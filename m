Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E011C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSVv-00028o-EO; Tue, 17 Jun 2025 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSVr-00028M-Bz
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSVj-0006Qq-PL
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750152097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5yKjCNNeruAZkNxjeuEKEwe7iq4DANTcQ4xdjlOPdo=;
 b=JClnjXFwepTe1Ze9LnEv59Qo27zoRZTCKVhMmsDlEKwD2MZjHlMmbBrLeES2x6zJue2QV/
 zomcOs3ZmSUBek7f9ARps4lq78IQyrRBzTdcSqZ7QQ+NUuapLdadlNMAijmbic8q6k62F7
 iulFlgZ+VFFghVY+Cm69jlGqV69uzNA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-9lEoN2XSNkio5fC-4OnCGQ-1; Tue, 17 Jun 2025 05:21:34 -0400
X-MC-Unique: 9lEoN2XSNkio5fC-4OnCGQ-1
X-Mimecast-MFC-AGG-ID: 9lEoN2XSNkio5fC-4OnCGQ_1750152093
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2840792f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750152092; x=1750756892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5yKjCNNeruAZkNxjeuEKEwe7iq4DANTcQ4xdjlOPdo=;
 b=PIXElyJTSkHAnThuhdcqdIZ3P3S7qLbZiQpa3YraF36fWbk01RiDGRD/zJr/EJRnC2
 Id7z3K8MSidoMALUqW0QDTA+87503GAot1ZYtyhsf6mSMq0wTEUtSpfvaRDV1KB4eUBM
 8Qecs93A6N8vPAU+DsXNTSxg21R95hnzDHyQzu9wfGU/yxWYAXkZuT0B/9dAyM+ouYhn
 5LiaJhYVLWwXgq0dlQHjNMbPkH77UIdDXzZo1Qh0y/6p9GQE+esgjfpeb1auD4eTWcsJ
 HhyRbRDdOY0BxYLpp+3AjcP6Bo0zIUTUi+5NkwL5sj6XXuPScUydLnhozkHNEKB4y/8R
 /VCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOvh8G6BOG2lcOpPlhySqEqd0HBVseThBizx0hVj+x1hpDFLzlCNzPFv9X6JNABEqiZ4O9CQ5BDqem@nongnu.org
X-Gm-Message-State: AOJu0YwSjziZeL6jz9AWpQ+IgW19nJy7122IhFTK9dI1IWIQIm0BCnVv
 uVqkmFfie31mqYkx864mPTtKRyZ367hP9lEYoM4Rl6ztJtucAv0Aa+0l7wb27LqGZJPRXUcAXfp
 j1xSDTk9cpKYcWOw/yeXuXnmMw1j3GQ+7Vs5q6V17WHi0fceTyfNuhVfvvFPiJ8pp
X-Gm-Gg: ASbGnctL0GLGMT+TcFFeKh6SBGL8uc6e47YVu4Xqtl/cbksGbF4we+Z12IkrAASmDiZ
 gZwfUXed7hAlHQbruGIRD6yTB/VXJUGlP3c4QzLCNI+ALGVUEApSUp60s1yo0fG5rXLfV37Kvjh
 AEXTi9ZfI9z5GP3DNSeqZes7HA1WnooDYa9u2tmPeMM7VLegbAhjrUL0RReuJjFrz7etRl18V9U
 SIFqAZCjsRxo6xTuSF+DBPXl26bYcVChVx1OvJ4MKc+vH8764qG+rsnZnyP3ODRqNKTvSUM8wWe
 Wu6NlbB+6xuVgeyZ+h5yDEOUf8PP6oYr1iEoRRq74+wgz5VLbkUS/klMw/zkJsE93ILd+A==
X-Received: by 2002:a05:6000:290b:b0:3a5:2e84:cc7b with SMTP id
 ffacd0b85a97d-3a57238b7f2mr9736412f8f.11.1750152092342; 
 Tue, 17 Jun 2025 02:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Vm1iRyQV6g1ZdtMuaZSDvaSR48Ccpmt3DVHgBxgMD0E8bYdtBEcf3fVorHHBV7kEYuA2nw==
