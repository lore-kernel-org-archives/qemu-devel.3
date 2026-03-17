Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D24F506CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2NCG-0003Cj-SS; Tue, 17 Mar 2026 01:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w2NCF-0003CU-9y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:42:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w2NCC-000644-HX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:42:27 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6611e4aefdcso9231225a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 22:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773726141; cv=none;
 d=google.com; s=arc-20240605;
 b=EGDso8ApwcA6XWZz47m+E4zh3l4fi6CEda3B2xtzLHU+lhm8Q2lj1C2cFz1rxCvBJ0
 LVzsS8yssFI6/2qBYPNVdm5Ku1vUo6lYTrcw9SPzBQi4gNJN7pTTMLMFOedwBypvoyiU
 F1tfdcBgIOEcTZw/+hvHgdT2INLDojRrCRzitbPQoPA/pWO6I74ZgZ6voFYDFoqcFCJk
 yRV9U9YV+n0u9DVFBLD5glk42ZYzfj59fDfcUL+aTSYeOVPmgO1vZk0lCVciIKVyUiFS
 c+qK0F/qcTwQ5n5Amv8q+eQ0vcdVaSVVy+hvyDwexxkzh27OKDJz1rEHIcv1nXhVm+Sy
 ghMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JVFq9FYwPguIc15a1nIdBD4nYRgQ81ajq/3e1WEDK2s=;
 fh=5xkmThXa/iK1P0JKOUNHwUUL7ixLSI/qF9SymsFMndk=;
 b=AGXk6nS7JJ9wOuU7VdqM7z96CFe+qAigrFvS1MnE7V7ld+2YOZZ3lYPBMksLFFXQKa
 nl81BtgLetuFy82dOkrEQZeuystNxt7a4VxsKPfE32WSdAcM5vh2j5LKH/EfyjhLSyo8
 lSYfU/RBdKUM6dm6jJDTaBdL3Ddvnm+J+u6tzQtnMmvYcVgwOuG9yrEpF3odbj6+ei9c
 XcTrzVdVhFgkFjebyd8HMn9HWuu9iP5vfK/E+Jz1b4p48/oo5vvW7iid5mPvJXdCv0ar
 THg8KT5n1K6vVeNXc1vm5rfCFUhtxb+6RiucwXsX4G9K3yj5iYolH+wFaH8wtbR1fAxk
 g0Ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773726141; x=1774330941; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVFq9FYwPguIc15a1nIdBD4nYRgQ81ajq/3e1WEDK2s=;
 b=GTqLh8jGmSPGDZe+L93/BZ0kMQTKqLjOcXrHqQA1vJWTqfinjTklA/SJl6I+XaRbU4
 1hPaJI+BkIP9QKaW8vzj9NJevfFoJ+eicGEzQSnDV9tuHZqzZ0LOk9wbdFvnkgBgGCSE
 S3dThtRjjWyZbl8uDeHw4J2U5QmVuxlJV0NHE0PIOAtVjHkJjVm44APrOLpzDdXCGYnv
 MGU76OztNtdVYNEGKyCPVy4F0Ot9VdnjsgiC1B9GJDaCL00wf+70LMHkVdDZFD39v7Ep
 AW2Uv629b/pToZRs7Z4GW8SL3HFSg1wbsygraPjy/LyJJfLZ+GF/tsxgx7R9hRm9wZ+a
 3bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773726141; x=1774330941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JVFq9FYwPguIc15a1nIdBD4nYRgQ81ajq/3e1WEDK2s=;
 b=dioYiAiaQhrzalTEY5fwnpdyl/bqMpWKQLv5ZTbnm7omFB53fylenOPtsqiWUWYKTQ
 tA+5T7hXzKlUHBuEakoEHBk/12bKpr1+5n1IKIAZLCWAdvGpnrWlP75+dRZ8NbB09xK5
 W93JO0DTzXSvmSvjC6f2XDd7W8cnxnBQlFxS+Pky6aepZ+GTb170FCbn9h/E6KxOvOnq
 xmlQFXqIXecVZfY7gpADpfndBNepyN4ZX4XvpWTT285l/ieWPVC+zpde+e+bZ3MXERd0
 A3B0Fc9O7FpcW+D0P9oRHw5+TRRw/w7uU3Qw55B9x1WNStY634exhCNM5Nr8K5q5N9uN
 t6UQ==
