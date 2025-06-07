Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C8EC5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 22:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uO2KM-0000ZG-GH; Sat, 07 Jun 2025 18:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uO2KK-0000Z3-3g
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 18:47:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uO2KI-0004Fz-Eg
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 18:47:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so531292266b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749336464; x=1749941264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4r48hg0+zle6nHOAQEg30AWWLQwZnyGI12HsioJFrg=;
 b=LL2bXWgqQ8dB24nAQrItKqRkcp1W0oJcR0efhCO705Gt+akYHkxkIm0YKtocnRL+mE
 mcOsttUl2TImomSWSRajCsv/ODtpNGPKPcV4tjrvVWLjIsfLxvUI/42PFBlAlG+VTb3f
 zSvJ/tMzllyDgRraXOeKLdpY3I9420f5hpBXu77x51vSQZRQAJy+LXRUN5oBFIQ1zb5L
 6HhSDjHxJqbZ6+hs29mIQtL2EzO1ABqa6Tm21C0Opmxpd/37vkQXj8FtTMwlQ0Ma4ZTr
 KrezXjrr/jv4kUvCdDRRYBWn7inORTUtJpkoYLe5Zi42tY2I0guU5nYQcrJTJ56l56PJ
 ejgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749336464; x=1749941264;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K4r48hg0+zle6nHOAQEg30AWWLQwZnyGI12HsioJFrg=;
 b=GusrEKq/3xwUZsJLPh/7jAQ3tSldaaqLsG4j+Yu2SzUYMWY/fCBGCvk8/Sdynd0OTx
 uQKZXRHYGyhop9WDbFUnuxgk/7/++8TahCOdmHk5DrjdvzEvE1XpCUiHtpD/alr4n9h2
 4V9gaqT1vpy6gjLTmv1NS/INNIfzyNNIyVKLvBpNdB7W9NhZfrQod5vTIv7xfmo8dUcu
 x50pUILZH94M31PKGPOL7WE752jzatG+8ZE1JvTDAGUxJCT7qfQKY1+FzAG/bI+YKwO9
 0uE4aYjyWNfxvqjbsEmGeQMe/aNi/u/8q3kGHnecaNXZ/bdE9Z0pV/IM26z9e3CIMiMM
 rFrA==
X-Gm-Message-State: AOJu0Yx1VB9DAbhg1yiNcXYVvjvf8Da5pddb57v9rwoKDUA4D6B4kuLP
 Oc1tL+r4D4s4X1+nCl6TJpB7N/AOMWmZ4vDZtNnuKaqbthd9sFMuhtiT08m3BYMSBqXKgbQiKkw
 EsRbjiT8=
X-Gm-Gg: ASbGnctlLIXtB9pDHk4LtYVDocZcl4A4mTEa3/dtF4XLm412KiChQr6e1hbzmDsrltT
 Yyv4dAcNpjxcZZO7G9+CJnBvJdmLddiiIDx2B5Epcj+9RF9jbh0jADcvzrcFXvncyhC/hpvnLZT
 5cP7tHN1Rgu5kM2KOZkBZQTCjjs0pVJExXJLhph3xnnLkpA86BUDfbX+P5O9DFc/ODglBfXNfdU
 fvA/8iE26Kl1p187gTwgeuYFNT1JPEgaKikWgjga56x1utj9QT7+GrJQYSlVXe7lVZ3Yfm0nuU2
 pI+z2q2OQngAovZl79+U8NavcHL7wOwHNNxW3ZDDULa0akqTcszOA83ZlycKoV0=
X-Google-Smtp-Source: AGHT+IEp+hJBYE+k5Wi9woN1BCWXmF0XSON0IGmbVpxQtAv8qrI2U3C9Prba15cfSP1nVA55pl1OCw==
X-Received: by 2002:a17:906:f5a3:b0:add:fa4e:8a7a with SMTP id
 a640c23a62f3a-ade1a92c81dmr700933166b.34.1749336464516; 
 Sat, 07 Jun 2025 15:47:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c771sm328377766b.103.2025.06.07.15.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 15:47:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0D735F86B;
 Sat, 07 Jun 2025 23:47:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com> (oltolm's
 message of "Sat, 7 Jun 2025 11:45:04 +0200")
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Sat, 07 Jun 2025 23:47:42 +0100
Message-ID: <87qzzv88z5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

oltolm <oleg.tolmatcev@gmail.com> writes:

> Sorry, I forgot to cc the maintainers.
>
> The build failed when run on Windows. I replaced calls to Unix programs
> like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls to =
=C2=B4python=C2=B4. I wrapped calls to
> =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the tw=
o paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>

for plugins:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

