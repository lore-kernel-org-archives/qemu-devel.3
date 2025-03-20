Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9EC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMFk-0006ZI-Tp; Thu, 20 Mar 2025 16:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvMFR-0006UQ-IO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:12:13 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvMFK-0002OG-Tz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:12:12 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e60ad903382so880500276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742501525; x=1743106325; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o14v6h9GWPrM2pbVE+TNSreW8dx88FN/oamTxQL76M0=;
 b=xl1lpR2pxJlxZVTTn32YXFXbYCfd9Qad3q08AG5KEmJ1QXLESVwulPC+yaMm+mctQU
 5HDgqc+Uk+hQ8MyrgGBP42AwiS2C2BFr0NnueGKcBg7KiYXYM3ljc5HWGOZML/iF4Uh6
 tpcXwIW4VcQY7m5bIDeWKsftLQdyBBOuC1Sun3GnDLiA3r4HzWcKcpn3u0qnv8BV8j6W
 mSTS9veg2/bfz9yV8YWpX6u6+E/LuT+LbCY+tE/rXU5hrKv6hMp4+IGltwMZgwPv/qyU
 LfmUgOf3/I7eZgEARNRuCVBlNdGHvS41AZDqtbSy2I0O9IA9GdsUMZ3Wk9ZGwviaZtLp
 qbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742501525; x=1743106325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o14v6h9GWPrM2pbVE+TNSreW8dx88FN/oamTxQL76M0=;
 b=CJF0I1f9tFrC9kM0WlkHnmd2o3pSSg8XXYhg80ZH3kYy/skGLZyRYGXWBk/nN52P2H
 9W/wxJ27IZYHJkvIr+alD4SvOXJuaVc/cJC87f9ZC2u8wSB6S7f4zh7b1+n+0hg5yjBc
 yqQe8NBqD9kKW37AYwR7TldejjXDeNJBfgVaZmBJCxcW1Fd35B4JRVLJ8l220oK4lmBp
 udofhbwd24OL4s8lR+3yHI4JPlFbec3ZAKAgJi61dnamnOLPLNQsY2s24jq/3ET3FWfR
 OxoCTEBRDv3E0lAJuWYFzOtqpj6J/hJddztIfA4CLG16T3XfEvr5i0GPOtJ79TIXNRYO
 ao0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk6v8LHKuWLNYdCDk1MCWQYBHB1QShyC6E0wNhTS1jvtCdXOoeNt56k20SLUI8A7sy1aoNOPS0HJ5n@nongnu.org
X-Gm-Message-State: AOJu0Yxqmy/zHO9lOtNUhs0dxK5/n85lOO3p15oKI3vwnuT68bH7yUDS
 6tmqzYEraYn4onN8vKAR3N0VGZnwDgPk2Q8BCXbDxANKcXPGiVwPZ+yuS4gNaj3SSSAzC0Wd3pR
 Zjq1nqHa6esH/PZsTpRqi31OMfV/aqL8CRJGZMQ==
X-Gm-Gg: ASbGncsP2+a6sh+mhe93phCMwnPeLkX1qhQrs83STotIKyDfFz04I/5JpstUU7yrhYS
 Gui9hL3QSyyDEoi7P+pnEjPHUNv8nvMyjgvfJ9Kzl2bwXPDyNqqF78L9ecwUg8Unv/7ZfO1f2L4
 sJvHaa2TAStyXCZ83hnu4b6WxPaKU=
X-Google-Smtp-Source: AGHT+IHC0u2zfXuBHiIjHYCVkX9Gbarb3n384o/I9qnXwLFg4tunrCFxT4u310gth+719TUngyxP7YHu874xFZ+z3jQ=
X-Received: by 2002:a05:6902:118f:b0:e5d:ac56:c3c2 with SMTP id
 3f1490d57ef6-e66a4db0342mr674864276.18.1742501524821; Thu, 20 Mar 2025
 13:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
 <87ecytm2ru.fsf@draig.linaro.org>
 <4545005.21021813.1742490863752.JavaMail.zimbra@univ-tlse3.fr>
 <CAFEAcA8rBnTD3pqiraQvgLLyOWMCj=2cftgDkZp5h8N7F8nq6g@mail.gmail.com>
In-Reply-To: <CAFEAcA8rBnTD3pqiraQvgLLyOWMCj=2cftgDkZp5h8N7F8nq6g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Mar 2025 20:11:52 +0000
X-Gm-Features: AQ5f1Jq71nVXXUmbmxXj5Uj1pWgKazyOicjwx3DAEJcWnBu8Gs3i-hfP2BeJIag
Message-ID: <CAFEAcA-aCi8CrHOffPJxFQq9xqnR+-_S6LUFg69PsdSR+g60gw@mail.gmail.com>
Subject: Re: Raspberry Pi 3B energy consumption
To: clement.aldebert@univ-tlse3.fr
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, "millian.poquet" <millian.poquet@univ-tlse3.fr>, 
 laurent polzin <laurent.polzin@univ-tlse3.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 20 Mar 2025 at 20:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> If you need WFE to work, that's certainly feasible and something it would
> be nice to see, but potentially quite a bit of work in the guts of QEMU's
> arm emulation. (Basically going to sleep on WFE is easy but then making
> sure that all the events  and situations that need to wake up a WFE is
> tedious. We implement sleep-on-WFI but not sleep-on-WFI because the set

should read "sleep-on-WFI but not sleep-on-WFE", of course. Oops...

> of WFI-wakeup events is rather smaller than the WFE-wakeup events.) It's
> been in the "we really should implement this but since the only downside
> is the host CPUs spinning, we've never got round to it" bucket for years.

-- PMM

