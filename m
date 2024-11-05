Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CFD31769
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NT0-00052k-J2; Tue, 05 Nov 2024 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NSu-00052K-1q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:35:41 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NSq-0001SF-Vb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:35:39 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso40999a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 09:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730828133; x=1731432933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBkNgXMGLims9qs0/w9lPjJDn3qEGKCxXwy34dsDzT0=;
 b=T/nfdoR1Q2JKZR60Rp2jYDVIJeEwbnoaKaHIUDfVnHL8HykKmrCZEwQgE+4Ld7LoXg
 uyf40WBpujcPgxqnbkCNVkNzDaJoiWVC+2jwRvZQdPmpSl0CoJhziqR9HFyBvbqfSW+v
 hHjZXJ0LanfyYAkjzw7TBCDgktFp71gedsRZ2y5WFzo7EoZLOjxXVR4Rkr5dWB2dPSEl
 2eCbR9HsWX1XuHzdyCy1QDXn6wVR7wtpI3IdCDuUh9zvmoEqmscT4nyY0TVP05Ecn+BR
 HrAwGJipOOPU6U6N4zk+aVVeVapchdhkF4WVTqkMAGbVQ5ao+K1hKj1jRjgAa2qiuIsG
 RRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730828133; x=1731432933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBkNgXMGLims9qs0/w9lPjJDn3qEGKCxXwy34dsDzT0=;
 b=QLAR+G2v+Vj0FZlk65FLweNDBIBVZSJbdcMpEyasMB/JnFQmwYsXT65wRgyi7EtpU9
 GDFyZxWhsq4HPiCn6sDgCxXJqlHGu1MTY/v7vh7yGdqbRsaVIUC1J3JfoyQiGvxZad5D
 SeVwKnBF9FxU6PSOMo8yu1yjTrFbinAqhOfCakEeB1B4l9dOEQAAbvqbQkT/Tz6JCnV3
 +UbnfkSX09YJUMaW2weeNT8+vwjv05+mbuCz9TDDlT/q8usZoBvqT/473kfjcI2g35rA
 9dphGq48RY0OiLWr0HDvEPxR9nnDBUbk4uoAQjql64L8FY/XgpDCVzbLgFH3coEMcmxT
 rxwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAoyw4oAjXMmLM/I508mt0Ym6djIBd1kkPrLa7KHSvcrhcdq6kt68VJZgx5cZbv08xotkk/IY14v4z@nongnu.org
X-Gm-Message-State: AOJu0YzIrYBlR1UMhlqqhytV9yE+O29rGSRrmhJPXWttFpBSyjpBgLkN
 GIrXXuRKS69RgJfCQhlctilmOTO8Kh/4/TYvdG/izDql7H2EBDHr5+TVb5lDQ0I1qM/SDEPk432
 oMtDjIz7k0LY5x7DIlinJGGdtBwwjTUppEtL4Gw==
X-Google-Smtp-Source: AGHT+IGL5htrgsFTmBx2FQl6EmfNpCafkcpNFITq6qvXy7lby4rrtCkls29ahdLJnXfq0VDlaSlKkc40FczoaYkvqnk=
X-Received: by 2002:a05:6402:d4c:b0:5cb:881e:6d3c with SMTP id
 4fb4d7f45d1cf-5ceabf26e83mr16627763a12.8.1730828133335; Tue, 05 Nov 2024
 09:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-16-npiggin@gmail.com>
 <49b1d57d-e0bf-4b64-b6ef-3cb4e1da5d65@kaod.org>
In-Reply-To: <49b1d57d-e0bf-4b64-b6ef-3cb4e1da5d65@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 17:35:21 +0000
Message-ID: <CAFEAcA869xMGhB+K1x722CL0bD0a55+oWofpsW610HSycz_Yag@mail.gmail.com>
Subject: Re: [PULL 15/96] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jul 2024 at 11:11, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/26/24 01:52, Nicholas Piggin wrote:
> > The POWER8 LPC ISA device irqs all get combined and reported to the lin=
e
> > connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
> > host controller irqs use that line, and the device irqs get routed to
> > 4 new lines connected to PSI SERIRQ0-3.

Ping! It looks like these issues are still floating around...

> > -static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
> > +/* Program the POWER9 LPC irq to PSI serirq routing table */
> > +static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
> >   {
> > -    bool lpc_to_opb_irq =3D false;
> > +    int irq;
> >
> > -    /* Update LPC controller to OPB line */
> > -    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
> > -        uint32_t irqs;
> > +    if (!lpc->psi_has_serirq) {
> > +        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
> > +            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
>
>
> Coverity reports an issue :
>
>      CID 1558829:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>      "lpc->opb_irq_route0 & (70931694131085312ULL /* (0x8000000000000000U=
LL >> 8) - (0x8000000000000000ULL >> 13) | (0x8000000000000000ULL >> 8) */)=
" is always 0 regardless of the values of its operands. This occurs as the =
logical first operand of "||".
>
> Should the above if use PPC_BITMASK32 instead ?

Seems likely to me.

> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                "OPB: setting serirq routing on POWER8 system, ignorin=
g.\n");
> > +        }
> > +        return;
> > +    }
> >
> > -        irqs =3D lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
> > -        lpc_to_opb_irq =3D (irqs !=3D 0);
> > +    for (irq =3D 0; irq <=3D 13; irq++) {
> > +        int serirq =3D (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) &=
 0x3;
> > +        lpc->irq_to_serirq_route[irq] =3D serirq;
> >       }
> >
> > -    /* We don't honor the polarity register, it's pointless and unused
> > -     * anyway
> > -     */
> > -    if (lpc_to_opb_irq) {
> > -        lpc->opb_irq_input |=3D OPB_MASTER_IRQ_LPC;
> > -    } else {
> > -        lpc->opb_irq_input &=3D ~OPB_MASTER_IRQ_LPC;
> > +    for (irq =3D 14; irq < ISA_NUM_IRQS; irq++) {
> > +        int serirq =3D (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) &=
 0x3;
>
>
> Coverity reports an issue :
>
>      CID 1558828:    (BAD_SHIFT)
>      In expression "lpc->opb_irq_route0 >> 22 - irq * 2", shifting by a n=
egative amount has undefined behavior.  The shift amount, "22 - irq * 2", i=
s -8.
>
> The shift value (irq * 2) seems incorrect. should it be ((irq - 14) * 2) =
?

You can also detect this one by doing a clang undefined-sanitizer
build: we try to do a negative shift on startup:

$ ./build/clang/qemu-system-ppc64 -M powernv9
../../hw/ppc/pnv_lpc.c:444:43: runtime error: shift exponent -6 is negative
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../hw/ppc/pnv_lpc.c:444:43 in

thanks
-- PMM

