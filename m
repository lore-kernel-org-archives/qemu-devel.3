Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D081E83043
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6ga-0000Ar-MV; Mon, 02 Feb 2026 22:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6gY-0000AX-UI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:02:38 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6gX-00032p-BE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:02:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso4110461b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770087755; x=1770692555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhhvTJcLSZjg5NWAm4+sf6CdvE3XvDrZ4hzeHUQAfj0=;
 b=Cus4ucBXHvXnzNf1DZxfrkhcIEoryJxt6vmiY3iZeNUtNwjxAUPmCmog7MB7+rmJUa
 vmjz17qdT7CI3sDZztYG9ByrMcgKppDfm6U9/BS01kPPsUIXDeBTQxrF/9IPh4p/LbCT
 //S5HYEJjtYxL8wNhqVNU671AGtI270zzvDr6n9l4/cAFKsRpzu7wkvqEzJlIUUrDqf0
 6JPOAUbWNz6juLlcNLIZR1siEfKXHiZpvdMqlHAlAf967RKwwv4Y+yhwIoIUIJJRrXWv
 8+HwvMdY91eWQx/IV4NDzEPHa1zr4qyzBEl2EIUQ+iyN4o0WlF2RrzImSxn9YnbS8hh4
 oGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770087755; x=1770692555;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhhvTJcLSZjg5NWAm4+sf6CdvE3XvDrZ4hzeHUQAfj0=;
 b=A4Vuy9BuXu0emprgwwlmntOxY1Nt7L2GY5hndVRO+wgMgwECXn5Gq9rEh7/30WABg0
 74s3ftlj6wq56wrg9Xb1RRvatyOhOz2DAnlJ+sGbXyUAHPecGvrF1uD+kKQepr2ot23p
 yX1/6YgJ5xfYnK+LGjJrjaXPOlu45YD6gOi7yliEAi6TgLUuxKmD9FlYFzjiBGvOufCG
 bMAVWJ+kQp+2wXZs3VoHOFqBzNiVaKBYpc40swXLF57kpHVGyhbZCk8kSTGUimAU5WSF
 iGAxxECkeyAXcPwGX8XG6dFC2/bPJ+Pr/vcHbS1W9Rpu2ACcVR/nbYFL+9IuHL9X5ws5
 QQcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMjurRlstVaVfdTF+jiQFmR7/olmSyp70oKyQUUTVvp2EyMQJ1rlwCVdqGGyPcovA/wrzeVGeZ46Ax@nongnu.org
X-Gm-Message-State: AOJu0Yx6EJ5TMiXmxrPJxl10pjpo5pnP99ESFRKsXU1tYNqWEN9S5K8p
 7ioYXtIiyIM03Dw10HM1TuPKf1OJMO/MCh6ZblAOBWgjmkiyL1Z0B0A9fktDJddoXv4=
X-Gm-Gg: AZuq6aL+WwoKbeIMRSNTXdhzypKf6NNtCPzYrZx+tw/lCeHBqGjpIUn4MCBkn1/JsoW
 hIuvnAG8+ils7uxaa3E5pFbs2KWMbPykAUX5PJrTCzDgiIe56GipfEQqGRxjYEo68Krp7R9dilN
 rR573TDKG7Qqpa4RXql0xKJzPH1aVdtoiSU6PWHwlJS2fMxeL6ul9zJkBoxH9obnOhiuKHHo1VN
 EWYrD5HbS705VHLW+XtjJ8SE+cxtV9o3q7OF4jqIjxBKNZmNHlhlOGSPoUIZO3vGEMIPkVzle3t
 zDrigANx6wWnz2by/OzOKaZme9UNbGRsDnzIcNDhRtDvam63vKCSYPgZlFrTVIZpCQfW22IWyOy
 ztMzu1lQWeD1PcWwSkqP2u0jUgoPqgjzlZcrX+X1vSb6E7bhJtQHl053wR6231rd+Igjf6bduLc
 Jiwbn5gSRCpChg07TxCCy1bbVcYuLTKm38vKXFKRKU2EY5vsmSGOIm3TKXGbYHGGmzXB3KDlDNv
 KELZUn6BXiPubYfQ1ODzPWQrhc1TH4CagjFwGb5Dw==
X-Received: by 2002:a05:6a21:6f12:b0:38b:e430:157a with SMTP id
 adf61e73a8af0-392e0115568mr13394366637.41.1770087755482; 
 Mon, 02 Feb 2026 19:02:35 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c64276efd8asm15999627a12.7.2026.02.02.19.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:02:34 -0800 (PST)
Message-ID: <299e4fa8-d973-49cc-85d2-87d5477ca4fe@linaro.org>
Date: Tue, 3 Feb 2026 13:02:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] target/arm: Fix feature check in DO_SVE2_RRX,
 DO_SVE2_RRX_TB
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> In the macros DO_SVE2_RRX and DO_SVE2_RRX_TB we use the
> feature check aa64_sve, thus exposing this set of instructions
> in SVE as well as SVE2. Use aa64_sve2 instead, so they UNDEF
> on an SVE1-only CPU as they should.
> 
> Strictly, the condition here should be "SVE2 or SME"; but we
> will correct that in a following commit with all the other
> missing "or SME" checks.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 64adb5c1ce..81f487152c 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
>              gen_helper_gvec_udot_idx_2h, a)
>   
>   #define DO_SVE2_RRX(NAME, FUNC) \
> -    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
> +    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
>                  a->rd, a->rn, a->rm, a->index)
>   
>   DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
> @@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmulh_idx_d)
>   #undef DO_SVE2_RRX
>   
>   #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
> -    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
> +    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
>                  a->rd, a->rn, a->rm, (a->index << 1) | TOP)
>   
>   DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

