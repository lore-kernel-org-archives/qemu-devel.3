Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD51C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woees-0004eA-Qq; Tue, 28 Jul 2026 06:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woeer-0004dv-Gn
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woeeo-0002BQ-Nb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785233009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QxGmlAIJjGy5m7ey4dDKrXyrZriUihqL++HrQYXVi/w=;
 b=h8M6uG/XrEBz4qhMzVq0VYOx/i/9q7BnJm1kd5l6QCEk9en3f8TZ8ZxYbqApLBLdSMzZ6A
 FKFby9Sd/R4A4LVZG0pD++rM/LKut0Enmmr3XVJGAz8M/d+77rQt5f2ZGTm9al5kWvehgt
 JgVNu7s6EScjOmvKSHIiqhTYU7t3uyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-_3OdD_3HPAq-RFgzQXV5jw-1; Tue, 28 Jul 2026 06:03:27 -0400
X-MC-Unique: _3OdD_3HPAq-RFgzQXV5jw-1
X-Mimecast-MFC-AGG-ID: _3OdD_3HPAq-RFgzQXV5jw_1785233006
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495495ad5ddso20443375e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785233006; x=1785837806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QxGmlAIJjGy5m7ey4dDKrXyrZriUihqL++HrQYXVi/w=;
 b=Uq7WgyDXrgFGvVgS3hkuvFAkiaL1PjE9BgHMmwNt/Z4kZyNDAYmADAbC8cnlHR7+KB
 CodyiQyjFOKaNbnjuS4SDM3Ekec1EPvPW6Zfub1kWmGEluemchc6iGOWMNyqStKPiX1g
 9cjISgdpNFA13BHEXfvtuOLDaM2NAuJHnRhkPGxtRNHmgLSBvCNHdzR1ICsxM1ojCIz5
 Jz39lFyRAugumcdWpflgvOvdWXiMj2fsDiCpztuq5MENViXV8e+HWOYlGzotCNAPVrrA
 8RxjtEhGExABEK6xAgpI7JA1kurV35zZUeKcLKHQXsTzg4x+fAs8GyVoW05fCUUFYRnT
 g0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785233006; x=1785837806;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxGmlAIJjGy5m7ey4dDKrXyrZriUihqL++HrQYXVi/w=;
 b=qVybk0oPxCaU8bvJkPu1xOJ8yiZl5HBwbsza9GExz9rM7Es3ues2kXsDv/+HOadHtQ
 T5Jift8aQ2iAvZBdMM/hjKOUuf2Gxn1hwZhLxCgEvf4De9UVP00axxpG1J40iKOzUv+H
 JWqrnMhnQEj6M/t1wYJMnj6nNVUKxXW7JMNJBWgjCc4NHykFTCvxFj+twkKpUeQkA2+E
 g3qPc0LrRf4ddYeaCGI2ZH8CBA1DT67nd2UqCXl0OorzmhDz0FpocZTIHa6zosgBSgrl
 iLNvnjrr2mD0+R3/+oaLqq1fgTtfA5n2PpxvG6MKfdaBu9O7/pbuw7En27sKsuKTEJoB
 IgeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO9EGogTmSD+emUEbcsu9touULVG9ZEfr577vOfpxjKbYV/hxWQA1FJqd0B570TP79jAcNS1ivKHx3@nongnu.org
X-Gm-Message-State: AOJu0YwdKL66HK7lCOViQghRzs7zhBonhd4sF13e6enVZj9VdHWC3+Iz
 i1Bh14VAu7qzNTWT1S/bN/R9rDrhJ92BqHBBf1TeaniKljCPLWzhVK1/PubAZF9BJ/eR4HcYn4u
 5DQY338fJaEbmviWN+gyrJ0NpVrA+y3hHSoeEHqljDZ8MBcwSKAgVB7IX
X-Gm-Gg: AR+sD11RW+FHEBApmI4ufbnyjWpQiYEzcNF9u+gRdaQViaykwvmAWfeg5JZC3Vwlbj3
 NL2LH+V0v9Dp63tW05IVEACE6H1PMc8BYnUggKjklKCkV+rDjIdmqsx10BTzTDBxULPFyJbL7Tr
 SB4PyUrN8q9l4tF4AgtOUsjiH0FwSj9M6bPe8Q2v30aINYw/iVAw+aML8uCPUHnyYfnLqol90Qs
 V80yZagZv6J/mLnu/RiNfcBrOmooepkM+qLnI0D5m+/3Z2I7Rt8csWWQINzFRtPqCUG1//qvHlx
 3SEXKNbuOd3POqXRvkkcBoro9BybJZU6Bj+H2P/OB9SSmv/jRZyO/ajiiUWOmqj1Rj3Q59t+fDJ
 mRntwbcY+5DpUQueMDqfGVdwOk4Wzf2G/S6P236w=
