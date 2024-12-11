Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1ACE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNuz-0005Yc-Rp; Wed, 11 Dec 2024 09:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1tLNuk-0005UF-DK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1tLNug-0003dh-0a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733928124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fie4e9/SqiKEIJ0BgBQG34M0q5HC6FdXlnKmBKvG7qI=;
 b=FIjU97VHdUOBFfeGZWUbHul0/jAwkfu59/MnbJCtUd/ttbBC4BdjhkRQqDV6PwEGhDibdO
 gJYA/vgkGNz/gXpwpXTTpMzNQk+9iSfDsQRG/7hlg5UI7xyqoiJf+qkh2JROkl9VPw0vaR
 zBrBmyeD+vt7BT/yq1fSRnC2ZGv+RUs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-UKmlBJFsOV2yvTNG1dJU5Q-1; Wed, 11 Dec 2024 09:40:55 -0500
X-MC-Unique: UKmlBJFsOV2yvTNG1dJU5Q-1
X-Mimecast-MFC-AGG-ID: UKmlBJFsOV2yvTNG1dJU5Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso2921714f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928054; x=1734532854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fie4e9/SqiKEIJ0BgBQG34M0q5HC6FdXlnKmBKvG7qI=;
 b=aSXeeCoqrpLx89mSGq0gek6dtJsT8g5LJPaG6ptKPFqaEV7WiLTDY22GcuYZIajT2C
 uuykGBUsN2G73fG3Iee4rW5E0E66be0XkdE4Tv3sPSM8e412dn/xBVZQvSwsztFH/vBz
 eda/wLsreTK12beMatzoV8TMlKx7RQLlXkksl4j/Fki3dCGrdBP2EaJlTvoJtTvVV7Uy
 fpGHsi1d//8UQptSVxK7+WxntgUjcSsmrDVYz0nhRqUvZGaPrX7gRGp5h8k2Y0wWZTyQ
 QmwS/yGOs4sZN2G6ASr4V2kpbN0BipK/ZYT0OxTQplLFJlqrNnVgyw5TOuA0eEtXLh4L
 a9FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfKQ7OgFEOWmQ1U/SHb8u5xhXg1TfPL7VqzUDjYDZwU3EcgcuFzD61Khlnm/BWlsrUU4YQ53EahuNs@nongnu.org
X-Gm-Message-State: AOJu0YzH/69RqnOC6jsgTbZGhAT8RScf/LYxmriQiKWKt9ClmeqnQP2u
 I8R97ZZ6Mz/f0Me8zG8+LfiU3uYToAyBxZv6n/2oGW/38RCwXQ5s0CECe+h5t6CGBE5796OMk1r
 Y9QDBrpazWoNX9Ws5yqz1NeEVb9Sqap4Elxe8WaDfUTxyvq2MsvM1
X-Gm-Gg: ASbGnctKGWTadS8WYcFycw2QysR+Gpv/IUwuX2gWk+mIFOBtCV9gptREmCt/LeEjK+M
 Wdx/tIedEK77wKaYTmcLLkCd4RGoVnSmNVL7EPavcsfxS1Hba3iBZwtvFeYyDugl+qeC2bM3U7g
 dRGToF1ivpmlAOAGaOPo4iZJcUP2VYBgcv+iam+RBBZydzRGRd72shEjn3Fbt04NscVAn6Xe5uu
 a+nlHYMWDQ4GHIyltdjF1CyvRVp76ITn3e4OFtnvnfH8jWAiE7ej5K0JnFTx7U74GZ2Biugda5F
 5Dvxi8zZ5sn9Cl8Pm/GsbllCHsNom59mlt8=
X-Received: by 2002:a5d:64a1:0:b0:385:ed1e:2105 with SMTP id
 ffacd0b85a97d-3864ce5f9b2mr2876451f8f.26.1733928054107; 
 Wed, 11 Dec 2024 06:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP3/NfP0tU3DLmmvvWNBrQwhme/o4KGnD1KsbQ4zv9Ts/LEgigB5av0UEZVDiodvFxA6F5ZA==
X-Received: by 2002:a5d:64a1:0:b0:385:ed1e:2105 with SMTP id
 ffacd0b85a97d-3864ce5f9b2mr2876416f8f.26.1733928053523; 
 Wed, 11 Dec 2024 06:40:53 -0800 (PST)
