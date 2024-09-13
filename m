Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14FEEEE26C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 12:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5bw-0002Il-2D; Fri, 13 Sep 2024 08:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp5bs-0002IF-Ul
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp5br-00061L-70
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726231269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RaivyCQMSUyJzPDIA7XrIPLMabA2F7y53TiK4oNNe3I=;
 b=RiB02yZ0JH1xxJbOiz3qP/3K4F2KY7ywnsSghtMRKp5Yc96vya5WPS+vh0JpSsBINs3Wsf
 F2+4kn+ul/bFf9FW9fFuc0S95iqQD0TvZE+V/HSkkw5mUg8lzDtl1/LWzDUAggeSfXyoKW
 8vP/Y/75wGJJVSMYbO1GvywTwmXe1iY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-krtvtBiiOvmTWu0MrSXmWA-1; Fri, 13 Sep 2024 08:41:07 -0400
X-MC-Unique: krtvtBiiOvmTWu0MrSXmWA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c25d886aso1036175f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 05:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726231267; x=1726836067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaivyCQMSUyJzPDIA7XrIPLMabA2F7y53TiK4oNNe3I=;
 b=hQLAbBiOVpHnfmzGouLR7C5dk92wlP5UKxwVjiBsSf6FsOJXyJvlNta4dFX1L5OKjt
 R/lkx4V/iwC9RWUD/x58HhHiv4izdp7LPOGfALXfIkCK243VKPTlIJ4UC/58T+CAWtaK
 7PNj8jgLRsMYd2e1E7DEUKg1wzDVkX+f35gqlsGnkzGVNXMx+9VkZYl1J0o5y6vuHgLb
 vdz6pdhw/hEITYGCvgZDIOKl/m0yEwdsBVaK8KRkA3EOMmAD5+B1M5wlwidUOZZTq13+
 3aCkC0+6QS7QzTrE1yf1R5C+sD9sRRamu1NhS6qWvH/KfRm419GKQ09KRtaLRtsdyEtW
 SGgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ7+ukun4hEDEq6m/Pp5KcqUFLN/6QkN0FXyjVJc81DC1iwPIXSVgeq3alnKo3Rc7w7qHa+EZEmIm/@nongnu.org
X-Gm-Message-State: AOJu0YzsZkH1C/+ONqgL4Di+s7uGeg/FuNgVB0caK5iJRpqJgaQlWBXq
 I8HnejusCs8Vw+4dnspQmocZ3fvPTpjJM5/wBbb31pa58GATtyaMf2JsTp3tC4YTJecj9Va6hqW
 Kw5KK6ndDhinFegj4bVmQzHOIUfd6X+GOaMKGXWYcSoj5GYt7lVq4
X-Received: by 2002:a05:6000:1e50:b0:374:c42f:bac1 with SMTP id
 ffacd0b85a97d-378c2cfeb41mr3645581f8f.8.1726231266702; 
 Fri, 13 Sep 2024 05:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Tt8kzxXokxwKINcLtm0NiO17a8Tfg8ri1D8bKktM9aw7UzEypVW7sfcqFFcviSQlUjhQPQ==
X-Received: by 2002:a05:6000:1e50:b0:374:c42f:bac1 with SMTP id
 ffacd0b85a97d-378c2cfeb41mr3645553f8f.8.1726231265596; 
 Fri, 13 Sep 2024 05:41:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d37a1sm16781888f8f.77.2024.09.13.05.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 05:41:05 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:41:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Ani
 Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "Jason
 A . Donenfeld" <Jason@zx2c4.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] acpi: ged: Add macro for acpi sleep control
 register
Message-ID: <20240913144104.643c1e89@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240911030922.877259-2-maobibo@loongson.cn>
References: <20240911030922.877259-1-maobibo@loongson.cn>
 <20240911030922.877259-2-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 11 Sep 2024 11:09:21 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Macro definition is added for acpi sleep control register, so that
> ged emulation driver can use this, also it can be used in FDT table if
> ged is exposed with FDT table.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/acpi/generic_event_device.c         | 6 +++---
>  hw/i386/acpi-microvm.c                 | 2 +-
>  hw/loongarch/acpi-build.c              | 2 +-
>  include/hw/acpi/generic_event_device.h | 9 +++++++--
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf..94992e6119 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>  
>      switch (addr) {
>      case ACPI_GED_REG_SLEEP_CTL:
> -        slp_typ = (data >> 2) & 0x07;
> -        slp_en  = (data >> 5) & 0x01;
> -        if (slp_en && slp_typ == 5) {
> +        slp_typ = (data & ACPI_GED_SLP_TYPx_MASK) >> ACPI_GED_SLP_TYPx_POS;
this makes a bit more complex expression once macros are expanded,
but doesn't really helps to clarity.

If I have to touch/share this code, I'd replace magic numbers above
with corresponding simple numeric macro but keep the same expressions.

> +        slp_en  = !!(data & ACPI_GED_SLP_EN);
> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYPx_S5) {
>              qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>          }
>          return;
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index 279da6b4aa..1e424076d2 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -131,7 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>      /* ACPI 5.0: Table 7-209 System State Package */
>      scope = aml_scope("\\");
>      pkg = aml_package(4);
> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));

what's the point of renaming this?

>      aml_append(pkg, aml_int(0)); /* ignored */
>      aml_append(pkg, aml_int(0)); /* reserved */
>      aml_append(pkg, aml_int(0)); /* reserved */
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 2638f87434..974519a347 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -418,7 +418,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      /* System State Package */
>      scope = aml_scope("\\");
>      pkg = aml_package(4);
> -    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYPx_S5));
>      aml_append(pkg, aml_int(0)); /* ignored */
>      aml_append(pkg, aml_int(0)); /* reserved */
>      aml_append(pkg, aml_int(0)); /* reserved */
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b5..41741e94ea 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -81,8 +81,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  /* ACPI_GED_REG_RESET value for reset*/
>  #define ACPI_GED_RESET_VALUE       0x42
>  
> -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> -#define ACPI_GED_SLP_TYP_S5        0x05
> +/* [ACPI 5.0+ FADT] Sleep Control Register */
> +/* 3-bit field defines the type of hardware sleep state */
> +#define ACPI_GED_SLP_TYPx_POS      0x2
> +#define ACPI_GED_SLP_TYPx_MASK     (0x07 << ACPI_GED_SLP_TYPx_POS)
> +#define ACPI_GED_SLP_TYPx_S5       0x05  /* System \_S5 State (Soft Off) */
> +/* Write-only, Set this bit causes system to enter SLP_TYPx sleeping state */
> +#define ACPI_GED_SLP_EN            0x20
>  
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"


