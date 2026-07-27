Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E540FC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woPF4-0001SU-SF; Mon, 27 Jul 2026 13:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woPEt-0001S2-RS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woPEr-0003iL-H0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785173740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUgExyhfsCw38P4tG6J27CMxDFNXJXw8wj+sjyMXnJk=;
 b=D4m1OeERHJUaUozToOTN1wQs37zymMFT33hboXcMr/zatYlb+Nb7FntzKOg85SAxkXRhI7
 QffyEF8TRK/842SufvlG02SkBjIE5omcAT9Ki+HeY0Ko/l6ibTznsRY9BqrZz0JrRQ6cQ0
 Nfu0/AAdUOuZPKP2tGWDwYza3i95s7M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-O_L1OnR7Nlu5o07j20ZQPA-1; Mon, 27 Jul 2026 13:35:38 -0400
X-MC-Unique: O_L1OnR7Nlu5o07j20ZQPA-1
X-Mimecast-MFC-AGG-ID: O_L1OnR7Nlu5o07j20ZQPA_1785173737
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49544a639e9so15795155e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785173737; x=1785778537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AUgExyhfsCw38P4tG6J27CMxDFNXJXw8wj+sjyMXnJk=;
 b=AKaiu/UpIns7ugSsZMDKXO7MbmbeAxm907c6si7Gz+vy5bv0kIcIeRxo+UtzSMaeHo
 6Lm5WF0hBU7XLqb1cF/LYjNekNfFCjZGryR7ijH4jme5+IuNjbH2bTrpkWYZ4fO5gw3Y
 /8bne4wDVqdnxeYekExcI4KmSRkfKdehrZUIyZngHeHBRGyf/hOqCZyz7CaMLXPPTNZs
 W03scR+BvdxqjvY7bAOmcPen1vhoDW81V9N9BULnd8X76PmR1DxakEMk21MSKlgrUmht
 yRZoYj/VVzFHnvHnJ6eZaXfg8pHsYbKR565rBoeFLPvKB3B1fIEN/1zxwwQMOOGYb9VD
 ww+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173737; x=1785778537;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUgExyhfsCw38P4tG6J27CMxDFNXJXw8wj+sjyMXnJk=;
 b=OZpHAjeo3mPdtgDrrYuWRKPju/+hcRcXwwLAUSWSbvIFQLo9kcpNfFJIeqHu58Ud3E
 GA3L430YCBPN9HFdKu6q+JvBa8lza8goNc0lPf5Cd7LmtIPEzF4WYXm/+i8fwQUXN5h0
 eyBJYeEjoimrMnvSG5a6VpcOavb6Xjxz5vl2XgZWwyf5RsOgU0FcHIv1H2sH05YyH9P7
 neix6thVcTPwljVkEt3ibc2nVq9o6NWW+x5/oLNt5Nd93mXwnQdaLHMGhLBRCbGef3z3
 9p5B/aMrDiM/KmRUV6cDJalTZwnmJMsN1YX1/XT0AujSOy2N20I6xfOYlxhYKaJ8uRqf
 7nXw==
X-Gm-Message-State: AOJu0YxAJBWJoi/A+h5vjl8agaGon0D11a7mbHkBkkBsH6AKt/ZW6EDp
 dveXLEb3qkt6tsXMKhgbQIjK3apuD1SVpXacMJ7aJBpszXk9b5btaPaGOoa22LBYY7c9jJAw0Tm
 5g9ouFdryStMoIm36eNdVHiZ4MDPuTUR9oBfb5sEKBaTkZk1S74cj7mNjCRDyd0riFRwv2mV8sP
 8RhLOU6lCCGhxRqYtNPnyygBof4u6udFHzUQ==
X-Gm-Gg: AR+sD13f187OVpq9SJsJXNqMO7bT8xG0GltK+xLJmSqd25XAewJZHCHGXrO9W2zXFD1
 ECgoN0CKablmTuXj2x+f7b9TyNgHPrI5DrPngCC7hklvHJ1iQEJ563fGkvVIysQcXfdVM4Qeqe+
 Dvdgc6TYF9VoABcxtJJbMF53lcZdCQYoenPx+AmvU2aWFI4FTgFp/XUxslsP5Nl6eNJPlByxYfy
 V6ZLSlefy6d0dAHwqGK7H2Xri9N9mXgXhu8W0n5nQhMsPsUOQSoJDyj1nl7qC4G2p8BQ4HCnfrF
 wC3EUScnzCIslTNYrK5bzC8tlJuDnLqhZWi9rrM8CVWByd07UNonhTdIC/BRRbw/Bs8S00+NZ/2
 oRDRNZuYT5s5tylLXHP1Okt5m4zaEykBXPpiJz18=
