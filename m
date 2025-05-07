Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A7C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgeV-0006EJ-1S; Wed, 07 May 2025 11:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uCgeS-0006AQ-5z
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:25:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uCgeO-0006gs-SQ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:25:39 -0400
Received: from loongson.cn (unknown [209.85.128.169])
 by gateway (Coremail) with SMTP id _____8CxeXFnextojWDYAA--.26755S3;
 Wed, 07 May 2025 23:25:28 +0800 (CST)
Received: from mail-yw1-f169.google.com (unknown [209.85.128.169])
 by front1 (Coremail) with SMTP id qMiowMDxu8RkextoR3O6AA--.12421S3;
 Wed, 07 May 2025 23:25:25 +0800 (CST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7082e46880eso60903237b3.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWBcwsQlymzo8GH1WAriHffLr0B4ARSgvO4mC9fTtwxkZ/0q0wxkRgthhAxyoLdBTKL22vHoABS9DD9@nongnu.org
X-Gm-Message-State: AOJu0YwB4egtY0GEWi9p+VKrckAx/R7V+VGYYWEKjpxJjqyEjNvIWpGo
 ibyYStyuhPuPxeWi2bTAHr7AgXwzcW2YYXyfDUwfXulpeMfYJYAZPh0erGkJZntltoN71w+jNZW
 hyh2wRJsMx/LOxRdXCMUjgbkJLGRCtaXejonTfQ==
X-Google-Smtp-Source: AGHT+IFYy/3Jly0hZ3YUEuAChnEeIvZtn/EcEZ+HAYOwHU0hfBZPqmrVrTXF5D+uM06oNQOmzb5/pJeiaYcBBgzFOOg=
X-Received: by 2002:a05:690c:650a:b0:6fb:8461:e828 with SMTP id
 00721157ae682-70a1dad5ae4mr49740247b3.30.1746631523254; Wed, 07 May 2025
 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250507091455.3257138-1-wangrui@loongson.cn>
 <f92c8c65-8fb4-4cfe-b793-a5aa17f11c1d@linaro.org>
In-Reply-To: <f92c8c65-8fb4-4cfe-b793-a5aa17f11c1d@linaro.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 7 May 2025 23:25:12 +0800
X-Gmail-Original-Message-ID: <CAHirt9jd4LGkGyp0xKFQYKM3CnPYUs4xJmSyg4je6iMKR_0b5A@mail.gmail.com>
X-Gm-Features: ATxdqUGo_E9NHLOCUWJs74i3zUDNri2GHvvP9RsARnIvEAN7CbXDi4w7r2t8Wew
Message-ID: <CAHirt9jd4LGkGyp0xKFQYKM3CnPYUs4xJmSyg4je6iMKR_0b5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/loongarch: Fix incorrect rounding in
 fnm{add,sub} under certain modes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMDxu8RkextoR3O6AA--.12421S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4rWF4UGF1fArW8Wr1ktFc_yoW8CF1fpF
 W8CF1vyF4FgF1kX397Way0yFyfXw4rtrW3Ga4kWa9xArn0qF12qF4FyrWUua9rCw15Wr4a
 vr4Y93WUWa4qkacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
 x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
 McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1l
 x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
 v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
 x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
 Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
 yTuYvjxU7QzVUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 7, 2025 at 11:04=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/7/25 02:14, WANG Rui wrote:
> > This patch fixes incorrect results for `[xv]fnm{add,sub}.{s,d}`
> > instructions when rounding toward {zero, positive, negative}.
> >
> > According to the LoongArch ISA specification, the result of an
> > instruction like `FNMSUB.D` is computed as:
> >
> >    FR[fd] =3D -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])
> >
> > Here, `FP64_fusedMultiplyAdd()` performs a fused multiply-add operation
> > compliant with IEEE 754-2008. The negation is applied to the fully
> > rounded result of the fused operation - not to any intermediate value.
> > This behavior is specifiec to LoongArch and differs from other arches,
> > which is why the existing `float_muladd_negate_result` flag does not
> > model it correctly.
>
> Loongarch does not differ from other arches; we got it wrong for everyone=
.
> There's no need for a new flag.

I'm not familiar with PowerPC and s390x. The official PowerPC docs[^1]
doesn't clearly specify the order of negation and rounding operations.
I also don't have access to the hardware to run experiments. However,
I did find the Linux kernel's emulation code[^2][^3] for the PowerPC
`fnmsub` instruction, which seems to suggest that negation occurs
before rounding - though it's possible that interpretation is
incorrect.

[^1]: https://www.ibm.com/docs/en/aix/7.2?topic=3Dset-fnmsub-fnms-floating-=
negative-multiply-subtract-instruction
[^2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/math-emu/fnmsub.c?h=3Dv6.15-rc5#n49
[^3}: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/math-emu/fnmsub.c?h=3Dv6.15-rc5#n55

Regards,
-hev

>
>
> r~