X-Received: by 2002:a05:6000:290b:b0:3a5:2e84:cc7b with SMTP id
 ffacd0b85a97d-3a57238b7f2mr9736377f8f.11.1750152091931; 
 Tue, 17 Jun 2025 02:21:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm13081068f8f.89.2025.06.17.02.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 02:21:31 -0700 (PDT)
Message-ID: <096d67cf-d5ba-4041-8919-3e47a9cd10eb@redhat.com>
Date: Tue, 17 Jun 2025 11:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-4-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250613144449.60156-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer,

On 6/13/25 4:44 PM, Shameer Kolothum wrote:
> With the soon to be introduced user-creatable SMMUv3 devices for
> virt, it is possible to have multiple SMMUv3 devices associated
> with different PCIe root complexes.
>
> Update IORT nodes accordingly.
>
> An example IORT Id mappings for a Qemu virt machine with two
> PCIe Root Complexes each assocaited with a SMMUv3 will
> be something like below,
>
>   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
>   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
>   ...
>
>   +--------------------+           +--------------------+
>   |   Root Complex 0   |           |   Root Complex 1   |
>   |                    |           |                    |
>   |  Requestor IDs     |           |  Requestor IDs     |
>   |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
>   +---------+----------+           +---------+----------+
>             |                               |
>             |                               |
>             |       Stream ID Mapping       |
>             v                               v
>   +--------------------+          +--------------------+
>   |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
>   |                    |          |                    |
>   | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
>   | 0x00FF mapped from |          | 0x01FF mapped from |
>   | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
>   +--------------------+          +--------------------+
>             |                                |
>             |                                |
>             +----------------+---------------+
>                              |
>                              |Device ID Mapping
>                              v
>               +----------------------------+
>               |       ITS Node 0           |
>               |                            |
>               | Device IDs:                |
>               | 0x0000 - 0x00FF (from RC0) |
>               | 0x0100 - 0x01FF (from RC1) |
>               | 0x0200 - 0xFFFF (No SMMU)  |
>               +----------------------------+
>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d39506179a..72b79100ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/hmat.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -296,6 +297,58 @@ populate_smmuv3_legacy_dev(GArray *sdev_blob)
>      g_array_append_val(sdev_blob, sdev);
>  }
>  
> +static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
> +{
> +    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
> +    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
> +    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    return map_a->input_base - map_b->input_base;
> +}
> +
> +static int iort_smmuv3_devices(Object *obj, void *opaque)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    GArray *sdev_blob = opaque;
> +    AcpiIortIdMapping idmap;
> +    PlatformBusDevice *pbus;
> +    AcpiIortSMMUv3Dev sdev;
> +    int min_bus, max_bus;
> +    SysBusDevice *sbdev;
> +    PCIBus *bus;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> +        return 0;
> +    }
> +
> +    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
> +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    sbdev = SYS_BUS_DEVICE(obj);
> +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +    sdev.irq += ARM_SPI_BASE;
> +
> +    pci_bus_range(bus, &min_bus, &max_bus);
> +    sdev.idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    idmap.input_base = min_bus << 8,
> +    idmap.id_count = (max_bus - min_bus + 1) << 8,
> +    g_array_append_val(sdev.idmaps, idmap);
> +    g_array_append_val(sdev_blob, sdev);
> +    return 0;
> +}
> +
> +static void populate_smmuv3_dev(GArray *sdev_blob)
> +{
> +    object_child_foreach_recursive(object_get_root(),
> +                                   iort_smmuv3_devices, sdev_blob);
> +    /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
> +    g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
> +}
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -320,6 +373,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      nb_nodes = 2; /* RC, ITS */
>      if (vms->legacy_smmuv3_present) {
>          populate_smmuv3_legacy_dev(smmuv3_devs);
> +    } else {
> +        populate_smmuv3_dev(smmuv3_devs);
>      }
>  
>      num_smmus = smmuv3_devs->len;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


