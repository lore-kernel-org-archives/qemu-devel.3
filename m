Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC5E77181
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 09:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKwXY-0002ty-91; Tue, 10 Dec 2024 04:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKwXQ-0002tE-BM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKwXN-0007jQ-U4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733822892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0eI1ZEXllrpc/FY0FhBYzyH8YCe1+DojHVcjAOp5qc=;
 b=TWuI4JcR6r+5WoKqs50gDu2NKqbBcp8UZ8tLh1fQrsJSvZ9QmSZU4RVwROKBjYn2B1ji46
 QDNRWkzzXvcOtGxotihcOmfsQVT0jbtL+ao45rBPibvuel39EJK5XtD8mDjtXy/GJvAqWS
 aEB+vWNxqFl0Tkw4jDNsJkbzlgR5WgY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GmsgJtewPvqS8m_Bx38RGA-1; Tue, 10 Dec 2024 04:28:10 -0500
X-MC-Unique: GmsgJtewPvqS8m_Bx38RGA-1
X-Mimecast-MFC-AGG-ID: GmsgJtewPvqS8m_Bx38RGA
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6ef88388aaaso61570907b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 01:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733822890; x=1734427690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0eI1ZEXllrpc/FY0FhBYzyH8YCe1+DojHVcjAOp5qc=;
 b=Dcn6GTZoraucYWqRwjs2vQ+epfYgHq2ABwzZxDAqAvr3keWju2yZwkl5HT0C8xBTMc
 QOCXCOaEB+pvK/xtqHOO3jUfzuaq6fNdP8E+Fj0wIzNSLQgAW7CLpEXHjqNjx9PULkZY
 GE5an2Pqr8iTIz1FGfBaVXSXAfOaQvs5bF4iQLQ+4kIbdNcBrt6v7v7A9IXyaZVCHRzq
 2vKaEaTzQQMp4wC4pYdeMmoSyuVr5+R+WhERVaWNG0R1665BhZSGeYDIf5JsslxIUMay
 jbLBudEwPgn3iZw+DxHiEOTTm0oSDzb+Pe8TVK3R/PDQlW4t/EeR/N35nyziMY5BhYE2
 IwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3FjsYNZ63TEirjr1wJKLGCYg+V2PJwgt7iCIoIvUbb1h5oyinfKS2weSIogFxCovhgRyK6XldLvL@nongnu.org
X-Gm-Message-State: AOJu0YzQlpv1hBaZhOh0kSYy0Kn8Kax78UYD10d/WT3O9vwRUsdgR8fT
 LpVSJD/5B85Rs+QqptK4wAqlCYugtHpnsAWjGgKrJ8qLrpYnczOARYd2y10EbH3oXnWcotPtA8s
 aS8XceUx8inG/zg+kVfrWtamWeZzM2k1q9c71T3cjh41f2IFE2W5TlEFSTh99LfpKHDJCxMN+t8
 DnwT9PB0Ks9cuD9VP09o627SmaX1M=
X-Gm-Gg: ASbGncuitM+SjxWUyZvky+c9D0ujKpxDEEKPftC+/MNhpTi1kHEp2641MH40C1eUJZd
 c7ZbFMbHr0rw/BLBj8JPzwY4I4BltNEub0r8=
X-Received: by 2002:a05:690c:62c2:b0:6ef:9dbe:9f82 with SMTP id
 00721157ae682-6f022f74f6dmr43952537b3.29.1733822890280; 
 Tue, 10 Dec 2024 01:28:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWSCol/oT2x9olJlqNaSMIqSlUFVXMVbqHet3+Y1PECZt7VpoguM9pwBL6/1O3yLu6MsYQjna5NC2CNmouEaM=
X-Received: by 2002:a05:690c:62c2:b0:6ef:9dbe:9f82 with SMTP id
 00721157ae682-6f022f74f6dmr43952437b3.29.1733822889907; Tue, 10 Dec 2024
 01:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Dec 2024 10:27:33 +0100
Message-ID: <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

