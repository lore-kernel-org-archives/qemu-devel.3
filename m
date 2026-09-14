Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A71C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64pC-0005WZ-1H; Mon, 14 Sep 2026 07:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64p9-0005WM-Ib
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:26:11 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64p7-0007r1-Ak
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:26:10 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aae3149so1376913d50.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789385168; cv=none;
 d=google.com; s=arc-20260327;
 b=qljzFA2sSree6Hp1i4EyWZoPHGGI/H9QplIH6kWVafXbJSIneQniKd83JwtdAV6ENf
 qYOF7YP1NBuO2eTJEewcdPPpgankYm/fITQhqbNlBz4ZCHa46+T7sQInqkScYTCLJxgz
 PTS9fW2bVeVAQqxNAYYYrSR74YqztJl505dj6z2f6vdTLcGcJxIk0/XcTPDg13faE2OF
 O1H/SB1FpAeF5ae4C5ARCjNjfbpAvcR1zA6vG/lWZDM9EgPUNFsXrXJVnNLY+anhjbtH
 /TCp5UY5PECbzwBDjsEmsxvzTqQWukj3evLYR0UkRziYhLylaRgWN3GoWne7wNoczwLy
 IFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KGXd6U3Obv31kSVPrgdwb04PokF5l5JzigAcSViv3CY=;
 fh=x+uSFHiOneA5EuBGK9BNiePh+uYk6UrctUlmv5nF+Xk=;
 b=L6c9xW56O9+37sH4NxGKBzXspTmmGbIMw5o9hi3mkLvcyQd+j5DP2MztJ26p08AJoL
 4srmDDK6UV2LXo20vQDA3vLjXUUa+mtVnbtdNla+oYPHX2NrPsL/KPybryZPpiE8XOgU
 +wltn4CaPHYO4Xbpr8090Ki8e4dSRz48yee/y36E0qBC35uyP47mDtqTvaj6TyT6l/5M
 2utQSd5+SzMQ57kJl1E8l4qKH/rdZOIqMIP7HkFVL9GFiyZfcpcw+WuFNrAETwT86KsI
 8nukVKXyLsvGZp1VWV3atseKw2r+sseD0XemP6j4Uj1lm7HCL+DuozZHkkuQsFx8Okx+
 a48w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789385168; x=1789989968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KGXd6U3Obv31kSVPrgdwb04PokF5l5JzigAcSViv3CY=;
 b=iU3NRuOtl/TLT1RNCKR+GW51XmMu6gz9uMTO+hUeVpsrnNV6jvwDNZcgg56FgJVDSt
 bd6Q6DIgJCEczhR6B+oZ5tbb/xQF7WEYAm7mMS4AdVlCIcP5Fv3LbTyejH1ncGSWUO4F
 ma5SeSUId70EVf275SFtHMHo8H22FwqZCCI8HCsoXXfjm5YnibNeMHyNvHiOc5WpqEN9
 zNLUE/R+ELpJDPuUhZr6A9e364aD90Dr6F4VKZ7h9uk0yL4lNyvymFTwKpQKNOWs+Dju
 cTq247A1d5o+AgP5SXJ6cN3dAGsAeo9QC2qLjTGYYUkQSPVPoGK5x8YmlMRCM0z4VARq
 xnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385168; x=1789989968;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGXd6U3Obv31kSVPrgdwb04PokF5l5JzigAcSViv3CY=;
 b=gAnaOStX7JHT1cCzGAkApb87OwLqcDYDtiROyseusvBR7bAmzFsU3BcalylMYrwWxw
 tRBd2uHzltgHoeckXyZFnVKyMXZ56thaK2Sti2p9vkAW9lHRTfVLgy2cAxFL04SmrXK/
 rXXj2Zga9bWam8ZUq442aip52P/V0LEICZKmyDGKoefizjWBBxMqF5FBrbdyYNrxLbS7
 BO/t8y2rF0g4zxxtG4ojyHRihE2baXjmz47OQR47ytyo6n8nICKptmuIQMA0Ygc+Mw9e
 SvNqBTnF/jfchql1Tvovh22PnA6IQSzz2h6MMLPsdSv0fF9Hu9xEsrXgjsx2sTPvEKcW
 ULpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVLtS4V0bNWMWPfda+4v2v8GGW9hsgFetTGcTtNn09E+yrPBfO3dlqk8dK7xvoWq0yZJbwAAQ350jH@nongnu.org
