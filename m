Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50960ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snb5u-0006T7-EH; Mon, 09 Sep 2024 05:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snb5s-0006SX-8i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:54:00 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snb5q-00076q-F3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:54:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so4144951a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725875635; x=1726480435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XiIx2qngV93HMYOCPX+0VUKpSYoE/saaJ3eEBvqehn0=;
 b=cVnBgld1ultduw14+xuqpzXh+iVihW7zWtrtXU77eS30Fx4OVRkQQlO+SKhN08C9oC
 3s7bX6NuK+YrVExdpJ/RRzJH2IN+fF3I+U8WS+oVtlRrBviJyXd9q+DOVlcqAEgCDof+
 WZAVoHnu3s48KPCBur4VExY1irOs5COsH61EeFGx/EWE71jMR39xbL/gUEbiqv8RBYg/
 3CRr28o0AEmxw7X3J44jHNiMgAPUWj0cwc7Sw7kBbvM6mH9Rzg5mzR+LMw+gEBdQcRiN
 Ca9Y6kWZcWwIvESOZccdFw8LbxmOjZTMNovZrO+EHMMGebSeZ9IJMFQh69gOIlKnOBnZ
 CxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725875635; x=1726480435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XiIx2qngV93HMYOCPX+0VUKpSYoE/saaJ3eEBvqehn0=;
 b=krfcqbuvvJbuw34OLOXQxDLzEivXbwlUhs+po2LI3qGo2iELrJCEXAwVi7IZvtqY9I
 zFCpDChlbDvsOwTzd/S9zF+mOvTck+WTh6k8gffZYBG+2ruKeYlSM3XoAnUS1G+cAbhp
 vHKHsMNV781vGQZ7olP7MeNQ3Sn4UvVHu7D2/Z6/zaYo9S+IP92d5Ht2P8Xze3gViEtE
 c7fQrf7lOaXbLK+uzc8BRYZCSz312AQquH+UGEI5m/ZwF7M2HqdXmtVT/HrutJFVknQH
 5wg0Bv6Fg1jNef2uU0SkBLEGQqwNVoqXi2cdd+hUCMXFM1tc6mXXGN4Sce63OQKSTAD6
 LLlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHQzMTC+9CwlD3G1QcibLbpOWIswhZeuXO+/+Ukm8/tg7bvOdvzZC45+mMgLKL1g6yb1kZ/+t9ubV@nongnu.org
X-Gm-Message-State: AOJu0YxI0OEZ4AWoizYk9siYXX9SSM4mJmIsubE2a0Zj3uNC/v4uvlBd
 XZXezaFEwHyRAnHAEGzOzw1cnYNJhk7xFyQ+RXbltRTZaL+ZFu41qKJsmurgKJ0=
X-Google-Smtp-Source: AGHT+IEIuBwEOzKYyc1HuQleFwcBK+g3t45PzRASeFyWpDbMF01z0BMdNdxfn30ace84pKuYfmJmLg==
X-Received: by 2002:a17:907:803:b0:a86:a013:2161 with SMTP id
 a640c23a62f3a-a8a88667efdmr807588066b.30.1725875635216; 
 Mon, 09 Sep 2024 02:53:55 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce96a7sm316515266b.158.2024.09.09.02.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 02:53:54 -0700 (PDT)
Message-ID: <9f9b2305-da3a-4215-bf97-462bd1ade4c8@linaro.org>
Date: Mon, 9 Sep 2024 11:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/i386: Implement vector TST{EQ,NE} for avx512
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240908185110.485573-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908185110.485573-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 8/9/24 20:51, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Based-on: <20240908022632.459477-1-richard.henderson@linaro.org>
> ("tcg: Improve support for cmpsel_vec")
> 
> ---
>   tcg/i386/tcg-target.h     |  2 +-
>   tcg/i386/tcg-target.c.inc | 31 ++++++++++++++++++++++++++++---
>   2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 342be30c4c..c68ac023d8 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -224,7 +224,7 @@ typedef enum {
>   #define TCG_TARGET_HAS_minmax_vec       1
>   #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
>   #define TCG_TARGET_HAS_cmpsel_vec       1
> -#define TCG_TARGET_HAS_tst_vec          0
> +#define TCG_TARGET_HAS_tst_vec          have_avx512bw
>   
>   #define TCG_TARGET_deposit_i32_valid(ofs, len) \
>       (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 8c363b7bfc..afeaab313a 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -462,6 +462,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
>   #define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
>   #define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_VEXW)
>   #define OPC_VPTERNLOGQ  (0x25 | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
> +#define OPC_VPTESTMB    (0x26 | P_EXT38 | P_DATA16 | P_EVEX)
> +#define OPC_VPTESTMW    (0x26 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
> +#define OPC_VPTESTMD    (0x27 | P_EXT38 | P_DATA16 | P_EVEX)
> +#define OPC_VPTESTMQ    (0x27 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
> +#define OPC_VPTESTNMB   (0x26 | P_EXT38 | P_SIMDF3 | P_EVEX)
> +#define OPC_VPTESTNMW   (0x26 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
> +#define OPC_VPTESTNMD   (0x27 | P_EXT38 | P_SIMDF3 | P_EVEX)
> +#define OPC_VPTESTNMQ   (0x27 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
>   #define OPC_VZEROUPPER  (0x77 | P_EXT)
>   #define OPC_XCHG_ax_r32	(0x90)
>   #define OPC_XCHG_EvGv   (0x87)
> @@ -3145,6 +3153,13 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
>           { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
>           { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
>       };
> +    static const int testm_insn[4] = {
> +        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
> +    };
> +    static const int testnm_insn[4] = {
> +        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ

OPC_VPTESTNMB, OPC_VPTESTNMW, OPC_VPTESTNMD, OPC_VPTESTNMQ ;)

Otherwise LGTM.

> +    };
> +
>       static const int cond_ext[16] = {
>           [TCG_COND_EQ] = 0,
>           [TCG_COND_NE] = 4,
> @@ -3160,9 +3175,19 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
>           [TCG_COND_ALWAYS] = 7,
>       };
>   
> -    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
> -                           /* k1 */ 1, v1, v2, type);
> -    tcg_out8(s, cond_ext[cond]);
> +    switch (cond) {
> +    case TCG_COND_TSTNE:
> +        tcg_out_vex_modrm_type(s, testm_insn[vece], /* k1 */ 1, v1, v2, type);
> +        break;
> +    case TCG_COND_TSTEQ:
> +        tcg_out_vex_modrm_type(s, testnm_insn[vece], /* k1 */ 1, v1, v2, type);
> +        break;
> +    default:
> +        tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
> +                               /* k1 */ 1, v1, v2, type);
> +        tcg_out8(s, cond_ext[cond]);
> +        break;
> +    }
>   }
>   
>   static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,


