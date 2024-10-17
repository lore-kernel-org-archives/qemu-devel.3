Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BD1D37487
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 12:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1PqM-00024Y-V9; Thu, 17 Oct 2024 08:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1PqL-000244-2V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 08:43:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1PqJ-0006rQ-Cx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 08:43:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso1666633a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729168981; x=1729773781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZuKCrkaLzM33sZ5bBvK6gUY6ZZ4l7azgsAmnHgjSa4=;
 b=o/BIDqRohYZrVN81uqEv3e8i5sheaqfvt8QN7NcUf8HRzs3tCXKRtfladL8GzhTcED
 HQCOEcX4NmQktpPQab0WTpxrtIbv+D6i7PRB1XYg9fSQrTsv3twP5yJFClEJ4zJjg1+N
 Og/wisDOQURs3KjnqjZ6g0WSKw/79GIZNLQvhHvxG5D8jsxv8wZgpc9oSpPppWDCVMPG
 mAv5x1ilyHXkD2gHinO4ld2k062WvcGbDQEbmaKTELsPNPX42apxHi7lWSfQt4A3DCcm
 o9/yNqzGrsoLvzDJyQp9QOwlyqW3EIlhS8gHMbheI4IY89nAXeDg0YwxH/wZEQG/6S2f
 qNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729168981; x=1729773781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZuKCrkaLzM33sZ5bBvK6gUY6ZZ4l7azgsAmnHgjSa4=;
 b=gH8j1BDmk4j88FnX0SLFD9o1Cezm404fEpB48P/XNPQTMhZUkpcRJLmEJ2iacF4axt
 A4onuCBwDrl9bQHVEEm7tvxWEz5yuihKgATUGjQMN97hUgzLSS7othGcmsxSsmY3sQGI
 7+7DD1aVSKyUBL9w5JrTR1zvkqISYkonYUAV0sfQLpLK1BpElLEEi0Wkx26YQtJO5cae
 Auy0Hykpp72jOB2OOZmocf91UjyY/0cUPDKjTzPZhjTJBhd1MMfAxIuLV3b2eo+5v+uh
 W8fIqJ4J5T8idJvZIyOnryX0qp18AtUqUbapU2NyMrcZSnYPjjgUIqHS7r/1KQEcwrDU
 sK5A==
X-Gm-Message-State: AOJu0YwR7n4dwYNmfM3u3/kdQsYGfUjOVvy6dFouSCcht9Sy6ylS9e9W
 AwMGXQthjoJTkPeyHTE9MkPGHnYlccXIzMC1x/gfC3hCGzeOPOmWurYL9tzds1fsKhWnnQS21LW
 jpNPs6zHv2KxUnBTXGBb+KyqSttv1UF3gXzyH0A==
X-Google-Smtp-Source: AGHT+IEArqXHn2TZ8HnQtNR/0yn1cUP2Pz25ofAsIP5SflIArI0A2LZyQBOx8pJDoP8BFftRxNs83QuFLQwbAuPCBV0=
X-Received: by 2002:a05:6402:3513:b0:5c9:57bb:b922 with SMTP id
 4fb4d7f45d1cf-5c957bbc823mr15253428a12.19.1729168981305; Thu, 17 Oct 2024
 05:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
 <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
 <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
 <CAFEAcA9AZS1dGaLG85zZE8U0d7AcrLgKXNbhxkCoP+PLmbFn2g@mail.gmail.com>
 <cf7c8f57-22d5-4a40-bd87-0f15f5457d48@roeck-us.net>
In-Reply-To: <cf7c8f57-22d5-4a40-bd87-0f15f5457d48@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 13:42:49 +0100
Message-ID: <CAFEAcA98=2OdT9ykg5ibDuVLtSXuq4g0PLmSbxkYmt1SyKe9iQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 15 Oct 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
> Please let me know if https://github.com/groeck/linux-test-downloads.git
> meets your needs. For now I added 'collie'. I'll add more after it is
> in a state that is useful for you.

Yes, that's great, exactly what we need. I've put together a QEMU
'functional test' case that downloads the collie rootfs and image
and checks that they boot. (I'll send the patches for that out
in a bit.)

(I've coded the test case to pull the binaries for a specific
git revision of that repo rather than always-from-head, so
we're testing always the same thing against head-of-QEMU.)

thanks
-- PMM

