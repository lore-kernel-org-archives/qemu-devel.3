Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9B3C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ria5N-0003xD-3W; Fri, 08 Mar 2024 08:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1ria5A-0003wx-BJ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:16:16 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1ria56-00087e-PZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:16:16 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29b7dbe39ccso1480821a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1709903769; x=1710508569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDRK+4HPpXEzoHdKcxNPERnbIRLfSl3WqHvIvJ8OTJk=;
 b=Zy1D7QzJiTADE1yk61j0njYwb/4IuW2h95ICcx6IwARM+8CzULNk6ReCz3CNQbBHar
 tLYlvCFJqY/0HE15Tbogc+QNLhDmF8YBqPCoK9CFx4Aq2cI2dHtvHs1c6sl4Wmfp4VGV
 BZn1A1jLHGhGcemE91jjcMHEoqSkoiMzVz8eY9s48GjySyYaBk+lBAoIKh5WI1kxLnJV
 xyOEYdEVATeBMDqTfNX0pM7E0q+HsIaQOYJ4SqPwiTGJxzGpKOez9xacKlUnkbAskePa
 canSfXRfOfIINGUrbY1YMpyAWVq+s3+uXgWD5fj+DJkh/07Pcguvph3Cj6YE+5xV5KNg
 p3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709903769; x=1710508569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDRK+4HPpXEzoHdKcxNPERnbIRLfSl3WqHvIvJ8OTJk=;
 b=ZiMm8pAhaU5eBudsy/+XndT/1xg+d53j2mgxyeDBjEb3idvt3j6XQ7tezAXUiRl6oO
 pZ6ujeMo2UnYZEG9EJfAyLjMdKvXZtURLwG6lRRYsH7K3di2rv5SoQMw54AtZn6l+18Q
 31KHJj8ZiP/4ywwjtd+0oKedKLTaco0mhIVuue75ypzc1/O1Qd8oLnljUruVhagnXLyG
 dkvfrUERpIKSp7CXrlW1zMWVIW3CeOY2r7pnkhNXhLjmoZeFYu5We09boCziFhzNX1nB
 UmW/nayA4biBcr/Kw/gV3NGuKotMflUI2USQpQiiTw0CEclYZlDrBUldgN79ronh5wGV
 78hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8jUO02vwS9jAKdu/Ja+ZpWCB450oZQrwwNRp7yxeDKG/7qc0Eh+BZctf+yuBjaDn3AjB9P2EI5T5wraD7xQhcGota7g=
X-Gm-Message-State: AOJu0YyIF4Bs8x+VslicySECJQl36KlXK0rfdNR6bUM3VATInzfVLhtK
 s+sDnixKH5uL83YmMeMeUcJpu9zpZV3t3XWuOzni0P/OuUSYWTVlN5YaKZGoE7FahMntQpHg4wD
 B0G48iH9Y4jVOSh1NLoyDFNjoVv9UDDsTfQoGHdhsBly/Wv8g
X-Google-Smtp-Source: AGHT+IECWl8+S1Vc9OuxxBMvqu+oATB5t64/dZcpAB6YSw5mCFwpMVrd+k2+dpcL+Dl4SV/AZx6ExPrbCV23q4tphQ4=
X-Received: by 2002:a17:90a:fa12:b0:29b:ab15:73ed with SMTP id
 cm18-20020a17090afa1200b0029bab1573edmr285181pjb.16.1709903769480; Fri, 08
 Mar 2024 05:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
 <20240207115926.887816-3-christoph.muellner@vrull.eu>
 <CAKmqyKMZqysJWyQULpD21LVHdHKAVHc4671sVe3hqJ9Ksz9a0Q@mail.gmail.com>
In-Reply-To: <CAKmqyKMZqysJWyQULpD21LVHdHKAVHc4671sVe3hqJ9Ksz9a0Q@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 8 Mar 2024 14:15:58 +0100
Message-ID: <CAEg0e7hqQ8opuNxgDx32dwQrGHX7XNiA1kQas1Urzv3aKwNgyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user/riscv: Sync hwprobe keys with Linux
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pj1-x102b.google.com
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

