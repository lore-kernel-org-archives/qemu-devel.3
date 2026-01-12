Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBDC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIXX-0004yl-6R; Mon, 12 Jan 2026 09:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIXV-0004xg-Jx
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:05:01 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIXQ-0001as-Bw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:05:01 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-644798bb299so5927112d50.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768226692; x=1768831492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UziT9209levcy8cck8gsNOynkewUOtZyDWNcEauP+8E=;
 b=BL3bztZvUKCwHd4swU5hx9xozr6OUdPzI5E3DyDEqW5KPvBJHdPd+2zoA0EU3biO+8
 Nv5qFNi3/+QXmvIPrgrBatTsr3bJUihlAuXHCu/Ok0dCTbIVDPASA4BQd6yESOMEX7un
 K4Kl/IR622cCaZb8Nab/3uGBWU13uMAvXdf6uR2Qd/aB7XScTaLPR09WKY8gthRsQtUK
 0OFA+HjE1ZdraLqrH9Svfh0fCPiC9sZdxKlxDqj2RB1mjcsPwUR80x0rF8QSlcXogWpR
 cFlJTW00bw//FWYqCwt1AewMPPvphuYr7ZRrH8MHropQNzXWegQJPCz5y2AMK96H6Pm1
 i4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768226692; x=1768831492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UziT9209levcy8cck8gsNOynkewUOtZyDWNcEauP+8E=;
 b=Xn695+64yqTL4cCb1IMdabafAO5zfl5sQekOLi4R8Yz3HU22rjzyRF/vTOygdJGscJ
 WEmfxx0eR7DM2pXn8pRIzFbW1/LyDTtHU6ed/raKC0oEJylIBYuoQnk3YHtsPZQEvqU2
 4UpX69uyOBenYOVOKCNzTy9+cLOcJBWty8TtoNgUBALr5BLMe0EcMl7fW6K2Lhb5plqW
 PlDOba7xBYxs4vIr3P2OsSQVxO1QJNsA9asaH4pRtQ3zbzVwH9e/0KXNCa6UiypU1VLq
 Lj09PHtWmk2mS4xh7lEHMoaiAkEQEp8qmR6iVa+hD3Zwp2kGv6H6uUkR2c5D6lMQRHIq
 iE4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvW9086gsFIdL4ybqHDNC4f3cNcUAEnKzG3gldj7CsGWe3n9Ab1W0xlUVoExVIpJJweTZnNzbiouK@nongnu.org
X-Gm-Message-State: AOJu0YzGkx4tpYIDYAWYTviOw1OGFv/5XAEAE5TjH+9HDhudtGvAeEc+
 LOhUjk9KNjmNzae1zzYFhXpq2+uF0gBRSIfeRgR0hopv0+XISzE7GOQLUusOZEit+kDVpQaQ2q1
 sRNkfLeSukJ54cmUEqoj9wRPClFNoVMwtvWkKEHqzgg==
X-Gm-Gg: AY/fxX7Q/8GDA75uJKoV784fzKyaQwMULjkEBuTTuJSmFGC7AsiPjz/QVD7bL6K0Z4i
 gVgc96MTSN7D0s/ghCFQ31JwImQl6Sxt64SKeI7QQ6odFyg74YQ8nssFS+LOigS3kTIVwiwbxIZ
 WmmoPHtLa3OJ6SD/uRJ+jEW3acif3HjbIeHi76/uPx7q/CH7RBwTnj+4ea7vq0XAm9UCvjrJYQn
 xdz7gnFhzFpptiBc3i3UeNV7boANVzm5OMGWmU7niUKtEy4YdYf8D+xMXvRGJP4Yyeo3ChbidG6
 ndQ5H6dWERpFnrBrdyn+iPc=
X-Google-Smtp-Source: AGHT+IHaWY6mtUI+MKNlCASlBsnCdbvPpP8jKKDOD8JdvnrnBHLfXAXKXOJ1SyXNuG5TW9I79NZBDGkqmXcn+DDAUJk=
X-Received: by 2002:a05:690e:dc6:b0:63f:ac4d:426c with SMTP id
 956f58d0204a3-64716c60389mr14968462d50.51.1768226692211; Mon, 12 Jan 2026
 06:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20251128162306.13701-1-osama.abdelkader@gmail.com>
 <CAFEAcA__=TnXrcprp464uw6VNZKLcSBKYP0oj1T2e33Jysk18w@mail.gmail.com>
In-Reply-To: <CAFEAcA__=TnXrcprp464uw6VNZKLcSBKYP0oj1T2e33Jysk18w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:04:40 +0000
X-Gm-Features: AZwV_QjQJ5sdAKDpNqyh-BjZDX8pABqp_2jlqicBTsUe4g6mGxkKvooWcxfxj0Y
Message-ID: <CAFEAcA96T8JJ3K3OaGuhpwgn1A5QwwyNEfx5h4sChON3U_z_AQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/raspi: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 2 Dec 2025 at 10:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 28 Nov 2025 at 16:23, Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> >
> > hw/arm/boot.h is included twice
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  hw/arm/raspi.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> > index 81d2fa1b67..bc723dd7d6 100644
> > --- a/hw/arm/raspi.c
> > +++ b/hw/arm/raspi.c
> > @@ -24,7 +24,6 @@
> >  #include "qemu/error-report.h"
> >  #include "hw/boards.h"
> >  #include "hw/loader.h"
> > -#include "hw/arm/boot.h"
> >  #include "hw/arm/machines-qom.h"
> >  #include "qom/object.h"
> >
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

