Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD13FCC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWoG-000684-De; Tue, 13 Oct 2026 03:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGWoC-00067o-09
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGWo7-00008P-QV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791876018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+ff6djx7gf23dJQubUm/ShBo5YOo3eicU9p7gFhru70=;
 b=DknMfGFfQ+tobnafAjduX7fclUERDz/t01TxIzPlLerWR0BOSGuQHQLI1hN7ORpjLCBvfH
 5I8AQ14cmQl4eIaIKE1q3pUfM3TphWvuwqwt101unSIqXvoKyxZYYNOqG3aH8yxsqnDPu6
 hC7J6h7e6QC0x2Nbe+zxcJv8DVUeCkE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-A7wlMorRM5e-OnTDenQseA-1; Tue, 13 Oct 2026 07:20:11 +0000
X-MC-Unique: A7wlMorRM5e-OnTDenQseA-1
X-Mimecast-MFC-AGG-ID: A7wlMorRM5e-OnTDenQseA_1791876010
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso30655855e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791876010; x=1792480810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+ff6djx7gf23dJQubUm/ShBo5YOo3eicU9p7gFhru70=;
 b=DIBsnMlAxrWHSvsSF5dYKHOfRzJlQuBn2tYZEB23HTTMsYojLhUuLHePquMBa7SDNn
 YjFZY/r35tq8HuYQRTSF2YRXL9Rzg6XXCRNogXNyI//WZYlSGIIkHNYFSwaoHZK8Uxly
 bxQv/qtXULKgGpV7dbj9i6uW+zgm+AI7ZbCffMKhZ3pN4MiMASFKi7DGALu/KwcnE10W
 dH2SUKG9jMRmGP7HIwVdU02/mBblevVLGqcXhMKIh/XysjO44rFJQGTNcLQ7vP54Uimq
 7tSOs6VuZSGzikeH08cqxdguNJ0tbEjsg3Ug6JDxnzyInQM0TonCEXe98wqs1ShohFy7
 H2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791876010; x=1792480810;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+ff6djx7gf23dJQubUm/ShBo5YOo3eicU9p7gFhru70=;
 b=E2LmmT4rvi5zxnLffPFjfLQ9u8w8SDAa6N6mi41hXDjOoyntbZ2OIL8QxbuMVxSmAz
 /VaOC7qu2uEqzeyOE54v2abV+Wtf0qDVGnK7CKhZWPAqjPYwRBCqCy/7a+KXA+/dxf0B
 wyzW4dIMsBP98dTUsTp88a8OvekiqIIDXP4Xt4xmLdFQBqCuR91TvAh0juH4ZV0lidbi
 7BWMtIUL55QYAmbnKSmwVsytqZKv/KA5QynfqxrJAa0PurPk7HchaINeaGyW58rcyvJR
 M/vRbjH9rovnUZ4hQrqKqYG5PiPu9OalMWAwjxavbdvBOZjtvR8WOLOAL5owEdiGg7cZ
 0Mgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0WoRb11Q4GuLFAZkvZy7hOtqtYb1qJcfOna/MtX1Gs6wj2KtNgMZBUObp73npAIgjLTADbeBU+gPb@nongnu.org
X-Gm-Message-State: AFq9FYLH9FoGvZOGrSmIA/jn08DGkr3EyvrDejIo85/HtpWVg6NgqM+o
 h6EJz9dcBlHbTrKE2Syx0PJPI7oxMk5o4cCAyOreN6cO7/cbskPGxVPyXlrccC/8S05Qor2Edpu
 +Q8QFqdVpGnki+zZ64x/6c5EBjcme5zMht7Tg0fwyBU5E63/9H8LhcdCA
