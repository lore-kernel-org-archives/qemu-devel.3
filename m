Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C61C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokaA-0003wH-BJ; Tue, 28 Jul 2026 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woka8-0003vI-LO
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:23:04 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woka7-0002jt-BZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:23:04 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66893db7bccso5477899d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255782; cv=none;
 d=google.com; s=arc-20260327;
 b=Ltdx56CNTALGNwAam2p/8Jmie/BO4IJreQ91upX36KvReUy4QsG7vtnNZPmVg9DS48
 lB8MuB/JvTcIccGkXoVfLAdoXPrUYZX6wsW2032ufBoW7uyliZyCXxzr2Bkj3UOZbPUt
 crjiISVyql9a1zXaYBEqpm7zpJH5Oy3JebglJrTiApsF2FuU6HoYtt6G5CuyQdhy7Nm6
 rdl3lyUrCWoa1jDhB6BvAAik45SiqLP1exB/KQgjLkKLGfJM9TwWOfVBO7XHlvQ+o+1L
 5L4sS/8IsgSAcAoHJ9BcsFLxRmoQBUMfNFhqUaIvjl/mtiuvKERoUFnYdu2kkRKRtnRe
 8r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qweYkEqepW4QL8jqG+P1ypqAp57nlLvwSADpwPhS5qo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=oqWRM4uU4vg9j1C/bz4lHDMxjyjvebSBV/rjLPHUa+7wqlXzGYzJSti82EiG/s3+d1
 28vcXmKTmm6b5v0bNBU8mdojnYcE5564xDh0KuGCombhzWvZRz9yHtzEY9gZ1m3yWfKd
 uIcxtIfHfCdCNJa1/hsQlzHbQ8K3dq72jGGa8BGqaxAJVQS41nBI6NNwWLWUXZF3lAzS
 9KJ9fEedpNdqjCssJF18izciEuNE4pszSpUAkOGO0aCmDxkRLGAbAkT0YHDlPZ+5cyoZ
 27/b0nul5fRvqd/d659Bl3n9AH6alcdVeSd7AZEZGAvQbjtBEbxMVsVQFGw4xGky79u5
 BZfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785255782; x=1785860582; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qweYkEqepW4QL8jqG+P1ypqAp57nlLvwSADpwPhS5qo=;
 b=QZc+jdH6/Y1XA+mTPNX3w9c/O4yotTnuoJlV+CStYIoFe9JGtPVxB6SAa3qx99qcAi
 O917NTB7wgqK9kcF1ADwtflw+bmGnjEWJVS9IPeNlDGHpvicP7jKI6vNtQtSAr0CrERy
 AG0dfeS+BZRLca1OVa6fo6kxFeu2WKbZMiuDZLF3NiRUi1QFSkggbrRBCUht/JgB9JIj
 voOxRLFm8NLLtphsjoSDl415TnhuBThfvCB51Acb50iXPtqHVNqRNVk7qfAVXYhA1yFz
 WpXWKlKFmBFCigOxw0YFjsyIUNgehcYMx5sTe7h4zp1PUuCKKFu/ScLlsmij3/iBopMv
 zeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255782; x=1785860582;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qweYkEqepW4QL8jqG+P1ypqAp57nlLvwSADpwPhS5qo=;
 b=rUxGIedSodXFu7ydRVS3DbY/cTOApIrZomzbaWtRE8PfaMqzFZ2ZvYGDcLyN2yYS28
 16adccr6nNmwMo8fCIBhT6fNqHIvM5gMu20mt0VcStn/uI3EVCtQjDBs0Q8dNyaHaFeh
 qJGvnYx6V5h7Uppb+dC1e5q3YSu+yI//lwIzB2b6GRhu7x5FrKTfht4e4c2+j1NoD28a
 ntZ9PfkzVIGBTdob90UY8JO8WaZYzFXrQ1KpgLA4Mq2ArQT86oO/QUsypZ+h7atlP4dh
 J8nk6n4J2NqGm4M4RRLbmcFNpgUMEa1UnzBbw20IWhavVvcS7b+r8CHN2Y4DuevMLLHM
 r+Lg==
X-Gm-Message-State: AOJu0YzCzxBBuUHT5kvuroksi6LKQfGQlB0VlmiUTzbfnHOfstbT7fvB
 8TktIIeMKRjIwNe//2juVdWQyGqBGN1AsLVwRwjlT7ieoy+znqMm4skpx3Q8ei1cN0iEL7Hu2ph
 cetgYG2bb3qZvBiUvsexI+T81DdsEjFaxjoH3+pdVU6miFvf8FCUY
X-Gm-Gg: AR+sD10n8wNL5CHg4LaI5ENUt2PW3ROujpVwsBmW++iQmeueAtfI7De2B7fvBB6crYP
 jrod8H4dsNRSkvchIWkCPEl9CH1PX23TBo2BOb5Fo0CJJO44uOKisS9GAj8tfLJk5/y7IpUj6WD
 QgtbgNBW0fnFM2S9eoPdzVRsey/6fxd+ukSvc7aa9ItjDe1kcdzeNlZUBs/fJCCXs7K/8lezIf7
 OGDYEz89kUAwROUtdU/EHEnuVFFD+A055MrdLskYUnorOrB58oZ+7xPRNnih8R9I0R5XVcdUgbS
 ig0kN2soojjFBuwpOG1aHCFXsMWLQG8YtVBjjZV4+AtLsQ==
X-Received: by 2002:a05:690e:2017:b0:667:8b90:2ee9 with SMTP id
 956f58d0204a3-6690583a155mr881924d50.100.1785255782031; Tue, 28 Jul 2026
 09:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-21-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:22:50 +0100
X-Gm-Features: AUfX_mx8r9MWwT68D7avA5fKxzJj87ibJPrs8X3WIf34MvUWKzg-PRn5K6rmOAg
Message-ID: <CAFEAcA92eY8PGp+9_eLZMfV+n_-T2TJ_mLe7Wzedixz67jB5bA@mail.gmail.com>
Subject: Re: [PATCH 20/20] target/arm: Enable FEAT_SVE_AES2 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 21 Jul 2026 at 19:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 2 +-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

