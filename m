Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B93C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 10:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUOSX-0007MP-67; Thu, 18 Jul 2024 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUOST-0007LJ-1R
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:33:57 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUOSR-0004Rp-9f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:33:56 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eedeca1c79so7521641fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721298833; x=1721903633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
 b=lLqyetlrxbTTv9KX/N+SYlpIJY4FapA4CZz4reFRKluR6+5k5GIlGblDaDJEpqJ4xR
 f3v5TdVaPyRy7Egy1x5tdrf1vMhRkpuf37vUnIvC05ud8yhd/lq3T5tAXazK5/AB7rRo
 W9j6HQgAGhpcPYJS80LAciMsuko5p7J3d4/KRQW+tABOj50rc4mPpzeCfayuy7hgrg5r
 McRw4jMc0ATJB/6xSbJ7oKuKkK8TvI5T7qAiLBXETuvJ5MFMaQdP2KwwifMJrbBh9eif
 4ZjvJvdytFnLXu68nfLz5GqlerAieY4r8T1nggV/oILcQcwoJY55PjSa+MQ8dHlzktjq
 zCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721298833; x=1721903633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
 b=XJ6CeJUBTEoe6UGogCpqhMT4MBcB637sbCfP+Sd3PXsoHUSr2SRmQPjuI5uONuGw/3
 /7764Fm8VCpHqj59Rfr/xK2QRPPMsIxQMWo4amaInyWIhxbxLELlPsZE4vEuSL72JPdN
 Pjc5GT2F71Povp32z3Z3pKJX8F/Fe8wDxAu+shTTXOItpvvRvBMtXNUN2LG0uA+x9INV
 jw9KVjQPgxokfick8Uug04l1fq4/WbBvr/GpBdUN7+baa7cidh6nEvMu9p7j2lAp/z97
 lfNePoIOdlhVYkYcnyZZ6wMxRWZZ4uMGDvvKHCOXq9o4WoU0pT2tuIOI+3UA4RAqCTtL
 75EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEPM/o0yYMhmrHZ2hN4vnTDqc5qfS5Lmjuayh0t7bD9/i9vioIl+QAvMLRPtjW9RA2pU/QbS4l3W6QpkreJadhLq/NpJs=
X-Gm-Message-State: AOJu0YymE+HwLdGsZ3anH8729zuDgIKEm9nMFXMQrDcsIIsFNV60dvcD
 hfYJ2Um6t2ErAxnxUi54eVEJ7ESKKLS4vswbLU2ux2D5sk/75DLTAoP/GnJFfiI5+LjOMxb3nzF
 ZWCaz7yn6cKgLNYZjpAkcWXDlwhKk9wtOxbi6Cg==
X-Google-Smtp-Source: AGHT+IHCjC0UyjUkZCeVis2EOTvX9qYFjKU5SpT21H7Ab/b/Ox6naC1A81DsrfWBE21P3cP8fJ0p+oI4yF0oTIumuXw=
X-Received: by 2002:a2e:3c1a:0:b0:2ee:8adb:6190 with SMTP id
 38308e7fff4ca-2ef05d2c4e7mr16006871fa.35.1721298832782; Thu, 18 Jul 2024
 03:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
 <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
In-Reply-To: <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 11:33:41 +0100
Message-ID: <CAFEAcA_4ioaV2Rg8dFFUeAU=tBBq=_TRVpCAUftMeDxu9=gDTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] arm/virt: place power button pin number on a define
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Fri, 12 Jul 2024 at 14:15, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 3 ++-
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 8 insertions(+), 4 deletions(-)

Thanks for writing this refactoring patch; I have a couple
of nits below but otherwise it looks good.

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..ad0a0bcec310 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +    /* Pin for power button */
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;

I would say that with the constant name we could now drop that
comment entirely.

>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a345..7b886f3477b6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
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

You've missed one instance of the hardcoded 3, where we write the
FDT information about it
further down in this function:

    qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
                           "gpios", phandle, 3, 0);

This also can now be GPIO_PIN_POWER_BUTTON.

thanks
-- PMM