X-Gm-Gg: AYBFou1GslZQfQHEizngPEetMObFQ/AM08L0WPwN+q32Q+awNx8/aEEBlIknE4su+m+
 O9/tLwIT5kupKarg1FezaOGi8uWZViVWzfwWfunVqivDS9HFUhPJp0WypkQslu93LE3ActGYFwO
 KONom8vHnYgIpACQ8jXsYT+U5LT7mWWvYxrbKqZVi2zZYQA3wvPhXnFu6gHKX3pCo86KgGBRVni
 jLs9CWCe2UDmCKPHgbxR4hNswS2s7lb5veMbJT1I7AdYmeA7pnTz+NOeAyWnbDvAzXKTZfRV6Ar
 8I3wDbR1mpDTQ6p3dcaFs+OuaExKNLQXbFFWZS2kCa97RLB3dM2u4AhIJ2nfva+OIke3D14eXjQ
 iFjrFDqezn+9IM2R8BFnLmXWuTHAtWeIUMtVatM94
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id
 5b1f17b1804b1-4a1a475d8acmr59327025e9.34.1791876009453; 
 Tue, 13 Oct 2026 00:20:09 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id
 5b1f17b1804b1-4a1a475d8acmr59326315e9.34.1791876008854; 
 Tue, 13 Oct 2026 00:20:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab506bsm3949235f8f.27.2026.10.13.00.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 00:20:08 -0700 (PDT)
Message-ID: <34a84565-bb0e-4e6b-b5dc-480c2990740e@redhat.com>
Date: Tue, 13 Oct 2026 09:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] igb: Add experimental VF live migration support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <341bf6d3-27e4-425e-a0b1-0e3767e2db99@rsg.ci.i.u-tokyo.ac.jp>
 <73fe443f-0acd-41b0-a9ca-259f88f0ff88@redhat.com>
 <fd08029a-4822-4ccc-8033-a981b8ddbbe3@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fd08029a-4822-4ccc-8033-a981b8ddbbe3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Akihiko,

I finally found the time to address the comments from your review.
Some more replies below.


