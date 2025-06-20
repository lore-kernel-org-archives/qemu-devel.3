Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EDEC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbJD-00086q-Md; Fri, 20 Jun 2025 08:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbJ3-000863-Ds
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbJ1-0003B8-MB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750424239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ocXhnFoNE0SRads8qRr8AJf7z1hiUGAC5pHdUf3mp8=;
 b=bHgu32md/aiHfhCDyTXEyMNsOlDO6GGr8ZBHNthXXpmo62fkr54xoyFReYwSTFGJz7xxXj
 9Zb1v7+eQW9X2OxMJDwuuUt9VC05oy0oekLQjeHieQK2fEPebfF+W3CQDxgzuib/HXIqDE
 wtkP6fhHEQtoyKWbNOEtAfeD5K4KdNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-CwsB3ViwP_ysA17DG0m9SQ-1; Fri, 20 Jun 2025 08:57:17 -0400
X-MC-Unique: CwsB3ViwP_ysA17DG0m9SQ-1
X-Mimecast-MFC-AGG-ID: CwsB3ViwP_ysA17DG0m9SQ_1750424236
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d244bfabso14812545e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424236; x=1751029036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ocXhnFoNE0SRads8qRr8AJf7z1hiUGAC5pHdUf3mp8=;
 b=lw+W6Ijk1Je8ql9oUYQDoUbHwdhNpwlv+Y5fm0eRpilCGxd8R0w7i0wH6Mfy3i4sE8
 2WbwuCSRU4giva6ZQauf+3dd26IqSuFpTT8jejzwYLqFxl01fWj2aWwVOZ528vON+mlG
 NOg8l9MRxVEr0gNto3gwev6Uv7pt1npIqZX4YX+DEKWKXXMMcb7tAaXhpqFoIgS4T9HH
 z/zPVUWjG/hugRMvOczvwm88m6ievUuqkADIf06wamyuHC5vYjhkx6Wz+qxe1T5n0/FR
 AfI1zLtwDBNZSP/HhYCoyEkQKfbvdXstAGYX2Owz50y+XUzjE2ntD/3fKdzQrbKj+4jz
 Msug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCVTzk9SwBy6bRljJ5zElh+c5P0I1R1JX/Np3AfNH3OY4172e3nz5zjyPxSlx5hWmC4CbCgoWwjrAp@nongnu.org
X-Gm-Message-State: AOJu0Yyxm3vg3AZ72tYDknOdMkUpM2hIRk7xoF4eic8jh3nTD/L4iVgg
 6Kl6WdLRRxKui52svQWiEG2wWHDjuMEqkCii4hs9QBh6kDkicW9e+tbsFleWTg9M6Z8nLoigEG6
 vMo33igZIm2faxhw3uxWwlz4j4o3yUWdxgQXRbb0EbvGuNRU9B/p2tH9u
X-Gm-Gg: ASbGnctF0wIRf2fh1EgwS9GL4kxhvBRJBbphG47yo5PwfDuNRYhjOpQBceBImubCJqX
 XT6Ya3sO+ZvG6iIut7VlIcP0EjBOr+vI4DdYY7Ag/xPhkekC1J/AUr87uTwxRj+8UKCtatU12b1
 CSYRJjUUaCU6PnRcUYsgopCWIQ9bhaQmLhWRwQE4/nNksRqpQe/RLI2RnTnRMvLBZWfgtCpi5eI
 xspumGD7TDJU3n95hZ+o71PoTR00Rs4RSCA9jjDyF97rTArSLQ12csXsH+gcQey78zaaISF7wR1
 o8718rsEl0aS
X-Received: by 2002:a05:6000:18ae:b0:3a4:e7b7:3851 with SMTP id
 ffacd0b85a97d-3a6d12fc225mr2304225f8f.58.1750424236347; 
 Fri, 20 Jun 2025 05:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0pyJwWCQDeWKlydnDkk+wMUFoJ0Cw7i5Vq0HvxAQoipxUo4h/zBSVh49ChpJmuM3tj0e9fQ==
