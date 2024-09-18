Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E165CE8D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srE1b-0004iA-8b; Thu, 19 Sep 2024 06:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1Z-0004hT-4c
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:33 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1X-0002G6-9O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:32 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53659867cbdso974503e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726740269; x=1727345069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fgkteckHfqEieyx6yTUMKAb4iTKgJ61+BnzJtGAfN8=;
 b=ncbJDJ87G2z8WAG1XcNkT647SBidy374rw4Utoo/7cooVdCxq4+neWYcH8KQp8YTgN
 HsAbbvOeAkjzTRVI3muhgc3N71mcJx01zv6yTB1dUzh3GE0Hr26GNAHSL+Dy0WXRXZTg
 xUj7mouXovuP/paEGxcfvqwFBqcHlfnOOcz/1tbiyQM3QJ64Ea4eWPcc6RC8PEA1losY
 c8NU+pN3f7yZwCJkNA1gVPg8OobYvss2EUbQhYvbwtNFTICgxODzCXtvfyZHmXuhsdrp
 F/sFBn5rw1xzz3w3jNE9B/7+8FRyu7R/+hytHwI0QylxGcoqQ2z8eK6+2kpYlsnLsGF0
 173A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726740269; x=1727345069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fgkteckHfqEieyx6yTUMKAb4iTKgJ61+BnzJtGAfN8=;
 b=tD3lZZsSdxJ8hYtFS7Z0+r5kK+GH2rSKAEohsehr+T2D9nH5eO8Me/bP1qCZj6No/P
 fp8EgOfozVTveYkR+gs7KOQ1Vo8TuVFBwrE8BeL93EwnUwJMNVrJydap505UeV6ekAuG
 tqdvoUHdEyMM4hnf2cp2rFVz1Jy6WAiPBLJ1mARNgPi+OvJrqArxYCuxp4SFfI6uzvvv
 zS/Jsd2tYhYZcKsReH5SjaDqc9xuIUGktYM/qR8PnHcqRRJb6J7nL55zVDAjZCxYdT7F
 IF+cmPIHMHqsAV9QB3Z1aPtYBXi/Js4M/t194s4ioYFPAf4extCLpHgHe5zmty2dG8jI
 RN5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGquG7+QuUaWz+zcHjZYbnbQkhy4eNn2UvRxCjqoXy+amb0GjC1YR7v+clMcfvU8FEQR4AbDjgMueC@nongnu.org
X-Gm-Message-State: AOJu0YybsGCXkpUTO73KPktv4y+mbchCt3JdtQsW4TryQ8/pYz/XpOk7
 ycJe2TrEEDmVdABoFhFRWS33JrN4KBdA07ZwQmnHgALt0spY4XdstxTeufQEQ/U=
X-Google-Smtp-Source: AGHT+IHv3W2ThZ6MkHobEJzznVOjszQn6y0ZQBibGCJ2SE/pXI8RGKQjgU1wSShNxpCbWH/PtQMdow==
X-Received: by 2002:a05:6512:2216:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-5367ff32872mr15710557e87.50.1726740268883; 
 Thu, 19 Sep 2024 03:04:28 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f3aaesm701574766b.53.2024.09.19.03.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 03:04:28 -0700 (PDT)
Message-ID: <cfffe21e-258e-4592-802e-0797a045b97f@linaro.org>
Date: Wed, 18 Sep 2024 16:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240917161337.3012188-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240917161337.3012188-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/17/24 18:13, Peter Maydell wrote:
> The Neoverse-V1 TRM is a bit confused about the layout of the
> ID_AA64ISAR1_EL1 register, and so its table 3-6 has the wrong value
> for this ID register.  Trust instead section 3.2.74's list of which
> fields are set.
> 
> This means that we stop incorrectly reporting FEAT_XS as present, and
> now report the presence of FEAT_BF16.
> 
> Cc:qemu-stable@nongnu.org
> Reported-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

