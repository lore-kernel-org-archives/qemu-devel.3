Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13C8D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAsq-0008Ha-Am; Mon, 01 Dec 2025 15:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAso-0008HK-O8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:52:30 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAsm-0006He-Tq
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:52:30 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-640f88b873bso3963287d50.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764622348; x=1765227148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/n/+NprJbJm2VplrJkY2PhyEJjO5AcZj4CxzcMha8gg=;
 b=i/0PsYkGvJlZg0P2fMLjRox1rLwpgPWsbGQXk0RhF8EMsbq4jclKiQ8lx/RHlC3xLe
 YecLwpvOip9QaLp800Jq2i/1Z9f/kDhFg1kNQCUvJxp3aUtSpSifdMvgN7o3DIzIdros
 kX3xPUFZe2Pgq3ydj9407OEWdVpGEKzcxMxaQw5axIlSuTEO1eocsNJdy5FXNHeB2M/8
 nwrKY3mc2ETdvCk1UKt1jnBBpNC1fIxNI9E/mBOdJfRqh4BYi0kE7sJJM6IbsFea4iAS
 rfWpA/DuZ5tb1ZTz4RTbnYPkv5cUTB1YAWxj07m2KhTWf7Az4m1tNAgDaQUCSB1IbHD4
 bqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764622348; x=1765227148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/n/+NprJbJm2VplrJkY2PhyEJjO5AcZj4CxzcMha8gg=;
 b=phK3tnBu5vgFX0TyIxizx30q2lval1aXMMGEvlnfq56osOe3NRySEp3/m4ZGkHvuwa
 R15/2UtbGjvs7YdLL2964v9s8geWFiJZvctcQfwF6gGdk3mSYKmVeeNKJEfPF8WuFZ4C
 sKbYfzPb+gKMHvGIVuAxgFcK9zLzT441rw71z+2p1chm2CHm/sQmS9Fteg2iH6iV4+uu
 pY7FmbfHxuBPGepdQitkkeNArN65j95FSPxZ6VuF69mZwVcfjFH/O1Pq1VwUDkgCTdaM
 e6BZqz3il1i8o+CoR2lAhE7e2cy21+3HvAV0sF9zf8j0yRmb1XopbvA44pd5zyn3EkVS
 6njw==
X-Gm-Message-State: AOJu0YxBkTKGK7CLtngYXO5ifjocPUWUesHcHpZWVPLNw7JQWVfq+rE7
 rGPA3T8EGYmRfE4ckq25y4R4c/GaZlDcR082guE+Isaaii/CYnJQq5IcvtxdRwaTr9/3UGw+NN1
 wRO0JLnJ2puhxBrUYxGaxKVefDGkAgJp5/j8mRaQWVQ==
X-Gm-Gg: ASbGnctAtxL1MCue8loC7o83lQsWj63H15glYIVoXFxkrfQ3aqlLUMvncxz7uCjxyd3
 zEAALde+/fuqzgCJJMc3+zw/sG91vWBu37aOWfAM3kjtx+2PN23Ba+sxtpyZuEz7H601Nd9XTRw
 wLTNh6Fe8mCPlb0UQ23RogwyDJXUv2TXP2XNd78Ski1ozWyNaqKHZwK1AMRNGX3+HQd/2RzsXCS
 BvaKL2kq2eg8q7HSHLYRt5XzENBaIKtQYIOFgd32MjVhVGXGOmyfJXolpPkKIjg+zKgxmes
X-Google-Smtp-Source: AGHT+IG0nwmhKVxxM+YyhshY/hNvDStx+3C1UnZxYwWPgonA6FRBGrnzghr890gqKgaL+XPyAI17HsjqNDEwh4wouzM=
X-Received: by 2002:a05:690e:d08:b0:641:e826:bb71 with SMTP id
 956f58d0204a3-643029b20e8mr29056455d50.0.1764622347646; Mon, 01 Dec 2025
 12:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-3-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-3-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:52:16 +0000
X-Gm-Features: AWmQ_bnOdvwPu7Ad3w7x7NCwH_62QWh_D80aoNdTnCbtLwG9YsTryF05bEc6Vd4
Message-ID: <CAFEAcA8WHgKtPPVQKNSRV2R5xVPCZ3vNxQgy9rcVu=ECrxNE2Q@mail.gmail.com>
Subject: Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented CCM(Clock Control
 Module) and Analog IP
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> Implemented Analog device model
> Implemented CCM device model
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Can I ask you to split this one up a bit more, please? Where
we add a new device, this should be two patches:
 (1) implement the new device
 (2) add the device to the relevant SoC or board

In this case we have two distinct devices, so unless there's
some reason I missed they should be separate patches, which
would make 4 in total.

But: why do we need a new imx8mm_ccm device ? I did a diff
against our existing imx8mp_ccm source files, and unless
I missed something, they're exactly identical apart from
changing function names etc from 'mp' to 'mm'. Can we just
use the existing device we have ?

The analog devices also look very similar. In this case there
is a tiny difference in the ANALOG_ARM_PLL_FDIV_CTL0 value.
But unless we expect these devices to diverge a lot in
functionality we haven't yet implemented, this kind of
"almost the same device with minor tweaks" is better done
by some other method than "copy and paste the source for the
entire device". A couple of options:

 * you can have an abstract base class, which the different
   variants inherit from, with the shared functionality in
   the base class. hw/char/stm32l4x5_usart.c is an example.

 * you can have one device, with some properties that the
   SoC sets to configure it. hw/misc/mps2-scc.c is an
   example of this, with uint32 properties for some config
   and ID register reset values.

 * you can have one device, with a single property for
   "revision of this h/w" which then drives several different
   unrelated behaviour differences. hw/misc/iotkit-sectl.c
   does this.

Based on the differences I've seen here (i.e. only one
register value is different), I would suggest the "uint32
properties for register reset values that differ" approach.
But you might think one of the other options is more
suitable based on better knowledge of the actual hardware
than I have.

thanks
-- PMM

