Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF25CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOlT-0007OV-O1; Wed, 24 Jun 2026 10:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1wcOlS-0007OG-Mo
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:39:42 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1wcOlR-0002qU-1E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:39:42 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5aa5edf347eso770310e87.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311979; cv=none;
 d=google.com; s=arc-20240605;
 b=gacSxYB7XkSKdPN7Inu9S0WO6V1GGkCVZ0rA7pNtV1IvVXc2WzMzZtK7X423PKvyBF
 hgy/r6fTdD1VQdZwLWAdRPKdXfR4P1Qu4HS8g8kduz9r1/61XYViyr2ulP07XNU1untU
 t/mthv5QlGAW+mnzEcXJ4gLAiRz8spfs0s5PMZJ5bTprUQHzW7X2yEhjl2liWU52arSW
 lK4pkAfPVU7DBZaO8KO9lES+FPRc+R17ur5UVHQ261MjUIuyLBCmDHrrHtzb1rnvfP6V
 uWdGj7u30XyjzcAu1Kq0cUe1tNuC7kYUbRnBYH2/5EqH4G+hufImT3UVrJlUM22WQ6Vx
 UgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ToX7vzujzwu1ZERuBXKxJH0zW2dxltUXq9k0R/akn1s=;
 fh=wYzagAB4gBox6BnyUupwAxJd/jAPk4OH9R+vBVeHg0o=;
 b=LcNXrCYTzoAnzVJG7mdhT3fXEKCF2KqmBzQrhrcLweRUZvV4zOv8aBs4208jx3WQwV
 FvaRgwUROY8b+ZIEy/7TkwdnMf3IOrDP9vhHiu7p81rSBDjSaUBjkn2iCUVZqWEkii2h
 KaZmVkhoI8wIFRhzO7UcL60rra7S+vmQ3BMq5D2A7Hz/9btcO8ZcKAgdJwhxP/cViuKj
 RKkn46dFGmwUkW2SPbLnl2kdas1RlNs3dnP1m+rNsRjLhDnmKkQjfBAFIfxPph8QFxDB
 bev2xufl/xF+aUt+IkXXwHSoXzikC43QXoLBEUKw4DB7ktShG9Gx5BAIN2R5gkFyFla8
 4W2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782311979; x=1782916779; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToX7vzujzwu1ZERuBXKxJH0zW2dxltUXq9k0R/akn1s=;
 b=Y6DwHvj4Hi02c7dqQQOM3GCxVrCUj4UJHHJoRSkSicphG8xqun6fsJLRDb0PVJAI7C
 wFq0eugvuoGQQJlEZE27FJW/Ae1omjVkC1qAAtrDSl3QFIfj5u+2AzohQbhQQgPivowN
 +UnuBRcTuzK/O0nYi13TyRY6ZzOH2nas3/ckc/QHL03LP71jn38OCpiJWowGCFpnLQdI
 gU9RtBtZkGTTayne0rHrwH0Ld+w7+jHWnO2Ds0QlrEN1x2mpvDYp/kiKx7H4EgPJ3w/n
 Yhgz/Z8+B9XyDIJpt62qLDCuoxkq3c13e0RKsnxKRTrxWwB9aAXOCruJPZBGC4a6IjBM
 5/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311979; x=1782916779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ToX7vzujzwu1ZERuBXKxJH0zW2dxltUXq9k0R/akn1s=;
 b=R6TAO0XHF1/9UjyG0oMfB+8rhBSibbohqAlUY8dhcjrw9V1d6pQ/Lc42P+7xOGFD+A
 j8lhlgIz3aS5NsaeZDSTYszsOklgehrsiJTQn5+k3VeU6Xe9gHQ582+AhxbwHsN37zU2
 s+KQJB57bCiRrrgsRlx9skdbeIfwCsfH42s/apgspQWIwSCeKLncQn+DpNqqUpkYK2nE
 7MXfjXAfxhEB/veAd7aAUNxrviLwJJAUABZFBFKcc+l+3ijVOZciS+pAuiqf07TOCcS0
 G6kUWaHseB6FZfGGaJodorZxckFlwKxGwdFDUj0wgFcR7mlDb+rbAVGo9W8l5k21NsH6
 fklA==
X-Gm-Message-State: AOJu0Yzw9mhau3lgH3rXKrjd1b+SZwvaDSauK284S9S3rgwbrPXkQoGz
 zeBLP61qjqdkKp6rMHM5RhwkWVBo02PK2DQvrdmOBeP6tYiTGavwzHU9P6XxIFt6o71k8Fw9zOT
 AeM4Vb84Qn8nYvpfr5vR29Ya+yvohP48=
