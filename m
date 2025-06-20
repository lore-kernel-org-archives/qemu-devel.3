Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326C7C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVrd-0000oj-C9; Fri, 20 Jun 2025 03:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSVrb-0000ia-Bd
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSVrZ-0005yu-JB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750403310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjpROTlUxcFKatVESFWzJpOCxiNhugKIOSY4dxFsU3E=;
 b=S4CA8ktH+ZhRoU1TxKJNEt/hG4cV8+ggZZWxELwSQrlw9n9z2TjuNVovIhwHDYDdsMKGyf
 eIK/lELfQ+CbmuqRvbMRYpVsrRy/4OOIh2URexVrXoat1ma/F23UCmoPMRcro2InwdwqZC
 GwLJIRWDno6annSDe7bJ74iedO1pWko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-5x3lBa11OlqhhLol1H963w-1; Fri, 20 Jun 2025 03:08:28 -0400
X-MC-Unique: 5x3lBa11OlqhhLol1H963w-1
X-Mimecast-MFC-AGG-ID: 5x3lBa11OlqhhLol1H963w_1750403307
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so12055045e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 00:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750403307; x=1751008107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjpROTlUxcFKatVESFWzJpOCxiNhugKIOSY4dxFsU3E=;
 b=cCfUmT5dFuUX6fsg4beuE2rj7X+olXJzwSqkaBlzTI31N6V1Q/PiQDpO9MyO9HEA6B
 2v2apbJs6t9b6qi53kVjg7pWkBKouu3mQNP7jw4jtVwsBf5Jom2OnXpLo+Z3w4Atsf8R
 mCSn9kDD3DKumZDFALVSZbL/zVdlfzw+952vN0zO58Z5smqyG18hhn6NZ1dc70QKKUi3
 6bS+FHyZTiUVZCMaTP6wTeVMDn6Z+sLp2JBIFnrLQ6hBNaKxHn88NSuzbio8RuZS1exA
 g0T6qVgFinHolwsoA+PoS04TOgMZ6AwgHxx5nB/GO+kUSfsjn1vLbnA4/Uuay7EvEn5T
 azYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnvDYYU3wYyjMOXbw9Xkh2/NJByyAOiBM6t23GIcj9Ii39p7AiMB60f4sX7dYgg+0KQc/ATUAwNvxx@nongnu.org
X-Gm-Message-State: AOJu0Yw1c5pU9MiRv+y/rAZyUW2F1iUx2khAZBIqMXZ84EeqGSMoLEVA
 GkPkb4SDTS7FnSgrhZiqI+FA1Dfty0BtdpaZjwn5tI5A1Yd8nN9CC/8iMlR28MrBWR0KSCqVwI+
 njrhTS0Ens38JwNVqvewOmd63A/cL5eh4bCRqImEZbKzR8r3AlyUcFzDy
X-Gm-Gg: ASbGncu9kxOAA8Z+iJt50U6rvUhz6Mw3XYq4jcX0Ezj4HXOfFbWkxH0XudUzDp4K4AO
 ExSkBBRuoBz+1Oq+8v5vl/ZDum58eR6aB4I1whmZqcThtnbb4PV0k+Qhsm0RA8ghcUiDiBzGBnz
 DcZ/WtfB1Cvk974BzLjDh4CYuBJPsSECP1rqRO5WvFzKA2KX9KUDqoLVI+XwP4bMv5rxMWXKOyH
 Te+TOOhQ/T5XQv48j5QTFw0MlfTJLGCWSRUQs9dicZQk2k/4g37QIFaOeJDdM7oLYarLGnV58ue
 FZ7S/87f1csdV+/cqvlHKUSNKa5Z0EF3Ky5sswRNLznaBb8d09HRq7P0q83/NhCZHQBbmg==
X-Received: by 2002:a05:600c:4fc1:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-453659c4832mr12694135e9.6.1750403307245; 
 Fri, 20 Jun 2025 00:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUABaILCvTv8XSf57qoOLDXNSoGLFNbeF5Es0RB+0lipU/fsEvaNL58XjDEpp7/rNi/3it6g==
