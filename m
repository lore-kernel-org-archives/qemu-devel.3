Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA99C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4adN-0001RI-PB; Tue, 15 Apr 2025 03:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4adK-0001Qg-3R; Tue, 15 Apr 2025 03:23:02 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4adH-0003l7-Rz; Tue, 15 Apr 2025 03:23:01 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4c30f11e79bso60948137.0; 
 Tue, 15 Apr 2025 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744701777; x=1745306577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6rvcmtjGCLvp2DM6nogkFvSmbecYxxuYsd9xDOpYdI=;
 b=deUxwZTY7FOPwZYtnuLNLC1mxB+r8BYLphOONcBKIK+IKp6GMP9d7cxcC1QNx7xNCQ
 odHVmRgBhTj1oBBG5R7DsJqLINMhlhRbkmfjuUATqf0kR1nqv2jqDVwqEoTxZAKSlhfc
 xjYMWf9Q0+fsHcHpwPoZnpy160WSBRR6/8jNnNeXvuu0y1OW9luLERYNlrrUi3KGrJ4U
 wsIEDcDfOOybsv4ym0Rmyglx5SSylvUqqQW/gyMDFH09WuUMXk6I6INsdsUOFLOkriOZ
 qERnl0AQwVOvIXOU/346WpQy9vY6FqPUaEwZA3PgZy5XiHAuzA0O06Qpi0T0+1lg3EnL
 EYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701777; x=1745306577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6rvcmtjGCLvp2DM6nogkFvSmbecYxxuYsd9xDOpYdI=;
 b=Jm1mKt6xRMn7eTRwz36ft5HEDZCu1YYj/FSjkZb3scAngVAiHidoBt6Qx9X/nn4DM3
 xYcVuf95H6sP6qliCFKVjBeern3mNdF+tjqfpGQbvimyktcncYopx/zYExLWtGpTO4p8
 2KDPj/dIu707/VJC3AflRCdE+N4dvM39cw66mO0JfkRmQgckWZEHJc+6CLPJC0SJW14q
 0LfJL7M078l7W3g7k6nzPDyL6emfvRnMabOjuSwgKkU4ivUs0VZJUbifm425Svnv0+Up
 PhcqxoKt42+OcA/pDsuKtXZgPNXareQrLD1ANFaCvZwf36CxNLOl2l9MDa5Jri31JgZb
 I/aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDRbpd/42JhV0ppDgk8f2ve4UeSQfhit+XsYJYMY0TZys3KssHRXdYte9wV9wO4kzDPdrJVHA7WVCN7t4=@nongnu.org
X-Gm-Message-State: AOJu0YyrSIBTxWWhvHatsVaXZ/eQGILNQcXLr1yU4W3Ksiyt+u23CnZy
 vsXxaG70x3gw1RPaLFY3XjGG19s0XQ4jX66TfbKac1xh8vTgazDSuVrBcO0UxIthd3xcfRzwPcl
 36K8HalamcLdvtjNFOfegYEk3Yf4=
X-Gm-Gg: ASbGnctmaLodIYPulWhQM4n1IhRc6AFcUQPeO2sQ7h8ModiWeU4FJIutvoPY9wcWTNR
 qXNggHXuWotoPxOMYuX6qJtdHxup+mmnCp46GsoTaQOwAcN79T6gM1npdZpr9QWyyC4ZakYIOLH
 jGy099i3oXIdgn6FTfb5HQlQ==
