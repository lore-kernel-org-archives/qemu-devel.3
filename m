Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27ABC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkYN-00058e-MG; Fri, 04 Jul 2025 13:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXkYK-00057T-Gv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:50:24 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXkYI-0000kS-US
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:50:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40a7322f081so351586b6e.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751651421; x=1752256221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hRbAt35ga9TlYhtTcIDMTS2490Ha3n2dEGWk3Zn+vJo=;
 b=JP8s/2vbsiuhnUWwxGojdol+lKUUrwCzQBGjz9yZKo/VRSwT1PxDnnApnO/knEKwuU
 PLHuRd+GL00U4y1U7+Udr50nMAMLotMV+wLtWLXE7hcw0vokhxqddE0DYnu8R59nW6n2
 ivAHsVesmTDmpRcUmW8zrki9HzhTeX9BgXxLA5xT12zUFRfx3Z80+FIslb6CnOs4AScK
 vL6FCM0Qc435OgcOSS9oO7tnaKsWTWqfSYCofKPBiBWZM+5CDfBfc/DQAAbTYek/nKr0
 j4L4NHg7MI+w4ejYm0gJzRdeQnfz9ctfrXCV61wjPr1NQoDoEy0mQFjTwod7CWHWH6o/
 n4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751651421; x=1752256221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hRbAt35ga9TlYhtTcIDMTS2490Ha3n2dEGWk3Zn+vJo=;
 b=m/m7tZe+0dxvrpm3QF8J6EipNQ7CPOygW5lCJyszYiQH/gwrGkGLsRrfjvfuoiPnOk
 YsiKlxBG4jl+g9KmckuuLZlaQpOI9w/2VWlRAdMFa8bQHv84q2D/QW2uFKXGX1XJQfB8
 sm5qiO45WQI1elNYBi4wrclpyzdBeiqLvxDRXphEks6tRdCEKP4M83gfixpaoKDGn/Wd
 Rbi6ej7CBTSPeZqnPb1Z9wU2UOn7O0UURxp5dhraQY9D0f4O8Vlw6lZc6vSZUkAYrr7z
 82e3ACFz01ZUtk6fy5zBQKLwKvJlDkNzxXb33cwI5ZjOUEEjP+z4cW4PI0O99oMh6YFy
 lVVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWriPJ5dZylYJ98siZVgT/io/9geVsRTsaayAywS/eJ4Wrs64oqa4CJyEdViMyI2SndAaxIp0JQuTTU@nongnu.org
X-Gm-Message-State: AOJu0Yxrow3RapzIB7aKoUWUCW6glCxUO+epWxO5Fm+oEzryd4tbDEFO
 nGmOntRDgCDtJE1SWLa8cr9ijcvxiWQZWEH12NM1vktNiLvSRHiY8Tq/6ydkaV0PCtZLrSNTkp2
 HHyyE+jw=
X-Gm-Gg: ASbGnctFfRV/tXc8UbIkhg+0okifds7ocXZn0qMslXeqDd42cwGaD7il0TuPLbeWf/z
 ZgaOPJnD8FaK8vbPjZ3rykiZZd0MLb6fP5KcWPDQeGarLqXIqofl9C+0RwpH6Szq3O5v3qbeeY+
 MmYPJ8jN92SB47dp8KjGRkHEaitCdpsm6qfVJOXFHvzt5H+G3mOh5HRXmYTpzd5dupR2J0FnJl2
 qOnSAHu+3H2J97fIkM4Ysil5OEwQoPGukt+B5629M9tPHU7XPWiL6J2Krka4+OB2eQr5hxaFp9U
 JKqaNtoCupTBkIdtvkpYipmVmSBO+rtCCmkb0Glj3iD2KHXiXN8MwRIRERcltTV/zSOTuCecHfc
 8eaVXn40htJ9aYQbzr36m+dxnsHOCMTOnj+HAn/18
X-Google-Smtp-Source: AGHT+IGTrus+rwNVDelF/cE8AD2KvMZCyD8H4z7SngRxCXQXwyhe8zRrQDPuYNfuo5TNBNiJPsOaug==
X-Received: by 2002:a05:6808:5090:b0:40b:9361:cd69 with SMTP id
 5614622812f47-40d043a3153mr2857517b6e.15.1751651421506; 
 Fri, 04 Jul 2025 10:50:21 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a43f8bsm371347b6e.12.2025.07.04.10.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 10:50:21 -0700 (PDT)
Message-ID: <97a6099f-0272-4156-85bc-8c7881dec8db@linaro.org>
Date: Fri, 4 Jul 2025 11:50:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't enforce NSE,NS check for EL3->EL3
 returns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250704165636.261888-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704165636.261888-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 7/4/25 10:56, Peter Maydell wrote:
> In the Arm ARM, rule R_TYTWB that defines illegal exception return cases
> includes the case:
>   If FEAT_RME is implemented, then if SCR_EL3.{NSE, NS} is {1, 0}, an
>   exception return from EL3 to a lower Exception level
> 
> Our implementation of this check fails to check that the
> return is to a lower exception level, so it will incorrectly fire on
> EL3->EL3 exception returns.
> 
> Fix the check condition. This requires us to move it further
> down in the function to a point where we know the new_el value.
> 
> Fixes: 35aa6715ddcd9 ("target/arm: Catch illegal-exception-return from EL3 with bad NSE/NS")
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3016
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

