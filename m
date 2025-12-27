Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D637E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 12:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZTMX-0001WA-Ph; Sat, 27 Dec 2025 07:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTMW-0001Up-RP
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:25:36 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZTMS-0005MO-Uf
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 07:25:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so69700265ad.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 04:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1766838331; x=1767443131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tGCN4kNRzivpgazlU6yse++mXkdYhAiT3gh1hfyja+E=;
 b=J1xWECp6V9w/RWzfIPNqeeFY8CWJTeFj+xG9bpsLRqik9OAUK1Sp5GC4uWje/T5QQE
 XVODWf8MDbVCYh1KJrsJWEoBxH2dVPrEwUDmlAglsZKuPAvoBK003nkleIQO3/7wYPwl
 DQIFELKXoytGHbc1ibBcvbnKR74z2VAJRi76bmmeXBbBoQufbEFAI7T0r9phfWZ36uR8
 dZ7JtkD1KkLOrbwcDFikFs5TTSt7ckUVPIDRcInCpA4bl63kIfg+zYmnbHRlTMu0mQnx
 e9l5VIa3FUY83xQMVYB+i2Z8p+ZqoC1Wb3zlcfDJwGQZCAnkzgIDLTz2eiRGUTd8F9iT
 GNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766838331; x=1767443131;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tGCN4kNRzivpgazlU6yse++mXkdYhAiT3gh1hfyja+E=;
 b=K2WXyltOAFR6BhwYVbvpmXZVn65cYNmWxiDi1PFMtUCTeq7LlyYqgY7mdSU8j5dH/O
 EoGaIlPbDVpjHHcWAyZ525BiN56JBoonLoH2zTko+9B420cO/ro3OzIJJwiGx12tsQdx
 O4WwjJhjHDABtpJVipXp39YtQy7p/ErRfUTowazWqy9o+ecIQEqpGcQGJ7VN3iTaIXs5
 5d9grawruU9owxK17rAIXUUN7EIIrXGFOOMrOQdF78+Au2KFxfWl2oAiFuXpJtuQ+uBG
 8fBWxSTu2tBnKhuw3RCfEUqFXWUc+whehuXDlkSI9vrFH8YYtXptumrgagzDPQUVbKHB
 xR9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+spgHJx/xyQXegkfdbnydPF71TG0gSDZGNNco3x3GuIa6X0b+099F0wW2Qg9ZKFHHSWQgrXlNIVH4@nongnu.org
X-Gm-Message-State: AOJu0Ywwe6ZYepf8aiqnX+gUSPCZNLy/wbxTgrE6Sanz4XObggP4K1SP
 eo6jOQaLc5TyJ7/loI0nZ/IiqkZpXoyC/UDufVnFUIp/cm+hz1ffLqE7sXf4mLpZO5c=
X-Gm-Gg: AY/fxX5WDKG7Ec3tCR9OKMQ7kso1LgqOjwUTT4ehKLGSdMGBQ+PcEey3cb8ZjVtFkXL
 VixJqVZ3MS4ILdlXhTXmwj8nSG2El8pE6bcZvRr5TqQ9vpkXkMFYNiHzSuuUlZjR8urnU4Ir221
 eRZXvbm56K8SW+U5XQpucKvIkqJFA8jFfdRW4XO0QVHBHlidP2SxquiTdDgvIbdBaB1UazwM3QE
 wqOhM9irIbDM9lksReqfuOXZI3Bs09qlJSsgXgnE5BH1Kyy48Ae+ETk1B6+3RAzNZ547r9Tscm2
 kiFCdkeAY9lodPmPScGRMtz51zbWpRiuKN1d2VTz88w+6SSACN8OA5EFzkX/Rqz02wuaOtSKpXa
 Iqd2mtPS4Exo/AJb01XEINhGb7MqNvkSKYnX0Ll4AeOZAuoE2ZQqlLVMfS1XHHvc2CffWMerNwW
 8dqlw5Oxn4wgjAcIXroTOGhxhe0os=
X-Google-Smtp-Source: AGHT+IGWiJ+l301wQaAaaBklKacmPpczF56i5IyWsLjkg6s3iD+91IVwAo8K1t+xQ2wf3pk6UwPVSQ==
X-Received: by 2002:a05:7022:7e8e:b0:11a:c387:1357 with SMTP id
 a92af1059eb24-121722ac203mr23430874c88.16.1766838331365; 
 Sat, 27 Dec 2025 04:25:31 -0800 (PST)
Received: from [192.168.68.110] ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254ce49sm95419413c88.15.2025.12.27.04.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 04:25:30 -0800 (PST)
Message-ID: <d8f08ec0-ad45-48f2-bc2d-830ed25b623a@ventanamicro.com>
Date: Sat, 27 Dec 2025 09:25:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Align pmp size to pmp-granularity
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251223102547.13337-1-jay.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251223102547.13337-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 12/23/25 7:25 AM, Jay Chang wrote:
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it automatically aligned
> to the PMP granularity.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/pmp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..01b337f529 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>               uint8_t a_field = pmp_get_a_field(val);
>               /*
>                * When granularity g >= 1 (i.e., granularity > 4 bytes),
> -             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> +             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
> +             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
>                */
>               if ((riscv_cpu_cfg(env)->pmp_granularity >
>                   MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
> -                    return false;
> +                    val |= PMP_AMATCH;
>               }
>               env->pmp_state.pmp[pmp_index].cfg_reg = val;
>               pmp_update_rule_addr(env, pmp_index);
> @@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>           break;
>   
>       case PMP_AMATCH_NAPOT:
> +        /* Align to pmp_granularity */
> +        if (g >= 2) {
> +            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
> +        }
> +
>           pmp_decode_napot(this_addr, &sa, &ea);
>           break;
>   


