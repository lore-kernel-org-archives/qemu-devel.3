Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F318C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 02:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuMU4-0001Pw-VQ; Mon, 17 Mar 2025 22:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tuMU1-0001Ow-GV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 22:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tuMTz-000219-4B
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 22:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742264104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6eyyp7sbfv8sA1WSc+sRiZXx7MwTcMnUviQWgAmN1Y=;
 b=EjNR6QamVQeyXN0Fjuecq2UKxSYcI5LLXVYqK5/s3py8l4ueYkBdieDO/QHswgQdVhdohD
 66vytgLcfelE9U4bK8BzcQp245+p70unIo/RvVGt+RkGDyL7y0Orb0J2oqUtxXX2shd6hv
 +7yf9Wa8ELriGL8BquVJcmtWwdMRjM0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-4AdJjK7COeWSJ4X1rEz3tw-1; Mon, 17 Mar 2025 22:15:01 -0400
X-MC-Unique: 4AdJjK7COeWSJ4X1rEz3tw-1
X-Mimecast-MFC-AGG-ID: 4AdJjK7COeWSJ4X1rEz3tw_1742264100
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff854a2541so4244135a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 19:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742264100; x=1742868900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6eyyp7sbfv8sA1WSc+sRiZXx7MwTcMnUviQWgAmN1Y=;
 b=V2CVDVbqxBhRfQNT9tlIxPTjKx9g+uUsACu0ZqnqcNEfwzomalElOLfTwwpJgmqacY
 K65uLGeEQ5ntZG6lBhBNGLzokm5TUPD7OpUOH2kkKEBFObz877+a8PsdkcINh24w/z51
 xZ+m+vKzhlNgiPt1cj1fTI700SobBTxc23+ZUcAr7dfvrSvx40pMiMzK4GzKHK5r2dIQ
 QfBHNoNc0Qnc+xiwM2aWS5m9H4r6yqHrqll4tbzBWPWfkzMEI+TdGzUbflDbwmmxPFjU
 hERgueeL/V3hs9MoX7Giy0FQktWmMkEguXrYT2rx9LXJ3S2ZVOMealiLvGpBJe4R54AV
 2UpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUV82+TkiCQKcF6uCjh3JWl7r/eQ/0NtOY5EHNstj3JccLvFx5N/LHUvYSZdPINe0A9rSgpweB+5aC@nongnu.org
X-Gm-Message-State: AOJu0YzO402dALjAet21Xpm485BR0MK6W+ghNfEpPy330V+afVWBU9eL
 MiHp5k642TqfaoC0nM/hhwg4Y/xbNas+0j7EI4JSP9Kn9GtsxmVa00sd/sY7twP2oxzPlTqdmcb
 Vua0glIeWKiPcrfMeASguO3E9I1x+jMY2gQgByCWMcmMcyeL2xMx3JM8Oof+zu73ciYZFaF2iAC
 eKNaPDJAjSoG8yRporUuxXJpASpEs=
X-Gm-Gg: ASbGncsNYz8t/KekQ6PLtUwjpvzk43EWclcQlJM0jorCeNR47ZSH10wdD/OatecYCwg
 lDtncBcoy3cs8tHSUQ5+YHtZR1l8NuzBVpAakuSNP2dwXSSHa4UYqhfuFV11f1kCFckXkVg==
X-Received: by 2002:a17:90b:3c91:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-301a5b028b4mr780240a91.3.1742264099781; 
 Mon, 17 Mar 2025 19:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw0sYGuMaTgraPO9vkp1wadjThCbvmDM0s7s+X/gV4kXmBGQZBwd3UNMYxmP9S6BhZEAZJwwZcCtdIK7NGFAo=
X-Received: by 2002:a17:90b:3c91:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-301a5b028b4mr780204a91.3.1742264099371; Mon, 17 Mar 2025
 19:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
 <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
In-Reply-To: <CAPpAL=wMpNHMjGJuZQTVxDkdH_tCKP18OzdrUZpXL_N2e=JJ=A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 10:14:47 +0800
X-Gm-Features: AQ5f1JovMR7UZie8cddoG_HApy_KLAyrp_ezhBcwVZzKwgd0Z2QWRzePgsBRpBg
Message-ID: <CACGkMEu6pNCJsd0BFcC4B0W68yMvaA3K-mv0KxTqbVdfS7-x8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Move memory listener register to vhost_vdpa_init
To: Lei Yang <leiyang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, 
 peterx@redhat.com, mst@redhat.com, jasowant@redhat.com, lvivier@redhat.com, 
 dtatulea@nvidia.com, leiyan@redhat.com, parav@mellanox.com, 
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com, 
 boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 18, 2025 at 9:55=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Jonah
>
> I tested this series with the vhost_vdpa device based on mellanox
> ConnectX-6 DX nic and hit the host kernel crash. This problem can be
> easier to reproduce under the hotplug/unplug device scenario.
> For the core dump messages please review the attachment.
> FW version:
> #  flint -d 0000:0d:00.0 q |grep Version
> FW Version:            22.44.1036
> Product Version:       22.44.1036

