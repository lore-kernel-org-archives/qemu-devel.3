Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DDFC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgKvW-0007HJ-LW; Fri, 07 Feb 2025 04:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKvT-0007Dq-0b
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:45:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKvQ-0006Vw-I6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:45:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21634338cfdso45301725ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1738921527; x=1739526327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JAM3eL/WomDESnGsQK0BJe3nFp0migrvkKHJt3TK/u8=;
 b=j2rZ0H76EQ5CEZlZ2N89WyvyAbg4eYrd+Tl8BKLInq/Vngw287C39HYTr0GQLQFtXu
 zUVi0igIoKW0hpXGY5y/XmEDnKet02IKO+MCEy/E/nn5Mtfecg3cTPvUf13jPsPCTZ+K
 AT1kiRcs2dTp8lVKLJnQA8ctAP9fACoj+VCRdfd56ajl6+DknB29nfhykas7K0FbiwvZ
 P1xQkBlDyus6b1Fe275n2J6pyjlSPfbY7t9fJLKHMq9HyQPa0s8Nb4IY/Gq7bpe6m+S4
 YZH/ajNRZW77YFiwQ1vnvjdcmHqDRxpYup0aD6IjHSvq9WGtb66XvKOIGBNqcqa+bsLz
 wrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921527; x=1739526327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JAM3eL/WomDESnGsQK0BJe3nFp0migrvkKHJt3TK/u8=;
 b=czVWnSMkomFISKl2QuNRIvgULDB1ZFST4U+FsOwBWYbqOUxsMU8rBQauU5q+fq8fXt
 fGBsQEzmH5H8brgBUxr83bZ5h41C1O1YFw692662p75wPyqLSQ9mFpsBDNPKuk37LtfS
 dPLqmyyJnAD+Nze9zwP2+nSjFgqhoYTujEkW7J8iPeKodbvz731O81G8qerVkNBBQ8qJ
 eNGlC1lnB8uyAtZM2fnoustZJb+WxEJBG+H64imVCa/0fY/MHA735EA+vFLpac/vkYXU
 yEdv7qw+CuilNVSMa85XJQurBboGG1EBGkY5AhRJ3LpZVv0Q3XaC8YEUv/P6/nhGVI4Y
 oEFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDI1qf0nIP9GDNhecwa2hLcEk4FEqIj8xpG6nAjG0afZJI0tc1n+yio/jIhvmwsqRvwPIp52VtVW8+@nongnu.org
X-Gm-Message-State: AOJu0YyZdxQfux5Q1dUReuhmfYw6DKNi5MdaNAvARiuXVw29vm3EezBE
 KF13TX+VQ7y7chsagFoEZWbC3c/YjMJddD/6pvwlCof1t3Y6ySy/3kaX63Bdbpo=
X-Gm-Gg: ASbGncthGK2B18QKhhX+3+sxnXTFOR32kWfaTw5i6oy1JiFoppUXBFMeynd6u9dOHBI
 pFincTJz9k4VUcEtRSCRXw4j7StvtuFp8kQnmrPfSuASqz27d7yYg7vZM7DObUv/FOPNBsv3CGE
 rD/qsZd59GKV80df/ifF4eUsYlCJkRnKGqWuGtytsDINFI7QQTsVUhiHi8rxCCG+YEtCzb3V6Wv
 FMIjAFF64dKy1y4mWuOGSObd1LOuuqm0aN+u5yljD2nVWH2YP+paVAFgcSTlninI+CJScjuiSgi
 l3RVMNSuBgeSxA+EUDIVK610S3NjBb96I8LjazOx2CBTLNlaWhnaUPoa16B8V48z0dsK
X-Google-Smtp-Source: AGHT+IHzIZBGH+9zBTkP73+5nhvItKxusYGL2bXGYFJJgGG48nKVbhlxOKHP6ZzDhaMszcTHgml+2A==
X-Received: by 2002:a05:6a00:3e0b:b0:725:eb85:f7f7 with SMTP id
 d2e1a72fcca58-7305d4187c1mr4583988b3a.5.1738921526882; 
 Fri, 07 Feb 2025 01:45:26 -0800 (PST)
Received: from [100.64.0.1] (218-166-198-8.dynamic-ip.hinet.net.
 [218.166.198.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048e1e80fsm2584260b3a.157.2025.02.07.01.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:45:26 -0800 (PST)
Message-ID: <391b0fdb-b5f7-4151-ad84-0718a197dcee@sifive.com>
Date: Fri, 7 Feb 2025 17:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/riscv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
 <20250126072056.4004912-12-antonb@tenstorrent.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20250126072056.4004912-12-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Max Chou <max.chou@sifive.com>


On 2025/1/26 3:20 PM, Anton Blanchard wrote:
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 312d8b1b81..2741f8bd8e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2410,10 +2410,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
>   }
>   
>   /* OPFVF with WIDEN */
> -#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
> +#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
>   static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>   {                                                                \
> -    if (opfvf_widen_check(s, a)) {                               \
> +    if (CHECK(s, a)) {                                           \
>           uint32_t data = 0;                                       \
>           static gen_helper_opfvf *const fns[2] = {                \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
> @@ -2429,8 +2429,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>       return false;                                                \
>   }
>   
> -GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
>   
>   static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
>   {
> @@ -2512,7 +2512,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
>   
>   /* Vector Widening Floating-Point Multiply */
>   GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
> -GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
>   
>   /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
>   GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
> @@ -2537,10 +2537,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
>   GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
> -GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
> -GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
>   
>   /* Vector Floating-Point Square-Root Instruction */
>   


