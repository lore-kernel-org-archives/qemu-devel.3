Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C57C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6CA-0002tV-30; Fri, 26 Jun 2026 09:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6BP-0002TN-NP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:01:37 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6BN-0001hH-0w
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:01:22 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66481f17a4cso962701d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478871; cv=none;
 d=google.com; s=arc-20260327;
 b=PNSyihhX6yA7+WYNF5O/z23RDLnexwzvKA5e+kxmLnSxTzoHlZCK5t89YT73+I11O8
 jE1GdXJM7GPGWHsIG04O/HbNf2tND4wEj6ptXbe/SSCrdBIsWUR35eknAlTEUQ6z2ysp
 eLA3FPh6aN2Yg3ljQrLIiwLvC1am2UxmzK+8ChB3dhkafI518O3Kw5F+eivKzuS0EC2c
 jEiRE/yvA0UkGCgJi1eQHmG7gKSuxa/qEmK7hydYJ6E6JSgRqKY9DhpMM7u/XTc1KFPA
 zIMIugKjFK6tlqB2B2pAXZ0tfD9mm/XtT4z3GgjFA2/dAyV2KOvA2CaCOpxy0rk9DvrS
 Z1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5hQKVPBDERSSv1YoWb+/cMPA0IlNXMYJYmiObjWxW+g=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=iletwtu9fAaNmRRlyfTjdiFc6zJyjANrBR2eUXdhgzQ/Bqpxs8D0TNs3shhmsVMaWJ
 4+XWj9Pzte98m7ieEL3mRxHHhlFeLUwCe0m/Y+9YcXH2wG2VwgP1Y4GT1Wg6yLGDg8Ae
 bFk2Kbv73fGSaxbrsO8JN+2xdw92O5G5eJxWi3PTkTzPfeQ6bx6HhNbgHE2hk4ExWpPU
 byO13BvAWdsHO9hoMXUztAdwf7pxtgTypsFub4G+uw3RK2/3FCYL3GxAE6onUpI/oX88
 7MSAqvSUSAqek03rCmDQBkaAMRvat3myp4Eq+X//th7LU0KD7fFqf0jcT1q5hQza5HWY
 +Oqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478871; x=1783083671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hQKVPBDERSSv1YoWb+/cMPA0IlNXMYJYmiObjWxW+g=;
 b=pOghHqYAR8wMQzLTxX9QI6z/YlVs6S2ik5/mm6MyLBlJ9Wg6QEhdQfbBRAj1SywHDa
 XNRyNjpZ4RN5yQ8ImVjPU3LsXwZoUk2cWIJZXiO8fD0foCvPneZ4Uom3CT8Ga+txU1R6
 7OCSyT638NBofIiUcoqA9x6kgE8m1sUlpYhtcMuzCNVyrxzZIRve/Jpn3K7iSp9cMKeR
 agIrgMo8tx82v7vv44v9MBCruzjoM6cxbwWt+bqKz3wWcTTsbejKeq+hqNY2BoK1foDg
 7hNNEzGsaDeB7MIb/j969eEaqv6T/2MnOFAAG3BkegONgGQdMnWybRlERmd1h1mN2ds8
 HI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478871; x=1783083671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hQKVPBDERSSv1YoWb+/cMPA0IlNXMYJYmiObjWxW+g=;
 b=V0nLx5z4AKmQUZwCUA686EG95EFLD9gqEQCSKPoJffeyqEIaZXJpNVy2IJpJBoD0Vm
 vtMJ5Q8oEFg8S++w40lgWTJ86itMOZ83IXpD83HUF/kPyOL3Jp/LcjH/1XAeHqreKba0
 d6hn+L8nzFu6ndeiueo41bMmUJwHZhlbWtdHdeLLluEZdo2XbChTNkCa2Nz4KONLesKH
 FTDk6wxZ4qf+XlShRGFtKu124eFjzTHF5zIS5D22IzGrsewLfr9VB1OdWYx/hKHj0ma6
 I9PYDdEGb8aHDF1JLSj1E/cRz/qTrELwW5r5PUSXRGTb2RoQdMXO57KpHj2Um0f7zFGW
 5FqQ==
X-Gm-Message-State: AOJu0Yz3stop6R7eGwG5ZFxzJB15NcnzdQPfsQJmiRgrXwwm3W1z/quM
 oEdN0TO1hjpEnaHfRgCCg3ieSMFVvvPZf9qLEM5eL8ASSKxsS3X0mkVC3Wuz1IG1asqRKw2Ohjy
 gCtWBLfkxf75bm4On++wb6Ayd3MIQmLgXC4qrl+Zl8Q==
X-Gm-Gg: AfdE7ckvozEg1fxiNpqtwKJ1b0GjigD96+F9lB0cpNXXk4YGH3l9GDSJeyON50UnLTV
 kvJkltu3cvC78WVhflseMnQwdAvndpPUuLSLDwisAqpl7Yrako28O2RDcN0ByavPSZQMviYr5mI
 OMU6WRhXYqbFhG6Me+SuhiscBmgabzS6qcSJJ51XY3/5QPuEqtkebnMc3BLI0GF4FEpsnwy4IQG
 Wfa8eYLQUQIJuzMy3mxYSNDfpmacrC359ZkZU2ndK/mDyiUEj0xXmPvF+rdVDQGqgakVH8Z34RH
 vIMj1UnanD2Ns2uYWMVR9cQAsh3x7xYUay5fBZE10oWq+XJezuB08xXl
X-Received: by 2002:a05:690e:440e:b0:661:4e42:f89c with SMTP id
 956f58d0204a3-663557114e1mr10653833d50.41.1782478870543; Fri, 26 Jun 2026
 06:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-9-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:00:57 +0100
X-Gm-Features: AVVi8Cd2UQwawxIhNw3tvwUn2pS31JykeOR1kX6y2oWTfpb-kzAeIriPXWv38o0
Message-ID: <CAFEAcA-G085VHSxKhOHmj0Jid1MfFdZd7B+-XCbG_odU4JLwGw@mail.gmail.com>
Subject: Re: [PATCH 08/15] target/arm: Implement FMOP4A (widening, 2-way, FP8
 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
>  target/arm/tcg/translate-sme.c   |  2 ++
>  target/arm/tcg/sme.decode        |  3 +++
>  5 files changed, 27 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

