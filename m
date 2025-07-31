Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF480C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 17:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhXXU-0004pr-Ba; Thu, 31 Jul 2025 13:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhW4f-0007hK-0b
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 12:24:19 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhW4c-0008BR-EG
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 12:24:08 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e8e0c6f1707so937894276.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753979044; x=1754583844; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zlgK9DVZSGqNF9y844BLb+txWYcYeVtEy/EJdewCCcw=;
 b=EUz9CmiXlVoGwnLO9ZIQXSmrgDV6mpkbXp+jTNDHRk7kWo+JyjSPrkKReCs51ONXWQ
 IYmiclbeyLCHbUs3ZRgvKaYeIQRzWrFXOLePsDxiDO3zGHZ5h5bJLSikliDAk5GwlIwa
 MtuT9UCBKsmM82oGqD4wdannIQq8WkaMIvauKZUEYHhyoAsZ1H12XLmnHeO0UKYBuT3r
 dAhv/XsHV3KPRYPANThVmI0ooynXnTvQorVkLAqpSbk6NDs1IpqdkAJlRE1KQ/yTj0xT
 t6yYcFq+BDNFT1WwpIn19Tq2sda/eU2UOcxUeOUWbm7VyJDTouuKkmWx+0FSYoT7d1ht
 WDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753979044; x=1754583844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlgK9DVZSGqNF9y844BLb+txWYcYeVtEy/EJdewCCcw=;
 b=DGOyMBIB1qreANrP5apRkRdanBPxV48zuEP5CDENPJfOjBHPgqWNwBuwcCjy3S7gt+
 WPkpIBKVT1ONfugrYYVBVCcAlJNhXCZoL0KjnlR0nHmdBtchBfPeYdbOHRn+yot7oCSh
 d/eyPF4Wx0aF7gdBhG1y/e2Jqu35C8aoh0g35zYwniqzxQIQ1mWF4GCmCKicp+bwQknY
 yLESzujNks8quaSZnCsM8HgtT+PPJkd1pb4qgZvIKwao6TMa9SKQxFkEO8kxFJa28Azx
 p1D/C7oTmmdqpkX2YJrKM0QFqK21I2k+rDILQc/I4qpPQcAovCkYdR9olsV5XvEabyHX
 Y/wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJYUXuEn9HFTZ1MnpbrHFkM/uJ+0kUDlPnTI8eeulWe+fLCpLK/sbWqyMYGWpYusNGw8iCYoky2AH@nongnu.org
X-Gm-Message-State: AOJu0YyeBadajByqqhiJ2LDEsHYVhbCX/UM9q1Cjut7oN+0I/G2LWElk
 ERiDg5P5L5RMmYIQXRJAPdia5VuLHNmxMCXygUkWFGe25Xvs6iAjHt3Ee2IsEZ6Px+AoI0+n7XO
 FVOf1j66BD/A6opPgEWahnhtwuB3BEzOTpgynoqV0Vw==
X-Gm-Gg: ASbGncus0nRNk5gCnY+DsaLOHtRztQRJ0YFQJ9DnTEX+rzn6XN09jE/ZRgs3T5Yjxop
 OVxszDoDulXpLprFTh5gPUx6UduZvQWmIJAuFl2Pg5qw74wvJ2boeQfGEydFx2vpvymiRC1Dx2b
 5NYdndI61fc5EscDl9k7pxhgpISerZt0jG246K5RMdy5P9R8K1Cf8YMW+Fal/9/IBAafKzKMG4u
 KteV0H72hewJ1e9Qbw=
X-Google-Smtp-Source: AGHT+IF9Ig2f3gBFF7YhIUdcOpWwduPZ46ZY086trDa9j7gScDQ/g5aOvGa9F+TfTt56Ok4UHDFgTXiA0JXj4/yJpic=
X-Received: by 2002:a05:6902:188d:b0:e8f:dd0d:5da6 with SMTP id
 3f1490d57ef6-e8fdd0d60e4mr1805404276.39.1753979044136; Thu, 31 Jul 2025
 09:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
In-Reply-To: <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 17:23:51 +0100
X-Gm-Features: Ac12FXycJJLK_0eEyf0DuFAkWfmicvl-58NTuyiUIaRlduIEt1eR-70rfzWXD6I
Message-ID: <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Mon, 28 Jul 2025 at 20:34, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> This old commit (7702e47c2) was the origin of having interrupt related
> code in a generic folder, but I don't really understand the rationale
> behind it to be honest. It seems to be an exception regarding all the
> rest of the codebase, thus the idea to bring back things where they belong.

Most devices are both (a) architecture specific and (b) a particular
kind of device (UART, ethernet controller, interrupt controller, etc).
The nature of a filesystem hierarchy is that we can't file them
in both ways at once. We picked "sort them by kind", which is why
all the interrupt controllers live in hw/intc, all the UARTS in
hw/char, ethernet controllers in hw/net, and so on. In this
breakdown of the world, hw/$ARCH is supposed to be for board models
and SoC models only.

The GICv3 and the NVIC are odd, because they are very closely
coupled to the CPU. (A few other interrupt controllers are also
like this, but many are not: for instance the GICv2 is a distinct
bit of hardware that communicates with the CPU over the IRQ and
FIQ lines only.)

One of my post-implementation regrets about GICv3 is that we
didn't really get the split between the GICv3 proper and its
CPU interface right. In hardware the GICv3 is an external device
and the CPU interface is part of the CPU, with a defined
protocol for talking between them. In QEMU we put all the
implementation of this in hw/intc/, and the code in arm_gicv3_cpuif.c
does some ad-hoc installing of hooks into the CPU.

For the GICv5 I'm trying to structure this in a cleaner way that
is closer to the hardware structure, so the CPU interface
will be code in target/arm/, with a clearly defined set of
functions that it calls to talk to the rest of the GIC that
lives in hw/intc/. (This would be too much upheaval to
retrofit to GICv3 though, I think.)

In a green-field design of M-profile we might have made
the NVIC be code in target/arm, and instead of a separate
device have the CPU object itself do this code. But at the
time it was written we didn't have the same QOM device
class setup we did at the time, and IIRC CPU objects
weren't a subclass of device.

> As well, I would prefer having a clean build system more than a clear
> filesystem structure, considering it's quite easy to jump into any
> definition automatically with your work editor nowadays, vs understand a
> meson.build file full of tricks and implicit dependencies where no tool
> can help you.

On the other hand, I prefer to have the source files in
a clear structure, because then you know where to find
things, and command line tools like grep etc are easier
to use. (I don't use editor jump-to-definition: I've never
felt the need to try to set it up.) Build system files on the
other hand are things that most people don't need to look at
or do more than very simple "add another file in the same pattern
as the existing ones", so it's not too bad if they accumulate
a little complexity.

Looking at hw/intc, there is a lot of use of specific_ss
here, so I suspect that these Arm interrupt controllers are
not going to be the only ones that are using target-dependent
code (there are 25 files which use CPUState, for instance).
So I think it's worth figuring out how to build these in
the right way where they are rather than saying that
various interrupt controller models should move to
a place where they don't logically belong because that happens
to be a folder where we have the build machinery for it.

thanks
-- PMM

