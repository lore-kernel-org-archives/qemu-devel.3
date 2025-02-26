Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48838C021BE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 02:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn7SK-0006ho-5m; Tue, 25 Feb 2025 21:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tn7S8-0006gG-7q; Tue, 25 Feb 2025 21:47:19 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tn7S5-0004c9-H9; Tue, 25 Feb 2025 21:47:15 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4be74b9de53so1870586137.3; 
 Tue, 25 Feb 2025 18:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740538031; x=1741142831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F95Tvv63zG7/DaG/ueIhsClwZWNLrFPgC5rHgRqZz84=;
 b=ml5lDpNdvfv2npPKVSdkyzGuy1K3kvZzpEIlJI+hDHZVQrYYQL/uW6duPRAjkM/EbH
 2YRyQB1zJrWh397NYjLAiwZiAcEWGSmk5/yN1+rbfWIdNRCQHBHoH4gDJyTRel33KXm0
 7aKvJrLkHMTwK9NWIDJU8dmeb51zvNDBVLtLHizSWd2F7QWZmsvJTTDG+OIKBinJv6pv
 gBNEi62G4H1vp3pSm5Vgv2mq9KZwlYsgT/Gzxio8+6H42wKbSuK4bRwuUUc16c0VYkHt
 bOYL00nA29m/88z/1g3xlKyLmaVFKJDWfry21tWvmuSSunNkuECnlol1/mzzbIz16RiE
 hHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740538031; x=1741142831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F95Tvv63zG7/DaG/ueIhsClwZWNLrFPgC5rHgRqZz84=;
 b=BnSAGojpNGY/XB+rx1XkdT1LCOkR3Nwl+MoBFRI1qtc+SosRd+tcAkKhqblYuXAI/R
 un31rD0iqS7cPelTkUgdJ+KdtsKtCRX6aTwXCEJG22Ox6rVC0Ms+5Si7i5RzyUuSmFkU
 vxb2wjTmOvuUpcOJlXIEBrQK1O/gnEW+adz7CIbeWmJT6TsKcxUSv7pTnQgIpQbfaR8N
 7LgbeBNfRPcGYPtXjrvMSCvTYpJnQi9lCj+2lH2H0/dmP225VpPLNyfWNafCSJU9/ROc
 dCgWQE/fGO8PipXLZyGArj574r2/EsxMOcPa536tVw95Q85rHtrBrQFuXdnpDr135HMw
 HOnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/z3bnEjcJIOyRbK3Yhi27zVyJPD4M8HkS5X4gqCGiabG6p+iJFDD4YIHeOiacJFTb0ROD2WINN+OTYA==@nongnu.org,
 AJvYcCUf71VuLnViCEUj3IOm/JYsgu8VrxglEvWc521BsmaPfR/niFSrku55XBNAv2v6vqUR4U3Y3CFpOq9S@nongnu.org
X-Gm-Message-State: AOJu0Yxb8c0Rij4izLReysX+cQ4UuwILaI+r/AK4XnCuohU1TNgKVJV3
 glnO3phzox5GmcJY/ZP/V+/0SeQgx7HSsiRZ2rDswaPpaNRHj37A+mRUR3c8U9PoSfiK7jezATZ
 bBGY3EnUFDmBzJ3yWDJnoNoHveWY=
X-Gm-Gg: ASbGnct9QIEJddkQ2WYWov0wPe7lsY+JZy7tK9ah8CE+58AUEmp9/cUKzD+OCHcHuqm
 APAIJHTIbEu2bLGW/MfekQT7w60ZMB6ecVKZxJ5haxLpTJZT4CjB09GLY2PGzBrjnD6yUk5lkUJ
 9ADdatZ1f4kB6xtlX2tMAODyqq64mrpV69XxJ58A==
X-Google-Smtp-Source: AGHT+IFZck125UeBc09nrlot+7p15RYZmDSPxo+kMotxrB1ySozOc1mrwqU5qKOz/T0DDI0IoVYIL0Hp6bQqqQ2fB6Q=
X-Received: by 2002:a05:6102:3ed5:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4c00ae566bbmr3582390137.20.1740538030742; Tue, 25 Feb 2025
 18:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250220-reggae-hardness-907e385516d8@spud>
 <CAKmqyKNex8vQuT3ArR3gePfGfeLCZbW0DxzD9dz8oNAODE8sbw@mail.gmail.com>
 <20250224-ignition-afternoon-9d4996362813@spud>
In-Reply-To: <20250224-ignition-afternoon-9d4996362813@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2025 12:46:44 +1000
X-Gm-Features: AQ5f1Jqq1J74sJURigvO-mkwQjY47A6DHDEa-hNO_hdSZ5KR_othf_2DV_C9Eho
Message-ID: <CAKmqyKOXkUNSdw-xeboHdo3wTF=73378h6_U9S-0aHB--wCUJQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
To: Conor Dooley <conor@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org,
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 25, 2025 at 7:28=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Feb 24, 2025 at 03:14:00PM +1000, Alistair Francis wrote:
> > On Fri, Feb 21, 2025 at 4:31=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > +cc qemu-riscv, Alistar.
> > >
> > > On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
> > > > Booting the microchip-icicle-kit machine using the latest PolarFire=
 SoC
> > > > Hart Software Services (HSS) no longer works since Qemu lacks suppo=
rt
> > > > for several registers (clocks, DRAM controller). Also reading from =
the
> > > > SDCard does not work currently.
> > >
> > > On that note, I think the inaccurate docs about polarfire should be
> > > removed. There's a wiki page here with dead links, or links to things
> > > that do not work anymore:
> > > https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFi=
re_SoC_Icicle_Kit
> > > I think the whole section should be removed, find it kinda odd that
> > > there's a polarfire section but not for any other board. Either way,
> > > it's talking about something that just does not work, the current HSS
> > > and Yocto don't boot.
> >
> > The wiki is independent of the QEMU code base, so you can modify it. I
> > agree that we should remove outdated/wrong information as it's very
> > confusing to users.
>
> I don't have an account to make the modification, any clue who has one
> and can hook me up with one?

@Peter Maydell  @Philippe Mathieu-Daud=C3=A9 can you create wiki accounts?

I don't seem to have permissions to create new accounts

Alistair

