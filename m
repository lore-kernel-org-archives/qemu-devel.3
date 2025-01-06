Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C2E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlLo-00075P-VG; Mon, 06 Jan 2025 06:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlLm-000753-NX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:32:50 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlLl-0003gu-30
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:32:50 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so16032275276.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736163167; x=1736767967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BP9c/i25v5UW7WE+BIN2xQjuUJzNiyXyg8JOLidi03k=;
 b=x1viCMax+tonWHlQ+LB1MG2S9psRh1PIXNEU1vG2QHdzMR6yk9/alcKPPhD1u95jVc
 zBaGh2k2f4lfziyqQw4gDW0ZCQ6CEpsHkNQ4GasoO9WrFioZwD162EKO0w5HHrwwepMx
 cImSQR0ZY3u3NUV+NSnIdUBdLyLapyKalFJI/utTxQAgi54ykL9CUPkmfXuNiji/sldt
 rfKuowzdeWEvNpUTFUineNBMShVKKyRReSP9eoCxulGz9jEF/1mryu0530DJuQuuhtaY
 SKLr+nQe4PVVrFjuI03y8syYhuJ5GmTBg05gg0u2vMemIGCA+C+5Km7Zlb9x0m+iyB5b
 nW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736163167; x=1736767967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BP9c/i25v5UW7WE+BIN2xQjuUJzNiyXyg8JOLidi03k=;
 b=o1s3cGqA/OUiJdxn17SLPD5mmJWKL7X81r4XLHYBWY200Zw7CA/TPgTbBLUgzvcKNU
 fHn34OcKe35yM5xiOgEcUtAUktaAZQLxDcnPTWBzDaE3AlVzs/54sjXEUHE4nDwlrIjI
 +v+1S1IWG8m3n4buzmxMYoqQpgip/MPNgicLTR6RIRw2u7MpzgMcbLasom2LdBa4bNRf
 cKTXrWHq5AbPcVEeYABUdONTGvL8UfH02d9+CFf0szzxz4Kz2WrbJQQI4T8VFky1YdVE
 ufZHR9v5PYrGF1wCs8rsbgaohxyyO9FE31f8IpSLvbmo+h968sqRvLBij48v73hkMjCL
 7sfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1V9+gJPO2ORIBI8omMHwi9cV+4fzX1/VbaE53HMAZbJtuLWpJZrU/GDtlK6pGA82bUD1nvjaBvgy@nongnu.org
X-Gm-Message-State: AOJu0YzMBklQ94uvIUhlhpMERIIZL+UKmt+jHfm5MGUci3ge6IwPPM3z
 Wupf4K4d0OpxFV9Yb1dJLNHf30iZKXVaJ9a4uBEaa2WxUwz76YFPOSlgM5DyqriZV9+HtRXzgDg
 xGPEF215lO9vBfWH30fCBBJVwf0nvBZaXU0pb8Ag10b2qJjZ6
X-Gm-Gg: ASbGnctSqxUy4LEM2JQONsGQUTvtBXPeFP4iTH7EIBtHAgcO4SMiNR+IqemAMgSvYs/
 yquPW07NT4Nc6urz7ZBwMyRQz8yUTBiaUMoVdI/Y=
X-Google-Smtp-Source: AGHT+IHd9ZvzXjd3AkpbVwFFjOXVXQ1KoBFvg+0XSmZRjue6bvTHg3NX4RZdUtHq8bbYxo9eF/8ugR32fApEwFr/0ww=
X-Received: by 2002:a05:6902:2011:b0:e49:8b2:2022 with SMTP id
 3f1490d57ef6-e538c40bdbbmr43046991276.47.1736163167521; Mon, 06 Jan 2025
 03:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20241226141626.28722-1-tsogomonian@astralinux.ru>
 <87msgikqkq.fsf@draig.linaro.org>
 <e2773daa-f819-4b71-b5c7-7ff8efc8d6b6@astralinux.ru>
In-Reply-To: <e2773daa-f819-4b71-b5c7-7ff8efc8d6b6@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 11:32:35 +0000
Message-ID: <CAFEAcA-jJ0qgsxL-vrNkOOMr8Aug8pQtDqpkD=0J8gLFFeqQjA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: cast nand_getio value to uint64_t
To: =?UTF-8?B?0KLQuNCz0YDQsNC9INCh0L7Qs9C+0LzQvtC90Y/QvQ==?=
 <tsogomonian@astralinux.ru>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Fri, 27 Dec 2024 at 10:55, =D0=A2=D0=B8=D0=B3=D1=80=D0=B0=D0=BD =D0=A1=
=D0=BE=D0=B3=D0=BE=D0=BC=D0=BE=D0=BD=D1=8F=D0=BD
<tsogomonian@astralinux.ru> wrote:
>
> 27/12/24 01:49, Alex Benn=C3=A9e =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Tigran Sogomonian <tsogomonian@astralinux.ru> writes:
> >
> >> s->buswidth =3D nand_flash_ids[s->chip_id].width >> 3;
> >> <=3D 16 >> 3 <=3D 2.
> >> x <=3D s->ioaddr[offset] << (s->buswidth << 3)
> >> <=3D max_uint8_t << 16
> >> With x << 24 overflow is possible.
> >> Other cases are similar.
> >> Thus, need to cast return value to uint64_t.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
> > This code was removed in 192f75ad11 (hw/misc: Remove omap_gpmc)
> Yes, I saw that upstream master doesn't have this code, but some users
> use stable-9.1. I suggest adding these changes not to the main branch,
> but to the stable-9.1 branch.

It is not worth the effort. If you want to propose making
a change to be backported to stable it needs more justification
for this, e.g. exactly what the failure is, how users might
run into it, etc. "I ran a static analyser and it produced
a warning" is not enough -- you need to look at the code and
at what the device itself is doing. At which point you'll
find that the function is not used in any situations where
the eventual caller cares about the top 32 bits.

More generally: will you all please *stop* running this
static analyser on anything older than current QEMU
head of git? It is just a waste of your time and ours.

-- PMM

