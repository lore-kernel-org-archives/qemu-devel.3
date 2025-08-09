Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A9CC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 13:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukjIk-0007ED-93; Sat, 09 Aug 2025 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukjIh-0007CQ-ND
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 09:07:55 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukjIe-00013o-GN
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 09:07:55 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32128c5fc44so2518871a91.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754744871; x=1755349671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnhvN/QEHbRtVO7YxiovAlrUeekiX1kxdle80dQ1Rbg=;
 b=NGM4GUE+/NTjtP1lKfE1uhr1pF60/v4UwqSXnsoXruIDBKxX1UZL3MjNjNwc6AJPTG
 trAA3XdLZdxSX/6FOsppZnxrPWBbD0rXjdE07PtJKkAhvxvvgmFnM3aqsR8gVZWyvaBc
 NYr25lrx4DXhMn1AM4NnIxEBeETtLfpxR8+bfMnCrBr5c+A18ERTGSFEKqs6iAEBG4x8
 LpZPJ5vj5bybhxeJp+SoyUjE8E9mWAya2PyK/nqVRHIdfWOluzvoVjDlPx8aG/TJqejv
 3yG2i4TCY2nHWT+oWTTHgZdWP0SPRMpYbRuSoqW2auYTjM6aV/gDVnbeFkmuSdh3yV2Z
 Bcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754744871; x=1755349671;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnhvN/QEHbRtVO7YxiovAlrUeekiX1kxdle80dQ1Rbg=;
 b=HhWFhzmpBJXP476FEiTCej/XYD4+TFa7UbLZpwsOoqHBrGUJ8tlzBlvniwMMhjHnbB
 ytmt0y7eYClOm0z/SdM4kloFa0cV0LfSlg1T1mEwHk/KnLN27aB7DQ7z7L6NWF62CRrV
 Ulaj6RmwkENPF2HhClqvC33M855PTo7S3bxY5fa7oPlxlyDoEyDDYkPsk/Bye5i7yFYz
 kEpFBlPGEUSo4AF2x/HAq1Ag7g8HP0gRPnsUvdZTDlOUPkdDNKQpm+T21F8dJhIOeN+d
 unkMDUUwZw483KnKHjATMAkRNCPnXq1WIpGEcVXhoZ0vq+sNp7rKrZNRXG5JQb24DJgE
 ubXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVStvQCsYU1ZFyyZ93IDUGJO+AjFLK41KhU/9WzYWSA5oB1P65UTLWJ6b11XmL/3/xZLx890ewwRWAH@nongnu.org
X-Gm-Message-State: AOJu0Yyhm+zXd1Wgoo4RuxZtJ41SC/kx6mBXZNUSvGYb610oJFN9WBtp
 jzKUEvMntJ0X45A5rYXP6oGs/FPahI63HTPDv8IGw1J5NXZFPhkhgXptvqiPAldRhf0=
X-Gm-Gg: ASbGncsaZFkeeiw9+acSASQdEOJ9AJ8VnP2CtQy0EJlZduYijMcvDtCReE4fIvK9lTh
 Q3oH57a1eJTKwqyhNt/dlbTxVst1GB8P3Y0uw5UdQS9GxQc7/5D2sLorqyA4aWlE6yTgVumiEI6
 uf+fmZ+e/3pg828hxguIjQArfei3nIXTGRBe4xUL2qlQ6BJ789KnwnQSq+Z3kHJusnq+mvrEb2x
 zgl9E4QNp5vkCWprEICAbWfY+kfqK7aLJpf8ZQVM1PP1XMrfBh2xZrCnSaUObTaj3PTYMUvBokh
 2OtK6qjoL/QuYMEQneFi1Rlwu+yBjpsqPo3rE5KvHIbXrAzl21oYxT0XM5KcO6nVsnzwzCkTQlk
 Z8OYCKmh/ZtEYT4kmura7kCi2MEszgl1TkcS45A==
X-Google-Smtp-Source: AGHT+IH9krsvhR1fqbCrcYcf4Rj/VlJNTuvVi0EVjfJ+RkpEg5QAWe9LvaaCLaJqFAiHjCN88dQ5mw==
X-Received: by 2002:a17:90b:3c04:b0:31f:14b:f397 with SMTP id
 98e67ed59e1d1-32184377ae6mr10571848a91.1.1754744870744; 
 Sat, 09 Aug 2025 06:07:50 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da602asm26961926a91.2.2025.08.09.06.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 06:07:50 -0700 (PDT)
