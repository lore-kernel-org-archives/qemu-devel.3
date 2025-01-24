Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C58C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIsC-0003oB-E9; Fri, 24 Jan 2025 07:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIry-0003nX-6X
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIrw-0002s5-75
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737721983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWlnJyAfr5kKrDmYCKt5XJ6CvwgSJ3hG6Bq7urvwigs=;
 b=Q2NIyChqEQ/VK2csWRpYtBGB/fbQhsMjehkiDdKkvMpUJDl5Jg4VuoNMFP5MiWhPChH0E4
 hxHpYpySPz/zXFn8fqHinAhcbyop3XKBJVbyFIN93ne5GwWLe44KMZPLLX/ZSsQXZ5R7pG
 FeVV+AAgq+7MdIB/gn/EFYotkHwgsY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-Y8iUN_f0PKm20J4HSZd6mA-1; Fri, 24 Jan 2025 07:30:57 -0500
X-MC-Unique: Y8iUN_f0PKm20J4HSZd6mA-1
X-Mimecast-MFC-AGG-ID: Y8iUN_f0PKm20J4HSZd6mA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bee9ae3b7so1326212f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737721856; x=1738326656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWlnJyAfr5kKrDmYCKt5XJ6CvwgSJ3hG6Bq7urvwigs=;
 b=D9gn4JEhTzbvHTa+yipZSNuyWyYC0SjEEOCNaiAwwZEbHBnql1Q1VGhLK+dNFrrwAv
 O9F14k//JnQxgTA5uFqu6SGCxfeD72+1vBPgDYKntzQZnKpKKYyEf98Y0U6bfYjLhaIf
 kFWvfUsG7Y/avJr/cI8ikZTHybgE6x615fsTuAGPfOsgNtm/luAlk5Z4EHBfYaXPzokd
 wJHzlfFgGmKecx02z/ZEFI54UKY8AN8DoKbvxSw895XXDWeEQXOU+HME9OqEKwKV4BWI
 Wc2b7682JodWkh2zI4UdGYqAi/BxQw6j9G+HLo6tFHEWhDHxSgDQQNW4cTgQwG7ng9i4
 httg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx4OSU97QI7ouH3gxTlT9mvhU3D0OktEScjUDiuvZY4O5qTyC094+jpEoEoSLp3uAh7vZUdwD7A1NE@nongnu.org
X-Gm-Message-State: AOJu0Yz0jP6B8eGyTYOYszpQCbQjJpmmuWNiD3t+eJJBQWCyhMsak8vA
 q2rZf7IVyk86dw2O7OCaAV3yAnVcz0NBKxsbTILH2pvCQbmYyJUiuKH6jIjCrq/hlV65q2biBr1
 idxICizRR+8ZuI/DkVM4hAIkqtQU2I0w9Y+hjoSRacZ8UIq3RtL1m
X-Gm-Gg: ASbGncussEMUUhjuy959ZNUbVx4P1aTcpGY+GzEjfK4E5DFgXjTkd+Vucgazxz5eHYH
 ufRUj2IwmgpamCxCcBWAQTIepJ7xHDVpNuXoOfbMVym1KKVZgLSgAEeAsEu8nFBlyoGleS8bPUj
 8avuIh4jMzGJAfzcICgzoNkFgOVpTuQUL8GYwHTU2R2S4oG+Z3mSO4aq17u3aQuA/hN6Oat+k3a
 lLx4zyBREi+9FkUuNERTd46PiU8tcuFg52sZLmFr78T+pKnPNZSesTT3YdwBD1rWWuMruMRkmS+
 ZsKn80PncUIRCh4GIYyeBCTZsAsjLNySA/q1OGx7sg==
X-Received: by 2002:a05:6000:188d:b0:38a:418e:f3f with SMTP id
 ffacd0b85a97d-38bf56567f9mr27907903f8f.3.1737721856089; 
 Fri, 24 Jan 2025 04:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG12Xt4aj/eG5/E9mQlckmfEVippnF3zMnnQq4W7fADOaD/viCZSUvfTZHCbLNEyElH9/bcwg==
X-Received: by 2002:a05:6000:188d:b0:38a:418e:f3f with SMTP id
 ffacd0b85a97d-38bf56567f9mr27907866f8f.3.1737721855667; 
 Fri, 24 Jan 2025 04:30:55 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb040sm2553078f8f.67.2025.01.24.04.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:30:55 -0800 (PST)
Date: Fri, 24 Jan 2025 13:30:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] acpi/generic_event_device: add an APEI error device
Message-ID: <20250124133054.1f06579c@imammedo.users.ipa.redhat.com>
In-Reply-To: <41b6846394154ddac4d00c3644cd2de577d10115.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <41b6846394154ddac4d00c3644cd2de577d10115.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 22 Jan 2025 16:46:25 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds a generic error device to handle generic hardware error
> events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the guest via ACPI APEI Generic Hardware Error Source (GHES).
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/aml-build.c                    | 10 ++++++++++
>  hw/acpi/generic_event_device.c         |  8 ++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/aml-build.h            |  2 ++
>  include/hw/acpi/generic_event_device.h |  1 +
>  5 files changed, 22 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f8f93a9f66c8..e4bd7b611372 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2614,3 +2614,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>  
>      return var;
>  }
> +
> +/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    return dev;
> +}
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index fe537ed05c66..ce00c80054f4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT,
>  };
>  
>  /*
> @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_ERROR_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> +                                      aml_int(0x80)));
                                                 ^^^^^
nit: perhaps add a comment with intent and ref to spec wrt above  value

> +                break;
>              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name("\\_SB.NVDR"),
> @@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_GENERIC_ERROR) {
> +        sel = ACPI_GED_ERROR_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50aa..8294f8f0ccca 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_GENERIC_ERROR = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index c18f68134246..f38e12971932 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -252,6 +252,7 @@ struct CrsRangeSet {
>  /* Consumer/Producer */
>  #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
>  
> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
>  /**
>   * init_aml_allocator:
>   *
> @@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
>               uint8_t channel);
>  Aml *aml_sleep(uint64_t msec);
>  Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
> +Aml *aml_error_device(void);
>  
>  /* Block AML object primitives */
>  Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d2dac87b4a9f..1c18ac296fcb 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -101,6 +101,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;


