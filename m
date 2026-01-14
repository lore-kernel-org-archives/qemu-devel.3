Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B1D29FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfypt-0006Xq-5A; Wed, 14 Jan 2026 06:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfypl-0006SX-4J
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:14:42 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfyph-0003mx-Dv
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:14:39 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-78fdb90b670so79267517b3.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 03:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1768389276; x=1768994076; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMiwVDwXj2dFs8KEeqQ55bZILtO3/3fPWfNS6/YxFIE=;
 b=lrqJqwA09l7wbei/pmOggjtEZRGfwa8H1jBUNy3EkAkD1sxlGNk7mDpCgyQpjKk4Ae
 gbG2FKBrAeiwlLxHTbryqRZYTlM9L0izbOV7o9R3h36R/KHFoyPwUBe0y2+dab41Thxw
 ANuP3eBzFXjBnBJHLK6BR7+/DqMVfUXIMSt3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768389276; x=1768994076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMiwVDwXj2dFs8KEeqQ55bZILtO3/3fPWfNS6/YxFIE=;
 b=v0uQR+iRhLx8tf0H3Ct68/TglUkYGUfC/y5gRCrUi+1zDtorSvBP3ZVccv5AzQZ8Qe
 tY5trSrzWnuzEqACm6NpT3P1rpD/uTNKkSCe+UkTbNlzLlo1TsKhjPfUW0fNWbhPxh8U
 QctwR+kxZcCFwBE/r3TAr++GsMtZmGHL945QpxkxI/g0JYzuuYtk77VMxVBICIBxKhBt
 iMOJDhkFfKwjZTEvQxkvj+6yzi0IrCtYnPxRhp5nLOsZLl60RY0o7ywtRAT9eT1oYdf+
 /KcKj3HM3T1H78RTnntbMEfoAFl1N80ZHvTXQpRN0RplN3pip37KYoqOiH9JV55kbg4Y
 Gnzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1+P6/Sh+n/TurDYFbzToSnyB4+GSsshJNrDvj6slTXp1Pg1rTYhkJFjCQ0/YydMhskIkvBIFxmv7H@nongnu.org
X-Gm-Message-State: AOJu0YwS+ZpSO+vKL0Hp1wLKeJRkkJc98mErus1oRY/701tUkH+SDDyV
 U/m3yP+7aKK1M0rrDVtrx8g2BAdeur+pZmqpPXX4eQFq3Kz+TrENoWeAYWYd8mPxmyfbERxZoQ7
 MzTFKyUAGz6g6XZcDBn4hBLqEQpngjkw=
X-Gm-Gg: AY/fxX6qLTCeUI038MJxBi0VjdVpberTvpdzLwtCspNjiRq7M6BSOOHVu/NpcpERNgx
 Og6zSphniG+FXY64Ty5NND4Mok6Z4E/K3YSvYCoUVyk6j41WU8K5wMYCklg3YsvBlyYlZNBr86b
 GEPqUrahxS1im4LfQ5+rqtLi2FnNJPDOTSdoetacua/RVOvGi6T0mu5MwYeIxThIRYOjYu2J/rT
 7wLmijCba/HKx5bhQXEDXyWBCfKWU3bGDJwLC1zVu2TTGBrPUrN+5ZE7ScRQn+v86xkQkM=
X-Received: by 2002:a05:690e:13c8:b0:641:f5bc:6961 with SMTP id
 956f58d0204a3-64903b594camr1226062d50.77.1768389276030; Wed, 14 Jan 2026
 03:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20260114043433.1056021-1-joel@jms.id.au>
 <437f995f-6ae0-469a-b2d3-6ce59b3f49e0@redhat.com>
In-Reply-To: <437f995f-6ae0-469a-b2d3-6ce59b3f49e0@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Jan 2026 21:44:24 +1030
X-Gm-Features: AZwV_Qgmjayv6SrLMxBU2qNAJRnXbCCB-d6_dIkSJoHWekaBJoItJpC9KnoJYio
Message-ID: <CACPK8XdURBGUWxaiT+4uEP6nKxMP=C7_iw4A=9s4cNj0DmC+uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/riscv: Add the Tenstorrent Atlantis machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, 
 qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 14 Jan 2026 at 19:36, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Hello Joel,
>
> On 1/14/26 05:34, Joel Stanley wrote:
> > v2 separates out prep patches so the machine can be reviewed
> > independently. It depends on the following two series:
> >
> >   AIA: https://lore.kernel.org/qemu-devel/20260109133125.397364-1-joel@=
jms.id.au
> >   Boot: https://lore.kernel.org/qemu-devel/20260109131657.396794-1-joel=
@jms.id.au
> >
> > Original cover letter:
> >
> > Introducing Tenstorrent Atlantis!
> >
> >   The Tenstorrent Atlantis platform is a collaboration between Tenstorr=
ent
>
>
> What kind of board is the "Tenstorrent Atlantis platform" ? Is it an evb =
?

An upcoming dev board with the SoC on it.

> >   and CoreLab Technology. It is based on the Atlantis SoC, which includ=
es
>
> Why isn't the SoC modeled independently ?

What I've modelled is the soc, with the exception of the test i2c
sensors. Everything listed (aside from the i2c sensors) is inside the
SoC.

Lets say we add atlantis-evb that has atlantis-soc on it, with memory,
i2c devices, etc. What does that look like? The aspeed machines are a
bit complex to follow these days!

Cheers,

Joel

