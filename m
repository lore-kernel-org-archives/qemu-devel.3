Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119C5CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqpI-000075-F8; Mon, 03 Nov 2025 04:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFqpG-00006n-Eu
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFqp8-0001Q6-8t
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762161956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vg+PJGuiJ+7ipDLEWd8M8CbBrP8i6RGUoX9+lwHLBg=;
 b=greExj/uztv8szLMZ4oXi3akolx1ANvYBOxoJqwx3+m54ApNZcgrF6h1FBRCsKFvSw57I0
 ONUBRoxPahZZlwGe7TN2h8j2N8ZIVj1+vuFsBYC8n8aSvGAm0Cnk6MOjtTGXOsSnL6Vg4T
 6m0ItvhJf2N8vMl4zLfTsOuOteTea7E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-9NF3nxeAPhKYdLTAScyoHQ-1; Mon, 03 Nov 2025 04:25:54 -0500
X-MC-Unique: 9NF3nxeAPhKYdLTAScyoHQ-1
X-Mimecast-MFC-AGG-ID: 9NF3nxeAPhKYdLTAScyoHQ_1762161951
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso32930135e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 01:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762161951; x=1762766751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3vg+PJGuiJ+7ipDLEWd8M8CbBrP8i6RGUoX9+lwHLBg=;
 b=iJont9MD65iD6BYSMoGdiTQAjsyO+NRQ0AVGW6G+UPEg/glHvuXrXsx9jrxb+Spase
 mA/9GvYQBWZRjHl1skDIyIhHwPuWWmn0byOPR6OGtMc/BwegHnAapYsTerMKAxiFTdjC
 xmjpqsSKDbNl5yk+hY+40yPhT83ixdeX2aFiOz2b4oBBgRB11m8S+KTFlaxr+SpnON/g
 fKCTiMw+ES4tussILBsFjF6YfDrRgduOOpepUc13bcVSfMbvazYYWt7KUJJOvie0xTJc
 gAHWAsocPNtYSGGryea4Ci7fOr4+D76nBTtBeeM9Hz/nCZJUHhAIu8j2eNnjYuqsJf40
 WomQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYw2cDr5qMtfp/sZ3uUalpzNdyu/425BJdDjpEORpdHUcWZYQIqXRLBdvAkvDxoC5Caf1c0HcE4krD@nongnu.org
X-Gm-Message-State: AOJu0YwMqa0eOmaWQdiOB+Ew+i0wKBEjOxnTs19QVtqVakPezA+agHRm
 +e/4cMFfTDdSvIokp77bgpvJoPZB2N0Im8NrvasRAXARi3QiD3IW+vbkRQqwM8lUe4MP+nrQOht
 wJ26j/v/RRw3L6aCWc0UcJ380JzYcbwjrnyZAIEDT7Gq16iCPX/u5XZtC
X-Gm-Gg: ASbGncuH647ndC55NO0gMjYokEVhUsqy1EVDWTiV1vV46wbjFcvwM2LNJhZdsln7fBM
 J1lmOdB2+9kggpxzbzojOtRKu9S5o2Xe5fdCvlQk5rHfe2rcv7lYepPPgF5BXPQilMP/rCjKNAl
 pSqKILgE9krVyf6UW0XZNVF+QJFce5zCRWpFvJ+rVWLUQDMnfZg4o/ZWbPiE07a71EvzjJfXGW8
 sxzgVYc36CQ6dJYlADD8sbrVU3peqdVrQahuWpGHrZz0gng1HC3ZaGDRxnb+4hIkybj3flMoHGs
 QcH5IdaWyIWVlYnu8jlH3wjW4MvJg/TpEnT7Loa093tjijBWlAVpC48CetreR70F1m9WLscgmMY
 MpP/OliF/HKspq7RA7Ph+SOBomDBI70kMmlHUo8u48TlTpA==
X-Received: by 2002:a05:600c:34c8:b0:471:115e:9605 with SMTP id
 5b1f17b1804b1-477346a92d2mr97026375e9.35.1762161951246; 
 Mon, 03 Nov 2025 01:25:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbzJr7cVwcj3k3MH2Kuh7t9eMZgYFbRSBJIr4VUAxv+VqXid2+dIQGiC5eU6moiatiabot6Q==
X-Received: by 2002:a05:600c:34c8:b0:471:115e:9605 with SMTP id
 5b1f17b1804b1-477346a92d2mr97026045e9.35.1762161950703; 
 Mon, 03 Nov 2025 01:25:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773d81cb03sm133304185e9.13.2025.11.03.01.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 01:25:50 -0800 (PST)