On Fri, Mar 8, 2024 at 5:23=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Feb 7, 2024 at 10:00=E2=80=AFPM Christoph M=C3=BCllner
> <christoph.muellner@vrull.eu> wrote:
> >
> > Upstream Linux recently added many additional keys to the hwprobe API.
> > This patch adds support for all of them with the exception of Ztso,
> > which is currently not supported in QEMU.
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >  linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 91 insertions(+), 7 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 43467c9707..3ba20f99ad 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8793,13 +8793,41 @@ static int do_getdents64(abi_long dirfd, abi_lo=
ng arg2, abi_long count)
> >  #define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
> >
> >  #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
> > -#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
> > -#define     RISCV_HWPROBE_IMA_C        (1 << 1)
> > -#define     RISCV_HWPROBE_IMA_V        (1 << 2)
> > -#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
> > -#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
> > -#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
> > -#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
> > +#define                RISCV_HWPROBE_IMA_FD            (1 << 0)
> > +#define                RISCV_HWPROBE_IMA_C             (1 << 1)
> > +#define                RISCV_HWPROBE_IMA_V             (1 << 2)
> > +#define                RISCV_HWPROBE_EXT_ZBA           (1 << 3)
> > +#define                RISCV_HWPROBE_EXT_ZBB           (1 << 4)
> > +#define                RISCV_HWPROBE_EXT_ZBS           (1 << 5)
> > +#define                RISCV_HWPROBE_EXT_ZICBOZ        (1 << 6)
> > +#define                RISCV_HWPROBE_EXT_ZBC           (1 << 7)
> > +#define                RISCV_HWPROBE_EXT_ZBKB          (1 << 8)
> > +#define                RISCV_HWPROBE_EXT_ZBKC          (1 << 9)
> > +#define                RISCV_HWPROBE_EXT_ZBKX          (1 << 10)
> > +#define                RISCV_HWPROBE_EXT_ZKND          (1 << 11)
> > +#define                RISCV_HWPROBE_EXT_ZKNE          (1 << 12)
> > +#define                RISCV_HWPROBE_EXT_ZKNH          (1 << 13)
> > +#define                RISCV_HWPROBE_EXT_ZKSED         (1 << 14)
> > +#define                RISCV_HWPROBE_EXT_ZKSH          (1 << 15)
> > +#define                RISCV_HWPROBE_EXT_ZKT           (1 << 16)
> > +#define                RISCV_HWPROBE_EXT_ZVBB          (1 << 17)
> > +#define                RISCV_HWPROBE_EXT_ZVBC          (1 << 18)
> > +#define                RISCV_HWPROBE_EXT_ZVKB          (1 << 19)
> > +#define                RISCV_HWPROBE_EXT_ZVKG          (1 << 20)
> > +#define                RISCV_HWPROBE_EXT_ZVKNED        (1 << 21)
> > +#define                RISCV_HWPROBE_EXT_ZVKNHA        (1 << 22)
> > +#define                RISCV_HWPROBE_EXT_ZVKNHB        (1 << 23)
> > +#define                RISCV_HWPROBE_EXT_ZVKSED        (1 << 24)
> > +#define                RISCV_HWPROBE_EXT_ZVKSH         (1 << 25)
> > +#define                RISCV_HWPROBE_EXT_ZVKT          (1 << 26)
> > +#define                RISCV_HWPROBE_EXT_ZFH           (1 << 27)
> > +#define                RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
> > +#define                RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
> > +#define                RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
> > +#define                RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
> > +#define                RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
> > +#define                RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
> > +#define                RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
>
> This fails to pass checkpatch

I copied 1:1 from the kernel, so I guess it is the tabs.
Sorry for this! And as you have already fixed that: thanks!

