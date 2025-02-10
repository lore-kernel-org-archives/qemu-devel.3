Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5123DC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZO3-00033n-J0; Mon, 10 Feb 2025 14:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZNq-0002wK-4y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:23:55 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZNo-0006lz-8d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:23:53 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso29781855ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739215430; x=1739820230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lspwnponpGADd1D4Kpy6wY6Sz0h6Xh9FVhPJX9U3Tzg=;
 b=rMU4QyCzsEvx++J+OG27ruFj8e1hGK+MV7vQFVX2lV1wVtxwRch0HayER/v4GNraRB
 Ka+JM6CecRZ1e5T1KUp2N5rTMek7550cCsct3eQ8IJbfly6wo89ix9i8h5YYP1MsxZbP
 8etDg9ln8oEz91CUH+sFQZqQUSKjugKxMNVYcVHas++pN0jsjNM7buKdz0q1qcl0HiIQ
 a0mK0k1OjC+zz33uRz6rdWnnVRYP5MvRWnBgHTUqhpg1RupjAjY8c/HRbXpDRF3jjs0k
 2nrmwu97E6+7gWYhwUwuYyPOFWUiWG2+dOy1tl+T4YR4CbjlTVVzw7JmJPeWAeWoICny
 ZrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739215430; x=1739820230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lspwnponpGADd1D4Kpy6wY6Sz0h6Xh9FVhPJX9U3Tzg=;
 b=v07ptY3o0+xly5pAjsvrBF9mIlvjuK3CKeU1exIwSdzLvPFBJgLuoCtjYD0smOSdyr
 LUhBYa5OK90ZNRgu4gW5obPCXxoOdRwJ/SlGccx3TaH3f0BfbBRnawFFpo4VpDmiXbH9
 tP4+Y0vmQqG9w6Md1Ww8LNq3snaLoQraJTnTkhFf0D5dVg8VBOW9SozsUrqxAdSbuH0L
 6pwbeA+FUtp1Mvfl6t28Yi6shc2l1+jbTxA4d4205wsgUUMhyNHqLmRwEzWeag1OkcTI
 uPf59jXa1F1d198rjDiGWlQp7Vpy2we4oJpMj4bm1NAnzecSLGXBSUw3guBsRMGlOLUz
 3pBg==
X-Gm-Message-State: AOJu0YxWMfYFlf/1ntX8QZV2s8lk/wlccClJiF/ylhbfuU/21Kh05D5V
 65JeTA1opa6AOY4BJML0VQe7irn1/wnj2hzmbQoZdmvsr4raErTO4ENEY+/cwC86RJpyMoAvplh
 T
X-Gm-Gg: ASbGncvv5PUF2YnTlm/Zo+iqY8Jj5VCuwNwnpsOlkwTU0V49BBvUe8xbTFVEajFz4gz
 IHUOkQPZWSzuW2rztGyrvpG13hg+f6AKucoX4oJZgcOeTaTPQ9z0SrBmM1exLmc54fjC4h8kvD5
 59QS0uBcth2ccsDPV7rIW+owsmJLRUWirzOgPVKNMglrP0LE5msLfjZQyTV2pN8BrHSicxFQwBO
 EpcKchhbIqzsyJTSEdLx5lmVzzWqB4aP8e8n7TtlsEVOHfNnFUfdU2OhihMFKnLsf6cuMSq54Yx
 vWfBxw2lZTucUx/V6RKwRDGAtg7vi2Qc7G7TWfBt6XDS0njxMqYeMfw=
X-Google-Smtp-Source: AGHT+IFxi0xgztYZSVgWAuEiSzFKNHdC9um5zYgn6kWu3M5rwMm890PNfpqOxuKJU0FWuu3+k1oYjw==
X-Received: by 2002:a17:902:d4c4:b0:21f:8677:595f with SMTP id
 d9443c01a7336-21f86775a33mr94529095ad.15.1739215430169; 
 Mon, 10 Feb 2025 11:23:50 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d5b0sm82296755ad.109.2025.02.10.11.23.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:23:49 -0800 (PST)
Message-ID: <57145fa2-3a50-48af-a647-b936aecaec64@linaro.org>
Date: Mon, 10 Feb 2025 11:23:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/intc/arm_gicv3_cpuif(): Remove redundant tests
 of is_a64()
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> In the gicv3_{irq,fiq,irqfiq}_access() functions, in the
> arm_current_el(env) == 3 case we do the following test:
>      if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
>          r = CP_ACCESS_TRAP_EL3;
>      }
> 
> In this check, the "!is_a64(env)" is redundant, because if
> we are at EL3 and in AArch64 then arm_is_el3_or_mon() will
> return true and we will skip the if() body anyway.
> 
> Remove the unnecessary tests.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