X-Received: by 2002:a05:600c:1d08:b0:496:c249:dd9a with SMTP id
 5b1f17b1804b1-496c641fdd1mr19341715e9.3.1785233005723; 
 Tue, 28 Jul 2026 03:03:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:496:c249:dd9a with SMTP id
 5b1f17b1804b1-496c641fdd1mr19341105e9.3.1785233005118; 
 Tue, 28 Jul 2026 03:03:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm103740985e9.5.2026.07.28.03.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 03:03:24 -0700 (PDT)
Message-ID: <a81d0762-63e9-468e-bd13-5f40e1956225@redhat.com>
Date: Tue, 28 Jul 2026 12:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] igb: Add experimental VF live migration support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <ad1d1648-9bfa-4539-9bbc-86577ccff2c3@redhat.com>
 <e876234f-312a-495c-837b-5cf64195a622@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e876234f-312a-495c-837b-5cf64195a622@rsg.ci.i.u-tokyo.ac.jp>
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

On 7/28/26 07:50, Akihiko Odaki wrote:
> On 2026/07/28 2:35, Cédric Le Goater wrote:
>> Akihiko,
>>
>> On 7/27/26 07:39, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
>>> growing requirement, but real hardware with migration support is
>>> scarce and hard to debug. An emulated device provides a fully
>>> controlled testbed for developing and validating the entire software
>>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>>> QEMU, libvirt - and for tuning complex migration policies such as
>>> downtime convergence. It also serves as an educational reference for
>>> understanding VFIO migration end-to-end, from device state
>>> serialization to dirty page tracking.
> 
> This is another good example of using QEMU as a SR-IOV testbed.
> 
>>>
>>> This series adds an experimental VF live migration interface to the
>>> emulated igb (82576) device. It enables a vfio-pci variant driver
>>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>>> protocol with stop-copy and pre-copy support.
> I suggest looking into virtio-net as an alternative to igb. It would allow avoiding lots of complexities of igb.
> 
>>>
>>> The target scenario is nested virtualization:
>>>
>>>    L0 QEMU (these patches)
>>>      igb PF with x-vf-migration=on
>>>      └── VFs with migration BAR + vendor cap
>>>
>>>    L1 kernel
>>>      igb-vfio-pci variant driver [1]
>>>      translates VFIO migration v2 ioctls → BAR2 MMIO
>>>
>>>    L1 QEMU (stock, unmodified)
>>>      vfio-pci device model, standard migration fd
>>>
>>>    L2 guest
>>>      standard igbvf driver, unaware of migration
>>>
>>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>>> migratable device and uses the normal migration fd path.
>>>
>>> * Design
>>>
>>> The migration interface is exposed through a hidden 64KB PCI BAR
>>> (BAR2) on each VF, discovered via a vendor-specific PCI capability
>>> ("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
>>> machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
>>> RESUMING, PRE_COPY).
>>>
>>> Device state is serialized as a versioned blob of per-VF register
>>> (offset, value) pairs covering control, interrupt, RX/TX queue,
>>> receive address (RA/RA2), etc. plus TX context descriptors and
>>> VFRE/VFTE enable bits. The blob is transferred via DMA through the PF
>>> device, since VFIO owns the VF's IOMMU domain and the variant driver
>>> maps its DMA buffers through the PF.
>>>
>>> Dirty page tracking is implemented with per-range bitmaps maintained
>>> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
>>> descriptor writeback) are instrumented to record touched pages. The
>>> variant driver registers tracked IOVA ranges and queries dirty bitmaps
>>> through a DMA shared buffer, using a single MMIO doorbell
>>> (DIRTY_CTRL=QUERY) per iteration.
>>>
>>> * Caveats
>>>
>>> Patch 1 introduces PCI_BASE_ADDRESS_MEM_ALWAYS_ON, a QEMU-internal
>>> BAR flag that keeps the migration BAR mapped even after VFIO's
>>> Function Level Reset clears PCI_COMMAND_MEMORY.
>>>
>>> The x-vf-migration property is experimental (x- prefix, default off)
>>> and the migration BAR register interface may change.
>>>
>>> The dirty bitmaps are maintained inside the device, which is not
>>> realistic for discrete NICs without on-chip DRAM.
>>>
>>> * Testing
>>>
>>> The target scenario is nested virtualization: L0 runs QEMU with an
>>> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
>>> and an unmodified QEMU, and L2 runs a standard igbvf driver.
>>>
>>> Migration under iperf3 load works correctly: dirty page tracking
>>> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>>> STOP_COPY), and STOP_COPY stays under 250ms.
>>>
>>> * Todo/Ideas
>>>
>>>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>>>       add VMState support for L0 migration (dirty bitmaps, tracking
>>>       engines, migration BAR registers, stats)
> 
> If you have AI assistance, why don't you just add migration blocker? It should be just one prompt away and not more troublesome than leaving this "Todo". ;)
> 
>>>    2. Add PRE_COPY match data validation (magic, version, caps)
>>>    3. Support driver-provided DMA bitmaps per dirty range
>>>       (DIRTY_RANGE_ADDR_LO/HI)
>>>    4. Add QMP/HMP knobs for error injection and capability tuning:
>>>      . Dirty rate throttling: artificial delay or rate limit on DMA
>>>        dirty tracking to simulate different convergence scenarios
>>>      . State blob size inflation: pad the migration blob to stress
>>>        large-state transfers and test DATA_SIZE limits
>>>      . Migration phase timing: expose per-VF counters for time spent
>>>        in each state (PRE_COPY duration, STOP_COPY latency)
>>>      . Hot page simulation: mark specific page ranges as always-dirty
>>>        to test worst-case convergence
>>>      . Error injection: force STATUS error codes, fail DMA transfers,
>>>        corrupt state blobs, mask CAPS bits, etc.
>>>    5. Add qtests for migration state machine transitions, dirty page
>>>       tracking ?
>>>
>>> * Credits
>>>
>>> Alex Williamson suggested the overall approach: a hidden migration BAR
>>> discovered via a vendor-specific PCI capability, the "vf-migration"
>>> device property to gate the feature. Thanks for the ever ongoing
>>> support and valuable discussions throughout these years.
>>>
>>> * AI disclaimer
>>>
>>> The lack of a migration-capable device has been a recurring pain point
>>> for VFIO development over the years, and we hope this proposal
>>> demonstrates the value of having one.
>>>
>>> Claude was used to analyze the IGB PF and VF internal state and
>>> identify the pain points of a working live migration of such devices.
>>> The generated code served as a starting point but *significant* time
>>> was then spent cleaning up, reworking, and shaping it into a clear,
>>> reviewable proposal. As QEMU does not yet accept AI-assisted
>>> contributions, this series is submitted as an RFC.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>> [1] https://github.com/legoater/vfio-pci-extras
>>>
>>> Cédric Le Goater (11):
>>>    pci: Add PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR flag
>>>    igb: Add x-vf-migration property and vendor-specific capability for
>>>      IGBVF
>>>    igb: Add migration BAR with state machine
>>>    igb: Add VF state serialization for live migration
>>>    igb: Add VF post-load fixups for live migration
>>>    igb: Add dirty page tracking for IGBVF migration
>>>    igb: Quiesce VFs on STOP and include PF enable state in migration blob
>>>    igb: Fix post-migration RX ring deadlock
>>>    igb: Send RARP after VF migration to update bridge FDB
>>>    docs: Add igb VF migration testing setup guide
>>>    igb: Add migration statistics registers to VF migration BAR
>>>
>>>   MAINTAINERS                           |    6 +
>>>   docs/system/device-emulation.rst      |    1 +
>>>   docs/system/devices/igb-migration.rst |  313 +++++++
>>>   docs/system/devices/igb.rst           |    6 +
>>>   hw/net/igb_common.h                   |   11 +
>>>   hw/net/igb_core.h                     |    8 +
>>>   hw/net/igb_migration.h                |  201 +++++
>>>   include/hw/pci/pci.h                  |    6 +
>>>   hw/net/igb.c                          |   18 +
>>>   hw/net/igb_core.c                     |  144 ++-
>>>   hw/net/igb_migration.c                | 1194 +++++++++++++++++++++++++
>>>   hw/net/igbvf.c                        |   29 +-
>>>   hw/pci/pci.c                          |    6 +-
>>>   hw/net/meson.build                    |    2 +-
>>>   hw/net/trace-events                   |   20 +
>>>   15 files changed, 1939 insertions(+), 26 deletions(-)
>>>   create mode 100644 docs/system/devices/igb-migration.rst
>>>   create mode 100644 hw/net/igb_migration.h
>>>   create mode 100644 hw/net/igb_migration.c
>>>
>>
>> First thanks for the quick review ! I will recap here :
>>
>> * bisectability, will improve the first patches.
>> * state serialization, the blob management is awful. I was expecting
>>    flames. Yes. it needs a rework. I lack a qbuf-style put/get API. The
>>    contents of the blob need a review. Seems feasible.
>> * relocation between VFs, on my TODO. The code already checks the vfn but
>>    needs tightening and better support.
>> * interrupts bits: will look into it. hopefully, the model "only" needs
>>    to be more precise. This was a difficult aspect of the igb to understand
>>    and I am still learning.
>> * dirty tracking, I worked on 2 different interfaces and some of the code
>>    fell through the cracks. DMA failures, bitmap clearing, size validation,
>>    all need improvements. Mostly addressed already, remaining items are code
>>    reorg. should be fine.
>> * quiesce: looks like a bug in the model. Will check.
>> * RARP : I got inspiration from the tests. you are right saying it belongs
>>    to the management layer. Keeping it for now as it simplifies testing, but
>>    will move it out.
>> * Stats: the addition is from yesterday. Needs fixes indeed.
> 
> Thanks for the summary. Well, the "AI disclaimer" states that you spent significant time on cleanup, but your recap highlights several critical issues.