X-Gm-Message-State: AOJu0YxND+ItHPT1JcdRs+Q7B8k6MXYO/FDt5Hz4hGx3GgrGla7ztZHj
 aseTmH0bNz7H8634VHfKz+MiL7X7FeMve+rLlXmW1Fzx19PlqZC3NisEdAPmru7PrlmdffVsZLu
 6F5QDPEeYk546eK4pwz0QkyTuDI0sTN8=
X-Gm-Gg: ATEYQzzdhS3xpV7CvSkRWg1Mz0KrpFnAIuOcZasZe7X7+fPJUBLJmQKAifO2Qx1iuCe
 Vl7jXKDZUgpZ0AofkgNceUXbQieduxIbKCK5atCw5PTpmz5V+qchug4UEyas3JY0JdDof6XHK4q
 2GNLRirj7Eh8QhmUZlKgAlhgHitrCC7jyfoHDXaOOiuDtuXaZRvgti600egHyIeTHl+fdaLFOk3
 9SFPhvv7ToUbEla6VCiwe7fHJv18qVWabYc66huX6yUeDyzfWKMy91IZFvWb9VjbNtGh93WCaPv
 AnqWDlv7uO1M5fWwTMZGoXy3LYUbeoIJaQA4ZNLtyQ==
X-Received: by 2002:a05:6402:40c6:b0:661:2922:be03 with SMTP id
 4fb4d7f45d1cf-663bac05926mr8028109a12.24.1773726141138; Mon, 16 Mar 2026
 22:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260316210600.62415-1-serapheimd@gmail.com>
In-Reply-To: <20260316210600.62415-1-serapheimd@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Mar 2026 13:42:06 +0800
X-Gm-Features: AaiRm534AG5sFtsXSHwKYi5fhB1ONIjSexYLN38pV37IZZ44TM_qwZaZavK0Tfc
Message-ID: <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
Subject: Re: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
To: Serapheim Dimitropoulos <serapheimd@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 stefanha@redhat.com, sgarzare@redhat.com, xieyongji@bytedance.com, 
 weijunji@bytedance.com, xiongweimin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 17, 2026 at 5:39=E2=80=AFAM Serapheim Dimitropoulos
<serapheimd@gmail.com> wrote:

Hi Serapheim,
Some thoughts below. I only have a rough understanding of RDMA, so I
hope others who worked on previous virtio-rdma and pvrdma devices will
also join the discussion.

> QEMU removed pvrdma in v9.1 (deprecated in v8.2). There is currently
> zero RDMA emulation in QEMU. Anyone wanting to learn, develop, or
> test RDMA software needs Mellanox/NVIDIA hardware which at times is
> hard to come by.

I think this is a sign that virtual RDMA has a small community without
someone willing to maintain it over the long term. Can you see
yourself actively maintaining this over the coming years?

If not, then it may be more appropriate to treat it as an experimental
and out-of-tree project. That way the spec and code can be shared in
case others want to build on it in the future without any commitment
or the overhead of going through the full process of getting a device
merged into the VIRTIO spec, QEMU emulating code merged, and Linux
guest code merged.

If you are going to ship products that rely on this, then it's
probably necessary to go through the full process of getting
everything merged upstream.

