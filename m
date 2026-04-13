Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43074F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQwJ-0000vx-1d; Mon, 13 Apr 2026 19:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQwH-0000sm-7r
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:43:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQwF-0000ut-ON
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:43:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso2485612b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776123810; x=1776728610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fLzjmA1OV+SUpT+ZfEpWC9pi56Oq0i8ulqnWx9yn380=;
 b=Q5q32nxW5YEVOEnNypeiao2GVm2ZG3yPWchcEyjl/5/g1JI0xeXFTfwjqRDBUNVrdw
 n1HQ0ZaBR1KudEQYz11KgppHH3LnxBR5AuJUX1MfEOaoh7f54QppP8wEcCYYztKo2IMb
 1JLllzpN2lMkCgiSJ+elgZlCPq93Oma7hzyAuZwkya3HijwfB0hE3hstdoxqL8LiScA+
 /Ss8udzfzzsHd15ZvPbvnmj0iPe1XsAeds4O1AcSTRmu1/fqsVNMr80QQu/mGqAsPN5S
 Z8+3SPyoXzGdJ2ETCh1JsjPyDOsbZn4P5IJ9kzztel4tyDsGJgGX4lEeSouYEKwm9mMH
 th1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123810; x=1776728610;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLzjmA1OV+SUpT+ZfEpWC9pi56Oq0i8ulqnWx9yn380=;
 b=Flr4B5DQ+PylrgVpqauinaRidnLStOPRlH2PEYlhtgo3EePEzQLb7fU+1gOX2AO4WS
 OTnUljollZtHDxV2KKUYtjG86mVl5CgzHk7Y0weNv5w6XHW98sm0s4DkcWvWklo261we
 KGQyVZd6DVIlZvTvBQXiLj4JzzvFakaF8ZTER+j2OzYfNvbodUG6HuNdsDeKXumk1xmo
 g6BW7M4+DxzPwSqCyR1Qb0vAgkfeRA0V08IJc7aa+1Aw/6CHymaNNShkDaOzCkPWfze+
 jGRYDaXzKU7UcTbBtFwmNia/LsYKaUHoR5PrZdrtLCDlOUkQ3QhdUoe8l9zXR46wV4Cd
 6w7w==
X-Gm-Message-State: AOJu0Yx0BzZ87LVpHp0yC2jE7IL5jBgVGEq5COSOHO3G+7/ZJbc5bM8+
 2XWv/oAAKgBbQSYIisbp7IUTSQ2wkHVkA3JkDn63yKcSpUVccUwNnTe9lA1Wb1rjbHRORvHM5A5
 Yk4s8
X-Gm-Gg: AeBDievpafzSgUF6Z71VB88w+4WcvVpGOEIlBHPfYGfWohDE26ROQ5IiyR/BjdB79Ak
 OHMnI+vFcCcHAEGOqTBR/2OqexhEy8IQaqFksE/vAwtbEMYH10F4mux1gHxI0FT+uDqBoivAvL0
 LBE51dyb9Q52OctHfDmUacvTQiXSP/5X8TMPeyYTKuVoo2dbiQs2eaXY9gf2YqaKMc2173kzeUP
 oqfGnxWdg/ZZ/MwZHme8z9ULGIBwk+eQzgvtewRe2r1IuNih4cKfipjQQjzj0r/cyw6IiWfkj6l
 5lSZ5MiCXdSO3JVqDacV7zn5oZga6k6hj1x140GfnOTLAG67md6v+Ip8pHBayCq0DWB56feV+j6
 Qu0rVQ2sAu9mHD/6L9UGrPGL9TFdq3bZ9bDAhnzJv7fBdnMW+ANrTMfpLu+ahzA2zA9VQkN9BAx
 /W+wnxAyZY/ZqG8Ij6X7LoTY0Yo+l1vF2yIGvPQ3/rIXcT6U02F8L9Wr4sllocEBa7cEJwg5I5x
 nRY03mwrfHF6Hq3RWQjVm7i
X-Received: by 2002:a05:6a00:1887:b0:829:924c:348a with SMTP id
 d2e1a72fcca58-82f0c26b71fmr16871606b3a.45.1776123810076; 
 Mon, 13 Apr 2026 16:43:30 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4e182csm12818021b3a.45.2026.04.13.16.43.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:43:29 -0700 (PDT)
Message-ID: <a53567c7-4605-4567-baa9-d4c083fb5150@linaro.org>
Date: Tue, 14 Apr 2026 09:43:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/arm: Conceal MO_TE within mve_advance_vpt()
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/mve_helper.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)

"Hoist X into Y" better than "Conceal X within Y"?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

