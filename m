Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C06AC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4x59-0001mh-JC; Wed, 16 Apr 2025 03:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1u4x51-0001lo-8q
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 03:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1u4x4u-0002be-4G
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 03:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744788057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1iGn7MFW8UnwFCTCQtZBFEgBpfm7ypTXWC8OO/lnMA=;
 b=O6CotArbSWX5onfMIUZelqvb0X2ap2yg7Lhf3VsVWCSx8SvllH8eq7G2/5CAk0AL8suxvY
 lBvhNObkHtn+B3tlGb1wyokEttAgYjhegRjT46dQDtGWoOqeXPFWbik8O5vUiXBcunb++d
 b5eEyNGoPzA8TCWzYldzfQnO06g0Y5E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-DyomU7PrO8W6LlFFUGwFaA-1; Wed, 16 Apr 2025 03:20:56 -0400
X-MC-Unique: DyomU7PrO8W6LlFFUGwFaA-1
X-Mimecast-MFC-AGG-ID: DyomU7PrO8W6LlFFUGwFaA_1744788055
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff7aecba07so6305831a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 00:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744788055; x=1745392855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1iGn7MFW8UnwFCTCQtZBFEgBpfm7ypTXWC8OO/lnMA=;
 b=KoYibOMN7an1vlax9pDvpwbH7pHuQ+r+Dg64uMDORSnaNIyb+HEveFzOR8FvkIeObf
 kkjVUPSilZuQ3nhvdL238tvkSqO0bIlqIqNr6vLYp2+9YTcYCX850G/coRhPIYghdWFp
 uMcJ6Jz7Nt6AROuAmHfFgGdWT9eOLKQ76+hvhTfXu5TW/DlS1ZlgVEjbuK2bbwgS0K7b
 2gj99/DWEDob2pwQcJM6boXNWkMVphQyHS8Vqn50H2yaSfmjAjNKGPW7od/D+XbYmW7a
 MwSRVLrcWdo/FXtBy5N6Tu/WsZB8PcdgDXd4quYCDjYiosJMV2KQYVBl1RmkFq3nvkkN
 1zXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+iecudQ6smovT6YVEqxHS3tv/lCg/485rQRtzvKz2ZZcq3+6FU1UZsDPYyMv5nMfyTqnd7Oj7oTJ@nongnu.org
X-Gm-Message-State: AOJu0YyUTSJjtN9v2dHuixwbD1jmcLygJ55MlGM3AYsUkYZNoBfz4Rbb
 y2ZPGASFTO4mTPxc1lBarztzIs/81A/Zo4b3ImZmD99lp1C43lhjuxaYkOZdYzDBPzYjuzsCrGN
 UMAH7qGyl2S0qimA6mw7Kc3YntqVhwVz1AFOE72Bwt0K7qz2v4wcmpMxqD659EFdb53FYNl8uTe
 d7Jq5ozL2jyTlJu2PTdQB1Nnpv7G4=
X-Gm-Gg: ASbGncu1Y2PkcdI/NzOEDvAH2a1Jk2Rpsqrid105OK0NZ2WmVp4aea4Tp5P/ZvMiVHv
 EQIvSqpU7Wr/9GIr+WvLVkp24m/xkgSrRL4+3kbwixv+PDji6NoRKaAr4pA4y/axUNo8=
X-Received: by 2002:a17:90b:2d10:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30863f18c46mr1338900a91.12.1744788054691; 
 Wed, 16 Apr 2025 00:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvyAj9KcDW74laK3lXqMgnVo1Yn+o/Taham0vdXpVGrcUugGHzK0RSeUAERRXrnJVqGCdab7w9E6GGN8xTjjs=
X-Received: by 2002:a17:90b:2d10:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30863f18c46mr1338843a91.12.1744788054202; Wed, 16 Apr 2025
 00:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
In-Reply-To: <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 16 Apr 2025 09:20:17 +0200
X-Gm-Features: ATxdqUHF4kGjAsRrknR9DidAu8ShduZi1VEo8HTwYRGLHgsf-EU9PYfcrQM5ty8
Message-ID: <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 14, 2025 at 11:20=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> Hi,
>
> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 2:59=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> I managed to fix a few issues while testing this patch series.
> >> There is still one issue that I am unable to resolve. I thought
> >> I would send this patch series for review in case I have missed
> >> something.
> >>
> >> The issue is that this patch series does not work every time. I
> >> am able to ping L0 from L2 and vice versa via packed SVQ when it
> >> works.
> >
> > So we're on a very good track then!
> >
> >> When this doesn't work, both VMs throw a "Destination Host
> >> Unreachable" error. This is sometimes (not always) accompanied
> >> by the following kernel error (thrown by L2-kernel):
> >>
> >> virtio_net virtio1: output.0:id 1 is not a head!
> >>
> >
> > How many packets have been sent or received before hitting this? If
> > the answer to that is "the vq size", maybe there is a bug in the code
> > that handles the wraparound of the packed vq, as the used and avail
> > flags need to be twisted. You can count them in the SVQ code.
>
> I did a lot more testing. This issue is quite unpredictable in terms
> of the time at which it appears after booting L2. So far, it almost
> always appears after booting L2. Even when pinging works, this issue
> appears after several seconds of pinging.
>

