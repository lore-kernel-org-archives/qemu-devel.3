Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA86AD116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 11:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOwoR-0002Cw-Lo; Fri, 28 Nov 2025 06:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwoK-0002Ax-OM
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:38:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwoE-0000wW-OI
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:38:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29845b06dd2so23767015ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764329921; x=1764934721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B3W3zaRuryIzEchU4VZXi8OZPPCsajr5u8lNnhbimyY=;
 b=kLmh81+/egSM1vPmVrWTseZXQqJKtIsm+E2uDhTfeXy2pOUHZV65tqhlDwJW5DuTdM
 bLen8QH3R6gr4uTStfciUkYAihTlEI9WwCWP6VR10CoNMzVLZTqIGO/h0zGKro2iGj+Z
 2ZmLfe8x6zyFkWv3IKFy2yj/4c/YDNVIFg3Qbn0J61Rm85Kz01iR0hUGwkoBCXNxdaus
 61nTG9BDOvh/rhciENQAxnV2y+vHK5p3oVeNcyTFqIiEIGl5j/Fue26YkC6/pP54PGKg
 eDEDa7IkQKvCv658+Iew4jwmvneJcf7tquVv54JizpjEky24E9TsSY11ax0/yN5LN2jA
 67eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764329921; x=1764934721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3W3zaRuryIzEchU4VZXi8OZPPCsajr5u8lNnhbimyY=;
 b=i/XaOhdt89q4YqIZ3i5g1UgPLXo8/u4ziaQ7LIJ1WI2ArzkWgB8kj24c1xUr9RZ7Er
 VzQGdMpZ6cUfZJ2ZzWHQyEx6kLEBwOYbF6u0BY2V0BHJbL7Bf+CtLmuRtVAczdNgxB5o
 ul4rjPpc9wZ+K5DNVpP0BWTZSH0YGR2FdAMMFEARgokwKTupt7N6wjnaE8DeVg7N1o3E
 rwsb49AXHAk1SnFzsf+18yql+g97sCYmyhe52gRIY+hb2TQ3YAR8btX3NB+I2qI+oEdR
 8wseMKJh4u/CKqHk1URxY4DTXihFKl9RrgLi1zV9TtY2V1Vi3pkFOMpFhEU6THD77fVz
 VrYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy/Bhd2gmcgNYBjvMifdlLVtrpyWYIMU0s2VjmRUZTn7WRgMW82brMaB9BzZCb8cuxRwa3b+/F4Vmx@nongnu.org
X-Gm-Message-State: AOJu0Yw7rXD/oO5fYl/PAbOa1pqqeTVvQQCchWSj2cdD5aky0RkmA6KP
 +XNaz66teYWcfQvtPGIzJQTCVKkiHk93vLFxYOAPeSFAxCsUPBmh3kMSmiCM3Hf97tA=
X-Gm-Gg: ASbGncsoqtqI6WazP9YHdSz+VVltlzncC5TIECIZUHLzmMBkilVFV12Qhlr3o2ye8vk
 uSwXvqspikNZF2GhY6vRzFqiT3upVUJ5WEXj5g/lwohK8K/yuva5zQX2ftOnH6WVBIQlsFNY6i0
 QbwIGWn3LUhE/JszXF1PIZAI8j+3IjS+4YX8Y4vdCRZlSv1NRQheBe6F7/FklwHdvS5RokoXUF3
 PxBG6gynPXEvv2QYNw3C8cfWYOOuiPM0T0G1GXpGTEEUay6bX7ARbKB0YF8PKhe1kprRlIRZxGf
 hmxzLEdskDjY0JZR1Pl0ZiCe5tzM/Awc3zGXEzyfZhg1wdJmRSr2P62g2tX138ttVE8YbJNkoIC
 gVtlnRIn35JekGGvRiw0aRyL+6OYDQI8HXfkM51mbLji1WsNekv9us/+1jLh4/Mgcoy1w3YsdZk
 gu2g6ef0g1VvFUH5+lPr1IYAvhazHVDy4RL8Wz
X-Google-Smtp-Source: AGHT+IHAaI7YAIu9eA8D7pbNZuxsxlBG5YsOn9tHBz9oH3l9E8qXEKOC7jyAKvXlv4HWO2Ibq+7DUw==
X-Received: by 2002:a17:903:19ec:b0:29b:5c65:4520 with SMTP id
 d9443c01a7336-29b6c5750f1mr272471275ad.29.1764329921035; 
 Fri, 28 Nov 2025 03:38:41 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-be4fbde37d7sm4459955a12.13.2025.11.28.03.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 03:38:40 -0800 (PST)
Message-ID: <dbe5461f-2388-4dd0-a876-37d16bca2fa5@ventanamicro.com>
Date: Fri, 28 Nov 2025 08:38:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: Simpily support versioning of debug
 trigger module
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, vivahavey@gmail.com,
 Yu-Ming Chang <yumin686@andestech.com>
References: <20251126164329.2157287-1-alvinga@andestech.com>
 <20251126164329.2157287-3-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251126164329.2157287-3-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/26/25 1:43 PM, Alvin Chang wrote:
