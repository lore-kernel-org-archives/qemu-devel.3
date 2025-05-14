Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBACC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFF9g-0000bt-6W; Wed, 14 May 2025 12:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uFEqK-00054G-Nt
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:20:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uFEqH-0000c4-1e
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:20:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so57885e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747239616; x=1747844416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1aXl1eViToMl9JPTvZ+ucdanKKTMhp7uZv/rNwK4io=;
 b=Lirivbl5AhQEXZ45wOrtTshI/uDlm8DJHM7CiDHoWfFnfFEn8PYEV7ENFCR2SH7x+v
 BMI7ja0I64fU6290Xt+oUotffLZRQsaLV2SUInf6oJy/xP5uGxfbd+7ackKd2rX83umB
 ZgpV11tDe5kLfh7f9QlcXUvZ8FjIxyW8hOA27qHP9s62zpkSXXrWYPXbQa8gIuf89Gbr
 VWQmDsIAAZ7LRRddb9gGy8BOQUNsc4IlYgOa5CM9OckXCVoDffyUSXU9lfG/bmn2z6hD
 NBngBCoEKZuAKwuGm6xlu6EByNh8+Xe2cfRPoBxxhol+W+S4mKzEXbpWdzUyCu6UIyhn
 teIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239616; x=1747844416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1aXl1eViToMl9JPTvZ+ucdanKKTMhp7uZv/rNwK4io=;
 b=uVkRWtmzeo57yRXaKVsIHaQD9u2yAK84ZPluupMKy4hfnliQmAdcZza96FrGH7KDc7
 aBKFZ4tcOmu6jvNWuLr4SNW0JMuP1X8I9tcrgd0bv50QoseYi9IAdBVKNKinq6Rpwwy7
 vld9f4Q8LqltNEuaRjELtp1xLXiV0TjR5wPuVC5gvnt2qwQvHDtCn1bBLRmZrWHK8Vma
 gaV90TawM3g/Brkp59uP8CV6O4XloKuCvXN4+9h4gPIRNxbzF8JSEnq9+uV5wpHNA/gA
 zAk3vn0fCo0IWBJCfHMS4sQDP9YuoySF+YRjGZroirp0VukTf7fzMgPRGHHQ0Gp/JBQf
 tKaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrlnmy7RDlOrh2d71teXOriQuoTuYFQ/tPW0728aZoBwlGPMhpsrIuE3jACPPJh6VDYQX6tY60C0WP@nongnu.org
X-Gm-Message-State: AOJu0YwVh2ZyyRXOdMJZtblEHy7P2BSARPqiNHvuYRF4gQY8CtVGOQKZ
 CAWmf1illIeSVDepEsEnxOAzFiis4u0nnoVrDNz/MimaWC8vO02/FN9d/CGtMn0=
X-Gm-Gg: ASbGncsN2lRPmaluXIxjSqYryxDQw3ld/JsdbaGDpq2NQ7eFIdtsx2jALdXHajAw6fw
 h7JDk5sGJvIPL6QYNpLlXAD+P9XaRhYB2O4YvgxToSXCOZFvga8gLvaTyy+abzEz0CUakO4thRv
 0wPWA7MuQiyyJMXet7y4DjOv0ejqK9gBeZEm0k+pKZNI0OnHDXuiI7bibVGUj2lG/z+nwhJ5psP
 kD4cIUo6lc5uu9l5ij5z1R5hnO79+FloYGZZhu9/IzNxivmU4EyJ8+qddi/948SkQu9K8WsB+1q
 ah8HkjAFRhjvDBA8OikFWtK2PDmxekwHFKxNFdFLo4er2bAPhQGaShOt7Y3oDthINcVb/DwRj1I
 pCRYzx4rWcDnj5A==
X-Google-Smtp-Source: AGHT+IHgz4VkA8Td0bpsVOrOmG9oh508VrYWrPOXbm7BlCG4Ws0Y8fYyWkiYUvY8fglVNGUwl1yn/Q==
X-Received: by 2002:a05:600c:1f95:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-442f20e85d7mr44469095e9.10.1747239615814; 
 Wed, 14 May 2025 09:20:15 -0700 (PDT)
Received: from [10.93.18.105] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db47sm34846335e9.12.2025.05.14.09.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:20:15 -0700 (PDT)
Message-ID: <e68728e0-c478-475c-8cab-f64907afbcfb@linaro.org>
Date: Wed, 14 May 2025 17:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/24] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-19-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250428102628.378046-19-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> QEMU will notify the OS about PCI hotplug/hotunplug events through
> GED interrupts. Let the GED device handle a new PCI hotplug event.
> On its occurence it calls the \\_SB.PCI0.PCNT method with the BLCK

nit: occurrence -^


