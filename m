Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F0EC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGx3-0001g3-Nx; Thu, 03 Jul 2025 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGx2-0001fG-1t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:13:56 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGx0-00018i-A2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:13:55 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e812c817de0so4599854276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537632; x=1752142432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YcnY0ChhwlXMVkjmrPnW3qlLSY51H5NvtF/eJ7J+Qws=;
 b=btWs8aUYUc3fmZnr7vWrQKV9MdmMVHfLYE+gw9xYCvX2otWxBTlaFlTKvxdttpkSvg
 pP4uc8tJr3hdiflPI68m0PIdWM4E2bXEPD214Ov1POVKil6j+SiCPmrbB/moTmliasaR
 Mru4osuqyiiGMjbyGY/9pc0sjAqJOOe6UDtDDSEkQ28IBl+DQ22aGrBSQIflMZblBvnl
 PAMRWRBMPIjm53Kv0zl0tTg9eOqcnj8REQT9ZxpUu96uTCGi1HwwfRZ9mbAhGngWZD3+
 SnZkS3bYVD04EGJ4wMpDUiJCpvXdtRnKwFPdXh20/E08coZE59NHd8V22zpU6FB+WNDK
 SK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537632; x=1752142432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcnY0ChhwlXMVkjmrPnW3qlLSY51H5NvtF/eJ7J+Qws=;
 b=eXUYXyItcSWIvWM84Kb++yjCf08O0veVZ+/Rx0DDMlIlGthDrF46QT5Sear7KgFzBG
 cHLrBtEMd+qpfJk+3ZOj9zbLaO2D6vfSFS3tonamIxywuShL6/iJhmIvv2LwfSvDkxcD
 MswMbZ7sP6vYJ73tv+5aBfWt7NqkWHZ1OOz5JmmaePABI+L/DAZp3lI4XulP2NZimh8Y
 S77RXM6w2mvXi6iv4ZnwAxpQxJjqb/fUVzaDeLyTkwbSJ71LpA/Z2A7WyXsd01yUjHcV
 5Bq5+fWuvEsmpfp2pEjO/zeoflcvuSHv12JEpMfICFzaJS6Mmxn0A9ijIYjZi+0mXtG0
 mNaA==
X-Gm-Message-State: AOJu0YzNPs92QhRSNG9nuHkFxIUJs9bDzus/hV8t8au4uAengv6G2h/6
 r7dDTQIvrI0Dw0EG0E5EvUNZJVBGHP4RMyT4YllBL5/Clm/6MCGvNQpKSwWEO9XknlEBZDQQoSX
 CBfHDztFwvVxTEAmuujPy9J0BO7o+rsW6GjskspXC3lWmbJVVWtFh
X-Gm-Gg: ASbGncsXEFBmoSpdDWTMkCQcVyWigyIv2fqCTuMBX1VIoj6OSunL0d/TnjcTltFlKZh
 vukyrOq4DAGOJk36t6QYuZtPkMCQzOWhN96khDwGQd9Bx2vBqQetOVjQ7JMtTSOkjJvuB6RvlTo
 dGiKO6SAIs9YDTCN0zsyiS64XtV4E1IBEltDHFleUAv4RG
X-Google-Smtp-Source: AGHT+IH7hjlCBhaaG7Cfha1VVbM9b9fxRRO+hkTbk2jQy7+uhbLEO1m3hOvYhgUA689psGt5JDVs9FgezSfCnwOCmbg=
X-Received: by 2002:a05:690c:6608:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-7164d467d9bmr80835997b3.25.1751537632616; Thu, 03 Jul 2025
 03:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-42-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:13:41 +0100
X-Gm-Features: Ac12FXy3pUqudIO75Uer8xEzjPbM5S4yJweeUPgdmcYXl5ilWzZ53X3D8zbfhHs
Message-ID: <CAFEAcA9DixH6YnUJBVWOhvq185RjU9e9PM25dxgcgB6qeYiiGw@mail.gmail.com>
Subject: Re: [PATCH v3 41/97] target/arm: Implement SME2 ADD/SUB (array
 accumulator)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 28 ++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 12 ++++++++++++
>  2 files changed, 40 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

