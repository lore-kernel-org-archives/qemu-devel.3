Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04464D68B09
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZnj-0008QI-Tp; Thu, 14 Nov 2024 08:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZni-0008Q9-Fo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:22:22 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZnf-0006Lc-Qk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:22:21 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso881505a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731590538; x=1732195338; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=erd3vfGBLOndPrcv2kD/ZK/Z1S/QldFs3eEeJreH6LM=;
 b=Z3bNVJHNwug0YJ3+shH3QE0/nMY6u9jNIzddPBaPykr+vGAuWlwXryPqD4ImNPsAil
 vy2h97GzEzeZ9o5JnyWdf91jCAOGQAVRJLCSC7PkXc+GpEgig1fLdwH/hWmNKxcp0SYs
 aBFNoWgUOWTMK5bMF+SPNpcf3+5nqlQN0kC0ms8KERm9w65ARPSmILhdlE68TXgpRZ4y
 eaRZ0MJ7RetCZiRlDtbhB6aYiUP5jKq1KlC8ok/l9RdDJ+U/pe24RirwACZp3oD9+8XQ
 5aEw2Urc3zf8156uObwaWwqJM6FVHCU6r3WIDYQuIvgoYf8OzlsTnOlH7aRgBSUINAkb
 RyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731590538; x=1732195338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=erd3vfGBLOndPrcv2kD/ZK/Z1S/QldFs3eEeJreH6LM=;
 b=pD9i2bWVITc2n6lVDpmtFk+Ky7l79D58aqkw7Di2MDI/rrNdXOAN9ORHTlI4Js35JQ
 zyXSFHWC988GvdoLTPE5PPLhzZss+yZPxrSCNjmB0NLbrreeySXCFke6p8kPzKEjKxLu
 +a67J1v5NdwbEPYOGPsIaFUZIzP2agAub/oiLv4n0PoYM9emE6Lz3CQlazJYoMrfCXka
 ken+K2fqCVg82LFjKv5E+9wWRWJnkV33dKGE4MJWDlkX0WcYyYJe8RRQHR4+Do5Ab59S
 dX/9iyYhsxzD7v8E0cQ/yuhTBnHEoH9uq7ntgdTsFiJFolHPoqgwjYzkDY5l8FqSsW99
 85RQ==
X-Gm-Message-State: AOJu0YwxfHuyVbHbF9Z5+5fKSEuju0eATMqMtQnL5WAIRFVxEe8aUDXD
 8t1QC0/loXz7fYM4RIn70J9++Nw7HGr+woeZ3kjxFxPYeFZA0aazXf6YoBCr3f4KxmNBoxzswm5
 RlNGJdJVvgoEbjmgdX4Y+dfODOUj5ztnu6K/exgqfNbjlpK7x
X-Google-Smtp-Source: AGHT+IGI2ezcjvqRifDEOCaaBW6PkR40OG//WgdhieBGPGKNrfYMHRNJrsZu2ipkOPXF7z5jkb0MqxkSQ8uUNO+CUhQ=
X-Received: by 2002:a05:6402:51ce:b0:5cf:45d4:3f8f with SMTP id
 4fb4d7f45d1cf-5cf45d44215mr10656886a12.12.1731590537794; Thu, 14 Nov 2024
 05:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20241105180205.3074071-1-peter.maydell@linaro.org>
 <dae49b9c-0d47-4811-bd48-fdd401594609@ilande.co.uk>
In-Reply-To: <dae49b9c-0d47-4811-bd48-fdd401594609@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 13:22:07 +0000
Message-ID: <CAFEAcA82rYdZduR73CjJr7hYWG7N5e4Dqmx5j1O=3FT_BqboNQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/openpic: Avoid taking address of out-of-bounds
 array index
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 6 Nov 2024 at 11:58, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 05/11/2024 18:02, Peter Maydell wrote:
>
> > The clang sanitizer complains about the code in the EOI handling
> > of openpic_cpu_write_internal():
> >
> > UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
> > ../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in
> >
> > This is because we do
> >    src = &opp->src[n_IRQ];$
>
> Extra $ symbol at the end of the line here?

Yep (cut-n-paste from an editor that marks end-of-lines).

> > when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
> > is -1 then we don't do anything with the src pointer, but it is
> > undefined behaviour. (This has been present since this device
> > was first added to QEMU.)
> >
> > Rearrange the code so we only do the array index when n_IRQ is not -1.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Arguable whether it's worth the stable backport or not...
> > ---
> >   hw/intc/openpic.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> > index cd3d87768e0..2ead4b9ba00 100644
> > --- a/hw/intc/openpic.c
> > +++ b/hw/intc/openpic.c
> > @@ -1031,13 +1031,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
> >           s_IRQ = IRQ_get_next(opp, &dst->servicing);
> >           /* Check queued interrupts. */
> >           n_IRQ = IRQ_get_next(opp, &dst->raised);
> > -        src = &opp->src[n_IRQ];
> > -        if (n_IRQ != -1 &&
> > -            (s_IRQ == -1 ||
> > -             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
> > -            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> > -                    idx, n_IRQ);
> > -            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> > +        if (n_IRQ != -1) {
> > +            src = &opp->src[n_IRQ];
> > +            if (s_IRQ == -1 ||
> > +                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
> > +                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> > +                        idx, n_IRQ);
> > +                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> > +            }
> >           }
> >           break;
> >       default:
>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks. I can take this via target-arm.next, or does anybody
have a different preference?

-- PMM

