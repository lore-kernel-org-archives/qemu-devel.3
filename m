Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B3CCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqthD-0001AU-Gi; Wed, 18 Sep 2024 08:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqth1-00015F-Ly
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqtgy-0007LS-2W
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726662113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzfVzlmfEDIal0FGOmG929QVA1cSXOjk3xpvWuwpbVE=;
 b=XeEX/tIg3oZZKZ2ZcCPgnintoOg8vkiK4l2ITHFcj6q6zCSR7zPWrmk8ik6zpkLqfMhxFI
 3JVbFPMYkzdbyfGNLho6njyR32Z14II/iRmVAMwUEwsM7XJqeBIyQg2KriiMMo2qmCiHPO
 pbhoEq+USWA5zpWUpcEcfUeqciIjZas=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-SP3SlPXGP5ingvrpRJV7BA-1; Wed, 18 Sep 2024 08:21:50 -0400
X-MC-Unique: SP3SlPXGP5ingvrpRJV7BA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c960ee7aso3896277f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726662110; x=1727266910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzfVzlmfEDIal0FGOmG929QVA1cSXOjk3xpvWuwpbVE=;
 b=J5gvwL+Pm0o5vWk5H2bxKyzQ7OaceAUCMz6wMuizgjm7dUeMnHjX76xEPMZ9MmiT8j
 2RWTrVtb/cdmVb4PZzrs1eA6pjVMZOeb6A+UlcTc8JVjB7vcMnZmDIzYVa9sMe8vbyeD
 fKlxm31IUySIeoJ1PdW8OxIsxfp+DML1VcWa8iJI+/M7lFjQOq4xSHhJxTjp1h3mmKvm
 A9UgLpZLZ7aW7wePZEyPJkD5tgKXSlIdftp4gvpCXmyMl1jh0JkRhxZ/XFmE+KGfZMRb
 l1TXC7TjXfT9j6+gngbr4NJHdDJPwxSC9YiIMlo3BDPOPObc+mOeRLnA72TnTG/JsWhH
 UzIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWk0ScCJ3J4efoOf0C4MC3FzBwauEu7jaY/eA4xOF6/roWNvi6cBXj7ftyWU47XjPirB6IikTFCOtZ@nongnu.org
X-Gm-Message-State: AOJu0YwGFAwfzlCO1As+gjyj0fEkrTJobZYwlOUyPnakR6fzM09+YZLw
 Mc8EI8KbuSiEhTZ+VDOq3/btyuPUPQo3DBLF+lOMZEhniDJdvwIdXKeQv6gj+9G2v2+PrGIseDa
 ldA6Is+MEposKUjm8gGpEmw4XBDU5uzDvHkBhSuXR2r5KZzFpmtTd
X-Received: by 2002:adf:cd8b:0:b0:378:8f2f:905f with SMTP id
 ffacd0b85a97d-378d61d4d27mr14322175f8f.11.1726662109574; 
 Wed, 18 Sep 2024 05:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFffAWseuab53raL510pbuU7srN1JqGpMfTnm5vp0NMQ4CFNNAQTb6Hg6Ut5fG0+uKX0aiFxQ==
X-Received: by 2002:adf:cd8b:0:b0:378:8f2f:905f with SMTP id
 ffacd0b85a97d-378d61d4d27mr14322146f8f.11.1726662109045; 
 Wed, 18 Sep 2024 05:21:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e80fcsm12135518f8f.36.2024.09.18.05.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:21:48 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:21:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1?=
 =?UTF-8?B?aA==?= <thomas@t-8ch.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] acpi: ged: Add macro for acpi sleep control
 register
Message-ID: <20240918142147.50ef7b60@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240918014206.2165821-2-maobibo@loongson.cn>
References: <20240918014206.2165821-1-maobibo@loongson.cn>
 <20240918014206.2165821-2-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 18 Sep 2024 09:42:05 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Macro definition is added for acpi sleep control register, ged emulation
> driver can use the macro , also it can be used in FDT table if ged is
> exposed with FDT table.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c         | 6 +++---
>  include/hw/acpi/generic_event_device.h | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf..d00f5a6c1c 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>  
>      switch (addr) {
>      case ACPI_GED_REG_SLEEP_CTL:
> -        slp_typ = (data >> 2) & 0x07;
> -        slp_en  = (data >> 5) & 0x01;
> -        if (slp_en && slp_typ == 5) {
> +        slp_typ = (data >> ACPI_GED_SLP_TYP_POS) & ACPI_GED_SLP_TYP_MASK;
> +        slp_en  = !!(data & ACPI_GED_SLP_EN);
> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
>              qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>          }
>          return;
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b5..d2dac87b4a 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -81,8 +81,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  /* ACPI_GED_REG_RESET value for reset*/
>  #define ACPI_GED_RESET_VALUE       0x42
>  
> -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> -#define ACPI_GED_SLP_TYP_S5        0x05
> +/* [ACPI 5.0 Chapter 4.8.3.7] Sleep Control and Status Register */
> +#define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
> +#define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
> +#define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft Off) */
> +#define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
>  
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"


