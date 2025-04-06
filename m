Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7761DC36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZNn-0007Oo-OV; Sun, 06 Apr 2025 19:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZNi-0007OO-Kc; Sun, 06 Apr 2025 19:26:26 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZNg-0002p9-NY; Sun, 06 Apr 2025 19:26:26 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-523d8c024dfso1574741e0c.3; 
 Sun, 06 Apr 2025 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743981983; x=1744586783; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYgECubPYOZa5IZk7yJ0VadSl7O/pqXfl2qyHdEVDAs=;
 b=KPRnOCJxKltaS9mGRtMCNP2YQC3SAIMYmp5mMQKUmsxcZvhu2HnN0rmHnZx6vxJ/u8
 AzZdh+DaU5IxRCglQC1k8QEScMZbciZ2lDlFMUT8ST09/0JgpkwdFmYjKqykNKpTkL1v
 3NZYRu93OFfHgUKGcU7gyjY3A/lkcYjNxrNGce30HaeaL4m8WtXd3QsNGUGChbrRdWpl
 qr2r9uoydyZ4Apzm1YCrrASKMtLYaQjm5iGsfEJdLB7wrGj6bQuWecHmiq5pXpZfVRqS
 DPiTvVKeE44CHj6Q+tp1CnH2L6lFF5+0EDw0HzcsdYbt/kOGUaSQMeJCiYkGBhgNbT1+
 zxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743981983; x=1744586783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYgECubPYOZa5IZk7yJ0VadSl7O/pqXfl2qyHdEVDAs=;
 b=mFLZ0epRVnqO8tLXZFuzoSeQ+OA9tg7r/l9pYO9YnR5zGDkqssI437iM3vntBGVyHY
 jhBqdB0oGtZs2gkzJUzh8CuXEf7m9U/TXdvxH6S0MJjK+dDw2XSjze6ESt+v2DpHo+S7
 stRmERpm2vLo0c9wCIrw3yViESEjP4Hyq10Qw1Ttr3mwKM9fzdXNV3jNcVsTcVG9eeP+
 mgAzauTonbZ6AxBlcN46q/6teV6KV+wJP4aNaSeD5TUGekxnkB3xQ6PRqJafjoainqYo
 oMTQOr5CxeVX/9MKBiXqM4kCvv2tB/nwALsWWajlbN1l7R4EslIatbHlPpNbhKGlCIou
 rLXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTrFQjjG5ASXFQrrflMIFZukFgSUEjCFTgi8+LCghMM33BM6sY0uWulx5XFdOyN34CbDeGrRMv3hyMOA==@nongnu.org,
 AJvYcCWlfVYQ1QvZYqgBk5J2gwglGnzYWrcySMplQ8ImeEUVfENH72rQZoxSbgP8H1dgrqYByX7cC9O26v3z@nongnu.org
X-Gm-Message-State: AOJu0YxGAluVuyxx7vOSTk7i9sK4703Mw5i1gJn+eEumhAi0nZMAj8RP
 CEr0mY1CwBJdfQfTV7yxO3emciTo/rVwQu1GtTgOAKpHPQ7HlARthcLkKGno5NI8KAY5nAoWs6z
 KR3z1hSn8vRXhGrVvDiMeSKFzZKNC/Q==
X-Gm-Gg: ASbGncuV3cg8jN/pk+OtPo/YSmgjOfR9yFIqRUxhm8pEiEuKEUzKDIXSHF0jdpi/l0Q
 b2XTThKHs6Wbx39k67ELlKAycDva4Wya/XXdo7zoXjNoO8f0KR/nEf5wHfem106f01VGKRCP6JD
 bkZQGHQel5oGuJ0J6rirzzC5SdZkbMkBaWTLen00OEddqLzOZo1XJbom/H
X-Google-Smtp-Source: AGHT+IFA2gXHXTRl/AR7ZFJwgeWSJR46yRQDA7HnAxZYgA+6qg6V2Hqk2XnfBNM0WH6hNZDH3yFZNiuZY1g0D4u6o0s=
X-Received: by 2002:a05:6122:168c:b0:51f:405e:866e with SMTP id
 71dfb90a1353d-5276444bd32mr6967624e0c.1.1743981982824; Sun, 06 Apr 2025
 16:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220106210108.138226-1-frederic.petrot@univ-grenoble-alpes.fr>
 <c5c8566a-fd0d-48d1-8ed1-e52f0bb4f210@linaro.org>
 <CAKmqyKN51+jriKkSL8V5EFc9hBSFoEHYKp-70uP6RvO_K6a=pg@mail.gmail.com>
 <9ae32149-fe18-49d3-a689-60ee6752c20d@univ-grenoble-alpes.fr>
