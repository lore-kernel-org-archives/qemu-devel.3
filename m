Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417D0C5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQ16-0005iA-PC; Fri, 21 Aug 2026 10:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQ15-0005hS-Fk
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:14:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQ14-0001Yn-2a
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:14:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2caf228a910so8325455ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787321680; x=1787926480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=poYKYsb+mY1xFgLOxBjJjxbz7+kn4OoCX0mfleD+IxE=;
 b=FF+G4f04i5otpzulfdXo8XFuv9CnkO+J8n1DBChMH3tor0C14aWKfpc7duFH9bJ42w
 osTwADaGt23GtLWP3kJsCMDfgKaX5P1TzgacpdduUgVTNAkWcpG7SYnevV/eAS2JgbvO
 Na10xNxcDNgOc8KIGZ3qthVB4yzxA8Uy+zeJp4+6Y7BN/vIoLUdaZro4ACbBq+d8OolO
 GRMRBti2Pa6ZvhUuFF1uY6AeYrBkmMPQZf1yf3GPPoGBQjZkkiS+f4WWPPT9XFbb5J1D
 MtktqOuKpLjxuNcYjMI7rvy4y+T0OMzh3uJcr56aE7ni9kohOC1k0VBSuKkgKkbHZHIN
 vRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321680; x=1787926480;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=poYKYsb+mY1xFgLOxBjJjxbz7+kn4OoCX0mfleD+IxE=;
 b=eWSLpEsTL5uICRIunBn6CRXGCC6cPmX5ZSMwaOcGR4I5/qRQQDTfTixZIL40SEOJlX
 2AytdcE5zFPQk8mUKUj6lL4D0h4WQs0W93g/WaMWQeEFaj3DdOzdzndSbnLF2e8b4iFE
 4HD8RHSJSUPkv1VP0I0oeoSnEzGsPCwz+7DNCQGGZ2Igr96AbMpIIqOyCe0HrKbPKGmH
 4eg5Qz/1IpNUjjdYbcj5k4/IwoktynVbHgtNeMWf6juqU6I8Kznq52kym0Utwj1GzlMw
 17GhBCaZfdsJew495O9unRhJqjqMr64bOpzYuJkUmBw+t9UUFj55e7HhYjK5BkP4b9CS
 YpaQ==
X-Gm-Message-State: AFuF++mKqE/JEAIxh2q7FLI5io/AcYw+QTCtjwaLset+UusJQf2BFPWb
 m5zYmLHFCXaU1nkuXtcurGZQPeEaxbILRCnkwRfOxBHmv4uVQbRzJgpqFYiOcopXcGwIZ3gaXl+
 lE0vE
X-Gm-Gg: AR+sD12N4DmO0TLWUmjQyON7SRjIYm3UEnna3F0ngXF/aJeqveQeV9Dtqz2fkIxVb25
 YZcl1KA8jBBAZLhkyaKP1u0cpCbF7ahC7UtQpYVhJMXkQcJbu0TpTvnQekIKUPo1qdXXpIq3HFS
 hVmVzJ2EwOKjkK5wMwAaa/sqnR+IaBs8+kv8uAAy2BEyiV3PdHwcPikqza4stXd3kM9+T9FL676
 frQE1ki1a/fzwSSnJdtJmfWK+efE+HmgdQqTrOTAv3B3SGbU62up7SgKjoTkYAENeJ1we3nm7tT
 USoCAt7KaCwIEp1KscabBHdVsLXZvvx1LmEIKzlI4BNDkAgYqehSXp5qUy83hIQNWtQTXwvVcbt
 J1kA3LSRko/5uZgtayphu/Rs3FXLbsVpbfmo/9e0nwsxJRLa/939QwDHpdDD+MF8Is5ut/kdsVg
 78hkwE6scbs7+m0dun6cTuPiu7rf8U+3f+ToF6oN+pAqrfYTiB9t8RaCScnrbkL0orKau90gRMa
 zui
X-Received: by 2002:a17:902:fdb0:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2d64b0b5652mr147404865ad.14.1787321680126; 
 Fri, 21 Aug 2026 07:14:40 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d58a897sm19753475ad.27.2026.08.21.07.14.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:14:39 -0700 (PDT)
Message-ID: <a84cfe03-f09d-462a-86b0-162ed2a1fb3f@linaro.org>
Date: Fri, 21 Aug 2026 07:14:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Make CBZ/CBNZ UNDEF before v6T2
To: qemu-devel@nongnu.org
References: <20260821132550.168896-1-peter.maydell@linaro.org>
 <20260821132550.168896-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821132550.168896-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/21/26 06:25, Peter Maydell wrote:
> The Thumb CBZ/CBNZ encodings are only introduced in v6T2 (for
> A-profile) and v7M (for M-profile).  We missed out the feature-check
> in trans_CBZ(), so don't UNDEF on v5T or v6M.  Add the missing check:
> conveniently, the ARM_FEATURE_THUMB2 feature is true for exactly the
> cases where CBZ is implemented.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 9ee6e8bb853bde ("ARMv7 support.")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