> Software RDMA stacks (rxe, siw) exist in the kernel but they run
> entirely on the guest CPU. One-sided operations (RDMA WRITE/READ)
> still involve the remote CPU (it receives a UDP packet, then
> decapsulates it, copies data in software). My point is that they
> give you the RDMA API but not the hardware behavior.
>
> Meanwhile, the vDPA framework has matured significantly (VDUSE in
> 5.15+, generic vhost-vdpa-device-pci in QEMU 8.0+), creating a
> natural abstraction layer for virtio devices that can span software
> emulation and hardware offload. No one has applied this to RDMA yet.
>
> =3D My Proposal =3D
>
> A new virtio-rdma device type (one guest driver + multiple backends):
>
>  1. QEMU device model (in-process, C): The reference implementation.
>     Software emulation for development, CI tests, and learning. No
>     host RDMA stack or hardware needed. The idea: two QEMU instances
>     on a dev laptop doing RDMA to each other.

This sounds like it would be implemented along the same lines as
vhost-user and vfio-user. These protocols use a UNIX domain socket to
coordinate shared memory and signalling. In the RDMA case there would
be two QEMUs talking to each other rather than one QEMU and a device
emulation process.

If you are eager to use Rust, QEMU has support for Rust code too.
Bindings are missing for existing C APIs but they can be added.

>  2. VDUSE backend (userspace daemon): The same virtio-rdma protocol
>     implemented as a standalone process via /dev/vduse. Could be
>     written in Rust (or not no preference here). It's crash-isolated
>     from the host kernel and the goal is to make it a natural fit
>     for DPU control planes (i.e. the DPU runs a VDUSE daemon that
>     presents virtio-rdma to the host VM).
>
>  3. Hardware vDPA (potential long-term goal): when/if DPU/SmartNIC
>     vendors ever implement the virtio-rdma data path in silicon, the
>     guest driver would work unchanged via vhost-vdpa-device-pci (no
>     QEMU device code needed).
>
> The guest driver is the same in all three cases. It submits verbs
> through virtqueues, completely unaware of the backend.
>
> The main idea is that this is basically self-contained (no host RDMA
> stack or hardware needed for [1]), it uses standard virtio-pci
> transport making it hypervisor-agnostic, and provides RDMA "hardware"
> behavior without the actual hardware (compared to rxe/siw which is
> RDMA "API" behavior without hardware). Again this is complementary
> to rxe/siw and not a replacement.
>
> The follow-up on that is that I hope it could fit naturally into the
> vDPA ecosystem alongside virtio-net and virtio-blk as a first-class
> offloadable device.
>
> =3D Design Overview =3D

It would be nice to also include virtio-comment@lists.linux.dev in the
design discussion. It may help get the attention of VIRTIO folks who
are less focused on QEMU but still interested in RDMA.

>
> Four virtqueues:
>
>   VQ 0 (command)    - resource management: create/destroy PD, MR,
>                       CQ, QP, AH. Synchronous request/response.

Does this mean that memory is registered on VQ 0 and incoming RDMA
WRITE (without immediate) requests modify that memory directly without
virtqueue activity? I think this is necessary because registered
memory is available continuously and the virtqueue model doesn't
really work for this mode of operation.

It's worth clarifying this because accessing memory outside of
virtqueue buffers is a violation of the VIRTIO device model. That's
okay, VIRTIO is pragmatic and some devices do this but it's worth
mentioning explicitly.

Stepping outside the VIRTIO device model can create implementation
challenges because interfaces like vDPA/VDUSE may not be designed for
it though.

>   VQ 1 (completion) - device returns CQEs to pre-posted driver
>                       buffers when operations complete.
>   VQ 2 (data-tx)    - driver posts SEND/RDMA WRITE/READ work
>                       requests with scatter/gather data.
>   VQ 3 (data-rx)    - driver pre-posts receive buffers; device
>                       fills them on incoming SEND.
>
> The device maintains full resource state: protection domains, memory
> regions with page tables and access keys, QPs with the standard IB
> state machine (RESET -> INIT -> RTR -> RTS), and completion queues.
>
> The QEMU device model uses a socket backend for SEND/RECV currently.
> A shared-memory backend (ivshmem) would be needed for truly one-sided
> RDMA WRITE/READ where the remote CPU is not involved (matches real HCA
> DMA behavior). The same shared-memory transport would also be reused
> by the VDUSE daemon backend.

