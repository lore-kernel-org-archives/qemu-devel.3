Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78BC3600D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLIs-0004wH-Dx; Wed, 26 Mar 2025 03:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txLIr-0004w4-I1
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txLIo-0003v5-VD
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742974551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omUctucYZfV6lapR5f+el9xbaJVOo/RNS559gOfGPXM=;
 b=eQAfnCZsbHhjZ+57iY1CxlHTTSWOtXMlZ3MXZUkIGR8sLlckY6cv39guSoIys85l+eYvXM
 2mV99wrAFA0BleaF5iqvfbPwfoo1rIYNZNrI64I/WYgkO0ND1SNu8HUWQlc1TmsK7op8sT
 9soO9icTH07dzZ759z5iEAqrIRj+syI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-1zL0AbWQPr2MROm3v0W8kQ-1; Wed, 26 Mar 2025 03:35:48 -0400
X-MC-Unique: 1zL0AbWQPr2MROm3v0W8kQ-1
X-Mimecast-MFC-AGG-ID: 1zL0AbWQPr2MROm3v0W8kQ_1742974547
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff854a2541so10935259a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 00:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974547; x=1743579347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omUctucYZfV6lapR5f+el9xbaJVOo/RNS559gOfGPXM=;
 b=Eb9C68qaMjucvSPXOd1U99EcJifBvJKYfCoCDoJcoN2Jm3veft98RrbINNZlzvJBRX
 ER3fEI1UBmRKDnF1rs0UoX3ri2PIEA8qmwYbjaORRnqytD5AL+SrGlYl4NfFfgZkY50K
 z3E2cy1PWNigd/JA1vh0kovad5lPzbM5We2wB7Yv8augUkjj7RFJ8291B3KpYggCR3Tb
 B56JPUEqARipemE/19FP1OpBRGI2yW5r0CbDo+g5tpREohmxsWoEm9HIfrnmnekvnNu2
 MvT+Q42Uaa42b6RMawSbAUhXav6in7yhj0jqDiOO40TxzQPYAF4Nw5Nsvn7TNeEgUdi+
 fsCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzfL2nmQ2+U1ZGDTre/c+HDihaHzhsrM6/p06bJKyLHe6JPCHM2HvBCLJrMlHRCn6LiHSpIJuQlaY9@nongnu.org
X-Gm-Message-State: AOJu0Yw0Rgpz9yQ0FsA83WdnMldhZkW+syCGr8i09B5lSNza7I8fUl/o
 7otOul8kQlBn8bfpXGLG2ypJnMTKEop6jTe1jdiQgCMahXHpX9i4292GoDlxhPUKdIxuNyPflZz
 eH5dGvAgZlJjmaWW6DNQylHZp0J3jJFCxhUHO9KVtQ2/kMTWrdu3r9ok5PFIgoBWEOTe5AbJGiG
 V+V50T41R45FhleK6SebE0bxflrxI=
X-Gm-Gg: ASbGncv+VNBrN9M3ge22dIwbjroD4mhhLx8z33ZjnhBGotpUTllokubmccxVO4U03XD
 3eM1tcS5HF9OFYQB78f3q/Yj1BEkqbHYOAyieJB2z1TuhnmzbcT4ZRRxFstovPbwLfQl7ek8=
X-Received: by 2002:a17:90b:498f:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-3030feb7afdmr33106825a91.15.1742974546800; 
 Wed, 26 Mar 2025 00:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeGLgErzkA+FL+LlxH2JcL/fLdKBVpyOBcoGSIWzWlWUv0TABq703Z2ZfFkheaJnzb+hklgrwMOT+bwn26eA=
X-Received: by 2002:a17:90b:498f:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-3030feb7afdmr33106751a91.15.1742974545678; Wed, 26 Mar 2025
 00:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 08:35:09 +0100
X-Gm-Features: AQ5f1Jpd6cSp7Yi9VULAF5a51OdvofbDu5NPHzkln2hoLmNfu0RApEazsC3FwdY
Message-ID: <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 24, 2025 at 2:59=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> I managed to fix a few issues while testing this patch series.
> There is still one issue that I am unable to resolve. I thought
> I would send this patch series for review in case I have missed
> something.
>
> The issue is that this patch series does not work every time. I
> am able to ping L0 from L2 and vice versa via packed SVQ when it
> works.
>