Message-ID: <56714679-d455-4a5f-a46b-b0dbc40f7674@redhat.com>
Date: Mon, 3 Nov 2025 10:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to host
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-14-zhenzhong.duan@intel.com>
 <90e0d491-e59e-4093-812e-57627baea452@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <90e0d491-e59e-4093-812e-57627baea452@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric, Zhenzhong,

On 10/24/25 7:01 PM, Cédric Le Goater wrote:
> On 10/24/25 10:43, Zhenzhong Duan wrote:
>> This captures the guest PASID table entry modifications and propagates
>> the changes to host to attach a hwpt with type determined per guest
>> IOMMU
>> PGTT configuration.
>>
>> When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
>> When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
>> coming from VFIO.
>>
>> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/i386/intel_iommu.h |   1 +
>>   hw/i386/intel_iommu.c         | 150 +++++++++++++++++++++++++++++++++-
>>   hw/i386/trace-events          |   3 +
>>   3 files changed, 151 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>> index 3758ac239c..b5f8a9fc29 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>>       PCIBus *bus;
>>       uint8_t devfn;
>>       uint32_t pasid;
>> +    uint32_t fs_hwpt;
>>       AddressSpace as;
>>       IOMMUMemoryRegion iommu;
>>       MemoryRegion root;          /* The root container of the device */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 871e6aad19..3789a36147 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -20,6 +20,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>>   #include "qapi/error.h"
>> @@ -42,6 +43,9 @@
>>   #include "migration/vmstate.h"
>>   #include "trace.h"
>>   #include "system/iommufd.h"
>> +#ifdef CONFIG_IOMMUFD
>> +#include <linux/iommufd.h>
>> +#endif
>
>
> Exposing IOMMUFD in the Intel vIOMMU is unexpected. Initially, we
> introduced HostIOMMUDeviceClass to avoid exposing the IOMMU backends.
> Are we OK to bypass this abstract layer now ?
HostIOMMUDeviceClass was rather introduced to hide the differences
between VFIO and IOMMUFD backend implementations.
This feature is only implemented based on iommufd. Besides it is
specialized for VTD and ARM so to me it looks like a different class
derivation

Maybe you should put that code in a separate file (-accel.c) as
Shameer/Nicolin are doing for SMMU?

Thanks