The issues are mostly related to the IGB VF state. It was expected.
Dirty tracking issues reflect my various attempts of using MMIOs and
shared buffer. The rest are bugs :)

As for AI, yes, I find it useful to draft code, but really, it
requires a lot of directions and control. At the end, some parts
are not elegant or just wrong for some reasons. I don't trust the
output.

Where it is really good at, and where it saved me a lot of time,
is in analyzing QEMU and kernel logs of the L0/L1/L2 software stack.
Extracting the relevant info, correlating events, doing the timing
analysis, adding/removing logs. I did similar work in the past on
nested PPC emulation, and it was a painful and time-consuming process
without this kind of assistance.

Once the core debug is done, you can use it to produce python
scripts to automate the process and use that for the follow ups.
> 
> Ideally, AI assistance should minimize manual labor while keeping quality high. > Right now, the workflow seems inverted: the AI created the basic scaffolding, you spent significant time reworking it, 
> yet critical flaws not mentioned in the "Caveats" and "Todo/Ideas" sections still remain. I believe we can do better with AI assistance.

Your review uncovered several important issues in the interrupt
handling that I hadn't expected Claude (Opus 4.6) to miss.
  
> In fact, I am part of the Codex for Open Source program and use GPT-5.6 Sol Ultra extensively for reviews. It is quite effective at raising quality while cutting down manual effort. Most of the comments I provided came directly from Codex using a simple prompt: "review each commit." The model somehow possesses a latent understanding of QEMU requirements, allowing it to flag issues like bisectability breaks and lack of L0/L1/L2 boundary enforcement.