>
> Alistair
>
> >
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0     5
> >  #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> > @@ -8860,6 +8888,62 @@ static void risc_hwprobe_fill_pairs(CPURISCVStat=
e *env,
> >                       RISCV_HWPROBE_EXT_ZBS : 0;
> >              value |=3D cfg->ext_zicboz ?
> >                       RISCV_HWPROBE_EXT_ZICBOZ : 0;
> > +            value |=3D cfg->ext_zbc ?
> > +                     RISCV_HWPROBE_EXT_ZBC : 0;
> > +            value |=3D cfg->ext_zbkb ?
> > +                     RISCV_HWPROBE_EXT_ZBKB : 0;
> > +            value |=3D cfg->ext_zbkc ?
> > +                     RISCV_HWPROBE_EXT_ZBKC : 0;
> > +            value |=3D cfg->ext_zbkx ?
> > +                     RISCV_HWPROBE_EXT_ZBKX : 0;
> > +            value |=3D cfg->ext_zknd ?
> > +                     RISCV_HWPROBE_EXT_ZKND : 0;
> > +            value |=3D cfg->ext_zkne ?
> > +                     RISCV_HWPROBE_EXT_ZKNE : 0;
> > +            value |=3D cfg->ext_zknh ?
> > +                     RISCV_HWPROBE_EXT_ZKNH : 0;
> > +            value |=3D cfg->ext_zksed ?
> > +                     RISCV_HWPROBE_EXT_ZKSED : 0;
> > +            value |=3D cfg->ext_zksh ?
> > +                     RISCV_HWPROBE_EXT_ZKSH : 0;
> > +            value |=3D cfg->ext_zkt ?
> > +                     RISCV_HWPROBE_EXT_ZKT : 0;
> > +            value |=3D cfg->ext_zvbb ?
> > +                     RISCV_HWPROBE_EXT_ZVBB : 0;
> > +            value |=3D cfg->ext_zvbc ?
> > +                     RISCV_HWPROBE_EXT_ZVBC : 0;
> > +            value |=3D cfg->ext_zvkb ?
> > +                     RISCV_HWPROBE_EXT_ZVKB : 0;
> > +            value |=3D cfg->ext_zvkg ?
> > +                     RISCV_HWPROBE_EXT_ZVKG : 0;
> > +            value |=3D cfg->ext_zvkned ?
> > +                     RISCV_HWPROBE_EXT_ZVKNED : 0;
> > +            value |=3D cfg->ext_zvknha ?
> > +                     RISCV_HWPROBE_EXT_ZVKNHA : 0;
> > +            value |=3D cfg->ext_zvknhb ?
> > +                     RISCV_HWPROBE_EXT_ZVKNHB : 0;
> > +            value |=3D cfg->ext_zvksed ?
> > +                     RISCV_HWPROBE_EXT_ZVKSED : 0;
> > +            value |=3D cfg->ext_zvksh ?
> > +                     RISCV_HWPROBE_EXT_ZVKSH : 0;
> > +            value |=3D cfg->ext_zvkt ?
> > +                     RISCV_HWPROBE_EXT_ZVKT : 0;
> > +            value |=3D cfg->ext_zfh ?
> > +                     RISCV_HWPROBE_EXT_ZFH : 0;
> > +            value |=3D cfg->ext_zfhmin ?
> > +                     RISCV_HWPROBE_EXT_ZFHMIN : 0;
> > +            value |=3D cfg->ext_zihintntl ?
> > +                     RISCV_HWPROBE_EXT_ZIHINTNTL : 0;
> > +            value |=3D cfg->ext_zvfh ?
> > +                     RISCV_HWPROBE_EXT_ZVFH : 0;
> > +            value |=3D cfg->ext_zvfhmin ?
> > +                     RISCV_HWPROBE_EXT_ZVFHMIN : 0;
> > +            value |=3D cfg->ext_zfa ?
> > +                     RISCV_HWPROBE_EXT_ZFA : 0;
> > +            value |=3D cfg->ext_zacas ?
> > +                     RISCV_HWPROBE_EXT_ZACAS : 0;
> > +            value |=3D cfg->ext_zicond ?
> > +                     RISCV_HWPROBE_EXT_ZICOND : 0;
> >              __put_user(value, &pair->value);
> >              break;
> >          case RISCV_HWPROBE_KEY_CPUPERF_0:
> > --
> > 2.43.0
> >
> >

