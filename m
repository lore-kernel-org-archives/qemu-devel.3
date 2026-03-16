Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F7BF53D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Fdi-0003zZ-9f; Mon, 16 Mar 2026 17:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serapheimd@gmail.com>)
 id 1w2F8e-0003Id-DM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:06:14 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serapheimd@gmail.com>)
 id 1w2F8c-0006wZ-2V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:06:11 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cd8576a512so17013785a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773695165; x=1774299965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vrJxf7H35iYwWw2Wng/CRj+1Il5hCE+51xScTp1cgAI=;
 b=nl5ZCaRVftuv4n8XeKMEJgOvj5fVWySbG+FEUeLZlrqf/QBykDZJBJPxgW0ic6GTtB
 J2XDcFDGVR1JFW0siHYj2x1hVOOwWe4Y3YpGULo8eAHDjvQe5Cl+5RZk1aDy4tYPFqwi
 EoifUQCH37yRhh8MDL/tbfpUlpkaTJQt1HATmq+m5wqdh3tPzlym+rilk+1FHLXLcnvk
 2vlYKk2JpfsIooi/TSli7J1IzhlwsbAZ94jJKkitycFenpMMJugUn4AmyhDOWWe9e9lw
 0IfuV607B6V8AcABM7BRdxUITMIZQQT8tBqQl3ZxyGIQ7eiJqzA2fD3ktPWR2srBK2hI
 PLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773695165; x=1774299965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrJxf7H35iYwWw2Wng/CRj+1Il5hCE+51xScTp1cgAI=;
 b=j/Fw0/Re12t7JIfJc2vwngpfeahMQ3HvsVT+suGU+dSTQoWtiBoCcy9zygS0AFjZrF
 tXc7zxHv+Q3DCNxgA6VwuLuLhIib4JcfCq9eoXWbflm6Riz/j/6LM5eXpPTHyfMm2APz
 dYvhDpK517+V78iJrt/XzDsW4J/VuH1mUY9J2aLLG9cNUfo0hWutx1TjQH4CquxMv5vX
 SqoxRm6QmsRdO6gehGNBz5hWi93dT+MfJ+PiW41Ti31dDesh4xuPRSu21D7NOwjdHFmq
 5G1NHqLbZq98DgZ0LvnMdGK5fMtXq/mEQbUgxmRqLWhiZKiMeEHZ2lm/PlarnJcy3W7n
 SlBw==
X-Gm-Message-State: AOJu0YwlIul6c5ZQ1ZdKBAZp/19neEGUCXghZP5b8bfE7tFLUt8XTpcj
 eW5Gl47qo1jYaTodGsuJMMB3OjFTwYrEwGdr8PPSnjqOTilVHFaPcXdP7EDueTrE
X-Gm-Gg: ATEYQzzWyIbsHTCESK+n8AEpbqwK9w42QfDRzYjXDnvj6XQPahz3Ua+pPftOXClRQ6W
 rvU7h7fDRcjZ4JMXxML4+XVs2qcoFZEgFQO2HEEG6qjUqjXe+Eh2GY3QTOEohsfwjVM9mZzv6LR
 07euEnAdV+xzoVr8CGdTMvYSWqKElLmQN+MA6y7mwvVerr9hQg42MplUbpLGuVeUVTzo+SVekPP
 mzMvXQT1DOvrwvXpu98P2LLqkFiM3WrWoGfHOSRjZwZcYl+2dqtFMgqLfZOF3BxsjyCWtOsxgmX
 Kbt8PKQVewCsHjo4nfhBDHiVb+tl4mNyhW+QwxRjPvu1KJaEk49hq6XPJPchAVVYP5YUkSdNP+o
 Pvb5Tk6w2RJCGO9npiFJVSU29bpNNJCHkNlvkNQknD/BgBtuzYbNw8UlzgsHpN9RA90NMJOr4Cu
 gj5GqC0XlpEjSdUle2VqJIz/ie2X897JaMmLKQsQub1OfoR2FlSI9YPAPGZ0/N+XKgbKUVS8585
 2UIYNwpkcAu2u8g
X-Received: by 2002:a05:620a:2893:b0:8cd:8945:bcf4 with SMTP id
 af79cd13be357-8cde12248femr174507785a.0.1773695165147; 
 Mon, 16 Mar 2026 14:06:05 -0700 (PDT)
