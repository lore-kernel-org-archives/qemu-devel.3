Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E7CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclAQ-0005X5-K4; Thu, 25 Jun 2026 10:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wclAO-0005Wx-Gq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wclAM-0003YM-4q
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782398091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcJvSo+yM44IPJq/8/t8uHpdYZSMjkd8xx/hVTQZCgY=;
 b=L/xtnFlXhFA9atYWVUXm6x7BpnJ01Xu07xvBHFc2xMB5C32dV/5hnvLkDdIBBGoFAqEdyY
 YiCaefNxsFqbimQ1epcq2uNv0YOe6ODIFYcg26PR8cuscYX30RHVLgC9523TR9WpowhUJz
 +BwA9z3x5vSqT7EVvTO+xLZI/8Fp0lY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-BmzEv0y9NEW9gyreU7vprg-1; Thu, 25 Jun 2026 10:34:48 -0400
X-MC-Unique: BmzEv0y9NEW9gyreU7vprg-1
X-Mimecast-MFC-AGG-ID: BmzEv0y9NEW9gyreU7vprg_1782398087
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46e5abe83a3so251781f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782398087; x=1783002887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcJvSo+yM44IPJq/8/t8uHpdYZSMjkd8xx/hVTQZCgY=;
 b=PL1QpePJNMaZaNCD+2mbws3ONml/vbQkKBic2mobEqoO58fNA3CwgO2FZFa8AwE39+
 /oiRxiYgqXwf3+vZB1UWzGkELfHfIu9ABUKOcsO2tZvOOqYcn91Ly0jDbg9EpNcbdTyT
 sjyeKzgeLbuBAsmqyfr432HdhaZfJ6ZMQOCpea/Kzheoe+jlbETbkCrViKBWog+/PVnw
 WK2FrZE2LWreG3HpbzugdoVHw2X/lDU44fyQohCFZHnA+NFBBUvX/SgJeY6ZCOCIqDxc
 EKpSuNEhMY16HfWlLcEkSXAWwY9k2mAuz511oGvZyDl4VOEMBTODy5s1JVE/9+cwS+IJ
 NvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398087; x=1783002887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcJvSo+yM44IPJq/8/t8uHpdYZSMjkd8xx/hVTQZCgY=;
 b=fNv+MgpqDWoa81c18DahwylMnJlQfZ0Z5N0jVRFjLW93upMSdfnw5CaJU1IAU7A9zo
 sdtO3294SHbezFCZ5fZFnvYKRyV4YSOwquGl9fyE9C9QHwE91tXI+1NBvyjLtkx178z1
 r3cM7t0L9Nv70DFyikFhmwoBjddO7zNN73gxXYO6oqBvzxbk+EAFssQkGsXr4oDztkol
 IVjsr3D1TTsFZ1gV78wZFV3se7cm2UpJlPHLHZb9x5qOu40rnOIm8lesAxNAVYjY6YlG
 O1UgzP+Ye7m8BShXlLwstgyAmgADarjpGHcCDrPsOsBSH3Y9+zV8Z6bQuVbDvlQ085bk
 6rCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2zpkBwbxMTTYPTLymSVwv4Q1LmG5ecCmMTaJELOiBTHrf2yJqPYWrwlTxlaYRf7yoQBmdYCV/kKsm@nongnu.org
X-Gm-Message-State: AOJu0YzOaQNBJQIA4CEENxl4M2Nzpour0Ki8cep1Sx5WC1XRqm5CGmlz
 GjUzrZKsqiUl4NPdDza+QgaqeStO5FytacnRlzbOtBqA2tZfJS1LsLbv/QdfIrOe/tedWGFJ7V3
 WK0uQVFuCMhWrRVb+9yFcTXulwDfSfF4IsY5b/TaBtj1nCe9Wk+Lxfpu3
X-Gm-Gg: AfdE7clVBCeiNA8ouft2Ac/F54o/iY4Jc3y1xMk1h6242JDwCiJATQkmDDOJaQ+n/4G
 06IvOltTlerpPQbXhzWI9Aly1ocgDCLDRggsTHMIuSuR0Ur6F0KXTq5zHATXkmEdLIzxUqbdAOP
 Fw5/5EYjWl94+kI/7ZXryRfEjsmo4oEhE6q7+iaD2GKmk+70YEjpuUqcG4wk3SIt/u4s8NOZuJB
 IWcVXQaYOCeo0LDaD2e/knZQhSggkFQCrfROanJoC1C6Jp1kZ2O3y6oSUi2SkAMdwC07+IczrUC
 4ny4+RGEwGnvNWwxtkNpyMz4U9RWloyyX8brhBpDBagf0BEpQHI9mAmLCSeK3D4owLonPRc=
X-Received: by 2002:a05:6000:471a:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-46dc0e04bb7mr4391473f8f.23.1782398087220; 
 Thu, 25 Jun 2026 07:34:47 -0700 (PDT)
X-Received: by 2002:a05:6000:471a:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-46dc0e04bb7mr4391419f8f.23.1782398086824; 
 Thu, 25 Jun 2026 07:34:46 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9f240c3dsm14721150f8f.35.2026.06.25.07.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:34:46 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:34:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: <mst@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, <qemu-devel@nongnu.org>,
 <david@kernel.org>, <gourry@gourry.net>, <philmd@mailo.com>,
 <berrange@redhat.com>, <peterx@redhat.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v14 00/10] hw/mem: add sp-mem device for Specific
 Purpose Memory
