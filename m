Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4AC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4NR-0002M7-RY; Thu, 08 Aug 2024 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4NM-0002Kq-5b
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4NK-0007nx-IY
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723128261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yHWhOGhXoiaID94xq0Obn8IF6l9bmHYEIpGRlWg4Yk=;
 b=ZjllRycLy/clzm5sIkB3BuG7Ccj4KlFMyNtcRj32QPOlNX1lXyfjYlZr12+Q1MF9dy1i8D
 roMt6BRsnOQaQAfT5oYkLUgiuWM0pMLuYA99mtos7tPsDpskkpIDxZgrCQvFaCMsKGPqwC
 moy/Csu1TlpGXd6SE+ndSqRddq736f0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144--ShGKu2KOLGvUaEJjPSf-g-1; Thu, 08 Aug 2024 10:44:19 -0400
X-MC-Unique: -ShGKu2KOLGvUaEJjPSf-g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52eff5a4faaso1243366e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723128258; x=1723733058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yHWhOGhXoiaID94xq0Obn8IF6l9bmHYEIpGRlWg4Yk=;
 b=t7QI3uqRpKEnA1zchXLuf/SrqjP3kHFzA7TYdkJCRy6n9qhw3bKHx9EMRHbC1yfV3D
 ywDq/EQOq1Y8b0rHh4a50yAicKDTL/9ywRKBvI6SWOj/N6EiHmQ/vyJXq9VcfCAUu3XV
 E19juQr20geRMD2D9OTPKBteWFJXTe2+75EF0ayCJEWN+l6bOEdlABnd+Rq1zMKuSWga
 gQPG71JZU4d4SRPb4Ooly5DOq+3rToV/gbQO300eKptlH2FUbi32qNSVMI+CIB4gNUvT
 CfpeoYHRow2F5wC2WOC1Ok73/tJkakZHYoHvFJRHkMS9FaohkUv4m3F+f0IzVaDyFajn
 OKPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIxruNlE4ezG5Vsp+CZ0pYC8u+K+Do89E5LSXXkmW1C6MIYywqUClqBWIndQ/5VvnlyPzDMr+onvJbJ9dv9W9KAMUlf3s=
X-Gm-Message-State: AOJu0YxM6qVEkLtib59lNWTyly/EX8giUM3ir5iG6dSj/9t0LLhGBxJx
 wtoq4d+BVqlQO4oy/AaUVakeWWNhI4mEHNU6tiLjwCGlVK9v5q25l8Mw0sYnliBVDuOwVY48Gm8
 sTg3CLwOFYzs7ONFslMot/A66pPSWBUK3R7xgbYA2CrQoOidSxE5N
X-Received: by 2002:a05:6512:3f2a:b0:52c:deba:7e6e with SMTP id
 2adb3069b0e04-530e583dbd1mr1838868e87.29.1723128257877; 
 Thu, 08 Aug 2024 07:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyh0BU4hkdxFulosZVyBK7BJraF3bjcMfeyi8ouHjXm8HPCLcpB/V7MWfZ+ttDa5YmHQVeiw==
X-Received: by 2002:a05:6512:3f2a:b0:52c:deba:7e6e with SMTP id
 2adb3069b0e04-530e583dbd1mr1838822e87.29.1723128256896; 
 Thu, 08 Aug 2024 07:44:16 -0700 (PDT)
Received: from redhat.com ([2.55.34.111]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e8676fsm742332666b.164.2024.08.08.07.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:44:16 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] arm/virt: place power button pin number on a define
Message-ID: <20240808104308-mutt-send-email-mst@kernel.org>
References: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 02:54:52PM +0200, Mauro Carvalho Chehab wrote:
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com/
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

ack, but note we do things like that only if something
is repeated.

> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 7 ++++---
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..f76fb117adff 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 719e83e6a1e7..687fe0bb8bc9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      if (s->acpi_dev) {
>          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
>      } else {
> -        /* use gpio Pin 3 for power button event */
> +        /* use gpio Pin for power button event */
>          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>      }
>  }
> @@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> -                                        qdev_get_gpio_in(pl061_dev, 3));
> +                                        qdev_get_gpio_in(pl061_dev,
> +                                                         GPIO_PIN_POWER_BUTTON));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -1024,7 +1025,7 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>      qemu_fdt_setprop_cell(fdt, "/gpio-keys/poweroff", "linux,code",
>                            KEY_POWER);
>      qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
> -                           "gpios", phandle, 3, 0);
> +                           "gpios", phandle, GPIO_PIN_POWER_BUTTON, 0);
>  }
>  
>  #define SECURE_GPIO_POWEROFF 0
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ab961bb6a9b8..a4d937ed45ac 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -47,6 +47,9 @@
>  /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
>  #define PVTIME_SIZE_PER_CPU 64
>  
> +/* GPIO pins */
> +#define GPIO_PIN_POWER_BUTTON  3
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,
> -- 
> 2.45.2


