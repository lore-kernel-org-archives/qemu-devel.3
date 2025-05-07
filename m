Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC9C3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 01:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCTJT-0006b1-P4; Tue, 06 May 2025 21:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uCTJI-0006ae-D4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:10:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uCTJF-0005OU-0j
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:10:56 -0400
Received: from loongson.cn (unknown [209.85.128.170])
 by gateway (Coremail) with SMTP id _____8AxDGsUsxpoH4nXAA--.25729S3;
 Wed, 07 May 2025 09:10:45 +0800 (CST)
Received: from mail-yw1-f170.google.com (unknown [209.85.128.170])
 by front1 (Coremail) with SMTP id qMiowMCxrhsOsxpoNLa4AA--.24193S3;
 Wed, 07 May 2025 09:10:40 +0800 (CST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-708b3cc144cso60592707b3.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 18:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUc4KbhOsN/wbXKfjJ08cGuekYDod6k6qL9PtbpPwjDJQW8oNek0e2zXks2hevt1KEKWY0zc6VKMtWm@nongnu.org
X-Gm-Message-State: AOJu0YyZWbP2zL3IriBkYckgul4Nnu4YpJB8M2MD/XkHjxMoY8CvaLaE
 pqTDOQMnWexSKaxMtExdiZfqnPBbJcvCO8QUR7G5TXiX86TGlcyV6KvartZ4yfhBVjonOTJFHbO
 m+sit2QtFNK1pHdvR8xChgaLCb6qad4bW4c2e1A==
X-Google-Smtp-Source: AGHT+IFCSTdHfZ0hahTZxsah8nW/IXb25vcAoKq59KcLXIW1AIMZg0Iw9/pa+/C4frpjcQlt5I2hzf1EopdFd8aBc2A=
X-Received: by 2002:a05:690c:6f0a:b0:706:cc6b:855e with SMTP id
 00721157ae682-70a1dad28bamr23712797b3.30.1746580236923; Tue, 06 May 2025
 18:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152600.2521399-1-wangrui@loongson.cn>
 <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
In-Reply-To: <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 7 May 2025 09:10:25 +0800
X-Gmail-Original-Message-ID: <CAHirt9inR94pDOPppE9-uUBCeoF2myFWJekFjmS0pK9qAFw9jg@mail.gmail.com>
X-Gm-Features: ATxdqUE11EubDt6hlqFgZMvkPylimZ6sn5RR0OfxlSXpqOCAyR6T5Mn8_KrXUck
Message-ID: <CAHirt9inR94pDOPppE9-uUBCeoF2myFWJekFjmS0pK9qAFw9jg@mail.gmail.com>
Subject: Re: [PATCH] target/loongarch: Fix incorrect rounding in fnm{add, sub}
 under certain modes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMCxrhsOsxpoNLa4AA--.24193S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4DKw13WFyDWw4UWr18Xrc_yoWrJF1fpr
 WfCF1YkFWkJF4xAwn3X34qqF13Xr18Ga1UZr1xKryDCws8Jr1IqF1xt3WUuF4UG345Ww1a
 vrs5K34UGa4DZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
 x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
 McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1l
 x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
 v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
 x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
 Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
 pf9x07jbPEfUUUUU=
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

Hi Richard,

On Wed, May 7, 2025 at 1:50=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/6/25 08:26, WANG Rui wrote:
> > This patch fixes incorrect results for [xv]fnm{add,sub}.{s,d}
> > instructions when rounding toward zero, postive, negative.
> >
> > According to the LoongArch ISA specification, these instructions perfor=
m
> > a fused multiply-add followed by a negation of the final result.
> >
> > Previously, the sign inversion was applied before fused operation, whic=
h
> > interfered with rounding decisions that depend on the result sign --
> > leading to deviations from the expected behavior. This patch corrects
> > the implementation by applying the negation after fused multiply-add,
> > ensuring that rounding is performed on the correct intermediate result.
> >
> > Reported-by: mengqinggang <mengqinggang@loongson.cn>
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> >   target/loongarch/tcg/fpu_helper.c     |  8 ++++++++
> >   target/loongarch/tcg/vec_helper.c     |  7 ++++++-
> >   tests/tcg/loongarch64/Makefile.target |  2 ++
> >   tests/tcg/loongarch64/test_fnmsub.c   | 20 ++++++++++++++++++++
> >   tests/tcg/loongarch64/test_vfnmsub.c  | 27 ++++++++++++++++++++++++++=
+
> >   5 files changed, 63 insertions(+), 1 deletion(-)
> >   create mode 100644 tests/tcg/loongarch64/test_fnmsub.c
> >   create mode 100644 tests/tcg/loongarch64/test_vfnmsub.c
> >
> > diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/f=
pu_helper.c
> > index fc3fd0561e..970b88ac56 100644
> > --- a/target/loongarch/tcg/fpu_helper.c
> > +++ b/target/loongarch/tcg/fpu_helper.c
> > @@ -389,9 +389,13 @@ uint64_t helper_fmuladd_s(CPULoongArchState *env, =
uint64_t fj,
> >                             uint64_t fk, uint64_t fa, uint32_t flag)
> >   {
> >       uint64_t fd;
> > +    uint32_t neg_res;
> >
> > +    neg_res =3D flag & float_muladd_negate_result;
> > +    flag ^=3D neg_res;
> >       fd =3D nanbox_s(float32_muladd((uint32_t)fj, (uint32_t)fk,
> >                                    (uint32_t)fa, flag, &env->fp_status)=
);
> > +    fd |=3D neg_res ? 0x80000000ULL : 0;
>
> |=3D cannot possibly be correct -- it would have to be ^=3D.

Good catch!

>
> Is this a problem with the sign of a NaN result?  That's the only case th=
at isn't handled
> by floatN_muladd.  target/arm/ does not use the float_muladd_* flags for =
exactly this
> reason.  The LoongArch manual has
>
>    FNMSUB.D:
>      FR[fd] =3D -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])

In the case of `FNMSUB.D`, the result of instruction is computed as
the negation of `FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])`,
where `FP64_fusedMultiplyAdd()` performs a fused multiply-add
operation compliant with IEEE 754-2008. The negation is applied to the
fully rounded result of the fused operation, not to any intermediate
value. This behavior is specific to LoongArch and differs from other
architectures, which is why the existing `float_muladd_negate_result`
flag does not apply here.

Regards,
-hev

>
> which matches the language in the Arm manual.  Which does suggest that th=
e negation before
> on fa and the negation after on the result should be unconditional.
>
> However, for this test case, if I'm interpreting these numbers correctly,
>
> > +    *(uint64_t *)&x =3D 0x4ff0000000000000UL;
> > +    *(uint64_t *)&y =3D 0x4ff0000000000000UL;
>
>   0x1.0p256
>
> > +    *(uint64_t *)&z =3D 0x2ff0000000000000UL;
>
>   0x1.0p-256
>
> > +
> > +    fesetround(FE_DOWNWARD);
> > +    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
> > +        :[x]"+f"(x)
> > +        :[y]"f"(y), [z]"f"(z));
> > +
> > +    assert(*(uint64_t *)&x =3D=3D 0xdfefffffffffffffUL);
>
>    -(0x1.0p512 - epsilon)
>
> That really should have worked as-is.  I'll have a quick look.
>
>
> r~


