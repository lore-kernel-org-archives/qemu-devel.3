Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE2E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPCg-0000Cv-TI; Wed, 11 Dec 2024 11:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPCb-0000Bz-VH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:04:42 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPCZ-00050a-S2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:04:41 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so3482402276.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933078; x=1734537878; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8MA2gWBkJ2+i1Kdessuxl3UtxoPL0/XKrXRfRNatXk=;
 b=k6pgxX9xh49vc3p4Gx7yFj9EVWqAniaqS7idQ7u85yQZ4iRVWA7NXJZNW4NUW/AGLn
 xlvFyJ3/eVJAoJq+0zJSOsENW0h9Pao/K3WjYFw9FCqj0ETgr8lfpwwZbJpoCdhnCH3b
 fh4/YGzsvHMSDfhbqk9Dj0QyzgTFc7atdcivyUUf7NKGztJZQG30yUDt+gt9AyG2M0ku
 7oIfvGOPZlFPIG7DA3NuNd5BbdaO3IFnaSIi2s5p00yF8nNmE4cPKZEzh0mV13gFd6T0
 sVmSgptmsQ/ALXX+HuGQD5WiIFF2OJrijM0f+eAk9RF0dep+oAU9EvXAKp/wwZ0X4NEL
 dbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933078; x=1734537878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8MA2gWBkJ2+i1Kdessuxl3UtxoPL0/XKrXRfRNatXk=;
 b=LQMvh52ivqnecFDdDD06JCuq/anh+KT/U80SdZrLjQj8hKb3Ps7fQZJuWdnXoXsnPZ
 ZptdN71NgSYujKEEKI1m13MtR407SSz9DwPzmAxeezPBT8bJQCy9mYZyk9jl6ZSkaw6H
 XB3PmGozBp5m+VugzUevUlTQxyEdQS+VHEmwvkkuwCwtoC5RnZkR9NzlLVexmLV36Wn3
 aI3A1yx2hkYZCTyap2t9AohmXSmkcgbTvEwIgAxpfYoEMLOvjPCdf3tUC5E5fgRsQob9
 nkPCIqqoMg6aHIpV6bJvtq8Uicjpp8lkwa1ryInup9Lpe8HIu4CtbEDxv39XVW00EA+S
 7GuQ==
X-Gm-Message-State: AOJu0Yyx5d+2+FYtMkrzV8oLmg+Gtd0OhpDY8/mPn25qgGXtOI7MVKAR
 +wQqFKmGxhBckiHmKJUGce6tUIoJhm1G4o/KcozBykTsDt+2Ycs3SUFU3YgvL+XhO4eq/KUCXKa
 8JVBeZmW4ZVZqG8FW81FTcRg/wWStRzpPtVm2AGrGDkxgAqj+
X-Gm-Gg: ASbGncv5NRL6EUTRiQihv4tY2tzC52QEtztrVcS8RWiMrUrpQgYIdrTm7lqzr9GwVnL
 Yh9DPCUDlZicqL6xkm2gZbJ1mVVC2H4ZWnSdo
X-Google-Smtp-Source: AGHT+IHJpl5tYewFusl1iKCNDaK5yabx8lWhHAH/gsBZk+fDCrHoZpYBxoCr/D27U17/FDLOucRIfHzLxWAZ6J2UiWo=
X-Received: by 2002:a05:6902:c04:b0:e28:ee2b:34fa with SMTP id
 3f1490d57ef6-e3c8e22dcebmr3828110276.0.1733933078392; Wed, 11 Dec 2024
 08:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-59-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-59-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:04:27 +0000
Message-ID: <CAFEAcA8wd5UNU1OMi6Vfs+h_6y28ORguzoiOsMkX=OKntByb8A@mail.gmail.com>
Subject: Re: [PATCH v2 58/69] target/arm: Convert FCVT* (vector, fixed-point)
 scalar to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 10 Dec 2024 at 16:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c |  4 +---
>  target/arm/tcg/a64.decode      | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