On 9/17/26 21:49, Akihiko Odaki wrote:
> On 2026/09/15 17:20, Cédric Le Goater wrote:
>> On 9/9/26 09:19, Akihiko Odaki wrote:
>>> On 2026/09/03 4:20, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
>>>> growing requirement, but real hardware with migration support is
>>>> scarce and hard to debug. An emulated device provides a fully
>>>> controlled testbed for developing and validating the entire software
>>>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>>>> QEMU, libvirt - and for tuning complex migration policies such as
>>>> downtime convergence. It also serves as an educational reference for
>>>> understanding VFIO migration end-to-end, from device state
>>>> serialization to dirty page tracking.
>>>>
>>>> This series adds an experimental VF live migration interface to the
>>>> emulated igb (82576) device. It enables a vfio-pci variant driver
>>>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>>>> protocol with stop-copy and pre-copy support.
>>>>
>>>> The target scenario is nested virtualization:
>>>>
>>>>    L0 QEMU (these patches)
>>>>      igb PF with x-vf-migration=on
>>>>      └── VFs with migration DVSEC
>>>>
>>>>    L1 kernel
>>>>      igb-vfio-pci variant driver [1]
>>>>      translates VFIO migration v2 ioctls → DVSEC config writes
>>>>
>>>>    L1 QEMU (stock, unmodified)
>>>>      vfio-pci device model, standard migration fd
>>>>
>>>>    L2 guest
>>>>      standard igbvf driver, unaware of migration
>>>>
>>>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>>>> migratable device and uses the normal migration fd path.
>>>>
>>>> * Design
>>>>
>>>> The migration interface is exposed through a DVSEC (Designated
>>>> Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
>>>> 0x160 in VF extended config space. The DVSEC uses a command doorbell
>>>> model - all commands are synchronous via PCI config space writes.
>>>>
>>>> Device state is serialized as a versioned blob of per-VF register
>>>> (offset, value) pairs covering control, interrupt, RX/TX queue,
>>>> receive address (RA/RA2), etc. plus TX context descriptors and
>>>> VFRE/VFTE enable bits. The buffer address is a guest physical
>>>> address (GPA) written by the driver via virt_to_phys; the device
>>>> accesses guest RAM directly through the system address space.
>>>>
>>>> Dirty page tracking is implemented with per-range bitmaps maintained
>>>> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
>>>> descriptor writeback) are instrumented to record touched pages. The
>>>> variant driver registers tracked IOVA ranges and queries dirty bitmaps
>>>> through a shared buffer. Buffer structures include len, flags, and
>>>> reserved fields for future extensibility.
>>>>
>>>> * Caveats
>>>>
>>>> The x-vf-migration property is experimental (x- prefix, default off).
>>>>
>>>> The dirty bitmaps are maintained inside the device, which is not
>>>> realistic for discrete NICs without on-chip DRAM.
>>>>
>>>> * Testing
>>>>
>>>> The target scenario is nested virtualization: L0 runs QEMU with an
>>>> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
>>>> and an unmodified QEMU, and L2 runs a standard igbvf driver.
>>>>
>>>> Migration under iperf3 load works correctly: dirty page tracking
>>>> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>>>> STOP_COPY), and STOP_COPY stays under 250ms.
>>>>
>>>> * Todo
>>>>
>>>>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>>>>       add VMState support for L0 migration (dirty bitmaps, tracking
>>>>       engines, DVSEC registers, stats)
>>>>    2. Add PRE_COPY state transfer to validate device INIT data (magic,
>>>>       version, etc.)
>>>>    3. Add qtests for migration state machine transitions, dirty page
>>>>       tracking ?
>>>>
>>>> * Ideas
>>>>
>>>>    1. RX bandwidth throttle (x-mig-rx-limit, uint32, default 0)
>>>>
>>>>       Return false from can_receive when the per-VF packet count in the
>>>>       current tracking interval exceeds the limit. Reduces DMA writes
>>>>       and dirty pages realistically.
>>>>
>>>>    2. Migration phase timing (GET_STATS extension)
>>>>
>>>>       Add per-VF timestamps: precopy_start_ns, stopcopy_start_ns,
>>>>       precopy_duration_ns, stopcopy_duration_ns,
>>>>       state_transition_count. Expose via GET_STATS.
>>>>
>>>>    3. Hot page simulation (x-mig-hot-pages, uint32, default 0)
>>>>
>>>>       Re-set the first N bitmap bits after each DIRTY_QUERY, simulating
>>>>       workloads with hot pages that prevent convergence.
>>>>
>>>>    4. Error injection (x-mig-inject-error, uint32, default 0)
>>>>
>>>>       One-shot error code injection before command dispatch. A separate
>>>>       x-mig-inject-dma-fail (bool) for persistent DMA failure testing.
>>>>
>>>> * Credits
>>>>
>>>> Alex Williamson suggested the overall approach of a variant driver
>>>> with the "x-vf-migration" device property to gate the feature. Thanks
>>>> for the ever ongoing support and valuable discussions throughout these
>>>> years.
>>>>
>>>> * AI disclaimer
>>>>
>>>> The lack of a migration-capable device has been a recurring pain point
>>>> for VFIO development over the years, and we hope this proposal
>>>> demonstrates the value of having one.
>>>>
>>>> Claude was used to analyze the IGB PF and VF internal state and
>>>> identify the pain points of a working live migration of such devices.
>>>> The generated code served as a starting point but *significant* time
>>>> was then spent cleaning up, reworking, and shaping it into a clear,
>>>> reviewable IGB model extension.
>>>>
>>>> As QEMU does not yet accept AI-assisted contributions, this series is
>>>> submitted as an RFC.
>>>
>>> This largely repeats the concerns I raised previously [1]. Your description of the *significant* time spent cleaning up and reworking the generated code suggests that this series is intended for upstream inclusion once the implementation direction is agreed. 
>>
>> Yes. The IGB kernel vfip-pci variant driver is "ready", and so is the
>> internal test framework for VFIO migration. The emulated IGB device
>> is also becoming increasingly important as a reference device for
>> the kernel VFIO self-tests. See:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ commit?id=1583ef1175ba533e326dfeff6d8b9f3aaf761225
>>
>>> My concerns as a maintainer are therefore correctness and maintainability.
>>
>> I am trying to avoid too much intrusion in the core igb model :
>>
>>   hw/net/igb_common.h                   |   16 +
>>   hw/net/igb_core.h                     |   11 +
>>   hw/net/igb.c                          |    7 +
>>   hw/net/igb_core.c                     |  124 ++-
>>   hw/net/igbvf.c                        |   52 +-
>>
>> These are mostly code movement or additions. The runtime is hardly
>> impacted apart from the DMA tracking, which adds one indirection.
>>
>> I have added myself as Maintainer for the migration part :
>>
>>    +igb VF migration
>>    +M: Cédric Le Goater <clg@redhat.com>
>>    +S: Maintained
>>    +F: hw/net/igb_migration.*
>>
>> I can add you in the next respin. That would be a natural choice
>> from my perspective, but I don't want to impose it on you.
> 
> My concern about maintainability is not primarily the line count in igb_core.c, but the correctness of the architecture as a whole.
> 
> The migration layer inherently depends on deep assumptions about the core device model. For example, my feedback on this version highlighted dependencies on RA handling, VLAN filtering, and the interrupt state machine. Moving migration logic into a separate file isolates the file footprint, but it does not remove these underlying functional dependencies.
> 
>>> The missing migration blocker is a concrete example: it is a basic correctness issue that should be straightforward to address, yet it remains a TODO. 
>>
>> yes. It's identified and easy to address. It can come at the end once
>> all other issues have been discussed. What worries me the most is the
>> control plane : interface with the Linux driver. That is the most
>> important part on which these changes depend on getting it right :
>>
>>    https://github.com/legoater/linux/commits/vfio/
> 
> That makes sense. If the immediate goal is to review the control plane interface while save/load state remains incomplete, it would help to explicitly state that scope in the cover letter, along with the current limitations in implementation and testing.
> 
>>
>>> My comments on individual patches also raise the same kinds of issues I pointed out in the previous version.
>>
>> You're being tough on me ! I did all this fixing below ! :)
>>
>> * Changes since rfc-v1
>>
>>    - Migration BAR replaced with DVSEC at offset 0x160 (no BAR needed)
>>    - Wire-format structs (IgbMigBlob, IgbMigRegPair, IgbMigTxCtx)
>>      replace raw pointer arithmetic and memcpy
>>    - RA entries separated from fixed regs, scanned by pool bit
>>    - VFN relocation support (offset remapping + RA pool bit swap)
>>    - GPA buffer (address_space_read/write) replaces PCI DMA through PF
>>    - State blob validation on load (magic, version, error codes)
>>    - NEED_WORDS macro and igb_vf_offset_valid removed
>>    - Error codes renumbered: removed BAD_VFN, added UNK_CMD (1-11)
>>
>>    Reported by Akihiko Odaki:
>>
>>    - propagate_irqs: clear VF bits before OR (EIMS/EIAC/EIAM)
>>    - propagate_ivar: clear IVAR entry when source VTIVAR is invalid
>>    - rearm_irqs: restore actual PVTEICR causes, not all three
>>    - Dirty bitmap allocation uses BITS_TO_LONGS (heap corruption fix)
>>    - Dirty query validates range before g_malloc0 (memory exhaustion)
>>    - Dirty bits cleared only after successful bitmap DMA write
>>    - Dirty query buffer uses struct offsets (layout mismatch fix)
>>    - Load path: register offsets validated against VF whitelist
>>    - VMBMEM (mailbox payload) documented as transient, not serialized
>>    - dma_writes counter: consistently uint64_t
>>    - Dirty range_size: consistently uint64_t (was truncated to 32 bits)
>>    - ERROR->STOP: quiesce VF (clear VFRE/VFTE) on transition
>>    - rearm_irqs: runs on re || te, not just re (TX-only VF fix)
>>    - Stats DMA-written atomically via GET_STATS (no split MMIO tear)
>>    - Bisectability: DVSEC + state machine introduced together
>>    - Removed NAPI reference and "===" comment decoration
> 
> I appreciate the progress, and I certainly don't mean to minimize the effort put into fixing these issues.
> 
> However, many of these bugs stem from the same root cause: high-level systemic requirements, such as boundary checks, VF renumbering, interrupt state preservation, and OS-independence, are being addressed piecemeal as individual bugs arise. I would like to see these requirements enforced systematically across the entire implementation rather than patched reactively. Replacing raw pointers with explicit wire-format structures across the protocol is a great example of the kind of systematic fix I mean.



