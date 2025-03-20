Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A97C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHVI-0007Kv-EL; Thu, 20 Mar 2025 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tvHVC-0007Ke-U8
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tvHV9-0003y4-Ht
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742483284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Tn9Fzbm4QNcXGAfUsczmC8h8kpj174doaq7vJpqytM=;
 b=PpnTtMgP5TZ07J2AFCDRznG3BE8QPSNhCM1tJ0wnDu609260edCuTSikvD0KJ71qybXHPX
 HYdhQzrg1zaXzPRKW2Gu8aUJWyJgGyIj139uwmfeTtrDUDFXCDp3FD3PuhtS2E0mF0L5Rw
 MieoARBVCSPdfSov2j8OnoD9IWrOaf4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-0K2ISzW8N-eZAr5eHuohwA-1; Thu, 20 Mar 2025 11:08:02 -0400
X-MC-Unique: 0K2ISzW8N-eZAr5eHuohwA-1
X-Mimecast-MFC-AGG-ID: 0K2ISzW8N-eZAr5eHuohwA_1742483281
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e72c1bf151so897427a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742483281; x=1743088081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Tn9Fzbm4QNcXGAfUsczmC8h8kpj174doaq7vJpqytM=;
 b=LPF3+DsbTJS8pKeyl/rsIRR81dnoX8zgd6qKPf4XQI2pps+JEQoB2ICSmfwdXRxv8r
 HPwVIf0n6If6oN0hmRAHEGKVLNu6GBj0lKSq/zRWXOzBjfg1f9vmSMPhavs1WPBaFrqw
 Beup426j6A5JoCa7K9ORDFtCfuhyqmBch/gQB2738ariGX4vUB+pCG5Y4E10m4utRYZG
 E96t0fxujaUh0iZJ17evw+//YUKBccEK0k8TCRibd+tmNvVX6++mdzk3WlayNHb9H1Dw
 8VXq4k42bdRyQ+cjyHjzqIrUMKCBNHERJn6Axlnr6N7XJvlUrbatAEYMVCHao1vFGu90
 0eaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtn134o/bwkM9NpoTjzl/RZPjmz3+94Rkg3bYH4piSv3JsGMkPdVDq/49sofgT11YKq3s7qy7MOX6@nongnu.org
X-Gm-Message-State: AOJu0YxrbwTNblwAXUEhc9HYZ5waIYwmjbad1Wpek7XZr2WIXgkBEbCW
 1MppTVh50GzWHzGxu5L5iOOlarX3PgqkUsvlZnw7iRrMKZe+wOB309r+5U/PwYMid37xgNypmNT
 rSAm9AbmBVF1/kScx/naCrzdHeu3nkkapEEseQYKJoh1fHEz5LR8maUG79EGWrOzo4wqzbQIJZW
 DdwUsdTGRzpYB9PAe6zsgo5dnYcVk=
X-Gm-Gg: ASbGnctjdeaTDdeuZh1iKF0YcEu8N1RlSkEIAadk5xVUUFESKYWGp1qbR0otv1sKL3P
 Q7KSkF8jznL00ycfVxSO7YwmEqlJYCj9n0onAjfFaaMIWwlVbq5cF3cyzj7NzA3uJeX5KF7kv3A
 ==
X-Received: by 2002:a05:6402:270c:b0:5e5:bcd6:4ad8 with SMTP id
 4fb4d7f45d1cf-5eb80d0f29emr8329870a12.9.1742483280821; 
 Thu, 20 Mar 2025 08:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvCvWH4RKg38Zz8ktT6HuDg9TY9dDgkwKszcQCz5GZ7rssVH8pLlsUP4iV7U/FMGA84YHkf5kZglNVJLQ78Sw=
X-Received: by 2002:a05:6402:270c:b0:5e5:bcd6:4ad8 with SMTP id
 4fb4d7f45d1cf-5eb80d0f29emr8329781a12.9.1742483280118; Thu, 20 Mar 2025
 08:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
 <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
 <CAPpAL=zj-XgHO0VC46dHMZ0=nXegX3bMhC5UEN_8rAGRwPqXYw@mail.gmail.com>
 <fbf1cda7-8be3-472e-afc0-1a1aabf8d7cd@oracle.com>
In-Reply-To: <fbf1cda7-8be3-472e-afc0-1a1aabf8d7cd@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 20 Mar 2025 23:07:22 +0800
X-Gm-Features: AQ5f1JpIrl6rt1Irs2dFNnhzRlpl7Qpdr5ZDrg8klnLvrXsTiBnhbTifkD-1kNA
Message-ID: <CAPpAL=w0hUxnDwNmrcqdpNokEwdpmOmO_DHA=7cGLX1+3k6H0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>, dtatulea@nvidia.com
Cc: Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 qemu-devel@nongnu.org, 
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com, jasowant@redhat.com, 
 lvivier@redhat.com, leiyan@redhat.com, parav@mellanox.com, 
 sgarzare@redhat.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Dragos, Si-Wei

