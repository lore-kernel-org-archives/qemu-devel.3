Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44006CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZKc-0007Vt-PM; Fri, 19 Jun 2026 09:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZKa-0007VI-Vw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:32:25 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZKZ-00046b-JP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:32:24 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66077e888b2so2100726d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875942; cv=none;
 d=google.com; s=arc-20240605;
 b=lqVQfLxfMTAFf9fkbf6TcnTnWYgUTIQrFbW98vHVyEoTxwnUA57GAm0wvXAZLKTVIv
 7gZo6NBzDweQHj7shNl/Usfr+c8Ob5AOCfadclKdxjV60qIfvVdfbV7OcMw59UNmvZ5B
 8eh5Qa0kDgBT6P6QBYT7dzIg/fVMTWquC9RvV5icxIm2g7aYGwkcSmphkfsxgr4rWHVQ
 tY6JsFjALG/hAFGsh3jrLDib2sbCnLRlogvZAKHDl3a4huszyntrluEVjfxabE6nBNja
 4mAskMfal26xM9UWRv7FmIhGQLf+mtaVwTxz4Rn//UvFBtszOdwXGbg7nfyjzrB4zH6I
 Xvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FWx3SQsaaZvP/ihMY29sgSd20PLBhVOnHyRpXFlR+/A=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=QLqu0nV7Vw043Jgs55txnWtNzxHa+BBIcT8vA+F9Kq+A/BCp7FXyAq4YmejzJFIEW7
 4tcg2ttyEFdtASFK6b8fw0UIhGupadIGh/YlMmbiAIaq8AB/nU83LyNifVe7z260CQZe
 6yuoXFopqDLdWTeGzIOj6BxTPY/lgENxid1s4l6mZJDwkyaO+Y5cHNxZffqtxC13w4US
 VBc0KxYZccT06g/kfZo6JItDMQjdwiFs2mqT+FT8SoN6kjeUb0EHzTNh7Rrr/K1NczxG
 D0XxnOlW5qHJpQ3MJTwu1nCYtRxYxmd8Cmg03C4eperMXEeU8irm7DiHoiLJEW1PvG3x
 UPIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781875942; x=1782480742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FWx3SQsaaZvP/ihMY29sgSd20PLBhVOnHyRpXFlR+/A=;
 b=vPvjqtL+ZMDm09fJlb5035yeeoBEktTnMole2u1f8iyTmtYOGfl2ox7Ype+FxYntlR
 +U61R4NNB39OrwHvZNzCIfX+ziFvCjOBhstEVOF51zxbixqHKxallq7Y4DwixGceEPb1
 CMPaClAYPGV+mFXWJdRlJVpOVQ0BBeJ/fJ3ab8hpqVcRA90g0c4lpdjtJbg7xvm2YcZU
 WwJB/Waif4krIQojTVQulJOe8mntOdllSujODhy9ryWxK5gA9Tr/Oe8HZH5GR9bqFOlO
 XYIzM6PqSzl3Bnu5OoYpwTEisaHwQLbCxz/4JJSPO6zi45izBN+wLnNcYIBg9jod4HET
 8O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875942; x=1782480742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWx3SQsaaZvP/ihMY29sgSd20PLBhVOnHyRpXFlR+/A=;
 b=RSORaQ29nfYFUervMWV8yA9TLuUOhLpH6g4dRpRJxpjGT4SNFVc6IPqtaffgwX+8m2
 lceVHcaMhgwOddaWGPLr76p1b/ElMaxx3R2CdpmaC7ZSpKXffrpOt77h4S9zwANpREiW
 ZkBs7Y+Bx1GRS7Q7K9Y885cjj1WgsLFG19wBQIezlb4FCHJwqTZzgHN0Z0gDdfy8k2Lx
 +QP8sklkR7/JNbxRbgYOFXmwCR2C2wZ/B8o0jMGEG/1fnXdgcIvBIv8jX44yQ68bxBso
 Z8z03C/owaRwuaOb63/mRexC7GXcaDh4V+cdqMQoU6bGMEysV9Tlh3OuR3PTmitJXpsq
 PT5Q==
X-Gm-Message-State: AOJu0Yy+JyFm1F+3TA3PHtEUZCQdwDDR4tsQ/n2yqeJrbFLbowtgRh8h
 iWrp9lYY47+/CYw8MLgmUCQ3zvBVM6peanSmrju11xGm6tZqZg+kNZIT7gql08R4OScedyEzfI9
 6YAjIQTDDNE5tERXmdtji0iVyX4bwo1FfdxGPXM9X1Q==
X-Gm-Gg: AfdE7clZ6vr8TJmwV5g9J7hrKAy3h6TcwbI+bN5eI5+S71GfRPWu2VfuWSSsoRzvMpq
 mIpdH80Xquy7tuXrqLNuvZwFu0bqmtx1pX9fZBjXlsYMlbypiXsSmAIM3K8hI+kMqWsHdBqX739
 65Jwp/7KaSHmOlbEEhkSQ6OuIiw3CpexjtPtnyjXQzjU6PwqWL1Eundr/UTmOtRORgu8AJ0yXBT
 4QBnq9s8qhzA1SxA/xaIh6LtY8FmegpECgTAZ7Evg75ZPPIiH4h0QgI/7rIg8q/Kx0A1JYWZQpG
 9dqdVKgqY2aJwaAB5uNxbiBNcsitQ1h0LT4eSazQYNDkeuVgUk4MN5yF
X-Received: by 2002:a05:690e:4894:10b0:662:551d:b987 with SMTP id
 956f58d0204a3-66302ef7ff2mr1562872d50.12.1781875942348; Fri, 19 Jun 2026
 06:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-5-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:32:11 +0100
X-Gm-Features: AVVi8CegvYBPu03QvBx4q7dcEq-0y1AGq_DMN-DlK2wQpyhem-MDEkYtWquuGBk
Message-ID: <CAFEAcA9Rs4HJruPbDqQBaW3-=JLsAdf1TJGjcCse3QVfv5f4Fg@mail.gmail.com>
Subject: Re: [PATCH 04/10] target/arm: Implement FMLALL (multiple vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 1 +
>  target/arm/tcg/sme.decode      | 3 +++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