The v3 series enforces these requirements structurally. The migration
blob uses a typed wire-format struct. Load is two-phase: the blob is
validated before any core state is modified, so a malformed blob does
not leave the device partially updated. VFN mismatch is rejected.
Interrupt mask bits are captured from the PF aggregates before quiesce.


>>>
>>> Many of the correctness problems found in v1 and v2 stem from the choice to build on igb, which is more complex than virtio-net. That is why I suggested using virtio-net as a simpler basis, unless there is a problem that rules it out.
>>
>> virtio-net is a software abstraction designed for virtualization.
>>
>> Here’s my pitch for igb:
>>
>> Using an emulated igb device addresses a different problem: validating
>> migration of hardware-like devices. igb exposes a real PCI device
>> model, hardware-driver interface, DMA engines, queues, interrupts and
>> SR-IOV VFs. It allows migration to be implemented at the same
>> abstraction boundary at which VFIO migrates physical devices, rather
>> than being reduced to serialization of a paravirtualized protocol
>> state. Also,
>>
>> The igb VF uses the inbox igbvf kernel driver, which matches the
>> hardware VFIO promise: transparent migration with unmodified guest
>> drivers.
>> The DVSEC extended capability is a discoverable and standard control
>> plane with the device. This is a mechanism a hardware vendor could
>> use.
>> One cool aspect of an emulated device is that it allows the state to
>> be inspected, the behavior is deterministic and faults can be injected
>> at any boundary. That's the QEMU bonus.
> 
> I understand the motivation to test hardware-like device migration. However, modern virtio-net devices are also implemented in physical SmartNICs/DPUs and expose standard PCI interfaces, BARs, DMA engines, queues, interrupts, and SR-IOV VFs.
> 
> Using virtio-net as a VFIO test device would not require guest driver changes or bypass hardware-like semantics. Given its cleaner separation of state, it remains a strong fit for these testing requirements without carrying igb's extra complexity.


