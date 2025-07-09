Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DB8C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWtL-0005Tl-Nw; Wed, 09 Jul 2025 11:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZWtK-0005Rl-4f
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZWtH-00035A-1z
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752075561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q5UpjwO0R6cGtN67tG8SqlONW5BDfrPQMqbELvuIwU=;
 b=AeXPlMTHR4D7WDGiXja98/t8XqyelP4atd5fFbRR8G2KPyneD296Cy+NsUs1pgfUKmPLcC
 ufmtNDv/NniLUxhFkrhERnUT9Kdq4uEfERG6gz804LcZZw3+yXE8bcmsiiV671B0SGbcM8
 FcZfaTKKch0NMXGJb40ZPxE2srhwKAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-zNW6db4XMvC-ftGZgeyRDQ-1; Wed, 09 Jul 2025 11:39:19 -0400
X-MC-Unique: zNW6db4XMvC-ftGZgeyRDQ-1
X-Mimecast-MFC-AGG-ID: zNW6db4XMvC-ftGZgeyRDQ_1752075558
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so30726385e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 08:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752075558; x=1752680358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9q5UpjwO0R6cGtN67tG8SqlONW5BDfrPQMqbELvuIwU=;
 b=P0I7VZQ4GYyYBySbif0vCwATsWpBW+4Rdv+uQ1On3U13T2tmxwjH7qikcufOhYPalZ
 z5alM6ht8mm3t52GsuSlKul2cPXvd/1+wOFQeOqm2NrV/RgW6PCz7tha9DkY+Zt54ZER
 AaOCBQ0hzF3qQJJGjZbscq8raM1UdDKhUDo2HSE/MW/zyJsVKWn5x9ex5HKeFzx/TXnN
 esmFmXIok+Bq0fCebFE9x7ZNqIR44sqGQs5MozKgyzo1tTvSsRqGRhR69xHHGDUHDdP0
 tLSr8goXfKDw8wg/A89XOx08aV1QVGCZONnLbGrCzt4TLK0tVykPpYEfncuQLfSEl87G
 3/fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtxQZLLkNY9vwOrkQ/g9neHa4fzeqtQZR58rpxBWr5vWN3y/DR0JJC1XSpGrLgDGSBlyErtWfODlzy@nongnu.org
X-Gm-Message-State: AOJu0YxGkWr3b8FDt/eXEjn4L8g8g2QoB00C6Vd3luB7VLKQGA9nOlAf
 TUr4RhyjRBZoBYDKO/3yuJUOjiMtC0p0dsY+FP+jtlSvCZElQuCb6/bBR0yJt2idmvXjmarkyzR
 XirJVdSWBqopite1DWI6qDlamEOAZyHSkQBfVj6iXthNwmm39fNH8QdNp
X-Gm-Gg: ASbGncvxiRmusGXYxmn8agWIsaGL4t+gfbjpJDlsnfXmLhko0EnzZvGYEzuAkAyPypi
 /wRe3DZ+QDzZgRC4Vw0Uxr17+eYCCp21GsLR8meOZgoaZG3JBnlmQF8cJ4U+2rMGSqrYtW7xFd0
 c/Ll3zXoUvW8c1BPKzMrvM2Y9Gm7rtZUYFIWM7Tc+ifuIt23O7IXLvWLeRGskmPj3Z5OHBKWFof
 3qngXuegQcwlXGKWRzIah9bRZdNdyWSrn258PqCgpwEu+H75uRyEf+xgyv3AM29kIFCccOw0mui
 nBxK4y+msQxuCQ/BNqjypUsujgcDCip5qdFHIH23tkotv0YmOq0BYCz1t5yFsK55OrOAUg==
X-Received: by 2002:a05:6000:24c1:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b5e4537ad2mr2820124f8f.44.1752075558098; 
 Wed, 09 Jul 2025 08:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW5RgC8+xBMUmwHdwEVNTHqo+Eru2mw8tSZ0FQg6eyikdvP3GRvGv/5s8PzxzxwtNLXWyaiw==
X-Received: by 2002:a05:6000:24c1:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b5e4537ad2mr2820081f8f.44.1752075557410; 
 Wed, 09 Jul 2025 08:39:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afefsm16194112f8f.82.2025.07.09.08.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 08:39:16 -0700 (PDT)
