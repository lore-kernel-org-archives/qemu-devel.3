Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101BCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCNg-0001yZ-EI; Mon, 13 Jul 2026 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCNf-0001vp-CQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:51:15 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCNc-00042p-UC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:51:15 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-667b76205f1so2331780d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932672; cv=none;
 d=google.com; s=arc-20260327;
 b=qLJUmpJlesB1iCRXol8LfW0X4kL3wBZIrUGs8O7SWAbnxcRLjiWLel+NJ+RaNI8Ng7
 /wBh4xKdjv2ZIcasI20muXQCDdWef9MWAimAKQyAIigT/DtOisyXK1GZixT+7kbyeOYS
 i8C3TDuYqywRKScrUbPEer6sTncGgp408heHiL8LjW6ScGgAHkkVXJFdZhvRTZpjBBHU
 GbzujUw93yf8ZugXrn/XwUCH67I6c5KXM6TSZvtmhIzFRpN9lWeWZd1l8LK4kTFrPKAB
 BnusQqRDhLj1VWZeF8Yrg8zRrlojTWiOgAiBGk8sOfIQhax2y84hC3ipRZFeI6nahVWw
 TuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sQlT3EamjD68u+9QT9LalK+PZcnYjXGD0CPM12MbDeE=;
 fh=GRGAhYIRyJLIexm/SQeD/ONQMnKo+TSDqNowgo15cfY=;
 b=OKziotoFRcykOMMgBu7TMqGmXj0gnbUArYeVt0n6+BXhVeGknEyb3PsKw2Uvnm2pyQ
 30bfHr+ReD3JJzd8vQwgRGZg7AKzjczXT0mnq80+gJXGzE9gc8IiIw5Lt5nbNEezxZsZ
 os2lJ2/l6D1MiJLb1GPTdnqOnewVsQ0ciMGng+NYamohqOxzyL90WK4+UrVLbyBE2TWO
 PD7o3Hc3bNlLzKat3lLUCXlWB6ShVfU7NmLW+61HIjxwwtBYb8T7ENztWQIFeJSRjal6
 9qfuqaBVGvx5aB8KvzyK5pWZAZY0pR1fLj9m+B5NHw79OPhTecD6xaHl9htiRjPvKvP4
 z40A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783932672; x=1784537472; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sQlT3EamjD68u+9QT9LalK+PZcnYjXGD0CPM12MbDeE=;
 b=jw6drx4Ut7OkHFbkMQ4tCgbJgVtmz5qh2zfrQypUlIXyFXmI3vcojs6ISYNUi97d7R
 g1mvXMrBjBiFH3q3xWKlH+9bPcMoe1Y8iQ6GF4vIicEK/LDGA5eFU30K6R8Dh8KiskTA
 erY1z2tu3qlBCsrvZ3Y4/PB20mapkJyKOmfDvDCUI4jK1b8i+9Y/d9Og4HcFkc2CZGsG
 kLESIfkVkjK+GcEufOlsHTD4Bj3ss0pakzrasgFA2W4Nd5v+5v0SRQvT/SqyvMfG9zHj
 kpe7fVr59L6aPuL+xpuI8jkBkVnb2LTBOVo0l7YW8xqmvToS+etRbutQUKA+8rdsLkQt
 ZC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932672; x=1784537472;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sQlT3EamjD68u+9QT9LalK+PZcnYjXGD0CPM12MbDeE=;
 b=sXaA3Xh+EKakk1d5yabftCA88yRK2eEe8DFZOAepK6QXbzDVu00+1j9ECwk+MGzt73
 HFzxK/SwGh7PBLkajlPkvdQMu2JjfRNmMBL4fCXBKIQY1WKv8v6rfDylYVG937itCjSw
 6a7Ql8FFX9sbR0tS0QzpRG5ZQhHER61NmNpuIbGYQR5nJ39A63tZXdH4O+LHRdxLZY/h
 srDrFb3G+yhTKTlMV6E48B8aP+MBuz4P/6qHKUwTdVeA30PIzvnswUT3+SIUp4NVOBY8
 nqmkXv9esWkvyAPuvqdZJyxbfDhlGSZXFp4ruPuKZvYzJg0CV16OWRFM6difMCu/zAkP
 C0/g==
X-Gm-Message-State: AOJu0Yw5iOlyh+H7CI/3t0QcSmBkIgGqazq4mwh+TMXc6LcsDDBnba+c
 APNxsvSwFTMNevNytscC5Civ2UeHSm8gIBxpU1m2hHGR2hAn1JPZ8gKlK1PdzWz77KcdyP8U1JB
 lL7xalJqgbzGgxqVbR95VrFJPIchSJnM3/aRvUamAi/k8ixVHUOTN
X-Gm-Gg: AfdE7clpc6BjPs++YGV4UthSkxJemownjfVJBeNEdeu+YrK+sxD3+Mv2agfOn9KyCuK
 LGjl+uWVHqmV3ce7zYC9Uzs2c3hsxLvj7wDB302cUSXS/vsrT7/yznz4GLtvHxdaUlclb1Cwr1u
 lLkqTQT1gAZOthY1N0ifGuEAmYUjvp8DvrBZJD2lXWui+RGtT14lRwmaOi2Si4vjI4UT4C4FKUS
 OTHET1O2fN6l4cOoVlWH+ImqpNizlV+TTxschf3VOplZGCRoOSpqBggXxa7o79xd9Hhr7Qal935
 ESOc86ijsXa8eYLL+qcXuNf68gvGjvcBJGWyiFBUDd0CbJjrj9WQrF5X
X-Received: by 2002:a05:690e:1446:b0:667:e2e1:44 with SMTP id
 956f58d0204a3-667e2e130c1mr4071305d50.22.1783932671687; Mon, 13 Jul 2026
 01:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260710175818.528974-1-richard.henderson@linaro.org>
In-Reply-To: <20260710175818.528974-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 09:51:00 +0100
X-Gm-Features: AVVi8CcaXN8HVh-MZrReoWelY0YIbYhcOFtn-wGy6WzjjhZqQBWYtscYwM08W8g
Message-ID: <CAFEAcA_er-_1VAmokZWygtFAwJbiHRiJ3rrRdF94tV4hQwBB+A@mail.gmail.com>
Subject: Re: [PATCH for-11.1] target/arm: Be more defensive for invalid
 tlbi_aa64_get_range
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 10 Jul 2026 at 18:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> It's possible to program TCR_ELx with an invalid granule size,
> which could match passing an invalid granule size to TLBI RVA,
> which would then fall through to assert in arm_granule_bits.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

