Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA59C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aLH-0003Kv-Op; Tue, 15 Apr 2025 03:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4aLG-0003KT-Fe; Tue, 15 Apr 2025 03:04:22 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4aLD-0001Fc-Hd; Tue, 15 Apr 2025 03:04:22 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4c6cf5e4cd5so123844137.2; 
 Tue, 15 Apr 2025 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744700658; x=1745305458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZmOA0EGwvGVxO5KJ0tZZHGlzGWd9vn2JKSA5zm7LSI=;
 b=V1rnlxto+LYvDYRN492L5EOm49CaNlrEmpwdzvxLRjUXNCVyvFaETPLw9hTtUQGEFx
 cc818OQQRixoRNcWYKsnwHJXl57w6lW3cd3xuQSsdhjJBGYjU6HjpauaHNFFfRVrnNOL
 kxoDoZgILH9V7iJWX7picYTZ+9vWOs4TJYoutjiXqvg0djNtPS0U0EBtpmQzH1e7U8Q4
 n2eTMHVSOfgR2rftO2vEabPY0AOq9X+nLsYQ4oPotP6kv8SIjOYQJaZVjPJOCyx4dECB
 XcYEfPAVp9mWv1yEjvQRQsd8YnD8QlkK3hDqTCAevIC3cw7asZH/JyKAcc5wt0qYvDUP
 zDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744700658; x=1745305458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZmOA0EGwvGVxO5KJ0tZZHGlzGWd9vn2JKSA5zm7LSI=;
 b=mQJfO2xYQb7Ye97yJN5LkpKW/rUE1nOTCofvgK/loF+1x347xmsfYH06wCZvZmABzc
 TovlM4hBieUPn9zWTRTSbncIErn+GWmsPOVkukxz7YjDhlksxnuMyvax18+2dmigNOyH
 FUsPTY47bzoHsjcC43/qYZTnazGUstarhzYIfB1CthH/SQbqVXXrFcQmI9Ikve9l4Il2
 Xas1oBFJHAWUS0KC/PsWnUmEbYDonaP99CZwERD3ZuOSQqgBYpXmdRHeggR+DuAr3ry4
 a5TvCqhFQHiwWkVjsOyZrROhU+ERhEeAB9bVWcCPYUURiRHxS85RDsC/xhsg40bqGPqq
 2FEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1sqQoIL5yq6aL+0+WXFwkLckdrvQaxyeetdPq6BMd8ogVDm/DSh6ri2cPoa6xvE6xx2sqtNnFlawRnuk=@nongnu.org
X-Gm-Message-State: AOJu0YyzKrb0aSydVYJiCfg5+rww0hB7x6D0f1nxsMjUGMqyw+sFJpdv
 1nXY64x0s1Emk+peo7Ej2jKx9+Od0L6AVEtBB1weBCQoNWIECxUMNmk7N+XIkF1qC0twdFME2yE
 S14QQHTbQ2Aof7BZcLxlkvdLoZ6A=
X-Gm-Gg: ASbGncvWnAEOgzXCSjpTBRKe3dc7FQlPl17dOuCVcQWLefe1mXo7FNRbVEK1M9/GH6C
 /sx0h0HrCPU8i9tA4Yw5KgJn6s7wLhNysWuFT7ZJW62ddLkm947RXTBSuZhCapg/mgYIjlQG7EC
 pHS2YenTXC8lY75bK1w2sWhw==
X-Google-Smtp-Source: AGHT+IGt+o042B+NzTtA7h3oumJiGRQ60f6EL6g112SyqklNWvlX5xqkSwxQ8H/4jbmcyKPOalSi2I/gPZgF1ZeByx4=
X-Received: by 2002:a05:6102:e14:b0:4bb:e36f:6a35 with SMTP id
 ada2fe7eead31-4c9e4f17decmr9997382137.14.1744700657796; Tue, 15 Apr 2025
 00:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
 <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
 <c566eed5-605f-4aeb-8841-dae4e591fcb3@linaro.org>
 <CAM0BWNBNrjJ6UuF+TRtkuEesLatnY1pzSjyaiPVDeKSMF8no-A@mail.gmail.com>
In-Reply-To: <CAM0BWNBNrjJ6UuF+TRtkuEesLatnY1pzSjyaiPVDeKSMF8no-A@mail.gmail.com>
From: Ziqiao Kong <ziqiaokong@gmail.com>
Date: Tue, 15 Apr 2025 15:04:05 +0800
X-Gm-Features: ATxdqUEeR-UI9N5_JOGizXtzwfRWBeGXMbDiihSfq9TptR9cOuxcPJwLwd06Rrc
Message-ID: <CAM0BWNBGAJ-scbhXAQ2s2Y=w3WhJ5pR72xSA5Xf+bsbk73cL6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, 
 alistair.francis@wdc.com, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=ziqiaokong@gmail.com; helo=mail-vs1-xe31.google.com
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

