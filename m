Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEC4C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshs1-0008NY-1y; Thu, 13 Mar 2025 08:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshru-0008GM-6E
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:41:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshrn-0003TR-6C
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:40:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22409077c06so22823075ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741869649; x=1742474449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J19oiaHRBrxvp66mVfLeas4kFW3rCdjeeeMEfGJnHiM=;
 b=X4w7Twg/KKwGuLl4ArbmPaTfD9QwtJBsijM+k/hQ9BmF8rZn9eGlDT2u4r5jYZed/W
 7BbcYUgmUczPc791TS6jPj4ffNxoauB2O8okShFjXcqkvx5l8o/ltCYMdq3aq2p+m4P6
 VWBCfMJspt96ciSTWm3GuMB47XbSsKZ8Dm5tkNOIYr/bI+OL9n1Inei6bIN9WvhSRhQl
 oegUciQbAFqjsFR/JK8dX2VVTyZTl7xGrJ43HHyDUwDkxlSsRvrBUXPGBWskjWkWPQ5r
 CGp5iWwm9jTE2KELnWXcj51EoZVVU3UxMGIPqIyetMM5mvwQtT5rjfcr6TvM2SdqomKp
 Rl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869649; x=1742474449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J19oiaHRBrxvp66mVfLeas4kFW3rCdjeeeMEfGJnHiM=;
 b=oSs+0If/DKpvlgNZwXENmBWpxnv1ZA2/zlQyvYaW3xUapKhlJzn/gMnyV2/0DHei51
 pXBaQ39NtavVsUv58TPGL1Kq72BceSdu2NrF8MGnQGC6Ja2lcn6+xgUALHl438j8hu2d
 2ulj+MQwwzOzZIOAI6ENghfapl8DFBKKPl5Xa7rWL9Gd2CKajN50PZGFxioGumybpPmq
 HSAkoA8GsH/AUmLn6LL0Nst5OnZVOMI2C3NOkXEZaZvy6kRic1f7yRiZBCGF2/QScRjb
 HTokhBK9bmo0956DGWg44mGxWMU9/Ql1I6KjAzv/Kamc7kP9pOFyxGQWOBExpMb14Dj0
 LrFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2ztnHApHyzDodtgZkH5WoBnyzpNf18HaG5VflverDVqgx6i+dDlFULvtQnGspFNYzykE9tv/htBx@nongnu.org
X-Gm-Message-State: AOJu0YyYdW2k8+wDtYABHDsAMcdTkRrM56ri3PXtDQ3ibN23uY+j3Y0E
 UzaTnDo88L8rc6/mGS9RuVWIScJqQjfG45dcseWTVXR3MtYMLsZG+S3G0XrCpZk=
X-Gm-Gg: ASbGncvmqv6yUeIbDmcAlVbhsyBxFcnO5K8d+Yv8Bk6H0KRYkgoAgrkivcyKI0BtfhD
 qnsLfeEU2r1GahKq9jwFVHuyi4kfHptI8nwbaJsY3ebvRq+1WCQpv11ib5yOVpBnZdiXRUfwMeQ
 YEF97la+044KIc5TnTbcVWuO7SRkJ1Gsn+CJhlk673nI70q/2Li3Z08g7a/qdxdjbFTfNJwaPOD
 hHXEYRFmkJ/NhCFENGvu0D6bPeNFSSZn9SexEW/bELay64kMmXcl1nEvVG46biFlLMb+qNL7l8Q
 2ogcMq4zkwcD3jvexYAorBlltFkBZp5xclFeEzzvovXWqCcEx98NeFUPCgs=
X-Google-Smtp-Source: AGHT+IF3ffiiVNOpG7IY+bsmK2wH4MUOzNVcFite/qI8jWvmGFlHkkgAdnt+u5RP+Carkmhrzuv+GQ==
X-Received: by 2002:a17:903:1788:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-22428a8ca41mr405050855ad.24.1741869649427; 
 Thu, 13 Mar 2025 05:40:49 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c6bsm12057265ad.150.2025.03.13.05.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 05:40:48 -0700 (PDT)
Message-ID: <194d1c63-e2af-45fd-94fa-0336b0b53faa@ventanamicro.com>
Date: Thu, 13 Mar 2025 09:40:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/riscv: pmp: fix checks on writes to pmpcfg in
 Smepmp MML mode
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-4-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225160052.39564-4-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 2/25/25 1:00 PM, Loïc Lefort wrote:
> With Machine Mode Lockdown (mseccfg.MML) set and RLB not set, checks on pmpcfg
> writes would match the wrong cases of Smepmp truth table.
> 
> The existing code allows writes for the following cases:
> - L=1, X=0: cases 8, 10, 12, 14
> - L=0, RWX!=WX: cases 0-2, 4-6
> This leaves cases 3, 7, 9, 11, 13, 15 for which writes are ignored.
> 
>  From the Smepmp specification: "Adding a rule with executable privileges that
> either is M-mode-only or a locked Shared-Region is not possible (...)" This
> description matches cases 9-11, 13 of the truth table.
> 
> This commit implements an explicit check for these cases by using
> pmp_get_epmp_operation to convert between PMP configuration and Smepmp truth
> table cases.
> 
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmp.c | 81 ++++++++++++++++++++++++----------------------
>   1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b7f1430ff8..e0ea436f8e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -75,6 +75,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
>       return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
>   }
>   
> +/*
> + * Check whether `val` is an invalid Smepmp config value
> + */
> +static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
> +{
> +    /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
> +    if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Adding a rule with executable privileges that either is M-mode-only
> +     * or a locked Shared-Region is not possible
> +     */
> +    switch (pmp_get_smepmp_operation(val)) {
> +    case 0:
> +    case 1:
> +    case 2:
> +    case 3:
> +    case 4:
> +    case 5:
> +    case 6:
> +    case 7:
> +    case 8:
> +    case 12:
> +    case 14:
> +    case 15:
> +        return 0;
> +    case 9:
> +    case 10:
> +    case 11:
> +    case 13:
> +        return 1;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   /*
>    * Count the number of active rules.
>    */
> @@ -103,46 +141,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> -        bool readonly = true;
> -
> -        if (riscv_cpu_cfg(env)->ext_smepmp) {
> -            /* mseccfg.RLB is set */
> -            if (MSECCFG_RLB_ISSET(env)) {
> -                readonly = false;
> -            }
> -
> -            /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
> -                readonly = false;
> -            }
> -
> -            /* mseccfg.MML is set */
> -            if (MSECCFG_MML_ISSET(env)) {
> -                /* not adding execute bit */
> -                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    readonly = false;
> -                }
> -                /* shared region and not adding X bit */
> -                if ((val & PMP_LOCK) != PMP_LOCK &&
> -                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> -                    readonly = false;
> -                }
> -            }
> -        } else {
> -            if (!pmp_is_readonly(env, pmp_index)) {
> -                readonly = false;
> -            }
> -        }
> -
> -        if (readonly) {
> +        if (pmp_is_readonly(env, pmp_index)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpcfg write - read only\n");
> -        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
> -            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
> -            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> -                !MSECCFG_MML_ISSET(env)) {
> -                return false;
> -            }
> +        } else if (pmp_is_invalid_smepmp_cfg(env, val)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - invalid\n");
> +        } else {
>               env->pmp_state.pmp[pmp_index].cfg_reg = val;
>               pmp_update_rule_addr(env, pmp_index);
>               return true;


