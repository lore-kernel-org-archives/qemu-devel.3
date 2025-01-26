Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3A2C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Kw-0007mU-A2; Sun, 26 Jan 2025 08:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Kr-0007eg-Jn
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:05:59 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Kn-0001Y6-Ac
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:05:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21661be2c2dso60028035ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896751; x=1738501551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgQAdifYyTiiKjeQtrH2km/3nVMxS+ZeHYk88LlVShw=;
 b=hlK9FL6qlLjM5AY2kP0oxv9qAwpBqG08+TSgCpOPIj72f/C6N9Szo2rffNlR/PARLp
 IVU8eV/Cpjbhwldfe0IjzQKUKNG4lPWR1v5CS/XsFB1nUHW1wbjNRPguw7Ks2Tp48goj
 qno5P2x4sC3dEk6O9sy6n2CScB3l6d6eTeKLtWxwwdFpWj1kkK7UEA8OZQhF9SCtrepP
 DYel4fRp3LPiuHcYOCJAKFwMKbKyd0/3Sb53ZwapW0oTQ03CdDjY9VK5jXP8hX5bg2cC
 YVkmJ+ApmM46EnwNZbXU8qoRXb3Qw+bcQPwj+gA237pw4L2hfBmKmirPnkyZvIU11X3W
 aexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896751; x=1738501551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgQAdifYyTiiKjeQtrH2km/3nVMxS+ZeHYk88LlVShw=;
 b=GE0fiFkSNTuY+yEdzdi4k69OQBAEkEwtZ/yUtz+ndAY4WMQNEifQWRSf8iFFjVy24F
 0g2DunVl664T/bHucWPipPquoWTDP7gokhKmXkvh9wWaj4Y3j7OE8VbZHgQAnFzC9KdU
 mYorqFN96SNk6e8SToq220Ft7TUTp6bHM2i594NYAkSLMZqJvFHhmRD1IunMCuSq72Ja
 MpLWTwMf+jv6W+SXMibvt9NHOWpwIYEOE4fVTq+JxdD0q0sOY9nVT3kD7aTLh2da3qne
 /QYF+0oZG9tPkPkZ2OPl8Tp2Obr9vmDUTkbYfgtliOKLvkEZ6RQkT/dZ4i4avDaNzbbc
 mqTQ==
X-Gm-Message-State: AOJu0YztBfaASqWNSn2taVyqdD8EHZ2F448eXtPjyaZ90JKJLbvJ35tY
 z0aN+RaqJzNoiUioascvld9KhW61y1emEYaQ1r+taLFeDanxRjc3IbhnBTVS6A7mlc5MP0U+ShA
 z
X-Gm-Gg: ASbGncu5qFV0qU2FA+xDKizT0pai36RKDIwMG/P2CiaBhFiFBP0v0A71+x6+jtxp9xt
 TUwWEN7cY6/plznWPPuLtjyp+ptOQUK5mylnBzONJN8n+xk1SJ+zVCUn4QZzyB7XmEeVMkHLMEP
 It35/euNAu4UZX/o52DkRB6oI8wMonvi3KyLVaaB+WY/EKb1clXpDeagDZcbATJj+4/aAWhk4Wr
 fthdHqNEedwfbPqgPKaVbYBFK5Eh1laCJUd0zmIqVqmkJXf6NITzeuRdgrr0IC60VIm16HTF0dP
 bYVSWYcPT1jDXcFOXmmzZb8=
X-Google-Smtp-Source: AGHT+IG8v+qSRqUsYlDpLPfaKLQlOR5bHAEAg0mn/WnOt/5LeYBa4Sfz0z3hjXj19WWUaPoEoWr5OQ==
X-Received: by 2002:a17:902:e5ce:b0:216:6590:d472 with SMTP id
 d9443c01a7336-21c3551ae48mr587186235ad.21.1737896750693; 
 Sun, 26 Jan 2025 05:05:50 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3fa8420sm45956675ad.102.2025.01.26.05.05.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:05:49 -0800 (PST)
Message-ID: <d2c5fd92-3de6-4453-8d22-7a058982779e@linaro.org>
Date: Sun, 26 Jan 2025 05:05:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/76] target/arm: Handle FPCR.AH in SVE FABS
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-57-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-57-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Make SVE FABS honour the FPCR.AH "don't negate the sign of a NaN" semantics.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 4 ++++
>   target/arm/tcg/sve_helper.c    | 8 ++++++++
>   target/arm/tcg/translate-sve.c | 7 ++++++-
>   3 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