Received: from CW-FL20TJCW03-L.tailb3cd1a.ts.net
 ([2600:4040:9138:9600:881:9edf:ce7b:f39e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21100b8sm1304691685a.29.2026.03.16.14.06.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Mar 2026 14:06:04 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, xieyongji@bytedance.com, weijunji@bytedance.com,
 xiongweimin@kylinos.cn, Serapheim Dimitropoulos <serapheimd@gmail.com>
Subject: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
Date: Mon, 16 Mar 2026 17:05:59 -0400
Message-ID: <20260316210600.62415-1-serapheimd@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=serapheimd@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Mar 2026 17:38:12 -0400
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

Hi all,

Apologies if this is not the right place but I'm looking to propose
the addition of a new virtio device type to QEMU for RDMA emulation.
Before sending patches, I wanted to introduce the idea and get early
feedback on the design before I go too far with my implementation.

= Motivation =

QEMU removed pvrdma in v9.1 (deprecated in v8.2). There is currently
zero RDMA emulation in QEMU. Anyone wanting to learn, develop, or
test RDMA software needs Mellanox/NVIDIA hardware which at times is
hard to come by.

Software RDMA stacks (rxe, siw) exist in the kernel but they run
entirely on the guest CPU. One-sided operations (RDMA WRITE/READ)
still involve the remote CPU (it receives a UDP packet, then
decapsulates it, copies data in software). My point is that they
give you the RDMA API but not the hardware behavior.

Meanwhile, the vDPA framework has matured significantly (VDUSE in
5.15+, generic vhost-vdpa-device-pci in QEMU 8.0+), creating a
natural abstraction layer for virtio devices that can span software
emulation and hardware offload. No one has applied this to RDMA yet.

= My Proposal =

A new virtio-rdma device type (one guest driver + multiple backends):

 1. QEMU device model (in-process, C): The reference implementation.
    Software emulation for development, CI tests, and learning. No
    host RDMA stack or hardware needed. The idea: two QEMU instances
    on a dev laptop doing RDMA to each other.

 2. VDUSE backend (userspace daemon): The same virtio-rdma protocol
    implemented as a standalone process via /dev/vduse. Could be
    written in Rust (or not no preference here). It's crash-isolated
    from the host kernel and the goal is to make it a natural fit
    for DPU control planes (i.e. the DPU runs a VDUSE daemon that
    presents virtio-rdma to the host VM).

 3. Hardware vDPA (potential long-term goal): when/if DPU/SmartNIC
    vendors ever implement the virtio-rdma data path in silicon, the
    guest driver would work unchanged via vhost-vdpa-device-pci (no
    QEMU device code needed).

The guest driver is the same in all three cases. It submits verbs
through virtqueues, completely unaware of the backend.

The main idea is that this is basically self-contained (no host RDMA
stack or hardware needed for [1]), it uses standard virtio-pci
transport making it hypervisor-agnostic, and provides RDMA "hardware"
behavior without the actual hardware (compared to rxe/siw which is
RDMA "API" behavior without hardware). Again this is complementary
to rxe/siw and not a replacement.

The follow-up on that is that I hope it could fit naturally into the
vDPA ecosystem alongside virtio-net and virtio-blk as a first-class
offloadable device.

= Design Overview =

Four virtqueues:

  VQ 0 (command)    - resource management: create/destroy PD, MR,
                      CQ, QP, AH. Synchronous request/response.
  VQ 1 (completion) - device returns CQEs to pre-posted driver
                      buffers when operations complete.
  VQ 2 (data-tx)    - driver posts SEND/RDMA WRITE/READ work
                      requests with scatter/gather data.
  VQ 3 (data-rx)    - driver pre-posts receive buffers; device
                      fills them on incoming SEND.

The device maintains full resource state: protection domains, memory
regions with page tables and access keys, QPs with the standard IB
state machine (RESET -> INIT -> RTR -> RTS), and completion queues.

The QEMU device model uses a socket backend for SEND/RECV currently.
A shared-memory backend (ivshmem) would be needed for truly one-sided
RDMA WRITE/READ where the remote CPU is not involved (matches real HCA
DMA behavior). The same shared-memory transport would also be reused
by the VDUSE daemon backend.

QEMU device model currently looks something like this in terms of
structure:

  include/hw/virtio/virtio-rdma.h     - device structs, wire protocol
  hw/virtio/virtio-rdma.c             - resource manager, command VQ,
                                        datapath, completions
  hw/virtio/virtio-rdma-pci.c         - PCI wrapper (boilerplate)
  hw/virtio/virtio-rdma-backend.c     - socket backend

I have a minimally working kernel driver (modeled after
drivers/infiniband/hw/efa/) and a very early draft virtio spec.  I'll
gladly open RFC patches for all three given the general direction of
this make sense to you.

= The vDPA/VDUSE case =

I want to highlight why I believe this matters beyond pure emulation.
The vDPA framework already handles virtio-net and virtio-blk offload to
hardware. virtio-rdma would be the first vDPA-compatible RDMA device
type.

The specific use case for my employer would be DPU-based RDMA. A DPU
(think NVIDIA BlueField) runs a VDUSE daemon that presents a
virtio-rdma device to the host VM. The daemon handles the RDMA control
plane (connection setup, memory registration, key exchange) in
userspace, then programs the DPU's physical NIC for the data plane.
The host VM sees a standard virtio device and uses the standard
virtio-rdma driver (no vendor-specific drivers needed).

If I understand correctly, the vhost-vdpa-device-pci architecture
was designed for exactly that, so RDMA could fit naturally as a device
type after net and block.

VDUSE currently only supports virtio-block (security scoping in
drivers/vdpa/vduse/). Extending it to virtio-rdma would require
kernel patches to whitelist the device type, with appropriate
validation in the virtio-rdma driver to handle untrusted device
input safely.

= Prior work =

I was able to find a few explorations of virtio-RDMA but no prior
effort produced upstream-viable code. Yuval Shaia (Oracle) posted
an RFC in April 2019 with a QEMU device model and kernel driver,
but it only implemented probing and basic ibverbs (no data path nor
progress past RFC v1). The MIKELANGELO/Huawei vRDMA project
(2016-2017) targeted QEMU 2.3 and the OSv unikernel as part of an EU
Horizon 2020 research effort it seems now obsolete.

The most relevant prior work I could find is from Xie Yongji and Wei
Junji at ByteDance, who posted an [RFC v2] to virtio-comment in May
2022 [1] proposing to add RoCE as a VIRTIO_NET_F_ROCE feature extension
to virtio-net (rather than a standalone device type). Their v1 was a
standalone device; the v2 reworked it as a virtio-net extension. They
had working code (kernel driver, QEMU, rdma-core, vhost-user-rdma
backend) but the effort seems to have gone quiet after 2022 with no
v3. Notably, Yongji is also the author of VDUSE itself so I'd really
value his input. I'm proposing a standalone device type rather than a
virtio-net extension because RDMA isn't inherently tied to Ethernet
(InfiniBand exists), it maps more cleanly onto the vDPA offload model
as a separate device, and it avoids burdening virtio-net with RDMA
complexity. But I could be wrong — happy to hear arguments either way.

In addition, very recently, Xiong Weimin posted a vhost-user-rdma/DPDK
concept to netdev (Dec 2025) [2] which takes a different architectural
approach (DPDK-based vhost-user backend); that work seems
complementary but has not produced formal patches.

I CC'd both Yongji and Xiong on this email in case they have opinions.

This series builds on the same virtio-RDMA concept with a complete
data path, modern QEMU/kernel APIs (virtio-1.0, QIOChannel, kernel
6.x ib_device_ops), and a vDPA-native architecture that none of the
prior efforts had.

[1] https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?MessageKey=20912da6-db56-441c-9117-0148b9c86ea5&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226
[2] https://lists.openwall.net/netdev/2025/12/19/13

= Questions for the community =

 1. Does a virtio-rdma device make sense as a direction? I've studied
    virtio-sound and virtio-can as precedents for new device types.

 2. The device is written in C to match existing virtio devices. I saw
    the Rust PCI+DMA bindings are still in progress — should I wait,
    or is C the right choice today?

 3. For the shared-memory backend, I'm planning to use ivshmem. Is
    there a preferred mechanism for zero-copy inter-VM memory sharing
    in QEMU today, or is ivshmem still the way to go?

 4. Any concerns about the virtqueue layout? I split command and
    completion into separate VQs (rather than putting responses
    inline) to allow async completions — similar to how real HCAs
    separate CQ from QP.

 5. For the VDUSE backend path: should the QEMU integration rely on
    the existing generic vhost-vdpa-device-pci, or would a dedicated
    vhost-vdpa-rdma device (like vhost-vdpa-net) be preferred for
    control-plane visibility?

 6. I'm planning to extend VDUSE to support virtio-rdma as a device
    type. Is there ongoing work or discussion about expanding VDUSE
    beyond virtio-block that I should coordinate with?

 7. Would it be ok to use the experimental device ID 0x1045 until
    the OASIS TC assignment?

I'm happy to send the RFC patch series, kernel driver, and spec draft
whenever you'd like to see code.

Thanks,
Serapheim

