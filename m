Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF22E6BF25
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 16:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlrHW-0005yu-T2; Fri, 30 Jan 2026 11:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlrHV-0005yK-4H
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:23:37 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlrHT-0000ru-Ju
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:23:36 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79492a2a57bso21822427b3.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 08:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769790213; cv=none;
 d=google.com; s=arc-20240605;
 b=Zfudxt/AgzoD9FoGDycSNaXY+5/PqHvNGmTzTyxAuPvDOhaIp4fyqrVZ9Cri3qwAGN
 DE+dh0C7bMQFZ/JJAFfZl6aN1QlwCkNJ+HGxu2ReMKG/BogetKywZDyaII/eZ4qHFixG
 4Da1XgulpSisUVZCW/Uf7iepQC2SM5MlU8gbMxmGcs5G/MSdG4dYvgRvykVjtSz17rIc
 FqKDawUg2MitmwZIJWLjGF1n3Lq/CGurT6deTYyjPIIDfP5dL2j97kvE8q0dbcyKVC+p
 9GXko8G76mu0+2PYrwDlsmgVjxE/ElX2SeH+mQjDm3bA7/81EQbs6gQn+1SQxgvr3P/W
 BRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qEwa/WyQGTWAW+FMrIdjEWhMp0kgJZJQQgEPoAK1UWg=;
 fh=J3PzjybaugvUOwx1lkMPY42EeM2OdVcmCsTlfmGJYCs=;
 b=MzRXTK7at4VvJY9GuILaTQ99UwhGbwrKrUXLwjOtnF/n1uSiZHI3jIHcsyaT3tsjvc
 Xfc7BqTOBPhOsJ2KLEjI7a5/5YryQn0JiN7cCk+/bCZz6U4axbrajeZfC7WuWAM4JNR0
 TH6O7WPacvnWct+hrV2hpo65G1T398aGkqq8xwH1PIlmy/JAkIMiA2wiqIElR/9W3yfJ
 MB2xbOOOTz3Nzv/Wzly7457AroXV44Eq1yxuyueE/ITJO9Vm2B5fdDxu32BjdTt4zgO9
 aKjrKcjwbR+ZjY/ea13JEjsc+SKx9UelJKW4i69fXjM9trEljsxLU0udeTXVm3DVZkNz
 Ts4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769790213; x=1770395013; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEwa/WyQGTWAW+FMrIdjEWhMp0kgJZJQQgEPoAK1UWg=;
 b=wrQ1gtmomCbyYIRLULhQbTm+PLcSiiKXfsEJ/PvDPapPrV0HhyArEwOs33EhdZroba
 HGazh11u9K/s2nNuC3X9a54rdg9NlUzFJ6NVxSJcDYm6VtTYw7zCWWO1nXWunxvPfh1f
 OWg/CqYyqYPyYYLskwZfLgMo5YyKvPPNXCj6tY6Xt6uNhSFbHwif8Zne/q0DRVGR3bRX
 siVWdYQUbnrmRR5s3vecF0xZSrNdV8/qB2ZQYyXdF/NbLW6ooaoz7ERQzP5agYzNmd/t
 VPIXr3f2fmaHkzm1TFYIMJ+/BTxaFSYHqCtUaMJBJ1g49HU9wD1Jnc4ibqZIR+tErvj2
 krSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790213; x=1770395013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qEwa/WyQGTWAW+FMrIdjEWhMp0kgJZJQQgEPoAK1UWg=;
 b=FLClbR68iQicNhHUJZuhPxEJStxFAxhuFOi3/Vwg1P3/kity5NokCTvYS8PANXrowE
 DMCYUKuMwmUerOvzWExJTYILM/hFhQc+wctXrCeCy14g4Y//6VWjVSAYxRnCqlr3DRZx
 KoprI4Gt7GfJ6rJJIIJGwtNz3bY4mKf5vLF43HL+vAd6+0FHULcYOXUKTzfCIxr0bsyI
 vzLGeau8SM/RebkVX0ivcT7K7ZV9j0DFT2qGNOct1TJbMkGMTxPkwzVec6Njhk6Nr/Xs
 RFHZdlMiAAExZKeQ5CJRsOMbxVHidQJOCGOSkcu3Wnq6RWzh53U1ZrYG7lUcjBw5hvu4
 JvZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN8yHqO/f5GxzJ7Nmg0DFwX8HwxcT4QJFYnZMXKTKpdmmpbmMRaOLBakw1xxn8KwRRwlNA+SHwqziC@nongnu.org
