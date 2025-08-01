Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED95FC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvhr-0002JB-Jr; Fri, 01 Aug 2025 15:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuBE-0002x7-HT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:08:32 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuBC-0002Yt-OP
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:08:32 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8da9b7386dso2761016276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071709; x=1754676509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/TZmJ2dEVYaCrGLM2XLZlWhXy5Azq86QQdBKE+rkFfI=;
 b=iYJBb3EOoeAl4eZ2TVqGi6DwnXaqdQXhcxzItO+kKaKgf3hDn2SqARdHX7Oeo4JAJe
 N3bTL9tZ2dsQ5M2KxePivXhUf1ACbEAdS/Pgghg0BH5p/z38ca7NrwMis4upxETuyl+p
 kcQc8s/2X3332rU1wltD7+bx0a5XSdjgGZ++HeWJzWZM1rAcHB3Zt82TEU4PQP8lcWI8
 oWpIf/AEFndJqBkuuIqXiuimC6Tm/2lda5ID2ddAKvYvaFcykIGb9700YvqwkWWiW6F7
 K2CrLR5TBvLhauu74J/OW2O3fRtaZP/fsov0HzYSkmbMrdT5OUTnL3quvX8QuwblFb/m
 Z/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071709; x=1754676509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TZmJ2dEVYaCrGLM2XLZlWhXy5Azq86QQdBKE+rkFfI=;
 b=ukPz5s8VMH++ZNoAE9AXppSPZTkkmj5pdjBg1F5iCv6bDIA7ZH8ajCHuLCkQkqKah6
 BJ1q2mSKr2T30+n2CcOdhdi5z+b63JyIuA7BBwNBNqbBaOnMrgpG8TyJY4w+ET+E0qmL
 /8G2j6p9GMUvHcNUnjxfM+8XGFTh4EkfMXESZ4F6JlvLyqvaJNnFrP4WiX5ymXyYbwX2
 9d2RY6vwMkqUniD2Kt3aBD92sxrbpFOtPMP4ZlZvsF23S5SDl3FYZzThOAyOdUDkJhI+
 qrTFnNPSGqA72F0pfjVbc/JAlUZ2lazQLRGdpLpnYIBTO8Yq6AdN1n/2xJtF6RgdiA6a
 fDDQ==
X-Gm-Message-State: AOJu0YyUXm88fqALvvuAU0Qv2k3lLs+5eSdM1v2AOEOXHS2atHqe8w6I
 e6I0FqawOZP8Prw8Xfg5qgD5ACwvIl/wo0krP/OrSyfo9uN9ozB/OF8mq6LnwIfENKlszGaSL33
 katiXPgIVGMYG0qnlSV/UNKFTHIDv7ZtoGqZd8p0FYbk8I4J8AI46
X-Gm-Gg: ASbGncv/oVCQyUW6dHKcjT+ziyWfWgA5vAzhcbwRdtyMsb0kAyt9/IznKTVFLFlT3Tl
 H6aRy7DzHBAyKP3TuTzruYM72TZ+MlcOf/NwGzeaW2oAEhSdBG89ImS/tqHCr+jD6Ls2l5vP8cQ
 d1jgVe2cIt32bIP72uCZzZ9hYQVoOOTOry7LV3/AHasYoj/5OpsCwKPcI7EwQF8x0/dpc8MDdKL
 UgU/uED
X-Google-Smtp-Source: AGHT+IH549WRKtr9z7rL7+mwMtH2oXB8QV5IDAUkn8qXdKH0vnmDzpQgQxg0outDNGuC2h0/tFWwxF742dcbNoNCtvw=
X-Received: by 2002:a05:690c:eca:b0:70c:ceba:16 with SMTP id
 00721157ae682-71b5a899bcamr94167807b3.17.1754071709275; Fri, 01 Aug 2025
 11:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-57-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-57-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:08:17 +0100
X-Gm-Features: Ac12FXx8Ky1GWe_aIcIUupHKa_87nFTrH4begwtrgDIWliJGOMc2FrsI83eJd6w
Message-ID: <CAFEAcA-9pBp3qo1iWq0X_rN7P7OuKJwf6e3TUOtXFS5EMDbU9Q@mail.gmail.com>
Subject: Re: [PATCH 56/89] linux-user: Move init_guest_commpage to
 arm/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 30 Jul 2025 at 01:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/target_elf.h |  4 ++++
>  linux-user/loader.h         |  2 +-
>  linux-user/arm/elfload.c    | 46 +++++++++++++++++++++++++++++++++++
>  linux-user/elfload.c        | 48 -------------------------------------
>  4 files changed, 51 insertions(+), 49 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

