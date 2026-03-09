Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7B8EFCD7C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXhA-0002vn-Ey; Mon, 09 Mar 2026 06:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzXgu-0002tj-U2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzXgr-0004d2-RY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773051499;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8YCq90UjcclfOFZjjnKI8QO7OBSSA6hQoDJ6x4cpXM=;
 b=O2nm7uNAJM/KeGJWMoyS5lNlQZ0yf/UyavC651qymeCfrTFA7NG0iMG+MhK+Vh6qmNElGC
 dPfpZZa4Sc07+M1HvUDvhajFNtCpoDGwYj+QShlUBwVdnvhtalcMCdkJoxh97xqJGRjb54
 v0VGn3LN1f1548gs03BYj510Lfwez4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ltSl_s8NMAGQhIeGztdUDQ-1; Mon, 09 Mar 2026 06:18:18 -0400
X-MC-Unique: ltSl_s8NMAGQhIeGztdUDQ-1
X-Mimecast-MFC-AGG-ID: ltSl_s8NMAGQhIeGztdUDQ_1773051497
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853466655dso11412055e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773051497; x=1773656297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8YCq90UjcclfOFZjjnKI8QO7OBSSA6hQoDJ6x4cpXM=;
 b=J+lXKH/urfrbxH7ACWEWYcdvbz1CSxwxayG02t+MKbeonuoFIsIrOgavJinkWfCI6i
 6GKUw21BQZrxbdO/+fXx0QxO3x2qA8L6iUQqMKMf628yrBu9KKECxV5rOLAMcTU+epAo
 k+TNFQWLQwx50loOhonM3ZDBeHgL4/VwL8hmUEjCJrGCAwywara6nJMa93AnKU60qOQK
 Eu3HUuFAitTz49tVX+2c5VrkIyF5xCDS0Ga2sAxtpf2mE8EMERm2xZbhgpsCKYqkIBQs
 F0+yGslQ9xa3VwzYc3EKQ7IRko+lx2oeHe2oOlz///mLCyPciScU7lKZnaiOmBFcoh77
 HreA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxe09oG0HIlib9UMEcn4/yI7F3lkT1H9vfaJ7sYStvTY6oFPU04V/57rVNwlQBJRKH0Z3CKgbKWPzw@nongnu.org
X-Gm-Message-State: AOJu0YwwstVfTtawTjAANQWqBz0Lm5d8D7EddqzSvZKjE3c3zDd1fx3K
 ZxhIrMQSXCn4+VqyCPEqB+urkC7fCRdnrUCQbHYDGk+9pE1XulRLsRZ1uxEKt+PRWgTmU/b8yU5
 57ZyDj/xfRuj9zrCiu/PLcDrjbV6BC7zDLBx9qZAXSSqkWo9/iSBehxWS
X-Gm-Gg: ATEYQzwqwK/nvenMSLsixT8wv1hrLmGZ0/JMnJCbuGdKt7nkYX5irr+fYuacbHc5TpQ
 jd5woZVH+E40Djam/GnclBBfSXhhGxKfAWC/RducGxQI+ptAW9Au/ryUGY234r9dlX9KK/iDNM6
 qSIIHqfxbQ5gnYzLITSF63LV5gJEv1SJ1Z8w0lwtd29CeaNrXpoK9mn8fOd0yunrpSiG+OXs89O
 JmU80TJa1XGbDph3LQaMxpoWlq678BbczRDuId8xejbSun3AHsH0f+5SiS6noJ8fAVH1P1KUSXY
 /mX9xCg8Q6PnjDlrix100tAYuNC4+Ryafttt6Q2+G12Ihybkq5twJyDc29iTCMTKLiEtS4I9DQ0
 ntdXcvC84PU028D4GfnkcGyf3m02qPkx2gAiNRiaorUObR9UcO3EBScOSCReHr2A0kj02aA==