Received: from [192.168.23.161] (92-184-116-132.mobile.fr.orangecustomers.net.
 [92.184.116.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43618fa49b6sm42217175e9.15.2024.12.11.06.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 06:40:52 -0800 (PST)
Message-ID: <cc6d2f65-1d71-4a78-9a9a-0fe7d16957d5@redhat.com>
Date: Wed, 11 Dec 2024 15:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20241209192927.107503-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/9/24 20:29, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitiate this, pin the entirety of
> guest memory into the host iommu.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 23 ++++++++++++++++++
>   hw/s390x/s390-pci-inst.c        | 42 +++++++++++++++++++++++++++++++--
>   include/hw/s390x/s390-pci-bus.h |  2 ++
>   3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 40b2567aa7..8d4224e032 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -18,6 +18,7 @@
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-kvm.h"
>   #include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -720,6 +721,27 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>                                name, iommu->pal + 1);
>       iommu->enabled = true;
> +    iommu->direct_map = false;
> +    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
> +    g_free(name);
> +}
> +
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)

This is duplicating s390_pci_iommu_enable(). May be we could add a new
argument to s390_pci_iommu_enable() instead ?

> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Because
> +     * the mappings are contiguous we are not restricted to individual 4K
> +     * mappings via vfio, so let's not worry about the DMA limit when> +     * calculating the range.
> +     */
> +    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
> +    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
> +                             TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> +                             name, iommu->pba + ms->ram_size);
> +    iommu->enabled = true;
> +    iommu->direct_map = true;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }
> @@ -727,6 +749,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
>   {
>       iommu->enabled = false;
> +    iommu->direct_map = false;
>       g_hash_table_remove_all(iommu->iotlb);
>       memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
>       object_unparent(OBJECT(&iommu->iommu_mr));
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 41655082da..f4d8fe8fe8 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -16,6 +16,7 @@
>   #include "exec/memory.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/hw_accel.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> @@ -990,6 +991,33 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +static void s390_pci_setup_stage2_map(S390PCIIOMMU *iommu)

This is very much like s390_pci_batch_unmap(). Could we introduce a
common helper ?

> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint64_t remain = ms->ram_size, start = iommu->pba, mask, size, curr = 0;
> +    uint64_t end = start + remain - 1;
> +    IOMMUTLBEvent event = {
> +        .type = IOMMU_NOTIFIER_MAP,
> +        .entry = {
> +            .target_as = &address_space_memory,
> +            .translated_addr = 0,
> +            .perm = IOMMU_RW,
> +        },
> +    };
> +
> +    while (remain >= TARGET_PAGE_SIZE) {
> +        mask = dma_aligned_pow2_mask(start, end, 64);
> +        size = mask + 1;
> +        event.entry.iova = start;
> +        event.entry.addr_mask = mask;
> +        event.entry.translated_addr = curr;
> +        memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
> +        start += size;
> +        curr += size;
> +        remain -= size;
> +    }
> +}
> +
>   static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>                       uintptr_t ra)
>   {
> @@ -1008,7 +1036,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       }
>   
>       /* currently we only support designation type 1 with translation */
> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {

Is this change part of the patchset ? It looks like some other issue.
I might be wrong.

>           error_report("unsupported ioat dt %d t %d", dt, t);
>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
> @@ -1018,13 +1046,23 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       iommu->pal = pal;
>       iommu->g_iota = g_iota;
>   
> -    s390_pci_iommu_enable(iommu);
> +    if (t) {
> +        s390_pci_iommu_enable(iommu);
> +    } else {
> +        s390_pci_iommu_dm_enable(iommu);
> +        /* If not translating, map everything now */
> +        s390_pci_setup_stage2_map(iommu);
> +    }


I don't understand how we can enter "map everything" case.
Could you explain a bit more the scenario ?

Thanks,

C.

>       return 0;
>   }
>   
>   void pci_dereg_ioat(S390PCIIOMMU *iommu)
>   {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    if (iommu->direct_map) {
> +        s390_pci_batch_unmap(iommu, iommu->pba, ms->ram_size);
> +    }
>       s390_pci_iommu_disable(iommu);
>       iommu->pba = 0;
>       iommu->pal = 0;
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 2c43ea123f..2aa55e3fd0 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -278,6 +278,7 @@ struct S390PCIIOMMU {
>       MemoryRegion mr;
>       IOMMUMemoryRegion iommu_mr;
>       bool enabled;
> +    bool direct_map;
>       uint64_t g_iota;
>       uint64_t pba;
>       uint64_t pal;
> @@ -389,6 +390,7 @@ int pci_chsc_sei_nt2_have_event(void);
>   void s390_pci_sclp_configure(SCCB *sccb);
>   void s390_pci_sclp_deconfigure(SCCB *sccb);
>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
>   void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
>                                      uint64_t faddr, uint32_t e);


