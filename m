Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F93C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Vd-00063N-EL; Sun, 26 Jan 2025 08:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2VO-0005wa-U7
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:16:58 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2VL-0002fN-KP
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:16:49 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso4755142a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897406; x=1738502206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qzPvJ1K4g+mBQpkU3tq+OO+Jo2vnGUWt4HctKXPF8vg=;
 b=Jlg4KtChEvQHldXZwlCkwSqY0dCKuS45wF0nh72fDoAiG55OWigRA6KF4IsBFGozsU
 goiSncEvZOUSp/spNdGmiVl/9OOwLh/Wj4RHdYohVbXKZhb2i4vu+xkdIv+FzG1CsktX
 ky/9q5O2CUW2sL01dADrnQEICJloEyOq6IuZ6aqdSNxxQWVuBjicN/HBNLFJJeVRaVMw
 c+6G1BACadpx7bSAjCLHuKTStOafe7IGfNKhksDOospaQqzf8ADE9dYX6oghXOeOji6v
 LbViHWuo/5/4797HEY100jInnIDaOgj8XhI5XG7UZFVQIyfKG0FTO7A70JkCDyHenheJ
 nY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897406; x=1738502206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzPvJ1K4g+mBQpkU3tq+OO+Jo2vnGUWt4HctKXPF8vg=;
 b=GAvWwua1ZO7NdYRNiVizglPG2L8vHUN95D34GzZM3yEdeSEcGyU+scXkTclunx0cPC
 EvuEVzLtgoEGoHbgzHhP2BCyGifU9oyAzpNqOKGdIlrgc/92CquzCsmf534YLNxCuIpB
 qBkMz8h+N/SGXFZd/IgtkT4QlMzpJEkSIa103ceOsxF8iJIMDZzxE3NBuvstRzUUkoZ3
 WMJ5FPWy9QBa0uUuikxsxXFJJ8GR7wJyp3h4FQoFJy17BtjvkfV+DTLncyhYiK7JuhdS
 LwGM99yYzDZ8SIBWY0e8bSM1Ck4TBeJVPKSCAMYT10/Dn2UgVn4u77MqUmd65btaIXEe
 pu2w==
X-Gm-Message-State: AOJu0Ywh6zmnp0/mAt4vlzryX+M5Ad3Bl0MJ01FNyY8pSLN90haNXNzL
 n7nJhxr5ad0uEiyt3La2PMcfzOGgfXNThj/oShORfMBAfO06m7pnmr15v8LjvwPYq4VBLzhyg3L
 A
X-Gm-Gg: ASbGncsPCyvtMljJd+IWnYYRHIPb/gF50h3ALWrpidJa7rIgAAiCtZWtFUxBylnheC5
 DUsLPdiRwuGUV71XSklqGtiVT9bypaWraSWdelZf01LbUxtJ+UHO+ydHAwoY3EiN1zkbAnY53p7
 8iDj/Ix/+MpdCo9RcP8XAjVAROoiXEDtfv9wyy1K0RXeZAZTPxJDaf/u+qV99hzLfWbfCQCy5oQ
 F2Sp4YClNgKXw+/uaziW+uS2ZIQYkacn+1fL2AD8yBWJl7c3D7l0E9JMdc5PAlher0+dz4IWvCH
 osRF4BNLhqyD9q1+/s3OHj0=
X-Google-Smtp-Source: AGHT+IGno9OPWLRvfH9PHNA14ebK3v5qb+wAYoHNp7BKfktfXRvmLkkkv4+ctdVebAoKazliGA1vPA==
X-Received: by 2002:a17:90b:50c3:b0:2ee:8aa7:94a0 with SMTP id
 98e67ed59e1d1-2f782d732e0mr46782859a91.32.1737897406147; 
 Sun, 26 Jan 2025 05:16:46 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414151fsm45749785ad.121.2025.01.26.05.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:16:45 -0800 (PST)
Message-ID: <9a8bc1c9-b6b7-4748-8271-f918d5f04e1f@linaro.org>
Date: Sun, 26 Jan 2025 05:16:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 63/76] target/arm: Handle FPCR.AH in negation step in FMLS
 (indexed)
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-64-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-64-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
> Handle the FPCR.AH "don't negate the sign of a NaN" semantics in FMLS
> (indexed), by passing through FPCR.AH in the SIMD data word, for the
> helper to use to determine whether to negate.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate-sve.c | 2 +-
>   target/arm/tcg/vec_helper.c    | 9 +++++++--
>   3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

