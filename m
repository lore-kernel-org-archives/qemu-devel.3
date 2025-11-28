Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAD4CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxOp-0005fq-Hx; Fri, 28 Nov 2025 07:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOxOn-0005fT-Uw
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:16:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOxOm-0007Fy-C9
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:16:29 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso18287435ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764332186; x=1764936986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9tDSFsZqND37BFIxQSlZZTg8fMpJxxlaF2wzP0al1T8=;
 b=VhnaBSz8dcNzwOy/+qACQKvRDeLS3JIdE7B9w1yCBU/l6Ielo71IJ6am2VDXy0KZKO
 IeIcTdVduXO0aayR2tUrcswGi4FRrPyzR6Uql9xbAkLC4AKIzdIYrHUoKaF165g0+tej
 zro65YorP883o79O6jiZ4GI+3D+09O/ChxBtNuqTthVLINlMC8YkAL//jgpI4em2ArEj
 oVL/VzW+J2EMnW1Jv5X86nkl5ZjREteM0HzsWDTbMv9beZtDBJy/muCHEf98zUU7lxuc
 1Oq4REzocCwhjrZsvkigHMoFlWp8bH1woyjL7CbdJ/m0uDyqM0jwG2E0f5Glb76pTRJd
 e/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764332186; x=1764936986;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9tDSFsZqND37BFIxQSlZZTg8fMpJxxlaF2wzP0al1T8=;
 b=ANV2xZjxV+c0tEXIdUEfqYgpxP4zr6TDrmgojqRPC5uGGAWOpvD1pEARyzdsH1iOlo
 p+7d2Iq6PpSTw5PVReLE3EAee3cvyqelsmn02szJN902gE+sj700PQNlJtxczWuxvMs0
 21/pAEEOgR9p+6o2p7KQJJUhwP9GxyHrn2FFWNzVHzwUsNFOCPQ+8p1kMRRtep5MTlMW
 SaUjszDlBEbvW33ZFLMzfh+LRc7IRVrBhjw70HnVKAGvbIhSwmyxH/Jwp+EoOXpG+li7
 NLaVL4Fv8qd0Xc8BS2ZWKSKrAdUgAfIXTZKQ5623vmxumZ4lvWWud6X749rxOdHkQ+9q
 Kmtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+DqIlUqdlgvfy12mcAa/yBMyp1FTYjM+lngt9G/sx6eNxijVGqIx/3xYTH6QXL9cSHtgfMIecIELT@nongnu.org
X-Gm-Message-State: AOJu0Yyop5ORoRElDdgv1jzE1dA86VdIJt3E1pC0q+xjwmm1QIxOwuxB
 FdL4OZZLihobzfBOP4oQeh1pJo9mpvRo6S+TQ9acRCObsoUYhshtwq29Qd91wkoIOwg=
X-Gm-Gg: ASbGncs8NqktOQObB8CG3KiiNqdXBhjy2OmdB2+3CYUR9DhnXTUXCh0WLsDT996FkW7
 crW1DQEcIVF4motMffEHWXy1a5g740YbkJUwiMGTsjweVDtssO/APjHDjRgG53MO2UOcAz6wTVh
 Ex1FY26o8A7PNuO+1ezLTHVjXerHXz/ve+9mPNcOINqAwFThjeCPZaInSxHHGok5k66375W0dAK
 t0zafrwQVHfSPwz+cusxqUqbx4oln2/xmfqaFOzyECGkgt+yoRxWCt3L3+f9SDKDbqDtqxcgvsJ
 bTYfUFMOabQyc+PYWXUsBGsWasD/RJTsoyI4At3ZMsTy7M0CFVqa97LQx/yTcVZmMnXqZM2qTFg
 ZC1zDpGECw6zYnyQIBNW39UGNLRDeRNdVKCM6Ll/zzRu2pqkigamXAOZ3hRMr37YLVPeX3e2Zzt
 +pd10NLvJxLdRtZAY45df7G5xIWQ==
X-Google-Smtp-Source: AGHT+IGwW42KRmZJP6Dp5/9tqXjTbPNlq3GeaQ8esfwD/KCzC0CHE+HM15+WOXuFl9tY5s0ErpEsFQ==
X-Received: by 2002:a17:902:d4ca:b0:294:f6e2:cea1 with SMTP id
 d9443c01a7336-29b6c571f11mr311405135ad.38.1764332186197; 
 Fri, 28 Nov 2025 04:16:26 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-be508b06867sm4515045a12.23.2025.11.28.04.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:16:25 -0800 (PST)
Message-ID: <02259145-b8b7-4c94-a7ef-e1084a90e541@ventanamicro.com>
Date: Fri, 28 Nov 2025 09:16:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: Update MISA.C for Zc* extensions
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
References: <20251128022302.970294-1-frank.chang@sifive.com>
 <20251128022302.970294-2-frank.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251128022302.970294-2-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 11/27/25 11:23 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> MISA.C is set if the following extensions are selected:
>    * Zca and not F.
>    * Zca, Zcf and F (but not D) is specified (RV32 only).
>    * Zca, Zcf and Zcd if D is specified (RV32 only).
>    * Zca, Zcd if D is specified (RV64 only).
> 
> Therefore, we need to set MISA.C according to the rules for Zc*
> extensions.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 440626ddfad..752eee32289 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1150,6 +1150,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
>       }
>   }
>   
> +/*
> + * MISA.C is set if the following extensions are selected:
> + *   - Zca and not F.
> + *   - Zca, Zcf and F (but not D) is specified on RV32.
> + *   - Zca, Zcf and Zcd if D is specified on RV32.
> + *   - Zca, Zcd if D is specified on RV64.
> + */
> +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV32 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> +        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
> +                                   riscv_has_ext(env, RVF))) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV64 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +}
> +
>   void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>   {
>       CPURISCVState *env = &cpu->env;
> @@ -1157,6 +1188,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>   
>       riscv_cpu_init_implied_exts_rules();
>       riscv_cpu_enable_implied_rules(cpu);
> +    riscv_cpu_update_misa_c(cpu);
>   
>       riscv_cpu_validate_misa_priv(env, &local_err);
>       if (local_err != NULL) {


