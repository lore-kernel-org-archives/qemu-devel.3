Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C744D44D78
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8hVu-00071i-TF; Wed, 06 Nov 2024 10:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8hVs-0006zd-Ib
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:00:04 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8hVq-0002Lk-LC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:00:04 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so65595281fa.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730905199; x=1731509999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whzH8mu9CmRtX+Vg/bOu/FkD3WtZojBB4IwWf0vmLss=;
 b=glR+1Lnd3FnFQosh4gRDT5Y8N6DS+mM1bYgCpMQg2gcbortxq5qSl2LOi9bUHSJB1i
 SL/h5nVvezXrtU0S8mo0jFrfxETCX/UYrTXVAjacUBTT/6R3P6e96s4MFBlZH/WXhydT
 nwe29FGvqimt2SbjDui+ZRs7189ljJqsjBNoABXk7Dj497iwHB4dXiyapOf4Q34ohug8
 CVNZy9RYPOdoNWDWN+yGbJEngfnRwyOUQc/Ze3yZApXuT+loTdFdPwQ2Tlqe+BCjFM9e
 T0f4J1Cd0e7+PNIohkLmsqdR17eHoTw8UFlpsHn4mNDKg3DXwDHlQkZGSTyNe7kJcWok
 W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730905199; x=1731509999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whzH8mu9CmRtX+Vg/bOu/FkD3WtZojBB4IwWf0vmLss=;
 b=NhbmmAqZThlvIaErvP7vFGcw+ebVk9bxgpVEjpHmQFiYErIvsebXczBQ2EjQR1TaEd
 R/rnXebAtVl6jPhmTywE+Nqeu4Bm6YPOtSujwFQtUmkEz0pPRxR05/nGtBGOCU0keTbq
 jEvOw9pqseo+o+WadIJXqV1cinxsxathwp/iITeTdqTNG0yfwLwCyWOc3hbhFX0T2MxS
 4aEYImre5i1z8l8tcAAT3Iz52LUCo9JVIRHFgsswpPQphsB9GKODHBG57K4NKOpKOlVo
 CyArPIyysWRcLLcNGjP2K6qauHunX3zQeVVPRGO2c1j+S8pozsVJx9YdbPBqd+wU+Zo7
 f4LA==
X-Gm-Message-State: AOJu0YymIPf4mKZoM2Nq6buoGtfLCVIhZ34nPWI3RdXtkszSVhmMWrRk
 wlRFY7XgwTAYCCQwAPuEDLesU3wQRly6WBWS9zwlXnaF7E5fgi71dN0HsqG+PiWLjy1mSaFu9Zp
 1X/wddupfqoMQQL8SvNekW7AOrCOweOsoOy7bGg==
X-Google-Smtp-Source: AGHT+IFzgEbeWf/o3mnBAE73Au/ObPoZGg3btri9iyz7Avoj/T1MsQGEyHiFR/k88nGJwIPU84tf4Z9zCqqGeo44ipg=
X-Received: by 2002:a05:651c:1595:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2fedb7c9bbfmr85285951fa.22.1730905199278; Wed, 06 Nov 2024
 06:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <CAFEAcA8JoYxokZxcf66ivkCAMXuVFvDdrC7tCguNvQ43aAr_kg@mail.gmail.com>
 <CABgObfbzpioAQ7czF1TfPnEApykth1gJm67WZveVY9bo_FYs-A@mail.gmail.com>
In-Reply-To: <CABgObfbzpioAQ7czF1TfPnEApykth1gJm67WZveVY9bo_FYs-A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 14:59:48 +0000
Message-ID: <CAFEAcA8WKODD_ZqQb7t_0KxnSk65Vsx-5-z9WSD2d8HeqD02zg@mail.gmail.com>
Subject: Re: [PULL 00/40] Rust changes for QEMU 9.2 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Wed, 6 Nov 2024 at 13:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Wed, Nov 6, 2024 at 2:10=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Mon, 4 Nov 2024 at 17:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > The following changes since commit 15195de6a93438be99fdf9a90992c42285=
27130d:
> > >
> > >   ci: enable rust in the Fedora system build job (2024-10-30 16:30:56=
 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust
> > >
> > > for you to fetch changes up to d20feaa9a5af597bd20630d041e5dc7808612b=
e1:
> > >
> > >   ci: enable rust in the Debian and Ubuntu system build job (2024-10-=
31 18:39:52 +0100)
> > >
> > > ----------------------------------------------------------------
> > > * rust: cleanups
> > > * rust: integration tests
> > > * rust/pl011: add support for migration
> > > * rust/pl011: add TYPE_PL011_LUMINARY device
> > > * rust: add support for older compilers and bindgen
> > > * rust: enable rust in the Debian, Fedora and Ubuntu system build job
> > >
> > > ----------------------------------------------------------------
> >
> > This probably isn't something worth not merging this for, but I
> > noticed while testing (via vm-build-openbsd) that Meson complains:
> >
> > Compiler for language rust for the host machine not found.
> > Program bindgen skipped: feature rust disabled
> > ../meson.build:111: WARNING: bindgen not found, disabling Rust compilat=
ion.
> > Message: To use Rust you can install a new version with "cargo install
> > bindgen-cli"
> >
> > Rust is still disabled-by-default, so why is meson probing for bindgen?
>
> It's not probing it ("Program bindgen skipped"), but I was a bit too
> happy about printing warnings. This line:
>
>    if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
>
> should simply have had an "if not have_rust", or something like that.
>
> If you want I can resend. I know that Linaro people are in Dublin, so
> whatever is easiest for you.

(I'm not in Dublin, as it happens.)  I don't think this needs
to be fixed in this pullreq; it's fine to send a patch to
fix this cosmetic issue and we'll apply it sometime during freeze.

However, this does seem to be causing the functional-tests to timeout
on the CI job that now enables Rust:

https://gitlab.com/qemu-project/qemu/-/jobs/8284623145
https://gitlab.com/qemu-project/qemu/-/jobs/8283637798

both fail with

01-tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt:
INTERRUPTED
13-tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt: INTERRU=
PTED
15-tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa9:
INTERRUPTED

(which I suspect will turn out to be "all the functional tests that
use a pl011").

Could you have a look, please?

thanks
-- PMM