vhost-user and vfio-user build the shared memory support into a UNIX
domain socket protocol. The guest RAM is shared with the external
process via file descriptor passing. The external process can then
read/write guest RAM at will. See
https://gitlab.com/qemu-project/qemu/-/blob/master/docs/interop/vhost-user.=
rst?ref_type=3Dheads#id54.

There are limitations to this approach with regarding to IOMMU and
isolation (security), but it works well for basic use cases.

I haven't thought about how it would integrate with VDUSE.

> QEMU device model currently looks something like this in terms of
> structure:
>
>   include/hw/virtio/virtio-rdma.h     - device structs, wire protocol
>   hw/virtio/virtio-rdma.c             - resource manager, command VQ,
>                                         datapath, completions
>   hw/virtio/virtio-rdma-pci.c         - PCI wrapper (boilerplate)
>   hw/virtio/virtio-rdma-backend.c     - socket backend
>
> I have a minimally working kernel driver (modeled after
> drivers/infiniband/hw/efa/) and a very early draft virtio spec.  I'll
> gladly open RFC patches for all three given the general direction of
> this make sense to you.

Makes sense to me.

> =3D The vDPA/VDUSE case =3D
>
> I want to highlight why I believe this matters beyond pure emulation.
> The vDPA framework already handles virtio-net and virtio-blk offload to
> hardware. virtio-rdma would be the first vDPA-compatible RDMA device
> type.
>
> The specific use case for my employer would be DPU-based RDMA. A DPU
> (think NVIDIA BlueField) runs a VDUSE daemon that presents a
> virtio-rdma device to the host VM. The daemon handles the RDMA control
> plane (connection setup, memory registration, key exchange) in
> userspace, then programs the DPU's physical NIC for the data plane.
> The host VM sees a standard virtio device and uses the standard
> virtio-rdma driver (no vendor-specific drivers needed).
>
> If I understand correctly, the vhost-vdpa-device-pci architecture
> was designed for exactly that, so RDMA could fit naturally as a device
> type after net and block.

Yes, but check how registered memory can be implemented both in VDUSE
and in-kernel vDPA drivers.

> VDUSE currently only supports virtio-block (security scoping in
> drivers/vdpa/vduse/). Extending it to virtio-rdma would require
> kernel patches to whitelist the device type, with appropriate
> validation in the virtio-rdma driver to handle untrusted device
> input safely.
>
> =3D Prior work =3D
>
> I was able to find a few explorations of virtio-RDMA but no prior
> effort produced upstream-viable code. Yuval Shaia (Oracle) posted
> an RFC in April 2019 with a QEMU device model and kernel driver,
> but it only implemented probing and basic ibverbs (no data path nor
> progress past RFC v1). The MIKELANGELO/Huawei vRDMA project
> (2016-2017) targeted QEMU 2.3 and the OSv unikernel as part of an EU
> Horizon 2020 research effort it seems now obsolete.
>
> The most relevant prior work I could find is from Xie Yongji and Wei
> Junji at ByteDance, who posted an [RFC v2] to virtio-comment in May
> 2022 [1] proposing to add RoCE as a VIRTIO_NET_F_ROCE feature extension
> to virtio-net (rather than a standalone device type). Their v1 was a
> standalone device; the v2 reworked it as a virtio-net extension. They
> had working code (kernel driver, QEMU, rdma-core, vhost-user-rdma
> backend) but the effort seems to have gone quiet after 2022 with no
> v3. Notably, Yongji is also the author of VDUSE itself so I'd really
> value his input. I'm proposing a standalone device type rather than a
> virtio-net extension because RDMA isn't inherently tied to Ethernet
> (InfiniBand exists), it maps more cleanly onto the vDPA offload model
> as a separate device, and it avoids burdening virtio-net with RDMA
> complexity. But I could be wrong =E2=80=94 happy to hear arguments either=
 way.