In-Reply-To: <9ae32149-fe18-49d3-a689-60ee6752c20d@univ-grenoble-alpes.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:25:56 +1000
X-Gm-Features: ATxdqUHbzAg4aR86tj9EmZeF9tNlmTI-51wnUVtaN9Sel8INEA3R6dgRpQWcKxE
Message-ID: <CAKmqyKO4GYqJ5GcvEc+yL4d01ONzDLR=2Ava7Disw2aSOZVFsg@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Adding partial support for 128-bit riscv target
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, bin.meng@windriver.com, 
 richard.henderson@linaro.org, palmer@dabbelt.com, 
 fabien.portas@grenoble-inp.org, alistair.francis@wdc.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 7, 2025 at 4:24=E2=80=AFAM Fr=C3=A9d=C3=A9ric P=C3=A9trot
<frederic.petrot@univ-grenoble-alpes.fr> wrote:
>
> Hi Alistair, Phil,
> well, I'm trying to keep the thing alive, checking from time to time that
> the current QEMU still runs the 128-bit tests that I have, and on which
> I continue (slowly) to do stuffs.

If it's being used then I don't see any issue keeping it

Alistair

> I hope this can stay upstream for experimental/research purposes, but the
> 128-bit riscv community is, I follow you on that, scarce for now.
>
> So, your call.
> Cheers,
> Fr=C3=A9d=C3=A9ric
>
> Le 04/04/2025 =C3=A0 05:26, Alistair Francis a =C3=A9crit :
> > On Sat, Mar 22, 2025 at 1:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 6/1/22 22:00, Fr=C3=A9d=C3=A9ric P=C3=A9trot wrote:
> >>> This series of patches provides partial 128-bit support for the riscv
> >>> target architecture, namely RVI and RVM, with minimal csr support.
> >>
> >>
> >>> Fr=C3=A9d=C3=A9ric P=C3=A9trot (18):
> >>>     exec/memop: Adding signedness to quad definitions
> >>>     exec/memop: Adding signed quad and octo defines
> >>>     qemu/int128: addition of div/rem 128-bit operations
> >>>     target/riscv: additional macros to check instruction support
> >>>     target/riscv: separation of bitwise logic and arithmetic helpers
> >>>     target/riscv: array for the 64 upper bits of 128-bit registers
> >>>     target/riscv: setup everything for rv64 to support rv128 executio=
n
> >>
> >>
> >> I see this series has been merged as commit afe33262585, with
> >> 332dab68785b describing:
> >>
> >>       This patch adds the support of the '-cpu rv128' option to
> >>       qemu-system-riscv64 so that we can indicate that we want to
> >>       run rv128 executables.
> >>
> >>       Still, there is no support for 128-bit insns at that stage
> >>       so qemu fails miserably (as expected) if launched with this
> >>       option.
> >>
> >> Is this code tested? 3 years passed so I wonder about possible
> >> code bitrot here.
> >
> >  From memory at the time there was some momentum for RV128. So this was
> > merged with the expectation that it would continue to improve.
> >
> > That doesn't seem to have happened, either software or spec wise though=
.
> >
> >>
> >> (I reached this code by looking at targets not supporting MTTCG).
> >
> > I'm happy to remove the CPU if it's blocking you, it's experimental so
> > it doesn't need to be deprecated or anything fancy.
> >
> > Alistair
> >
> >>
> >>>     target/riscv: moving some insns close to similar insns
> >>>     target/riscv: accessors to registers upper part and 128-bit load/=
store
> >>>     target/riscv: support for 128-bit bitwise instructions
> >>>     target/riscv: support for 128-bit U-type instructions
> >>>     target/riscv: support for 128-bit shift instructions
> >>>     target/riscv: support for 128-bit arithmetic instructions
> >>>     target/riscv: support for 128-bit M extension
> >>>     target/riscv: adding high part of some csrs
> >>>     target/riscv: helper functions to wrap calls to 128-bit csr insns
> >>>     target/riscv: modification of the trans_csrxx for 128-bit support
> >>>     target/riscv: actual functions to realize crs 128-bit insns
> >>
> >>
>
> --
> +------------------------------------------------------------------------=
---+
> | Fr=C3=A9d=C3=A9ric P=C3=A9trot,                        Pr. Grenoble INP=
-UGA@Ensimag/TIMA |
> | Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angus=
ta |
> | http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.=
fr |
> +------------------------------------------------------------------------=
---+
>

