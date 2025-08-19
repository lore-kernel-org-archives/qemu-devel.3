Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D847CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoODw-0002Eg-Cg; Tue, 19 Aug 2025 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoODu-0002E7-FJ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:26:06 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoODs-0007bo-Fb
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:26:05 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e933a69651dso3168608276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755617163; x=1756221963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r2QXCMIO4z0sNO0fyaO/mu9Yn7X4g6WvSYCK977bQks=;
 b=RKyY5humEKDrfJ2wJnJUpUnhtAZLYjAm9KXewqEXn5TfnjJzxPqLT4UCBieVFrhKXn
 d4lbIRTTHTGITl2qVD5RPO02WfbhGFEWqR9Irc0X1QBHKPzzJFJqaLKZ5W/bpVHWy6ip
 i0FL27cDbCr9hdb30d57/kKLpyn4/ngmc/zKF8PIuc1G9oMIqIHZ/ak1Vlz4zPAQ1qAR
 9wi9TbntzdGud/KPxhjoorEjUK36flC4uT44PoMbju+PJsFugrR2pbe6MLrZY3+/oL5o
 9v2ADFypmiN4257B7zvWLDTdTMSugLvIvbVpzjkJdkwvtanpIandDJAsMxDqbpdJ8ISN
 mcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617163; x=1756221963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r2QXCMIO4z0sNO0fyaO/mu9Yn7X4g6WvSYCK977bQks=;
 b=May/ys2TP75qXC3wfm94f4/y8ra2Wwmn+NFXPToqgAY9Q7lF+wNW614yzkSOuXaxBs
 Ukw/SmpbO4HFo/Gvep/gTFmbGamCIlr3g/k6SQUJd2JmALhV+a6F+RYBbgtPtNu72DoJ
 PXu956Dqn2wL+Zs+tNMX93y9h0NDEM2pS+B6xNwclomQPfNnpYNikovyTD8/fWNHMNT5
 s7Pr0zMs1TebHzhnzmTMYzKA90NGxVZ/MnoiyVvmQNqeRZ6ZUOxIXJ14ZZKyZNUlG0ku
 W6iBrFbpjfaZsJuGYes3JW1wp2cKjXOGqzLr9OpFphvQx69lVgDe2GbGDmUwTaYOvm+/
 G/iw==
X-Gm-Message-State: AOJu0Yw9de89oIiriHPYf6Lfh9a5bvykGumtT+RCCjc7bN3n8rwrV66c
 WwiU6B5b+nwQaAmMwOjVm3/p068O1ttAWaOBhTVYi+kknX+uubdRQ6scqaBG6tnhUsVkLbbtitb
 F0VAoeVkPM/SdecURcQLNxfo3lFEhXgRuYqpM1qdr7Q==
X-Gm-Gg: ASbGnctjg6q1kt/B+uEiQekkfOhgr0le9DFjpEiQR4N6JPkfB+CMJMSZoDQKVfafZCz
 e3iv4Pd73eYyyF6yQXWNDgYHlkwu9yp29TSTdD8Q9SW/2LPjOO8CHt5Gs2Z1nUYvYBbj7pOJkzs
 kZrFPmyg/YLFS4LabDvQ5bsXmFynlNpt2wTjUapqT+GLIbSyR6A7xRTG6YP/Ejs7563azKGEYVN
 /vf0CIq
X-Google-Smtp-Source: AGHT+IEt3XagP2Oi5KUl6Ld6I0idSNtE/A6jnBOP2p4uhrPCVpm8tIN1WrhebB4VD5E+HZMK5dFWt60K2lmADRjaV9s=
X-Received: by 2002:a05:6902:6005:b0:e90:2ed6:3dd7 with SMTP id
 3f1490d57ef6-e94e61bc94emr3303743276.17.1755617160608; Tue, 19 Aug 2025
 08:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
 <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
In-Reply-To: <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 16:25:48 +0100
X-Gm-Features: Ac12FXwJcpCimU7_fBUTUlYbs3nMnxybwgP6YJH5S2_zc_mChZM0PFguK1x88SU
Message-ID: <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Mon, 18 Aug 2025 at 14:30, Luc Michel <luc.michel@amd.com> wrote:
>
> Hi Peter,
>
> On 13:24 Mon 04 Aug     , Peter Maydell wrote:
> > On Wed, 16 Jul 2025 at 10:55, Luc Michel <luc.michel@amd.com> wrote:
> > >
> > > +static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> > > +                                          qemu_irq target_irq)
> > > +{
> > > +    Object *container = versal_get_child(s, "irq-or-gates");
> > > +    DeviceState *dev;
> > > +    g_autofree char *name;
> > > +    int idx, or_idx;
> > > +
> > > +    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> > > +    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> > > +
> > > +    name = g_strdup_printf("irq[%d]", idx);
> > > +    dev = DEVICE(object_resolve_path_at(container, name));
> > > +
> > > +    if (dev == NULL) {
> > > +        dev = qdev_new(TYPE_OR_IRQ);
> >
> > Here we create a device...
> >
> > > +        object_property_add_child(container, name, OBJECT(dev));
> > > +        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
> > > +        qdev_realize_and_unref(dev, NULL, &error_abort);
> > > +        qdev_connect_gpio_out(dev, 0, target_irq);
> > > +    }
> > > +
> > > +    return qdev_get_gpio_in(dev, or_idx);
> >
> > ...but then we don't save the pointer to it, so the only
> > thing still hanging onto it is the QOM tree.
> >
> > If you want to change "embedded device struct" into
> > "allocate memory to create devices" that's fine, but the
> > SoC should still keep track of everything it's creating,
> > so that (at least in theory) it could clean it up on
> > unrealize.
>
> I'm not sure I fully understand your point:
>
>    - The OR gate device is parented to the "irq-or-gates" container,
>      which is itself parented to the SoC. So finalizing (freeing) the
>      SoC would trigger a cascade of free calls to the children,
>      including those objects right?

Ah, I hadn't noticed that we add the object as a QOM child
of the SoC here.

It does mean you can't ever get back to the OR gate object
except by walking the QOM tree, but I suppose that's OK.

It would be helpful if you could run "make check" under
the clang leak sanitizer with your patches added, to see
if it complains about anything. (Unfortunately it will
definitely complain about at least some pre-existing
leaks, I suspect.)

thanks
-- PMM