All were good findings.

> I expect that iterating with prompts like "review each commit" and "fix these issues" would automatically resolve most of these problems, reducing error-prone human intervention. I am not sure if Claude has the same depth of virtualization-specific knowledge, but even if it doesn't, you can feed your recap back into the model to let it handle the heavy lifting.

yes. I will try to fix most of the issues with the current model
before moving the the next version.

> Moving forward, I see two potential directions for this work:
> 
> - Focus on high-level design: Explore alternative architectures like hacking virtio-net SR-IOV or keeping RARP out of QEMU. You could send the results as a fresh RFC while openly noting the rough edges. This allows us to discuss the design architecture without spending massive effort polishing the implementation details.

Alex proposed good directions for a new HW implementation. I will
keep the igb vf as a target for now. Hopefully, I will have time
to fix the igb vf serialization and the interrupt handling for
better support. All issues seems feasible. Takes time.

virtio-net SR-IOV could be next.

As for RARP, yes. I will add a disclaimer saying that we need it
for tests. It's a extra patch any how.

  
> - Focus on code quality and advocacy: Burn more tokens to improve the code quality. Use this series as a concrete case study to demonstrate that AI assistance can successfully implement complex virtualization features. This could help shift project policy regarding AI usage and pave the way for upstreaming this and future AI-assisted patches.

Yes. that's one aspect.

Regarding the VFIO subsystem, improving testing is necessary and
it won't happen without a complex framework that people can use.

> 
> Whichever direction you choose, reframing the narrative in the cover letter will better align the series with the project's goals.
It's upstream first of course :)

Thanks,

C.