X-Gm-Message-State: AFuF++mv3T54XaajstPJPoXOXTmnFyZWDLz0k3Oy9VTHxgNqSnwkDI52
 DbZbPOXIVwgCCm+O3Md31OqLWbJecocrEsGgMSbpu9evi9S/i6m7u2hph+lFO6vPx5m+NuzR+zR
 IYdLvarv8ol17mhGZ0iG1R6CwnhO+q1c/HjIJlYStMg==
X-Gm-Gg: AYBFou3E9vY97oLo7XmkFqvjwW/YYAPObAsnnQrGZ4MmKOzUbjkBsIbyWY5LcJmW0dR
 RT0RzKkuS5aWkF7Aw9+c01c+7qOKliRRQvIUdxTYcwTZXGzFeQMHtjnwr8iyRswpsUnekoSBDtH
 0NG6acrS4N+kpAFxACrnk4n3K87rjZgq3TOkLJeHCCpMuOrPyMQUURKk47L/ZOQyiZMG6rQmZtk
 Wm41Tg9kTzry3nJr46U1tVlJWOnatZEBK3OZlLXvhRIWTfag8BKMDuQZLlarqN6hD+Cu4n3Bbse
 5WnCriRmF0H7gfbapUVgufwPjPp7SJt7US0SBtrrYOSef6Hc59XmsNBRCHhsPkuEeBC6d+ynDcz
 ukqp/ojpfmTFZdkeqFFRwek17J3A7DgU38DpPbqg=
X-Received: by 2002:a05:690e:1685:b0:671:158a:ef96 with SMTP id
 956f58d0204a3-6714dfc87fbmr793275d50.11.1789385162944; Mon, 14 Sep 2026
 04:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-bcm2835-v1-1-b3719ca0df13@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9aJJc_yRNYbATjA8d4ggZr_B=r5EmVNma1rzhi_ZrWLw@mail.gmail.com>
 <CAJ+F1CK3eC-t-uBDuCSd2VG=-hx9v+ev8cRf5_xh9oC=04O3Og@mail.gmail.com>
In-Reply-To: <CAJ+F1CK3eC-t-uBDuCSd2VG=-hx9v+ev8cRf5_xh9oC=04O3Og@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 12:25:51 +0100
X-Gm-Features: AcwNN1XN6kuQlPcZ1UAkEa2egw5zkbIeTGPudMOhp3ltCnUL4_02rdB0wAySaZU
Message-ID: <CAFEAcA8ysxWGFO9ER_HgU8P6j4uZ3gcb=eN90-1J2swYD+KdtA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_powermgt: Free the watchdog timer
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 11:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Sep 14, 2026 at 1:32=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Sun, 13 Sept 2026 at 07:44, Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> > >
> > > It leaks with introspection.
> > >
> > > Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watc=
hdog timer")
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > >  hw/misc/bcm2835_powermgt.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> >
> > Hi; Thomas Huth sent the same patch a few days earlier:
> > https://patchew.org/QEMU/20260910175001.76278-1-thuth@redhat.com/
> > so I'm going to take that version.
>
> And earlier!
> https://patchew.org/QEMU/20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com=
/20260906-nohmp-next-v1-3-2b21e63974f3@redhat.com/

Ah, I missed that one as it was inside a larger series. I've fished
it out of there since yours has precedence :-)

-- PMM

