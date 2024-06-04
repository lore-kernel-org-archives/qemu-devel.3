Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E094BC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPJc-0006vS-M0; Tue, 04 Jun 2024 04:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPJb-0006v7-Gw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPJZ-0003Ff-LN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717488880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pltE4YmOdjx9AYCvJuxzp/4HH2d7IOiOEdOQ1bvIcww=;
 b=eyX/jDyolTBDgoJkOoPi2hjvwyBsFiIpGSX0KfTIVlHaoKAaBI3I8Mc+Cm5w9b2S+n6RXP
 UTiJTPQOLMBpXw4qqRCXSiojIXoEJ9rCwRLVpakugkM0ITP0OvFEE0PCIAJZOprGxlv9UA
 pNCLYHayA+R320nTQFLSy+KfWIP2KCk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-GbKGiwXePrq71jTfqXDuCg-1; Tue, 04 Jun 2024 04:14:37 -0400
X-MC-Unique: GbKGiwXePrq71jTfqXDuCg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42120e123beso47786355e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 01:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717488876; x=1718093676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pltE4YmOdjx9AYCvJuxzp/4HH2d7IOiOEdOQ1bvIcww=;
 b=Iuy0KQ86tJYbKlYAA6EfQS0/GiG7NnW2Nm5wJ9CwtS4eHMS6V/asWiwwOxycDMHqME
 MmYDWzOJhwQ/CBW8uAz0Q07yjDuz81lYWTBy/lt+R4xE3EtSEeGELKd1dXSjIEh6KD2p
 REW1koL7/T6Tf6Wx0pxZPRLDAAJzIaV22gPlZibftgnvjZFxRMJm9tq3RfBigH06z1/M
 9f00LUq1jyiESJ0sWTZmXSYzs8JcHn5ZNKbT3CcSJjE+y33ISpuoG3lP7gN4q1L++rEL
 WwuXO5PdxjALmsySaFmL06MW1MdzmJrBJATQivDqB0g5iXntqPFF01RSktvogcaCKQ8+
 luxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW9ByFsOJl8RnoXuKbd3DQ4CU0E+tHZK0E8lrnG9bWFYL/d6TxGgv7F0RvbAJJyYA3p3ZKzXMxvcXZxLzoleiXlPmvWIs=
X-Gm-Message-State: AOJu0Yz4E2UalAwoame7CQtV1rOi1Jlr2kXaGoqWo6/Z8D7m655Iy2KS
 gVUmNoq7296FKJ8Wc3po6SMLX0EUmgRAY1aqd5+xPHKZuYYW3H9yoVZKvXCCwiYYi2/YhAZn75A
 nNvmEL7xcS/TuIiCim/7l2Fi1C5ca36CginWFPPhb2FzOC3CR3T0O
X-Received: by 2002:a05:600c:a03:b0:421:499c:7039 with SMTP id
 5b1f17b1804b1-421499c71acmr17540455e9.29.1717488876509; 
 Tue, 04 Jun 2024 01:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGceLO68J3dEVDCj1SyX/h0O7sbzan7Rcq0svs3/Xu0Y4a/XwdiA3uMssH/u9uoUIsODes2Uw==
X-Received: by 2002:a05:600c:a03:b0:421:499c:7039 with SMTP id
 5b1f17b1804b1-421499c71acmr17540145e9.29.1717488875897; 
 Tue, 04 Jun 2024 01:14:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214fdf4953sm7853895e9.25.2024.06.04.01.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 01:14:35 -0700 (PDT)
Message-ID: <d089e681-5fa3-4f97-8637-76376fd4b4fc@redhat.com>
Date: Tue, 4 Jun 2024 10:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <7d5fb5db-8505-469a-a41f-6e18ef8bc77c@redhat.com>
 <SJ0PR11MB67442CF9C141B5C1120CA59092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67442CF9C141B5C1120CA59092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/4/24 07:40, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
