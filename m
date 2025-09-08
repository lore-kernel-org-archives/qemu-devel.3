Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA153CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvd2v-00066C-UO; Mon, 08 Sep 2025 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvd2m-00064r-Nf
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:40:33 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvd2d-0003x4-2d
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:40:32 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d60150590so34936737b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757342414; x=1757947214; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ie34N3VBwqrFPbD6ojvoILKtO0smHKsr9OKY9vnHdMo=;
 b=YZtfefGjSLuStpyeKvUgnbfnh7IBXWPi1KHU52udca6UUBz3EAbUIRUHmoyiHu9jnM
 ZKx6k7jVdHLtkDhxu4lrB2scwIjb6tj2SPVTpXcDW3NdcG7bO/gk1iIwxszqVVjfHl+A
 OF+1Hq4GG9d+1qItvZnAUFER7eqXLIdPjtI7z9emijWZPGLzWTfdxVIRQ1kOtRAftmEF
 dJvwv8sy/G7OJoD2pmLg9eKfYKBerSRAb72cYGU6rdP2XwgbB8opDsXwyC13mSJZqLDB
 VG2LnN9+7tW8fT8U+bKI/aM4rnD06mbIPG4hDyrqxRCODKOxTjRhHC8iVUupGK1SfqSt
 XDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757342414; x=1757947214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ie34N3VBwqrFPbD6ojvoILKtO0smHKsr9OKY9vnHdMo=;
 b=qef/qOj+81ljhmpGjmQNfHDMSN8SXufXb14pPMeQmbKE7ty+YSXUOvF8Q6lKoVSXXL
 lP+Fj2jIDvMjWCm4LEdF+R9cMx+W6+UGUdNGGuDBHp3SBbJAzbs20anMF2m2x8q+IPGR
 3HbTpYee0tPdcRMiOTisH8EI3psMhZJucP7da1tqPq40oFNTO0a+8G7/a60kHPTeHHxj
 T0dQtNmDbVMXLiEzagneLWTmWoAyCziPgGbYegZcZYeIngfInhSGk6nmIZEtwUCLL+dv
 SPKK1IdeWaf4jVYuudxCKTqjHvQCT1wCd7MpekHVhW4jGlTD4guHzoOZO5UTOG9kUU+r
 dudw==
X-Gm-Message-State: AOJu0Yzh8XL/Yf8RCArpos5lCPMiyseFS4IOjpEwn2j4K7uQdfQLph83
 znjBcMb9Vo4XKtuv6zLeLCVhwU5byzwqhI8hNwuwSH2qVcyHJ7CV4ETiYGiNvDb/FOnJeB1Irvs
 +wNZKPG7xrJONLkQzXBleTqR0pi1VjKrZ3AJs53JfUQ==
X-Gm-Gg: ASbGnctXuodpvZjeBdGATTKDyeIdb4/gCzjO5ndN8WZ4sKKDVIX8ksQWjhuO2r2zhV1
 D3x7wlPqtau1B4DRULZ7Hln1Sy0xCPAGrvdawOtT1QVX+lGytaTKZqVM5Th0+9xS6N6FUXziI8p
 XhhdnjGZo8SW8NYAvgGCInQei2oYbUqEqxu8oub3+kW68UShv9nV8VFTT6cWSCDVBRyMT7Uh+GF
 VVvaXX3zBzUgI/rE+Y=
X-Google-Smtp-Source: AGHT+IHhsjuNPyIzKMUeNxY5Mwm+esAXfiuk2vgektFdvaaf7I657hIB3fs6YRjKz2bWk7obYFxGkDBmm3Q6PDNxfWA=
X-Received: by 2002:a05:690c:e1a:b0:721:1649:b070 with SMTP id
 00721157ae682-727f5648a22mr68472707b3.44.1757342413782; Mon, 08 Sep 2025
 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-22-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 15:40:01 +0100
X-Gm-Features: Ac12FXwwgwtZix-bigiwbIAlrULrTLg8Zc_nYKMGaTuwQu8P8XfMxdwGH5aikIE
Message-ID: <CAFEAcA_irevvN4jAtU9w2bXvEbcQ2gT2XcRGjYpP00QbgX5YcQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/84] target/arm: Do not migrate env->exception
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 30 Aug 2025 at 16:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are not architectural state, only placeholders
> between identifying the exception and delivering it.

Yes, but is it definitely guaranteed that QEMU will never
do a migration or a record-and-replay record of the cpu
state between identifying the exception and actually
delivering it ?

I note that we do migrate CPUState::exception_index
(added in commit 6c3bff0ed8) which in theory would also
be in this "non architectural state that we consume
immediately" category: so presumably there is some
situation where we might save out the state after
we figure out that we need to raise an exception but
before we call the target's do_interrupt hook.

-- PMM