1.  I applied [0] [1] [2] to the downstream kernel then tested
hotplug/unplug, this bug still exists.

[0] 35025963326e ("vdpa/mlx5: Fix suboptimal range on iotlb iteration")
[1] 29ce8b8a4fa7 ("vdpa/mlx5: Fix PA offset with unaligned starting iotlb m=
ap")
[2] a6097e0a54a5 ("vdpa/mlx5: Fix oversized null mkey longer than 32bit")

2. Si-Wei mentioned two patches [1] [2] have been merged into qemu
master branch, so based on the test result it can not help fix this
bug.
[1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
[2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")

3. I found triggers for the unhealthy report from firmware step is
just boot up guest when using the current patches qemu. The host dmesg
will print  unhealthy info immediately after booting up the guest.

Thanks
Lei


On Wed, Mar 19, 2025 at 8:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Hi Lei,
>
> On 3/18/2025 7:06 AM, Lei Yang wrote:
> > On Tue, Mar 18, 2025 at 10:15=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >> On Tue, Mar 18, 2025 at 9:55=E2=80=AFAM Lei Yang <leiyang@redhat.com> =
wrote:
> >>> Hi Jonah
> >>>
> >>> I tested this series with the vhost_vdpa device based on mellanox
> >>> ConnectX-6 DX nic and hit the host kernel crash. This problem can be
> >>> easier to reproduce under the hotplug/unplug device scenario.
> >>> For the core dump messages please review the attachment.
> >>> FW version:
> >>> #  flint -d 0000:0d:00.0 q |grep Version
> >>> FW Version:            22.44.1036
> >>> Product Version:       22.44.1036
> >> The trace looks more like a mlx5e driver bug other than vDPA?
> >>
> >> [ 3256.256707] Call Trace:
> >> [ 3256.256708]  <IRQ>
> >> [ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
> >> [ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
> >> [ 3256.256715]  ? __build_skb+0x4a/0x60
> >> [ 3256.256719]  ? __die_body.cold+0x8/0xd
> >> [ 3256.256720]  ? die_addr+0x39/0x60
> >> [ 3256.256725]  ? exc_general_protection+0x1ec/0x420
> >> [ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
> >> [ 3256.256736]  ? __build_skb_around+0x8c/0xf0
> >> [ 3256.256738]  __build_skb+0x4a/0x60
> >> [ 3256.256740]  build_skb+0x11/0xa0
> >> [ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_core=
]
> >> [ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_core]
> >> [ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [mlx5_c=
ore]
> >> [ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
> >> [ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
> >> [ 3256.257226]  __napi_poll+0x29/0x170
> >> [ 3256.257229]  net_rx_action+0x29c/0x370
> >> [ 3256.257231]  handle_softirqs+0xce/0x270
> >> [ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
> >> [ 3256.257238]  common_interrupt+0x80/0xa0
> >>
> > Hi Jason
> >
> >> Which kernel tree did you use? Can you please try net.git?
> > I used the latest 9.6 downstream kernel and upstream qemu (applied
> > this series of patches) to test this scenario.
> > First based on my test result this bug is related to this series of
> > patches, the conclusions are based on the following test results(All
> > test results are based on the above mentioned nic driver):
> > Case 1: downstream kernel + downstream qemu-kvm  -  pass
> > Case 2: downstream kernel + upstream qemu (doesn't included this
> > series of patches)  -  pass
> > Case 3: downstream kernel + upstream qemu (included this series of
> > patches)  - failed, reproduce ratio 100%
> Just as Dragos replied earlier, the firmware was already in a bogus
> state before the panic that I also suspect it has something to do with
> various bugs in the downstream kernel. You have to apply the 3 patches
> to the downstream kernel before you may kick of the relevant tests
> again. Please pay special attention to which specific command or step
> that triggers the unhealthy report from firmware, and let us know if you
> still run into any of them.
>
> In addition, as you seem to be testing the device hot plug and unplug
> use cases, for which the latest qemu should have related fixes
> below[1][2], but in case they are missed somehow it might also end up
> with bad firmware state to some extend. Just fyi.
>
> [1] db0d4017f9b9 ("net: parameterize the removing client from nc list")
> [2] e7891c575fb2 ("net: move backend cleanup to NIC cleanup")
>
> Thanks,
> -Siwei
> >
> > Then I also tried to test it with the net.git tree, but it will hit
> > the host kernel panic after compiling when rebooting the host. For the
> > call trace info please review following messages:
> > [    9.902851] No filesystem could mount root, tried:
> > [    9.902851]
> > [    9.909248] Kernel panic - not syncing: VFS: Unable to mount root
> > fs on "/dev/mapper/rhel_dell--per760--12-root" or unknown-block(0,0)
> > [    9.921335] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0=
-rc6+ #3
> > [    9.928398] Hardware name: Dell Inc. PowerEdge R760/0NH8MJ, BIOS
> > 1.3.2 03/28/2023
> > [    9.935876] Call Trace:
> > [    9.938332]  <TASK>
> > [    9.940436]  panic+0x356/0x380
> > [    9.943513]  mount_root_generic+0x2e7/0x300
> > [    9.947717]  prepare_namespace+0x65/0x270
> > [    9.951731]  kernel_init_freeable+0x2e2/0x310
> > [    9.956105]  ? __pfx_kernel_init+0x10/0x10
> > [    9.960221]  kernel_init+0x16/0x1d0
> > [    9.963715]  ret_from_fork+0x2d/0x50
> > [    9.967303]  ? __pfx_kernel_init+0x10/0x10
> > [    9.971404]  ret_from_fork_asm+0x1a/0x30
> > [    9.975348]  </TASK>
> > [    9.977555] Kernel Offset: 0xc00000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [   10.101881] ---[ end Kernel panic - not syncing: VFS: Unable to
> > mount root fs on "/dev/mapper/rhel_dell--per760--12-root" or
> > unknown-block(0,0) ]---
> >
> > # git log -1
> > commit 4003c9e78778e93188a09d6043a74f7154449d43 (HEAD -> main,
> > origin/main, origin/HEAD)
> > Merge: 8f7617f45009 2409fa66e29a
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Mar 13 07:58:48 2025 -1000
> >
> >      Merge tag 'net-6.14-rc7' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> >
> >
> > Thanks
> >
> > Lei
> >> Thanks
> >>
> >>> Best Regards
> >>> Lei
> >>>
> >>> On Fri, Mar 14, 2025 at 9:04=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>> Current memory operations like pinning may take a lot of time at the
> >>>> destination.  Currently they are done after the source of the migrat=
ion is
> >>>> stopped, and before the workload is resumed at the destination.  Thi=
s is a
> >>>> period where neigher traffic can flow, nor the VM workload can conti=
nue
> >>>> (downtime).
> >>>>
> >>>> We can do better as we know the memory layout of the guest RAM at th=
e
> >>>> destination from the moment that all devices are initializaed.  So
> >>>> moving that operation allows QEMU to communicate the kernel the maps
> >>>> while the workload is still running in the source, so Linux can star=
t
> >>>> mapping them.
> >>>>
> >>>> As a small drawback, there is a time in the initialization where QEM=
U
> >>>> cannot respond to QMP etc.  By some testing, this time is about
> >>>> 0.2seconds.  This may be further reduced (or increased) depending on=
 the
> >>>> vdpa driver and the platform hardware, and it is dominated by the co=
st
> >>>> of memory pinning.
> >>>>
> >>>> This matches the time that we move out of the called downtime window=
.
> >>>> The downtime is measured as checking the trace timestamp from the mo=
ment
> >>>> the source suspend the device to the moment the destination starts t=
he
> >>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.252=
6
> >>>> secs to 2.0949.
> >>>>
> >>>> Future directions on top of this series may include to move more thi=
ngs ahead
> >>>> of the migration time, like set DRIVER_OK or perform actual iterativ=
e migration
> >>>> of virtio-net devices.
> >>>>
> >>>> Comments are welcome.
> >>>>
> >>>> This series is a different approach of series [1]. As the title does=
 not
> >>>> reflect the changes anymore, please refer to the previous one to kno=
w the
> >>>> series history.
> >>>>
> >>>> This series is based on [2], it must be applied after it.
> >>>>
> >>>> [Jonah Palmer]
> >>>> This series was rebased after [3] was pulled in, as [3] was a prereq=
uisite
> >>>> fix for this series.
> >>>>
> >>>> v3:
> >>>> ---
> >>>> * Rebase
> >>>>
> >>>> v2:
> >>>> ---
> >>>> * Move the memory listener registration to vhost_vdpa_set_owner func=
tion.
> >>>> * Move the iova_tree allocation to net_vhost_vdpa_init.
> >>>>
> >>>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136=
.html.
> >>>>
> >>>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/2023121517=
2830.2540987-1-eperezma@redhat.com/
> >>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.h=
tml
> >>>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jona=
h.palmer@oracle.com/
> >>>>
> >>>> Eugenio P=C3=A9rez (7):
> >>>>    vdpa: check for iova tree initialized at net_client_start
> >>>>    vdpa: reorder vhost_vdpa_set_backend_cap
> >>>>    vdpa: set backend capabilities at vhost_vdpa_init
> >>>>    vdpa: add listener_registered
> >>>>    vdpa: reorder listener assignment
> >>>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
> >>>>    vdpa: move memory listener register to vhost_vdpa_init
> >>>>
> >>>>   hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++--------=
----
> >>>>   include/hw/virtio/vhost-vdpa.h | 22 +++++++-
> >>>>   net/vhost-vdpa.c               | 34 ++----------
> >>>>   3 files changed, 88 insertions(+), 66 deletions(-)
> >>>>
> >>>> --
> >>>> 2.43.5
> >>>>
> >>>>
>


