Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55962C3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 01:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCTM3-0007GQ-On; Tue, 06 May 2025 21:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uCTLy-0007FF-6J
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:13:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uCTLv-0005fN-2Y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:13:41 -0400
Received: from loongson.cn (unknown [209.85.128.171])
 by gateway (Coremail) with SMTP id _____8AxDGuwsxpou4nXAA--.25733S3;
 Wed, 07 May 2025 09:13:20 +0800 (CST)
Received: from mail-yw1-f171.google.com (unknown [209.85.128.171])
 by front1 (Coremail) with SMTP id qMiowMDxu8Spsxpomre4AA--.7774S3;
 Wed, 07 May 2025 09:13:14 +0800 (CST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-702628e34f2so5104757b3.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 18:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5xtpDJnlCmzkCCr1b1qmg8EtGrc5b4/SFHDBf4HN2AXRd8eL8JoKKe1ZGi1Q+eoUH1Ik2lS+MuAeU@nongnu.org
X-Gm-Message-State: AOJu0Yxad6lbMj1ZS8uXznqtTH6zgVvZMAAS9KsMo5TvPZMJDccp++y3
 30dNk8Ly2l9ZV2HExgLFlZqQCtcoGLa4twroJQBkOJ8Vtlp6gzGLCNt4w3Dmn96pbLr7FC1k0m6
 3owed3WJ0oCeK9gQE0cshvyi5RTNQpf99nHkd7A==
X-Google-Smtp-Source: AGHT+IGfT3+jWMAs/XlBhTY/vMg3/vA1hhAjEnR1Q8ALKSVva92IFV/p26neiePqJownaLZ7LTMu75jbnl6hROGLiZ4=
X-Received: by 2002:a05:690c:4587:b0:703:b200:9f08 with SMTP id
 00721157ae682-70a1e1e0fd3mr18097277b3.4.1746580392557; Tue, 06 May 2025
 18:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152600.2521399-1-wangrui@loongson.cn>
 <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
 <4e9fb340-dafa-446d-9939-91614fc8191e@linaro.org>
In-Reply-To: <4e9fb340-dafa-446d-9939-91614fc8191e@linaro.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 7 May 2025 09:13:02 +0800
X-Gmail-Original-Message-ID: <CAHirt9gRPwsL8=m_53D8yJZMSP_GCY0WVedH+CDcjyKOpTk-jA@mail.gmail.com>
X-Gm-Features: ATxdqUFpnRCtYU4u01-eUnboQReP8AnvTYoG-pltltt49vRrfCHOB52W0i-Eq8o
Message-ID: <CAHirt9gRPwsL8=m_53D8yJZMSP_GCY0WVedH+CDcjyKOpTk-jA@mail.gmail.com>
Subject: Re: [PATCH] target/loongarch: Fix incorrect rounding in fnm{add, sub}
 under certain modes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMDxu8Spsxpomre4AA--.7774S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWkXF18Cw4UZrykCFW7GFX_yoW8Wr1fpr
 yfGF12kFZ3tF1xArsFgw1qq3W2v3y8Ca45Jrnayr9rA3Z8Ka47GrW5tayUuF4kWw4kJw4a
 vF4DK3yakan8uagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
 x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
 McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFyl
 x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
 v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
 x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
 Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
 pf9x07jjwZcUUUUU=
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

On Wed, May 7, 2025 at 2:28=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/6/25 10:50, Richard Henderson wrote:
> >> +    *(uint64_t *)&x =3D 0x4ff0000000000000UL;
> >> +    *(uint64_t *)&y =3D 0x4ff0000000000000UL;
> >
> >   0x1.0p256
> >
> >> +    *(uint64_t *)&z =3D 0x2ff0000000000000UL;
> >
> >   0x1.0p-256
> >
> >> +
> >> +    fesetround(FE_DOWNWARD);
> >> +    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
> >> +        :[x]"+f"(x)
> >> +        :[y]"f"(y), [z]"f"(z));
> >> +
> >> +    assert(*(uint64_t *)&x =3D=3D 0xdfefffffffffffffUL);
> >
> >    -(0x1.0p512 - epsilon)
> >
> > That really should have worked as-is.  I'll have a quick look.
>
> The negate_result is applied early, so we're computing rounding on the -(=
1p512 - epsilon),
> and since that's negative, round_down produces -1p512.  Whereas what the =
ISA wants is the
> rounding on (1p512 - epsilon), rounding down to 1.fffffffffffffp511, and =
only afterward
> negating.
>
> I'm thinking that the current placement of the float_muladd_negate_result=
 test is
> incorrect, since we're not negating the result, we're negating the unroun=
ded intermediate.
>
> There are only 3 targets which use float_muladd_negate_result: loongarch,=
 ppc, and sparc.
> I will use this test case to test those other targets as well.

If the current placement of `float_muladd_negate_result` aligns with
the behavior required by PPC and SPARC, then perhaps we could
introduce a separate flag like `float_muladd_negate_rounded_result`
for LoongArch, applying the negation after rounding instead. What do
you think?

Regards,
-hev

>
>
> r~


