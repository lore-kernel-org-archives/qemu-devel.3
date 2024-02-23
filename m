Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5600AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZ4E-0007lr-89; Fri, 23 Feb 2024 12:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYrZ-00008J-M9
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:57:31 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYrR-0004LL-Tw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:57:28 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso891389a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707429; x=1709312229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xsDhYDGOw5CqhnAyZ1mUQnkbXRXKZJFQMDnbXbJP7ck=;
 b=cpvI2nBY9jmCV7SHejOX8n9n8JG+RlrFnju5+Ocv5oh6dHBE5+m6wdtqEnKd6sB2Uu
 ldfnTpp7hjcTsMjkTwLlz+2HN9W4y5IUUC+PxaeQgMxITKPlfmHGwKLZD0Wvz9iaNEWr
 EmNaEeCrEJZ0HJmRlrQSOQkbBn1gQ5aaKaZb0C/C0X/UR8Pds/tGQ7TzCHq5SWRvW6SD
 X/DrbP1WZF8ZBTUNAKI/TR+gRzs09TM3R4aABV5l5rRhZTxBZEunle1SjsIFzSzFJiin
 O0AtPr04adN7p4se0MhzL6pkuI8VsZQom6ihKs6+/73sXkWClPwapNpY0qTa/aPK6Ccg
 w3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707429; x=1709312229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xsDhYDGOw5CqhnAyZ1mUQnkbXRXKZJFQMDnbXbJP7ck=;
 b=R3Z+CWlc5I67ScJU+nCBpwyvefI7xv7VIGYSwE3+SBQQHj8tmarwQTLTzp8JmWrTYD
 KL1M3sByh8mJw6Gz91cZ33SmYKzfH6Bs8LPCphyiUdNzriLe5TJUXdNMCdeoo7UZbXZN
 39ghKy+0UDw6GfP3w0ozrmjiEuC1M6G7fLWfTERCdyiCl7wSJjDUXAgV1MvbEk1TgH2E
 +C4LqL/MbYO7zVG7O6vB4FoPyY2S9EzW/J9dNyNiFWZeRzbTBz5sfA54R/JTlGHOKcFP
 6sSjz7H+SAJ7hcVoZ4b8CP6yDUdsJTYPE6tPESlZLieY0jCv+AFsoNMJD8v+fzXDwMZf
 z+kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwP7RYb8mOPqOXdW1ccou4S/HSJuo+HIYQsevviKp0Jj7oBLsVXEXUbrAPHdzaS0Hyn7ipyBZdrFoW6yJgTo/z4HNsbLs=
X-Gm-Message-State: AOJu0YyYXRPKfFgIGJaaWY/5H4pJkOfcU0rTdI1RIb4s6yRlQJN1oM2v
 7y6LctZ3F54zTB0p9M50JEY62zIonzIt/H/ktmySDP3s1xvoOHjEkzXm8fJ7YMuIz5izE5qrdyh
 GZ41hHyBl0emQXNmMO6xX0isle6m3HBZLiixhBw==
X-Google-Smtp-Source: AGHT+IFOcAemeN9d+xcwiY1NHvlaE8CkJ1mjdhQrNvZv1uH1/CaLSNjuwrIDwW7GynEbt1/dTxRouoPFbv4MDiv2q90=
X-Received: by 2002:aa7:d0d4:0:b0:565:665b:9c82 with SMTP id
 u20-20020aa7d0d4000000b00565665b9c82mr247097edo.8.1708707429234; Fri, 23 Feb
 2024 08:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-42-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-42-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:56:57 +0000
Message-ID: <CAFEAcA9Ly8PVajPtjuPiuBejwjTf34sgNArJjL+vxFUefwRmMA@mail.gmail.com>
Subject: Re: [PATCH v5 41/41] Add RPi4B to paspi.rst
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:23, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  docs/system/arm/raspi.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Still has the typo in the commit message subject.
Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

