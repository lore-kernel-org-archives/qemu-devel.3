Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE6FC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokWO-0007UK-DL; Tue, 28 Jul 2026 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokWM-0007Tb-OU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:19:10 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokWL-0001eZ-D3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:19:10 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66843304cbaso6185063d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255548; cv=none;
 d=google.com; s=arc-20260327;
 b=jTVgJJwWqeFaA62LaLn9kRjv7C38n3PEewCKUDazTaguvq1RFeFPiTTYw5X1kmU2vk
 IvERoptwd82zYbpJCeXScB22nCjyWFIPngCgHQ1Gc8hydoPBaYqOZ+Kn7GpiCGiLG7uF
 oqtuziJT5eqOgpLq4NRO1IJyDNFzRK/91pC/gITlueFBw8nbZ08/mRzeK5Y1HiaUvMOz
 miA52iBz4jLoN7vJw/AXtfb6CUDwwsmZV/KA/jx5a01z4renJYHBOmeEP8XtAoyMbfcN
 CosPBwDJgUwa8Y3CQuWRE9bf/IH2600BjoJOvRR4qsgBwKUQgR4OhX2HvMuJbeyEzEdG
 3P7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fHk/7TC3HZl9S/mZJw1oYBpSSU1S9w5VOIz67VDbGw8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=QsGq0Uz8yrVEhOdb7tPtaH35xvoA+xpW5FinE7XGD0y6zQdBkGeMZjwnmrw96zu4VT
 KFrXU9eJUe4DsH966FMZLxLDatmdbvnA/RR+QzFagmOgggBZfAnoLxpEI7fkp7iWAA1Q
 d/hhcI0g3d1YlEQFTGC0R7hppC7xC7Lbf72JIkeOI9rYEZfZcbGFX5ETx39fqk2neAEn
 O/66/uIY+OmSCGJWr39uanST4qlToJZo+BUVlkSBuvGl/qmHj8TDdXPBEgd8k+h6uaDV
 IhB7hKMn+fF89dHaCYNzKZS4k5B6DjPoD2CQt5KuCrJKJNtUvgRb9oxYIaCwudvBJLA8
 azag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785255548; x=1785860348; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fHk/7TC3HZl9S/mZJw1oYBpSSU1S9w5VOIz67VDbGw8=;
 b=E/lwNGc67m1IJlNCtcX2LIr02Uwfs8PVIvR0HcwZfuxsDE9Nizy8WOaINjbjQSwFsw
 p6d4Ce9j+Z8/ODfyH9790mE0SsGjJbTu4eXYRKEhI5nqZBdXgTWjd5bxWGEPFlt3XQ/0
 fiygB5Gj67r1kDzMTl9qaqwS5Ktl4sVZqQomB230jAKs446qMxY/c7Xd23P/jK2vY+e5
 H+EKticJLzRfVAMVBb+be2cHC4ajZyPJ6kKOmrCzy/UAKMaeln+IUbDjpTWTbK4HYNWr
 Jw+nqlo6G/oEg/M15OJwLxvxp1KyOPYuw0k6wAhtoY1kCfFM4wSCJhg695HlUV8+8sNw
 5TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255548; x=1785860348;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fHk/7TC3HZl9S/mZJw1oYBpSSU1S9w5VOIz67VDbGw8=;
 b=qe4MW/1t8RIz+2DiDSaODe0g3jv/i0jh+aef1WmzI09DTnsRnPx20DJTy3h1gN09lT
 4pdxB4A5LlfdR75/5ugh0Y1Me3LWdgZgHdjhETLeJlEs90MFJwcq1Pnsbvg3F9pjJNwY
 SDSkCI14tXtoAxmIBJOMfUTw/wPcolpVV0L+TCGkxz6fpnqWWHeE7Ykx3O0JuYCLFBPM
 E84fF5EglNTdP0Nw+AnWYv3MNe1cWV0fYnAP6E95b16ZZ5hSHme/XdVjHjm1+n/HOu1f
 uzxZETZr8O5x2VUPcd5bzgE8mxDg3C4CVJCGejpbUR8XUPAZPtSk9Nx+QSVkaLFEHTrj
 Z2iw==
X-Gm-Message-State: AOJu0Yxsx0kVb2h/7Zdnj3YNpTXV6SwAwEjRBIzI96i3zDkIPMrBbuQA
 n1aYXzj7jwyaEdNbhRzdsPD6vpMBVHGkR5E4nC04inB3tnYPAqoNP3HBmKLTDdJaljXrkWkCcU7
 ENBblVhhm4yhvh2DH0wLT65lUMwVmvLXne5SrC1DBl3s+D8ZIXKHA
X-Gm-Gg: AR+sD11+2AwWfdpB0Vr3ofkNgFC1M6XJfItFAiPrNjjRZwB2rFcs7NANhs6dLdODL2B
 bLbkvTZRdvmwMMeFvlrYnJ/Ec6OCWmE9zPCf/0BOrwPMcEXXXSvY/6n05i0dNRCLOEeNt/qVU1S
 Lc9M/NPYOMIKt4qxR53sP3Fsl9hV8CAy1jG7tRHPougeiw8UxxdwW/dr/CJ2Xd1HeNkNVKh0xFI
 1bijw/2EhnuDN5mHWex0pJYsv7STb9wIaUek5jdgPvx3y8+JNK5Z48ImBQaneY67zkzcy2i9eu0
 bOdacCedKmtUjH2XU6lN5zhZYHzbWx1YtGecOvfxTFs6jA==
X-Received: by 2002:a05:690e:4402:b0:664:ef34:44 with SMTP id
 956f58d0204a3-66905828477mr679502d50.77.1785255548203; Tue, 28 Jul 2026
 09:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-17-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:18:55 +0100
X-Gm-Features: AUfX_mxnLjyroR6gMg_ZLt7B4SCY-3UgzLrhxbDEqv--JB1xvBDg4AryHbf0QxE
Message-ID: <CAFEAcA-wpd0CeUSSko2NSb8W5DUR6VNODv+0AVV4E847_HCu6Q@mail.gmail.com>
Subject: Re: [PATCH 16/20] target/arm: Implement AESD (indexed)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-defs.h   |  1 +
>  target/arm/tcg/crypto_helper.c | 47 +++++++++++++++++++++++++---------
>  target/arm/tcg/translate-sve.c |  2 ++
>  target/arm/tcg/sve.decode      |  3 +++
>  4 files changed, 41 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