Message-ID: <20260625163444.23b168ac@imammedo>
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 23 Jun 2026 15:50:41 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> SOFT_RESERVED guest memory, following the direction from the v7
> thread [1] and the v8 / v9 / v10 / v11 / v12 / v13 reviews
> [2][3][4][5][6][7].

review is done at this point,
I guess Michael will take it via his tree. 

> 
> Background
> ----------
> 
> This series targets coherent CPU + accelerator shared-address-space
> systems, where the accelerator's HBM is not a device-private
> framebuffer behind a PCIe BAR but a tier of host system memory:
> visible to the CPU in the platform physical address space, shared
> coherently with the accelerator over the platform fabric, and bound
> to a NUMA proximity domain set by platform firmware at boot fabric
> training.
> 
> For such a region to function correctly in the guest, two things
> must hold simultaneously: the CPU memory subsystem has to see it in
> the system memory map (so the CPU side can address it), and it has
> to be reserved exclusively for the accelerator's driver (so the
> kernel's general allocator does not hand SPM pages to unrelated
> workloads). The SOFT_RESERVED memory type in E820 plus a matching
> SRAT memory-affinity entry is the mechanism that delivers both: a
> firmware-produced topology that the CPU memory subsystem honors and
> the accelerator's driver consumes for its own range.
> 
> Approach
> --------
> 
> The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
> Each instance binds one host memory backend to a single NUMA
> proximity domain and is boot-time only; placement, mapped-state
> enforcement, and QMP introspection come from the existing
> memory-device framework.
> 
> Testing
> -------
> 
> Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:
> 
> - single sp-mem instance
> - two sp-mem instances on different NUMA nodes
> 
> Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
> sp-mem device, dmesg SRAT parsing reports the matching
> memory_affinity entries with correct PXM, and the umbrella
> HOTPLUGGABLE entry covers the remaining hotplug-memory window
> without overlapping the sp-mem ranges.
> 
> In-tree coverage: a bios-tables-test case validates the SRAT
> partition for two sp-mem devices on distinct nodes, and an e820
> fw_cfg test checks the SOFT_RESERVED range.
> 
> Changes since v13
> -----------------
> 
>   - qapi: note that SpMemDeviceInfo's @size is in bytes.
>   - pc: fix the indentation of the pc_sp_mem_plug() continuation line.
>   - Collected the Reviewed-by / Acked-by tags from the v13 review.
> 
> Previous versions
> -----------------
> 
>   v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
>   v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
>   v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
>   v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
>   v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
>   v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
>   v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
>   v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
>   v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
>   v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
>   v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/
>   v12: https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/
>   v13: https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/
> 
>   [1] v7 thread closeout:
>       https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
>   [2] v8 review:
>       https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
>   [3] v9 review:
>       https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
>   [4] v10 review:
>       https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
>   [5] v11 review:
>       https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/
>   [6] v12 review:
>       https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/T/
>   [7] v13 review:
>       https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/T/
> 
> fanhuang (10):
>   hw/mem: add sp-mem device for Specific Purpose Memory
>   qapi, hmp: introspection for the sp-mem device
>   i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
>   hw/i386: hook sp-mem into the pc machine plug path
>   MAINTAINERS: cover sp-mem under Memory devices, add R: tag
>   tests/acpi: add empty expected blobs for sp-mem SRAT test
>   tests/acpi: add bios-tables-test case for sp-mem
>   tests/acpi: generate expected blobs for sp-mem SRAT test
>   tests/qtest: add e820 fw_cfg test
>   tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
> 
>  MAINTAINERS                        |   3 +
>  qapi/machine.json                  |  43 +++++++++-
>  hw/i386/e820_memory_layout.h       |  11 +--
>  include/hw/mem/sp-mem.h            |  33 ++++++++
>  hw/core/machine-hmp-cmds.c         |  11 +++
>  hw/i386/acpi-build.c               |  96 ++++++++++++++++++++-
>  hw/i386/pc.c                       |  36 ++++++++
>  hw/mem/sp-mem.c                    | 128 ++++++++++++++++++++++++++++
>  tests/qtest/bios-tables-test.c     |  21 +++++
>  tests/qtest/e820-test.c            | 129 +++++++++++++++++++++++++++++
>  hw/i386/Kconfig                    |   2 +
>  hw/mem/Kconfig                     |   4 +
>  hw/mem/meson.build                 |   1 +
>  tests/data/acpi/x86/q35/DSDT.spmem | Bin 0 -> 9910 bytes
>  tests/data/acpi/x86/q35/SRAT.spmem | Bin 0 -> 384 bytes
>  tests/qtest/meson.build            |   1 +
>  16 files changed, 508 insertions(+), 11 deletions(-)
>  create mode 100644 include/hw/mem/sp-mem.h
>  create mode 100644 hw/mem/sp-mem.c
>  create mode 100644 tests/qtest/e820-test.c
>  create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
>  create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem
> 
> 
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb


