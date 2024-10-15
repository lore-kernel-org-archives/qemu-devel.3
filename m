Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEB7D1D88B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0l6m-0002uD-HF; Tue, 15 Oct 2024 13:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0l6j-0002tl-AF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:13:18 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0l6g-0003Yy-3d
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:13:17 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so17640251fa.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729012392; x=1729617192; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DiPm4r96ebUEyaZxC+805tfF6sT6Y2BwaLiml4Z063s=;
 b=cHP0bkqEOFy5G0y/A6GjMIYvBE1HimrGxmyVcWUFnY/+iK02Hxf2FtZtFIGCsOQWAA
 XhgHAexsnqeIxah7g1D9iwOnDxxO2pY6JmhFvSJcq/1Z/GGz994djxmDsmyuL8E78cLG
 w+TX3jDqyDS0vvr896EVb9pdOBfq4kypmLp9IrFNHru0w7JBaQXGJbOfjXtegP7UiJu+
 SyNOoZhQtZVyhKC3soUboeBbEhFschPsUIY+vUKwtctbsrgWi+oeNkpMX91U0g/j3HT8
 +1IK9FMHnAk+lN5HuS4ZcMKnCraoo+tAuLEB9Qth9BnkygBlqFxwm56WVoxeCaRmHSDe
 1NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729012392; x=1729617192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DiPm4r96ebUEyaZxC+805tfF6sT6Y2BwaLiml4Z063s=;
 b=KVw2xltxy5wgrrhCAYy6NrdmFwHyQLJigYc8nNtBtjLhSwosL1zcJozAdFhwINidsP
 ud7z79Rjqxs5+Lx83XWNEoqp1TyUAB4tzw2Kj2FCsF1JqrlDlaxvuZve9vdTshFII5ev
 8yaZQzDUyG30amhHcCpcKW6PU8WcnpoZq7qfDeJUWssfeQVCFGrieDx5AOIap+rTuqAL
 gjMBnRKN1g8d60ihtKgaCeD6ZyTs8ds8CKTBXGjYw5jr3LUZEOOvDCBfgIOxxkydfV6G
 vJue9zYcQln7nRP7Fk8C6snwWIzvck9oYRuhhlCRFASIxXPfjdgzTBUVUgeXspguNBj6
 ZItA==
X-Gm-Message-State: AOJu0YwGeQfL5oQizpR1yrH85xkjkoPN/HyIlTdLTOx73YnYgPz/f5uU
 59UmiHV8/sV7vojobxHgUtaX49GQQK1CLVXFZaQOCHcPhp/CbE3qNcF/K+as6Whq7bQ843r29EJ
 S24mV4AfroTKjsrdXEE1TChoIvrC/BtArMVl23Q==
X-Google-Smtp-Source: AGHT+IHSFf6OgOjGOdU4U9kmnDcRd4b/LJVxuMW7RO8tVxyUI3rcOG2c/0CoFQJ0SPMybiwd1Euo1YTe6v1iUUtEOWk=
X-Received: by 2002:a2e:2e0c:0:b0:2fb:5cff:fcd8 with SMTP id
 38308e7fff4ca-2fb61badb33mr7155341fa.34.1729012391812; Tue, 15 Oct 2024
 10:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
In-Reply-To: <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 18:13:00 +0100
Message-ID: <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, 
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Fri, 8 Mar 2024 at 15:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> Thanks to everybody for your input on this thread. My
> proposal is to drop from QEMU:
>  * all the PXA2xx machines
>  * all the OMAP2 machines
>  * the cheetah OMAP1 machine
>
> leaving (at least for now) sx1, sx1-v1, collie.

This has now gone through. I'm now looking for test images
for these remaining boards, so we can keep them from breaking
when we do refactoring and code cleanup/modernization.
Specifically, I'm looking for:
 * QEMU command line
 * all the binary blobs that go with it (hosted somewhere that
   doesn't mind when our CI downloads all the images to run
   its tests...)
 * ideally, exercising the SD card interface if present

Could the people who are still using/testing these boards
help here ?

thanks
-- PMM