So we're on a very good track then!

> When this doesn't work, both VMs throw a "Destination Host
> Unreachable" error. This is sometimes (not always) accompanied
> by the following kernel error (thrown by L2-kernel):
>
> virtio_net virtio1: output.0:id 1 is not a head!
>

How many packets have been sent or received before hitting this? If
the answer to that is "the vq size", maybe there is a bug in the code
that handles the wraparound of the packed vq, as the used and avail
flags need to be twisted. You can count them in the SVQ code.

> This error is not thrown always, but when it is thrown, the id
> varies. This is invariably followed by a soft lockup:
>
> [  284.662292] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [swapper=
/1:0]
> [  284.662292] Modules linked in: rfkill intel_rapl_msr intel_rapl_common=
 intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_=
class vfg
> [  284.662292] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.7-200.fc39.x=
86_64 #1
> [  284.662292] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  284.662292] RIP: 0010:virtqueue_enable_cb_delayed+0x115/0x150
> [  284.662292] Code: 44 77 04 0f ae f0 48 8b 42 70 0f b7 40 02 66 2b 42 5=
0 66 39 c1 0f 93 c0 c3 cc cc cc cc 66 87 44 77 04 eb e2 f0 83 44 24 fc 00 <=
e9> 5a f1
> [  284.662292] RSP: 0018:ffffb8f000100cb0 EFLAGS: 00000246
> [  284.662292] RAX: 0000000000000000 RBX: ffff96f20204d800 RCX: ffff96f20=
6f5e000
> [  284.662292] RDX: ffff96f2054fd900 RSI: ffffb8f000100c7c RDI: ffff96f20=
54fd900
> [  284.662292] RBP: ffff96f2078bb000 R08: 0000000000000001 R09: 000000000=
0000001
> [  284.662292] R10: ffff96f2078bb000 R11: 0000000000000005 R12: ffff96f20=
7bb4a00
> [  284.662292] R13: 0000000000000000 R14: 0000000000000000 R15: ffff96f20=
452fd00
> [  284.662292] FS:  0000000000000000(0000) GS:ffff96f27bc80000(0000) knlG=
S:0000000000000000
> [  284.662292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  284.662292] CR2: 00007f2a9ca191e8 CR3: 0000000136422003 CR4: 000000000=
0770ef0
> [  284.662292] PKRU: 55555554
> [  284.662292] Call Trace:
> [  284.662292]  <IRQ>
> [  284.662292]  ? watchdog_timer_fn+0x1e6/0x270
> [  284.662292]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  284.662292]  ? __hrtimer_run_queues+0x10f/0x2b0
> [  284.662292]  ? hrtimer_interrupt+0xf8/0x230
> [  284.662292]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
> [  284.662292]  ? sysvec_apic_timer_interrupt+0x39/0x90
> [  284.662292]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  284.662292]  ? virtqueue_enable_cb_delayed+0x115/0x150
> [  284.662292]  start_xmit+0x2a6/0x4f0 [virtio_net]
> [  284.662292]  ? netif_skb_features+0x98/0x300
> [  284.662292]  dev_hard_start_xmit+0x61/0x1d0
> [  284.662292]  sch_direct_xmit+0xa4/0x390
> [  284.662292]  __dev_queue_xmit+0x84f/0xdc0
> [  284.662292]  ? nf_hook_slow+0x42/0xf0
> [  284.662292]  ip_finish_output2+0x2b8/0x580
> [  284.662292]  igmp_ifc_timer_expire+0x1d5/0x430
> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
> [  284.662292]  call_timer_fn+0x21/0x130
> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
> [  284.662292]  __run_timers+0x21f/0x2b0
> [  284.662292]  run_timer_softirq+0x1d/0x40
> [  284.662292]  __do_softirq+0xc9/0x2c8
> [  284.662292]  __irq_exit_rcu+0xa6/0xc0
> [  284.662292]  sysvec_apic_timer_interrupt+0x72/0x90
> [  284.662292]  </IRQ>
> [  284.662292]  <TASK>
> [  284.662292]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  284.662292] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [  284.662292] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 53 75 3f 00 fb f4 <=
c3> cc c0
> [  284.662292] RSP: 0018:ffffb8f0000b3ed8 EFLAGS: 00000212
> [  284.662292] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000000=
0000000
> [  284.662292] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 000000000=
00289ec
> [  284.662292] RBP: ffff96f200810000 R08: 0000000000000000 R09: 000000000=
0000001
> [  284.662292] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000=
0000000
> [  284.662292] R13: 0000000000000000 R14: ffff96f200810000 R15: 000000000=
0000000
> [  284.662292]  default_idle+0x9/0x20
> [  284.662292]  default_idle_call+0x2c/0xe0
> [  284.662292]  do_idle+0x226/0x270
> [  284.662292]  cpu_startup_entry+0x2a/0x30
> [  284.662292]  start_secondary+0x11e/0x140
> [  284.662292]  secondary_startup_64_no_verify+0x184/0x18b
> [  284.662292]  </TASK>
>
> The soft lockup seems to happen in
> drivers/net/virtio_net.c:start_xmit() [1].
>