X-Google-Smtp-Source: AGHT+IGmGGoXAmc1QgzIuOJP251F34UrDM+DaFo1wEz4NmzK8EgywrxzHYEPz3V5O4XJiGBFthtfQlwoIk7eMJu3YKQ=
X-Received: by 2002:a05:6102:5488:b0:4b6:5e0f:6ddc with SMTP id
 ada2fe7eead31-4c9e4f224a4mr10004773137.14.1744701776813; Tue, 15 Apr 2025
 00:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
 <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
 <c566eed5-605f-4aeb-8841-dae4e591fcb3@linaro.org>
 <CAM0BWNBNrjJ6UuF+TRtkuEesLatnY1pzSjyaiPVDeKSMF8no-A@mail.gmail.com>
 <CAM0BWNBGAJ-scbhXAQ2s2Y=w3WhJ5pR72xSA5Xf+bsbk73cL6w@mail.gmail.com>
 <7d2e61de-17da-4a6b-b9c8-2ff14fdce15f@linaro.org>
 <CAM0BWNCOYwNZjD4h2XgEesV-HJYbDhapqfPYDcMm+U90PeU-vA@mail.gmail.com>
In-Reply-To: <CAM0BWNCOYwNZjD4h2XgEesV-HJYbDhapqfPYDcMm+U90PeU-vA@mail.gmail.com>
From: Ziqiao Kong <ziqiaokong@gmail.com>
Date: Tue, 15 Apr 2025 15:22:45 +0800
X-Gm-Features: ATxdqUFiLGNYFHfCSGBgcwVgQFKczeZaGfkYieDMhVNTEwtDPNXkDk3ohEdVeno
Message-ID: <CAM0BWNDZG-KfFMT4SD9Ye+CNc=tcNpCLLTmGPTuKGyeGWBjXoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, 
 alistair.francis@wdc.com, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=ziqiaokong@gmail.com; helo=mail-vs1-xe2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 15, 2025 at 3:19=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail.com> =
wrote:
>
> Hello Philippe,
>
> On Tue, Apr 15, 2025 at 3:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > On 15/4/25 09:04, Ziqiao Kong wrote:
> > > Accidentally not cc all recipients. Sorry for the confusion. Below is
> > > the duplicated message:
> > >
> > > Hello Philippe,
> > >
> > > On Tue, Apr 15, 2025 at 1:38=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > > <philmd@linaro.org> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 14/4/25 18:59, Ziqiao Kong wrote:
> > >>> Hello Philippe,
> > >>>
> > >>> Any further concern regarding this series? I certainly would like t=
o investigate
> > >>> and help =3D).
> > >>
> > >> Short term I can't keep looking because I'm busy with other stuffs a=
nd
> > >> tagged this patch for another review, because there is some endianne=
ss
> > >> code smell in get_physical_address(). I understand your change fixes
> > >> your issue, but I'm skeptical about it, in part because there are no
> > >> such use in the whole code base. My change suggestion is just a star=
ting
> > >> point, more is needed.
> > >
> > > Thanks for responding.
> > >
> > > Actually, the pattern of this usage is actually very common in the co=
de base and
> > > that's why I fixed in this way. Sorry I should have put this in the
> > > cover letter to
> > > justify my fix. Below is an incomplete list of the code using this pa=
ttern:
> > >
> > > - target/i386/tcg/system/excp_helper.c:129
> > >
> > > if (likely(in->haddr)) {
> > > old =3D cpu_to_le32(old);
> > > new =3D cpu_to_le32(new);
> > > return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) =3D=3D old;
> > > }
> > >
> > > - target/arm/ptw.c: 840
> > >
> > > if (ptw->out_be) {
> > > old_val =3D cpu_to_be64(old_val);
> > > new_val =3D cpu_to_be64(new_val);
> > > cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_v=
al);
> > > cur_val =3D be64_to_cpu(cur_val);
> > > } else {
> > > old_val =3D cpu_to_le64(old_val);
> > > new_val =3D cpu_to_le64(new_val);
> > > cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_v=
al);
> > > cur_val =3D le64_to_cpu(cur_val);
> > > }
> >
> > Doh OK...
> >
> > >
> > > You might want to do a `grep -rn "qatomic_cmpxchg" .` to see all matc=
hes.
> > >
> > >
> > >>
> > >>>
> > >>> Bests,
> > >>> Ziqiao
> > >>>
> > >>> On Mon, Apr 14, 2025 at 7:17=E2=80=AFPM Ziqiao Kong <ziqiaokong@gma=
il.com> wrote:
> > >>>>
> > >>>> On Mon, Apr 14, 2025 at 6:41=E2=80=AFPM Philippe Mathieu-Daud=C3=
=A9
> > >>>> <philmd@linaro.org> wrote:
> > >>>>>
> > >>>>> Hi,
> > >>>>>
> > >>>>> On 14/4/25 05:46, Ziqiao Kong wrote:
> > >>>>>> On big endian systems, pte and updated_pte hold big endian host =
data
> > >>>>>> while pte_pa points to little endian target data. This means the=
 branch
