Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229DC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohb1-00081m-Nf; Tue, 28 Jul 2026 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohaz-0007tQ-Db
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:11:45 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohay-00024q-2U
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:11:45 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66892c81725so4353831d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244303; cv=none;
 d=google.com; s=arc-20260327;
 b=nzaJrxXXOnn0pAmba5p5EV/pgSLuFJp0rj7S2keXsi7/xcK1ECqBdYsElIs2Dw8rmf
 EoPAe3Cv/Su2FYVa+/+eIcoiPYfJTsulgHL5Gouh5FPgBi8Wklob8l3F4ZamngarSifT
 Nbz8iFqn9gmw+SJFMsFXGqxa5mX7JqXEXb3K1o+Ui7dIG7IxHcKlYH+wFSquF8Zs/wJQ
 PBbUd+t5B366w5MTX158hLfow570gUH/4iRD18Oichwob32rM+Dy8VhDn7aNWFT+TOxt
 VbHUdlgiwj8QBnREnRSDAI7Vun3HsbL2M23EPAgUWPckX3NtsdJwV+qm5sHro9vQikpA
 lLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a6jqDiSXmZ0oLtZlh//8RGxMxFKhK2e6v8igUwMmNvQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=S1mRoHsZbpOZE6jST+/m+2BRqg37NpEixFzD1OwgFZ+q1KYHp+X6MlND1D+fcXdMTP
 FqGFTOYCupdrBJ+3hAysLf20rY2Ntnf7YJv/ks2z+Dj57qg7hnyg3/OIdpvGsPPTXqCE
 OX6pWElvzsUTu0+kOkf7W3Rjdqb9Y2/KEP5Pwn7cnYnjREuAY/Mq8YZi2jvuxiMm5ziR
 UZTLMhYnqGVZ4iCnz3C/MVRdMY+g5teU6oy+LhvvOrirrXC5WsZrgWP5OtTtTwxGVuj4
 pgpUicY3qVOakYk3Xt8WFTL9KFBe60lkEtgVfIu/EYw+ccC+2VNhVaUWCD4ZeNIuR3bT
 toeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244303; x=1785849103; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a6jqDiSXmZ0oLtZlh//8RGxMxFKhK2e6v8igUwMmNvQ=;
 b=EawQFhX2xeaHwFEmLKaPNxcvPdtoQKP3+NVkRMIOWRMoMnr7/sTDuqJHZ352y/rvDn
 24T2SMgN/Q4PBwfYnaYDV6wSm8UzR4yt3fc3EbLIHUS/y9N+0AQzds//tsQPkROdQ3bR
 zolW0+ujtcr0Dz5ZPj8nlpLka2O81esg5aHNZPdUPiHpcusCZmcWbp6nzpGffAcnLykQ
 gtzcEy8VwKS/dkGEqIIVgDecckWDE29Aab1ERqeayq7ScO4aYCjdbavIulgx7zt01S8O
 um1h6qw/7KDhxtwQtgp8r83rvzuZSsg8KDW0vrWUy3YBiRnKZ1lSR8Ne9j5E4AvRP0Qc
 B2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244303; x=1785849103;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a6jqDiSXmZ0oLtZlh//8RGxMxFKhK2e6v8igUwMmNvQ=;
 b=rmER3R/ULcn3Qpe5O4jm1eUOdNQdrIMWoFu7thhnSs7hn/7nDrtGgIj+s5NlDru9OU
 ovu5CdXUdHPLo2vWhF8BHHYoNbys1+sJv3PdFCR7K0KGWwSMPMhQS+912iXJHhYc/9eM
 Uu12OaKNQIlM1TGa6lUxOzvqyVR5pGP450dgApRiP8ITOLY37J4WynsO6KuVsrdzDfzS
 By0qKEcaH9Octv7aABfk4H/uHoZ9pe0ixSgBfqFhqnKmv6UanXtQdRvR2yd9no3GrUy9
 P2bnjPXFboGxHQOYi/cMovAIR/C7VEz7YFLkmkyUUJWYpH/jtz47XE4S7N6Fho0biOlr
 2FLg==
X-Gm-Message-State: AOJu0YwgxXH6qZLsewfwzdki3xSLCcSlB6QX7K+goJQrDUEdFD5AHjdl
 mhbEK+5WKKMZQ/9B3+4GIoPHjNzm/xQ3xTAUVXKIXMu36N/tregldSuGvgVYfF97XG6v2yV3xVi
 caagFgCJDOYEvgsB7XncF7p8MfOBnnyjfPG+DMYqfaw==
X-Gm-Gg: AR+sD116fZlTNjVPWSSqd9BN0wdBtkPFSVP88mOah8xZddeKtpFlgGkoXkz7VxlPnaA
 gucNhpeKRw16gU0I7BVmmUzUcY/j+kh1ozvcfTKfxjezksSc83zwwar5DqERuy4hRoZYhZf9Ebc
 Vm+HkkYxSugUtcuYMq5bnhkkYs7m9tAv35QtgqtF9iehYht8vQdvhniEUOC+n3ox6xTIMHMS593
 NNT6Kg+z1ZW50UB2N8CpHgI1W3AekUG9JvDWvFyf4WtzbyHWnrgqPGiorCMLa6eBeu6EEDd+6wx
 KMWdFAqN3C8JrQ9Q4OQJXE3QRe9719CwkVE0F9+Z4GdGho7X0A73AueL
X-Received: by 2002:a05:690e:bcb:b0:664:dbd0:23b7 with SMTP id
 956f58d0204a3-6690545d1acmr846325d50.9.1785244302959; Tue, 28 Jul 2026
 06:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-6-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:11:31 +0100
X-Gm-Features: AUfX_mxxFkOIC6MZsjDIOA0CziM0GzD6jxojUbakNuYSWRe_PX7rIYTK2N5KPs4
Message-ID: <CAFEAcA-j_RnMrL0KfDiu3Qh2aB3nMxSQHQcFc79GetzLJXRntA@mail.gmail.com>
Subject: Re: [PATCH 05/10] target/arm: Implement FTMOPA (widening, 2-way, FP16
 to FP32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 14 Jul 2026 at 00:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme-defs.h | 1 +
>  target/arm/tcg/sme_helper.c      | 6 ++++++
>  target/arm/tcg/translate-sme.c   | 2 ++
>  target/arm/tcg/sme.decode        | 1 +
>  4 files changed, 10 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