X-Gm-Message-State: AOJu0Yzc7/MqLguoB1xGW+D4q9DvsF7mR4b3sf16dGENuwz+96zSsuwE
 1IdjZtkSNe9sgrXW4QJBnt8EoD2KK6pkAOF1zwlkT02oh4W9xPEjEkJyYcGjFKHym3wJT7pLfPN
 gqomRzba94WIUDaHiJfDEk4ba0AcqtGaD+a6joB9bOQ==
X-Gm-Gg: AZuq6aJLKZ0GRtpBPi6IXle0qhy7zIXoBka/jY7QnFVkQEiqUSGjxTn7gvD/FTQN4PG
 wxelWT37YI/LfjGqjISWfq3KAgGrkazmzq0NMMSixiozKo5cCsAD49XQR45RQp64154/DbANz+A
 4EwGdpkChLmN7LlCDjyUbVi6tahBPN6f7PD+UlfdImVsRTlZ2oEFw/EueUrXx5MR8AyPs0SDL2d
 CrSrd5BLq+6jkvOWPEKkEFqqs27rqYzRpY6urfOGTVZXaL3tWTSRzeS3hrAeqKOX8WG/Q==
X-Received: by 2002:a05:690c:f08:b0:794:8603:3b2e with SMTP id
 00721157ae682-7949de65372mr31523467b3.4.1769790212789; Fri, 30 Jan 2026
 08:23:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHhgW4UH=_65pZJEACBXh7J0XN1SH1HFS_e_FCN8Zm2sKa1sww@mail.gmail.com>
 <CAHhgW4X-R-Pm1ZV20UuBPbCtnSmp5r1HkwMjWMZ7KuVX0Cp63w@mail.gmail.com>
 <e0b9fcf2-d4f2-40ae-90f4-221268364501@linaro.org>
In-Reply-To: <e0b9fcf2-d4f2-40ae-90f4-221268364501@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jan 2026 16:23:21 +0000
X-Gm-Features: AZwV_QgdUAywXsDNDJaoCeNv4_aLk8hfjZ652gmU1_uYD_bwibeUd0AQg_1TIIU
Message-ID: <CAFEAcA-QAuiNH1RdkqsxiqKSungGfbPGgi+eAESyd5fU7AyFJQ@mail.gmail.com>
Subject: Re: Wiki Account Request
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Yodel Eldar <yodel.eldar@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 30 Jan 2026 at 16:12, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Yodel,
>
> On 1/30/26 3:03 AM, Yodel Eldar wrote:
> > On Thu, Jan 22, 2026 at 1:30=E2=80=AFAM Yodel Eldar <yodel.eldar@gmail.=
com> wrote:
> >>
> >> Hi,
> >>
> >> Can an existing wiki user please create an account for me?
> >>
> >> username: yodel
> >>
> >> Thanks,
> >> Yodel
> >
> > Ping?
> >
>
> you might have better chances asking directly to one of the maintainer
> with who you contributed previously, and that knows and trusts you.

I think this just dropped through the cracks -- our wiki's
"somebody needs to create an account for you" rule is not intended to
require a high trust burden; it's only there to distinguish
real humans from spam bots, who were previously overwhelming it.

I've created an account for Yodel.

-- PMM

