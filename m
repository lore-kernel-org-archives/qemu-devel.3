Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37955C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi0p-0000zx-8j; Sat, 25 Jan 2025 10:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0m-0000zX-QA
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0l-0003gG-9y
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21661be2c2dso52769525ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818630; x=1738423430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naVh3FTmTWro4SYlZG59O/x7+YvfleBhCu2mMYiNWRs=;
 b=JmBY45JcAcztx3inRJf7kY95M5PWG8/eZU3D+d3yL6ZGSR+fgY5LfYCCustN18mPyZ
 Lw5Q3OQn/H8QRe2YggU42vC0YQ3u5nZJEuKCLpQWXe7ShovmUqWsh+ihsHRe4HP8eyYp
 u6ZYr4mWQNk9p+2pPiO4z827itsrIUhf5o61WGaYRlkl84G6/5Ov2uqFVzUt3yw5YTBl
 QX6wln9ClG8CC5PwNSbiyrPnXM2OkVepd5QXBzO3frQswXAVGruLamNClFr3Wtsnv0ry
 ax77QsShLAOe52PGY0o/M1hRtpCoqsBwks5w/QejqTq3wc1Vj8cBPZE39hos0YxoJCnT
 3RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818630; x=1738423430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=naVh3FTmTWro4SYlZG59O/x7+YvfleBhCu2mMYiNWRs=;
 b=krYfgDpK0KacUM1Y+UCr8OOgiXrKFnNJaxK1GMUvu1nX8t6awcmT02RtShAvCHEKfa
 5RgQbQ5SXc8l/Uyq9KzkQsLkVLj2dasNJzl/1uc9e7AW6TI1AWChNiGzt3KDJ/xjtdFb
 haSfrXbrmwtC3y5kx1ic3/41kAOCHisKEWhgRJeSuhAvo4X1oh++q3mOn6GbTXCa2PFC
 sJ5x3mq8clGLSFy0T9FUEPPC4sg2qo9rLU1p16KAuLjpQ01/SxZ5Ph5mkWUlUAgWOw6v
 ObEDPtBEQCzEFnxto2hGnG1uBUI2XbNN+OxrKJJi3hLLzHrUpxcchBp30ZJEFjo5WHLw
 u1fg==
X-Gm-Message-State: AOJu0Yz1PyEkN15k/iSL0667xYuBDLiqonZaK5QmHtUugf/GEbhFEmT3
 EmG1c0Ez2/k4Et1/ms9mdz0fuwLNPAYVEUEGoQkCUDCztUgE27DQ8zWivGATaprpsZx0REeLpXI
 2
X-Gm-Gg: ASbGnct8gLUWIdgxVp8w1/WgoZf6r9B6G1CusYPGxfrJVxnlQvIGW+DI9sKxa2w+xk2
 emoIMV3YQzLGNhD8Vbt/2G9J0VVg3G6lrl1XJ8DcO7q0QDEPG8AwstBXk66jKdOYaQpY+G0iTq5
 e0wiiDfE7Hk9gaeCUMRM+wkolpt2jVYhmhZ6xdatm24lcnRDR8AqikQwZ0oWtt2WEyssd8e4QdF
 EPDmSISaRKgQtU8llO0DNsae5q9J/P5T6+F5jW7GQRDatgslS/7qtUP4hgZMm0j3BiP3BgLgzs6
 cS1c21L7j9Gn2Qi7wrkL+Q==
X-Google-Smtp-Source: AGHT+IFx+kiAE3ekZ8RY9VFwKcPRpnn7I/ZIPQS72hEOEeBH82henJ27XEuReEIMGjgVitlLuEf+7g==
X-Received: by 2002:a17:902:d2c9:b0:21a:8ce5:10e7 with SMTP id
 d9443c01a7336-21c35530380mr511507435ad.23.1737818629912; 
 Sat, 25 Jan 2025 07:23:49 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424e827sm33234495ad.233.2025.01.25.07.23.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:23:49 -0800 (PST)
Message-ID: <33d2a9dd-5153-4cc5-847b-a1c9e91b90ee@linaro.org>
Date: Sat, 25 Jan 2025 07:23:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/76] target/arm: Remove now-unused vfp.fp_status_f16 and
 FPST_FPCR_F16
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-19-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> Now we have moved all the uses of vfp.fp_status_f16 and FPST_FPCR_F16
> to the new A32 or A64 fields, we can remove these.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h           | 2 --
>   target/arm/tcg/translate.h | 6 ------
>   target/arm/cpu.c           | 1 -
>   target/arm/vfp_helper.c    | 7 -------
>   4 files changed, 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