>
> In addition, very recently, Xiong Weimin posted a vhost-user-rdma/DPDK
> concept to netdev (Dec 2025) [2] which takes a different architectural
> approach (DPDK-based vhost-user backend); that work seems
> complementary but has not produced formal patches.
>
> I CC'd both Yongji and Xiong on this email in case they have opinions.
>
> This series builds on the same virtio-RDMA concept with a complete
> data path, modern QEMU/kernel APIs (virtio-1.0, QIOChannel, kernel
> 6.x ib_device_ops), and a vDPA-native architecture that none of the
> prior efforts had.
>
> [1] https://groups.oasis-open.org/communities/community-home/digestviewer=
/viewthread?MessageKey=3D20912da6-db56-441c-9117-0148b9c86ea5&CommunityKey=
=3D2f26be99-3aa1-48f6-93a5-018dce262226
> [2] https://lists.openwall.net/netdev/2025/12/19/13
>
> =3D Questions for the community =3D
>
>  1. Does a virtio-rdma device make sense as a direction? I've studied
>     virtio-sound and virtio-can as precedents for new device types.
>
>  2. The device is written in C to match existing virtio devices. I saw
>     the Rust PCI+DMA bindings are still in progress =E2=80=94 should I wa=
it,
>     or is C the right choice today?

Writing C devices is still perfectly acceptable in QEMU. With Rust you
are likely to have to work on bindings and may hit issues just because
Rust is new in QEMU, but it's there and you can absolutely use it.

>  3. For the shared-memory backend, I'm planning to use ivshmem. Is
>     there a preferred mechanism for zero-copy inter-VM memory sharing
>     in QEMU today, or is ivshmem still the way to go?

For the userspace virtio-rdma device implementation I expected a new
UNIX domain socket protocol along the lines of vhost-user and
vfio-user. That's because sharing guest RAM is only part of the
communication that must happen between two QEMUs and I guess you'll
need to define your own protocol to coordinate RDMA between QEMU
processes anyway.

When using vDPA or VDUSE, QEMU shares guest RAM with the device
through the /dev/vhost ioctls.

In both cases, I'm not sure if ivshmem is necessary.

>  4. Any concerns about the virtqueue layout? I split command and
>     completion into separate VQs (rather than putting responses
>     inline) to allow async completions =E2=80=94 similar to how real HCAs
>     separate CQ from QP.

It depends what you mean by async. Virtqueues can complete requests
out-of-order, so a separate completion virtqueue is not needed from
that perspective.

There could be other reasons why a separate completion virtqueue makes
sense. If RDMA relies on the separate CQ design to emit multiple CQEs
for the same request or emits CQEs not associated with any request,
then a single virtqueue won't work. I don't know RDMA well enough to
say either way.

>  5. For the VDUSE backend path: should the QEMU integration rely on
>     the existing generic vhost-vdpa-device-pci, or would a dedicated
>     vhost-vdpa-rdma device (like vhost-vdpa-net) be preferred for
>     control-plane visibility?

I think vhost-vpda-device-pci is good practice. It makes sure the
device is self-contained and doesn't rely on device-specific VMM
support. If it's possible to use just vhost-vdpa-device-pci, then
that's great. It scales better because it avoids the need to implement
a device in every VMM (like QEMU, Firecracker, etc).

>  6. I'm planning to extend VDUSE to support virtio-rdma as a device
>     type. Is there ongoing work or discussion about expanding VDUSE
>     beyond virtio-block that I should coordinate with?
>
>  7. Would it be ok to use the experimental device ID 0x1045 until
>     the OASIS TC assignment?

You can reserve a device ID from the VIRTIO Technical Committee
separately from getting the spec merged. Ask
virtio-comment@lists.linux.dev.

> I'm happy to send the RFC patch series, kernel driver, and spec draft
> whenever you'd like to see code.

It is helpful to see the draft VIRTIO spec and RFC patches at the same
time. So as soon as you want to discuss the specifics of the VIRTIO
spec patches it would be a good time to send RFC patches showing how
the spec is implemented.

Stefan

