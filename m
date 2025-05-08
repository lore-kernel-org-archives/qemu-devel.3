Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyd7-0002FJ-Fg; Thu, 08 May 2025 06:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyd6-0002Eu-I9
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:37:28 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyd4-0006XJ-Up
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:37:28 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e78f89f5c30so123281276.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746700645; x=1747305445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxsGv45yXM2dGvzaNPkdS3GffWkTTOXIPrTUUIiufPc=;
 b=bpRzO0Vxr4UKxhsxn/r/tgUYP/wBwLrlbLISPjM9BB0gP7uVqa9znN4wlxUCG4U+JW
 /yGxI4WxCPr5TsLBkd1HATjFNrK9GTye8IoKn/dzuAjZQbILJp+pD4xCch/wMXjFvHJ+
 rwy3CARsM2GZSaKwZtUSBWq3eF6JC0kEMlBJ3Dm4wFmStvL6Djq9p+UMDJx8WnAF7o8K
 jdk0lApBUfxLZKqsE0wjJUbltEHS8h1Tffovfs5Ac59CmQYoeDdkmDvFM0fyK5dQey8S
 hL2PSFEkgiirdg30/9M4AqSfcapiJhfHxsaaqqs995HbzkyJjj0wWFSeYxP5wJ7c3Mps
 soeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746700645; x=1747305445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxsGv45yXM2dGvzaNPkdS3GffWkTTOXIPrTUUIiufPc=;
 b=Kiu7PYET6tbNzCDuRBTtihj0XynxpzrnHGklWFLGhR0phPjiEnjJbvrW3UgK99nCiS
 Ku2rf+3Xmk8L8Zq9YHbKt0URhGYiXWosvj1oDCVsEgxZBd6I/pmfhRLlnUDzzj1wyQ+F
 rjxaBPfszlD2u9K48TRuMgYwefG2u2u54SYTvq898u1M+b2vHoOKEvit2tVmfMOM9Al8
 9+2TXytZrGgLenvG8IKZvPQ0zuhRuCk+eN10cWcXJLnEu8MHlreIDk7uU+XoI93rt7kB
 l4dJP004tUUuTy//F3UNNYXqiwYSXfll6MwWZ7XlFwiu2er4ImcRe3J55m+f5ZfznhZp
 UnTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjx8tSwLOSvSHJtmt1x4TzVvJf73EgkZt6E+iMMSkKsUjg9DwNAiwXT5JU78tiJaiuB+4Mp7LTcCuy@nongnu.org
X-Gm-Message-State: AOJu0YzWxFV++kAakAXlVUfbQKqcLCcCSnOruGUdpwd11yuqyigaM+nc
 SfHKzotKUNGkZiAF9yddobDIM2qGOISPQ9afCzAeh80Dgqmm0X8FdrEWO2X5juZcJST5uDmj35H
 MnykLbmASIA2pOVXQni88rh8uRFQDKA6xC0NgALGVHcdc19Fj
X-Gm-Gg: ASbGnctjB2KfIAbt73bFIYHGHOdTyiIXVfiOLlEDRp0MJ9SKpdxFC9CBdqyBcP8pwJM
 m9HX6nl4XLKIUHD4ytaoHXTa6g5/GL7eOnIzLE4AU6v6PRFkOi5jVAyDIieIlSHuP93fpsTotyX
 XvWLqTWXlsFh8wfdvDhpPdB44=
X-Google-Smtp-Source: AGHT+IEwlGGPMtTZqxkpEPIC49l6ax7XuLP8MSmJmYxXlPlv4XoOB0+vwEkyOUofcEAs3LVqzcTlvOP/onG6zcrLwbc=
X-Received: by 2002:a05:6902:2e0a:b0:e73:1cd5:fae9 with SMTP id
 3f1490d57ef6-e7881b1a1damr8773251276.30.1746700645629; Thu, 08 May 2025
 03:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250507124040.425773-1-shentey@gmail.com>
 <aBtavpDt1yfoavj7@mail.minyard.net>
 <8a5893be-7217-4c58-838c-01370db5d6bf@linaro.org>
 <b0737130-fc97-40e0-8488-3daaca23552d@linaro.org>
In-Reply-To: <b0737130-fc97-40e0-8488-3daaca23552d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 11:37:12 +0100
X-Gm-Features: ATxdqUEOYQ166hgRIeGt8wr00URORUpqbEwn9Q__mDvxV7UdnakoJPWylvMg5NY
Message-ID: <CAFEAcA9xSecBW6NZe38757oWNKXrfvHfy0+Cfq=itPFsHeQV+w@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/imx_i2c: Always set interrupt status bit if
 interrupt condition occurs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: corey@minyard.net, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 8 May 2025 at 11:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> FWIW I noticed the patch subject is truncated to my default git-view
> because it is over 72 chars. Since there is no enforcement on patch
> subject / description lines length in checkpatch.pl I suppose nobody
> really cares about that so I'll merge as is.

I treat subject length stuff as an "it would be nice to be
below this" thing -- I try to keep them from being overlong
lines. But sometimes you really can't express what the
patch is doing in that length limit, and in those cases
I favour having a slightly long subject line over having
one that doesn't say what the patch is doing.

In the description part, we should be keeping away from
overlength lines by having them wrap at 75 chars or
less, unless there's a strong reason to not wrap (usually
it's a URL or we're quoting an error message).

thanks
-- PMM