X-Received: by 2002:a05:6000:18ae:b0:3a4:e7b7:3851 with SMTP id
 ffacd0b85a97d-3a6d12fc225mr2304203f8f.58.1750424235903; 
 Fri, 20 Jun 2025 05:57:15 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187ef4sm2031806f8f.68.2025.06.20.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:57:15 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:57:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 20/29] hw/acpi/ged: Prepare the device to react to
 PCI hotplug events
Message-ID: <20250620145714.0923f6c0@fedora>
In-Reply-To: <20250616094903.885753-21-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-21-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:49 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> QEMU will notify the OS about PCI hotplug/hotunplug events through
> GED interrupts. Let the GED device handle a new PCI hotplug event.
> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
> mutex held.
> 
> The GED device uses a dedicated MMIO region that will be mapped
> by the machine code.


> At this point the GED still does not support PCI device hotplug in
> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
> subsequent patch.

looks out of order, perhaps it should be before this patch

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - pcihp_init and reset are put in ged code instead of machine code
>   (Igor)
> 
> v1 -> v2:
> - Introduce ACPI_PCIHP_REGION_NAME
> ---
>  include/hw/acpi/generic_event_device.h |  4 ++++
>  hw/acpi/generic_event_device.c         | 26 ++++++++++++++++++++++++++
>  hw/acpi/pcihp.c                        |  1 -
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index f5ffa67a39..ec8e1abe0a 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -102,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -109,6 +110,8 @@ typedef struct GEDState {
>      uint32_t     sel;
>  } GEDState;
>  
> +#define ACPI_PCIHP_REGION_NAME "pcihp container"
> +
>  struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
> @@ -116,6 +119,7 @@ struct AcpiGedState {
>      CPUHotplugState cpuhp_state;
>      MemoryRegion container_cpuhp;
>      AcpiPciHpState pcihp_state;
> +    MemoryRegion container_pcihp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index ef1c1ec51f..b4eefb0106 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/pci/pci.h"
>  #include "hw/irq.h"
> @@ -27,6 +28,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_PCI_HOTPLUG_EVT,
>  };
>  
>  /*
> @@ -122,6 +124,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name("\\_SB.NVDR"),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_PCI_HOTPLUG_EVT:
> +                aml_append(if_ctx,
> +                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> +                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
> +                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
> +                break;
>              default:
>                  /*
>                   * Please make sure all the events in ged_supported_events[]
> @@ -300,6 +308,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>          sel = ACPI_GED_CPU_HOTPLUG_EVT;
> +    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_PCI_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -433,6 +443,12 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>              cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>                                  &s->cpuhp_state, 0);
>              break;
> +        case ACPI_GED_PCI_HOTPLUG_EVT:
> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
> +                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
> +            sysbus_init_mmio(sbd, &s->container_pcihp);
> +            acpi_pcihp_init(OBJECT(s), &s->pcihp_state,
> +                            s->pcihp_state.root, &s->container_pcihp, 0);
>          }
>          ged_events--;
>      }
> @@ -474,6 +490,15 @@ static void acpi_ged_initfn(Object *obj)
>      sysbus_init_mmio(sbd, &ged_st->regs);
>  }
>  
> +static void ged_reset(DeviceState *dev)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +
> +    if (s->pcihp_state.use_acpi_hotplug_bridge) {
> +        acpi_pcihp_reset(&s->pcihp_state);
> +    }
> +}
> +
>  static void acpi_ged_class_init(ObjectClass *class, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(class);
> @@ -488,6 +513,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
>      hc->plug = acpi_ged_device_plug_cb;
>      hc->unplug_request = acpi_ged_unplug_request_cb;
>      hc->unplug = acpi_ged_unplug_cb;
> +    device_class_set_legacy_reset(dc, ged_reset);
>  
>      adevc->ospm_status = acpi_ged_ospm_status;
>      adevc->send_event = acpi_ged_send_event;
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index e79a24b821..36492aa0d9 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -43,7 +43,6 @@
>  #include "qobject/qnum.h"
>  #include "trace.h"
>  
> -#define ACPI_PCIHP_SIZE 0x0018
>  #define PCI_UP_BASE 0x0000
>  #define PCI_DOWN_BASE 0x0004
>  #define PCI_EJ_BASE 0x0008


