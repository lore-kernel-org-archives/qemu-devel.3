Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41761C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ojc-0004oW-7L; Tue, 30 Apr 2024 10:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1ojZ-0004nD-Kv
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:45:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1ojX-0004GG-4y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:45:29 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso7517135a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488324; x=1715093124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vrpc54sucJbvI/K5I+Zr3ZBUWB1TIumeG6ND+o/VUJk=;
 b=gdsFZOSlxPDDC7DGKpMhHH9Z3zFbrPF6Xk5LnbIOLprk0fztxDdEnyhHtvbRxK2un0
 ZRH5KwV8YiPOltIbiiJJCFMCltj3ci+i6IWw+0jim7fsTrjgrfQj7gCtqrABlQmGVdPb
 fKDVdr/5eJuvpSbgsRrr/xib702nh7kVtVEeTlMu9jNyqxhJ624mzyVekf46zvSdGCGh
 BOV6lFKDwKDHIJF65iWGzXywZFbHt73gy6JMBdGsTnaYG1AD0WPf9NRhYO9EQwIOGC8o
 3wJjyatP33zk1D9Vqlao0K0OCbFPSJay8kDwzxIn04xOx8+cCCi5AYoilhr7TGMT0G1a
 Eu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488324; x=1715093124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vrpc54sucJbvI/K5I+Zr3ZBUWB1TIumeG6ND+o/VUJk=;
 b=IIQOg3y0LO9MINJubJnIbe4ct771Bj46TYizkdx9mwYg3pex6XO74O1cJh4fN+8a+F
 IjNOx/Ce+WPFrZAsCV8ZwVc8l1UDVruLnicUDT5WIAJSIfO/dLjjwRxGVFfyVdbas8iX
 wZSRhFBtlA84EmdTk1jfejoLcdrWuI9UD9KtB+qTwrEucbq4U2Dk++hfehOvKFI0SMuC
 889ysLo/FmF2gtHmjp3mOu6ZtcCXHrj7xL6oB8DNquoRTJhdd1XfV5m8KlMijzcxcZYv
 K2P5mzn+W50UJcZuGCyT8sB2zJAXu71vImGGiC8LZYaEsGuA8PDidA03jd83JXzI+bSi
 2YYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBjYcyQ3CRvhxT8ojXNpBJcGdhHgHx5a1NLFfb6SLfiN6TAXENF3ceLVBkHvKlf7SEoevk5D4UzY5zslbhmfN2OwLGz38=
X-Gm-Message-State: AOJu0YxG3mmx/UZkLJTEcCS2iRj13YB2qG6zuBDuH0rbV/EWBdcWBc2b
 cSlngDbjyU1PsiPZAd0BhHcadeLCp9VqHW5k4cX7E5cvOY3PZ2HtR4idZb7m6UBoE7JbSPYkQTV
 dQpETz09wYD2WhBuhMB6i7YFz1oPuzDPGG/5ANw==
X-Google-Smtp-Source: AGHT+IE8ZO0h5Bnbqz6SomZB9YvvXufwiT9HlYwFQYuRCboBKokuzXm/jbYQCEK98bhN8mua01Io7PtLMg0EMgCEdoo=
X-Received: by 2002:a50:931a:0:b0:572:1625:ae99 with SMTP id
 m26-20020a50931a000000b005721625ae99mr2456eda.31.1714488324066; Tue, 30 Apr
 2024 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240428181131.23801-1-adiupina@astralinux.ru>
In-Reply-To: <20240428181131.23801-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 15:45:12 +0100
Message-ID: <CAFEAcA9Zkh6xi2VvMi1mSjvAnSexrQFjVamES-z34Wh9gTuRUg@mail.gmail.com>
Subject: Re: [PATCH v2] fix bit fields extraction and prevent overflow
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Sun, 28 Apr 2024 at 19:11, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add a type cast and use extract64() instead of extract32()
> to avoid integer overflow on addition. Fix bit fields
> extraction according to documentation.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>

Thanks; I've applied this to target-arm.next, and it'll go into
a pullreq sometime this week. (I tweaked the commit message to
add a bit of the context and the docs URL from the other
email thread.)

-- PMM

