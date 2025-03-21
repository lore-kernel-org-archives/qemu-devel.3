Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C82AC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvW8n-0005HM-Rx; Fri, 21 Mar 2025 02:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tvW8m-0005Gr-97
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tvW8j-0005zM-Mo
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742539556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLIwkhJ/RhNp/kN0PnetdBsu1oh8yfrVqUdKA7TaOAA=;
 b=ClxeK6eF9qqK5XLN9OfGNPgbsWCysZz2ChGdAqL2VoF7EGGeCniDDDsXm43eErnvmSuRMe
 dlUBSluV+jM9bNlcpr5Td6i+9izloOFKrXnz/VqhNc+FCiBO9yoibQi8eT+IDTDswCrx5w
 i6qMrHwCp2Loe5GfMGHEXPHdyg+oxlE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-X-e9n0MqNdGLrILmINvZ9g-1; Fri, 21 Mar 2025 02:45:54 -0400
X-MC-Unique: X-e9n0MqNdGLrILmINvZ9g-1
X-Mimecast-MFC-AGG-ID: X-e9n0MqNdGLrILmINvZ9g_1742539553
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac287f284f8so113592966b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 23:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742539553; x=1743144353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLIwkhJ/RhNp/kN0PnetdBsu1oh8yfrVqUdKA7TaOAA=;
 b=nJ0oBvLukp6p/3oo7H0dUzSzKHzHns0rpn7zYhVyyT6ZgtT2OyLWXmoorkjK6lCNK8
 kwvMITaiEE1Ja+MQ1b0gTcJ8sOXID39PNYzOMlAIANPd47Nt74bmOyaYbwG4mt7RHUrV
 jfbUVp/S3ddYZmirUgKO+Q3TQouR2pq54sYqdR1c5itF/t2wW3Td8G+GY6QDYvYvnmvc
 FLW4vkNPNy7JQQMqTMbmJ9kxA2fajcRwaL6/eQ7SACT9UsP37/eg3A9uZzGNTqIGHSu3
 UyASwr1xg1YEbzf6k5vl39n8c/0hpf32ivZ/I0DpwFUtVkjoWLfALoqp7GPfmqWoUQZ4
 TUzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAu3J6A65vf1SbBhVOKdac9shRlwkMY5sr7jMyofuJq3uGh+1PpCXHAHsWxlYw23p4hKW4VVhojwC/@nongnu.org
X-Gm-Message-State: AOJu0Yw9RNo72kE5o/JRuIoOc/BNDvYnD1+7bJUHQSw4Vgc8VeJeKl+6
 8NwtIfqSd/gtBGC/AjLcchn09uZz8JEWrQl8txlWnEYdNyfN6OhI5Pu7c4bcVBspzYohLNN8arT
 H7dblsxtVOd+zQYYM/tyHooCfIXFUpEPcXXoFZI3Cq8vRNdnBcNldCngIbYS9/j8sdct0QlFXGT
 222jm9ilHWYVDnnYwvyMQ5j0KD2cs=
X-Gm-Gg: ASbGnct0SHZpI2wZJOur/87RSHNHH/8oMU2Kp7sjBRRuDTPplfsdBGQEGeKPP9y3wNy
 EviIj7U4I7QNglow+gpVBC1AfG58rk/IEkMtcW8NOSNQY1aONegksNonXiqvfyShkpQp8RbFr7w
 ==
X-Received: by 2002:a05:6402:42c3:b0:5e5:e396:3f9a with SMTP id
 4fb4d7f45d1cf-5ebcd51befdmr1623040a12.31.1742539552517; 
 Thu, 20 Mar 2025 23:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMjt9ueqZx5q8MnMMcZ/4kDg5ys4RM6gYWmMWp1zogNo92LX1xpmwVYDEcIlNJlMMbrSG0QRPZJWNJt+gnNcg=
X-Received: by 2002:a05:6402:42c3:b0:5e5:e396:3f9a with SMTP id
 4fb4d7f45d1cf-5ebcd51befdmr1623011a12.31.1742539552064; Thu, 20 Mar 2025
 23:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
 <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
 <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
 <fbf1cda7-8be3-472e-afc0-1a1aabf8d7cd@oracle.com>
 <CAPpAL=w0hUxnDwNmrcqdpNokEwdpmOmO_DHA=7cGLX1+3k6H0g@mail.gmail.com>
 <hgrt7shqvqsv2am7x2e3tlzxarsyfbr43izz7cfiteb3gxeizs@fpb77yzhmthi>
