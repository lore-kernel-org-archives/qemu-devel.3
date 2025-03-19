Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50841C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tut1M-0001E0-FP; Wed, 19 Mar 2025 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tut1L-0001Da-5b
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:59:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tut1F-0002vH-Il
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:59:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225d66a4839so9468975ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1742389175; x=1742993975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYDj1e+roerEsD3NsW/nCRUuEwo/42mdw0jES1Ni/X0=;
 b=mHuOO0c+mwCU7/ujwI26DcTOvvcxoT1dljoDq26g25VJfrUkNK/sxLWVF3hveWOQBp
 6ijnMpWExIK8eb4KQftgeoandwjYUhy0BK3GLf4CfmhAEZohGN6GK5HOuEpR+ffMsqm4
 peWsVsyBDSHt6/Og0xCOBsYyq5b6+CpHTT5N6NHixlkWTc+EXQ5Y/C8LRh6WA6TR413Z
 +saFgzbLAZZPZ8Nb8qzo7Ub/Irexzoa+NfCNZTWusUTUHlIhTY2mZsLFWpzyqg2UG8jp
 sle5HvXgdt8sk2MAF9rWIqbYYKlLo3z83RvK6cLrUZggiVLptqVO3akotwDTNjlCRV41
 ZnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742389175; x=1742993975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYDj1e+roerEsD3NsW/nCRUuEwo/42mdw0jES1Ni/X0=;
 b=mV1dztua3OBHkUPKF1hVyrrXHirfoERQW5NwtK4Wau1x+F+BD9DjZDLhU1l5l+PhbK
 rpKSadFGMLDDU3aVu5bFBB0RaxKtFanbLDlae8jr5AKMH0L0Iyv8MelZ9CoXN/69gKKs
 NzPu5Tlai/AMfTxwTwGFUFWkhxz6dZu74obGT/J0aLfG+SAcauSqLAT89nghydsTu/5H
 /cFC4M5qCZwNxka4x4PpItU7CRSuGybwEZh4b7K7cARlndZX0QmvTgEApXOMteNozyzD
 yssZZB9lBhgbuNgq5clM7xlHCcIURsq8UiF3elwNggpcn9DZs3wTPFRJwRVSfA3SyWra
 Y6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwx3VHG1zD8NygVbE07+yv7ZiU9hyhm67Jk7ruZtIpBfvy4Jwd7y1laqgadDRCd1MdM+3zr0kpqEht@nongnu.org
X-Gm-Message-State: AOJu0Yw01gCNyVqA5Xvapvq2V9ccfBpHIsg6RCuJKPl0nQ312shqD3hF
 9CltenJu1gdOrDkNmLBnOK90GxE2lcIg7PLwQxez5gy8VqwzXQFoIyFe7vUVU1I=
X-Gm-Gg: ASbGncuJgF5wmIPxapMq64gxkZi8tUgQOilahG5fneosqAV4HS7+CpqyXP5pJ5Pbi/V
 o5jRupacXKhjeqrWagHx8BWN3twlOIz8hMks9zmnAXr1ypJZvf9R0KWWSBXSef9Az2srqEV7wS6
 bVGwom27vV02ZP0z7D0pZDQOJYA0HbbBACOhk3xMEde85IlgGvDuBoVCw9y09GOPRelKSwn0ngu
 hz2qBHleIJocElN8NAbiGeRY5HLP213ykb/mGV8lZjOdHd73Idf3YC1pwBh46YT8NRF03OMOuUb
 hbvwuHZCGCfSuj28t7XBqyoBukhPvy5CB7R4VPt3xRdWJJwruYX4GKK7Hc8=
X-Google-Smtp-Source: AGHT+IEv8nqjwVqlO2ghfTxrVkbrp/nWFDDlDc7fwKRTTKpbNNgHAuzpUyNKjlawsHcBtJu9Avrtsg==
X-Received: by 2002:a05:6a00:3cc3:b0:736:491b:5370 with SMTP id
 d2e1a72fcca58-7376d5f626emr4073755b3a.10.1742389175492; 
 Wed, 19 Mar 2025 05:59:35 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b3798sm11845102b3a.174.2025.03.19.05.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 05:59:35 -0700 (PDT)
Message-ID: <19189ed9-0459-4c7d-902a-fcacb2595f07@ventanamicro.com>
Date: Wed, 19 Mar 2025 09:59:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Restrict midelegh access to S-mode harts
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20250318070136.38898-1-jay.chang@sifive.com>
 <20250318070136.38898-2-jay.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250318070136.38898-2-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 3/18/25 4:01 AM, Jay Chang wrote:
> RISC-V AIA Spec states:
> "For a machine-level environment, extension Smaia encompasses all added
> CSRs and all modifications to interrupt response behavior that the AIA
> specifies for a hart, over all privilege levels. For a supervisor-level
> environment, extension Ssaia is essentially the same as Smaia except
> excluding the machine-level CSRs and behavior not directly visible to
> supervisor level."
> 
> Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
> aia_smode32 predicate.
> 
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>   target/riscv/csr.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 975d6e307f..c3dd8e6cda 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
>   static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>   {
>       int ret;
> +    int csr_priv;
>   
> -    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }

I believe this won't compile:

../target/riscv/csr.c: In function ‘aia_smode32’:
../target/riscv/csr.c:377:8: error: ‘csr_priv’ is used uninitialized [-Werror=uninitialized]
   377 |     if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
       |        ^
../target/riscv/csr.c:375:9: note: ‘csr_priv’ was declared here
   375 |     int csr_priv;
       |         ^~~~~~~~
cc1: all warnings being treated as errors
[2171/2988] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_translate.c.o
ninja: build stopped: subcommand failed.


Perhaps the idea here is doing a "int csr_priv = env->priv;", but in that case you
might as well just use env->priv directly. Thanks,


Daniel

>   
> @@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
>   
>       /* Machine-Level High-Half CSRs (AIA) */
> -    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
> +    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
>       [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
>       [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
>       [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },


