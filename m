Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7079DCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNtu-000196-0G; Tue, 02 Dec 2025 05:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNtk-00014I-44
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:46:23 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNti-0004Xj-IW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:46:19 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7866aca9ff4so53396277b3.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764672377; x=1765277177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALDeg+YN5j+kVfbUwbTX/tg0d0egMOJBvLaiijxYEgA=;
 b=e6ti1XKeyioEPU/Hx3dUmJtQ/1KQmPYZm7uZLf++pxGexiXKXG9/G6aZKiXv4tatGj
 blDqNPOvdFOguqGbvm3UxHsIrJcLIG9ClJrOtvc/9RX7quayhzpVu4opZXsoP9G0pUhA
 aY/3uMyAeGky/wbg+8QtMje2/Zqm0jMfNwV4mXpjJt2iJxWJ88J8U+BXqC7cTNEGcGlk
 ABYOnOg/jYInkosVdcmmXHVP/Ft7/Hye2fTx+7J7ivf0C30FHNAInzsSv87pQLUMwIK3
 0092F6NPHPHLBAm+f8O69lBzLc66YDhwERZE6F9XlkhExawQn77Jau66cqAKfeqlWovO
 OfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764672377; x=1765277177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ALDeg+YN5j+kVfbUwbTX/tg0d0egMOJBvLaiijxYEgA=;
 b=xA0jILKaGyV3eB10dGz2SXewjp34WSdCUTeIz7BBiTX67nieNdgn3GvjIb0n8XLUiu
 VWoKMXyrhkKW0h7hTI/1/LqFzCTUIOoweoCZ8AXn99VZstgBL7Ux1S0ztqRzUIZgX2qC
 B/cselucVtDl56lKegvEQ18Jzo6GSsvS4R68qktdQp9zRv3Hims1FVzkdI/dfcG5PyC6
 fgMNFtLhcTwLvzF6AvrkC5Wz3ReKhKo4cinIylDmfUt99QRb1oaMNsLzf1alPw45hhSp
 LUJ0o1YTupBXEsNvNWLfNUNSRv+aesNE0J4iHixMxVNW7GKVrV1rJgXALvKLJBYUqoeo
 4KmQ==
X-Gm-Message-State: AOJu0YxlBuuXQdezIBY/iurnKmuVDvzu3xUwPgMjqu53w5i2BtOom0OT
 3VFwotD374jOJ/qXpL4CdMxmZG8mp4Uxt8leluR1xPSEH5KJPkug9lynsLE8bAQxnNZcK4CxRKx
 MYDWeqAq0E3WnvrOrTfRUWl2k3tPfrE8adfE7+xZmcQ==
X-Gm-Gg: ASbGncuVW0D3sM9tzMNC/cCNdQcIn5wSMlwGQZNNeFHMFB3p4I09sIzwBmtFzKJjPiu
 J7qF/l7xgS1nNDDbVGfKLU1UepdV8GWCVyH3k65lPgiH+SjJG3XDaPGK0juTKYKl/12/3iVJpIP
 UejQoBE49GirSv4At3jdS68wO4X4CeitDaUTPt7yRorX3b4YEapHXt8XPKwBW+lpOC8AdfJsfjp
 4O3ovz0SyBsilrZ7jYe6UYbms6ChvOmOASHnd1XmUvirZvfSsTV2tkR8rg5YnURelTSk9sJ
X-Google-Smtp-Source: AGHT+IHR5KOHjRVapgCH8oA5KKiqgfB8LgEb/x3c+HnWZ0/N/Z+nIryUio7PhtCi1y2iy28DzmT94LjSIqp+819KACI=
X-Received: by 2002:a05:690c:4c13:b0:787:ce99:eaa0 with SMTP id
 00721157ae682-78a8b580502mr346749067b3.70.1764672377212; Tue, 02 Dec 2025
 02:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
 <CAFEAcA8pb6cJ0h+L=fsE28HYpgkC2BWrT=kcwgVxCazJMPMy+A@mail.gmail.com>
 <AM9PR04MB848728E3D09323B636E7D54387D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB848728E3D09323B636E7D54387D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 10:46:05 +0000
X-Gm-Features: AWmQ_bm2nLvSh-95tujvkYWrDMgd34TfCOLBUCwR9bsP-MzDhH2iFLCHpERqLUQ
Message-ID: <CAFEAcA-1MJ5oDVihy1Uo-bv5FUtCF_xPaS9oSoDtrnGsWe-2wg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 2 Dec 2025 at 10:33, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: 02 December 2025 15:30
> > To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
> > Subject: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM
> > EVK(Evaluation Kit) board
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > wrote:
> > >
> > > Implemented CPUs, RAM, UARTs and Interrupt Controller Other
> > > peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE Complete
> > > memory map of the SoC is provided.
> > >
> > > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > > ---
> > >  docs/system/arm/imx8mm-evk.rst |  68 ++++++
> > >  docs/system/target-arm.rst     |   1 +
> > >  hw/arm/Kconfig                 |  12 ++
> > >  hw/arm/fsl-imx8mm.c            | 363 +++++++++++++++++++++++++++++++=
++
> > >  hw/arm/imx8mm-evk.c            | 109 ++++++++++
> > >  hw/arm/meson.build             |   2 +
> > >  include/hw/arm/fsl-imx8mm.h    | 156 ++++++++++++++
> >
> > Could you also add a section to MAINTAINERS for this new board, please?
>
> I was going through this https://www.qemu.org/docs/master/devel/maintaine=
rs.html. It implies that the contributors are generally people who have bee=
n actively contributing to the community for a while. Since this is my firs=
t contribution to the community, whose name will go up as a Maintainer ?

Mostly what we want here is that there's a section in the
MAINTAINERS file so the new source files for this board
get listed. It's more about ensuring the right people
get cc'd for reviewing future patches than anything else:
for Arm boards I do the "collect the patches up and send
pull requests" part. For this you can list yourself with
either an M: or R: tag, as you prefer.  Include the
"L: qemu-arm@nongnu.org" line also, and some S: tag.

thanks
-- PMM