On Thu, Dec 5, 2024 at 9:34=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Hi,
>
> There are two issues that I found while trying to test
> my changes. I thought I would send the patch series
> as well in case that helps in troubleshooting. I haven't
> been able to find an issue in the implementation yet.
> Maybe I am missing something.
>
> I have been following the "Hands on vDPA: what do you do
> when you ain't got the hardware v2 (Part 2)" [1] blog to
> test my changes. To boot the L1 VM, I ran:
>
> sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff=
,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Don,event_idx=3Doff=
,bus=3Dpcie.0,addr=3D0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> -nographic \
> -m 8G \
> -smp 4 \
> -M q35 \
> -cpu host 2>&1 | tee vm.log
>
> Without "guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,
> guest_announce=3Doff" in "-device virtio-net-pci", QEMU
> throws "vdpa svq does not work with features" [2] when
> trying to boot L2.
>
> The enums added in commit #2 in this series is new and
> wasn't in the earlier versions of the series. Without
> this change, x-svq=3Dtrue throws "SVQ invalid device feature
> flags" [3] and x-svq is consequently disabled.
>
> The first issue is related to running traffic in L2
> with vhost-vdpa.
>
> In L0:
>
> $ ip addr add 111.1.1.1/24 dev tap0
> $ ip link set tap0 up
> $ ip addr show tap0
> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state =
UNKNOWN group default qlen 1000
>     link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
>     inet 111.1.1.1/24 scope global tap0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
>
> I am able to run traffic in L2 when booting without
> x-svq.
>
> In L1:
>
> $ ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=3D0=
x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> In L2:
>
> # ip addr add 111.1.1.2/24 dev eth0
> # ip addr show eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state =
UP group default qlen 1000
>     link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>     altname enp0s7
>     inet 111.1.1.2/24 scope global eth0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>        valid_lft forever preferred_lft forever
>
> # ip route
> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>
> # ping 111.1.1.1 -w3
> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> 64 bytes from 111.1.1.1: icmp_seq=3D1 ttl=3D64 time=3D0.407 ms
> 64 bytes from 111.1.1.1: icmp_seq=3D2 ttl=3D64 time=3D0.671 ms
> 64 bytes from 111.1.1.1: icmp_seq=3D3 ttl=3D64 time=3D0.291 ms
>
> --- 111.1.1.1 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
> rtt min/avg/max/mdev =3D 0.291/0.456/0.671/0.159 ms
>
>
> But if I boot L2 with x-svq=3Dtrue as shown below, I am unable
> to ping the host machine.
>
> $ ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,id=3D=
vhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=3D0=
x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> In L2:
>
> # ip addr add 111.1.1.2/24 dev eth0
> # ip addr show eth0
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state =
UP group default qlen 1000
>     link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>     altname enp0s7
>     inet 111.1.1.2/24 scope global eth0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>        valid_lft forever preferred_lft forever
>
> # ip route
> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>
> # ping 111.1.1.1 -w10
> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> From 111.1.1.2 icmp_seq=3D1 Destination Host Unreachable
> ping: sendmsg: No route to host
> From 111.1.1.2 icmp_seq=3D2 Destination Host Unreachable
> From 111.1.1.2 icmp_seq=3D3 Destination Host Unreachable
>
> --- 111.1.1.1 ping statistics ---
> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2076=
ms
> pipe 3
>
> The other issue is related to booting L2 with "x-svq=3Dtrue"
> and "packed=3Don".
>
> In L1:
>
> $ ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,x=
-svq=3Dtrue \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,guest_announce=
=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,a=
ddr=3D0x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> The kernel throws "virtio_net virtio1: output.0:id 0 is not
> a head!" [4].
>

So this series implements the descriptor forwarding from the guest to
the device in packed vq. We also need to forward the descriptors from
the device to the guest. The device writes them in the SVQ ring.

The functions responsible for that in QEMU are
hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called by
the device when used descriptors are written to the SVQ, which calls
hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
modifications similar to vhost_svq_add: Make them conditional if we're
in split or packed vq, and "copy" the code from Linux's
drivers/virtio/virtio_ring.c:virtqueue_get_buf.

After these modifications you should be able to ping and forward
traffic. As always, It is totally ok if it needs more than one
iteration, and feel free to ask any question you have :).

> Here's part of the trace:
>
> [...]
> [  945.370085] watchdog: BUG: soft lockup - CPU#2 stuck for 863s! [Networ=
kManager:795]
> [  945.372467] Modules linked in: rfkill intel_rapl_msr intel_rapl_common=
 intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_g
> [  945.387413] CPU: 2 PID: 795 Comm: NetworkManager Tainted: G           =
  L     6.8.7-200.fc39.x86_64 #1