virtio-net already has a clean migration path via its own protocol.
The goal here is different. igb models a real hardware interface that
mirrors what VFIO migration must handle with physical devices.
virtio's cleaner separation is an advantage for production, but it
doesn't exercise the same problems.


> 
>>
>>> I would be willing to support allowing AI use in the project for work like this. I would still need to see these correctness and maintainability concerns addressed before I could support merging the series.
>>
>> I agree. The save/load is still in progress and we might need some
>> more intrusive changes in igb to support migration of all state.
>> To start with, we could detect and warn.
> 
> Starting with a restricted set of supported configurations is a reasonable way forward. However, for features whose state cannot yet be restored accurately, we should reject migration rather than merely issue a warning. Otherwise, a completed migration risks silently corrupting guest-visible device behavior.


Reject was the approach taken in v3. However, I made the choice to
fixup the MTA/UTA table. Restore widens the receive filter (OR missing
entries), never drops existing ones. The worst case is a few extra
frames that the guest stack would have discarded. Rejecting migration
over transient IGMP/mDNS differences would be disproportionate.


> 
> This is another advantage of virtio-net: feature negotiation offers a clean, standard mechanism to disable unsupported features and define a tightly constrained initial scope that is fully migratable.


virtio feature negotiation is a software construct. The DVSEC CAPS
register models the mechanism a hardware vendor would actually use to
advertise migration capabilities. Not as rich as virtio, but closer to
real hardware.


I understand your preference for virtio-net. I think igb and virtio-net
test different aspects of device migration and are complementary. Anyhow,
your reviews have significantly improved the robustness of this series.
Many of the improvements came from addressing your feedback. The DVSEC
interface and the two-phase validation pattern are not igb-specific and
they could be reused for other emulated devices.

I plan to send an RFC v3 shortly. If there are remaining technical
concerns, I'm happy to address them.

Thanks,
C.


