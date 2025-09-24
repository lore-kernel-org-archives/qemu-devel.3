Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D76ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 04:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1HH1-00067w-B0; Wed, 24 Sep 2025 00:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1v1HGx-00067M-Li
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:38:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1v1HGq-0006JR-8q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:38:30 -0400
Received: from loongson.cn (unknown [209.85.166.50])
 by gateway (Coremail) with SMTP id _____8Dx+tGkddNoPPENAA--.30308S3;
 Wed, 24 Sep 2025 12:37:57 +0800 (CST)
Received: from mail-io1-f50.google.com (unknown [209.85.166.50])
 by front1 (Coremail) with SMTP id qMiowJBxZOSiddNoe1+qAA--.15742S3;
 Wed, 24 Sep 2025 12:37:55 +0800 (CST)
Received: by mail-io1-f50.google.com with SMTP id
 ca18e2360f4ac-8b0055cbd0fso356387639f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 21:37:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW42zFR5BE5rDfMFVL9PKyPEwuFIJNaNzYY/A8zeN+tz9jRBJP6/VFqXkL2SBj26NV29mINUTHW/XN6@nongnu.org
X-Gm-Message-State: AOJu0YyFGieXgFITd/QVcD1w+v5fhAYFIB/NUREztqV846mv4PWoIxtB
 nvNS2esZ0XVyQhxZMrRJDKIHA570G+s9UFhLt9iDKMMA7bm3dXaap1ZURs20zk2PecI7K17gQBF
 eS8KQ82Pd5o8MGZiPwEKATOB+NR55C9HXGuzRwtRKbw==
X-Google-Smtp-Source: AGHT+IFNW0m077Y9mnwp3sxHRMgYsO7DN7QCoFKdNshrBEsDOjId6wnXA3XIuEeFr+2cPXM8Lo2hLP/BNo/APCViUEc=
X-Received: by 2002:a05:690e:2588:b0:635:4ecd:75a4 with SMTP id
 956f58d0204a3-63604663e32mr2791959d50.50.1758688177365; Tue, 23 Sep 2025
 21:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250919124901.2756538-1-wangrui@loongson.cn>
 <c0fc38df-9c52-406f-8d8b-f2496b4e410f@linaro.org>
In-Reply-To: <c0fc38df-9c52-406f-8d8b-f2496b4e410f@linaro.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 24 Sep 2025 12:29:25 +0800
X-Gmail-Original-Message-ID: <CAHirt9ifqqrzcc3oJ1VAfEhHAP+U4bW=yh+BJJxkgaArKOhG+A@mail.gmail.com>
X-Gm-Features: AS18NWBtrwwrjVnLSgY09gqOQZDuhDvbENnMDhxFPX2b9vUJHi1TthEXAB6_r0s
Message-ID: <CAHirt9ifqqrzcc3oJ1VAfEhHAP+U4bW=yh+BJJxkgaArKOhG+A@mail.gmail.com>
Subject: Re: [PATCH] tcg/optimize: Fix folding of vector bitsel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu@hev.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowJBxZOSiddNoe1+qAA--.15742S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF15ZF13WFykuF4fZw17XFc_yoW8Cr4Upr
 4F9FsFkF98X3y8ur90kr9rtry5CrZ8ta18JryYyF4DZw1DtFn8W34DKrWagF9rZrnYkr10
 vF1vva47CanFqabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
 Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
 Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWU
 twC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
 AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
 A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI
 43ZEXa7IU8OyCJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 19/9/25 14:49, WANG Rui wrote:
> > It looks like a typo.
>
> Likely from the TCG_TARGET_HAS_andc_vec case.
>
> > When the false value (C) is the constant -1, the
> > correct fold should be: R =3D B | ~A
> >
> > Reproducer (LoongArch64 assembly):
> >
> >       .text
> >       .globl  _start
> >   _start:
> >       vldi    $vr1, 3073
> >       vldi    $vr2, 1023
> >       vbitsel.v       $vr0, $vr2, $vr1, $vr2
> >       vpickve2gr.d    $a1, $vr0, 1
> >       xori    $a0, $a1, 1
> >       li.w    $a7, 93
> >       syscall 0
> >
> > Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
> > Link: https://github.com/llvm/llvm-project/issues/159610
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> >   tcg/optimize.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tcg/optimize.c b/tcg/optimize.c
> > index 3638ab9fea..f69702b26e 100644
> > --- a/tcg/optimize.c
> > +++ b/tcg/optimize.c
> > @@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCG=
Op *op)
> >               return fold_and(ctx, op);
> >           }
> >           if (fv =3D=3D -1 && TCG_TARGET_HAS_orc_vec) {
> > +            TCGArg ta =3D op->args[2];
> >               op->opc =3D INDEX_op_orc_vec;
> >               op->args[2] =3D op->args[1];
> > -            op->args[1] =3D op->args[3];
> > +            op->args[1] =3D ta;
> >               return fold_orc(ctx, op);
> >           }
> >       }
> Looks correct, but I don't understand the swap. Can't we justkeep the
> same argument order for an ORC opcode? I'd have done:
>
> -- >8 --
> @@ -1569,8 +1569,6 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp
> *op)
>           }
>           if (fv =3D=3D -1 && TCG_TARGET_HAS_orc_vec) {
>               op->opc =3D INDEX_op_orc_vec;
> -            op->args[2] =3D op->args[1];
> -            op->args[1] =3D op->args[3];
>               return fold_orc(ctx, op);
>           }

Bitwise logic can be tricky and easy to get wrong. In general, (a |
~b) !=3D (b | ~a). For example, when a =3D 0 and b =3D 1, the results
differ.

>       }
> ---