Maybe you can speed it up with ping -f?

> The total number of svq descriptors varied in every test run. But in
> every case, all 256 indices were filled in the descriptor region for
> vq with vq_idx =3D 0. This is the RX vq, right?

Right!

> This was filled while L2
> was booting. In the case when the ctrl vq is disabled, I am not sure
> what is responsible for filling the vqs in the data plane during
> booting.
>

The nested guest's driver fills the rx queue at startup. After that,
that nested guest kicks and SVQ receives the descriptors. It copies
the descriptors to the shadow virtqueue and then kicks L0 QEMU.

> =3D=3D=3D=3D=3D
> The issue is hit most frequently when the following command is run
> in L0:
> $ ip addr add 111.1.1.1/24 dev tap0
> $ ip link set tap0 up
>
> or, running the following in L2:
> # ip addr add 111.1.1.2/24 dev eth0
>

I guess those are able to start the network, aren't they?

> The other vq (vq_idx=3D1) is not filled completely before the issue is
> hit.
> I have been noting down the numbers and here is an example:
>
> 295 descriptors were added individually to the queues i.e., there were no=
 chains (vhost_svq_add_packed)
> |_ 256 additions in vq_idx =3D 0, all with unique ids
>      |---- 27 descriptors (ids 0 through 26) were received later from the=
 device (vhost_svq_get_buf_packed)
> |_ 39 additions in vq_idx =3D 1
>      |_ 13 descriptors had id =3D 0
>      |_ 26 descriptors had id =3D 1
>      |---- All descriptors were received at some point from the device (v=
host_svq_get_buf_packed)
>
> There was one case in which vq_idx=3D0 had wrapped around. I verified
> that flags were set appropriately during the wrap (avail and used flags
> were flipped as expected).
>

Ok sounds like you're able to reach it before filling the queue. I'd
go for debugging notifications for this one then. More on this below.

> =3D=3D=3D=3D=3D
> The next common situation where this issue is hit is during startup.
> Before L2 can finish booting successfully, this error is thrown:
>
> virtio_net virtio1: output.0:id 0 is not a head!
>
> 258 descriptors were added individually to the queues during startup (the=
re were no chains) (vhost_svq_add_packed)
> |_ 256 additions in vq_idx =3D 0, all with unique ids
>     |---- None of them were received by the device (vhost_svq_get_buf_pac=
ked)
> |_ 2 additions in vq_idx =3D 1
>     |_ id =3D 0 in index 0
>     |_ id =3D 1 in index 1
>     |---- Both descriptors were received at some point during startup fro=
m the device (vhost_svq_get_buf_packed)
>
> =3D=3D=3D=3D=3D
> Another case is after several seconds of pinging L0 from L2.
>
> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
>

So the L2 guest sees a descriptor it has not made available
previously. This can be caused because SVQ returns the same descriptor
twice, or it doesn't fill the id or flags properly. It can also be
caused because we're not protecting the write ordering in the ring,
but I don't see anything obviously wrong by looking at the code.

> 366 descriptors were added individually to the queues i.e., there were no=
 chains (vhost_svq_add_packed)
> |_ 289 additions in vq_idx =3D 0, wrap-around was observed with avail and=
 used flags inverted for 33 descriptors
> |   |---- 40 descriptors (ids 0 through 39) were received from the device=
 (vhost_svq_get_buf_packed)
> |_ 77 additions in vq_idx =3D 1
>      |_ 76 descriptors had id =3D 0
>      |_ 1 descriptor had id =3D 1
>      |---- all 77 descriptors were received at some point from the device=
 (vhost_svq_get_buf_packed)
>
> I am not entirely sure now if there's an issue in the packed vq
> implementation in QEMU or if this is being caused due to some sort
> of race condition in linux.
>
> "id is not a head" is being thrown because vq->packed.desc_state[id].data
> doesn't exist for the corresponding id in Linux [1]. But QEMU seems to ha=
ve
> stored some data for this id via vhost_svq_add() [2]. Linux sets the valu=
e
> of vq->packed.desc_state[id].data in its version of virtqueue_add_packed(=
) [3].
>

Let's keep debugging further. Can you trace the ids that the L2 kernel
makes available, and then the ones that it uses? At the same time, can
you trace the ids that the svq sees in vhost_svq_get_buf and the ones
that flushes? This allows us to check the set of available descriptors
at any given time.