>> [set|unset]_iommu_device() callbacks
>>
>> Hi Zhenzhong,
>>
>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
>>> In set call, a new structure VTDHostIOMMUDevice which holds
>>> a reference to HostIOMMUDevice is stored in hash table
>>> indexed by PCI BDF.
>> maybe precise that this is not the aliased one?
> Sure.
>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/i386/intel_iommu_internal.h |  9 ++++
>>>  include/hw/i386/intel_iommu.h  |  2 +
>>>  hw/i386/intel_iommu.c          | 76
>> ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 87 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index f8cf99bddf..b800d62ca0 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -28,6 +28,7 @@
>>>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>  #include "hw/i386/intel_iommu.h"
>>> +#include "sysemu/host_iommu_device.h"
>>>
>>>  /*
>>>   * Intel IOMMU register specification
>>> @@ -537,4 +538,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>>>  #define VTD_SL_TM                   (1ULL << 62)
>>>
>>> +
>>> +typedef struct VTDHostIOMMUDevice {
>>> +    IntelIOMMUState *iommu_state;
>> Why do you need the iommu_state?
> It is used in nesting series.
>
>>> +    PCIBus *bus;
>>> +    uint8_t devfn;
>>> +    HostIOMMUDevice *dev;
>>> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
>>> +} VTDHostIOMMUDevice;
>> How VTD specific is it?
> In nesting series, it has element iommu_state and errata
> which are VTD specific.

so at least I would add a comment in the commit message explaining this.


>
>>>  #endif
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 7d694b0813..2bbde41e45 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -293,6 +293,8 @@ struct IntelIOMMUState {
>>>      /* list of registered notifiers */
>>>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>>>
>>> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice
>> */
>>> +
>>>      /* interrupt remapping */
>>>      bool intr_enabled;              /* Whether guest enabled IR */
>>>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 519063c8f8..747c988bc4 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1,
>> gconstpointer v2)
>>>             (key1->pasid == key2->pasid);
>>>  }
>>>
>>> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
>>> +{
>>> +    const struct vtd_as_key *key1 = v1;
>>> +    const struct vtd_as_key *key2 = v2;
>>> +
>>> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
>>> +}
>> can't you reuse the key with pasid?
> s->vtd_host_iommu_dev isn't indexed by pasid but only BDF.
> Maybe I'd better to define its own key struct, hash() and equal() functions.
you could set a default pasid. But up to you

Eric
>
>>>  /*
>>>   * Note that we use pointer to PCIBus as the key, so hashing/shifting
>>>   * based on the pointer value is intended. Note that we deal with
>>> @@ -3812,6 +3819,70 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>      return vtd_dev_as;
>>>  }
>>>
>>> +static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>> devfn,
>>> +                                     HostIOMMUDevice *hiod, Error **errp)
>>> +{
>>> +    IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hdev;
>>> +    struct vtd_as_key key = {
>>> +        .bus = bus,
>>> +        .devfn = devfn,
>>> +    };
>>> +    struct vtd_as_key *new_key;
>>> +
>>> +    assert(hiod);
>>> +
>>> +    vtd_iommu_lock(s);
>>> +
>>> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
>>> +
>>> +    if (vtd_hdev) {
>>> +        error_setg(errp, "IOMMUFD device already exist");
>> s/IOMMUFD/Host IOMMU device?
> Good catch, will fix.
>
> Thanks
> Zhenzhong
>
>>> +        vtd_iommu_unlock(s);
>>> +        return false;
>>> +    }
>>> +
>>> +    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
>>> +    vtd_hdev->bus = bus;
>>> +    vtd_hdev->devfn = (uint8_t)devfn;
>>> +    vtd_hdev->iommu_state = s;
>>> +    vtd_hdev->dev = hiod;
>>> +
>>> +    new_key = g_malloc(sizeof(*new_key));
>>> +    new_key->bus = bus;
>>> +    new_key->devfn = devfn;
>>> +
>>> +    object_ref(hiod);
>>> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
>>> +
>>> +    vtd_iommu_unlock(s);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int
>> devfn)
>>> +{
>>> +    IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hdev;
>>> +    struct vtd_as_key key = {
>>> +        .bus = bus,
>>> +        .devfn = devfn,
>>> +    };
>>> +
>>> +    vtd_iommu_lock(s);
>>> +
>>> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
>>> +    if (!vtd_hdev) {
>>> +        vtd_iommu_unlock(s);
>>> +        return;
>>> +    }
>>> +
>>> +    g_hash_table_remove(s->vtd_host_iommu_dev, &key);
>>> +    object_unref(vtd_hdev->dev);
>>> +
>>> +    vtd_iommu_unlock(s);
>>> +}
>>> +
>>>  /* Unmap the whole range in the notifier's scope. */
>>>  static void vtd_address_space_unmap(VTDAddressSpace *as,
>> IOMMUNotifier *n)
>>>  {
>>> @@ -4116,6 +4187,8 @@ static AddressSpace
>> *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>>  static PCIIOMMUOps vtd_iommu_ops = {
>>>      .get_address_space = vtd_host_dma_iommu,
>>> +    .set_iommu_device = vtd_dev_set_iommu_device,
>>> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>>>  };
>>>
>>>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>> @@ -4235,6 +4308,9 @@ static void vtd_realize(DeviceState *dev, Error
>> **errp)
>>>                                       g_free, g_free);
>>>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash,
>> vtd_as_equal,
>>>                                        g_free, g_free);
>>> +    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
>>> +                                                  vtd_as_idev_equal,
>>> +                                                  g_free, g_free);
>>>      vtd_init(s);
>>>      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>>>      /* Pseudo address space under root PCI bus. */
>> Thanks
>>
>> Eric