Message-ID: <20701dc8-d156-4ad9-8945-282321c15527@ventanamicro.com>
Date: Sat, 9 Aug 2025 10:07:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] hw/misc: riscv_worldguard: Add API to enable WG
 extension of CPU
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-14-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-14-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> riscv_worldguard_apply_cpu() could enable WG CPU extension and set WG
> callback to CPUs. It is used by machine code after realizing global WG
> device.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/misc/riscv_worldguard.c         | 87 ++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_worldguard.h |  1 +
>   2 files changed, 88 insertions(+)
> 
> diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> index b02bd28d02..1a910f4cf3 100644
> --- a/hw/misc/riscv_worldguard.c
> +++ b/hw/misc/riscv_worldguard.c
> @@ -92,6 +92,93 @@ uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
>       }
>   }
>   
> +static void riscv_cpu_wg_reset(CPURISCVState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    uint32_t mlwid, slwid, mwiddeleg;
> +    uint32_t trustedwid;
> +
> +    if (!riscv_cpu_cfg(env)->ext_smwg) {
> +        return;
> +    }
> +
> +    if (worldguard_config == NULL) {
> +        /*
> +         * Note: This reset is dummy now and WG CSRs will be reset again
> +         * after worldguard_config is realized.
> +         */
> +        return;
> +    }
> +
> +    trustedwid = worldguard_config->trustedwid;
> +    if (trustedwid == NO_TRUSTEDWID) {
> +        trustedwid = worldguard_config->nworlds - 1;
> +    }
> +
> +    /* Reset mlwid, slwid, mwiddeleg CSRs */
> +    if (worldguard_config->hw_bypass) {
> +        /* HW bypass mode */
> +        mlwid = trustedwid;
> +    } else {
> +        mlwid = 0;
> +    }
> +    slwid = 0;
> +    mwiddeleg = 0;
> +
> +    env->mlwid = mlwid;
> +    if (riscv_cpu_cfg(env)->ext_sswg) {
> +        env->slwid = slwid;
> +        env->mwiddeleg = mwiddeleg;
> +    }
> +
> +    /* Check mwid, mwidlist config */
> +    if (worldguard_config != NULL) {
> +        uint32_t valid_widlist = MAKE_64BIT_MASK(0, worldguard_config->nworlds);
> +
> +        /* CPU use default mwid / mwidlist config if not set */
> +        if (cpu->cfg.mwidlist == UINT32_MAX) {
> +            /* mwidlist contains all WIDs */
> +            cpu->cfg.mwidlist = valid_widlist;
> +        }
> +        if (cpu->cfg.mwid == UINT32_MAX) {
> +            cpu->cfg.mwid = trustedwid;
> +        }
> +
> +        /* Check if mwid/mwidlist HW config is valid in NWorld. */
> +        g_assert((cpu->cfg.mwidlist & ~valid_widlist) == 0);
> +        g_assert(cpu->cfg.mwid < worldguard_config->nworlds);
> +    }
> +}
> +
> +/*
> + * riscv_worldguard_apply_cpu - Enable WG extension of CPU
> + *
> + * Note: This API should be used after global WG device is created
> + * (riscv_worldguard_realize()).
> + */
> +void riscv_worldguard_apply_cpu(uint32_t hartid)
> +{
> +    /* WG global config should exist */
> +    g_assert(worldguard_config);

We usually add g_asserts() after the variable declarations.

> +
> +    CPUState *cpu = qemu_get_cpu(hartid);
> +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> +    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
> +
> +    rcpu->cfg.ext_smwg = true;
> +    if (riscv_has_ext(env, RVS) && riscv_has_ext(env, RVU)) {
> +        rcpu->cfg.ext_sswg = true;
> +    }

riscv_has_ext() will segfault if env == NULL, and you're creating a code
path where this might happen:

> +    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;

In fact, cpu == NULL will explode on you earlier via this macro:

> +    RISCVCPU *rcpu = RISCV_CPU(cpu);

You can either handle cpu == NULL with a clean exit before using 'cpu' to assign
stuff or g_assert(cpu != NULL) for a more rude exit. But with this code as is
you're gambling with segfaults.


Thanks,

Daniel


> +
> +    /* Set machine specific WorldGuard callback */
> +    env->wg_reset = riscv_cpu_wg_reset;
> +    env->wid_to_mem_attrs = wid_to_mem_attrs;
> +
> +    /* Reset WG CSRs in CPU */
> +    env->wg_reset(env);
> +}
> +
>   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
>   {
>       uint32_t wid = mem_attrs_to_wid(attrs);
> diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
> index 8a533a0517..211a72e438 100644
> --- a/include/hw/misc/riscv_worldguard.h
> +++ b/include/hw/misc/riscv_worldguard.h
> @@ -48,6 +48,7 @@ extern struct RISCVWorldGuardState *worldguard_config;
>   
>   DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
>                                        bool hw_bypass, bool tz_compat);
> +void riscv_worldguard_apply_cpu(uint32_t hartid);
>   
>   uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
>   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);


