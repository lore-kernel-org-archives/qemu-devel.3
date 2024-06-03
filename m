Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0636C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9Mi-0004IW-8g; Mon, 03 Jun 2024 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE9Mf-0004F7-Hq
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:12:50 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE9Md-0004ip-UE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:12:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52b894021cbso3839175e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717427566; x=1718032366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFUcXpOs8LuKXpB3xp1QT8gFCh40XjLHsjXXilpajs8=;
 b=po4xbwkOwoM1QPSJmnRLYG+yNpmE/88wpSxscLJAoB3oI6NfjsJL5tFQI3/IFEM04J
 feIY2LEzbaT42QvOL2Uu8514yVBqDTQLWrDqNBDk1Zf/LV7+ZhccfIIGiOuFvEOu5HwO
 x7gXupt8kX3sQQalAP9ncwsJK10ZvPs2wTu33WVdPRCQoVCtSeDu9udOxltmnTMV+oPi
 fbBCfrzYlOlyDmHmDq0Dur1cwR9nEM/fZFG35kTcd64KQiSA4a06Ag9WG3UKKQIQE7V4
 Z2jiF9UfxymSNBJKaRtpXp8/3ydDPVh4i0yW0S2eQZCEzBAsqbu/GxSN/pMYCZWkr14U
 YCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427566; x=1718032366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFUcXpOs8LuKXpB3xp1QT8gFCh40XjLHsjXXilpajs8=;
 b=pa5xC0QDNspmd/kXugMoW7hfFsurjb542G3uvAOoQrYgB6Z4RmaH/PSvY47t/f3FIZ
 d8XRnbY/EMTdhT/5/quYnGWMNAi6XV9UXV8bHe2CMjV1quayx8fxeUTo93r0dzm92htO
 Yc0ya/fbaAVuOPN4nOg/J2pFHwXK+K1KoGigcGi8TAzW2DJonEnCb69nphYfq3/W2kgL
 AiegJQElQHBQeqK180knvFWdnaGjQRjGuu6tkAuvJ6Scr8C+88D5UXN7pF6/d15Gn89a
 AwUfP2xphPrBSy+xRR85KOTCnHifRlbJkpxUIi5Qu+j7GXJ5GQNnKkd6RSE0gJsCpcGO
 V0ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdW9sWAVPK36pMXj/PenANGuMqp+88Ylv8Aj3bxkqwB9+FL8XunR1DtGYnBWoAyYP6z2QenrMPrnSgU+NsdFgnatlrzek=
X-Gm-Message-State: AOJu0YzhGR8IWxJ1IMYfqsE5PNCUY9z56EZYlP4CDEpcwtWiSoFHcON1
 dJXkhf5GgSE8dEFKeNaORLBZE51lTc59kv9nd+hhz2RIyOAopYWzI9l15Pp//Ec2pyKY2T3LVJW
 LW4hIbFwQz5UyRIFPwAgsslI4wMRf8jz7BdcagQwtHoEnl6p0
X-Google-Smtp-Source: AGHT+IGF3RQ6/gcXnucJvEqL++Dv/CC5Ck7dKEkOpBDMEm/H3ScxQ5/9Unho7ZcPInyoDxXMiM/lUbRKeLwNSYblbrQ=
X-Received: by 2002:a05:6512:2385:b0:51e:147d:bd2d with SMTP id
 2adb3069b0e04-52b896b47f5mr8367070e87.39.1717427565777; Mon, 03 Jun 2024
 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
 <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
 <Zl3YBQQ5yWdQoH4y@redhat.com>
 <CAFEAcA_kkM6VgeVKxbSB_=UHOn0a6aFFUTUOeNP4otEoboYtvg@mail.gmail.com>
In-Reply-To: <CAFEAcA_kkM6VgeVKxbSB_=UHOn0a6aFFUTUOeNP4otEoboYtvg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 16:12:34 +0100
Message-ID: <CAFEAcA_QPwi093sB3jSD9EcJ43q2vvZMHwJ58NWqWL2-4soo8Q@mail.gmail.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 3 Jun 2024 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 3 Jun 2024 at 15:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > We can't rely on the sanitizers to catch all cases where we're casting
> > functions, as we don't have good enough code coverage in tests to
> > identify all places that way.
> >
> > Unless there's a warning flag we can use to get diagnosis of this
> > problem at compile time and then fix all reported issues, I won't have
> > any confidence in our ability to remove -fsanitize-cfi-icall-generalize=
-pointers
> > for CFI.
>
> You might think that -Wcast-function-type would detect them at compile
> time, but that has two loopholes:
>  1. void(*) (void)  matches everything
>  2. any parameter of pointer type matches any other pointer type
>
> It seems to me rather inconsistent that the sanitizers do
> not match up with the warning semantics here. I think I
> would vote for raising that with the compiler folks --
> either the sanitizer should be made looser so it matches
> the -Wcast-function-type semantics, or else a new tighter
> warning option that matches the sanitizer should be
> provided. Ideally both, I think. But it's definitely silly
> to have a runtime check that flags up things that the
> compiler perfectly well could detect at compile time but
> is choosing not to.

Slightly further investigation suggests clang 16 and later
have -Wcast-function-type-strict for the "report all the
same casts that the sanitizer does". gcc doesn't I think have
that yet. I didn't spot any option in the sanitizer to
loosen the set of things it considers mismatched function
pointers.

-- PMM