The trace looks more like a mlx5e driver bug other than vDPA?

[ 3256.256707] Call Trace:
[ 3256.256708]  <IRQ>
[ 3256.256709]  ? show_trace_log_lvl+0x1c4/0x2df
[ 3256.256714]  ? show_trace_log_lvl+0x1c4/0x2df
[ 3256.256715]  ? __build_skb+0x4a/0x60
[ 3256.256719]  ? __die_body.cold+0x8/0xd
[ 3256.256720]  ? die_addr+0x39/0x60
[ 3256.256725]  ? exc_general_protection+0x1ec/0x420
[ 3256.256729]  ? asm_exc_general_protection+0x22/0x30
[ 3256.256736]  ? __build_skb_around+0x8c/0xf0
[ 3256.256738]  __build_skb+0x4a/0x60
[ 3256.256740]  build_skb+0x11/0xa0
[ 3256.256743]  mlx5e_skb_from_cqe_mpwrq_linear+0x156/0x280 [mlx5_core]
[ 3256.256872]  mlx5e_handle_rx_cqe_mpwrq_rep+0xcb/0x1e0 [mlx5_core]
[ 3256.256964]  mlx5e_rx_cq_process_basic_cqe_comp+0x39f/0x3c0 [mlx5_core]
[ 3256.257053]  mlx5e_poll_rx_cq+0x3a/0xc0 [mlx5_core]
[ 3256.257139]  mlx5e_napi_poll+0xe2/0x710 [mlx5_core]
[ 3256.257226]  __napi_poll+0x29/0x170
[ 3256.257229]  net_rx_action+0x29c/0x370
[ 3256.257231]  handle_softirqs+0xce/0x270
[ 3256.257236]  __irq_exit_rcu+0xa3/0xc0
[ 3256.257238]  common_interrupt+0x80/0xa0

Which kernel tree did you use? Can you please try net.git?

Thanks

>
> Best Regards
> Lei
>
> On Fri, Mar 14, 2025 at 9:04=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle=
.com> wrote:
> >
> > Current memory operations like pinning may take a lot of time at the
> > destination.  Currently they are done after the source of the migration=
 is
> > stopped, and before the workload is resumed at the destination.  This i=
s a
> > period where neigher traffic can flow, nor the VM workload can continue
> > (downtime).
> >
> > We can do better as we know the memory layout of the guest RAM at the
> > destination from the moment that all devices are initializaed.  So
> > moving that operation allows QEMU to communicate the kernel the maps
> > while the workload is still running in the source, so Linux can start
> > mapping them.
> >
> > As a small drawback, there is a time in the initialization where QEMU
> > cannot respond to QMP etc.  By some testing, this time is about
> > 0.2seconds.  This may be further reduced (or increased) depending on th=
e
> > vdpa driver and the platform hardware, and it is dominated by the cost
> > of memory pinning.
> >
> > This matches the time that we move out of the called downtime window.
> > The downtime is measured as checking the trace timestamp from the momen=
t
> > the source suspend the device to the moment the destination starts the
> > eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> > secs to 2.0949.
> >
> > Future directions on top of this series may include to move more things=
 ahead
> > of the migration time, like set DRIVER_OK or perform actual iterative m=
igration
> > of virtio-net devices.
> >
> > Comments are welcome.
> >
> > This series is a different approach of series [1]. As the title does no=
t
> > reflect the changes anymore, please refer to the previous one to know t=
he
> > series history.
> >
> > This series is based on [2], it must be applied after it.
> >
> > [Jonah Palmer]
> > This series was rebased after [3] was pulled in, as [3] was a prerequis=
ite
> > fix for this series.
> >
> > v3:
> > ---
> > * Rebase
> >
> > v2:
> > ---
> > * Move the memory listener registration to vhost_vdpa_set_owner functio=
n.
> > * Move the iova_tree allocation to net_vhost_vdpa_init.
> >
> > v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.ht=
ml.
> >
> > [1] https://patchwork.kernel.org/project/qemu-devel/cover/2023121517283=
0.2540987-1-eperezma@redhat.com/
> > [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> > [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.p=
almer@oracle.com/
> >
> > Eugenio P=C3=A9rez (7):
> >   vdpa: check for iova tree initialized at net_client_start
> >   vdpa: reorder vhost_vdpa_set_backend_cap
> >   vdpa: set backend capabilities at vhost_vdpa_init
> >   vdpa: add listener_registered
> >   vdpa: reorder listener assignment
> >   vdpa: move iova_tree allocation to net_vhost_vdpa_init
> >   vdpa: move memory listener register to vhost_vdpa_init
> >
> >  hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++------------
> >  include/hw/virtio/vhost-vdpa.h | 22 +++++++-
> >  net/vhost-vdpa.c               | 34 ++----------
> >  3 files changed, 88 insertions(+), 66 deletions(-)
> >
> > --
> > 2.43.5
> >
> >


