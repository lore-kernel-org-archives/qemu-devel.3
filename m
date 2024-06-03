Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A31C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8yB-00068u-Ug; Mon, 03 Jun 2024 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE8yB-00068f-8F
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE8y9-00089y-5T
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717426047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07LiMA+Dy6IUI8ZOg0wYUYuw0/iNPlVSuGMmvSeSdAo=;
 b=g72VT4JUZH9ZL/aHHKz+jz0BoSeddGRmXfdgjofFUqI/Qv9Z8eg959nFc+Hx9F5bHT3EHW
 1l+m/8rsX9CQWeKV6FuSkhKVWwlXyWrfmXKWRzKdcLHivlVvWc84SsRLEuMtrK8hb9LSfk
 +dC9+q1hrWkndQdyr5iUqSXy6CGCbDE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-tDgqCm1rN0GxSHi2Cf0TlA-1; Mon, 03 Jun 2024 10:47:26 -0400
X-MC-Unique: tDgqCm1rN0GxSHi2Cf0TlA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dcde1be6cso1597f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717426045; x=1718030845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07LiMA+Dy6IUI8ZOg0wYUYuw0/iNPlVSuGMmvSeSdAo=;
 b=MbmEBXS6YzKSy+RzHDjwW9urz0PECHur4zHZGbFDHbNGwW/mU51pJIBqHFPxAjfaTz
 2UKoq817JyrfEOX49Yq3wapsxPiAN7RMBLDEWId+M3RNZH5yM6oL9iNe9Cz78cqRrPnr
 hpN2bkNRgH5p4/s0sclNlj9JgXvOXCycA0iOiBYFuUDMTuuZ3+ssu6EFDsVE+OlcEvdB
 JqIpxYBBwpjrHC0hJgLKr8YuIw8kEdUu9bYH7YKVFJCmhmXH2sSGgVEWCWSjg7MW3hqP
 eY/MJU1+C1N4BBjMw52XHdHscV7l07AlGlqKLLxPkJouCmxNHjSfWuueKe/9YnLmZ0qG
 cBRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX608HV7NEBDo5I0CudKbsyW54JeCWO58EeqXPpeL0BxzXOkgyQ7XSLIf+hFMR3dVh6q+4ONF0KKoX7BkLmab4pCeBHRSY=
X-Gm-Message-State: AOJu0Ywf0UgmNQ5tM4HZ4nuxYdc3mqwq4Rg9m4D7H1te72VFNI/j4SXN
 5brFlMjJ81tgxJe8cF5IvBZkMNzmiKx/Ic4kebCWdX6ECIIwJA9l4J0c4dWp3Ws5SHIZynH7lS7
 0TXpUISOBofedU2bUVUHPthoxzsseGHjogz+e4kqD3xKoTtObkqMX
X-Received: by 2002:adf:a359:0:b0:35d:cc52:aaf8 with SMTP id
 ffacd0b85a97d-35e0f32ef5amr6576252f8f.60.1717426045111; 
 Mon, 03 Jun 2024 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoT1bF9hxen0o2If9U1nDszjrAA/n8z/n+D5BstQwVGRHRb9UufpXXv+VSq0cuUY3gGxcMPA==
X-Received: by 2002:adf:a359:0:b0:35d:cc52:aaf8 with SMTP id
 ffacd0b85a97d-35e0f32ef5amr6576226f8f.60.1717426044669; 
 Mon, 03 Jun 2024 07:47:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d94e6sm8901983f8f.51.2024.06.03.07.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:47:24 -0700 (PDT)
Message-ID: <fcec6a43-3ac1-46fd-aca2-96097b85175a@redhat.com>
Date: Mon, 3 Jun 2024 16:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
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



On 6/3/24 08:10, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
> In set call, a new structure VTDHostIOMMUDevice which holds
> a reference to HostIOMMUDevice is stored in hash table
> indexed by PCI BDF.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  9 ++++
>  include/hw/i386/intel_iommu.h  |  2 +
>  hw/i386/intel_iommu.c          | 76 ++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f8cf99bddf..b800d62ca0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -28,6 +28,7 @@
>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>  #include "hw/i386/intel_iommu.h"
> +#include "sysemu/host_iommu_device.h"
>  
>  /*
>   * Intel IOMMU register specification
> @@ -537,4 +538,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>  #define VTD_SL_TM                   (1ULL << 62)
>  
> +
> +typedef struct VTDHostIOMMUDevice {
> +    IntelIOMMUState *iommu_state;
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    HostIOMMUDevice *dev;
> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
> +} VTDHostIOMMUDevice;
>  #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7d694b0813..2bbde41e45 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -293,6 +293,8 @@ struct IntelIOMMUState {
>      /* list of registered notifiers */
>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>  
> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
> +
>      /* interrupt remapping */
>      bool intr_enabled;              /* Whether guest enabled IR */
>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 519063c8f8..747c988bc4 100644
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
> @@ -3812,6 +3819,70 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> +static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                     HostIOMMUDevice *hiod, Error **errp)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hdev;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +    };
> +    struct vtd_as_key *new_key;
> +
> +    assert(hiod);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +
> +    if (vtd_hdev) {
> +        error_setg(errp, "IOMMUFD device already exist");
> +        vtd_iommu_unlock(s);
> +        return false;
> +    }
> +
> +    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
> +    vtd_hdev->bus = bus;
> +    vtd_hdev->devfn = (uint8_t)devfn;
> +    vtd_hdev->iommu_state = s;
> +    vtd_hdev->dev = hiod;
I am still not totally clear about why we couldn't reuse VTDAddressSpace
instance for this bus/devid. Is it a matter of aliased versus non
aliased bus/devfn, or a matter of pasid diff. An AddressSpace could back
an assigned device in which case a HostIOMMUDevice could be added to
this latter. I think this should be explained in the commit msg

Eric
> +
> +    new_key = g_malloc(sizeof(*new_key));
> +    new_key->bus = bus;
> +    new_key->devfn = devfn;
> +
> +    object_ref(hiod);
> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
> +
> +    vtd_iommu_unlock(s);
> +
> +    return true;
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
> +    object_unref(vtd_hdev->dev);
> +
> +    vtd_iommu_unlock(s);
> +}
> +
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> @@ -4116,6 +4187,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>  static PCIIOMMUOps vtd_iommu_ops = {
>      .get_address_space = vtd_host_dma_iommu,
> +    .set_iommu_device = vtd_dev_set_iommu_device,
> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>  };
>  
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4235,6 +4308,9 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
>                                        g_free, g_free);
> +    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
> +                                                  vtd_as_idev_equal,
> +                                                  g_free, g_free);
>      vtd_init(s);
>      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>      /* Pseudo address space under root PCI bus. */


