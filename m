Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7076C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 17:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txr4H-0002a4-Bb; Thu, 27 Mar 2025 13:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1txr41-0002Z5-Mj
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:30:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1txr3y-0004qT-E6
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:30:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so27135345ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743096640; x=1743701440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4K79JuADZVxew8NZh1Y0DBPTYMqkjfLhjKMzpJ5yDl8=;
 b=gWy/SpM/j9XbzPUSaCu8/R7M0WYU9IFGG8+ug/HxFUCHr/+yKxuDVHFMT/FMiZEgao
 qhDg52jGLNAnCElIQTWyYPJdORR/EcLdmzRuynJZMm7DMz0me3zhqqc4hJ1hfa2iPWWh
 db7/UfJkATQj20B/gRMsMjUIl3sBfqFwSWcC5RZqf0uy78PVpfoHb09U+B0B5bs6FCpJ
 yYXkq1jjUw3kMWesHOg8Lp9l3nkY/gZAQHjah4MfY85lJMyG9UYRSkRImW44+C51ThAu
 u7OgZ6v+H5Oawa2TV9e9rGC6jJTvpCqzcN+hVDjCWy4EAr31CHkTfehSIRlZ8XvmQcmv
 EyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743096640; x=1743701440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4K79JuADZVxew8NZh1Y0DBPTYMqkjfLhjKMzpJ5yDl8=;
 b=d9OEvbV80A3Fbrbi+OPYhdwaeHctikGqv3kj+q0AfvmqvEU3kg/QwyS/u/vH+m0uVQ
 4SrT9cQ67AjgeowiDYoPyJyuWqQDowN8SSHhdHol5k3QAst7qBG2T68Hfrb4JTybxLRr
 wAn4kvv2rkMJQoK69kai0HZ4+tyiNOG3ZavFF4LygKlYa3od2ifltgT/36QFUz1INeNl
 ZmNHRdgA3WreKRL9KvfmmQHDEiXeNwmnMPltUsGbFpSNgOt1fvvvmuJ5RYRWx9K5Icc3
 MxUVVQjJUu1pydnuEOZ9LQWgeTLkskx4QMhrRRCSzaxxmDDcEfXrBPI/aTa1t9//ZZ16
 MCCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsgV/mQIFTCGXCSXgdPT5XF7l/ntfO149DNcniFrDNLFUDkvJpLi+xD9Tm9eyfO9m+nvdElZs3gp7l@nongnu.org
X-Gm-Message-State: AOJu0YxtxZNkda/6XQNyujSeaHGjW9AXCUMEWAybewVrZAY1DNdK7QWr
 GqUrNqSvop7i+Jil5H0mC+RutA3ua0aGsyGi/+m/N8khfoAu17BnEzEt06QehIE=
X-Gm-Gg: ASbGncug8RTV4vy8iV/mYhL+hbXGp86j/mSAUGU2shRw+uwUAwaDTuGtzIgjNiuHPvl
 ss6+P0fBwcpv/w9CFScQVj6iA+I+2AH1BDZhX11UE0MH/WgUwMUb5aetZ6IMDSFI/A8dWYSKuN4
 PUTVffSRz+YwEUR6wA4K1/gE1fjCvCPiUzTCgKD7czAOnUGWJ7ba/T+CzJU6oS56Fswf6Nm+X6c
 JQ9DoyKLQv+oAxjHuP6P6osZMAr5QKE8PDzDJBMIRpvV2rduRiS6kVxzT5qwsVLzUr3tsSv1n6f
 yPi/J/EStiUs9Pkg+XPkF5+R5Aa5Pury4eiE0O9XjWCwhzkvCRjCGGDnBz2hJSTgI0cDJLaUICT
 vAqm4Z+aHQiFzREfTjvTT
X-Google-Smtp-Source: AGHT+IGDceHEvbz/CWhvfA6ITVTCoB7wLMNq8oMDJQ1J2t6lLQZTKm0CnL8DAwgftRQD4YC31SIDSg==
X-Received: by 2002:a05:6a20:c707:b0:1f3:194b:30ae with SMTP id
 adf61e73a8af0-1fea2d2ca7emr8466536637.1.1743096640042; 
 Thu, 27 Mar 2025 10:30:40 -0700 (PDT)
Received: from [192.168.68.110] (201-69-66-189.dial-up.telesp.net.br.
 [201.69.66.189]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b69f6ccsm155346a12.20.2025.03.27.10.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 10:30:39 -0700 (PDT)
Message-ID: <f26e12e9-1510-4be3-bd91-13b860e78418@ventanamicro.com>
Date: Thu, 27 Mar 2025 14:30:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-2-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250313193011.720075-2-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 3/13/25 4:30 PM, Loïc Lefort wrote:
> When Smepmp is supported, mseccfg.RLB allows bypassing locks when writing CSRs
> but should not affect interpretation of actual PMP rules.
> 
> This is not the case with the current implementation where pmp_hart_has_privs
> calls pmp_is_locked which implements mseccfg.RLB bypass.
> 
> This commit implements the correct behavior by removing mseccfg.RLB bypass from
> pmp_is_locked.
> 
> RLB bypass when writing CSRs is implemented by adding a new pmp_is_readonly
> function that calls pmp_is_locked and check mseccfg.RLB. pmp_write_cfg and
> pmpaddr_csr_write are changed to use this new function.
> 
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmp.c | 43 +++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b0841d44f4..e1e5ca589e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
>    */
>   static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>   {
> -    /* mseccfg.RLB is set */
> -    if (MSECCFG_RLB_ISSET(env)) {
> -        return 0;
> -    }
> -
>       if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
>           return 1;
>       }
> @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>       return 0;
>   }
>   
> +/*
> + * Check whether a PMP is locked for writing or not.
> + * (i.e. has LOCK flag and mseccfg.RLB is unset)
> + */
> +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
> +{
> +    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
> +}
> +
>   /*
>    * Count the number of active rules.
>    */
> @@ -90,39 +94,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> -        bool locked = true;
> +        bool readonly = true;
>   
>           if (riscv_cpu_cfg(env)->ext_smepmp) {
>               /* mseccfg.RLB is set */
>               if (MSECCFG_RLB_ISSET(env)) {
> -                locked = false;
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> +            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is set */
>               if (MSECCFG_MML_ISSET(env)) {
>                   /* not adding execute bit */
>                   if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>                   /* shared region and not adding X bit */
>                   if ((val & PMP_LOCK) != PMP_LOCK &&
>                       (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>               }
>           } else {
> -            if (!pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> -            }
> +            readonly = pmp_is_readonly(env, pmp_index);
>           }
>   
> -        if (locked) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
> +        if (readonly) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - read only\n");
>           } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
>               /* If !mseccfg.MML then ignore writes with encoding RW=01 */
>               if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> @@ -524,14 +527,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
>               is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
>   
> -            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
> +            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
> -                              "ignoring pmpaddr write - pmpcfg + 1 locked\n");
> +                              "ignoring pmpaddr write - pmpcfg+1 read only\n");
>                   return;
>               }
>           }
>   
> -        if (!pmp_is_locked(env, addr_index)) {
> +        if (!pmp_is_readonly(env, addr_index)) {
>               if (env->pmp_state.pmp[addr_index].addr_reg != val) {
>                   env->pmp_state.pmp[addr_index].addr_reg = val;
>                   pmp_update_rule_addr(env, addr_index);
> @@ -542,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               }
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR,
> -                          "ignoring pmpaddr write - locked\n");
> +                          "ignoring pmpaddr write - read only\n");
>           }
>       } else {
>           qemu_log_mask(LOG_GUEST_ERROR,