X-Received: by 2002:a05:600c:3515:b0:485:364e:934e with SMTP id
 5b1f17b1804b1-485364e94admr77136635e9.21.1773051497379; 
 Mon, 09 Mar 2026 03:18:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3515:b0:485:364e:934e with SMTP id
 5b1f17b1804b1-485364e94admr77136175e9.21.1773051496879; 
 Mon, 09 Mar 2026 03:18:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm63890085e9.4.2026.03.09.03.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 03:18:16 -0700 (PDT)
Message-ID: <a1b62ea5-1fb9-4b6a-b413-2c3a71629d1f@redhat.com>
Date: Mon, 9 Mar 2026 11:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/32] hw/arm/virt-acpi-build: Use stored SMMUv3
 devices for IORT build
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-10-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Stop walking the object tree to discover SMMUv3 devices when building
> the IORT table.
>
> Use the SMMUv3 device array maintained by the virt machine instead,
> avoiding recursive object traversal.
>
> No functional change intended.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 70 ++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 544004615d..ae78e9b9e0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -385,49 +385,41 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
>      return map_a->input_base - map_b->input_base;
>  }
>  
> -static int iort_smmuv3_devices(Object *obj, void *opaque)
> -{
> -    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> -    AcpiIortSMMUv3Dev sdev = {0};
> -    GArray *sdev_blob = opaque;
> -    AcpiIortIdMapping idmap;
> -    PlatformBusDevice *pbus;
> -    int min_bus, max_bus;
> -    SysBusDevice *sbdev;
> -    PCIBus *bus;
> -
> -    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> -        return 0;
> -    }
> -
> -    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
> -    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> -    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
> -    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> -    sbdev = SYS_BUS_DEVICE(obj);
> -    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> -    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> -    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
> -    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> -    sdev.irq += ARM_SPI_BASE;
> -
> -    pci_bus_range(bus, &min_bus, &max_bus);
> -    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> -    idmap.input_base = min_bus << 8,
> -    idmap.id_count = (max_bus - min_bus + 1) << 8,
> -    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
> -    g_array_append_val(sdev_blob, sdev);
> -    return 0;
> -}
> -
>  /*
>   * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
>   * return the total number of idmaps.
>   */
> -static int populate_smmuv3_dev(GArray *sdev_blob)
> +static int populate_smmuv3_dev(GArray *sdev_blob, VirtMachineState *vms)
nit: I would prefer vms to be the 1st arg
>  {
> -    object_child_foreach_recursive(object_get_root(),
> -                                   iort_smmuv3_devices, sdev_blob);
> +    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
> +        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
> +        AcpiIortSMMUv3Dev sdev = {0};
> +        AcpiIortIdMapping idmap;
> +        PlatformBusDevice *pbus;
> +        int min_bus, max_bus;
> +        SysBusDevice *sbdev;
> +        PCIBus *bus;
> +
> +        bus = PCI_BUS(object_property_get_link(obj, "primary-bus",
> +                                               &error_abort));
> +        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> +        sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
> +        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +        sbdev = SYS_BUS_DEVICE(obj);
> +        sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +        sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +        sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +        sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +        sdev.irq += ARM_SPI_BASE;
> +
> +        pci_bus_range(bus, &min_bus, &max_bus);
> +        sdev.rc_smmu_idmaps = g_array_new(false, true,
> +                                          sizeof(AcpiIortIdMapping));
> +        idmap.input_base = min_bus << 8;
> +        idmap.id_count = (max_bus - min_bus + 1) << 8;
> +        g_array_append_val(sdev.rc_smmu_idmaps, idmap);
> +        g_array_append_val(sdev_blob, sdev);
> +    }
>      /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
>      g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
>      /*
> @@ -561,7 +553,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      if (vms->legacy_smmuv3_present) {
>          rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
>      } else {
> -        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
> +        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs, vms);
So did you check this does not break existing bios qtests (as we change
the way we iterate on the devices)? If so maybe add a comment in commit
description.
>      }
>  
>      num_smmus = smmuv3_devs->len;
I would squash previous patch in that one.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