Accidentally not cc all recipients. Sorry for the confusion. Below is
the duplicated message:

Hello Philippe,

On Tue, Apr 15, 2025 at 1:38=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 14/4/25 18:59, Ziqiao Kong wrote:
> > Hello Philippe,
> >
> > Any further concern regarding this series? I certainly would like to in=
vestigate
> > and help =3D).
>
> Short term I can't keep looking because I'm busy with other stuffs and
> tagged this patch for another review, because there is some endianness
> code smell in get_physical_address(). I understand your change fixes
> your issue, but I'm skeptical about it, in part because there are no
> such use in the whole code base. My change suggestion is just a starting
> point, more is needed.

Thanks for responding.

Actually, the pattern of this usage is actually very common in the code bas=
e and
that's why I fixed in this way. Sorry I should have put this in the
cover letter to
justify my fix. Below is an incomplete list of the code using this pattern:

- target/i386/tcg/system/excp_helper.c:129

if (likely(in->haddr)) {
old =3D cpu_to_le32(old);
new =3D cpu_to_le32(new);
return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) =3D=3D old;
}

- target/arm/ptw.c: 840

if (ptw->out_be) {
old_val =3D cpu_to_be64(old_val);
new_val =3D cpu_to_be64(new_val);
cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
cur_val =3D be64_to_cpu(cur_val);
} else {
old_val =3D cpu_to_le64(old_val);
new_val =3D cpu_to_le64(new_val);
cur_val =3D qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
cur_val =3D le64_to_cpu(cur_val);
}

You might want to do a `grep -rn "qatomic_cmpxchg" .` to see all matches.


>
> >
> > Bests,
> > Ziqiao
> >
> > On Mon, Apr 14, 2025 at 7:17=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail.c=
om> wrote:
> >>
> >> On Mon, Apr 14, 2025 at 6:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 14/4/25 05:46, Ziqiao Kong wrote:
> >>>> On big endian systems, pte and updated_pte hold big endian host data
> >>>> while pte_pa points to little endian target data. This means the bra=
nch
> >>>> at cpu_helper.c:1669 will be always satisfied and restart translatio=
n,
> >>>> causing an endless translation loop.
> >>>>
> >>>
> >>> Cc: qemu-stable@nongnu.org
> >>> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
> >>>
> >>>> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> >>>> ---
> >>>>    target/riscv/cpu_helper.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>>> index 6c4391d96b..bc146771c8 100644
> >>>> --- a/target/riscv/cpu_helper.c
> >>>> +++ b/target/riscv/cpu_helper.c
> >>>> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState =
*env, hwaddr *physical,
> >>>>                target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_blo=
ck, addr1);
> >>>>                target_ulong old_pte;
> >>>>                if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> >>>> -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte=
, updated_pte);
> >>>> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu=
_to_le32(pte), cpu_to_le32(updated_pte));
> >>>>                } else {
> >>>> -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pt=
e);
> >>>> +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte=
), cpu_to_le64(updated_pte));
> >>>>                }
> >>>>                if (old_pte !=3D pte) {
> >>>>                    goto restart;
> >>>
> >>> If PTEs are always stored in LE order, maybe what we want is earlier:
> >>>
> >>> -- >8 --
> >>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>> index 619c76cc001..b6ac2800240 100644
> >>> --- a/target/riscv/cpu_helper.c
> >>> +++ b/target/riscv/cpu_helper.c
> >>> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
> >>> *env, hwaddr *physical,
> >>>            if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >>> -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res)=
;
> >>> +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs, &r=
es);
> >>>            } else {
> >>> -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res)=
;
> >>> +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs, &r=
es);
> >>
> >> Unfortunately, this doesn't work in two ways:
> >>
> >> 1. Note pte is used in the following code and that means pte must hold
> >> a correct value from the
> >> view of host endian (in my case, big endian not little endian).
> >> 2. address_space_ldq_le will dispatch to ldq_le_p, while
> >> address_space_leq will dispatch to ldq_p.
> >> However, on little endian targets, ldq_p is an alias of ldq_le_p so
> >> making no effects.
> >>
> >> Per my testing, this patch doesn't have any effect indeed. To have a
> >> brief view what is happening,
> >> see the logs just before atomic_cmpxchg:
> >>
> >> pte_pa 0xf14000000000000 =3D=3D pte 0x140f ? updated_pte 0x144f
> >>
> >>>            }
> >>> ---
>

