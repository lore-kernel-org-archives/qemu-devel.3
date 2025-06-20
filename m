Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD186C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbSd-0002Ig-2J; Fri, 20 Jun 2025 09:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbST-0002Hs-Of
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbSQ-0004S6-KE
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750424815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCPugQeYEJztwx9I+h2+DYZRCQdWluxXl/h618kyee0=;
 b=R/RmmU6vIDyWmGrs6T4hGHb4U+bueyshLaV/CzbvpCBARPG7ximM07CP18U/AeuuvO3T85
 tLQoFIFtw8Fo8xLxoMbN9CFCQmNjGEbbSZxIhhxwFoFPZeW2lWmNpPlnvhLuYRLKcEOQZy
 ZcWOfEpqiMyBM4svI7tjIKyvlsc9Km4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-GeVfLypPOjOM9_DhtkZmCA-1; Fri, 20 Jun 2025 09:06:53 -0400
X-MC-Unique: GeVfLypPOjOM9_DhtkZmCA-1
X-Mimecast-MFC-AGG-ID: GeVfLypPOjOM9_DhtkZmCA_1750424812
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so972007f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424812; x=1751029612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCPugQeYEJztwx9I+h2+DYZRCQdWluxXl/h618kyee0=;
 b=Poalyc3En0Nh8/InKHnt14Rr8Od13eLe25PP/NdIYu1A46I6W6rAR8QJSSg9YobBwy
 O8qEwbwbJuRWU/XKPmEbL4FCVtJQBgtMoiiuBwKfVHfXqTK1k+HTudiE0atz6I3jFr5v
 UDVqFEZKWmo0yGYwUZeFbMqc+21/jANmbpdAuEEaUzzGPW2DYkbdJk4hyFL6i6nYa2Os
 QtTZViuk4XKwZRFDQCTnWThhWEoYW0pHrZ+rQld8TIYa+AGPwfP1cvYRBar0KYrhLrdP
 PqUY3Mtt65H0Px/liT5XyhcduhLC3bn8EmRLJQYkHym2Hqb8Q2Jb7mq08rwwS9o5CIoY
 jznw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzVyI8kEqc89xT0GAJDcx4aiANxHGdp6U8aYba7zGCVTRRWB4AKp6rOin+R2AbvBv1mCPjdCZg2uq@nongnu.org
X-Gm-Message-State: AOJu0YzUN05XSxeCJ3YodsTjIj4TXV7eeCcelS/d+grpM1QWKznYUHmS
 6bT/OOUfOISNm+oEar56TDtLfKV9uJOIFuSQ6ZqxmHPs/MGxzlD3aAxs8/o9ofFOfTY1AheWJw6
 uPeNgaATQAvB//JF+R96dL1SPKe/lpVka0Rpz9uZPgFeCGGcmzNvqkSqL
X-Gm-Gg: ASbGncvFVKBNeZejvd8OEk5QNUk+H6dovZ5QREBSponJHaPxQwvQmWFhL7dEYWvPcwY
 ZAfjeu9zP0teIC5cXUaFS0ZnBLVGf5rVL5hLlGuRrcUUYYb6ZcaXs0Nyiaqe90GOME30wPoXpqt
 ZQXsDh901Wh9m1agv4YnDVPdE8NzDkdiOjiqMTprvIFZOdtQdqeA61mD9T4GVbbth1434P6bv/p
 T3kve5mqcJiJSq75dBxt9XE9awaOuw5IW0a+bU+V2jmslB9b+AoxXImApWk2ck2SvUDN6cZkWIP
 u3Z03otKVvIQ
X-Received: by 2002:a05:6000:3103:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a6d13013eemr2635362f8f.13.1750424810819; 
 Fri, 20 Jun 2025 06:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFge7Awv1P1VVAhisMZcx63sdih8ExUZZAl1or6KIRrJ+raw9Lchx23v9UKWOdXWuh2N3FBcg==
X-Received: by 2002:a05:6000:3103:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a6d13013eemr2635314f8f.13.1750424810401; 
 Fri, 20 Jun 2025 06:06:50 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190b00sm1977849f8f.87.2025.06.20.06.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:06:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:06:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 25/29] hw/arm/virt: Let virt support pci
 hotplug/unplug GED event
Message-ID: <20250620150648.09dab163@fedora>
In-Reply-To: <20250616094903.885753-26-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-26-eric.auger@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Jun 2025 11:46:54 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Set up the IO registers used to communicate between QEMU
> and ACPI.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - remove acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
> - use sysbus_mmio_map_name for all regs (Igor)
> - create_pcie left at its original place
> 
> v1 -> v2:
> - use ACPI_PCIHP_REGION_NAME
> ---
>  include/hw/acpi/generic_event_device.h |  1 +
>  hw/arm/virt.c                          | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ec8e1abe0a..8f5d903146 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -111,6 +111,7 @@ typedef struct GEDState {
>  } GEDState;
>  
>  #define ACPI_PCIHP_REGION_NAME "pcihp container"
> +#define ACPI_MEMHP_REGION_NAME "memhp container"
>  
>  struct AcpiGedState {
>      SysBusDevice parent_obj;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 41be8f6dbb..8c882e0794 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -684,6 +684,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      SysBusDevice *sbdev;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiPciHpState *pcihp_state;
>      int irq = vms->irqmap[VIRT_ACPI_GED];
>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>  
> @@ -696,13 +698,26 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      }
>  
>      dev = qdev_new(TYPE_ACPI_GED);

> +    acpi_ged_state = ACPI_GED(dev);
> +    pcihp_state = &acpi_ged_state->pcihp_state;
> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> +        event |= ACPI_GED_PCI_HOTPLUG_EVT;
> +    }

Doesn't it belong to ged_realize()?

>      qdev_prop_set_uint32(dev, "ged-event", event);
>      object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
>      sbdev = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(sbdev, &error_fatal);
>  
> -    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
> -    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
> +    sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
> +                         vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    if (pcihp_state->use_acpi_hotplug_bridge) {

like elsewhere, use property accessor

> +        int pcihp_region_index;
> +
> +        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
> +                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
> +        assert(pcihp_region_index >= 0);
> +    }
>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
>  
>      return dev;