Eric
>
>
> Thanks,
>
> C.
>
>
>
>  >   /* context entry operations */
>>   #define PASID_0    0
>> @@ -87,6 +91,7 @@ struct vtd_iotlb_key {
>>     static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>>   static void vtd_address_space_unmap(VTDAddressSpace *as,
>> IOMMUNotifier *n);
>> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>>     static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>>   {
>> @@ -98,7 +103,11 @@ static void
>> vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>>       g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
>>       while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
>>           VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>> -        pc_entry->valid = false;
>> +        if (pc_entry->valid) {
>> +            pc_entry->valid = false;
>> +            /* It's fatal to get failure during reset */
>> +            vtd_bind_guest_pasid(vtd_as, &error_fatal);
>> +        }
>>       }
>>   }
>>   @@ -2380,6 +2389,128 @@ static void
>> vtd_context_global_invalidate(IntelIOMMUState *s)
>>       vtd_iommu_replay_all(s);
>>   }
>>   +#ifdef CONFIG_IOMMUFD
>> +static int vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>> +                              VTDPASIDEntry *pe, uint32_t *fs_hwpt,
>> +                              Error **errp)
>> +{
>> +    struct iommu_hwpt_vtd_s1 vtd = {};
>> +
>> +    vtd.flags = (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE :
>> 0) |
>> +                (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE :
>> 0) |
>> +                (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE
>> : 0);
>> +    vtd.addr_width = vtd_pe_get_fs_aw(pe);
>> +    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
>> +
>> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
>> +                                       idev->hwpt_id, 0,
>> IOMMU_HWPT_DATA_VTD_S1,
>> +                                       sizeof(vtd), &vtd, fs_hwpt,
>> errp);
>> +}
>> +
>> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>> +                                    VTDAddressSpace *vtd_as)
>> +{
>> +    if (!vtd_as->fs_hwpt) {
>> +        return;
>> +    }
>> +    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
>> +    vtd_as->fs_hwpt = 0;
>> +}
>> +
>> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>> +                                     VTDAddressSpace *vtd_as, Error
>> **errp)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =
>> HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
>> +    uint32_t hwpt_id;
>> +    bool ret;
>> +
>> +    /*
>> +     * We can get here only if flts=on, the supported PGTT is FST
>> and PT.
>> +     * Catch invalid PGTT when processing invalidation request to avoid
>> +     * attaching to wrong hwpt.
>> +     */
>> +    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
>> +        error_setg(errp, "Invalid PGTT type");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (vtd_pe_pgtt_is_pt(pe)) {
>> +        hwpt_id = idev->hwpt_id;
>> +    } else if (vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
>> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid,
>> hwpt_id, !ret);
>> +    if (ret) {
>> +        /* Destroy old fs_hwpt if it's a replacement */
>> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
>> +        if (vtd_pe_pgtt_is_fst(pe)) {
>> +            vtd_as->fs_hwpt = hwpt_id;
>> +        }
>> +    } else if (vtd_pe_pgtt_is_fst(pe)) {
>> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
>> +    }
>> +
>> +    return !ret;
>> +}
>> +
>> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>> +                                     VTDAddressSpace *vtd_as, Error
>> **errp)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =
>> HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>> +    uint32_t pasid = vtd_as->pasid;
>> +    bool ret;
>> +
>> +    if (s->dmar_enabled && s->root_scalable) {
>> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
>> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, !ret);
>> +    } else {
>> +        /*
>> +         * If DMAR remapping is disabled or guest switches to legacy
>> mode,
>> +         * we fallback to the default HWPT which contains shadow
>> page table.
>> +         * So guest DMA could still work.
>> +         */
>> +        ret = host_iommu_device_iommufd_attach_hwpt(idev,
>> idev->hwpt_id, errp);
>> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid,
>> idev->hwpt_id,
>> +                                           !ret);
>> +    }
>> +
>> +    if (ret) {
>> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
>> +    }
>> +
>> +    return !ret;
>> +}
>> +
>> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>> +{
>> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
>> +    int ret;
>> +
>> +    /* Ignore emulated device or legacy VFIO backed device */
>> +    if (!vtd_hiod) {
>> +        return 0;
>> +    }
>> +
>> +    if (pc_entry->valid) {
>> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
>> +    } else {
>> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
>> +    }
>> +
>> +    return ret;
>> +}
>> +#else
>> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>> +{
>> +    return 0;
>> +}
>> +#endif
>> +
>>   /* Do a context-cache device-selective invalidation.
>>    * @func_mask: FM field after shifting
>>    */
>> @@ -3134,6 +3265,8 @@ static void
>> vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>       VTDPASIDEntry pe;
>>       IOMMUNotifier *n;
>>       uint16_t did;
>> +    const char *err_prefix;
>> +    Error *local_err = NULL;
>>         if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>>           if (!pc_entry->valid) {
>> @@ -3154,7 +3287,9 @@ static void
>> vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>               vtd_address_space_unmap(vtd_as, n);
>>           }
>>           vtd_switch_address_space(vtd_as);
>> -        return;
>> +
>> +        err_prefix = "Detaching from HWPT failed: ";
>> +        goto do_bind_unbind;
>>       }
>>         /*
>> @@ -3182,12 +3317,21 @@ static void
>> vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>       if (!pc_entry->valid) {
>>           pc_entry->pasid_entry = pe;
>>           pc_entry->valid = true;
>> -    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>> +        err_prefix = "Attaching to HWPT failed: ";
>> +    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>> +        err_prefix = "Replacing HWPT attachment failed: ";
>> +    } else {
>>           return;
>>       }
>>         vtd_switch_address_space(vtd_as);
>>       vtd_address_space_sync(vtd_as);
>> +
>> +do_bind_unbind:
>> +    /* TODO: Fault event injection into guest, report error to QEMU
>> for now */
>> +    if (vtd_bind_guest_pasid(vtd_as, &local_err)) {
>> +        error_reportf_err(local_err, "%s", err_prefix);
>> +    }
>>   }
>>     static void vtd_pasid_cache_sync(IntelIOMMUState *s,
>> VTDPASIDCacheInfo *pc_info)
>> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
>> index b704f4f90c..5a3ee1cf64 100644
>> --- a/hw/i386/trace-events
>> +++ b/hw/i386/trace-events
>> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail
>> 0x%"PRIx16
>>   vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target)
>> "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>>   vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target)
>> "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>>   vtd_reset_exit(void) ""
>> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t
>> hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret)
>> "dev_id %d pasid %d ret: %d"
>> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid,
>> uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>>     # amd_iommu.c
>>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to
>> write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
>


