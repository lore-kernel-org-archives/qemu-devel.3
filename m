Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D8FC83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctSg-0007K5-Kv; Fri, 18 Jul 2025 18:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsrb-00040d-UJ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:43:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsra-0006sd-AS
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:43:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23508d30142so30654185ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752875008; x=1753479808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNswNgnNbDvVcuoMnGRX1cNiu+F3tc7IPFoBAePUEnE=;
 b=d2eHSXo3zTqqIHmV5LxSd3SMUGHF+Ni+9qS/vrDtpqE2w2Z5BnYl9aHuxVuPODI35o
 3lqkQ9GpvcItOQEjAELA6/V47Azb5f9O0uMOO/Ywu270KjAzckn5Boykxh3pfRW0qkSu
 ebfk0XAjv912/K0ibpDRg+A11Kl5gcrlWfnp6hgDiO1nHmfL1wvH44UfxGY5AdFrgxdl
 a2vYPmCM1jaGdvX90WEL6lNPXxRONU+FSDPwijoK04TRcIsXrMtxvMuhzz+6TelIoCyv
 keKOfepcjqV5+Nsgtwvvlc2ZnFhi137kUZoP4vQqQxgtEPHLrlrFGtqXwJWHioSMyHGo
 ZM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752875008; x=1753479808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNswNgnNbDvVcuoMnGRX1cNiu+F3tc7IPFoBAePUEnE=;
 b=O6ZkugE0GItQr9Cf391kqRc+7at0oOWCgrMv9NQBdfqKI06qmmFW0N00x1pI7nzBOS
 0cVqK5a7eYO1UTXY3kRbCWiouKsOiLHkCfMDDy9lYm+W+GX5SCpheux2w2lHhEHZQfW+
 l8FholNiurStudazA+5F4uaklANRSx1daaW2QmGJKhy6fme9vrvm1o13ec+Ge8HxJc+8
 +CXCGkdElpPGqXZ4NdKNBTG6SUJNPyjkvYxjNO1/XkcNAdHPleboOBoPhCPzn0SFXBwx
 MHZxbjZe6PSBaLx0M0h/3RShyfLtzUiZPYS6PyglNdNY9WJLZzdkxXhaf6oYDs2w3hqR
 jhQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSueGKZhdK1I7gV0mAlGDEmgAt1G5qd+xYpEEF3fxO8AO8wOqCMThMlPy281O0MvzWUfWm/qTdoKMK@nongnu.org
X-Gm-Message-State: AOJu0YxaL+jsPB6xof+aiUL1FplJ50jiHzS2OmaofBTM44JIJs+2P3ho
 WWud379NkXuP09jsQu3C5Zbur3CErRLFh/9UpOloey1N6avrfSQSebJ0cQxLr3WYsK4m7FRWKou
 Qj+F6
X-Gm-Gg: ASbGncuC32/RAsMLZN8L5cCmnA2sxmfycn+Ne3jCD3FXHj3BoqVypZXx4twyc/bycwH
 uihoGTm2A+eziWESTlzAmuUxh3al+A1iWEQ2xOYhQckO8218XiodYa6EIb3tFwWehrJH0COW6bC
 vdyGcMEDlAN6mEKEK4Oj6MG9eaqLkOInhdrvJXXmIe8v3GMqkD3Vr/sCnqzR4WO4mjbGj2U2djc
 HqoGs2Hfrx6oWhVm1WMVFguj8bO+3ZIvsCaESuR+NFHtyrQfrOtWeiiXOxDSW3i5k8awqS9ZERV
 +Ahws7s+O2/lpnKyZ+jK+I+UeqzwfyC0RyHHiH8/1TZMaaTy6Ao56+RWvhPv9hSrqPDVSVD5pgK
 GvS3nWZGH+bRZgZYTvhT0IOLheoP8P/zivplYUU91iA==
X-Google-Smtp-Source: AGHT+IFBdQbVUATtOlpIyNZCK3RTA14viuWQoD406fNbjSqUwYu6UsKekLdTeXC92R+MKl/+gZ740A==
X-Received: by 2002:a17:903:1112:b0:235:ec11:f0ee with SMTP id
 d9443c01a7336-23e2569bbe0mr163386585ad.14.1752875008528; 
 Fri, 18 Jul 2025 14:43:28 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b612373sm18183165ad.72.2025.07.18.14.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:43:28 -0700 (PDT)
Message-ID: <d64ffc96-4991-46f2-8cbc-77d59c33f3b8@linaro.org>
Date: Fri, 18 Jul 2025 14:43:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 07/10] target/arm: Correct sense of FPCR.AH test
 for FMAXQV and FMINQV
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/18/25 10:30, Peter Maydell wrote:
> When we implemented the FMAXQV and FMINQV insns we accidentally
> inverted the sense of the FPCR.AH test, so we gave the AH=1 behaviour
> when FPCR.AH was zero, and vice-versa.  (The difference is limited to
> hadling of negative zero and NaN inputs.)
> 
> Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index fc76624b5a1..2ed440aff15 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4020,7 +4020,7 @@ static gen_helper_gvec_3_ptr * const fmaxqv_ah_fns[4] = {
>       gen_helper_sve2p1_ah_fmaxqv_s, gen_helper_sve2p1_ah_fmaxqv_d,
>   };
>   TRANS_FEAT(FMAXQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
> -           (s->fpcr_ah ? fmaxqv_fns : fmaxqv_ah_fns)[a->esz], a, 0,
> +           (s->fpcr_ah ? fmaxqv_ah_fns : fmaxqv_fns)[a->esz], a, 0,
>              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
>   
>   static gen_helper_gvec_3_ptr * const fminqv_fns[4] = {
> @@ -4032,7 +4032,7 @@ static gen_helper_gvec_3_ptr * const fminqv_ah_fns[4] = {
>       gen_helper_sve2p1_ah_fminqv_s, gen_helper_sve2p1_ah_fminqv_d,
>   };
>   TRANS_FEAT(FMINQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
> -           (s->fpcr_ah ? fminqv_fns : fminqv_ah_fns)[a->esz], a, 0,
> +           (s->fpcr_ah ? fminqv_ah_fns : fminqv_fns)[a->esz], a, 0,
>              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
>   
>   /*

Whoopsie.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

