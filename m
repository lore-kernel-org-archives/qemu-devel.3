Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACD4CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNJ1-0003Ws-Sc; Tue, 19 Aug 2025 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNIz-0003Vk-Mf
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:27:17 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNIx-0006Nr-TL
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:27:17 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afcb7a8dd3dso767795866b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755613634; x=1756218434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSEXM8ZbKt1R2tJtnXUPHtvMNKrzzhB7HXitJCJGjUo=;
 b=fIUIxQn85pSsqTgQrFXamxmis7ygCjs6XMkRCNSfmwT46iJ+BwUH7YEIi3T6YZjFw0
 USHtIS1fE6YmxsfuI16jZNh8SP0cvn8w2AaHw1MJlARZMuhnk78MSSQJgYePs2kgJOx5
 fGbfMWGmRDNL1vy7Y7n4YTk5I2+TZTtmZx1z/AnVY+EgmO9OPWTZQC2t8xOSIstGGxuP
 r7vjVzIUkW7QuuRp2BCl+WCbIfbh49cizxnOdGjLV5GdC3Zw7qCqb0JcbvLvkfz59x+I
 E38jZuPhN2yr2il2Qr1ka2gN5Tl91SyWwDweHP2/FkAwjvOoiCasARMx47BPb5aKyz9W
 ZYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755613634; x=1756218434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSEXM8ZbKt1R2tJtnXUPHtvMNKrzzhB7HXitJCJGjUo=;
 b=JQyB+0mEgUSAhRMmGpPTA0APIzcB25cryH4Kuj1ZFi7jzSqx7F7RpuM+Sophevcwmg
 RzE/jsPVgw0yi106waaHMND9K+F+86NIlMmjHjWT8GS7dxTEf5HQAMjfUASjSMy+o/39
 WPjy2i2fM5/NUCN7byqn0q1qvhAGYXW3tfRsD1OsuJH+bPbp4QG57DHbW0V9g7fxNanl
 prl7LicaqxBuEb9/U+3kv2axbOzyvVqhzM3oAXts4C5hP6VJe/k2+60HOsM7Hoa2y7ZO
 4LF2aGQFVHYgZBTiHZmuucKfFousMzgWKYwW0JwTiBQnCHhdOBLw/W7panPwhJurwrUX
 d1wg==
X-Gm-Message-State: AOJu0YxC+xfHVefnpdKavVEfXJNu2Je5p757gnoLeEmQmfPm4g5efVxb
 XVl4Xg8L0mqlnchc0oHfHpLVnIRzwGf7VAy+Tu3qE+5s4DzHA5sQauRr08U3GcKvHipv5/0vnE4
 C8ddD6/xy+bsNV9fqgIskVMgLR8YQynS0+cUB3Og38g==
X-Gm-Gg: ASbGncslqIFDOIFkfjtRDV2GLLqVYFNiZBeVXF1sgLvWKqTYSNY30aBoTD3gSl18HJq
 4qBXfhdBLx2UYYHOcizrCz2lOsKmUdd3psrpkeUW/PSWFD1YeVXUbmfIwSbEZhfW2kI569dOlL3
 B245huyC+KszTVXUpPAhFAWqEJ7nwXzjIOFWaGOr6GQmmn6Yp3KTLXMYvwXyAs/OtRgolLKthyd
 XGwbqLxd+yCCdlBlzg=
X-Google-Smtp-Source: AGHT+IGcrvfXtDw9gvPvlpQ8mzrobWpXWOQVUNCpFUm1oTv3xBL+y0kFpUpGbTCZVALAtg+Pbtnk5CSqLAPI+yy3lYE=
X-Received: by 2002:a17:906:478f:b0:afc:f12b:8a85 with SMTP id
 a640c23a62f3a-afddd0d2971mr241353566b.34.1755613633653; Tue, 19 Aug 2025
 07:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-6-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:27:01 +0100
X-Gm-Features: Ac12FXyJDgJfWnYYrq7zEMYnRPq4mtG-3HsMQPnf3NK_3Eb_-9AnzCNU6_LIBYY
Message-ID: <CAFEAcA-xteF32z0Y-B0-8hJGFFHAHSOEu9Ky=-degYVuAggmPg@mail.gmail.com>
Subject: Re: [PATCH 5/7] target/arm: Rename isar_feature_aa64_atomics
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Fri, 15 Aug 2025 at 13:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is FEAT_LSE -- rename the predicate to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  2 +-
>  linux-user/elfload.c           |  2 +-
>  target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 5876162428..e3d4c3d382 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -406,7 +406,7 @@ static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, CRC32) != 0;
>  }
>
> -static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
> +static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
>  {
>      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) != 0;
>  }

The Arm ARM says that FEAT_LSE is for ATOMIC >= 2.
Older versions of the Arm ARM also say that the old name
ARMv8.1-Atomics was for >= 2, though, so this is something
we've always got wrong.

I just checked and all the CPUs we define do correctly set
the ATOMIC field to either 0 or 2 and not the reserved value
1, so we can add another patch that corrects this feature
function to do the correct check.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