> >> This error is not thrown always, but when it is thrown, the id
> >> varies. This is invariably followed by a soft lockup:
> >> [...]
> >> [  284.662292] Call Trace:
> >> [  284.662292]  <IRQ>
> >> [  284.662292]  ? watchdog_timer_fn+0x1e6/0x270
> >> [  284.662292]  ? __pfx_watchdog_timer_fn+0x10/0x10
> >> [  284.662292]  ? __hrtimer_run_queues+0x10f/0x2b0
> >> [  284.662292]  ? hrtimer_interrupt+0xf8/0x230
> >> [  284.662292]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
> >> [  284.662292]  ? sysvec_apic_timer_interrupt+0x39/0x90
> >> [  284.662292]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >> [  284.662292]  ? virtqueue_enable_cb_delayed+0x115/0x150
> >> [  284.662292]  start_xmit+0x2a6/0x4f0 [virtio_net]
> >> [  284.662292]  ? netif_skb_features+0x98/0x300
> >> [  284.662292]  dev_hard_start_xmit+0x61/0x1d0
> >> [  284.662292]  sch_direct_xmit+0xa4/0x390
> >> [  284.662292]  __dev_queue_xmit+0x84f/0xdc0
> >> [  284.662292]  ? nf_hook_slow+0x42/0xf0
> >> [  284.662292]  ip_finish_output2+0x2b8/0x580
> >> [  284.662292]  igmp_ifc_timer_expire+0x1d5/0x430
> >> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
> >> [  284.662292]  call_timer_fn+0x21/0x130
> >> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
> >> [  284.662292]  __run_timers+0x21f/0x2b0
> >> [  284.662292]  run_timer_softirq+0x1d/0x40
> >> [  284.662292]  __do_softirq+0xc9/0x2c8
> >> [  284.662292]  __irq_exit_rcu+0xa6/0xc0
> >> [  284.662292]  sysvec_apic_timer_interrupt+0x72/0x90
> >> [  284.662292]  </IRQ>
> >> [  284.662292]  <TASK>
> >> [  284.662292]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >> [  284.662292] RIP: 0010:pv_native_safe_halt+0xf/0x20
> >> [  284.662292] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 53 75 3f 00 fb f=
4 <c3> cc c0
> >> [  284.662292] RSP: 0018:ffffb8f0000b3ed8 EFLAGS: 00000212
> >> [  284.662292] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000=
0000000000
> >> [  284.662292] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 000000=
00000289ec
> >> [  284.662292] RBP: ffff96f200810000 R08: 0000000000000000 R09: 000000=
0000000001
> >> [  284.662292] R10: 0000000000000001 R11: 0000000000000000 R12: 000000=
0000000000
> >> [  284.662292] R13: 0000000000000000 R14: ffff96f200810000 R15: 000000=
0000000000
> >> [  284.662292]  default_idle+0x9/0x20
> >> [  284.662292]  default_idle_call+0x2c/0xe0
> >> [  284.662292]  do_idle+0x226/0x270
> >> [  284.662292]  cpu_startup_entry+0x2a/0x30
> >> [  284.662292]  start_secondary+0x11e/0x140
> >> [  284.662292]  secondary_startup_64_no_verify+0x184/0x18b
> >> [  284.662292]  </TASK>
> >>
> >> The soft lockup seems to happen in
> >> drivers/net/virtio_net.c:start_xmit() [1].
> >>
> >
> > Maybe it gets stuck in the do {} while(...
> > !virtqueue_enable_cb_delayed()) ? you can add a printk in
> > virtqueue_enable_cb_delayed return and check if it matches with the
> > speed you're sending or receiving ping. For example, if ping is each
> > second, you should not see a lot of traces.
> >
> > If this does not work I'd try never disabling notifications, both in
> > the kernel and SVQ, and check if that works.
>
> In order to disable notifications, will something have to be commented
> out in the implementation?
>

To *never* disable notifications you should comment out the SVQ calls
to virtio_queue_set_notification and vhost_svq_disable_notification.
This way the other side (L0 device in QEMU and the guest) are forced
to notify SVQ always, and we can check if that solves the first issue,

> >> [...]
> >> QEMU command to boot L1:
> >>
> >> $ sudo ./qemu/build/qemu-system-x86_64 \
> >> -enable-kvm \
> >> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3D=
disk,if=3Dvirtio \
> >> -net nic,model=3Dvirtio \
> >> -net user,hostfwd=3Dtcp::2222-:22 \
> >> -device intel-iommu,snoop-control=3Don \
> >> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-moder=
n=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Dof=
f,guest_announce=3Doff,mq=3Doff,ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff=
,ctrl_mac_addr=3Doff,packed=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno,vhost=3Doff \
> >> -nographic \
> >> -m 8G \
> >> -smp 4 \
> >> -M q35 \
> >> -cpu host 2>&1 | tee vm.log
> >>
>
> I have added "-device virtio-net-pci,indirect_desc=3Doff,queue_reset=3Dof=
f"
> to the L0 QEMU command to boot L1.
>
> Thanks,
> Sahil
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1762
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L290
> [3] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1564
>


