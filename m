Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4960D2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfd2j-0006yL-Nu; Tue, 13 Jan 2026 06:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfd2a-0006wx-VO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:58:30 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfd2W-0006q9-LF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:58:28 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6447743ce90so7494680d50.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768305503; x=1768910303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh/9G2A2vbjrgibG+mQpLE/oAdLwICaYy7XTwVszBkM=;
 b=UI9QJaFohZlDt7ooP/FFHZvfYOJkumm6CVaTwwc1gGC9nZYCod9GvifVpOCB+0LaRv
 8y7pedlvh8jqVuBdrb+i9Femv4etC48YmEAhDDuLmiXal8AGyjDvbX3to2+6Pl8AstjE
 KSAk9usynd8pm25hZu2qKQkdKwrkx5w48XPH01AamKyuSiJ2lklWVz4F2lEyEcL6Gw/T
 N5sqNebL7s1w0nzubeBAyKTm1LbO7lt/CJmYp5ZwQ1wGRa/x10c0DweYn3oDDYGefUEd
 ArnatP+LC/0sFwApB3FZl1rsTZEl7bu1WhaH1az2aa9fYlwTqKBeAGK3ooXOqtNU5Hnv
 +9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305503; x=1768910303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kh/9G2A2vbjrgibG+mQpLE/oAdLwICaYy7XTwVszBkM=;
 b=wtZMP2GmWEi3TBSrqLKBnt3hU5gr1x5pb7VaYCmXFlvZVvOgdr+PGp7pnC3Fdr/KKC
 PhWcpg/6vh9bQUZpaBgWixeObKB4JhijgYe8btBZZQnTTvyXjhhbXGO9tU7K3HwuOyNZ
 x+HQ409rPj9aOPjOkfg1LfHcC/fC/OReDz5p9ZvA82z4+ZZAX9e/T97rk1q1AdINFmG/
 dblsX1EOPEbAP1Kg3PArJLjHG0xyRQ0kLxDVs+w0TAS6vdLmQBOypq0O5B+TLpiu1zti
 bEe+x6jYF4Ks4ha5x+H6QVObT+5RRAMD4b1tySBF78Qd8aAs6MAb/vuvz6vppAiWiMf3
 uVFQ==
X-Gm-Message-State: AOJu0Yy3+X+sNEsdU0zDIlQcnqSVCsKqiPLXnoJSqLEKKgIOOhG9nhAC
 LcaPg/lPHyF5YWfvHAIh1wyZwLuqT/vTBqf1dpdJbFIRcEErRQ7YYEza1heHjZKZtxgLIO+QvYz
 M1fvAEnaZzGZK6xNLOWaJvYjSAtNEN0OotecigxQ0Kw==
X-Gm-Gg: AY/fxX53IAP+rdt6S1p0Arhd/Ft4fLLDMEEt3gWa72G/suE52usmbrUoSIN0C1vKCKz
 ypU23vc6xmnePih+i8S2c+II84uZDzX0XLO4IVyI/+npD+WDryj7Qcs5KuHrUQSICnNMxeD1tsW
 UGkV+HNM90l6dS20EQpymeb7F2JeebPc677nq2NETq12RqT1gueiteDQ/56ptvgR+3gtOBKGC5P
 v+FpMf995G5Oe+5UZE4N+mM3IhogEnwTcsOJ+w8u9HBcQIxhi614oWAGswedtPENvEP1W/h5ywN
 QDoyF5EU0TfC0sam7WmgGLk=
X-Google-Smtp-Source: AGHT+IFOuQtMvXSMQxIaewq76FcvljNQ1lLFbrE0FLwvdBha78nJYY/RWV7IryERXhSihr8nW96CtxBiF6at+gfFEtg=
X-Received: by 2002:a05:690e:4008:b0:644:7901:5e54 with SMTP id
 956f58d0204a3-64716bb9cc1mr16268263d50.6.1768305503254; Tue, 13 Jan 2026
 03:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20260113115138.3171479-1-alex.bennee@linaro.org>
In-Reply-To: <20260113115138.3171479-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 11:58:11 +0000
X-Gm-Features: AZwV_QiHwWrdj29HTjtykG9EX2qjD-fOWhQPu1L1Sekk7uDNM_9dMGGswiSYkk4
Message-ID: <CAFEAcA8Ot9Zsse+F8NUA3=qnaMoBKHDwT4nRSzzmaAx3Fgz1bA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: migrate aspeed_rainier image
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 13 Jan 2026 at 11:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> fileserver.linaro.org is going away, migrate to the new share server.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/functional/arm/test_aspeed_rainier.py | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tests/functional/arm/test_aspeed_rainier.py b/tests/function=
al/arm/test_aspeed_rainier.py
> index 602d6194ac8..025e5751dc7 100755
> --- a/tests/functional/arm/test_aspeed_rainier.py
> +++ b/tests/functional/arm/test_aspeed_rainier.py
> @@ -9,10 +9,8 @@
>
>  class RainierMachine(AspeedTest):
>
> -    ASSET_RAINIER_EMMC =3D Asset(
> -        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
> -         'mmc-p10bmc-20240617.qcow2'),
> -        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90=
b')
> +    ASSET_RAINIER_EMMC =3D Asset('https://share.linaro.org/downloadFile?=
id=3DPaCHfyerwpSr0CV',
> +                               'd523fb478d2b84d5adc5658d08502bc64b148695=
5683814f89c6137518acd90b')

Is there no way to keep the filename ? For the human reader,
"mmc-p10bmc-20240617.qcow2" is a lot more descriptive of what
you're going to get than a long hex string...

thanks
-- PMM