> [  945.390685] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  945.394256] RIP: 0010:virtnet_poll+0xd8/0x5c0 [virtio_net]
> [  945.395998] Code: c0 74 5c 65 8b 05 24 37 8b 3f 41 89 86 c4 00 00 00 8=
0 bb 40 04 00 00 00 75 32 48 8b 3b e8 00 00 28 c7 48 89 df be8
> [  945.401465] RSP: 0018:ffffabaec0134e48 EFLAGS: 00000246
> [  945.403362] RAX: ffff9bf904432000 RBX: ffff9bf9085b1800 RCX: 00000000f=
fff0001
> [  945.405447] RDX: 0000000000008080 RSI: 0000000000000001 RDI: ffff9bf90=
85b1800
> [  945.408361] RBP: ffff9bf9085b0808 R08: 0000000000000001 R09: ffffabaec=
0134ba8
> [  945.410828] R10: ffffabaec0134ba0 R11: 0000000000000003 R12: ffff9bf90=
5a34ac0
> [  945.413272] R13: 0000000000000040 R14: ffff9bf905a34a00 R15: ffff9bf90=
85b0800
> [  945.415180] FS:  00007fa81f0f1540(0000) GS:ffff9bf97bd00000(0000) knlG=
S:0000000000000000
> [  945.418177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  945.419415] CR2: 000055614ba8dc48 CR3: 0000000102b42006 CR4: 000000000=
0770ef0
> [  945.423312] PKRU: 55555554
> [  945.424238] Call Trace:
> [  945.424238]  <IRQ>
> [  945.426236]  ? watchdog_timer_fn+0x1e6/0x270
> [  945.427304]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  945.428239]  ? __hrtimer_run_queues+0x10f/0x2b0
> [  945.431304]  ? hrtimer_interrupt+0xf8/0x230
> [  945.432236]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
> [  945.434187]  ? sysvec_apic_timer_interrupt+0x39/0x90
> [  945.436306]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  945.438199]  ? virtnet_poll+0xd8/0x5c0 [virtio_net]
> [  945.438199]  ? virtnet_poll+0xd0/0x5c0 [virtio_net]
> [  945.440197]  ? handle_irq_event+0x50/0x80
> [  945.442415]  ? sched_clock_cpu+0x5e/0x190
> [  945.444563]  ? irqtime_account_irq+0x40/0xc0
> [  945.446191]  __napi_poll+0x28/0x1c0
> [  945.446191]  net_rx_action+0x2a4/0x380
> [  945.448851]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [  945.450209]  ? note_gp_changes+0x6c/0x80
> [  945.452252]  __do_softirq+0xc9/0x2c8
> [  945.453579]  do_softirq.part.0+0x3d/0x60
> [  945.454188]  </IRQ>
> [  945.454188]  <TASK>
> [  945.456175]  __local_bh_enable_ip+0x68/0x70
> [  945.458373]  virtnet_open+0xdc/0x310 [virtio_net]
> [  945.460005]  __dev_open+0xfa/0x1b0
> [  945.461310]  __dev_change_flags+0x1dc/0x250
> [  945.462800]  dev_change_flags+0x26/0x70
> [  945.464190]  do_setlink+0x375/0x12d0
> [...]
>
> I am not sure if this issue is similar to the one
> described in this patch (race between channels
> setting and refill) [5]. As described in the patch,
> I see drivers/net/virtio_net:virtnet_open invoke
> try_fill_recv() and schedule_delayed_work() [6]. I
> am unfamiliar with this and so I am not sure how to
> progress.
>
> Maybe I can try disabling napi and checking it out
> if that is possible. Would this be a good next step
> to troubleshoot the kernel crash?
>
> Thanks,
> Sahil
>
> Changes v3 -> v4:
> - Split commit #1 of v3 into commit #1 and #2 in
>   this series [7].
> - Commit #3 is commit #2 of v3.
> - Commit #4 is based on commit #3 of v3.
> - Commit #5 was sent as an individual patch [8].
> - vhost-shadow-virtqueue.c
>   (vhost_svq_valid_features): Add enums.
>   (vhost_svq_memory_packed): Remove function.
>   (vhost_svq_driver_area_size,vhost_svq_descriptor_area_size): Decouple f=
unctions.
>   (vhost_svq_device_area_size): Rewrite function.
>   (vhost_svq_start): Simplify implementation.
>   (vhost_svq_stop): Unconditionally munmap().
> - vhost-shadow-virtqueue.h: New function declaration.
> - vhost-vdpa.c
>   (vhost_vdpa_svq_unmap_rings): Call vhost_vdpa_svq_unmap_ring().
>   (vhost_vdpa_svq_map_rings): New mappings.
>   (vhost_vdpa_svq_setup): Add comment.
>
> [1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-2
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/net/vhost-vdpa.c#L=
167
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L58
> [4] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1763
> [5] https://lkml.iu.edu/hypermail/linux/kernel/1307.0/01455.html
> [6] https://github.com/torvalds/linux/blob/master/drivers/net/virtio_net.=
c#L3104
> [7] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01148.htm=
l
> [8] https://lists.nongnu.org/archive/html/qemu-devel/2024-11/msg00598.htm=
l
>
> Sahil Siddiq (5):
>   vhost: Refactor vhost_svq_add_split
>   vhost: Write descriptors to packed svq
>   vhost: Data structure changes to support packed vqs
>   vdpa: Allocate memory for svq and map them to vdpa
>   vdpa: Support setting vring_base for packed svq
>
>  hw/virtio/vhost-shadow-virtqueue.c | 222 +++++++++++++++++++----------
>  hw/virtio/vhost-shadow-virtqueue.h |  70 ++++++---
>  hw/virtio/vhost-vdpa.c             |  47 +++++-
>  3 files changed, 237 insertions(+), 102 deletions(-)
>
> --
> 2.47.0
>


