Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93A8CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22mC-0000xM-BL; Fri, 26 Sep 2025 03:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v22m7-0000sI-AS
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v22ly-0000kt-EV
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758871290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0M6DHrcIlftENbTu2YNpYnWf0KmCbKUek8G5IF4o/Dw=;
 b=Wd8Uno5BZPBk9lazU38H6A3RZ37uteUN0xhBkenbnYrtDXS9jgxZJ7FphdVUbD5nXyn85Q
 grSEYHMFKUd7jTEEc2QzJukBEodlK015hS8IOUn3O9Ex8s04f1jQXUyaCVmpPFsc9xMj1H
 yI2lSNuJZRuC2zXRUbuDLDF9AffVBlU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-0Q-PCzsTM62jEqoj2e3bHQ-1; Fri, 26 Sep 2025 03:21:28 -0400
X-MC-Unique: 0Q-PCzsTM62jEqoj2e3bHQ-1
X-Mimecast-MFC-AGG-ID: 0Q-PCzsTM62jEqoj2e3bHQ_1758871288
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46cde0b2226so4709215e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758871288; x=1759476088;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0M6DHrcIlftENbTu2YNpYnWf0KmCbKUek8G5IF4o/Dw=;
 b=EPnTyyteAsAYpZNt+FtdFWA1VXHqqMNg9pRPlogu9xCG/RcR0nNzoOZdX8npcTLnA3
 121oSVPVaCagxyiix9I8hhVGHg0iL90c93gVDoW0Y99lnasL1SSzSbi+xBVrdYCgLmso
 VVZJUpVd0tpjlfVIPZZ0C6ClH+Sv/5ZIbZgL/soXy6PGus26qqY4J3kJxGV+XIg3S+RC
 E2iWZqx8tXn1m4DLk8vkdWza3oMncoqKOPLuyEn5npwl9sXXhxBx9nJ1MHdhxzxyCeQ3
 yF0DbyoYJ4c/CZr782wAe8TfgNIwnxSRVuuiRZV0H1y0ma81d26moNDgRpL4MnRduemb
 W5kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA4cnE3lxF7hDDmBGwM0XcQbyF2srEjYYUXRtInY+GOjxdd9zePQZD7TV2ZkplRaLqyc7zwodPdmfC@nongnu.org
X-Gm-Message-State: AOJu0YwIFkUugqdzyPxjl+uML48ztFMHWV16ZRevQcQhxk7dT/kgtFLg
 Jp8s7FzHzSD0MoJtbLwSrTrnr0NH7Lb5hMdC+mxivy7XHQqJF68L2LSEO/vpDT9VVo0mea5rJsp
 V9Y0K9HbTNxE/4Ky+sSrk1wWA9FRpg9OwFHWgTL2uqrxFfy3yOS4d6CNh
X-Gm-Gg: ASbGnctGN4xTLe23VYWdU2I75JSlw7QHHlPQOo2jV1ZFq2lEuQSz6l09gJbVZjNoGKg
 1FVQQUeFVAaHK0cFp1cFBim1v0WGv+7ayW0UZol6c0SHyMWB5lcnm9e/ji4E6oSkc613bIeJvhB
 4gHrwo7RUSpRuMHRntTkWHL1pEYGwoavawPpjwVXxASsHlPB39d7V2tnqCVmmEFkX+X3GbhWN5a
 /6xoopWj2agmANvq+Xikf0V7KjeHMQJ5yNuD4nMPmlIDRnomtaBFy5VudE2EniKN8NGP97AQAfd
 i+qgPIDDgGDff+fG9Vx6ibaugPHUyb9PQy2olrL7hYAoH9P9icfo9XPxm31IbySKeeWrB9rj0Hj
 wWFc=
X-Received: by 2002:a05:600c:997:b0:468:7a5a:1494 with SMTP id
 5b1f17b1804b1-46e329a81e7mr32480195e9.1.1758871287586; 
 Fri, 26 Sep 2025 00:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBF6XAN6SvS7vzNfCte5lcQ83wm6wKEgy8Oc9zml+OEyKc9YLkOnvWLfSc516hlbMbpAFNRw==
X-Received: by 2002:a05:600c:997:b0:468:7a5a:1494 with SMTP id
 5b1f17b1804b1-46e329a81e7mr32479995e9.1.1758871287073; 
 Fri, 26 Sep 2025 00:21:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9b6e1bsm117222865e9.10.2025.09.26.00.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:21:26 -0700 (PDT)
Message-ID: <e84f815c-3ec0-4ebf-b50f-87711b707bef@redhat.com>
Date: Fri, 26 Sep 2025 09:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
 device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com
References: <20250919070638.983549-1-zhenzhong.duan@intel.com>
 <20250919070638.983549-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919070638.983549-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/19/25 09:06, Zhenzhong Duan wrote:
