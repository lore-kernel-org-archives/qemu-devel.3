Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14684C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NAo-0004DS-Fr; Mon, 14 Apr 2025 13:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4NAC-00047P-O4; Mon, 14 Apr 2025 13:00:05 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4NA2-0001I2-21; Mon, 14 Apr 2025 13:00:03 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86d30787263so1923248241.1; 
 Mon, 14 Apr 2025 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744649992; x=1745254792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRRtBotIoeMV/57ax7oQatGsNL2fFD2WqwUiuUmDQ7U=;
 b=I/GnYkyXQKkMXXkIW3bBicwgBBNJHfQh2Be7LrARCw143pO7rlw4GXwixJbbjoYA+A
 W/wKlM7KOaSprEkodXeHIpmm+PFnbtLtCu4yVNlXQ9LuNRaa3nKAtYaotlx07Rdq9qxJ
 E6PUrlOS/ktOCsej6L0Vp9lFiZTkWSHrhBpL6Lt9HcdxgDzKqyS2gND/fjT8w+3iMD3b
 PRGHQVQgplEkE/fPtIZS8fDt4/3LsIqzFymBQCw1UtXoyLx2gxnz05sPl7ybG4iCV7Ie
 P8tMUYZa/Z/Wbtb44dcbFRbq3ro4LqtBRpGXQYF8wAWSHe+8fowY8hEiLRk4LDBGR5P/
 RnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744649992; x=1745254792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRRtBotIoeMV/57ax7oQatGsNL2fFD2WqwUiuUmDQ7U=;
 b=fB1rwS1Pi8DsjgO5tmT6wxeVOeFoD5FMiHr8oWdJgmXUkSdu9zvwswFJ+0upNlX3a0
 TryYLAf00mXPtBYo5eiGBgXgQm8PwvwSrJ6AUL7cuDLSxVk0PrzXuChmoUixB8BOB0hs
 VDrDJQpAQi/CkssNOah2nlrQ4/lgqQyzl+nyoSaemqJw0Dey4brZIBph2pG8esHiWhw0
 aSqfJp0W7upL29bWifBE1Bqy2/O55GpJclXO41zU+yfw2Yv/yGvcBHEK06x11knpCSAP
 BqmWh0aP5rnLEO/icasszMtW6asPlFz0nitAp8cSoQ8QthKt7Cs0KtUWAXTwvwzdoRHT
 h/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUC06VyhzKQgr4o1DsdgdTXSLoVhyU61ab3CQjXes6XC2VrJmjx7IqrZjrCYwCJ2lx5iYqUykw5TIsfo=@nongnu.org
X-Gm-Message-State: AOJu0YyJZrCzi5gILA1+EwTeJ6Ep7nJQOfOKEDLCf9djAeRfJqFY/ph7
 zxPtktrodgKkbL4hFgU8cNW8gvKpPi2WcYzJtQMzWVNwzGFXMlgmPyfao3wgVJsebnKfcSSi7d9
 DxBC2NVGC0Zb+DqbjM7hWisIFpzg=
X-Gm-Gg: ASbGncvYe8q3TKt20rZOjK0es5Ix2gt/AI4ykNMh/o9O8hxi02zJqMyyvWgqKT2sXfX
 Xw0PaJmjJbCOvBWE7xb/0uvQD++G+QenxPe7bUxy1mFX3JJnokVOC5B4M1QA1ioS7GnX11sZE+a
 6BJaoNt0DtnhY6LV79IulO
X-Google-Smtp-Source: AGHT+IGXet/2l9+1+/kjlG8+0MIar9KFlXWZLfaY+G3Bl5uQIacfQH+dTimZpvZ7qOAAVrgOIg/FRsDzZjVHqcbrj4w=
X-Received: by 2002:a05:6102:509f:b0:4c4:e018:326f with SMTP id
 ada2fe7eead31-4c9e4eec0bcmr8328173137.10.1744649991750; Mon, 14 Apr 2025
 09:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
In-Reply-To: <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
From: Ziqiao Kong <ziqiaokong@gmail.com>
Date: Tue, 15 Apr 2025 00:59:40 +0800
X-Gm-Features: ATxdqUEiYqnYUwijJljSg8gCk-PN9CynwRpdNIuCa6jo4UUakqmcVdHeL19SNbY
Message-ID: <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair.francis@wdc.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=ziqiaokong@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Philippe,

Any further concern regarding this series? I certainly would like to invest=
igate
and help =3D).

Bests,
Ziqiao

On Mon, Apr 14, 2025 at 7:17=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail.com> =
wrote:
>
> On Mon, Apr 14, 2025 at 6:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > Hi,
> >
> > On 14/4/25 05:46, Ziqiao Kong wrote:
> > > On big endian systems, pte and updated_pte hold big endian host data
> > > while pte_pa points to little endian target data. This means the bran=
ch
> > > at cpu_helper.c:1669 will be always satisfied and restart translation=
,
> > > causing an endless translation loop.
> > >
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
> >
> > > Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> > > ---
> > >   target/riscv/cpu_helper.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index 6c4391d96b..bc146771c8 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *=
env, hwaddr *physical,
> > >               target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block=
, addr1);
> > >               target_ulong old_pte;
> > >               if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> > > -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte,=
 updated_pte);
> > > +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_=
to_le32(pte), cpu_to_le32(updated_pte));
> > >               } else {
> > > -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pte=
);
> > > +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte)=
, cpu_to_le64(updated_pte));
> > >               }
> > >               if (old_pte !=3D pte) {
> > >                   goto restart;
> >
> > If PTEs are always stored in LE order, maybe what we want is earlier:
> >
> > -- >8 --
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 619c76cc001..b6ac2800240 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
> > *env, hwaddr *physical,
> >           if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res);
> > +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs, &res=
);
> >           } else {
> > -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res);
> > +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs, &res=
);
>
> Unfortunately, this doesn't work in two ways:
>
> 1. Note pte is used in the following code and that means pte must hold
> a correct value from the
> view of host endian (in my case, big endian not little endian).
> 2. address_space_ldq_le will dispatch to ldq_le_p, while
> address_space_leq will dispatch to ldq_p.
> However, on little endian targets, ldq_p is an alias of ldq_le_p so
> making no effects.
>
> Per my testing, this patch doesn't have any effect indeed. To have a
> brief view what is happening,
> see the logs just before atomic_cmpxchg:
>
> pte_pa 0xf14000000000000 =3D=3D pte 0x140f ? updated_pte 0x144f
>
> >           }
> > ---

