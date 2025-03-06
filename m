Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB3CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq29P-0005eZ-Il; Wed, 05 Mar 2025 22:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq29M-0005eB-Li; Wed, 05 Mar 2025 22:43:56 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq29K-0004YT-L1; Wed, 05 Mar 2025 22:43:56 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5235db99207so85018e0c.2; 
 Wed, 05 Mar 2025 19:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741232632; x=1741837432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m419S0McCJVd9ramFrEOmlGILW64OQ4WMwACvLAxGrI=;
 b=W7UhRklP9ojKrYItEgHtQUTX9t5Xa5aDdn+I3oXeQvWuPVhGfxwqlwfnZu+F9OhO/H
 OqhS25l8ebXM/z9aCl9mrjHNwI4hKOnNL2mx0bpvutS+dNu2/nJ4G5uavuWukhm7kRwg
 tgDFIN1ZGPuTg9/gQg5ftZODo9NaQddcSX7TsIXPOiFKjHTTJ/uPB51Tyg1dRjNKt0WN
 TW1/WUUR83NYGoWF7u5mtvDw2yQMIJzE0BEp3TqRq0kfQsaMEZWh517sK11j18BNMPhQ
 3YhDiuH+kDdc+u/77KR/fsuaxYLm90HUl3rKY45G3Elo+1HEHjaTVEpWH/Th/5i1YDXD
 4Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741232632; x=1741837432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m419S0McCJVd9ramFrEOmlGILW64OQ4WMwACvLAxGrI=;
 b=Nfr2lAXdg7Bs8ceMFzCO8ug6ywjGkAnL18tMj2XKvV8QqoIXp8s7fMfWQIcgIYx3AX
 nA1m6ZESOwm0rE3DSj6b5autsfkoXiIMo4yVf2hFwZwMkMhtpuHLKf/x96wkkMCP+QHp
 MA6AuT4sDKjIHKs7FxBv3MiVBSpvm9Omp1VgUaHBWYdAhf7kll92B8NBGnRvSTO7mPo5
 85cew7CUG4JvJtitfHaXclspf7pe204NeFmTFP4ZCi/7cssFhUM1EI+e0OmLkrn49KYP
 AXN0cp+CpCzFq5cX1Qa7DWd2UuH5cWYepIFqiJXu6WshgLN2X4cD8mOQhcguGeAuWHM5
 Aw9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXc60A6t06Ckwty4GMIWZ2YT+BYl/01SlWxfkXfxLMP6GE/4ww954aRXzHzaLOwczBA8YNEXL/jSVDEA==@nongnu.org,
 AJvYcCXItQeixXHjyZHHG00ErgThFA38GwarXjlCyFo2/pwzMnGEJwSBqIEfcjAXGse254RZW9nJijyCQsn/@nongnu.org
X-Gm-Message-State: AOJu0YwkkQnsohDo3I12TAw8kejvijlL5L3EXyEArZpvdA2pILt0RuRI
 ghUzMkJhYkhKo7bm5Ym8j4V5TjRfjpyEBPvUudQEeVqvsBWOt9QdhoC5c0g38WEPq4+6vu5pVpN
 QeRdKFXCWAQRRweig4fON6TxhwlE=
X-Gm-Gg: ASbGncvVyGWVmJV90D5I84zBCy0DbAkJGDo8X58cja6iR5w7es9zPncLgr3Gnua9F5W
 Lt4XW/2n/U9mMhueZgthpukNamgkMuWXrZNU6hvGu6A67otgyP+Zm300II2SonTaqbJMl4TPoMb
 kQWwJgJ0UN58iXGjmeU3xzBpUJh2Q/dQ/0zyvvAf3ml5yiq7Yawcy9ojlc
X-Google-Smtp-Source: AGHT+IFT4riVnsCg6AEjpSosQSHb1Xsd1WNfcXO8lgtsMoZ8WJC0zy3UmHzQJ6VdV0N0Y2s/oLS0rq81wiaA4dAqghU=
X-Received: by 2002:a05:6122:2a14:b0:520:42d3:91bc with SMTP id
 71dfb90a1353d-523c61149b6mr3636703e0c.2.1741232632393; Wed, 05 Mar 2025
 19:43:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736130472.git.lc00631@tecorigin.com>
 <20250305112412.1804-1-lc00631@tecorigin.com>
In-Reply-To: <20250305112412.1804-1-lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 13:43:26 +1000
X-Gm-Features: AQ5f1JoKhfmiUhKdTAUOaHdGM7_neBmLSZ63dFM6FHfMyE1ey5bbtThqJxBZgWk
Message-ID: <CAKmqyKMoJ-EMn5dYY93_mEtf8wqCekyjcQQ_quxJv2FpY=+WHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Enhanced VSTART and VL checks for vector
 instructions
To: Chao Liu <lc00631@tecorigin.com>
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, zqz00548@tecorigin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Mar 5, 2025 at 9:24=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> wro=
te:
>
> Hi,
>
> This patchset fixes some bugs in RVV instructions,
>
> can you pull it in the near future please?
>
> Looking forward to your reply!

@Daniel Henrique Barboza you commented on v2, can you have a look at this?

Alistair

>
> --
> Regards,
> Chao
>
> >
> > Hi, all:
> >
> > In accordance with the review, i improved the commit message of patch a=
nd added
> > the reason for the modification.
> >
> > There was no change in the patch content.
> >
> > PATCH v2 review:
> > https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e=
@ventanamicro.com/
> >
> > PATCH v1 review:
> > https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLW=
kKOAgEMt_b2KvZA@mail.gmail.com/
> >
> > --
> > Regards,
> > Chao
> >
> > Chao Liu (2):
> >   target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a
> >     parameter
> >   target/riscv: fix handling of nop for vstart >=3D vl in some vector
> >     instruction
> >
> >  target/riscv/vcrypto_helper.c   | 32 ++++++-------
> >  target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
> >  target/riscv/vector_internals.c |  4 +-
> >  target/riscv/vector_internals.h | 12 ++---
> >  4 files changed, 69 insertions(+), 62 deletions(-)
> >
> > --
> > 2.47.1
> >
> >