X-Received: by 2002:a05:600c:4fc1:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-453659c4832mr12693495e9.6.1750403306778; 
 Fri, 20 Jun 2025 00:08:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecb5sm49911525e9.37.2025.06.20.00.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 00:08:25 -0700 (PDT)
Message-ID: <a728c9df-92bc-49b1-989b-4857160a1ad7@redhat.com>
Date: Fri, 20 Jun 2025 09:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/15] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-5-zhenzhong.duan@intel.com>
 <1cf2ecbe-1f98-452f-8a39-331e7d459969@eviden.com>
 <IA3PR11MB91363F234F379A878B612FE69277A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB91363F234F379A878B612FE69277A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/13/25 11:08 AM, Duan, Zhenzhong wrote:
> Hi Clement,
>
>> -----Original Message-----
>> From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>> Subject: Re: [PATCH v1 04/15] intel_iommu: Introduce a new structure
>> VTDHostIOMMUDevice
>>
>> Hi,
>>
>> On 06/06/2025 12:04 pm, Zhenzhong Duan wrote:
>>> Caution: External email. Do not open attachments or click links, unless this
>> email comes from a known sender and you know the content is safe.
>>>
>>> Introduce a new structure VTDHostIOMMUDevice which replaces
>>> HostIOMMUDevice to be stored in hash table.
>>>
>>> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
>>> also includes BDF information which will be used in future
>>> patches.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   hw/i386/intel_iommu_internal.h |  7 +++++++
>>>   include/hw/i386/intel_iommu.h  |  2 +-
>>>   hw/i386/intel_iommu.c          | 14 ++++++++++++--
>>>   3 files changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 2cda744786..18bc22fc72 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -28,6 +28,7 @@
>>>   #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>   #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>   #include "hw/i386/intel_iommu.h"
>>> +#include "system/host_iommu_device.h"
>>>
>>>   /*
>>>    * Intel IOMMU register specification
>>> @@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>   /* Bits to decide the offset for each level */
>>>   #define VTD_LEVEL_BITS           9
>>>
>>> +typedef struct VTDHostIOMMUDevice {
>>> +    IntelIOMMUState *iommu_state;
>>> +    PCIBus *bus;
>>> +    uint8_t devfn;
>>> +    HostIOMMUDevice *hiod;
>>> +} VTDHostIOMMUDevice;
>>>   #endif
>>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>>> index e95477e855..50f9b27a45 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -295,7 +295,7 @@ struct IntelIOMMUState {
>>>       /* list of registered notifiers */
>>>       QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>>>
>>> -    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
>>> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
>>>
>>>       /* interrupt remapping */
>>>       bool intr_enabled;              /* Whether guest enabled IR */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index c42ef83ddc..796b71605c 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1,
>> gconstpointer v2)
>>>   static void vtd_hiod_destroy(gpointer v)
>>>   {
>>> -    object_unref(v);
>>> +    VTDHostIOMMUDevice *vtd_hiod = v;
>>> +
>>> +    object_unref(vtd_hiod->hiod);
>>> +    g_free(vtd_hiod);
>>>   }
>>>
>>>   static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
>>> @@ -4397,6 +4400,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus,
>> void *opaque, int devfn,
>>>                                        HostIOMMUDevice *hiod, Error **errp)
>>>   {
>>>       IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>>       struct vtd_as_key key = {
>>>           .bus = bus,
>>>           .devfn = devfn,
>>> @@ -4413,6 +4417,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus,
>> void *opaque, int devfn,
>>>           return false;
>>>       }
>>>
>>> +    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
>>> +    vtd_hiod->bus = bus;
>>> +    vtd_hiod->devfn = (uint8_t)devfn;
>>> +    vtd_hiod->iommu_state = s;
>>> +    vtd_hiod->hiod = hiod;
>>> +
>>>       if (!vtd_check_hiod(s, hiod, errp)) {
>> Shouldn't we free vtd_hiod here?
> Good catch, Thanks.
> I put g_free in patch10, but it should be in this patch, will fix.

With this fixed,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> BRs,
> Zhenzhong
>