Maybe it gets stuck in the do {} while(...
!virtqueue_enable_cb_delayed()) ? you can add a printk in
virtqueue_enable_cb_delayed return and check if it matches with the
speed you're sending or receiving ping. For example, if ping is each
second, you should not see a lot of traces.

If this does not work I'd try never disabling notifications, both in
the kernel and SVQ, and check if that works.

> I don't think the issue is in the kernel because I haven't seen
> any issue when testing my changes with split vqs. Only packed vqs
> give an issue.
>
> L0 kernel version: 6.12.13-1-lts
>
> QEMU command to boot L1:
>
> $ sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff=
,guest_announce=3Doff,mq=3Doff,ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff,=
ctrl_mac_addr=3Doff,packed=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno,vhost=3Doff \
> -nographic \
> -m 8G \
> -smp 4 \
> -M q35 \
> -cpu host 2>&1 | tee vm.log
>
> L1 kernel version: 6.8.5-201.fc39.x86_64
>
> I have been following the "Hands on vDPA - Part 2" blog
> to set up the environment in L1 [2].
>
> QEMU command to boot L2:
>
> # ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,id=3D=
vhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff,ctrl_mac_addr=3Doff=
,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> L2 kernel version: 6.8.7-200.fc39.x86_64
>
> I confirmed that packed vqs are enabled in L2 by running the
> following:
>
> # cut -c35 /sys/devices/pci0000\:00/0000\:00\:07.0/virtio1/features
> 1
>
> I may be wrong, but I think the issue in my implementation might be
> related to:
>
> 1. incorrect endianness coversions.
> 2. implementation of "vhost_svq_more_used_packed" in commit #5.
> 3. implementation of "vhost_svq_(en|dis)able_notification" in commit #5.
> 4. something else?
>

I think 1 is unlikely. I'd go with 2 and 3.

Let me know if the proposed changes work!

> Thanks,
> Sahil
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/net/virtio_net.=
c#L3245
> [2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-2
>
> Sahil Siddiq (7):
>   vhost: Refactor vhost_svq_add_split
>   vhost: Data structure changes to support packed vqs
>   vhost: Forward descriptors to device via packed SVQ
>   vdpa: Allocate memory for SVQ and map them to vdpa
>   vhost: Forward descriptors to guest via packed vqs
>   vhost: Validate transport device features for packed vqs
>   vdpa: Support setting vring_base for packed SVQ
>
>  hw/virtio/vhost-shadow-virtqueue.c | 396 ++++++++++++++++++++++-------
>  hw/virtio/vhost-shadow-virtqueue.h |  88 ++++---
>  hw/virtio/vhost-vdpa.c             |  52 +++-
>  3 files changed, 404 insertions(+), 132 deletions(-)
>
> --
> 2.48.1
>


