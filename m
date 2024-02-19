Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A8C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc7j9-0002Ap-Nj; Mon, 19 Feb 2024 12:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7j3-0002AN-5z
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7j1-0006rA-Ae
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708364802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjB/RAxotsZCWqt5XLgSLluD+e5KjLTrSK7blaWPM78=;
 b=OrEP2WTQYNFSmboXFCy834E4mQCzOmZAroKFhAI0LXjbgn0XLFyPVNT60Sd+KX3jFQyQxz
 ekkCK4B6KniPeUUkE+g/vhXAvsSHUjTj4XNf1arY7g+HnOvC9ncFAqZMWY8E2SYYqUh3oQ
 HsOZs0HUiKQXNijxCCNBSp8gNs2AVjQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9jmemBc1Nb23_GfgfE5ItQ-1; Mon, 19 Feb 2024 12:46:40 -0500
X-MC-Unique: 9jmemBc1Nb23_GfgfE5ItQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-785db68c0b2so469498285a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708364800; x=1708969600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PjB/RAxotsZCWqt5XLgSLluD+e5KjLTrSK7blaWPM78=;
 b=roqYn27UXA8LBBn03bWkZRh1oQNMaow4fzTFSqclCH3TJMzX3joYh62e2kpd3qMzHm
 L+Bv/ralbSTkF94iMJ2tZKvm5aced3JNh24dgS/VTlpM+anw1V+M9h/XG3mhWqcZ/Srg
 D1cRRhJxu0/SThPWHbJ4B8w2mWkzhukWXsteEH47kN1FKmk7rREZJJiJhqNV9NFy9B1j
 DpEZanmcNopj+v0KFPtxq99PBoIFN3OgE8WC2GJ5X8iT9OeNjmdWEMKc9BQzThQQ7EVi
 Yue4ZhNak3DDxNgVKHXmmTn/MWwMT54zPW/xJE+/dAVrcGm/+Mfp5MsZQHHth43GIVWh
 kBKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ZddntQGXdLbnZdOJpbAX+hqnWB9BMPQFhT0dIjbtPQJdbXgxdunTpb5RqogahElbaezqtiwnbDL+qKV6PMKudE3R5Kc=
X-Gm-Message-State: AOJu0YzU1Ro8eGmXSlxynqQDjOhwHGJRjIz2xQgW2ACBwJs/JEQ9/oh7
 APxEP/KrXcFtfQ6+yzyhxrhriUg7lbcL6NJTcsRkZ+oTd8KMvLcvFExPp3kAwDftUwy3x9yMnZG
 bxBTfEzaoBKEbpJTpZReTeL7fcdBpMSAxdnpS/DQAoTr8WdKx/tbm
X-Received: by 2002:a05:620a:a0b:b0:787:3503:6c71 with SMTP id
 i11-20020a05620a0a0b00b0078735036c71mr11678473qka.5.1708364799733; 
 Mon, 19 Feb 2024 09:46:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCVFA3i8XzSjppj50Bt/VgXH83K+p0wIMa6Ba8HWezP2aNswIx97O+Bo6pSebxi0GsyUJAgg==
X-Received: by 2002:a05:620a:a0b:b0:787:3503:6c71 with SMTP id
 i11-20020a05620a0a0b00b0078735036c71mr11678444qka.5.1708364799351; 
 Mon, 19 Feb 2024 09:46:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a05620a16cd00b0078715cd3116sm2679226qkn.106.2024.02.19.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 09:46:38 -0800 (PST)
Message-ID: <5ce5af6a-1279-44a0-87ca-820021d41a18@redhat.com>
Date: Mon, 19 Feb 2024 18:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 11/18] intel_iommu: Add set/unset_iommu_device
 callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240201072818.327930-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 2/1/24 08:28, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds set/unset_iommu_device() implementation in Intel vIOMMU.
> In set call, a pointer to host IOMMU device info is stored in hash
> table indexed by PCI BDF.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h | 14 +++++++
>  include/hw/i386/intel_iommu.h  |  2 +
>  hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f8cf99bddf..3301f54b35 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -28,6 +28,8 @@
>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>  #include "hw/i386/intel_iommu.h"
> +#include "sysemu/host_iommu_device.h"
> +#include "hw/vfio/vfio-common.h"
>  
>  /*
>   * Intel IOMMU register specification
> @@ -537,4 +539,16 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>  #define VTD_SL_TM                   (1ULL << 62)
>  
> +
> +typedef struct VTDHostIOMMUDevice {
> +    IntelIOMMUState *iommu_state;
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    union {
> +        HostIOMMUDevice *dev;
> +        IOMMULegacyDevice *ldev;
> +        IOMMUFDDevice *idev;
> +    };
again this looks really weird to me. Why don't we simply have

HostIOMMUDevice *dev;

> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
> +} VTDHostIOMMUDevice;
>  #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..bbc7b96add 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -292,6 +292,8 @@ struct IntelIOMMUState {
>      /* list of registered notifiers */
>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>  
> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
> +
>      /* interrupt remapping */
>      bool intr_enabled;              /* Whether guest enabled IR */
>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1a07faddb4..9b62441439 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1, gconstpointer v2)
>             (key1->pasid == key2->pasid);
>  }
>  
> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct vtd_as_key *key1 = v1;
> +    const struct vtd_as_key *key2 = v2;
> +
> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
> +}
>  /*
>   * Note that we use pointer to PCIBus as the key, so hashing/shifting
>   * based on the pointer value is intended. Note that we deal with
> @@ -3812,6 +3819,68 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                    HostIOMMUDevice *base_dev, Error **errp)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hdev;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +    };
> +    struct vtd_as_key *new_key;
> +
> +    assert(base_dev);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +
> +    if (vtd_hdev) {
> +        error_setg(errp, "IOMMUFD device already exist");
> +        vtd_iommu_unlock(s);
> +        return -EEXIST;
> +    }
> +
> +    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
> +    vtd_hdev->bus = bus;
> +    vtd_hdev->devfn = (uint8_t)devfn;
> +    vtd_hdev->iommu_state = s;
> +    vtd_hdev->dev = base_dev;
and here you set the base pointer.
> +
> +    new_key = g_malloc(sizeof(*new_key));
> +    new_key->bus = bus;
> +    new_key->devfn = devfn;
> +
> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
> +
> +    vtd_iommu_unlock(s);
> +
> +    return 0;
> +}
> +
> +static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hdev;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +    };
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +    if (!vtd_hdev) {
> +        vtd_iommu_unlock(s);
> +        return;
> +    }
> +
> +    g_hash_table_remove(s->vtd_host_iommu_dev, &key);
> +
> +    vtd_iommu_unlock(s);
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> @@ -4107,6 +4176,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>  static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
> +    .set_iommu_device = vtd_dev_set_iommu_device,
> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4230,6 +4301,9 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
>                                        g_free, g_free);
> +    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
> +                                                  vtd_as_idev_equal,
> +                                                  g_free, g_free);
>      vtd_init(s);
>      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>      /* Pseudo address space under root PCI bus. */
Eric


