Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1754110F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYGi-0004Ig-DC; Wed, 08 Apr 2026 15:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAYEo-0002rp-U0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:07:01 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAS6g-0000sZ-Ej
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:34:07 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-650775f427eso2659599d50.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 05:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775651644; cv=none;
 d=google.com; s=arc-20240605;
 b=DsTlXxuD1kpO0K9FF9gPWbXFmyFuM+uee1AV+QRnhJ75UiQRXZgxPwUHsIPa/gGk/6
 cnsxZC+kyq7O0Kq2OFF9r6TTd9xlpQJHMitAwoENh4SThOqXSWYia7ciI45g6bk86q3M
 j8GR131EkVwv2KsY2grehmXi0qP4sitHKAR1qJcVy0eIeLH01hKZziDQOyrYDvFoSrOB
 tIJC7g9TqMAmVoYr4Zig22+4YJG9vDClndMbz4R+JNZtpTD/4omcL7WobrEH9uX3Wb3p
 Yy3h4WcWmF8gPS9krGfd/oVr037yn8RJmDdVu8rkix339WHOqAuQwSfB/SMtpeU7X7C6
 Fq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iiwlYj7Rj1l2gx7jfccv1l8N+qYJW4WagLV6QjrPrxs=;
 fh=xY81o1QTnI2XKDfOt2g2HcXUXRE4KU2wXXSPt0G4hU4=;
 b=Mu0NQXeRe6yeXxsB7gnbiKvYn+DFcIecT13KKZgqqFb66petHVwC/iZ2vN+8iWemX0
 BggBwZlwhfiKOGvFFH7SzqjXpXmYA5bi0OlEGXv+q32Xpbh8w6zzMlTFnGRANFd4oPrW
 0iq+b9GhcToNSFT1Bqay5SkfAvbLbwFCUkK9rbVXFKzEslQADEHYTxzmCJIwNvUUMH4n
 E+5jvHpN5O+kKdWXVhO/iqLRhXC0tJtGDY0PZaanmTr1IwleMXhTaMJUq+dsVC+x589c
 9hssxaIA9nzSUmCjdHWOGGY6vd6PSIQ1Xc9oKh9XjRfFwSh6DWbt2SiMUpaVZZmxdA5p
 OyIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775651644; x=1776256444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiwlYj7Rj1l2gx7jfccv1l8N+qYJW4WagLV6QjrPrxs=;
 b=jWeT2Bm3zq5NN/ag/sYwCla/AFBXcasOZSaiUCUS38R/pSIR5zTpS9hWJ/FxsFm2TA
 PwcKvzjAkP9lswOQxq2UiE2cJoEtOlAn/Y3nKxcKUFNeFYdmaT+elWRjOFrm721HCnLO
 2PNUYrLeeyWmUPCBj+VZpTUwsMufN1UNu9Ic6d0lN4ClTrb4TghE9FvTlXW1/t3Etbtn
 eqiquXeduc5gvtTU85ed1jjqnXjpkPwVuiw3SBY6yjjuTNuQCnJJdkhCJw2hbXuzq9sQ
 z1BAil4PpdIcuJnlm6ZjHtf7+vOATawif4HkjzqpLqgPKQTJZtPoVLKwLRRJQRRs1A9R
 lasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775651644; x=1776256444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iiwlYj7Rj1l2gx7jfccv1l8N+qYJW4WagLV6QjrPrxs=;
 b=Jv7uBgE6WCH52uR+tRy/8wynFcHs03DYo+ffJyU2TO0zwYVXOO2Xcd0EHCQ8nWgWwK
 rMDUd7f1tCWDeCwJaZ+xadtxyCF30UHgP54qY6IyBGIEM31QDQd9U0myAZQrfxjGyVdT
 8L3COU2EVd9n8W7fmj8Rc7ZGUP5xArrDlkU2k6HxA0TY2hBfBWRcuoFIyraLq/48Hgh+
 SEnEIc9VOwcohfOw3lmV8nDqvijs0dEkPxMKIWYPwU1a3Ry1sj2cy1Dc1CFN040pEdZi
 AKDXJv6yBqrcflj+cPWfYTw/2jAbm/ODQ1TibrXeRZ4dYf06TxM0X6yL3iyGDajPl/PO
 DM6A==
X-Gm-Message-State: AOJu0Yx3sqMbm/mBKA767vGfFlU97ItoQ5lE3Vw/nqgqXqjtNyg1EPoW
 sFUpaYsaNURycDDg+A3xxgitxaeUUfSnph2887fLSlbkG8p/qdnC5aE3piPoNDqECnedhRPl+TK
 pXG2vJQozCLAGYMNpd0RgHTjUfBUscpXveJGwkn0bjw==
X-Gm-Gg: AeBDies+ChZBu6Lwycr3H6NrLWHJDWIy3QeT8iGleBdIdBoLhZn2rmxz39eLD3L0tNS
 kF87CSy+SFiRKe7DoyRrX8xjJPawpwW0DmwXmNsB9BZLHoSSzO5w0PidUaLQl4vL6Wc+CBRmmC8
 zHjufCpKGen7MZcxMNBUAef+F/jon7nsBjKYEV04DydL8Qhwh6Lhb9GB1EBKZ0jeJ6TiZ82e3Pp
 XQHL3Fbex+nd48ZUDEMYyyp6naBwsS4qePEXIWCo8/LMdPiLWAsa+qnUWOT0xfepFW1jyqnw0fI
 QoUlBjiydzKNYHjRudNoVIgw5Ag0C/pTde9o5pUXDS3U2JPNx07VAgraTL+3vMbFJp8=
X-Received: by 2002:a05:690e:484f:b0:64c:bae1:2149 with SMTP id
 956f58d0204a3-650486bf562mr14251247d50.3.1775651643877; Wed, 08 Apr 2026
 05:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260406165648.997995-1-alex.bennee@linaro.org>
In-Reply-To: <20260406165648.997995-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2026 13:33:52 +0100
X-Gm-Features: AQROBzDtZ6JypcRfRnMs_97-H3nzLiz2-t7CK22vrtOYkdg0OugS-StL2K-JxtY
Message-ID: <CAFEAcA82NhuNk+SQjxNM1eHuQrc=zeVOAmax7o1TEcva+XxVbg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system: remove extraneous sentence
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 6 Apr 2026 at 17:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Lest we confuse the reader about something we are no longer showing in
> the example.
>
> Fixes: 132f8ec799c (target/arm: change default pauth algorithm to impdef)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/introduction.rst | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index be387a66458..bec7291e476 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -165,10 +165,8 @@ names so we can override the defaults later.
>      -m 4096 \
>
>  We then define the 4 vCPUs using the ``max`` option which gives us all
> -the Arm features QEMU is capable of emulating. We enable a more
> -emulation friendly implementation of Arm's pointer authentication
> -algorithm. We explicitly specify TCG acceleration even though QEMU
> -would default to it anyway.
> +the Arm features QEMU is capable of emulating. We explicitly specify
> +TCG acceleration even though QEMU would default to it anyway.
>



Applied to target-arm.next, thanks.

-- PMM

