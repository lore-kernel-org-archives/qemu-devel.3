Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE76C02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgZI-000144-QM; Wed, 05 Feb 2025 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfgZH-00013i-7G
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:39:55 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfgZF-0005TM-FE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:39:54 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so861756276.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738766392; x=1739371192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NY4DsnPGBuvuLgxrqN9iTbzl7NxQMO536XcOPp7VMAs=;
 b=IRk5SPUL1C3l8Em1THip/Mt8cF0MxKqugwYeTXJ0eFxkP8k8fW3tOhGgEXHrveKYQL
 h5ZJliOJ4/TPzEViDMe3V5CpbW3v0XOIF792SLpgw6lvFJK6fyYQ9hZhTXrXi7lArStc
 jQ/o4HOa/o0YPSG7/wk8W2xguxEpsnVXmphMc/VLaDNCjaW7Izi8JgeALs/FRPDyaAmZ
 IhqxjcyIFvCCBAWU4h96Un+A7aAizDaGcZLxoY916meMKgPD3sCvB/vjfnIIWkmIRRY9
 GzfYdS/vTKpn/pAn4UjwlXfShT8gyFo1wbT2BmtYfdNbJ8WXb+EOBTPY+Tc9qiebMALD
 UdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738766392; x=1739371192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NY4DsnPGBuvuLgxrqN9iTbzl7NxQMO536XcOPp7VMAs=;
 b=gKzO7MGz6LoOYd3eqlXJPSTG2z0C8X2qcaz6/wdLg980z3ygYGgnk4MpdeHmJP0vFs
 m8JFepd8VGtvWcpL34Wi9z2TwyeJLBHtlQjOFXcry3fVge+mmOCUXK4BTLnxAG31BGuL
 rDFVGywriBHx3ZNfmtQHDOLAflIcyMGuTbiSxMdb9sRABSYv/3rGt/c6It8k1Xl/uuxU
 tLTV5X3cSgC8jqe20ibCFU5GHeMWqghZggQVOskpKxV4ACjEIfAq0V04hyOvy3Rx1De+
 b25xFkGLiYNgDJPMzoGKBSUOB4ZEqsMYzUqNp0zA28B7I2QH2ioVX23arI5HioTNhfZL
 O+gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/oCvGuwGsSiMDy54tI1Z1en16uhCDOWDMpb7oFFTP/gIaiKvXyAq9wkQ0O1OBSYPaIzSbG9L2g648@nongnu.org
X-Gm-Message-State: AOJu0YyPOGO+1O2uiCeZ1xMrgDtqeBdgj91lMwemulcpsDb6PS4B3HZg
 YxI99pVwYNJXE64bhvbmsNtbOYf3V7Oiqrnlmi+feCuZ6WpVxQbsbZ9+yRdRN8yuElUjAWvLqO9
 I35w+4QsDCqXbwLwM9/dB+PdJ5tPUGWdjNyEfMQ==
X-Gm-Gg: ASbGnctv+yyBJV4vukek3vedhDzO4B6f5DZ2mQH9WJCMxsxp9FdC6KSFGKSuk7mMShE
 Au8yEmo4zsNlGzO1tY1kP3qkQe2NXYMDhV/IE1x1/iW7RjQrci9544o5OQH9FQ6qlO4TZXvTysA
 ==
X-Google-Smtp-Source: AGHT+IHfe65u0iaenSEqIDexUjch9CShW+vA4OkZYJN7ly2iuH3Ms2IfP1iFLdC7AjSxN0hubBQn91Yh6Z/TpIzGlzA=
X-Received: by 2002:a05:6902:2210:b0:e57:3f93:c756 with SMTP id
 3f1490d57ef6-e5b136173b8mr6035707276.21.1738766391925; Wed, 05 Feb 2025
 06:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-6-peter.maydell@linaro.org>
 <874j18a70w.fsf@draig.linaro.org>
In-Reply-To: <874j18a70w.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Feb 2025 14:39:40 +0000
X-Gm-Features: AWEUYZkgu2kQAOap1W_NFZeq1zdW5e5cXDz54VTmJowLHzoefzFNHj0hjBYW2oQ
Message-ID: <CAFEAcA_rFHm=HwS7-vsbywkvr5LcV1_7a4AOdy2r_JCFysaQgA@mail.gmail.com>
Subject: Re: [PATCH 05/14] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be
 Monitor traps
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Wed, 5 Feb 2025 at 12:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > In system register access pseudocode the common pattern for
> > AArch32 registers with access traps to EL3 is:
> >
> > at EL1 and EL2:
> >   if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR =3D=3D 1) the=
n
> >      AArch64.AArch32SystemAccessTrap(EL3, 0x03);
> >   elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR =3D=3D 1) then
> >      AArch32.TakeMonitorTrapException();
> > at EL3:
> >   if (PSTATE.M !=3D M32_Monitor) && (SCR.TERR =3D=3D 1) then
> >      AArch32.TakeMonitorTrapException();
>
> I was confused a little by my copy which was:
>
>     elsif HaveEL(EL3) && !ELUsingAArch32(EL3) && SCR_EL3.TERR =3D=3D '1' =
then
>         if EL3SDDUndef() then
>             UNDEFINED;
>         else
>             AArch64.AArch32SystemAccessTrap(EL3, 0x03);
>
> But I think EL3SDDUndef() is always false for us as we don't have an
> external debug interface.

Yes, that's correct; I simplified the pattern a bit above
to remove some of the irrelevant detail. (EL3SDDUndef is also
hiding an IMPDEF choice about what order to prioritize the traps
in if you do implement external debug.)

-- PMM

