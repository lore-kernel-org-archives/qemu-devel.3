Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16ABC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhyq-0006dT-V0; Sat, 25 Jan 2025 10:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhyp-0006cd-5m
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:21:51 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhyn-0003S4-O4
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:21:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21bc1512a63so61629505ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818508; x=1738423308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6OBz/kihxLNAN8oMMS8wWSaV94tByWmx/mV+M4TOFQ=;
 b=u48rXJeXir0Aso4Y+H8AjySwsKWjA0bdKbX/HDo98z39e99Phg4iahhH73a8FcyXaP
 8QTpSvRl0lhlBGBY/cHThkHkkXEyTCVRuT8WYDSMEfHqLCzOeMsHL79oNT/1VTXbtqTR
 C4P/z1FzYPt4qctiC9cSV6vzbLdJRDXMfxhTuo5OmlgQOHD7BCyPmmVkat8HVDwTe93o
 R9e1ojkR83yLf07oo6y3rPS3aIFhlx8lNYlGf+QfG546D5UOmsC/DjhC5Vjb9C3q2Uz/
 osTeMtsCq5ejtFLnqbdcVAOD/179KNaePl7Ni/K9ESFwwFksqiu1vHNi+LoTkMyCR18K
 HrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818508; x=1738423308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6OBz/kihxLNAN8oMMS8wWSaV94tByWmx/mV+M4TOFQ=;
 b=D6t8CzbBrTJxyZGIYbuuktvDyidTnXsOIM5Am9V96ljZgmbuOYOFbS+H4iBHw2y18G
 ZjL9/JU0TC2TaFGcaWtO9auR07nz3Ue+2NZXpB0OertSfnLg4w081Pd9gY5mXYPWfcqN
 OR3KEMhAulKKs0yOlKJybFD7LEV01kmox0RIs9rxtoP7gnsY6JqsCVSi6o+WYdw7hqNp
 Ld6PVyx3fvgQf1In+vWcid9g/mttQHPWlm17TGltvTMTyyJgY2Mx0Dhs9VNtwBDtMiex
 qVJBwl5C9Nmnt+Q1QtF4E/BkNlzAmmC1Khybxjs7jX5aLO1W9ZSJDd22+OwlyBm4stkN
 gkTA==
X-Gm-Message-State: AOJu0YzF+nHHHE7MXYtZaShn7A9LmIStqg40ZPQEI0AjacLemtjYzrU/
 3mq/zIkdB2ydD//bQK/ps2U5zkby1PZLWajoHlOtZouOKinXNO06kqoghd4Vt/fVVWltE4dpdzU
 X
X-Gm-Gg: ASbGncsqT1c14gG11l7630r0OZ+Hg1yEMwGvae8nBNqBX/Qo+10t4ZHiVnVDZVQbN0x
 WUBCG05WTBC7iQ/WQQmqEYAPAQaCJl5vKY55uBcY+lJozuhrREVE2siMu33Ka/Kn/b37nMcC1X7
 zbCirgdaI7cMVx0MM8LoinYxUnzXo1z1/CB96UMrjU09RGmkt6BylQZdC3uzBlIFHwpl6WoqjAU
 WAb5kZmR/wIVj99QxcEHXuMW303Fuj7f9Jn+wER5ssP/s7FvJgBLd7Ce0SQtm1CvuUGqGYoMHc1
 R/62QTYRRsL0rdzCX6pzVZqVSazd980D
X-Google-Smtp-Source: AGHT+IEC6hx4ne77vsYQUSHL4YkPXGa30w8cFYBLlSNpI8i9+0yO010ECwNp7ekFGFPHzVdLLV/FnQ==
X-Received: by 2002:a17:902:c943:b0:215:a18f:88a8 with SMTP id
 d9443c01a7336-21c357afde0mr499538995ad.51.1737818508350; 
 Sat, 25 Jan 2025 07:21:48 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da4141c7bsm33135745ad.115.2025.01.25.07.21.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:21:47 -0800 (PST)
Message-ID: <b9e88ce3-f776-4204-af1b-913067002163@linaro.org>
Date: Sat, 25 Jan 2025 07:21:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/76] target/arm: Use fp_status_f16_a32 in AArch32-only
 helpers
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-15-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> We directly use fp_status_f16 in a handful of helpers that
> are AArch32-specific; switch to fp_status_f16_a32 for these.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 4 ++--
>   target/arm/vfp_helper.c     | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