X-Gm-Gg: AfdE7clu2PxwXTVuS7FEWlBsiVhY8B64iD3iTemCKtjWTY1vMj/2I4EpmjozFUOgbBF
 ICCkC3BonPr0zRRlOoFNneJg94lfoGpdDatxZIpD/syqMUnR1M7f5lt9v7+CPSlgEduWPBUSHEc
 XtAE5VrnE02TC9IST5vUUxINcmJvQbaP/ycB2YkEsCWW/XavIinrFdFqBBp6ERX9QlSwZqTdtPe
 aUREYiHQnqiS5c2ttuK0+TXwrNQmnC5VU+M6meHAwPRGyyvnTsRH1GsXvQmm2RtS7YCUSHTnMZ+
 aaLQG5nQ/ePQK5xwVXItNCHn5dnH
X-Received: by 2002:a05:6512:ac3:b0:5ad:5079:483a with SMTP id
 2adb3069b0e04-5addb81cdc8mr2481854e87.12.1782311978267; Wed, 24 Jun 2026
 07:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260624090052.463075-1-suunj1331@gmail.com>
 <4e78cb10-dbed-4f22-b104-43f45595f86e@oss.qualcomm.com>
In-Reply-To: <4e78cb10-dbed-4f22-b104-43f45595f86e@oss.qualcomm.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Wed, 24 Jun 2026 23:39:25 +0900
X-Gm-Features: AVVi8Cfi9Fp5VXWps5xvboHpH-iCiLiocVwAL6y-rxjSIlQVuREeeA5h2QZ264M
Message-ID: <CAGwK=3oHc_gep8fuoC8F7uQyEMxMvnrcJ_6F4HeSNOXtiJ_ggw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix vsstatus.UXL reserved value
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=suunj1331@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks for the review, Daniel.

I'll add a helper function and resend as v2.

Best regards,
SeungJu

On Wed, Jun 24, 2026 at 9:34=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hello,
>
> On 6/24/2026 6:00 AM, SeungJu Cheon wrote:
> > By the priv spec the value "3" is marked as 'Reserved' for
> > mstatus.UXL. write_mstatus() rejects this value, but
> > write_vsstatus() does not, allowing the reserved value to be
> > written and read back unchanged.
> >
> > Handle a vsstatus.UXL =3D 3 write by writing the current 'xl'
> > instead.
> >
> > Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
> > Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> > ---
> >   target/riscv/csr.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index dd9726fcf4..4c1da61824 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -5226,7 +5226,15 @@ static RISCVException write_vsstatus(CPURISCVSta=
te *env, int csrno,
> >       uint64_t mask =3D (target_ulong)-1;
> >       if ((val & VSSTATUS64_UXL) =3D=3D 0) {
> >           mask &=3D ~VSSTATUS64_UXL;
> > +    } else {
> > +        uint64_t uxl =3D (val & VSSTATUS64_UXL) >> 32;
> > +        if (uxl =3D=3D 3) {
> > +            int xl =3D riscv_cpu_mxl(env);
> > +            val =3D deposit64(val, 32, 2,
> > +                            xl =3D=3D MXL_RV128 ? MXL_RV64 : xl);
> > +        }
> >       }
>
> This is similar to what was done here:
>
> commit ddfd33f1965804fc4a718d8d46bc150525c2f9db
> Author: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Date:   Thu May 14 16:45:37 2026 -0300
>
>      target/riscv/csr.c: fix mstatus.UXL reserved value
>
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 83ca354bf0..d004a4bfb4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2045,7 +2045,17 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>
>       if (xl !=3D MXL_RV32 || env->debugger) {
>           if ((val & MSTATUS64_UXL) !=3D 0) {
> +            uint64_t uxl =3D val & MSTATUS64_UXL >> 32;
>               mask |=3D MSTATUS64_UXL;
> +
> +            /*
> +             * uxl =3D 3 is reserved so write the current xl instead.
> +             * In case xl =3D MXL_RV128 (3) write MXL_RV64.
> +             */
> +            if (uxl =3D=3D 3) {
> +                uxl =3D xl =3D=3D MXL_RV128 ? MXL_RV64 : xl;
> +                val =3D deposit64(val, 32, 2, uxl);
> +            }
>           }
>       }
>
>
> But that patch fixed just write_mstatus().
>
> I suggest adding a local helper riscv_write_uxl (feel free to choose anot=
her better
> name) to encapsulate this logic and then use it in both mstatus and vssta=
tus to
> write UXL:
>
>   val =3D riscv_write_uxl(val)
>
>
> Thanks,
> Daniel
>
>
>
> > +
> >       if ((env->henvcfg & HENVCFG_DTE)) {
> >           if ((val & SSTATUS_SDT) !=3D 0) {
> >               val &=3D ~SSTATUS_SIE;
>

