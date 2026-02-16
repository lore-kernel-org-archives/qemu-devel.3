Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4DEE81A25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0C1-0004Y4-DM; Mon, 16 Feb 2026 10:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs0By-0004XG-Ng
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:07:19 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs0Bx-00013X-3k
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:07:18 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-797de0727a4so2250167b3.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 07:07:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771254436; cv=none;
 d=google.com; s=arc-20240605;
 b=EoHjvw1MnDezkzytf4el2Kdy7DkJXPhyhW+y1vp5ZfwhVd5jclvUfTuFS2LV7Fvbz6
 rZSdz3VwZ/lYuo+1DmKd064H59zr1BncxlCeHMQDCmI6tRuoR932YSF58IgyU0SfTX80
 TIKBAv8NxA+T40XhT9pN/UZksvinhbqTRasr1m1dEAKOQt2ZllUalDJYl0nYMWOgYr0x
 FbgnTi6r2EpB6cVGsO2JxrNzgDw57MmKzFghqL/Zn/FdZNSc34eghVRIe8gHhwpTDBax
 2FvO3ZdXRpK7sDFU0IK7AR30zhZ8qCT0VVD53OiRkuoec3Jf6tyVwV2HEoBv1h4OY8Ey
 sVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cLj5mvxAEDc8A+D2g5Kp2Cw7/hFb6Z3ufCAWz8ObNVQ=;
 fh=7M/AA8JXQlfaVwpny6A82dhDK4CCtE9rEG/kuPF6hm8=;
 b=ajRhzJCFuftfYjcKmImmWcEQ9JFA1xx5GWt+qw//LQKdFJIVdwrfZ589jwxs/z30f2
 isGggUhgspvV5+D0lADHU0AgKPUPyMeNIqAELdfzDDWmUgMAs5cbYfFo3O5e09SUy7cf
 G8iwjscVjIsjPwK6dXFTIdhXaU3ZyVtdaaMQRWh3EglghKWYSFhb4tY+5FU6KHyQ9haw
 Ekdh8gnQBeQ7DX3vKv4k3R3l6T9r1cXIIRwOCCSUilKFtLaTK+IYd3cPYuWqYszBV7e9
 uZWGbr+q+ChW85B/FHhQ6FFKDBVGNpMXEjl07LdRtGyD7UqCQ2KfKTv75hpFjzGMbcW2
 tPTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771254436; x=1771859236; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLj5mvxAEDc8A+D2g5Kp2Cw7/hFb6Z3ufCAWz8ObNVQ=;
 b=xZu8qKSy0d7+2WD8RT/otlAtsqp/no5aqEGAGypWKVnhYbkMGiIS+YY0Ohx9aT5Qi0
 kpIXl2CQ89Y/4kSZsWMjYto2eIrw5wUNfDOCd/of8APamB6HG/hl4F5tga6Zpmvjiie3
 4ysQUyR68PaGDWb3q2cPFROzkuhs1HqPtaIOBE2UwwOTZtB92NoW+6RaWpt0TuhjgZ/r
 EMCIy6qS1CJLcP4B+8dtYBY60TqXUNe4ONMgMmDIzRdPAyw6Avh8qwig7mRELxMGvpHT
 JIMYrLW/7ynKLljK0dTJ67pwAt/XQes+OaPT3+fexeJujq3sE1HZSZhuaGdGU5lynv3j
 soUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771254436; x=1771859236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cLj5mvxAEDc8A+D2g5Kp2Cw7/hFb6Z3ufCAWz8ObNVQ=;
 b=dUviN4eoIFjnBRMxWpz3ILRcPTG3+X1z6Z0eTzvbj3iEp+cs5kR2EPjnsv+yuTUJN9
 RlC0yswHerAmIEOXXbpEe318i7hm2RL4K83ccQ5xrqave9l7jay+U5SrTvg9BMt+Hfdp
 u8pZPUk46jxnVbcgX9mD7JMThutzrBalwIFrn8r3ZWVjd//8p3xLWBHD5bdy7mx3LRtb
 rw0OkSvz6RiuRmRC0JUw7A+N6SOE7vKKg/gKzfiObdAluf1XPMO2TrIH0md81O8S9lqC
 GnaUArZMa7P8myYFCZgauBZduy22yLjWbujbeScTqcWoEgXWJ3eLtYdKXaXaCELW/KJr
 LoKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU72OaRjUNXo2r4cLheLqRZCm1IjEemoll+nDBu8ijEzJqPVRDydbMrEeiKNFpBHh1fYNi1AgymYRwc@nongnu.org
X-Gm-Message-State: AOJu0Yxhe6lkeBMxoI8lPqqZ67rOdK5ykTHI02HqH4Y9sEziAgrMpsxp
 uzruKUiUivzT7DPU+J4CZaFko/gJg9DGoDA4QGXF5i3kIM9vbYEtu772sfrOqanVNjG1vu4ZuHk
 v4JZUJd61ts6W92PqXZWZ6rw1wivgKPrtMI+DOPUgTA==
X-Gm-Gg: AZuq6aKEpA2Mm4S7wulGVyncI8BFhliF14eQQVPsrTiuJ4AkczEugugJm6SeCdEOTdW
 PbwQwEGNPFdxXmc5Jgl1H/cQd+J4V+Ohfv1rGM+g25/2N7QLHdAqcAhkmKmoCyrUQfJcY93E5fx
 Otwkaxbz/DwUEYvReWlg71E81gofr+iqylSPgYM7fiV1iEvoyR3YgxcB8vVisMOkx95LNXHqIKF
 Hu0HYnmj1txD5+pP1RCuHSq0NPkxn7jnt88Ci1Zv8j7bTvNLGoACOA21ZOL3UGvQuppxdH8R1LB
 DJbWwojcv23hVZl6vCCCqQLa+eVPC0RjJbqMrzZ+Mol+KbAj9GcuDqocSS7xUIHioSyFJ/aOung
 4Iw==
X-Received: by 2002:a05:690c:c50d:b0:796:3124:6544 with SMTP id
 00721157ae682-797a0bc23f2mr179995317b3.3.1771254435576; Mon, 16 Feb 2026
 07:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
In-Reply-To: <aZMwvfw4O5xeH-Gm@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 15:07:02 +0000
X-Gm-Features: AZwV_QimQU6IJYBL87nhKVRWSpbXRnX9OY5bjBUgydP-l9OQCzkzBCRZ0st54-M
Message-ID: <CAFEAcA8y-UQC-zSqouFa16eEcJzksdyvpCvTGVNiE8aLp8DYNg@mail.gmail.com>
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 16 Feb 2026 at 14:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Feb 16, 2026 at 11:17:38AM +0000, Peter Maydell wrote:
> > Followup: we have six test assets that are over 500MB in size,
> > and they are all aspeed tests. Please can you have a look at
> > slimming these down?
>
> I see 2 big assets from aspeed only
>
>   64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93
>   ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
>
>
> what are the names of the other files in $HOME/.cache/qemu/download
> you have that are over 500 MB ?

-r--r----- 1 pm215 pm215 519M Feb 16 11:07
e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc
-r--r----- 1 pm215 pm215 520M Feb  5 15:57
d5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525
-r--r----- 1 pm215 pm215 581M Feb 16 11:15
0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0
-r--r----- 1 pm215 pm215 582M Feb  5 15:59
4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f
-r--r----- 1 pm215 pm215 1.1G Feb 16 11:11
ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
-r--r----- 1 pm215 pm215 1.2G Feb  5 16:02
64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93

All these hash values turn up in tests/functional/arm/test_aspeed_*
so they're not stale leftovers.

thanks
-- PMM