Message-ID: <28bc331c-4781-497c-aea3-d497408d40c5@redhat.com>
Date: Wed, 9 Jul 2025 17:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm/cpu: store id_afr0 into the idregs array
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-2-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250704141927.38963-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 7/4/25 4:19 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/intc/armv7m_nvic.c        |  2 +-
>  target/arm/cpu-sysregs.h.inc |  1 +
>  target/arm/cpu.h             |  1 -
>  target/arm/cpu64.c           |  4 ++--
>  target/arm/helper.c          |  2 +-
>  target/arm/tcg/cpu-v7m.c     | 12 ++++++------
>  target/arm/tcg/cpu32.c       | 22 +++++++++++-----------
>  target/arm/tcg/cpu64.c       | 16 ++++++++--------
>  8 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 6d85720f1b46..d93e593fcba8 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1279,7 +1279,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>          if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
>              goto bad_offset;
>          }
> -        return cpu->id_afr0;
> +        return GET_IDREG(isar, ID_AFR0);
>      case 0xd50: /* MMFR0.  */
>          if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
>              goto bad_offset;
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index cb99286f7048..b96a35880430 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -14,6 +14,7 @@ DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
>  DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>  DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>  DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> +DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
>  DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
>  DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
>  DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 033815392385..ca8ad1cc27a8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1066,7 +1066,6 @@ struct ArchCPU {
>      uint32_t reset_sctlr;
>      uint64_t pmceid0;
>      uint64_t pmceid1;
> -    uint32_t id_afr0;
>      uint64_t id_aa64afr0;
>      uint64_t id_aa64afr1;
>      uint64_t clidr;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1f3406708bd7..28b8f7db949d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -655,7 +655,7 @@ static void aarch64_a57_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10101105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> @@ -717,7 +717,7 @@ static void aarch64_a53_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10101105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c311d2df2170..2f57ab4d87da 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7805,7 +7805,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_aa32_tid3,
> -              .resetvalue = cpu->id_afr0 },
> +              .resetvalue = GET_IDREG(isar, ID_AFR0)},
>              { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
>                .access = PL1_R, .type = ARM_CP_CONST,
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index eddd7117d5bb..a65b83fe9905 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -62,7 +62,7 @@ static void cortex_m0_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000200);
>      SET_IDREG(isar, ID_DFR0, 0x00100000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00000030);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x00000000);
> @@ -88,7 +88,7 @@ static void cortex_m3_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000200);
>      SET_IDREG(isar, ID_DFR0, 0x00100000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00000030);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x00000000);
> @@ -119,7 +119,7 @@ static void cortex_m4_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000200);
>      SET_IDREG(isar, ID_DFR0, 0x00100000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00000030);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x00000000);
> @@ -150,7 +150,7 @@ static void cortex_m7_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000200);
>      SET_IDREG(isar, ID_DFR0, 0x00100000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00100030);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01000000);
> @@ -183,7 +183,7 @@ static void cortex_m33_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000210);
>      SET_IDREG(isar, ID_DFR0, 0x00200000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00101F40);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01000000);
> @@ -221,7 +221,7 @@ static void cortex_m55_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x20000030);
>      SET_IDREG(isar, ID_PFR1, 0x00000230);
>      SET_IDREG(isar, ID_DFR0, 0x10200000);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00111040);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01000000);
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 942b636aa5bd..03cbe42f22f8 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -225,7 +225,7 @@ static void arm1136_r2_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x111);
>      SET_IDREG(isar, ID_PFR1, 0x1);
>      SET_IDREG(isar, ID_DFR0, 0x2);
> -    cpu->id_afr0 = 0x3;
> +    SET_IDREG(isar, ID_AFR0, 0x3);
>      SET_IDREG(isar, ID_MMFR0, 0x01130003);
>      SET_IDREG(isar, ID_MMFR1, 0x10030302);
>      SET_IDREG(isar, ID_MMFR2, 0x01222110);
> @@ -257,7 +257,7 @@ static void arm1136_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x111);
>      SET_IDREG(isar, ID_PFR1, 0x1);
>      SET_IDREG(isar, ID_DFR0, 0x2);
> -    cpu->id_afr0 = 0x3;
> +    SET_IDREG(isar, ID_AFR0, 0x3);
>      SET_IDREG(isar, ID_MMFR0, 0x01130003);
>      SET_IDREG(isar, ID_MMFR1, 0x10030302);
>      SET_IDREG(isar, ID_MMFR2, 0x01222110);
> @@ -290,7 +290,7 @@ static void arm1176_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x111);
>      SET_IDREG(isar, ID_PFR1, 0x11);
>      SET_IDREG(isar, ID_DFR0, 0x33);
> -    cpu->id_afr0 = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x01130003);
>      SET_IDREG(isar, ID_MMFR1, 0x10030302);
>      SET_IDREG(isar, ID_MMFR2, 0x01222100);
> @@ -320,7 +320,7 @@ static void arm11mpcore_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x111);
>      SET_IDREG(isar, ID_PFR1, 0x1);
>      SET_IDREG(isar, ID_DFR0, 0);
> -    cpu->id_afr0 = 0x2;
> +    SET_IDREG(isar, ID_AFR0, 0x2);
>      SET_IDREG(isar, ID_MMFR0, 0x01100103);
>      SET_IDREG(isar, ID_MMFR1, 0x10020302);
>      SET_IDREG(isar, ID_MMFR2, 0x01222000);
> @@ -360,7 +360,7 @@ static void cortex_a8_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x1031);
>      SET_IDREG(isar, ID_PFR1, 0x11);
>      SET_IDREG(isar, ID_DFR0, 0x400);
> -    cpu->id_afr0 = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x31100003);
>      SET_IDREG(isar, ID_MMFR1, 0x20000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01202000);
> @@ -436,7 +436,7 @@ static void cortex_a9_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x1031);
>      SET_IDREG(isar, ID_PFR1, 0x11);
>      SET_IDREG(isar, ID_DFR0, 0x000);
> -    cpu->id_afr0 = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x00100103);
>      SET_IDREG(isar, ID_MMFR1, 0x20000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01230000);
> @@ -502,7 +502,7 @@ static void cortex_a7_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00001131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x02010555);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10101105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01240000);
> @@ -554,7 +554,7 @@ static void cortex_a15_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00001131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x02010555);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10201105);
>      SET_IDREG(isar, ID_MMFR1, 0x20000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01240000);
> @@ -598,7 +598,7 @@ static void cortex_r5_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x0131);
>      SET_IDREG(isar, ID_PFR1, 0x001);
>      SET_IDREG(isar, ID_DFR0, 0x010400);
> -    cpu->id_afr0 = 0x0;
> +    SET_IDREG(isar, ID_AFR0, 0x0);
>      SET_IDREG(isar, ID_MMFR0, 0x0210030);
>      SET_IDREG(isar, ID_MMFR1, 0x00000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01200000);
> @@ -745,7 +745,7 @@ static void cortex_r52_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x10111001);
>      SET_IDREG(isar, ID_DFR0, 0x03010006);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x00211040);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01200000);
> @@ -977,7 +977,7 @@ static void arm_max_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10101105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 937f29e253d7..3f4fb003f440 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -52,7 +52,7 @@ static void aarch64_a35_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    cpu->id_afr0 = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x10201105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> @@ -227,7 +227,7 @@ static void aarch64_a55_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
>      SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
> -    cpu->id_afr0       = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_DFR0, 0x04010088);
>      SET_IDREG(isar, ID_ISAR0, 0x02101110);
>      SET_IDREG(isar, ID_ISAR1, 0x13112111);
> @@ -298,7 +298,7 @@ static void aarch64_a72_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x00000131);
>      SET_IDREG(isar, ID_PFR1, 0x00011011);
>      SET_IDREG(isar, ID_DFR0, 0x03010066);
> -    cpu->id_afr0 = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_MMFR0, 0x10201105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> @@ -360,7 +360,7 @@ static void aarch64_a76_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
>      SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
> -    cpu->id_afr0       = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_DFR0, 0x04010088);
>      SET_IDREG(isar, ID_ISAR0, 0x02101110);
>      SET_IDREG(isar, ID_ISAR1, 0x13112111);
> @@ -608,7 +608,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
>      SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
> -    cpu->id_afr0       = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_DFR0, 0x04010088);
>      SET_IDREG(isar, ID_ISAR0, 0x02101110);
>      SET_IDREG(isar, ID_ISAR1, 0x13112111);
> @@ -687,7 +687,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
>      SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
> -    cpu->id_afr0       = 0x00000000;
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
>      SET_IDREG(isar, ID_DFR0, 0x15011099);
>      SET_IDREG(isar, ID_ISAR0, 0x02101110);
>      SET_IDREG(isar, ID_ISAR1, 0x13112111);
> @@ -905,7 +905,7 @@ static void aarch64_a710_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x21110131);
>      SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
>      SET_IDREG(isar, ID_DFR0, 0x16011099);
> -    cpu->id_afr0       = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x10201105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);
> @@ -1007,7 +1007,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>      SET_IDREG(isar, ID_PFR0, 0x21110131);
>      SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
>      SET_IDREG(isar, ID_DFR0, 0x16011099);
> -    cpu->id_afr0       = 0;
> +    SET_IDREG(isar, ID_AFR0, 0);
>      SET_IDREG(isar, ID_MMFR0, 0x10201105);
>      SET_IDREG(isar, ID_MMFR1, 0x40000000);
>      SET_IDREG(isar, ID_MMFR2, 0x01260000);


