Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C55F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVo5-000825-RU; Thu, 16 Apr 2026 19:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVo3-00081x-3m
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:07:31 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVnz-0005uY-UY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:07:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso25989a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776380846; x=1776985646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYezGaLfKIsjTRMYKShj9GRcmD/igR3F5YkF1vZXRRk=;
 b=MnjYbu4F6UId6J+iR/lt4UbHVEgTIrx6FeUEakxOuh1kXhw6kgMq/yMT33vbA+B4qr
 IfIYX+PPxRbSYXLttysEMoX7Ai5MM5WXmhiDgxBgWDNIjm1fN7Kfo/2Q8WufgW6HGqhu
 R6VLJAkxv4NPLbLgerT954FgBWnjbbXMKK/FZN1LnqTfbMCog3ESyXGiUIdv/xqOddY0
 U5iFkjp2OapwFll2H6wjk3gwlkKUbhtYIvQuxm+5iX8d54aqGHU7x1WFbnKVEFpU4Ze2
 XqQFqpYX1XObp/DkzI4dXPm8j4ndtrteKGbptKePOUt6tlzAg5IxRNX5pw0kpVu0DAaH
 Iz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380846; x=1776985646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PYezGaLfKIsjTRMYKShj9GRcmD/igR3F5YkF1vZXRRk=;
 b=V7xAhY8VlSnIBBAS+iUcRVtUhLHzVtoS6tAK4RV7vO/Gj9Hy09ggV1xgAvJp1ElciH
 f8yb8J7FeD6YElBbWQp8hpDkUMUTNU0r3X0BbsVI3ksU1iINPblGmHXbI6M+zGzaUDre
 Dxs4picWoZQUhxkPWl7xAqVS505XKM9y9XOvzsmzNHj61OU+dTC4zMiWYJpAhmws71/R
 T6KWASrNdFG69pB9w2YErbemsyZwDxkdpbUvqNSzFWbA8yFe0oOmCnJ8XPiU2J2P9eV9
 Gp/ZtucJy6PudFkbGJqnC2+otXs5d0gO3HvgwGhQTbh9jgiz3K/VnlqBTE9Nt+e/yfO4
 +fRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MIJxYKIXCbfVkm9+azBttsB8bJ/X7O5OuFM8ULYzPR11Oj0ttTGNsfxm0sBoW1dAamsjQk/wO7xtk@nongnu.org
X-Gm-Message-State: AOJu0YxfWOYxLB4zrGRRYV/5kbgeCC/VzLTi9E0nMMb1XZ1Bjpu8zkF4
 ZHgCM44p1MkfuvRsLJsXN1DaH7pJumQEhtatChoTNrqqM21rrXqWAXFopL1TxmlfhRA=
X-Gm-Gg: AeBDieu4W+O8QeU/V+JcS20NoZ/SvdiZDxUhQ5YA1Z+9TD7O3mAgpp2T5mKNVYa0z6I
 B5xT3si1ZlWNq8elnKU8M6Fk1Y4kQReOF5CP81pBm41T2+/SZet8uRPR3XufFzhzn/q0offd80K
 j8MEAKOz2U9SCZoPfQyBn3F7Giu9f7Y/9F0/BeKFWptQyage7Wl2Kp/FAA3arV92lDC86Ogy9LU
 17fb/ESHbKRS56kwBg6OgNipJz8bxzbRoeR4Hpehc7i4eMmS4QVrmB0+SUO1TgJd8TBEfQ+yME0
 h84RmWIUqNEIWjbJ6JBsdc7Nqkp5cUn6fhVCA+FQHdjUOcTimVstHMt/my9/BMiFv0QfjybHvk1
 NoniNBwc0qF6nk6OZUL4QQykvOkWP6zQ3DnMG4hzPtqMe61rblNMf42tZAABKLObMs3O61VMyYK
 plWPfkWShYOOAZQfw64T9/mScOGQKtLiwqQtA2nTTgVJUr3uMALXEbb9hrQGbsFjhtNvoVrFkS2
 qeTi5Mmy07wcC+Bo4X5fhZNn4tffysxLAJgk7OHKJHY5c2aFbmQVeoWkkk+6KCbZA==
X-Received: by 2002:a17:902:7248:b0:2b4:696b:7bb7 with SMTP id
 d9443c01a7336-2b5f9e9a539mr2285925ad.15.1776380846336; 
 Thu, 16 Apr 2026 16:07:26 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa59dda1sm645585ad.58.2026.04.16.16.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:07:25 -0700 (PDT)
Message-ID: <bcbfb47e-022b-4db5-90d9-a91599ed227f@linaro.org>
Date: Fri, 17 Apr 2026 09:07:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210508.30686-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
> Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
> Pass the MemOp alignment as argument to gen_ldst_multiple(). Keep
> using MO_UNALN for REL6 decoder but use MO_ALIGN for the pre-REL6
> part.
> 
> Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
> Reported-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/micromips_translate.c.inc | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

