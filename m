Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C88CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMczi-0004Ei-UF; Fri, 21 Nov 2025 21:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMcAd-0006wz-Rd; Fri, 21 Nov 2025 20:12:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMcAS-0004dw-Pt; Fri, 21 Nov 2025 20:12:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5ALC5PTd002022
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 21:05:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+5GNtLSFKyQzhBbZfhNfyO2/GtHz4fBldl1unhI9Xjk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763726725; v=1;
 b=HrL0XQTYBRNpwmKEEvNw+rk36Pgg+a+5ccfZxKvh6MMUZ0VBkoHzMT27L70nfY1M
 YuCyfoooSAQ0H1IV4ygZtI1W7jWQEEmRZa3fyDFaCTEDXr2b5PRqryUpgGsg+Bt9
 aUmcgEJF0EcfU+OdZSpo0+yHOscJZcNaQM+srxu/G4XaqyAql6EkXBm8jn67At6E
 bzIxs+b3dIkFv1FDs42eH3f5JwW4nOmdEoc2W62CJ/3qQzG9j0Y9OV6oCwAXvseb
 FSX0Lgt+ryLD8JyppJX++nT3hMhw3zgglACgI8iYfLtLFNSGvmFUFb97GtjwiCwz
 RcXVuV/AOOIMWkVhEr0BvA==
Message-ID: <6ffd15c9-3928-4b66-a004-e9864432773e@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 21:05:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/28] hw: arm: virt: rework MSI-X configuration
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
 <20251121100240.89117-18-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251121100240.89117-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2025/11/21 19:02, Mohamed Mediouni wrote:
> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
> 
> Remove vms->its as it's no longer needed after that change.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c |   3 +-
>   hw/arm/virt.c            | 111 +++++++++++++++++++++++++++++++--------
>   include/hw/arm/virt.h    |   4 +-
>   3 files changed, 94 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c8ac58b64e..15e6239e5f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -962,8 +962,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           }
>       }
>   
> -    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms))
> -     && !vms->no_gicv3_with_gicv2m) {
> +    if (virt_is_gicv2m_enabled(vms)) {
>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>   
>           /* 5.2.12.16 GIC MSI Frame Structure */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ddc6d4d3b1..7b776187f8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -967,12 +967,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>   
>       fdt_add_gic_node(vms);
>   
> -    if (vms->gic_version != VIRT_GIC_VERSION_2 && virt_is_its_enabled(vms)) {
> +    if (virt_is_its_enabled(vms)) {
>           create_its(vms);
> -    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
> -        create_v2m(vms);
> -    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +    } else if (virt_is_gicv2m_enabled(vms)) {
>           create_v2m(vms);
> +    } else {
> +        vms->msi_controller = VIRT_MSI_CTRL_NONE;
>       }
>   }
>   
> @@ -2713,32 +2713,94 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
>   
>   bool virt_is_its_enabled(VirtMachineState *vms)
>   {
> -    if (vms->its == ON_OFF_AUTO_OFF) {
> -        return false;
> +    switch (vms->msi_controller) {
> +        case VIRT_MSI_CTRL_NONE:
> +            return false;
> +        case VIRT_MSI_CTRL_ITS:
> +            return true;
> +        case VIRT_MSI_CTRL_GICV2M:
> +            return false;
> +        case VIRT_MSI_CTRL_AUTO:
> +            if (whpx_enabled() && whpx_irqchip_in_kernel()) {
> +                return false;
> +            }
> +            if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +                return false;
> +            }
> +            return true;
> +        default:
> +            return false;
>       }
> -    if (vms->its == ON_OFF_AUTO_AUTO) {
> -        if (whpx_enabled()) {
> +}
> +
> +bool virt_is_gicv2m_enabled(VirtMachineState *vms)
> +{
> +    switch (vms->msi_controller) {
> +        case VIRT_MSI_CTRL_NONE:
>               return false;
> -        }
> +        default:
> +            return !virt_is_its_enabled(vms);
>       }
> -    return true;
>   }
>   
> -static void virt_get_its(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static char *virt_get_msi(Object *obj, Error **errp)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(obj);
> -    OnOffAuto its = vms->its;
> +    const char *val;
>   
> -    visit_type_OnOffAuto(v, name, &its, errp);
> +    switch (vms->msi_controller) {
> +    case VIRT_MSI_CTRL_NONE:
> +        val = "off";
> +        break;
> +    case VIRT_MSI_CTRL_ITS:
> +        val = "its";
> +        break;
> +    case VIRT_MSI_CTRL_GICV2M:
> +        val = "gicv2m";
> +        break;
> +    default:
> +        val = "auto";
> +        break;
> +    }
> +    return g_strdup(val);
>   }
>   
> -static void virt_set_its(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static void virt_set_msi(Object *obj, const char *value, Error **errp)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(obj);
>   
> -    visit_type_OnOffAuto(v, name, &vms->its, errp);
> +    if (!strcmp(value, "auto")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
> +    } else if (!strcmp(value, "its")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_ITS;
> +    } else if (!strcmp(value, "gicv2m")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +    } else if (!strcmp(value, "none")) {
> +        vms->msi_controller = VIRT_MSI_CTRL_NONE;
> +    } else {
> +        error_setg(errp, "Invalid msi value");
> +        error_append_hint(errp, "Valid values are auto, gicv2m, its, off\n");

This should have ERRP_GUARD().

> +    }
> +}
> +
> +static bool virt_get_its(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return virt_is_its_enabled(vms);
> +}
> +
> +static void virt_set_its(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    if (value) {
> +        vms->msi_controller = VIRT_MSI_CTRL_ITS;
> +    } else if (vms->no_gicv3_with_gicv2m) {
> +        vms->msi_controller = VIRT_MSI_CTRL_NONE;
> +    } else {
> +        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> +    }
>   }
>   
>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
> @@ -3065,6 +3127,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>               db_start = base_memmap[VIRT_GIC_V2M].base;
>               db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
>               break;
> +        case VIRT_MSI_CTRL_AUTO:
> +            g_assert_not_reached();
>           }
>           resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>                                           db_start, db_end,
> @@ -3455,13 +3519,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                             "guest CPU which implements the ARM "
>                                             "Memory Tagging Extension");
>   
> -    object_class_property_add(oc, "its", "OnOffAuto",
> -        virt_get_its, virt_set_its,
> -        NULL, NULL);
> +    object_class_property_add_bool(oc, "its", virt_get_its,
> +                                   virt_set_its);
>       object_class_property_set_description(oc, "its",
>                                             "Set on/off to enable/disable "
>                                             "ITS instantiation");
>   
> +    object_class_property_add_str(oc, "msi", virt_get_msi,
> +                                  virt_set_msi);
> +    object_class_property_set_description(oc, "msi",
> +                                          "Set MSI settings. "
> +                                          "Valid values are auto/gicv2m/its/off");
> +
>       object_class_property_add_bool(oc, "dtb-randomness",
>                                      virt_get_dtb_randomness,
>                                      virt_set_dtb_randomness);
> @@ -3518,7 +3587,7 @@ static void virt_instance_init(Object *obj)
>       vms->highmem_redists = true;
>   
>       /* Default allows ITS instantiation if available */
> -    vms->its = ON_OFF_AUTO_AUTO;
> +    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
>       /* Allow ITS emulation if the machine version supports it */
>       vms->tcg_its = !vmc->no_tcg_its;
>       vms->no_gicv3_with_gicv2m = false;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index abacc366bf..8d6493ae7f 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
>   
>   typedef enum VirtMSIControllerType {
>       VIRT_MSI_CTRL_NONE,
> +    /* This value is overriden at runtime.*/
> +    VIRT_MSI_CTRL_AUTO,
>       VIRT_MSI_CTRL_GICV2M,
>       VIRT_MSI_CTRL_ITS,
>   } VirtMSIControllerType;
> @@ -147,7 +149,6 @@ struct VirtMachineState {
>       bool highmem_ecam;
>       bool highmem_mmio;
>       bool highmem_redists;
> -    OnOffAuto its;
>       bool tcg_its;
>       bool virt;
>       bool ras;
> @@ -217,5 +218,6 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
>   }
>   
>   bool virt_is_its_enabled(VirtMachineState *vms);
> +bool virt_is_gicv2m_enabled(VirtMachineState *vms);
>   
>   #endif /* QEMU_ARM_VIRT_H */


