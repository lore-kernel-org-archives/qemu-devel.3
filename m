Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE8AEF8FEE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnfv-0002TR-Cs; Wed, 04 Mar 2026 09:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnfg-0002RU-CJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:57:57 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnfe-00083T-CK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:57:56 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2be1b5fe11cso3091786eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 06:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636269; x=1773241069; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YCnDpxticsBLd7T/cVukvDnzRsXq4UqrVFdlPu+OeGM=;
 b=fiiNQQA2Arh/Oj9J/irG4in+ar1q4SCHaPyT1UmBT01QsMiCNRHA2VD2+bdLCsgies
 hC/07LWf0eKOWJbMz73oIMTl91j0YuKYtbQY8HxFhvw8aZ2sV2uOtFApUK99eecbidme
 axgM+VOae/xkgjC/Jgq6bgoMntor30Wc3Hzy31YjCfQOSq7g76EAHsC8ekd0BUqMBXJc
 BxKrm6eCTAi8z3UqohQqoisnCgDT7huuLzxUojGPjZvjgrWp0LUjU/fvEiwvN2QGjLIH
 dxewz/4rbQQcX35Ga0nx4+pOmEgk7tN8WG163Lx0EZvE1c4maHEGF7O5k3+3lL+K9rKm
 qxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636269; x=1773241069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCnDpxticsBLd7T/cVukvDnzRsXq4UqrVFdlPu+OeGM=;
 b=fZMhmGyAGYWSrFfiGdMVp7X/b6+UIpP9KOHxMvf/mD7pxyqEgupR5YxPOYc2sqWNj0
 M5+WggY/qTrdhkitCpCfNbSglNf8yrv0qxVeD57zGG2+XsaVdAbhBHgWfxBLca/5rv2z
 AYvTmGFG6vzjNhWWf7Mp47iuVtaecQvKtacjQRBFdFQZAnxBfXVY/zgARGxGNpIVY1Xq
 X3GFcV7STCmYamioH4oA1xQNUIj7/rBC6nCUZ5y43nhNxLhfOIGfPrXQrH3repcZSRyq
 Jf9C1aLTIJpCqlh4d3XukZ96yfLvvmCELNEuXODtv+47GtImijOy1ATuUIiD5V66knm5
 p4og==
X-Gm-Message-State: AOJu0YyCuBkCy7cGJEcVj471iJbq3FM1NlRr60S8t4jEEsf72/jflQM4
 iWBcxBeolHAs3wGTWouKPrIvFxBwR7Ce5nS7gfr6IN4JtPPjDHNya+v1LMFb7EHp
X-Gm-Gg: ATEYQzwTYBjQtYebBO1lv18T9McgUltFe9qUDor63ZlCcmq1jd2U1NTMVsoqKDICBJP
 byK7HcpT8no3MjfWV4PtKZ9QFL78BG7hCvtd+b2ocEhu3mQeMDoXIhmEBLVK3mT2o2eAYAdtAtx
 utChqLOUhuI6Ct0hNZP98OnAqFQrl+G7ONDectjH4cUKNzz89DmaysADCR2PxOXC8jjDPAJyVuZ
 SSL2vhiBtAt6grH32OBDgUZiW/Bx2iIHGS2tl+Xyq8CFPfEMF51m2y2iVcYU4I7EfEQgnJhKkak
 S6LAarEJv9V9LFdrUN/F9NmF8kF+lAejWO+aNYtPcyj/AOZQvV+jhCnshPR5zaUI/et6CagZbju
 rVUnxIb5vc3jZMZ9uNUW31akclBrNtZgULuxxHc9CP3T9lhl7Hjivdh1J4suiHyD5hQ66pe6SbI
 6GM0GbngICI2glXuQwImGD2fyd9GpanM35Q+COvJv7GOvhhLN77QTnYx7L0pwWc90sgbHH+7Wfp
 q2i7kiWlZq9ZEfjCZjW64LDznj+SjY=
X-Received: by 2002:a05:7301:1287:b0:2ba:7863:f0a8 with SMTP id
 5a478bee46e88-2be311df87fmr952715eec.36.1772636268777; 
 Wed, 04 Mar 2026 06:57:48 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1a45a58sm14642229eec.0.2026.03.04.06.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:57:48 -0800 (PST)
Date: Wed, 4 Mar 2026 22:57:23 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH v4 2/9] target/riscv: Add the Zvfbfa extension implied rule
Message-ID: <aahH8AJMazH4q6rM@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-3-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-3-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:25:06PM +0800, Max Chou wrote:
> According to the Zvfbfa isa spec:
> The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
> 
typo in commit subject -- "properity" should be
"property".

Thanks
Chao
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2ddc26c837..376517755e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
>      &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
>      &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> -- 
> 2.52.0
> 

