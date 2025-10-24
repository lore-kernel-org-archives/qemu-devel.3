Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEACCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLfc-0006by-Ah; Fri, 24 Oct 2025 13:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLfb-0006bh-6H
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLfY-0001qQ-Qc
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761327219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2U85mfKVlBYUQ5jNYFXmUmqNDEHVJDPje8dWO7c3aeY=;
 b=YOkARelNJ2mdfaHueGxauXcW5HwG6cnLrpYL2HhPHGSua0egLbLFjtOb1Q/r9ty4FiHoRo
 KIsKsx66Edzuipn/1f2Aqyulc2ENYfoO1VvB8V5cvrS//m7eOooZ+Q1w83bv1/StUXP9HJ
 bxFsXsUOhXwzPLl4oYkkXl4B9cb+DhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-cZqKuN1jMu2nWyOBCEXAQA-1; Fri, 24 Oct 2025 13:33:38 -0400
X-MC-Unique: cZqKuN1jMu2nWyOBCEXAQA-1
X-Mimecast-MFC-AGG-ID: cZqKuN1jMu2nWyOBCEXAQA_1761327217
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47111dc7c35so18983185e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761327217; x=1761932017;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2U85mfKVlBYUQ5jNYFXmUmqNDEHVJDPje8dWO7c3aeY=;
 b=Mn2psJ4SnB0hQp6013UW6RiJfSY8bZswEpYzqYaBk3ZY3uCNNVGQiBD4I8kCokHxfF
 GQVoSTZNNyCbiyW+3U6Xmsty5jO4eg15CfSfEb+zboTMU0ab8wHEIbL/rtzboBBG8Htm
 DRxwZuNp8fOBJAP5SCk7Mgq6g4v+vKERxPogF4otw0DoJ2lJqgpXztRs+Qch+SXGEmzl
 D5bpKxdK54eqj5grxHy16nUAJayxQoGVsd37mP1Fk45L+8LYasy72mWRjxXh9YnAI3PH
 DCD2Opxpohcdq1TvlrEaqm/7o6UH5/6384patq3mPjX/QjVIOzh3sCDXeY2SdYUGSYSx
 9yJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZA+OcRn9/xlxBBsF/f2QR1k/l4x0iEjCgLulnVzDI7AEgEhbs76dHT05nUniTE0eaNx6NUoukFVYf@nongnu.org
X-Gm-Message-State: AOJu0YxRgx2XxKfDQZHmVw441oNc74XMx1mZ63Nek5gE5xfVnJmtym9w
 XxCUkMVjFI1BojpqU+EVcIm83EGLfWmAHcEq4YEf3aWvJOdNhuC8fPjPVtWqJZ28xxMqW8MX5WW
 fytwyCP9bKq9sbpj8ZyupXxxA/zzHmer1CakC3qZv3bpVtrHwEBQQOeqK
X-Gm-Gg: ASbGnctbc2102luUc/R0zCVSaJ8kWo96FG5bSInpYKIu4b0X5HEM3aoaB3ul3ZIKYdx
 iZ8XV25Oa9ELnRx1n84BWitaUlew6DVTBVGk/fPoRYNdDiuKT1X6Im56wxSqi+cgv3CxmO0zasQ
 CGFAUgeRqEokLCND5CG5slM3CtljCVQR6tBaY54nvyfVNax5a1jS05IgyUNe1SqMLwDjm563jNN
 yqTaX++qFwR3KNgEjZ7D6vMgTSEQrM5tDwQbxw2ZIWpZfOfeBHnJ3X511ISG9en9qv9NvOm1i4u
 9fR9nCt/QJqrY1ftTMfWmUbw553kr4rjZGW/VeVtY2yOot2g06lGHezK1yuMe7A5oDNVYwBv
X-Received: by 2002:a05:600c:3e0b:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-475d2ed1bcamr27130215e9.31.1761327216719; 
 Fri, 24 Oct 2025 10:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFixfGnbCXb8SiQF9C/mxS0gp9g04P9yZ9fk9Uzg8RyIvPfbZr7mGTPg/4ploHSzt9ob/MoFQ==
X-Received: by 2002:a05:600c:3e0b:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-475d2ed1bcamr27130045e9.31.1761327216269; 
 Fri, 24 Oct 2025 10:33:36 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f5696sm10605947f8f.14.2025.10.24.10.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:33:35 -0700 (PDT)
Message-ID: <0dd62d63-d847-49c5-a05a-2e58c6c6d538@redhat.com>
Date: Fri, 24 Oct 2025 19:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to host
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-14-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and propagates
> the changes to host to attach a hwpt with type determined per guest IOMMU
> PGTT configuration.
> 
> When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
> When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
> coming from VFIO.
> 
> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/i386/intel_iommu.h |   1 +
>   hw/i386/intel_iommu.c         | 150 +++++++++++++++++++++++++++++++++-
>   hw/i386/trace-events          |   3 +
>   3 files changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3758ac239c..b5f8a9fc29 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
>       uint32_t pasid;
> +    uint32_t fs_hwpt;
>       AddressSpace as;
>       IOMMUMemoryRegion iommu;
>       MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 871e6aad19..3789a36147 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
> @@ -42,6 +43,9 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif
>   
>   /* context entry operations */
>   #define PASID_0    0
> @@ -87,6 +91,7 @@ struct vtd_iotlb_key {
>   
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   
>   static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>   {
> @@ -98,7 +103,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>       g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
>       while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
>           VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> -        pc_entry->valid = false;
> +        if (pc_entry->valid) {
> +            pc_entry->valid = false;
> +            /* It's fatal to get failure during reset */
> +            vtd_bind_guest_pasid(vtd_as, &error_fatal);
> +        }
>       }
>   }
>   
> @@ -2380,6 +2389,128 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       vtd_iommu_replay_all(s);
>   }
>   
> +#ifdef CONFIG_IOMMUFD
> +static int vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDPASIDEntry *pe, uint32_t *fs_hwpt,
> +                              Error **errp)

Returning a bool is better. Same for the routines below.

> +{
> +    struct iommu_hwpt_vtd_s1 vtd = {};
> +
> +    vtd.flags = (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd.addr_width = vtd_pe_get_fs_aw(pe);
> +    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
> +
> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                       sizeof(vtd), &vtd, fs_hwpt, errp);
> +}
> +
> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                    VTDAddressSpace *vtd_as)
> +{
> +    if (!vtd_as->fs_hwpt) {
> +        return;
> +    }
> +    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
> +    vtd_as->fs_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
> +    bool ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FST and PT.
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.
> +     */
> +    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type");
> +        return -EINVAL;
> +    }
> +
> +    if (vtd_pe_pgtt_is_pt(pe)) {
> +        hwpt_id = idev->hwpt_id;
> +    } else if (vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, !ret);
> +    if (ret) {
> +        /* Destroy old fs_hwpt if it's a replacement */
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        if (vtd_pe_pgtt_is_fst(pe)) {
> +            vtd_as->fs_hwpt = hwpt_id;
> +        }
> +    } else if (vtd_pe_pgtt_is_fst(pe)) {
> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +    }
> +
> +    return !ret;
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint32_t pasid = vtd_as->pasid;
> +    bool ret;
> +
> +    if (s->dmar_enabled && s->root_scalable) {
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, !ret);
> +    } else {
> +        /*
> +         * If DMAR remapping is disabled or guest switches to legacy mode,
> +         * we fallback to the default HWPT which contains shadow page table.
> +         * So guest DMA could still work.
> +         */
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           !ret);
> +    }
> +
> +    if (ret) {
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +    }
> +
> +    return !ret;
> +}
> +
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +    int ret;
> +
> +    /* Ignore emulated device or legacy VFIO backed device */
> +    if (!vtd_hiod) {
> +        return 0;
> +    }
> +
> +    if (pc_entry->valid) {
> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> +    } else {
> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    return 0;
> +}
> +#endif
> +
>   /* Do a context-cache device-selective invalidation.
>    * @func_mask: FM field after shifting
>    */
> @@ -3134,6 +3265,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       VTDPASIDEntry pe;
>       IOMMUNotifier *n;
>       uint16_t did;
> +    const char *err_prefix;

Setting this prefix looks a bit fragile. May be add a default value here.


Thanks,

C.


> +    Error *local_err = NULL;
>   
>       if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>           if (!pc_entry->valid) {
> @@ -3154,7 +3287,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>               vtd_address_space_unmap(vtd_as, n);
>           }
>           vtd_switch_address_space(vtd_as);
> -        return;
> +
> +        err_prefix = "Detaching from HWPT failed: ";
> +        goto do_bind_unbind;
>       }
>   
>       /*
> @@ -3182,12 +3317,21 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       if (!pc_entry->valid) {
>           pc_entry->pasid_entry = pe;
>           pc_entry->valid = true;
> -    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Attaching to HWPT failed: ";
> +    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Replacing HWPT attachment failed: ";
> +    } else {
>           return;
>       }
>   
>       vtd_switch_address_space(vtd_as);
>       vtd_address_space_sync(vtd_as);
> +
> +do_bind_unbind:
> +    /* TODO: Fault event injection into guest, report error to QEMU for now */
> +    if (vtd_bind_guest_pasid(vtd_as, &local_err)) {
> +        error_reportf_err(local_err, "%s", err_prefix);
> +    }
>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index b704f4f90c..5a3ee1cf64 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
>   vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>   vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>   vtd_reset_exit(void) ""
> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


