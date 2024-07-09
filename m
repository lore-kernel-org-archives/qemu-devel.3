Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0856C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBil-00083l-C7; Tue, 09 Jul 2024 10:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBij-0007zw-Ds
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBiW-0001ko-6z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:29 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6b3so2819658a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534874; x=1721139674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JqKHucI2Jyi7c0em15pkqGeMYcE3Z5p3FPgBx0iS8hY=;
 b=jMjhDP8DS25ZW9Zzf8+TqnDkgIODMUkymZgon4FfwY3dwgyxGVqcExskCh82Yl6Zqs
 wEfe/flfgcz2cyxKj9UXKIbS6rrjGI42JUE3pwUhyslNENUSZ4yFjXNSzA/cOQPz9nmd
 2VVXLxqFP+6ZgfQG4NImV3JQyEEDGMTWtqU3B3evaUSFZlAzEHYhLEo1MS2rHH9RhCzQ
 4sDwUkJHlCaRIjA2QjOycoS8l+2Fj/Q/j3t7IW56JOzPCqTvjyab8anyeRPlcv+a3ecr
 n0xzRGCcpyYWS4cnbhYQdnJIH0R9VZiQUFNKkJeokuk+u4vcD/s5FrutBtdzzdxtc1+j
 S+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534874; x=1721139674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JqKHucI2Jyi7c0em15pkqGeMYcE3Z5p3FPgBx0iS8hY=;
 b=qb2Uy5E7fsqK6iMEkr0FFjaF+A4tvuxWo0O927x4gkpcFwONAhjgL9cZw5gxAWcxUS
 0/Clrmx/dN0lk5+sr0BBhND16De2WCMD49lzPIoENez664mEykCeE6/e+ocMQbb/w+CS
 xwciirG88TmtSo4TyErlenfvXP9HJ0/jYeWNhJ2mjqVAMU5kGTFXZttfIFtwvoT7412R
 3QkYqREIU1JquLBQAOnfdjfXLoI5tyKxtaRLly2xkRQ2jVvXe6+ybxIwdxLPd9/2eHDR
 5K69eweQesmaTUbRKEA8ji1NC2TKFN1e/DJjMselgd5ej7Kxg+EJkYwrXuXXom89tpwj
 c5qA==
X-Gm-Message-State: AOJu0YyomozMxCt0jLiU0/PdayaHS9eovwcAS7XbDGR4v2GrFXo5Gv52
 PnK0XfoJpG12eEICgGFzC1qm9Ybc9UhU/d2zG+WIipRE40c8DHxyMt8tX5DqJvSdUKWfGs23YlJ
 g4jdc55Yt9e1iOHTU8VNd1hU8mouwA+fCXpLsRHLJ+yqCx8Tf
X-Google-Smtp-Source: AGHT+IG/+QMfnNaCWG7J18hcuYsfUtVZJStRxBWeCHI+NLKmAtehhme4XA8kQQWaGosMl6ovqHuuHrLKHrS3FViqHiI=
X-Received: by 2002:a05:6402:13c7:b0:57d:4f47:d9f7 with SMTP id
 4fb4d7f45d1cf-594b7e7d0f0mr2623777a12.0.1720534874553; Tue, 09 Jul 2024
 07:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-3-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:21:02 +0100
Message-ID: <CAFEAcA9807by+dye=pEXfpzDdtjK0RgF0FBLuaTOx5+iY5QFNQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Convert SADDL, SSUBL, SABDL, SABAL, and
 unsigned to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 9 Jul 2024 at 01:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 150 +++++++++++++++++----------------
>  target/arm/tcg/a64.decode      |   9 ++
>  2 files changed, 87 insertions(+), 72 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

