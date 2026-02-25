Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6D3F55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6jx-0007BU-Nv; Tue, 24 Feb 2026 23:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6jw-0007BD-JB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:43:12 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6jv-000880-5h
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:43:12 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79868eae536so2121107b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994590; x=1772599390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dd9KFOHIHW0bHbYq4AjKCWC+KMVVBBlqH8qPQzzfQtY=;
 b=Vj+2nuZpEC4NB/McDnNPUSXKrCRM80y9dziZE6T3N2UHludFktoyb4DOedm1uH7K1E
 KclD5mVu9Ub/OhSs7bqsQpkwzKd0qc5MwzCcG86WkRQUt1VBXtlRw0mwRiCQqbSQB6nM
 Z6FbatfuwLgk/J8XhakolFPQYBvzgjWawv1VFRP3bmObEAeJA0fx4HBqUdRxGNOs35rV
 xU4GR/meJiZguwLPKtctn67Qp+ThhfySFhuayo0SUUNk4yh70dV71kRrAzUyVlPsTfKL
 ARq7TAkVibgaRH4YzopmZ8Td8QvJE5IFohbpCjkvd45PwJ8T+livWEH2I3WmxtssuFjT
 ABow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994590; x=1772599390;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dd9KFOHIHW0bHbYq4AjKCWC+KMVVBBlqH8qPQzzfQtY=;
 b=LKejJ/VmtaKmOFcw5VdzCPGmDqXK6t24rcAyUk2JsT1XJM48TEIxJVOrrkEtRpq90F
 mVKK5QkeX44VmxdNMuTOXOzIpeSKkb2IidjkQ6DqNAmBCcSH5ImSkafjeAAaEstOrgCN
 xglOHAk9p5pVFIpgsGOjcpHviyAB92+fFHZ635pNI2SH7IJjiu1NQlcag5lWWAjx7GKV
 6CSGsnMW5W3/yyeJR1NmFdDuRTIoAiZrzslmkimqjyfh9iGsBk+fkU120mI+EYg+6tG5
 F24Nq/ZGydGGh7/PDB7bgR+C6TreNaGaGGI5kD+L6+j0W6LKpU0BKWqoNlVjJ7MTLWy6
 9pwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFj9e+5Oa8nuipmrb3x5BBhJImW9VtxpTpKbQXXJgIo28zswMaOvh25Po2hYhUZ5AgsfdLbirPaFss@nongnu.org
X-Gm-Message-State: AOJu0YxY6AO2VRMHzLr1+GXoIHf2JVicD6V8UAeutsNacqSpHRc1Vkjk
 D1sVa4pHK0qRx3dvD0qAGihd8+gZ0kC/1lg3irkjDv7XcD+wUGTtDZqXrhS94tYkVxc4QOzoh7D
 sj/TCVvQ=
X-Gm-Gg: ATEYQzwEVfP8WSGCkvJhEirjaFU6ZwDKTKnxwGVGaTNZ9WoXGWP4NMpmsxzWQ/s1RDb
 CyOvNcHmMZuK10QmLxRleTPKKzsR32iE5F29lvBYWUu52gzNdlJ0WmS4B0mQAKV9VxphoKx8Qv/
 L1swT9v2DG3l+juDuPvNVItnVOZjNsnDYpdHUZkak9QnnhO6AQPEIpVnxt91CNN0F4ilM+EXXLY
 1MauIr+b1qAwAxW3KAdsk3ULMFvYAasq+aXLD2ZSv97HVM32c052Lef0Lzmw2YBuRgTT1An+yY6
 rNLd1ylVofaAwFiTYjbGT/oMjZKUXO+AQw5WHaI2xlcx4A1BK4sbvtjBoSkOAjxCqlG6TNhxzhs
 I0CtAvYLX9kMsIa8/j6ZCcYpeW7MDxllODGMwxxzovW6kxqq6phwjd6IFZFZZUvcOZVwqNtsbm4
 jYuApa6CB5HQuQkTFT8uj5Mz3cWxkAYhQE5GPn/JWBJxxStPIpt5U1SkuHJS++k3k=
X-Received: by 2002:a05:690c:9990:b0:796:9c2a:d657 with SMTP id
 00721157ae682-79828ef118bmr134656957b3.10.1771994589942; 
 Tue, 24 Feb 2026 20:43:09 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7982ddc6b65sm52742147b3.39.2026.02.24.20.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:43:09 -0800 (PST)
Message-ID: <a17fa471-11ec-4c0d-be33-09b28a08cc4e@linaro.org>
Date: Wed, 25 Feb 2026 15:42:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260225034720.41495-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225034720.41495-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/25/26 14:47, Philippe Mathieu-Daudé wrote:
> allwinner_cpucfg_cpu_reset() doesn't access ARM CPU internal
> fields: no need to cast, pass a generic CPU pointer along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/allwinner-cpucfg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
> index 3a1526bda0d..f8dbfdd120c 100644
> --- a/hw/misc/allwinner-cpucfg.c
> +++ b/hw/misc/allwinner-cpucfg.c
> @@ -84,7 +84,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
>   
>       trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
>   
> -    ARMCPU *target_cpu = ARM_CPU(arm_get_cpu_by_id(cpu_id));
> +    CPUState *target_cpu = arm_get_cpu_by_id(cpu_id);
>       if (!target_cpu) {
>           /*
>            * Called with a bogus value for cpu_id. Guest error will
> @@ -92,7 +92,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
>            */
>           return;
>       }
> -    bool target_aa64 = arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64);
> +    bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);
>   
>       ret = arm_set_cpu_on(cpu_id, s->entry_addr, 0,
>                            CPU_EXCEPTION_LEVEL_ON_RESET, target_aa64);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

