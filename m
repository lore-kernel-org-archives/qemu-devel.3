Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1485EC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEU-0001X0-Do; Mon, 24 Mar 2025 21:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEK-0001Us-TY
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEJ-0007PJ-9E
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c915749so66295155ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866642; x=1743471442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+TZInR2wyUL/fIdQxW8KxlK8QHtFZYM5KguBd4nFQI=;
 b=JCkdrM5jHT2cgBgcqXq4TS/wL3cchtHn07RJyYquRetIy2ggDUS0vTBa3V+mrsEeDe
 7Zecj+0f+5jtPsm3KPdUaBkestWwipl/Eb8jbhm8tL8H/QKHjZ4X6OX2sQ28JRNCqcSW
 hpHQ5Nhd6kk9bkrRozsnRArzBgS/jUYOW9IkRf+sEqqAYoapOwzSe0KNxTf8eqBR4cCu
 Whb/bIv3iaqxeP4OxRbDLEvk+sH44upBauRBvy5/GL5LSdMmykw63na+KjbiCCM1dx5k
 d+QTtqoxWn6bFyRcCPtbPs03ztN3x/fnlKKN80RDnQgjmBKK8DavlLJPLN2GZcPPUWgL
 F6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866642; x=1743471442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+TZInR2wyUL/fIdQxW8KxlK8QHtFZYM5KguBd4nFQI=;
 b=kqNlavvKkhx2RJet5vP77WhEoT9uNeS+QwbTMxgum27DYxfq+KUeCGZ8N0eb730vAp
 s4MoI825JPp3l7QAlDHZ5lQhXZxd89NuHMbFGjSskW/n95iZeCeArUBbfpxYs3rd+4wR
 jgATCFqOniy6gwsbHUMsA2rD8fGBtVuz7ZAny2wn7IWVDt344FKp3p88Ve4pJwdd/C/j
 u5PS+3TkQnUVn7iejqcXHw+dZJAj+PMni90vKxYh/ZXm5r6hQG3hwbSZ/pmTW//q71M8
 rRcrmLwv5bZIPMQ3SPVJrk2ir5Sly8YwDdDXeZ5VpGm6cdxbO+m//1W4o+wZoFx9l07D
 FUPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOUormIP6//UtopIKIoZZnfoTO0+eTbG4enivM6foDLe1dTjpGB3fAB+HTqjtMSHjU3DJNKgjA7/nu@nongnu.org
X-Gm-Message-State: AOJu0Ywr0qRknMF6JVz6DFG9VbPhGBGf3fNXU9jLCk0Ubm1MwasqEXPD
 M7WyB6dCEE78JPb04mtfO20RfBkJeBCW+7o6wbuvSR4jpEJJrpj0pCWQbEEfrwU=
X-Gm-Gg: ASbGncuNPJY6zON736IlZMDcjNjQHmYtVAbFCthRbjdqtewgu1mkQXeIjdV6G4sZvde
 nf90NgkyEODetCGkVQ4Ppndrnya1E34JyW0Nx4dZzccGyyrULoZsVLcfw4ws669+C9p0rHqNN9g
 gELcBdAcu3E3YzbgRkPY4f/zTavtYLHhIiJ/RFQ9geuMhdnUtJxqFFFE6NAaZsm/Rgr+pWeR8AW
 Aj9I2/XVrrcLyNMrc06bhFf6/oLC+8WK7d89blRl0d8at/YPF8N3wAHGZOXl/aKZqM4DClpFL3+
 Szgl0+Q0a8x9m5WXF2rzyo4Y/0sQHu/32IRJ21NusuUoo0Bw7cwqMSLEJg==
X-Google-Smtp-Source: AGHT+IG3feS6PStJzkLRwFwoFDTB2rjWrdRiNiA8+9spJ5CzvRd+uAPgb5SzKBiE/abBxRDSlp0rEA==
X-Received: by 2002:a17:903:2311:b0:224:122d:d2de with SMTP id
 d9443c01a7336-22780c7bfa6mr217133535ad.16.1742866641684; 
 Mon, 24 Mar 2025 18:37:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:21 -0700 (PDT)
Message-ID: <ea5f47aa-1bee-4bc0-a5b1-bfce9fb5c09e@linaro.org>
Date: Mon, 24 Mar 2025 18:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] target/avr: Add offset-io cpu property
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Communicate the offset of io within the first page between the
> board, the cpu, and the translator.  So far this is always 0.
> This will be used to optimize memory layout.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h       | 2 ++
>   hw/avr/atmega.c        | 2 ++
>   target/avr/cpu.c       | 1 +
>   target/avr/translate.c | 2 ++
>   4 files changed, 7 insertions(+)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index be27b0152b..0f5e1a53bc 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -148,6 +148,8 @@ struct ArchCPU {
>   
>       /* Initial value of stack pointer */
>       uint32_t init_sp;
> +    /* Offset of the beginning of I/O within the first page. */
> +    uint32_t offset_io;
>   };
>   
>   /**
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index f6844bf118..273582b8af 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -236,6 +236,8 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>   
>       object_property_set_uint(OBJECT(&s->cpu), "init-sp",
>                                mc->io_size + mc->sram_size - 1, &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpu), "offset-io",
> +                             0, &error_abort);
>   
>       qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>       cpudev = DEVICE(&s->cpu);
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 0b14b36c17..080f6f30d3 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -169,6 +169,7 @@ static void avr_cpu_initfn(Object *obj)
>   
>   static const Property avr_cpu_properties[] = {
>       DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
> +    DEFINE_PROP_UINT32("offset-io", AVRCPU, offset_io, 0),
>   };
>   
>   static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 0490936cd5..e9fef1aaad 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -92,6 +92,7 @@ struct DisasContext {
>   
>       /* Routine used to access memory */
>       int memidx;
> +    uint32_t offset_io;
>   
>       /*
>        * some AVR instructions can make the following instruction to be skipped
> @@ -2664,6 +2665,7 @@ static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->cs = cs;
>       ctx->env = cpu_env(cs);
>       ctx->npc = ctx->base.pc_first / 2;
> +    ctx->offset_io = env_archcpu(ctx->env)->offset_io;
>   
>       ctx->skip_cond = TCG_COND_NEVER;
>       if (tb_flags & TB_FLAGS_SKIP) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


