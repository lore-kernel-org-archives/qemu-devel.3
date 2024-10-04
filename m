Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DACFA763
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 10:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swffY-0007PZ-9X; Fri, 04 Oct 2024 06:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swffX-0007Om-3g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 06:36:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swffV-0008H3-Cf
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 06:36:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso2237299a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728038174; x=1728642974; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9OlicifHtCtS77O14+qa+y/eM2RaCg2lpgZjfc3j5w=;
 b=Op4rFDWc9ffEV2KNmEaRfu0n9Sq+G61ISttP+Hm/sgupCnYdLIHeY/qv+gf9G4DPE0
 iwooVcl6KgkS40nGJVt5F/TmYJq2BpmHBEzydFK8RbiVse1AlndF/DhEln4F9sLHa/Qt
 FP9mlX4G2fORNLNeRxVOihM0ISdqzsVFsVZ0KTjhZ/AUxROeBoAL0V0mkqiQf9ReD+AS
 rsSThTo6lrShGgrK+0WyCK57TBTZpVur+GTxNYRYPWC+64zj7JNhEbaGXrP/70CdUpg1
 fnu3u4DDsSMExCZFEMLCubxmTFA9HNSfBgSfhSEH/YImx7dVAFVWjHYo9nQp6SVZRxW3
 Nkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728038174; x=1728642974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9OlicifHtCtS77O14+qa+y/eM2RaCg2lpgZjfc3j5w=;
 b=w3mz5TbaJXkVq1E2/CP7orH2Rm+XXvB25QmqIsdlwmZbujFlB47N+zbJUdvD1ZS4uN
 qhFo37kyMJEBRyp5GgzW4clLnH9/7xNR37C3sGIbudni94+6EGchhTqKDjvwf5MHm5WX
 fL/otZHCF2bf4aMk4l10nNaUne7uofwx5ePMYLo66NeCd2kSWg311omkebKoWBscTp9D
 hEchGDFWen+TL3mCMtkjM5ENPomaBD8r6qpEDdhmK9uEZod+ckxvbm1vahMMCfvwEj2B
 9ZGhOggsNF9kiv8v5n5AZxI8VuqPzvIIRczmp9W99YxVEMCr/TGj4zEgKJj0rw9ctPTe
 8JiA==
X-Gm-Message-State: AOJu0YyOP4BrAhuChycOY/2zvKU2DmFGWrXWeSfzbvnGzxg0x23NFF0x
 +gko2SJB+Yx32ztolCszBki5G30ZQ4w2tIfzsR3EjPHDdVk57vtjUZ7lNd3mUyYx3TEwDPJEnuP
 Xdg2lSL18U6JbCziKWkcbnBfvBebL2ZHbTj36MQ==
X-Google-Smtp-Source: AGHT+IFEjbQaWuCjcKs/2KwarwPrZdoRWb13CGnS2mZ64GJMUUoDKl85FmqyvSkUUOMW7EHBWEZTeMytYCPaH6HMwAA=
X-Received: by 2002:a05:6402:440a:b0:5c8:8db1:1d55 with SMTP id
 4fb4d7f45d1cf-5c8d2e3a6b2mr1657000a12.10.1728038174213; Fri, 04 Oct 2024
 03:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240923035632.81304-1-sebastian.huber@embedded-brains.de>
 <20240923035632.81304-2-sebastian.huber@embedded-brains.de>
 <CAFEAcA8Wf-PzAC-YGdma3YVETyuatLJHmvjrrb_kG2NjDSGs+Q@mail.gmail.com>
 <1809049101.17000.1728005051804.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <1809049101.17000.1728005051804.JavaMail.zimbra@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 11:36:01 +0100
Message-ID: <CAFEAcA_zcdNaR5NTnTLmCZ5EgzBb=mFqqpLQKergk7z80kaEZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/boot: Use hooks if PSCI is disabled
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 4 Oct 2024 at 02:24, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> ----- Am 30. Sep 2024 um 17:16 schrieb Peter Maydell peter.maydell@linaro=
.org:
>
> > On Mon, 23 Sept 2024 at 04:57, Sebastian Huber
> > <sebastian.huber@embedded-brains.de> wrote:
> >>
> >> In arm_load_kernel(), use the secondary boot hooks provided by the
> >> platform if PSCI is disabled also while booting a non-Linux kernel.
> >> While booting Linux with PSCI disabled, provide default hooks if neede=
d.
> >>
> >> In do_cpu_reset(), use the secondary CPU reset hook provided by the
> >> platform for resetting a non-Linux kernel.
> >>
> >> This change allows a more accurate simulation of the platform reset
> >> behaviour.
> >
> > So, the difficulty with this is that it's effectively
> > introducing an extra way of booting. At the moment we
> > have two boot approaches for Arm guests:
> >
> > (1) Booting Linux -- the boot.c code simulates what the BIOS,
> > boot rom etc, does, both to set up the 1st CPU for the kernel
> > boot entry, and to set up the secondaries in whatever way
> > the bootrom does that the kernel expects to release them from.
> >
> > (2) Booting bare-metal -- boot.c assumes the guest code is going
> > to do whatever the BIOS/bootrom does, so you get what you get
> > for real-hardware CPU reset. (Either the secondaries start
> > in power-off state and the primary will release them via some
> > kind of power controller device, or else all the CPUs start at
> > once at the reset vector and the bootrom is going to sort the
> > secondaries out and put them in a pen.)
> >
> > What you want is a third thing:
> >
> > (3) Booting not-a-kernel but not 100% bare-metal: emulate what
> > the bootrom does for primary and secondary CPUs but don't
> > boot the guest binary as if it was a Linux kernel.
> >
> > The problem with adding that is that we don't have any
> > way to distinguish whether the user wanted that or our
> > existing type (2), because both are "user gave us a binary
> > that isn't a Linux kernel". (It also has a bit of a
> > "continuously expanding job" problem because the bootrom
> > could do arbitrarily complicated things, like boot directly
> > from SD cards, which we have historically not wanted to
> > emulate within QEMU itself.)
> >
> > There are other platforms where the real hardware's bootrom
> > has a particular "this is what a bare-metal-under-the-bootrom
> > startup looks like" definition, notably the raspberry pi
> > boards. There too we don't currently implement that, and
> > instead effectively tell users "pick one of the two boot
> > paradigms we do support"...
>
> Ok, I understand your concerns. What I would like to do is running unmodi=
fied executables on Qemu so that I can test exactly the same program which =
would run on the real hardware. To properly initialize an SMP system, you h=
ave to do certain things in a proper order. Currently, when I start the Zyn=
q machine it immediately executes the ELF entry on both cores. This conflic=
ts with the normal system start sequence which assumes that initially the s=
econd core waits in an idle loop. For example, the second core is normally =
released after the GIC distributor is initialized.
>
> Changing all the existing machines to use this third way is probably a ba=
d idea, but would it be possible to make it configurable though the platfor=
m info or a command line option?

Image loading is already weird and inconsistent across
architectures and across machines. I'm not really
enthusiastic about adding an extra thing that only
applies to one machine type.

You might be able to get the effect you want by writing a
guest binary that does the things the boot-rom does before
starting the main executable, and telling QEMU to load
both that "bootrom/bios" ELF file and the main ELF file.

thanks
-- PMM