> In early days, we have different tricks to ensure caching-mode=on with VFIO
> device:
> 
> 28cf553afe ("intel_iommu: Sanity check vfio-pci config on machine init done")
> c6cbc29d36 ("pc/q35: Disallow vfio-pci hotplug without VT-d caching mode")
> b8d78277c0 ("intel-iommu: fail MAP notifier without caching mode")
> 
> Because without caching mode, MAP notifier won't work correctly since guest
> won't send IOTLB update event when it establishes new mappings in the I/O page
> tables.
> 
> Now with host IOMMU device interface between VFIO and vIOMMU, we can simplify
> it with a small check in set_iommu_device(). This also works for future VDPA
> implementation which may also need caching mode on.
> 
> For coldplug VFIO device:
> 
> qemu-system-x86_64: -device vfio-pci,host=0000:3b:00.0,id=hostdev3,bus=root0,iommufd=iommufd0: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.
> 
> For hotplug VFIO device:
> 
> Error: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 47 ++++++-------------------------------------
>   hw/i386/pc.c          | 20 ------------------
>   2 files changed, 6 insertions(+), 61 deletions(-)

This is a nice cleanup.

Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f04300022e..5c67b42dde 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -85,13 +85,6 @@ struct vtd_iotlb_key {
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>   
> -static void vtd_panic_require_caching_mode(void)
> -{
> -    error_report("We need to set caching-mode=on for intel-iommu to enable "
> -                 "device assignment with IOMMU protection.");
> -    exit(1);
> -}
> -
>   static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                               uint64_t wmask, uint64_t w1cmask)
>   {
> @@ -3731,13 +3724,6 @@ static int vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                            "Snoop Control with vhost or VFIO is not supported");
>           return -ENOTSUP;
>       }
> -    if (!s->caching_mode && (new & IOMMU_NOTIFIER_MAP)) {
> -        error_setg_errno(errp, ENOTSUP,
> -                         "device %02x.%02x.%x requires caching mode",
> -                         pci_bus_num(vtd_as->bus), PCI_SLOT(vtd_as->devfn),
> -                         PCI_FUNC(vtd_as->devfn));
> -        return -ENOTSUP;
> -    }
>       if (!x86_iommu->dt_supported && (new & IOMMU_NOTIFIER_DEVIOTLB_UNMAP)) {
>           error_setg_errno(errp, ENOTSUP,
>                            "device %02x.%02x.%x requires device IOTLB mode",
> @@ -4378,6 +4364,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>   
>       assert(hiod);
>   
> +    if (!s->caching_mode) {
> +        error_setg(errp, "Device assignment is not allowed without enabling "
> +                   "caching-mode=on for Intel IOMMU.");
> +        return false;
> +    }
> +
>       vtd_iommu_lock(s);
>   
>       if (g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
> @@ -4910,32 +4902,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>       return true;
>   }
>   
> -static int vtd_machine_done_notify_one(Object *child, void *unused)
> -{
> -    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> -
> -    /*
> -     * We hard-coded here because vfio-pci is the only special case
> -     * here.  Let's be more elegant in the future when we can, but so
> -     * far there seems to be no better way.
> -     */
> -    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
> -        vtd_panic_require_caching_mode();
> -    }
> -
> -    return 0;
> -}
> -
> -static void vtd_machine_done_hook(Notifier *notifier, void *unused)
> -{
> -    object_child_foreach_recursive(object_get_root(),
> -                                   vtd_machine_done_notify_one, NULL);
> -}
> -
> -static Notifier vtd_machine_done_notify = {
> -    .notify = vtd_machine_done_hook,
> -};
> -
>   static void vtd_realize(DeviceState *dev, Error **errp)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
> @@ -4990,7 +4956,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>       pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>       /* Pseudo address space under root PCI bus. */
>       x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
> -    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
>   }
>   
>   static void vtd_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bc048a6d13..01cd9a67db 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1720,25 +1720,6 @@ static void pc_machine_wakeup(MachineState *machine)
>       cpu_synchronize_all_post_reset();
>   }
>   
> -static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
> -{
> -    X86IOMMUState *iommu = x86_iommu_get_default();
> -    IntelIOMMUState *intel_iommu;
> -
> -    if (iommu &&
> -        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
> -        object_dynamic_cast((Object *)dev, "vfio-pci")) {
> -        intel_iommu = INTEL_IOMMU_DEVICE(iommu);
> -        if (!intel_iommu->caching_mode) {
> -            error_setg(errp, "Device assignment is not allowed without "
> -                       "enabling caching-mode=on for Intel IOMMU.");
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
>   static void pc_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1758,7 +1739,6 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>       x86mc->apic_xrupt_override = true;
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = pc_get_hotplug_handler;
> -    mc->hotplug_allowed = pc_hotplug_allowed;
>       mc->auto_enable_numa_with_memhp = true;
>       mc->auto_enable_numa_with_memdev = true;
>       mc->has_hotpluggable_cpus = true;


