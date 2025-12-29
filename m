Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58636E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIF5-0002E8-3R; Mon, 29 Dec 2025 13:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIEz-0002Ch-A5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:45:13 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaIEx-0007zW-7f
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:45:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a081c163b0so88008695ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767033910; x=1767638710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L5b0ZmnLwNNT+g6DJnrDN46+Pb4pwpxsVnlZ830iB9g=;
 b=QeB7Ejp9rANwbdOD8EcxHxfV9UwEpM9uh/Q9RQxotqsSb3+hB8JjrGNuXiPm83d7EL
 FNZjUdS4OJZ8UNCM8k7MtXDZ0cicBfSoXlV01Zp9xrZU5n/1u2BX3gX8dUihzQUmh7qE
 pwmYhdZJeyTliiHs9xsHANjEaAxZdOKMLFxRrMTWqFNV4Vx6Hn+qJe3D2ikadcELAtxY
 mUDiBnVjc5VRZHeFy8YtgFpGVrQvqBJIzupl3u6dEnWl52GPdJ6R0ye5lY9xZBq0UU3h
 jF0jorpqJbq4RWOrOvecThDvpOjqPXfZOHkqQjOnb7RgoZjD4AlkabLV3Iikae/BTA9I
 WktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767033910; x=1767638710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5b0ZmnLwNNT+g6DJnrDN46+Pb4pwpxsVnlZ830iB9g=;
 b=i/KIbPzNrxFhKjVasL2wbfeayHrfJfH7sfrKZImcmlLmPI0FjZgn2DfqAf9aYkZC0c
 j/Dizd/llemgWSmenHcOaXsVQ0g8TS9TPu21VW4GzBTRCeQ35rPjYpgZSXn96wi58Y/H
 OKFnY3leOW2zXESxKXsYzjvNz80EyP0sVdDXLV+ZaDuzg39BAbNEPgIYI7WRzD5Non0P
 7FWmu2BcxdwxvqmU7kdwu6XvM8DCv++ISi8VFC0BKLoLA47cJElUxuba0JmtvlXJVcZa
 3RBroFJ6EKZLCOJUXsxi3Dxg3n76svytenUpENXD2PfNk0Mzm+asZl84dXJ48LvBbVuE
 SPyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDmLJWmdkCFguyxiyfzCnIPqiJtw6dApn2M3keKGWeoy2fnRbgxB2uSDBnF7b1SkKW2zdRBOKJTRyj@nongnu.org
X-Gm-Message-State: AOJu0YynGkQpDI5DJMJs25K1WsnrYjbw+vsVc7gwUY0eoPvgvm9XtOOL
 jhMO4myKnJgwrIcyPwiQPM8XtuZhgSd1xBq+iGahALE4RLgxW4AixvWvIfobVytXMN8=
X-Gm-Gg: AY/fxX55fTDySsGJwpCa87nF1PTkjR6KfUtyulhwoz3mYVYrbEV4pPnqFfIJhJh801/
 EH3l06N9Q6f3XZKdpLnM3o/EkSo2se59pOTxzx17XxryNb9ArhuoIZVemeFFUj+TCFTbFmJa9TR
 Sl6/BPhS89gL3N89ml8EkmGyKMxu+ul9ubOgSn7oI1D4MLRrz0n+t/se9INczQ7JEvFoJAgvAxG
 mmwYEavrhgRsHRzMi6sSJkijMDGeyGKPIDVrR4/LcrGmdjCmY+wz2Yhu8pdabYeBjcHyQHwRy+4
 PcNyEg9S5tUt8iMxF0xPccugfF4RDRa5fTXomi/xhrJ61ToM3FW1RHy4YCrBrytALKvKbbMayCb
 EkDhWEXWyPxWLElXFFC2F5u+f78HZGUoaWktRrWicUQ6J/bbNPZDe2Fyrdla3buq/zdP/PkIdc8
 dk6ZFjMm28Q5AYtpf49bnf1UF7uKJbwtgKwSfShURj/RCarIFSK1FAL+0p
X-Google-Smtp-Source: AGHT+IExCqEi/ChGsKnsoyZoiipt0DrI7F6rVRq1e9X0KXF+Rj/pzZvX2cLlIQiAOX+og9f6vzqWRA==
X-Received: by 2002:a17:903:b8b:b0:2a1:243:94a8 with SMTP id
 d9443c01a7336-2a2f2a4f102mr333447125ad.49.1767033909492; 
 Mon, 29 Dec 2025 10:45:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d663sm278943885ad.77.2025.12.29.10.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 10:45:09 -0800 (PST)
Message-ID: <e250a18d-9b08-4cb9-88d6-c21d0b8ed60b@linaro.org>
Date: Mon, 29 Dec 2025 10:45:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/28] hw: arm: virt: rework MSI-X configuration
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-8-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
> 
> Remove vms->its as it's no longer needed after that change.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c |   3 +-
>   hw/arm/virt.c            | 112 +++++++++++++++++++++++++++++++--------
>   include/hw/arm/virt.h    |   4 +-
>   3 files changed, 95 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 86024a1a73..f3adb95cfe 100644
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
> index dcdb740586..80c9b2bc76 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -966,12 +966,12 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
> @@ -2710,32 +2710,95 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
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

ERROR: switch and case should be at the same indent
#63: FILE: hw/arm/virt.c:2713:
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
[...]
+        case VIRT_MSI_CTRL_ITS:
[...]
+        case VIRT_MSI_CTRL_GICV2M:
[...]
+        case VIRT_MSI_CTRL_AUTO:
[...]
+        default:

> +
> +bool virt_is_gicv2m_enabled(VirtMachineState *vms)
> +{
> +    switch (vms->msi_controller) {
> +        case VIRT_MSI_CTRL_NONE:
>               return false;
> -        }
> +        default:
> +            return !virt_is_its_enabled(vms);

#89: FILE: hw/arm/virt.c:2735:
+    switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
[...]
+        default:

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
> +    ERRP_GUARD();
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
> @@ -3062,6 +3125,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>               db_start = base_memmap[VIRT_GIC_V2M].base;
>               db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
>               break;
> +        case VIRT_MSI_CTRL_AUTO:
> +            g_assert_not_reached();
>           }
>           resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>                                           db_start, db_end,
> @@ -3452,13 +3517,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
> @@ -3515,7 +3585,7 @@ static void virt_instance_init(Object *obj)
>       vms->highmem_redists = true;
>   
>       /* Default allows ITS instantiation if available */
> -    vms->its = ON_OFF_AUTO_AUTO;
> +    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
>       /* Allow ITS emulation if the machine version supports it */
>       vms->tcg_its = !vmc->no_tcg_its;
>       vms->no_gicv3_with_gicv2m = false;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 394b70c62e..ff43bcb739 100644
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


