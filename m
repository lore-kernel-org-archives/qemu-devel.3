Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0CECE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL17X-0001Yc-2S; Mon, 17 Nov 2025 10:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL17U-0001XY-L3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:26:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL17S-0003zb-Sb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:26:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso30677585e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763393177; x=1763997977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jbfTDig/ej8CvcFENX9wrk4ynv4q8GykQ67r2pkeDo=;
 b=ouwelMrM3YzLz44I+DuR+inRT/vq3YBJ8RVnrxsRYpuM0x3Younx4WRnqWnE/P5Yq5
 wFieRr/N8JCNgbstCCsdtFqrYiGk0GCyHayxdCrdDx7Bm1hKiv55SnVG9uRr6B5ktzkY
 MsKVswN0rdQKq1Bnu0/kI0uhSUS3nr2CrpnApQJzo101ULVl6F8hSLTlop/CQPBJwLsK
 uFcIZmcttitARX7Jt9g6apvQXOBy2sz1QNTZ38H1K+kX415NC33Pgnrzjzg2vu89rjxY
 xtj77oUPkPcVDTuSkR4HdNWZIggjw7tQ+eX8FDXjiVJW8wGclWHmmqWdPLnXmu8HjA1C
 PXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763393177; x=1763997977;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jbfTDig/ej8CvcFENX9wrk4ynv4q8GykQ67r2pkeDo=;
 b=EL1+xqlFd3heiOXCZaje3pcSrDZkau382BV0QBHpdk1eBGC5/Y/YBnwOJ9l849mceQ
 1acGUUWd26B3HGx7E3jYWTOCpm6UtyKFrv3C2SC82Aw6YhOVrYn3NucGxCMoF6ctXl56
 fiDm1s5V24kkgMUcVeVMaRBtwUl+b1eekOlaNVhdbWLDhmhI9cPdBlu2MNaq0vkawkpb
 clCznywGxfnjmnXMYa2niKzVoqvk3ttDrfapXQPg6ANVMKEHvlR378EuPDIqmSTzyy+1
 Iio+u6UNt5m5qGJvPx2geZy2RY2wc+tSFsWOWlS2bhj1iRdWZpnVHslVQw5CltiQDbJp
 hk6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFK0/uOvHhO5IxWTE3D2skR5qslbzrQ0qJnEkrZGxMcZQ0xl+uUKLInnknCiL9q3T4Lk0+gviJE5/P@nongnu.org
X-Gm-Message-State: AOJu0YzsR+WQwuEIcqUF7dnb7u+AH6QSRbJXGRDj6SEHXv1/bOOvVdCc
 gP/uo50Un9vSsf3s5EGqHg5nUf7ZSAr8TSSRxAQLyfcLW1u1EMtrweOt0TLucmy7idrPBc0O9tW
 UUWdZH6U=
X-Gm-Gg: ASbGnct7YWikpya5v3FazV0TzvekXdWazwxEniAKm7W2QLyJ9gpHLm0tKuTgRjc+idK
 OF3nBb9HnOXHymiukstXYcsJNwMI0MtkxZ8cxzNCu0iRVwefA0rqrNIKvZfCNYH/fkRgZxysajG
 /UghZ5uFUE+C6Z7m78uG9+WOrOa+TrMwI5/jxQ9yqWaPyxgHdeBhe9WCppdibWtLLqYzz4TOvk3
 trAYXavfieEMqcqQlBv16+L/jIZH4YJy/TRzY/hStnBmKoHhHDcerm/WHv6pDiYa7nn33YcrRHQ
 RkixbW3HaLd5M2S3Nt7pKRuV1Mky8IVDknTu89BP2Jx50SnwDhT4bAn3qnr1u9bbD2BCDZbPOyZ
 ACPKSY/wb6kBSNxaTY098Poj5ssN29OoljN8rL+Ao59gANSh8QUAl3I0eXLYy/IykXnNFxI2h6O
 sPlO14V3RMkGcWOYPYCqWPwk1XfivulSbuH1Cc+IeCFVCglwqfimOSlhmpTZz5
X-Google-Smtp-Source: AGHT+IHuvRbYEDS0pfPFSanePMY0nawu9yjRP0Pl6Q8exiepm7xuwrZT4FWV5aAdD3prjmdGVJWY6Q==
X-Received: by 2002:a05:600c:a47:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-4778fea195emr139643055e9.30.1763393177028; 
 Mon, 17 Nov 2025 07:26:17 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm22092785e9.14.2025.11.17.07.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 07:26:16 -0800 (PST)
Message-ID: <9b2de87c-b7d8-4a64-8c7b-bf94e3233275@linaro.org>
Date: Mon, 17 Nov 2025 16:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/10] target/arm: add FEAT_MTE_STORE_ONLY logic
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-4-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-4-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> This feature automatically succeeds tag checks on load instructions when
> the appropriate SCTLR_TCSO register for the current exception level is
> set. Find information on this feature in the "Tag Checking" section of
> the ARM ARM, Memory Tagging Extension chapter.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index bb48fe359b..f9fd6fd408 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -865,8 +865,30 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
>       return 0;
>   }
>   
> +static bool mte_store_only_active(CPUARMState *env)
> +{
> +    int el = arm_current_el(env);
> +    if (el) {
> +        if (SCTLR_TCSO & env->cp15.sctlr_el[el]) {
> +            return true;
> +        }
> +    } else {
> +        if ((HCR_E2H & env->cp15.hcr_el2) &&'

You can't test hcr_el2 directly, because SecEL2 might not exist when (Non-secure) EL2 
does.  However, this can be simplified using arm_sctlr():

     uint64_t sctlr = arm_sctlr(env, el);
     uint64_t test = el ? SCTLR_TCSO : SCTLR_TCSO0;
     return sctlr & test;


That said, we should cache this in TBFLAGS so that we don't generate the mte_check 
function call at runtime for reads.  See target/arm/tcg/hflags.c, s/MTE_ACTIVE/.


r~

