Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC09C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 01:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra44M-0000lG-Kw; Tue, 13 Feb 2024 20:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaro.koskinen@iki.fi>)
 id 1ra44H-0000kp-9s; Tue, 13 Feb 2024 20:28:09 -0500
Received: from lahtoruutu.iki.fi ([2a0b:5c81:1c1::37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaro.koskinen@iki.fi>)
 id 1ra44E-0001Uy-TK; Tue, 13 Feb 2024 20:28:08 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-160-177-nat.elisa-mobile.fi
 [85.76.160.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: aaro.koskinen)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TZLD71hD6z49PyJ;
 Wed, 14 Feb 2024 03:27:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1707874072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4114BJ6W6i8Bsstwtgpj1rAy65HGfORfmM3A0e8Aa4k=;
 b=qFSEtE3oeD972ocZ9UxJbiLMfVGTpOdndOtwRw8Kz1jaX1Cp+f9DirjIqCYohMnPbD8G/B
 fimJ5CVWHO9jTBZERDsMy145V/AToZtUu3vDt+9mMBAEEHVhFy7H7fDs9U9nZRnZTE6YEE
 /HolOg78Ng0woGsf37RWIx27Sd3P07tzaEieQDx/Gwnso/uRrnsbtHcsNbTrXpUBZniHxD
 jxBNvKkAVcwF18UNEKq4mGzesMBoa3oJQl8/BS1oMAr+ADhvurh5Epq1mofD/vdm4wnF4C
 G9CH5PcIWGXx7qN3AAjw4UtWsLHKQoVHYLsRojfhPMQPzbHxG0xg8qjDu/emSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1707874072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4114BJ6W6i8Bsstwtgpj1rAy65HGfORfmM3A0e8Aa4k=;
 b=TcPn2+J6WWZYMl/Nw1NwxP5KG7gcYjK+SyqxfbWuT8+oa34PrREG0pr01H43zQVnfEpNRQ
 6QznGJWRuHzWCOqCUvXl3YxBrWZQDI+er3ZdSyiF5K+62e/Ms1fqymHVPpPfKvB21iBkmS
 0SC7upcO2OOH5hK2cwOyln2h2GT5hWar+bf0/cvA3uvTOILdJBUSqI3GuNwRVT8uGkXP15
 p+Sv0ECvwxlsPaGuo0D69gSBcf4Cjpehqke2cEvrbXbyUL6Y4Riexz07pCryuTQSRiy4gS
 UPH2Pp1UdnsYeiHf9SHBa98aEf9xkCpMd6UNjl4o29qmIe9YqQuFOQOsVeiFaQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707874072; a=rsa-sha256; cv=none;
 b=sXIVf8RChiAZ7SLD2ivPhWO3VF0xTCe+uQqwok+lOGrLXO8KV5gVQ6iLxu36gccJuGQSaT
 euTU21km4HU1TljjcjKEddC8s6o0VbrGPiKKYXSeVNQPne1Qc19SP7VTB+0MmBoRX5x/xY
 DRKDzeuV6/zJMrvZAjVCZGTiY/Z9C8IZjsIvgDz+yzlaDjnOAtmTpd7PYam9pNnOqFbWzR
 UJTOPzNN2A3TyfACH0V3wOy1CWwSl2wNASBrF4X0cnvys51UFOj4yV89d1Bq1m+pHxAaz/
 U0aXUGTvMkEFxQlSBUVW5mv7Wo/lTDetoWnHvuojb+KF0uxlBLwIeTBYbgfMEQ==
Date: Wed, 14 Feb 2024 03:27:49 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stefan Lehner <stefan-lehner@aon.at>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <20240214012749.GA203324@darkstar.musicnaut.iki.fi>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
Received-SPF: pass client-ip=2a0b:5c81:1c1::37;
 envelope-from=aaro.koskinen@iki.fi; helo=lahtoruutu.iki.fi
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On Tue, Feb 13, 2024 at 09:11:38PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
> >> > > OMAP1 machines:
> >> > >
> >> > > cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> >> > > sx1                  Siemens SX1 (OMAP310) V2
> >> > > sx1-v1               Siemens SX1 (OMAP310) V1
> >> > >
> >> > I test sx1. I don't think I ever tried cheetah, and I could not get sx1-v1
> >> > to work.
> 
> This is similar. omap1 development is slightly more active
> than pxa, but then again they have no DT support today and
> are unlikely to ever get there at this point.
> 
> Out of the five machines that are still supported in the
> kernel, I think three still run on hardware (osk, ams-delta
> and nokia770), while the other ones were left there only
> for their qemu support. I don't mind removing them from
> the kernel as well if they are gone from qemu.

I'm one of the OMAP1 Linux kernel maintainers, and I have Palm TE which
I have been using for testing and development (and reporting bugs,
regressions) along with those other boards you mentioned.

Since I have the real Palm HW, I haven't used QEMU for that particular
board. But however I use QEMU SX1 support frequently as it's quickest way
to check if OMAP1 is bootable, and if the basic peripherals are working.
SX1 is close to Palm/AMS-Delta, and also it's ARMv4T which is rare these
days. I think it's useful to keep it in QEMU as long there are hardware
that people use.

So my wish is to keep at least SX1 support in QEMU as long as ARMv4T
supported in the Linux kernel.

> >> > > OMAP2 machines:
> >> > >
> >> > > n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> >> > > n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> >> > >
> >> > I never managed to get those to boot the Linux kernel.
> 
> I think Tony still tests these on both hardware and qemu.
> The platform side here is much more modern than any of the
> others above since it does use DT and it has enough RAM
> to be somewhat usable.

I have also these boards (real hardware) and test them frequently with
mainline Linux. However, QEMU support I haven't used/needed. I recall it
was a bit buggy, and some changes in mainline made the kernel unbootable.
Unless Tony needs the support, I guess they are good to go.

(Arnd: RAM isn't everything. Some of the OMAP1 boards today are still
more useful than N800/N810, even with modern bloaty Linux.)

A.

