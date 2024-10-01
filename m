Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC47DCEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sve3s-00043H-1Q; Tue, 01 Oct 2024 10:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sve3p-00041F-48
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:41:09 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sve3l-00030m-NH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:41:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2facf00b0c7so19093901fa.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727793662; x=1728398462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbuUT9EGajx0g1hYB1DGCdOdT0DPQMJrhPwUaR6K6v8=;
 b=DC6ttWAut4HJ1xl2gkpJpq+BACW0yudi9qSQzya3ViPWKhg0WBHHYpzrqhYD0w3W8+
 +Q/BC2L8RbuqX9B2KhQtly23LDUfB7kVtOxlkCPK+ArHFc5cXN+izrogzhg/C0g6Pdgh
 GPdfcZ3h3BRyUt4cSaGz6JmeQ6RbO4BHg4wSXFC27uWF/WHT33lUqa1BOyg9xoNP4fvh
 MyCvzniHvyLiNWnx3rzJc/Qy+CwjUpqhcMssmiq//qkGbR6VCLKQSaO+dF3EXad3hF0E
 QH9k9vM3evnTem0+x4vyqap5eM1wF2Sr5i4D3tgvpyQym+0EClx54oawlR9K9WiJce7T
 V+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727793662; x=1728398462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbuUT9EGajx0g1hYB1DGCdOdT0DPQMJrhPwUaR6K6v8=;
 b=dEv/au0hwxEy1Q8c9idXWDWt3gOfvdlkizQ/zE76nFnms6q1fX0/LqUPnO2L//XgZx
 8HqOePzzlO9eYiP5EmivbvoVRZMc9DTTd6zTFEiylzTSneBhEXTxR/Jh5n0f2ly52aYv
 A82cr1c/u60WcTB3RpLy7lI430N1AOqcllKo4ig63A5FaFYRolSd9RKOT1mWD/fSiN9O
 KfhE6FGsUksVbYfJm5zbBmLdI9VU/UfjzTQqhY69dON0EXJQ7ypZlwO0hav/6gs0d31Q
 TV7+cjc759/DhK/uy71QK5UIgNs81Jr12nD4zhk+yDB+iO82ORjXm2q8A06dquiuWKi6
 w6BA==
X-Gm-Message-State: AOJu0YxvhtR5txRAR5HhDE0FokzxOqgMnQpw5gpL97CNxKscQZci1RGd
 Ty1jR+x8WnXEEK24bubBI5RcdXkIwxIgcSwh/a2YnO3cAfrdtnZGbuAD39p76GJGV+fiGV7Aq8F
 6NSIiRYiQGC/Dc3NEwzpYnhrF3A8QwtxnbWKqErUFXFXBeUff
X-Google-Smtp-Source: AGHT+IGFdvj6QKOfG+IZOH1nx4C63t/O6K0scOfJNZJY58Szabr+jo343pyor7nq0Rk9wMFLyVoUp1tfMf3boaP++v4=
X-Received: by 2002:a05:6402:1599:b0:5c3:d8fb:df6a with SMTP id
 4fb4d7f45d1cf-5c8a2a3199bmr3250932a12.14.1727787724017; Tue, 01 Oct 2024
 06:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240906164834.130257-1-jlu@pengutronix.de>
 <CAFEAcA-_=vrtqVPUdu02ryUtdH5MwifEnHgeQVq=V4Z2Jp_dUg@mail.gmail.com>
 <d6e9f2f8d7185e90e7b80dff7b222fd99c899903.camel@pengutronix.de>
In-Reply-To: <d6e9f2f8d7185e90e7b80dff7b222fd99c899903.camel@pengutronix.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 14:01:51 +0100
Message-ID: <CAFEAcA-uMnP3Zyw5f2ha_9H1+QrnZXMau4FwEjP4UXNnjs-OqA@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Fix handling of disabled boot partitions
To: jlu@pengutronix.de
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Mon, 30 Sept 2024 at 21:05, Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:
>
> On Mon, 2024-09-30 at 15:18 +0100, Peter Maydell wrote:
> > On Fri, 6 Sept 2024 at 17:51, Jan Luebbe <jlu@pengutronix.de> wrote:
> > >
> > > The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
> > > specify whether the boot partitions exist, but whether they are enabl=
ed
> > > for booting. Existence of the boot partitions is specified by a
> > > EXT_CSD_BOOT_MULT !=3D 0.
> > >
> > > Currently, in the case of boot-partition-size=3D1M and boot-config=3D=
0,
> > > Linux detects boot partitions of 1M. But as sd_bootpart_offset always
> > > returns 0, all reads/writes are mapped to the same offset in the back=
ing
> > > file.
> > >
> > > Fix this bug by calculating the offset independent of which partition=
 is
> > > enabled for booting.
> >
> > Looking at the spec this change seems correct to me.
> >
> > Can you elaborate on when users might run into this bug?
> > As far as I can see only aspeed.c sets boot-partition-size,
> > and when it does so it also sets boot-config to 8. Or are
> > we fixing this for the benefit of future board types?
>
> I stumbled across this when trying to use the eMMC emulation for the RAUC=
 test
> suite (with some unrelated local hacks, which I still need to clean up fo=
r
> submission) [1]. Future boards would be affected as well.
>
> One other possible issue would be disabling the boot partition by using '=
mmc
> bootpart enable 0 0 /dev/mmcblk0' (or similar) from Linux. The layout of =
the
> backing file shouldn't change in that case.

Thanks for the clarification. I've applied this patch to
target-arm.next with the following paragraph added to the
commit message:
 This bug is unlikely to affect many users with QEMU's current set of
 boards, because only aspeed sets boot-partition-size, and it also
 sets boot-config to 8. So to run into this a user would have to
 manually mark the boot partition non-booting from within the guest.

and I cc'd it to stable.

-- PMM

