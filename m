Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E4DC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi5O-0003ly-5N; Wed, 19 Aug 2026 11:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi5M-0003lm-BN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:20:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi5J-0004hf-RJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:20:12 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso728325b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787152808; x=1787757608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JZnB3Dxuypq1DfYlzbRvpa+QT/STF1iSVE4GHNfBWw8=;
 b=IxGIQvRMEjV5zHLPwMfFrf0KLPHI9cQArdewhCqs1NHMTfONHAVE9tRwomnljqtMt2
 OsHhMtGViYTm/bmV43T8ga8grIbTpbdzzSAfJigxwLgdtTL4T+tlqUga067ONGu8jyF+
 xcwdB5/eQiXc4ljLDlZy9L9t0HEOuVtmarnT3v+pEbKHklQz72BGJwPerGo2hC1qSdPj
 CBQmenQy6t3HV3pKvVFUh36wrlQ3smckx7PQRs+0Ifyox5msYbdDw+UmOPreKVGRaPSR
 PQda1IdvcBxyahi7/HC+cqbvxot7acTI/hmWRDo7fYMpCTFzBhEF0tbQ0MIyldX98Tpf
 Rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152808; x=1787757608;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JZnB3Dxuypq1DfYlzbRvpa+QT/STF1iSVE4GHNfBWw8=;
 b=fNOlgItVnQ2DF1m9gLAMzNPeo/Jls3RzF/xSV1HBn1MI36MkLZn9bbud+BOWhirsqc
 wVkCV3BL9b+7aNymqtV9ml5tECpaLFDWjlPdJXK8ipkDr2rsxeAqGY/6QoMglA3MyLbl
 Ig2QpCTMykaQJE4LBmYb/flKNiz3PVns1twWYz93D9YK4GzTERm69QvEigajVqLcZHW2
 bW/r5u4dJanqs/8HT5Mnz1f54rtS5ybsIwuwY2Bo2u113PaDsZmakE+NIzY/u7Yc3D43
 23C1csD/CMfaygljnVQzwcrM/5qizTPjiCjxqSOWLxUkY9zW2y481iH/QqZ+njk6bocZ
 oSsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpO0JywwW+eR95PNQ6VFPEfVvqkVwNhKuJykXZfI+wT2BteMXzrG/JRIjk+hurU74MfGBYhSDp+51VK@nongnu.org
X-Gm-Message-State: AOJu0YzTQT5B7i0/SXeL552hLb+/gRoLq2ztqIdGp5k+ux6i8+TepDMn
 EpqtbjEEN+JKa1iuzBt+pkJ2iD4AiGaZN4/xmWdBlHK1Igl/yPv//4Fx7uDdJQy0hdg=
X-Gm-Gg: AR+sD10IdRmbLkuOTXK4ksp1WolCZM1DxxEZ/UMaIXNvv38ZCdOjUDQ3naWhaE/0mxv
 z0PIMlemutMwTL3gVREXxjRlwQKiCb+a0QJG9XKtYHTOARUXtE9mcz+xE9WaK7iqXhMxYL61DWy
 IOQJs+bY05hs3ZufVAIjxhXIik2gaG9uji/SRng/NbEvKXYJ3Jg94AiARPXVEQ79sc30rIOj4kM
 3OZGaFvQ6umCZkzhnd4UtU/kUfRwCxasZYKP9tnzZO3AJMu1Q1K8VPdjPu3PXku+ols8U9nza8g
 PafiTcO57aPwBmKOH2a7dVBLUrYuaRzZFrdbCKpzGdwupkDFfuo7+p9N+QL8ep8jbs7b43stlWc
 uRH9IjsTNrClDSM2ikvLuSp8coS6kcPSbnVGrMQMWbu1+6dIXynrrZ4FKJfGmtjQ4CeVnlUiq44
 zeFUaWx5J3Ct+Uq/O6yOB1FifCooNgq3rc10dT6UlHLTQoblQBMxvBnLsWVIuahxEZuZA+n1mrR
 BQZJqqr
X-Received: by 2002:a05:6a00:3407:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-851d3942af9mr8946037b3a.10.1787152808025; 
 Wed, 19 Aug 2026 08:20:08 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d366dc9fsm802985b3a.51.2026.08.19.08.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:20:07 -0700 (PDT)
Message-ID: <9372f8a2-c54e-4e54-83c6-e0454a308c33@linaro.org>
Date: Wed, 19 Aug 2026 08:20:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] target/arm: Pull Neon dregs checks out into a
 function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
 <20260817123838.1578060-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260817123838.1578060-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/17/26 05:38, Peter Maydell wrote:
> Abstract out the register check for Neon insns into a new function,
> similarly to what we have for VFP.  We don't have any extra checks
> that we need to add here, but having a neon_dregs_ok() is cleaner and
> means the Neon decode isn't oddly different to the VFP decode.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-neon.c | 118 ++++++++++++++------------------
>   target/arm/tcg/translate.c      |   1 +
>   target/arm/tcg/translate.h      |   1 +
>   3 files changed, 53 insertions(+), 67 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