> mutex held.
> 
> The GED device uses a dedicated MMIO region that will be mapped
> by the machine code.
> 
> At this point the GED still does not support PCI device hotplug in
> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
> subsequent patch

nit: period missing ^


> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/generic_event_device.h |  5 +++++
>   include/hw/acpi/pcihp.h                |  2 ++
>   hw/acpi/generic_event_device.c         | 14 ++++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d2dac87b4a..28be6c0582 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -63,6 +63,7 @@
>   #include "hw/acpi/memory_hotplug.h"
>   #include "hw/acpi/ghes.h"
>   #include "hw/acpi/cpu.h"
> +#include "hw/acpi/pcihp.h"
>   #include "qom/object.h"
>   
>   #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> @@ -101,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>   #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
>   
>   typedef struct GEDState {
>       MemoryRegion evt;
> @@ -114,6 +116,9 @@ struct AcpiGedState {
>       MemoryRegion container_memhp;
>       CPUHotplugState cpuhp_state;
>       MemoryRegion container_cpuhp;
> +    AcpiPciHpState pcihp_state;
> +    MemoryRegion container_pcihp;
> +
>       GEDState ged_state;
>       uint32_t ged_event_bitmap;
>       qemu_irq irq;
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 451ef74284..abb6e14549 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -38,6 +38,8 @@
>   #define ACPI_PCIHP_SEJ_BASE 0x8
>   #define ACPI_PCIHP_BNMR_BASE 0x10
>   
> +#define ACPI_PCI_HOTPLUG_REG_LEN 0x14

This is wrong, no? It should be 0x18, i.e. 24 bytes or 6 registers of 4 bytes.

I think it's better to move the defines in pcihp.c into pcihp.h and
use them to define ACPI_PCI_HOTPLUG_REG_LEN so the values are consistent, like:

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 82b8ea2811..3ab8b9de94 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -44,14 +44,6 @@
  #include "qobject/qnum.h"
  #include "trace.h"
  
-#define ACPI_PCIHP_SIZE 0x0018
-#define PCI_UP_BASE 0x0000
-#define PCI_DOWN_BASE 0x0004
-#define PCI_EJ_BASE 0x0008
-#define PCI_RMV_BASE 0x000c
-#define PCI_SEL_BASE 0x0010
-#define PCI_AIDX_BASE 0x0014
-
  typedef struct AcpiPciHpFind {
      int bsel;
      PCIBus *bus;
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index abb6e14549..6b79adcaef 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -38,7 +38,15 @@
  #define ACPI_PCIHP_SEJ_BASE 0x8
  #define ACPI_PCIHP_BNMR_BASE 0x10
  
-#define ACPI_PCI_HOTPLUG_REG_LEN 0x14
+#define ACPI_PCIHP_SIZE 0x0018
+#define PCI_UP_BASE 0x0000
+#define PCI_DOWN_BASE 0x0004
+#define PCI_EJ_BASE 0x0008
+#define PCI_RMV_BASE 0x000c
+#define PCI_SEL_BASE 0x0010
+#define PCI_AIDX_BASE 0x0014
+
+#define ACPI_PCI_HOTPLUG_REG_LEN ACPI_PCIHP_SIZE
  
  typedef struct AcpiPciHpPciStatus {
      uint32_t up;


or even use only one of them (ACPI_PCI_HOTPLUG_REG_LEN, ACPI_PCIHP_SIZE, or
another new name that would fit better in both contexts).


Cheers,
Gustavo

> +
>   typedef struct AcpiPciHpPciStatus {
>       uint32_t up;
>       uint32_t down;
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 7b2d582fff..0fd8baba97 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>       ACPI_GED_PWR_DOWN_EVT,
>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
>       ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_PCI_HOTPLUG_EVT,
>   };
>   
>   /*
> @@ -121,6 +122,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                              aml_notify(aml_name("\\_SB.NVDR"),
>                                         aml_int(0x80)));
>                   break;
> +            case ACPI_GED_PCI_HOTPLUG_EVT:
> +                aml_append(if_ctx,
> +                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> +                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
> +                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
> +                break;
>               default:
>                   /*
>                    * Please make sure all the events in ged_supported_events[]
> @@ -299,6 +306,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>       } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>           sel = ACPI_GED_CPU_HOTPLUG_EVT;
> +    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_PCI_HOTPLUG_EVT;
>       } else {
>           /* Unknown event. Return without generating interrupt. */
>           warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -428,6 +437,11 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>               cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>                                   &s->cpuhp_state, 0);
>               break;
> +        case ACPI_GED_PCI_HOTPLUG_EVT:
> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
> +                                "pcihp container",
> +                                ACPI_PCI_HOTPLUG_REG_LEN);
> +            sysbus_init_mmio(sbd, &s->container_pcihp);
>           }
>           ged_events--;
>       }


