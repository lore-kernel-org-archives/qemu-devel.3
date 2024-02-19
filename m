Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7740C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6hL-0006Rm-SO; Mon, 19 Feb 2024 11:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc6hK-0006EU-8P
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:54 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc6hH-0003Rf-W5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:53 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51181d8f52fso5867043e87.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360850; x=1708965650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUdQ7xp7QgHpCDmJh85ReBiVVfoP254Zxjtyb8OjtGA=;
 b=BhtbTdoVI1+QYZjUGcTCHhnUaGf6usweS53AQ5HtUunJKQjqYVAFITDWeJtb1T/3ql
 lbDBFQb1ETknDJ0GtyPZiSeRzTi3BN7rlI03U8ID3g1MQmmObWktDhRCtmJkYjM5DaW0
 dtNQ9EqHgMkvcMCLJ/00I8dd6bmZqllbwNlN08z+CxwtozOp1QwXZck6F2+YerLfCjuB
 JgGpBZzF9oqZz8ZHEWjf0BDzM69NHYIiySUGXYA4DnX4jVzvTMp4rIUDHF/A1mWwcsQk
 4BI4zISQZ52WDmOhPzoOCz71rbkUbvXwAHB4Tj4YVAZ5vxtJNMIVa2MH8nykoJ3N4HVy
 AH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360850; x=1708965650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUdQ7xp7QgHpCDmJh85ReBiVVfoP254Zxjtyb8OjtGA=;
 b=OiGhjtPNJxk33iSZdJyQ2jkx6QCllk4r3luXDD7Rs7PyzfOst7cp/xcBWaJ/XXmeo/
 PiqZQt6DBK+F69GJszeZuqctX2X3/EisVmxtNXGvV2bzysw6qF5Gwk929IN1Vi2Qj968
 J4q1D6keRIYpNEEBUDKLz0dU0r7WYNkzJdR2Vrxld95BMiFjjD6LI+NAxZkZ+fYcDJTs
 qLp4n1yeEJxOih9EidGNhamuPMx2TlgWZob+/c9Af7QiPr42jt38cUI1zE9uPHK5obow
 ZWMV5LocZXLePjmKqHckdx0ddHnusDGAizA/2XxRjPz7aTGSpxlJS9g5V6oNH3PF8Uwu
 NwIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU52fJYVzHJvQ1LksjldU7jQjG4GGtfqXDFjm2O9QJourJT9KGmh86a1JjU3MAFCN5rZ7VC77BEDIjWspi9q1JtCkovRio=
X-Gm-Message-State: AOJu0Yye9u/182CweBlH50lTxy46O/IgERUsvcI/k7ukUc+uOtS3UuJ9
 7fZqOuMxGbPMT8dHD8awtSF5PIIUcFGD3imRi9PQ0mDkzBo0tvLXP0Uatu1Ix9TGXNWfRpnBSPx
 l5GVRr/BDtZfpHDgswQPiFnZUw5unr7BNrcMLI2/zVva95J5D
X-Google-Smtp-Source: AGHT+IGkNaYSRXydzl/uTppbLpkghrUVV/RnR1pVsOY2p2VO5+bf0Mjw4HDM6am9tnXBSflB0zb66sCnuA+I0OKufYU=
X-Received: by 2002:a05:6512:34c9:b0:512:be5a:e33a with SMTP id
 w9-20020a05651234c900b00512be5ae33amr805984lfr.48.1708360850062; Mon, 19 Feb
 2024 08:40:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_BB5-eieVGuqqXn3aS-Vmc7OcTFmv5e=i5HgNw3Kp2FQ@mail.gmail.com>
 <ZdN5cbaqnJMTK5ts@redhat.com>
 <0a084faf-3685-4134-aecc-5edf13111d89@redhat.com>
In-Reply-To: <0a084faf-3685-4134-aecc-5edf13111d89@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 16:40:38 +0000
Message-ID: <CAFEAcA9zkCZVHR21mfSiz4PQG_A2n7GEG9X4SBq4B_ARPkNW2g@mail.gmail.com>
Subject: Re: dropping 32-bit Windows host support
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> On 19/02/2024 16.53, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Feb 19, 2024 at 03:37:31PM +0000, Peter Maydell wrote:
> >> Our msys2 32-bit Windows host CI job has been failing recently
> >> because upstream MSYS2 are starting to phase out 32-bit windows
> >> host support and are steadily removing i686 versions of packages.
> >> The latest is dtc:
> >> https://gitlab.com/qemu-project/qemu/-/issues/2177
> >>
> >> The writing is clearly on the wall for their 32-bit support, judging
> >> from the "2023-12-13 - Starting to drop some 32-bit Packages" news
> >> item at https://www.msys2.org/news/ and associated discussion at
> >> https://github.com/msys2/MINGW-packages/discussions/19326 .
> >>
> >> QEMU on a 32-bit host is not likely to be a great experience, and I
> >> suspect we don't have many users using 32-bit Windows who couldn't
> >> use the 64-bit version instead. Our Download page points users at
> >> MSYS2's packages, and they have already dropped the 32-bit QEMU
> >> package build. Stefan Weil's binaries page, which is the other thing
> >> we link to from Download, has no 32-bit version newer than 7.2.0.
> >> So anybody using 32-bit Windows QEMU must be building it themselves.
> >> Plus, we've already deprecated system emulation on 32-bit x86 hosts,
> >> so the only remaining "supported" config is with the NVMM or WHPX
> >> accelerators.
> >
> > The other data point is that Win11 is 64-bit only, and IIUC,
> > Win10 was 64-bit only for new OEM installs too, only upgrades
> > or end user installs could choose 32-bit.
>
> Yes, and considering that there will likely be a Windows 12 at one point =
in
> time, we'll drop support for Win10 and thus 32-bit support anyway.
>
> >> I suggest that we should:
> >>
> >>   * remove the msys2-32bit CI job entirely (we will still have at leas=
t
> >>     compile-time coverage via the cross-win32-system job)
> >>   * document that the 32-bit Windows support is deprecated in
> >>     docs/about/build-platforms.rst and deprecated.rst
> >>   * update our Download page to remove mention of 32-bit Windows
> >>
> >> Any objections?
> >
> > I think that's sane.
>
> Sounds good to me, too.
>
> Note that we already have an entry for "System emulation on 32-bit x86
> hosts" in the deprecation list ... so IMHO we could also justify to drop =
the
> 32-bit Windows support immediately, since that's a subset of that entry.

Mmm. I had initially misread that as only applying to TCG,
but it's more general than that. So I think I agree that we
should go ahead and mark 32-bit Windows support as definitively
dropped.

I'll put together some patches at some point.

-- PMM