X-Received: by 2002:a05:600c:a46:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-496b5717865mr127412065e9.15.1785173737393; 
 Mon, 27 Jul 2026 10:35:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a46:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-496b5717865mr127411645e9.15.1785173736837; 
 Mon, 27 Jul 2026 10:35:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c76sm7586075e9.6.2026.07.27.10.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 10:35:36 -0700 (PDT)
Message-ID: <ad1d1648-9bfa-4539-9bbc-86577ccff2c3@redhat.com>
Date: Mon, 27 Jul 2026 19:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] igb: Add experimental VF live migration support
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Akihiko,

On 7/27/26 07:39, Cédric Le Goater wrote:
> Hello,
> 
> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
> growing requirement, but real hardware with migration support is
> scarce and hard to debug. An emulated device provides a fully
> controlled testbed for developing and validating the entire software
> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
> QEMU, libvirt - and for tuning complex migration policies such as
> downtime convergence. It also serves as an educational reference for
> understanding VFIO migration end-to-end, from device state
> serialization to dirty page tracking.
> 
> This series adds an experimental VF live migration interface to the
> emulated igb (82576) device. It enables a vfio-pci variant driver
> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
> protocol with stop-copy and pre-copy support.
> 
> The target scenario is nested virtualization:
> 
>    L0 QEMU (these patches)
>      igb PF with x-vf-migration=on
>      └── VFs with migration BAR + vendor cap
> 
>    L1 kernel
>      igb-vfio-pci variant driver [1]
>      translates VFIO migration v2 ioctls → BAR2 MMIO
> 
>    L1 QEMU (stock, unmodified)
>      vfio-pci device model, standard migration fd
> 
>    L2 guest
>      standard igbvf driver, unaware of migration
> 
> The L1 QEMU is completely unmodified -- it sees a standard VFIO
> migratable device and uses the normal migration fd path.
> 
> * Design
> 
> The migration interface is exposed through a hidden 64KB PCI BAR
> (BAR2) on each VF, discovered via a vendor-specific PCI capability
> ("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
> machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
> RESUMING, PRE_COPY).
> 
> Device state is serialized as a versioned blob of per-VF register
> (offset, value) pairs covering control, interrupt, RX/TX queue,
> receive address (RA/RA2), etc. plus TX context descriptors and
> VFRE/VFTE enable bits. The blob is transferred via DMA through the PF
> device, since VFIO owns the VF's IOMMU domain and the variant driver
> maps its DMA buffers through the PF.
> 
> Dirty page tracking is implemented with per-range bitmaps maintained
> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
> descriptor writeback) are instrumented to record touched pages. The
> variant driver registers tracked IOVA ranges and queries dirty bitmaps
> through a DMA shared buffer, using a single MMIO doorbell
> (DIRTY_CTRL=QUERY) per iteration.
> 
> * Caveats
> 
> Patch 1 introduces PCI_BASE_ADDRESS_MEM_ALWAYS_ON, a QEMU-internal
> BAR flag that keeps the migration BAR mapped even after VFIO's
> Function Level Reset clears PCI_COMMAND_MEMORY.
> 
> The x-vf-migration property is experimental (x- prefix, default off)
> and the migration BAR register interface may change.
> 
> The dirty bitmaps are maintained inside the device, which is not
> realistic for discrete NICs without on-chip DRAM.
> 
> * Testing
> 
> The target scenario is nested virtualization: L0 runs QEMU with an
> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
> and an unmodified QEMU, and L2 runs a standard igbvf driver.
> 
> Migration under iperf3 load works correctly: dirty page tracking
> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
> STOP_COPY), and STOP_COPY stays under 250ms.
> 
> * Todo/Ideas
> 
>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>       add VMState support for L0 migration (dirty bitmaps, tracking
>       engines, migration BAR registers, stats)
>       
>    2. Add PRE_COPY match data validation (magic, version, caps)
>    
>    3. Support driver-provided DMA bitmaps per dirty range
>       (DIRTY_RANGE_ADDR_LO/HI)
>       
>    4. Add QMP/HMP knobs for error injection and capability tuning:
>    
>      . Dirty rate throttling: artificial delay or rate limit on DMA
>        dirty tracking to simulate different convergence scenarios
>      . State blob size inflation: pad the migration blob to stress
>        large-state transfers and test DATA_SIZE limits
>      . Migration phase timing: expose per-VF counters for time spent
>        in each state (PRE_COPY duration, STOP_COPY latency)
>      . Hot page simulation: mark specific page ranges as always-dirty
>        to test worst-case convergence
>      . Error injection: force STATUS error codes, fail DMA transfers,
>        corrupt state blobs, mask CAPS bits, etc.
>        
>    5. Add qtests for migration state machine transitions, dirty page
>       tracking ?
> 
> * Credits
> 
> Alex Williamson suggested the overall approach: a hidden migration BAR
> discovered via a vendor-specific PCI capability, the "vf-migration"
> device property to gate the feature. Thanks for the ever ongoing
> support and valuable discussions throughout these years.
> 
> * AI disclaimer
> 
> The lack of a migration-capable device has been a recurring pain point
> for VFIO development over the years, and we hope this proposal
> demonstrates the value of having one.
> 
> Claude was used to analyze the IGB PF and VF internal state and
> identify the pain points of a working live migration of such devices.
> The generated code served as a starting point but *significant* time
> was then spent cleaning up, reworking, and shaping it into a clear,
> reviewable proposal. As QEMU does not yet accept AI-assisted
> contributions, this series is submitted as an RFC.
> 
> Thanks,
> 
> C.
> 
> [1] https://github.com/legoater/vfio-pci-extras
> 
> Cédric Le Goater (11):
>    pci: Add PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR flag
>    igb: Add x-vf-migration property and vendor-specific capability for
>      IGBVF
>    igb: Add migration BAR with state machine
>    igb: Add VF state serialization for live migration
>    igb: Add VF post-load fixups for live migration
>    igb: Add dirty page tracking for IGBVF migration
>    igb: Quiesce VFs on STOP and include PF enable state in migration blob
>    igb: Fix post-migration RX ring deadlock
>    igb: Send RARP after VF migration to update bridge FDB
>    docs: Add igb VF migration testing setup guide
>    igb: Add migration statistics registers to VF migration BAR
> 
>   MAINTAINERS                           |    6 +
>   docs/system/device-emulation.rst      |    1 +
>   docs/system/devices/igb-migration.rst |  313 +++++++
>   docs/system/devices/igb.rst           |    6 +
>   hw/net/igb_common.h                   |   11 +
>   hw/net/igb_core.h                     |    8 +
>   hw/net/igb_migration.h                |  201 +++++
>   include/hw/pci/pci.h                  |    6 +
>   hw/net/igb.c                          |   18 +
>   hw/net/igb_core.c                     |  144 ++-
>   hw/net/igb_migration.c                | 1194 +++++++++++++++++++++++++
>   hw/net/igbvf.c                        |   29 +-
>   hw/pci/pci.c                          |    6 +-
>   hw/net/meson.build                    |    2 +-
>   hw/net/trace-events                   |   20 +
>   15 files changed, 1939 insertions(+), 26 deletions(-)
>   create mode 100644 docs/system/devices/igb-migration.rst
>   create mode 100644 hw/net/igb_migration.h
>   create mode 100644 hw/net/igb_migration.c
> 

First thanks for the quick review ! I will recap here :

* bisectability, will improve the first patches.
* state serialization, the blob management is awful. I was expecting
   flames. Yes. it needs a rework. I lack a qbuf-style put/get API. The
   contents of the blob need a review. Seems feasible.
* relocation between VFs, on my TODO. The code already checks the vfn but
   needs tightening and better support.
* interrupts bits: will look into it. hopefully, the model "only" needs
   to be more precise. This was a difficult aspect of the igb to understand
   and I am still learning.
* dirty tracking, I worked on 2 different interfaces and some of the code
   fell through the cracks. DMA failures, bitmap clearing, size validation,
   all need improvements. Mostly addressed already, remaining items are code
   reorg. should be fine.
* quiesce: looks like a bug in the model. Will check.
* RARP : I got inspiration from the tests. you are right saying it belongs
   to the management layer. Keeping it for now as it simplifies testing, but
   will move it out.
* Stats: the addition is from yesterday. Needs fixes indeed.

Thanks,

C.


