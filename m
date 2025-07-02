Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE9EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWybm-0006QW-2U; Wed, 02 Jul 2025 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWybe-0006PO-36
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:38:39 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWybX-0005Yf-6u
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:38:35 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2e9a38d2a3aso4487684fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467107; x=1752071907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lLsDdrK/c3twitjLNwxwexjP9Lc4HpJcodYK/GHxapg=;
 b=zbMsZK5G6rnOocN5nnNZeev4OjAFwcR/UUrEZ6DMyqrRskwqNXUYsGMC116sTneG+9
 9Cs5wDISp5gr3ZRIiOSPLgdPl5mfAkrbRm1enNzRMUmkN9qKfgx+nj+35sp+haFZaVjl
 vIgXh22BIoeveRz7/2Q+WNHuMlHOUZDtW6dRCnMGhrdnf48va4DNbGSSyqVtyz50Fdym
 j82Nq+W1YFQus1M1QgM53jNmemW4kSJIc7+AB140xPleSqpHHAgg1A9Kd/ohaBSlPHNk
 PmJ2MrnXtSyvFsmyVpBQI+99kExuVBossAVI6gVfoNYGe7UGTvAkWLK4cIdYYuXtA+pc
 4MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467107; x=1752071907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLsDdrK/c3twitjLNwxwexjP9Lc4HpJcodYK/GHxapg=;
 b=PAXSk6K0oLl4crX6/eV0rfilI8sklsQWOa41497HRDqI89DfqrPglfB/kDQfJ+NjBK
 JAwsrtH1Yu79OP4yY8/2GGtMCth7Et7wyFakP3HNVVbWoI5rFhram2pdAqzVTq3KxK4O
 hckZjjd0JcgP0V8zv3ImYEvfEeQkN/mn5UD1oyNdtKEjdb8hvNqpUrTs7WHBCn72WnRj
 C6x4kJV1iYSKGYcOfX4gty6YCnbaDQZv0vBchuTF5X2TW0AbyWyu2Q2PXNGjEajSZY90
 oDtwaR5fWCMRWCEVR7QFWv5LRVUPnzwGBKLkHyM9kZkEsL61f1+71HB4uk1Qpmk4mgyD
 9VgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3r4xwsICvejGViOlSWERvsk7tJpEZi9WKgCk+Et31eu6AKTrp7MtQTdVbJxfoKUC0ISQ8H529XiWH@nongnu.org
X-Gm-Message-State: AOJu0Yw4/AYtuOxzQSsDhz9BrFbDLiH82ft7ib0g1kCsvCoy2odw759+
 fdqCaI5nTOrz/lxYCbwClJvL5ba2mLATa2GktkNxiPFHSO0AIcdrjNF7K7OVl87dTuk=
X-Gm-Gg: ASbGnct5J16FPz6+muzZDwJs8CbCB+kdlS5yTMSyl2e6x8Rh1ISL++yXWDzTapCH/Xu
 hKg5J9u4VkBtH57GfaVw5Ym+rGiPCagfJTbCTD+vbSGa5gUTNQnoUT+Npx1m2btw5ke4HHMFnHj
 EfLWIADPpCQpeLZdTjbSihDnZcLjnIt4JwP2pr1Dk1hzFSUNlccLmDogQ8fVhnLZxPgQPnvkxNC
 mwSrKzTxR6FA5c1kkbhHp+wFBDHAby4KSyRbZv9/+mQoETd6ZTcThrBQ6MeANzz1hsocIb3+xXg
 rpYOnhr+ljscX+08YYHTVVcvjkAQ9f86YwP2xaE9wxzIE0NKCFXlEWslyBXN2fVd3F/QVdsKyL8
 5
X-Google-Smtp-Source: AGHT+IHRsEh6yWxiB3r/a/Zv89cjYFp67p6eyHeGk9XcgTgkSqBmgm+NqfbpM4DZFX4yCfW56Tn0hg==
X-Received: by 2002:a05:6870:b201:b0:2f3:e087:6b08 with SMTP id
 586e51a60fabf-2f5a8b9022bmr2305059fac.24.1751467107135; 
 Wed, 02 Jul 2025 07:38:27 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3910882fac.32.2025.07.02.07.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:38:26 -0700 (PDT)
Message-ID: <7e14ce0e-fb61-48cc-9d41-618ea69a2ce8@linaro.org>
Date: Wed, 2 Jul 2025 08:38:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] target/arm: Fix function_return helper load
 alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-4-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-4-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the load operations (when unstacking the
> return pc and psr) in the FunctionReturn pseudocode.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/m_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index f342d93489..28307b5615 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -1946,7 +1946,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
>            * do them as secure, so work out what MMU index that is.
>            */
>           mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
> -        oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
> +        oi = make_memop_idx(MO_LEUL | MO_ALIGN, arm_to_core_mmu_idx(mmu_idx));
>           newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
>           newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

