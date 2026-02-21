Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9BC61DE5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtmCr-0000Kx-BP; Sat, 21 Feb 2026 07:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmCp-0000KZ-Sn
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:35:31 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmCo-0007Bq-7n
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:35:31 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-896f5af3d8aso42421266d6.1
 for <qemu-devel@nongnu.org>; Sat, 21 Feb 2026 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1771677329; x=1772282129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxXXqauAtQ2VxkDuU8QcvTSJm7EWIs/ZwHD+lODSToc=;
 b=fTmV2GOLfsIc6dicjP/1BfrFoE4gNRwUyNHevCqUrQcWMKJ+0D0wP1a6xON5Nm36UJ
 U7vb6YgXCnQx5/9Yy7LPgOCVTXW8U8ZWG1AtRk4QoQyhGJOIajacA/0/H8MTiq1sPYk+
 EOGU4rtWrcKvv5xnHEfuQ64OObmhFVBB1CQJSc919TBMNc9QsSBI5+i9x/RErZpAmkUt
 MfHHzYctk+1cuQd2Qb33sbTXMP8XUFxdKHfaRZ3FQ+3rhF0qA421f11gfDa00pIUT2+Y
 teW0PE1HCHC5zyMIX8cRc1KEgEIExqH2zNXqTBnLYJlYy7hQ1aK+BF2tX3XCFzt13CmC
 pfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771677329; x=1772282129;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxXXqauAtQ2VxkDuU8QcvTSJm7EWIs/ZwHD+lODSToc=;
 b=KTEiuC46IORDz0ST2VIVr494W5wOIKHOBK+N2JVPd+3OLA//MJNFX1ntPJjM/tAZYk
 ydxt7tF8MwF14OUf3eWwDocQzZChtVlwDE5NtiAezQmvZkXj3jrL+kCDiDwTPVGwVXRa
 g5kpp/272JjERg1NbKgHx+GCJuZ1smPyx00poitg8vcBPEBu1HzuIV0AaZ3U+k1wU7yo
 qa/rq7HPkSllzd/poDfzitySbwRlVpztrre281qaBs+nIpmNTS9fcs3K/n1CSulXzrpU
 u1hTc62NdnCKgJlSl8UoXJm4cjwrfPWY9gFNS4DEW2zPn+wYHRWkaZmy+dPP6mMY7bnU
 0Fgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5KISUA9k2ayWErJG9eV0j6U1z7Un5weXNQaycRUI3e1cA6Syv2dJyWUBOX2BdH5ANkG+BbnObFumw@nongnu.org
X-Gm-Message-State: AOJu0Ywm9Mu1blidtZPdcTAp1/U28FHHQxth/86/b7cViSlVaBhzgyou
 2/caYYavnGqLoeckESeHuDvT/l3Z5I1aWKqk8UT+Y6svchfbX7Rkas/t1jLmUHZWtaU=
X-Gm-Gg: AZuq6aLs/uAvmGyL4pmRHy+CSB8JhquxcyRmQTmGmzhQXDOhC4Poaq5gTc70zlXM0Hr
 CL4ZCbAeJkbXwKPmznn+Y910FSl8c7QQffdNASz+jMRzujhukqRMCfzTMiyLYRzRT/mMd82v+nu
 oxnRokzT/UzeAh8QiBSXp9tJPitX1emZdvGZfJ4pR+EoGBgtWhmVnDvd8iNgn81UNyuOGDfEyRq
 bpJGQDMK6+l8fEyefje9s7j01m/GIksSxADERyRU19yWAvUSs2oZ0l9SwM20eeLMDg+y/9nrmUM
 UMQ7tFZW2yxzhkYk2X3ta/ZjGNhbve57fQFC/DxjkBPOYp0wPgmYPTr+E1x0o+y/FwQjU5DpKWA
 x4WWmnFhWZvH2aEAfQBsUEfb7qdOJuUfdZUFRjIJjAb09t7Ul4pVVPTPLuex2dnMMBYnwo/1eUs
 b32A02s9wWk26j1ocrIQPKJ1f4O4Jma3gGjRq75f6zAm4CbiRDIw==
X-Received: by 2002:a05:6214:260d:b0:895:35ea:8bc6 with SMTP id
 6a1803df08f44-89979db5299mr45177786d6.67.1771677329028; 
 Sat, 21 Feb 2026 04:35:29 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997c6bab2dsm17220546d6.14.2026.02.21.04.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Feb 2026 04:35:28 -0800 (PST)
Message-ID: <4d130eea-dfe9-4cef-9370-b92dcb4721ea@ventanamicro.com>
Date: Sat, 21 Feb 2026 09:35:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/50] target/riscv: Replace ldtul_p() -> ldn_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-28-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260219191955.83815-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf35.google.com
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



On 2/19/2026 4:19 PM, Philippe Mathieu-Daudé wrote:
> Prefer ldn_p(riscv_cpu_is_32bit) over target-specific ldtul_p().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/gdbstub.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1934f919c01..f89b20ea84a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -191,14 +191,15 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> +    const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
>   
>       if (n < CSR_TABLE_SIZE) {
> -        target_ulong val = ldtul_p(mem_buf);
> +        target_ulong val = ldn_p(mem_buf, regsz);
>           int result;
>   
>           result = riscv_csrrw_debug(env, n, NULL, val, -1);
>           if (result == RISCV_EXCP_NONE) {
> -            return sizeof(target_ulong);
> +            return regsz;
>           }
>       }
>       return 0;
> @@ -225,11 +226,12 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>   static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       if (n == 0) {
> -#ifndef CONFIG_USER_ONLY
>           RISCVCPU *cpu = RISCV_CPU(cs);
> +        const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
> +#ifndef CONFIG_USER_ONLY
>           CPURISCVState *env = &cpu->env;
>   
> -        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
> +        target_ulong new_priv = ldn_p(mem_buf, regsz) & 0x3;
>           bool new_virt = 0;
>   
>           if (new_priv == PRV_RESERVED) {
> @@ -237,7 +239,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>           }
>   
>           if (new_priv != PRV_M) {
> -            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
> +            new_virt = (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
>           }
>   
>           if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
> @@ -246,7 +248,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>   
>           riscv_cpu_set_mode(env, new_priv, new_virt);
>   #endif
> -        return sizeof(target_ulong);
> +        return regsz;
>       }
>       return 0;
>   }


