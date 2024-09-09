Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ACFCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snUJ0-00007o-U9; Sun, 08 Sep 2024 22:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snUIq-0008UM-R8; Sun, 08 Sep 2024 22:38:59 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snUIp-0003iB-7d; Sun, 08 Sep 2024 22:38:56 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-846bdc20098so794072241.3; 
 Sun, 08 Sep 2024 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725849534; x=1726454334; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9sHyq1Tc0mqXugtuU1NXOCaNYDGK9Wxh3+vNCk8aIY=;
 b=fkG3/F6H3RgBVFpYPRUBymJbida9/SVBFqk5rNWLGoygCCK7FAoSvVx1AD+0GJ1gXm
 oLnYzAdKLNI+f0JxXID4FYevrepcbhsBVfYATAA6GhIgo0/AuIDFIFw+vh6VKWdL/dM3
 iOMvZWdghe1mFKee0eILl8fqxCEPif0wgrmRLx//sgvHdK+8CHFOyKLGyMY0RUr9E5km
 FJtJL+o3zPQ3srS6BewCnQDSihC7NP/UJOsciCjjaxl5DaxiIibvVyRzTh39G0rHq3ZG
 F2r2fi/QXG5Vz9eyv5avuHB7YitvMxmk3MC4Jhv3oMvgWWdt1PZJNk0Q/+XBaU2gNMf3
 9W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725849534; x=1726454334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9sHyq1Tc0mqXugtuU1NXOCaNYDGK9Wxh3+vNCk8aIY=;
 b=Z1ow65VVUZ3di1QtiIvfN9EQdsSstNF/VupzesbE34atnH7HFSa4uQ/4vDB1GKHxE/
 gCqR68dZoF2+aaJMY3YIoSeAYZvSPi+qU2GXcSUDOjj26dI6DaTHLlyJUFOJSOIAFxex
 5jKam2QCy9yaaq8QaJ16olQSNeH/n2ced9V2AV6CPxjW+iqCexJbxEaVK69rPVJ/zpgK
 WlqhWTnqchzefjZ7NccNvfnRYuMwTb3dd/4EKTyBxiO/ySQRq1IjGCw8nTwYlEJGLyYu
 CGPljziUSrqudO0jC7oVanhS5L3MYOZaA6nMI4iaIvpndJZNVlR9yd3+rN+rfJkh/M5K
 klLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4AquOfkCbyRYknMd7bk4DKTUAZ1BK8BmQaYzSKQlr/ioTO+HGqF8mwbodZIINAsyKl4cwVD6me4G+A==@nongnu.org,
 AJvYcCX3KJwb678E2DSTa3AtITBL20ykm0E0icjhxxCKlwFMa6ZEgEM6znZNNvBSIdij2TlYgyJXxo4pwaVt@nongnu.org
X-Gm-Message-State: AOJu0YwqEYOD2/3pFKarYXuxZm/z4n2g0MHHU/P4huyw39GMlEOKdBSV
 bsRP89d2MVe0j2361TyvvpkEX7RNsS94bAvIckDki5yk+KBKjit6MxRV8fki9d/7R1PkPnLU9Fd
 ZtXJgPAfVQsSDzrCPNuXGsR9NTs0=
X-Google-Smtp-Source: AGHT+IHexhQDuX0/lT8f0qdwBngy4JFMlMVqZvIeZKEahyi8vextoBQ+W9FS1UiNC9QaFZNqXH4dptDliZkykF8mE0I=
X-Received: by 2002:a67:f9d6:0:b0:49b:d061:d6f with SMTP id
 ada2fe7eead31-49bde268077mr9147307137.18.1725849533574; Sun, 08 Sep 2024
 19:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240813071355.310710-2-ajones@ventanamicro.com>
 <aa7facef-acda-4846-98d5-2f7584515035@linaro.org>
 <20240813-e2c6dc0e68f76be576c72996@orel>
 <3f1accd0-33b8-4656-944f-f6637ee315b9@linaro.org>
 <20240813-94c16c9efc943fe891ba7724@orel>
In-Reply-To: <20240813-94c16c9efc943fe891ba7724@orel>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 12:38:27 +1000
Message-ID: <CAKmqyKNsxFTyjQM=F5b9VfeZ3GQyLB2UaD36v=2nmtYbu5DdjA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv32: Fix masking of physical address
To: Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 zong.li@sifive.com, liwei1518@gmail.com, cwshu@andestech.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Tue, Aug 13, 2024 at 8:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Aug 13, 2024 at 10:21:13AM GMT, Philippe Mathieu-Daud=C3=A9 wrote=
:
> > On 13/8/24 10:00, Andrew Jones wrote:
> > > On Tue, Aug 13, 2024 at 05:43:07PM GMT, Richard Henderson wrote:
> > > > On 8/13/24 17:13, Andrew Jones wrote:
> > > > > C doesn't extend the sign bit for unsigned types since there isn'=
t a
> > > > > sign bit to extend. This means a promotion of a u32 to a u64 resu=
lts
> > > > > in the upper 32 bits of the u64 being zero. If that result is the=
n
> > > > > used as a mask on another u64 the upper 32 bits will be cleared. =
rv32
> > > > > physical addresses may be up to 34 bits wide, so we don't want to
> > > > > clear the high bits while page aligning the address. The fix is t=
o
> > > > > revert to using target_long, since a signed type will get extende=
d.
> > > > >
> > > > > Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depe=
nds on PMP entries.")
> > > > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > ---
> > > > >    target/riscv/cpu_helper.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.=
c
> > > > > index 395a1d914061..dfef1b20d1e8 100644
> > > > > --- a/target/riscv/cpu_helper.c
> > > > > +++ b/target/riscv/cpu_helper.c
> > > > > @@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr=
 address, int size,
> > > > >        int ret =3D TRANSLATE_FAIL;
> > > > >        int mode =3D mmuidx_priv(mmu_idx);
> > > > >        /* default TLB page size */
> > > > > -    target_ulong tlb_size =3D TARGET_PAGE_SIZE;
> > > > > +    target_long tlb_size =3D TARGET_PAGE_SIZE;
> > > >
> > > > If rv32 physical addresses are 34 bits, then you probably didn't wa=
nt target_*long at all.
> > >
> > > Yes, just using hwaddr for everything that only touches physical addr=
esses
> > > would probably be best, but, ifaict, it's pretty common to use target=
_long
> > > for masks used on both virtual and physical addresses (TARGET_PAGE_MA=
SK,
> > > for example). This 'tlb_size' variable is used on both as well.
> >
> > Then maybe you want vaddr ("exec/vaddr.h"):
> >
> > /**
> >  * vaddr:
> >  * Type wide enough to contain any #target_ulong virtual address.
> >  */
> >
>
> I think hwaddr would fit better in this case since riscv32 virtual
> addresses are 32-bit, but I see vaddr is a u64, so it would work too. I
> personally don't mind changing the type of tlb_size to hwaddr, but I went
> with target_long in this patch since that's what it was originally and
> masking with a signed long mask appears to be a common pattern in QEMU.

hwaddr seems like the right approach here

Alistair

>
> Thanks,
> drew
>