In-Reply-To: <hgrt7shqvqsv2am7x2e3tlzxarsyfbr43izz7cfiteb3gxeizs@fpb77yzhmthi>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 21 Mar 2025 14:45:15 +0800
X-Gm-Features: AQ5f1Jrk71l74oZR-a_QGP2srL1BpU5PRqLwn1WkXG0B8lCiVGwX4al-CGokL1E
Message-ID: <CAPpAL=wNDwu49Hn5e6UNsyYOaZws92kd8GZy38_fvZt-gZ9e=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, 
 peterx@redhat.com, mst@redhat.com, jasowant@redhat.com, lvivier@redhat.com, 
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 20, 2025 at 11:48=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Hi Lei,
>
> On 03/20, Lei Yang wrote:
> > Hi Dragos, Si-Wei
> >
> > 1.  I applied [0] [1] [2] to the downstream kernel then tested
> > hotplug/unplug, this bug still exists.
> >
> > [0] 35025963326e ("vdpa/mlx5: Fix suboptimal range on iotlb iteration")
> > [1] 29ce8b8a4fa7 ("vdpa/mlx5: Fix PA offset with unaligned starting iot=
lb map")
> > [2] a6097e0a54a5 ("vdpa/mlx5: Fix oversized null mkey longer than 32bit=
")
> >
> > 2. Si-Wei mentioned two patches [1] [2] have been merged into qemu
> > master branch, so based on the test result it can not help fix this
> > bug.
> > [1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
> > [2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")
> >
> > 3. I found triggers for the unhealthy report from firmware step is
> > just boot up guest when using the current patches qemu. The host dmesg
> > will print  unhealthy info immediately after booting up the guest.
> >

Hi Dragos

> Did you set the locked memory to ulimite before (ulimit -l unlimited)?
> This could also be the cause for the FW issue.

Yes, I did it. I executed it (ulimit -l unlimited) before I boot up the gue=
st.

Thanks
Lei
>
> Thanks,
> Dragos
>
> > Thanks
> > Lei
> >
> >
> > On Wed, Mar 19, 2025 at 8:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> > >
> > > Hi Lei,
> > >
> > > On 3/18/2025 7:06 AM, Lei Yang wrote:
> > > > On Tue, Mar 18, 2025 at 10:15=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > >> On Tue, Mar 18, 2025 at 9:55=E2=80=AFAM Lei Yang <leiyang@redhat.c=
om> wrote:
> > > >>> Hi Jonah
> > > >>>
> > > >>> I tested this series with the vhost_vdpa device based on mellanox
> > > >>> ConnectX-6 DX nic and hit the host kernel crash. This problem can=
 be
> > > >>> easier to reproduce under the hotplug/unplug device scenario.
> > > >>> For the core dump messages please review the attachment.
> > > >>> FW version:
> > > >>> #  flint -d 0000:0d:00.0 q |grep Version
> > > >>> FW Version:            22.44.1036
> > > >>> Product Version:       22.44.1036
> > > >> The trace looks more like a mlx5e driver bug other than vDPA?
> > > >>
> > > >> [ 3256.256707] Call Trace:
> > > >> [ 3256.256708]  <IRQ>
> > > >> [ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
> > > >> [ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
> > > >> [ 3256.256715]  ? __build_skb+0x4a/0x60
> > > >> [ 3256.256719]  ? __die_body.cold+0x8/0xd
> > > >> [ 3256.256720]  ? die_addr+0x39/0x60
> > > >> [ 3256.256725]  ? exc_general_protection+0x1ec/0x420
> > > >> [ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
> > > >> [ 3256.256736]  ? __build_skb_around+0x8c/0xf0
> > > >> [ 3256.256738]  __build_skb+0x4a/0x60
> > > >> [ 3256.256740]  build_skb+0x11/0xa0
> > > >> [ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_=
core]
> > > >> [ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_cor=
e]
> > > >> [ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [ml=
x5_core]
> > > >> [ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
> > > >> [ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
> > > >> [ 3256.257226]  __napi_poll+0x29/0x170
> > > >> [ 3256.257229]  net_rx_action+0x29c/0x370
> > > >> [ 3256.257231]  handle_softirqs+0xce/0x270
> > > >> [ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
> > > >> [ 3256.257238]  common_interrupt+0x80/0xa0
> > > >>
> > > > Hi Jason
> > > >
> > > >> Which kernel tree did you use? Can you please try net.git?
> > > > I used the latest 9.6 downstream kernel and upstream qemu (applied
> > > > this series of patches) to test this scenario.
> > > > First based on my test result this bug is related to this series of
> > > > patches, the conclusions are based on the following test results(Al=
l
> > > > test results are based on the above mentioned nic driver):
> > > > Case 1: downstream kernel + downstream qemu-kvm  -  pass
> > > > Case 2: downstream kernel + upstream qemu (doesn't included this
> > > > series of patches)  -  pass
> > > > Case 3: downstream kernel + upstream qemu (included this series of
> > > > patches)  - failed, reproduce ratio 100%
> > > Just as Dragos replied earlier, the firmware was already in a bogus
> > > state before the panic that I also suspect it has something to do wit=
h
> > > various bugs in the downstream kernel. You have to apply the 3 patche=
s
> > > to the downstream kernel before you may kick of the relevant tests
> > > again. Please pay special attention to which specific command or step
> > > that triggers the unhealthy report from firmware, and let us know if =
you
> > > still run into any of them.
> > >
> > > In addition, as you seem to be testing the device hot plug and unplug
> > > use cases, for which the latest qemu should have related fixes
> > > below[1][2], but in case they are missed somehow it might also end up
> > > with bad firmware state to some extend. Just fyi.
> > >
> > > [1] db0d4017f9b9 ("net: parameterize the removing client from nc list=
")
> > > [2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")
> > >
> > > Thanks,
> > > -Siwei
> > > >
> > > > Then I also tried to test it with the net.git tree, but it will hit
> > > > the host kernel panic after compiling when rebooting the host. For =
the
> > > > call trace info please review following messages:
> > > > [    9.902851] No filesystem could mount root, tried:
> > > > [    9.902851]
> > > > [    9.909248] Kernel panic - not syncing: VFS: Unable to mount roo=
t
> > > > fs on "/dev/mapper/rhel_dell--per760--12-root" or unknown-block(0,0=
)
> > > > [    9.921335] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.=
14.0-rc6+ #3
> > > > [    9.928398] Hardware name: Dell Inc. PowerEdge R760/0NH8MJ, BIOS
> > > > 1.3.2 03/28/2023
> > > > [    9.935876] Call Trace:
> > > > [    9.938332]  <TASK>
> > > > [    9.940436]  panic+0x356/0x380
> > > > [    9.943513]  mount_root_generic+0x2e7/0x300
> > > > [    9.947717]  prepare_namespace+0x65/0x270
> > > > [    9.951731]  kernel_init_freeable+0x2e2/0x310
> > > > [    9.956105]  ? __pfx_kernel_init+0x10/0x10
> > > > [    9.960221]  kernel_init+0x16/0x1d0
> > > > [    9.963715]  ret_from_fork+0x2d/0x50
> > > > [    9.967303]  ? __pfx_kernel_init+0x10/0x10
> > > > [    9.971404]  ret_from_fork_asm+0x1a/0x30
> > > > [    9.975348]  </TASK>
> > > > [    9.977555] Kernel Offset: 0xc00000 from 0xffffffff81000000
> > > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > [   10.101881] ---[ end Kernel panic - not syncing: VFS: Unable to
> > > > mount root fs on "/dev/mapper/rhel_dell--per760--12-root" or
> > > > unknown-block(0,0) ]---
> > > >
> > > > # git log -1
> > > > commit 4003c9e78778e93188a09d6043a74f7154449d43 (HEAD -> main,
> > > > origin/main, origin/HEAD)
> > > > Merge: 8f7617f45009 2409fa66e29a
> > > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Date:   Thu Mar 13 07:58:48 2025 -1000
> > > >
> > > >      Merge tag 'net-6.14-rc7' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > > >
> > > >
> > > > Thanks
> > > >
> > > > Lei
> > > >> Thanks
> > > >>
> > > >>> Best Regards
> > > >>> Lei
> > > >>>
> > > >>> On Fri, Mar 14, 2025 at 9:04=E2=80=AFPM Jonah Palmer <jonah.palme=
r@oracle.com> wrote:
> > > >>>> Current memory operations like pinning may take a lot of time at=
 the
> > > >>>> destination.  Currently they are done after the source of the mi=
gration is
> > > >>>> stopped, and before the workload is resumed at the destination. =
 This is a
> > > >>>> period where neigher traffic can flow, nor the VM workload can c=
ontinue
> > > >>>> (downtime).
> > > >>>>
> > > >>>> We can do better as we know the memory layout of the guest RAM a=
t the
> > > >>>> destination from the moment that all devices are initializaed.  =
So
> > > >>>> moving that operation allows QEMU to communicate the kernel the =
maps
> > > >>>> while the workload is still running in the source, so Linux can =
start
> > > >>>> mapping them.
> > > >>>>
> > > >>>> As a small drawback, there is a time in the initialization where=
 QEMU
> > > >>>> cannot respond to QMP etc.  By some testing, this time is about
> > > >>>> 0.2seconds.  This may be further reduced (or increased) dependin=
g on the
> > > >>>> vdpa driver and the platform hardware, and it is dominated by th=
e cost
> > > >>>> of memory pinning.
> > > >>>>
> > > >>>> This matches the time that we move out of the called downtime wi=
ndow.
> > > >>>> The downtime is measured as checking the trace timestamp from th=
e moment
> > > >>>> the source suspend the device to the moment the destination star=
ts the
> > > >>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2=
.2526
> > > >>>> secs to 2.0949.
> > > >>>>
> > > >>>> Future directions on top of this series may include to move more=
 things ahead
> > > >>>> of the migration time, like set DRIVER_OK or perform actual iter=
ative migration
> > > >>>> of virtio-net devices.
> > > >>>>
> > > >>>> Comments are welcome.
> > > >>>>
> > > >>>> This series is a different approach of series [1]. As the title =
does not
> > > >>>> reflect the changes anymore, please refer to the previous one to=
 know the
> > > >>>> series history.
> > > >>>>
> > > >>>> This series is based on [2], it must be applied after it.
> > > >>>>
> > > >>>> [Jonah Palmer]
> > > >>>> This series was rebased after [3] was pulled in, as [3] was a pr=
erequisite
> > > >>>> fix for this series.
> > > >>>>
> > > >>>> v3:
> > > >>>> ---
> > > >>>> * Rebase
> > > >>>>
> > > >>>> v2:
> > > >>>> ---
> > > >>>> * Move the memory listener registration to vhost_vdpa_set_owner =
function.
> > > >>>> * Move the iova_tree allocation to net_vhost_vdpa_init.
> > > >>>>
> > > >>>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg0=
2136.html.
> > > >>>>
> > > >>>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/202312=
15172830.2540987-1-eperezma@redhat.com/
> > > >>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg059=
10.html
> > > >>>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-=
jonah.palmer@oracle.com/
> > > >>>>
> > > >>>> Eugenio P=C3=A9rez (7):
> > > >>>>    vdpa: check for iova tree initialized at net_client_start
> > > >>>>    vdpa: reorder vhost_vdpa_set_backend_cap
> > > >>>>    vdpa: set backend capabilities at vhost_vdpa_init
> > > >>>>    vdpa: add listener_registered
> > > >>>>    vdpa: reorder listener assignment
> > > >>>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > > >>>>    vdpa: move memory listener register to vhost_vdpa_init
> > > >>>>
> > > >>>>   hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++----=
--------
> > > >>>>   include/hw/virtio/vhost-vdpa.h | 22 +++++++-
> > > >>>>   net/vhost-vdpa.c               | 34 ++----------
> > > >>>>   3 files changed, 88 insertions(+), 66 deletions(-)
> > > >>>>
> > > >>>> --
> > > >>>> 2.43.5
> > > >>>>
> > > >>>>
> > >
> >
>


