Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC140C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohdC-0000Bl-Dh; Tue, 28 Jul 2026 09:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohd0-0000B7-Ei
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:13:52 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohcw-0002KV-L5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:13:49 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6626b5ace23so1469885d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244423; cv=none;
 d=google.com; s=arc-20260327;
 b=OQKnnxSwZNzSLb9xhx6v1PvUlu53xL3vRWy39FjBQ5RF+EVhrJtYq+EhLUJwSVZMta
 2tLWwD9/i3rrUPjjXB8cEFF07m6lRWRZtfVsY0IJZTGv/Hh6P1q3AlXbMEI2uPB/5h+W
 q+Cvx1j3hEZBBeuBwo83BzaRJksMOvqO4SLo6hzTae/EgJNFyk6QGRbCB38YPvxAkpto
 rxqe5sIEeCsO89fVJ9V7vV0QuDS8fFsII/R356tU4xLVd2iRwCQgydDwSZpDmd9R6bVv
 shMnhLiRCLXykO5oNI6onmIg6C0Iy5uKiWQa3s0F7/1yBnkevJ/QmiQCGPPmWCA92TQA
 riSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MU1owYP/D3gktGqlzAbq4xHyJSuZ1mIySueCS/JKmYI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=c7g05zAceWnTowU9khfDkjYQQv/aG9iIAbqhjEB3gZ1xoFDytIs3uqnxXbpUVSnRsE
 80ezeGCCZKnP6U73hP0a8Z4oqbE3T28TT3jmmNG37HctFAFvzlkDU+YvK1XdPFkGhldd
 5cTgVUAAGrfhpy6704O3nM/FMZl7yEVNAP6iT9ZAUwMX47RJE6ytBog519CZ+El+KGug
 nZCKqjXK/PMQINQBVaaBm/RAOpNsasH5nYBHCT5ikEEtOYrPREofaBggHql/2QU/uely
 eT3HbHz1k92LT96lZoxmeXKirYyczTZZdsq2F/NCr9uATbZZXWRrMWyTxEEbvFhhzx36
 LinQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244423; x=1785849223; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MU1owYP/D3gktGqlzAbq4xHyJSuZ1mIySueCS/JKmYI=;
 b=d2Go0v+pfrYSNyWbbQyG306G3WZ4+Dq8Yy5tWj6Lw1V+fk0SlkmuiKM4ugpofNqdPI
 eCbLQdVdPJnpHWf4jFItXY+BGrcLZ9szh+cNXaBUwPX99CvkmsI1YlrgQAlAy653EFz5
 +17QFjHnhixPR7rA5vR/GyAGM0mT2DqJm6F0dTTpPH4o7GkGCOJdWufb4YhTnW0GpQAJ
 Mv0qahQGxPzPaRn6EDEzIgY7IFOf42MptwyzFsauB8MKwIGCpwDBHeTr34g/7dYUVXxQ
 DckxhV2PCVQjQp0Bki2o5Cs/jc1B1mroSvQ8IakgAuen8rUkKvEi82WFL40SVXY5q0bf
 /CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244423; x=1785849223;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MU1owYP/D3gktGqlzAbq4xHyJSuZ1mIySueCS/JKmYI=;
 b=S0Ve+lI5nciXQQMDMp9ztGzDL9StQsNtwQc8GoRdgNr/gvi8TevcnSMtKiMgAy7heH
 TA1XxO26I75K4rb2ugiNzI3ikq88HHQi+vUe1ZNJtwvjXcun/TcKCbhr8ZOAeMkgm+dH
 p6WGg9f67RMYMeS18CRoARNsfkUr1TjnPFlx7atIWlMeagZf8EfduM25RPPGAeUAc2N9
 /UOx/3WqNp4Uq3ZA/hPfJ1VkH321XsOdlTlW8kBM/Nx2qPe9DSL1nvCth6sKRfwvTRHZ
 O0Lbu2p1j0OPXc7gQb9Ee3qZLNHn5WpZrFWwESwBj4e0KWDN17RCF7785BBVS3g1U4F6
 m57A==
X-Gm-Message-State: AOJu0YzRYaUYl4hTsEvKIT7Hchj6M/OZ1q86cudQBYmfLuvk2jNhcp0n
 34buSgPJf42t2YCYkrF7cHKNu+hgs8vAFXxhOJSWHXwcAR1VWnQX1bkJdIwnfA5/+cYl2dXE1p1
 j6xCuI/uQsPEEL49c6MCV3uhKWsnEHvvrMiEAzsEZjQ==
X-Gm-Gg: AR+sD11X+FT1X3xuQarEjvqIPbOOKQ/LsgQXrC13e15Vtgh/ZmxlbzUABztIMe6Q2zj
 /ttV1C6IkDWfjgDba1wx0zH2UDTkKmwl5XO3lFCv3lHyYmqoFgbmEreug9xugF7RzYc8ovw4cfH
 juTDqUrsJRWq9/xPrp3IPdU/Aoqarqzh51W1oZ9LY0Azxm0YDyK2QNSOMtf7YeMDHeiW7FIRLlP
 jJvYpJxVYw4JIPDkZkRdMN1/bZsieV1YqqoMSOORbLcooWBUiBdD7iy97wtCycIUkVB4u/20Cfd
 0Xl5UkRXwzhIi6I4JSU7iVViy62757wMxQEhMW6ISxhlVw==
X-Received: by 2002:a53:a386:0:b0:668:110f:8581 with SMTP id
 956f58d0204a3-6690582d2e5mr621168d50.39.1785244422729; Tue, 28 Jul 2026
 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-7-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:13:30 +0100
X-Gm-Features: AUfX_mw64BzBQ_G9vhtFk5f0LwiYR4wxz1uXgdVWigmcYLDqDw-adVkvVP5BTvg
Message-ID: <CAFEAcA_Uy3QYOkY2TU_C_Zj8V8r+aiCtGRNNh8pBkXoe_VseWQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] target/arm: Implement FTMOPA (widening, 2-way, FP8
 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 ++++
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 43 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   | 12 +++++++++
>  target/arm/tcg/sme.decode        |  2 ++
>  5 files changed, 64 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