> > >>>>>> at cpu_helper.c:1669 will be always satisfied and restart transl=
ation,
> > >>>>>> causing an endless translation loop.
> > >>>>>>
> > >>>>>
> > >>>>> Cc: qemu-stable@nongnu.org
> > >>>>> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
> > >>>>>
> > >>>>>> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> > >>>>>> ---
> > >>>>>>     target/riscv/cpu_helper.c | 4 ++--
> > >>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper=
.c
> > >>>>>> index 6c4391d96b..bc146771c8 100644
> > >>>>>> --- a/target/riscv/cpu_helper.c
> > >>>>>> +++ b/target/riscv/cpu_helper.c
> > >>>>>> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVSt=
ate *env, hwaddr *physical,
> > >>>>>>                 target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ra=
m_block, addr1);
> > >>>>>>                 target_ulong old_pte;
> > >>>>>>                 if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> > >>>>>> -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa,=
 pte, updated_pte);
> > >>>>>> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa,=
 cpu_to_le32(pte), cpu_to_le32(updated_pte));
> >
> > Then don't we need:
> >
> >      old_pte =3D le32_to_cpu(old_pte);
> >
> > >>>>>>                 } else {
> > >>>>>> -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, update=
d_pte);
> > >>>>>> +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64=
(pte), cpu_to_le64(updated_pte));
> >
> >      old_pte =3D le64_to_cpu(old_pte);
> >
> > ?
>
> Note old_pte is no longer used later (it is defined within the scope here=
) and
> dropped immediately after qatomic_cmpxchg so we don't need that extra bsw=
ap.

Also pte is not modified inplace previously, unlike the code samples above.

>
> >
> > >>>>>>                 }
> > >>>>>>                 if (old_pte !=3D pte) {
> > >>>>>>                     goto restart;
> > >>>>>
> > >>>>> If PTEs are always stored in LE order, maybe what we want is earl=
ier:
> > >>>>>
> > >>>>> -- >8 --
> > >>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.=
c
> > >>>>> index 619c76cc001..b6ac2800240 100644
> > >>>>> --- a/target/riscv/cpu_helper.c
> > >>>>> +++ b/target/riscv/cpu_helper.c
> > >>>>> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVSta=
te
> > >>>>> *env, hwaddr *physical,
> > >>>>>             if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > >>>>> -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &=
res);
> > >>>>> +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs=
, &res);
> > >>>>>             } else {
> > >>>>> -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &=
res);
> > >>>>> +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs=
, &res);
> > >>>>
> > >>>> Unfortunately, this doesn't work in two ways:
> > >>>>
> > >>>> 1. Note pte is used in the following code and that means pte must =
hold
> > >>>> a correct value from the
> > >>>> view of host endian (in my case, big endian not little endian).
> > >>>> 2. address_space_ldq_le will dispatch to ldq_le_p, while
> > >>>> address_space_leq will dispatch to ldq_p.
> > >>>> However, on little endian targets, ldq_p is an alias of ldq_le_p s=
o
> > >>>> making no effects.
> > >>>>
> > >>>> Per my testing, this patch doesn't have any effect indeed. To have=
 a
> > >>>> brief view what is happening,
> > >>>> see the logs just before atomic_cmpxchg:
> > >>>>
> > >>>> pte_pa 0xf14000000000000 =3D=3D pte 0x140f ? updated_pte 0x144f
> > >>>>
> > >>>>>             }
> > >>>>> ---
> > >>
> >