> To support multiple versions of debug specification, we have added
> "debug-1.0" CPU property. Now the debug trigger module inspects this
> property to determine the supported trigger types by the CPU. In this
> commit we validate written trigger type with CPU debug version. For
> example, the debug specification v0.13 does not support mcontrol6, and
> the indended tdata_csr_write() on tdata1 with type=mcontrol6 will be

I suppose you meant 'intended'.


With the typo fixed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> ignored.
> 
> If debug v1.0 is selected, the default trigger type is mcontrol6
> instead of legacy mcontrol.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>   target/riscv/debug.c | 56 +++++++++++++++++++++++++++++++++++++++++---
>   target/riscv/debug.h |  1 +
>   2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5664466..5163193 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -64,6 +64,26 @@ static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
>       [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
>   };
>   
> +/* Valid trigger types supported by debug specification v0.13 */
> +static bool valid_trigger_type_v013[TRIGGER_TYPE_NUM] = {
> +    [TRIGGER_TYPE_AD_MATCH] = true,
> +    [TRIGGER_TYPE_INST_CNT] = true,
> +    [TRIGGER_TYPE_INT] = true,
> +    [TRIGGER_TYPE_EXCP] = true,
> +    [TRIGGER_TYPE_UNAVAIL] = true
> +};
> +
> +/* Valid trigger types supported by debug specification v1.0 */
> +static bool valid_trigger_type_v100[TRIGGER_TYPE_NUM] = {
> +    [TRIGGER_TYPE_AD_MATCH] = true,
> +    [TRIGGER_TYPE_INST_CNT] = true,
> +    [TRIGGER_TYPE_INT] = true,
> +    [TRIGGER_TYPE_EXCP] = true,
> +    [TRIGGER_TYPE_AD_MATCH6] = true,
> +    [TRIGGER_TYPE_EXT_SRC] = true,
> +    [TRIGGER_TYPE_DISABLED] = true
> +};
> +
>   /* only breakpoint size 1/2/4/8 supported */
>   static int access_size[SIZE_NUM] = {
>       [SIZE_ANY] = 0,
> @@ -95,6 +115,20 @@ static inline target_ulong get_trigger_type(CPURISCVState *env,
>       return extract_trigger_type(env, env->tdata1[trigger_index]);
>   }
>   
> +static inline bool validate_trigger_type(CPURISCVState *env,
> +                                         target_ulong trigger_type)
> +{
> +    if (trigger_type >= TRIGGER_TYPE_NUM) {
> +        return false;
> +    }
> +
> +    if (riscv_cpu_cfg(env)->debug_1_00) {
> +        return valid_trigger_type_v100[trigger_type];
> +    }
> +
> +    return valid_trigger_type_v013[trigger_type];
> +}
> +
>   static trigger_action_t get_trigger_action(CPURISCVState *env,
>                                              target_ulong trigger_index)
>   {
> @@ -889,6 +923,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>           trigger_type = get_trigger_type(env, env->trigger_cur);
>       }
>   
> +    if (!validate_trigger_type(env, trigger_type)) {
> +        /* Since the tdada1.type is WARL, we simpily ignore write here. */
> +        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n",
> +                      trigger_type);
> +        return;
> +    }
> +
>       switch (trigger_type) {
>       case TRIGGER_TYPE_AD_MATCH:
>           type2_reg_write(env, env->trigger_cur, tdata_index, val);
> @@ -918,8 +959,11 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>   target_ulong tinfo_csr_read(CPURISCVState *env)
>   {
>       /* assume all triggers support the same types of triggers */
> -    return BIT(TRIGGER_TYPE_AD_MATCH) |
> -           BIT(TRIGGER_TYPE_AD_MATCH6);
> +    if (riscv_cpu_cfg(env)->debug_1_00) {
> +        return BIT(TRIGGER_TYPE_AD_MATCH) | BIT(TRIGGER_TYPE_AD_MATCH6);
> +    }
> +
> +    return BIT(TRIGGER_TYPE_AD_MATCH);
>   }
>   
>   void riscv_cpu_debug_excp_handler(CPUState *cs)
> @@ -1056,9 +1100,15 @@ void riscv_trigger_realize(CPURISCVState *env)
>   
>   void riscv_trigger_reset_hold(CPURISCVState *env)
>   {
> -    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
> +    target_ulong tdata1;
>       int i;
>   
> +    if (riscv_cpu_cfg(env)->debug_1_00) {
> +        tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH6, 0, 0);
> +    } else {
> +        tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
> +    }
> +
>       /* init to type 2 triggers */
>       for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>           /*
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index f76b8f9..0127cb9 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -43,6 +43,7 @@ typedef enum {
>       TRIGGER_TYPE_AD_MATCH6 = 6,     /* new address/data match trigger */
>       TRIGGER_TYPE_EXT_SRC = 7,       /* external source trigger */
>       TRIGGER_TYPE_UNAVAIL = 15,      /* trigger exists, but unavailable */
> +    TRIGGER_TYPE_DISABLED = 15,     /* trigger exists, but disabled */
>       TRIGGER_TYPE_NUM
>   } trigger_type_t;
>   


