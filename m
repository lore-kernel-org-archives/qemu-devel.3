Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E886CCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6YD-0007wo-Rk; Wed, 29 Oct 2025 09:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE6Xw-0007lJ-F7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:05 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE6Xp-0003gl-BE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:04 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c09ff13aeso12648234a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761745732; x=1762350532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHfrAOQKlWUNOOdiZnp3sKxU6aOyXzVnVWPBMBRYcrw=;
 b=GjSZ6adbReSVRxrWOQj0bKSWpjBiGK5JKhbSdZK9tzLXdtqK/5ebdFZ2NvIa4fc96K
 O8KNQtEPHC/euewDPi4fo7hkazkwJ4BSth31jg5l5KZZReetenbHvibg+Y8h3SWTCcC5
 kSDqLvO8W6QThO2a+PziiHiXcgBlDe6H8DbAs7B4Ry5f0jsGx6w2ygcE6ukX6f8jywr0
 +htxM3Tlk1a6ErZqTq59cohRUfRUtExoDKByXSIBBefgpUWc5+aeXyTc8dm1jU0yci9L
 4NvC8O6vTWC7mKwr9Lg4NcD65tlAuOxjt/Zo4wNssDwyXebvFdqodhqaybPTm2bOxpOl
 CAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745732; x=1762350532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHfrAOQKlWUNOOdiZnp3sKxU6aOyXzVnVWPBMBRYcrw=;
 b=tiADzHYPYmF9Szhb7xnnof2lwF/RENXJtZB4Mby51h1MphGZsJVMjdnDQQVJOzRite
 Ovs2DK5dBHgDYUNcwrWu9DE/Amd7eld97Kp3gVTOFmtbHoicythIOoGpkv7fHzbpfqeT
 EzRnZO+gsU22LVnR+4ZUjYaiLq2o1RS64w6PCyUxyEy825OA6LEjGZGp46DPd7tARs5B
 rzq5mbDWxLLxoqmq1FJ46Nakvghp9jQeGlg5Atx8BsFv/xUX6ERRReD4MF1i5qc85aIS
 H+IJ+tJHXjAGHzU+aOONeX5q4C7wpt5izRSYA2xf2mmokqebeiVp9a3a53A1CW6n4ruk
 GTuw==
X-Gm-Message-State: AOJu0YyDwfj7x5JxDc1yNPJCgVDm0hskYsl27Kv7ZVqvUDgUqk0ReJZ8
 2WrBXIzJR5+MvecgmqR9+ce41n0DzlC5InQedLUb7GcjrIiCbONkrt4WaBALGgjEUguoTIm8Jzr
 P2wMQ4dZmOr4cAcfYFbIkC4BAISOxG8hQvv2jcJvy
X-Gm-Gg: ASbGncsBXMUehL3H1qn2ckE/lgwXeFIc6+9WOm8iuyCzkrrWXvL1uJy6p8Oyf0ojF6g
 yzGSl4ymAHLXlZEBuXlKjO5V+uHuMBS4jnmJ6yJOhu1mXvfQh0GWi7hd74RfxC14nAkM2HEAKad
 iqpbY0ZDQad2lVt2D+CMf3CKUq+6jpQ/WvyU66DRDoZ8Y4hF27W+4ZcnZ3wrUiKW3CC4i3vNx+8
 XrHjsq9pMdIfKtDSe5irm8x1yfgBiZh15OBgMbQ+hkJEKdjpMT4JvJO/ccV5uyQNbRmX6/M3tcS
 6V2UPzMQYFISfllzKE0=
X-Google-Smtp-Source: AGHT+IH0P8XBdMiW4xFRyWKtnzSNN7tVEdZvbaKSU4BUZ5kOSlfK8+npX6ZudLB+X3jnEU/ZD+LIuK4g6TWUj+BHjzU=
X-Received: by 2002:a05:6402:13cf:b0:637:e57d:c21 with SMTP id
 4fb4d7f45d1cf-640441ce207mr2431064a12.3.1761745732208; Wed, 29 Oct 2025
 06:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-3-chigot@adacore.com>
 <aPp2eRW7gQfv4hT7@redhat.com>
In-Reply-To: <aPp2eRW7gQfv4hT7@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 29 Oct 2025 14:48:41 +0100
X-Gm-Features: AWmQ_bneHG3Y0lJwx7gvurF4FFdmegWnAuqudZ-kBS3-hSq7lHcUXcNXOOfK-SM
Message-ID: <CAJ307Eg_YngaeBukZjpr81iGJCm+ycwZHj_aPuxU_8tuSC9MPw@mail.gmail.com>
Subject: Re: [PATCH 2/5] vvfat: move fat_type check prior to size setup
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x531.google.com
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

On Thu, Oct 23, 2025 at 8:40=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
> > This allows to handle the default FAT size in a single place and make t=
he
> > following part taking care only about size parameters. It will be later
> > moved away in a specific function.
> >
> > Setting a floppy disk of 1MB is no longer possible as it was a side
> > effect of passing "fat-type=3D12". To be precise there were three cases=
:
> >  - fat-type undefined (aka default): a fat12 2MB disk
> >  - fat-type=3D16: a fat16 2Mb disk
> >  - fat-type=3D12: a fat12 1Mb disk
>
> That's quite a strange interface!
>
> If we're touching it anyway, I would change it to make the more common
> format (1.44 MB) the default for FAT12 and make the 2.88 MB FAT12 floppy
> temporarily unavailable and later require an explicit size. This way
> both sizes would still be available using the fat-type.

I'm a bit hesitant to change the default behavior as people might be
using it without clear knowledge of it. True, "floppy" is probably not
a widely used feature but still.
Do QEMU have some specific guidelines when changing such default
behavior ? Adding a warning ? Or just a comment in the changelog would
be enough ?

> Please say 1.44 MB and 2.88 MB in the commit message rather than 1MB (or
> even 1Mb, which might mean megabit). There were other sizes like 1.2 MB
> that are closer to 1 MB, so it's better to avoid that confusion.
>
> > Now, that fat-type undefined means fat-type=3D2, it's no longer possibl=
e
>
> s/2/12/
>
> > to make that size distinction. It will be added back a bit later,
> > through the size parameter.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> The code looks good, apart from the change I suggested above (making
> 1.44 MB the default for FAT12).
>
> Kevin
>

