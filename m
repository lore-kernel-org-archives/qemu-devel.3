Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3869CD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz8X-0000gg-TY; Tue, 09 Jun 2026 12:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8V-0000f8-Ot
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:17:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8U-0000mH-0j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:17:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bebac79fff8so603512566b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021824; cv=none;
 d=google.com; s=arc-20240605;
 b=ewECqREKVCjgTmHoa5O1eYFMAP5QAWjHeAtiobIs89khg6lpbBJrjuObtScuKBVlcg
 w7BdHnAgpwS9WPjMHPlYrl3YaVucOn0AV09d9CWC4+IG/rLCwkBbl04ym+qBTDlv+wpS
 8j2Gyo3Pnfq85tkFyqSmzk3KQjaZaoufCCkvvs0EU+9lj1Tnywi8eoQEy3yVzHFtkbCl
 W/5TlImgOrd0bEX1kQYPdYHxCSv7DK/9pa62Uq6mPOxzZcuOt4UbGbXaEwFsTswOWZSu
 kh+cOGTLiilqjsnjdYx0fItCLXuLAKLj9lN9cZKtwpwDgn3cByDd6dhUHIz9ebAh7CkC
 Bcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o74JHeojs25MWgZZG6Z/h1tuZpvQAWxc/zH1Lxru8Go=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=guUpJwKRM+GnRQ9adssXq9sZhrFtct5xBVy5wAfrjmy5ZqIwpddv7HuRp0i71PvzN+
 USNN8WESiqghscKkGy1vPU0Qorv7T/2sR6WZsFUa0dBme2jgrZrFI+Dpo4ZX3Lot6KPK
 af0zlpEZ9vGtSO37UAdjCaQky9nJavEAiYiL+HYtmpqH32uNVOVU5Kym2N9eeG15jgdN
 QGwIHpxl275rlmiDeguhxex/TVIt3qNINaK/eG2DkvtPyuYXCkqAYHLmZb0hENZRAf4g
 bvRuYD1khQqmFtgY/hFD1+RF64CdhexWUM0NQ873MF3rFMWq23xVh7/42JLeaZYl/XcW
 hiRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021824; x=1781626624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o74JHeojs25MWgZZG6Z/h1tuZpvQAWxc/zH1Lxru8Go=;
 b=P4BgrxATbx+4AVKlM2vQs8eGXbwn5Pe18PzPBcyreG9XKy+9+R5/Rbv3Zhci04VZIX
 aWUArWV5jv58RSEriTC6KFXaR22OPrkkF1hbcVG7Bg89MZzCmFsO6KlJ8Yh7iVfwPpK0
 eb8/Mbp5fQxr7IPLn+FOOyZ2W9Kvlyr7uQRMxYNNSpRWCNDD9cc4HY+xUr4+zkQqA+d0
 ETSdPVuIxvIbHveFqePvadUAhZKOuK9sq/cic1N+gfgA7VvT5aihUW0XtWvxk0Ddo1Q/
 CgxAtDSsOdixFr4cnERGqNMoEgF3Iw9VVUXaMdW+/l7ZMRMRidLrG/Km9AzOwJL4sro+
 pB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021824; x=1781626624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o74JHeojs25MWgZZG6Z/h1tuZpvQAWxc/zH1Lxru8Go=;
 b=SoKenqZ1s36aqj4XDl7GGVZLx4Nkln3/YJAzlmx5qvvHqAF3HUMxSTAbnPSIufW9rk
 v5N7gu5R9NackcmtHF17SCCuj0znQeClspgx8bxWLYyg9+CSJrs5UIe/+UJqL46mJ+1W
 X9pfAeAvmWSIKUQyqyAu3wAvAzbCkL0P7cW0E/mLlPmyoYOGd3YFJ87nXzcr2abboS+y
 hnKWsHsztpOsRETw1VJ1vDkydBJH6Qt188u2nT8nlKLoJRmPgkRq1dqZDoksUOMWUSjJ
 9V6SBSEekymoWl9MIkfYq++5OKBQ0Wi3v13D5qE/Lgx7+vHpuWzN0LVykGa7BA4p752i
 jbqQ==
X-Gm-Message-State: AOJu0YybsC/P84nIlhz+z3HZIlNfZ0ksOgL03Ms0rgjl2CFWKHD8qFoq
 VBCwe/28U1N07mLPVJCgrJS4rJQjN78ycQ1BnhAm4IkbsB1ka+MEwmYL5WwoUc1lyP8O7mQz6pt
 7iK3Zg+7twB4DPIe4Ax1T7OjRZqe+Btyv97Ie5k0+iQ==
X-Gm-Gg: Acq92OFeeHHA5mgxlUR0ouFY4NX3EqYsuuVyuGFAuBtpSS4A84eZIQjZn7MaKt2Cnlw
 Hho753Yr6jtLM7xSTqnfLEDcg6MefZCL/0UQK33b2IWwTj5OzvcOtL3wGdDm3qR8IQgXxOW+o+Q
 qVon62Xh6MhMg9hQca3v72ieZlYYpVYfCjl9j7EMl46ZHxliwwiGZw2lr1B6YRMGERBt6od+HO4
 1PJdOOWgfTCch9O+2T2G3J5uW6tjgkH2jVplp/PI2KHN30IJ2tYJhTI5FsJz2SMuPHStqJXGaW1
 Xys37J47WB5YUShiRJjm9R5PWvF8ufTCpa1Q0aWH/xUS7oj6ud+hCtherufVdzhFV9UVbd/w95m
 QRA==
X-Received: by 2002:a17:907:267b:b0:bec:bd4f:e495 with SMTP id
 a640c23a62f3a-bf37155192bmr759739666b.12.1781021824521; Tue, 09 Jun 2026
 09:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-39-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:16:50 +0100
X-Gm-Features: AVVi8CeYx8Uyk2ovu2HkVksac9HkCaE56KZm5R0stbByaGxtIKQFyejEt3G5CSo
Message-ID: <CAFEAcA-8cAPMSL+cDiUejPagVnRuiBU9tZQZV_Lr302h-hSEhg@mail.gmail.com>
Subject: Re: [PATCH v9 38/45] target/arm: Implement FDOT (FP8 to FP16) for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  2 ++
>  3 files changed, 42 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

