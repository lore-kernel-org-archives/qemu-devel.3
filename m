Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C57C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTY2-00039T-1Y; Thu, 04 Jul 2024 16:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTXy-00035T-6q; Thu, 04 Jul 2024 16:59:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTXw-0000nJ-IA; Thu, 04 Jul 2024 16:59:17 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e8b27f493so1162557e87.2; 
 Thu, 04 Jul 2024 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720126753; x=1720731553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k0FDqecZrCamRz8PvtsJUnmPAYojJ7BkczA2Sm72kHU=;
 b=WCFaJqdnzuEEYdRazK1r6xPq8OJLJfTXxvCFQuGjDs7ZbVxABrRhRBQCzKeP/79yms
 Xi/Wmr/dC40uw5IRXkhA1FmPYNSAxrE1mzjutocjZ1Y+3eK+C8blySa+VmJwAD7POX5i
 aJo8ZYQYu+ym48cDZQYr59g+rK0IlmhzJrq9I0EMAMIXX9UBMGspEve2MHpL029RIquD
 nKBlAu4SqCE0FnG/wGqU7CJsBmSquKXX2wOQecvS/roCFALmQZEIKlGwinBHzicMc4r9
 pQIYAbwnv/yUx7hWgvGE9P5elQrmOoDh0T56XCzAGUmofYSNc4waOgBtvQrZvWsIgyQD
 6uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720126753; x=1720731553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k0FDqecZrCamRz8PvtsJUnmPAYojJ7BkczA2Sm72kHU=;
 b=Ejoj7PztD9Wm0NjTndc0Rz2faqDnF1/8XJf1Kq+De82vNLCP49vR1119ixakLRnimo
 rN1xJJYhhP2XulyhB5aYcHJ3smJuS31e+4Tiubp7r69NgQinCM8P6SreKMKAkejU3eJ4
 K4/Xr3wFALSU8ulzl2kdLr69CfzQxdpOejDj0bQOY3z4TJcMSHc/xPs4dEXeHOEn4k6m
 Qwsk7iqZ7/gesdN9Dfw3UlCo+KgUviSeigSOyCedpXUQjpbpahk5vjT51APlQDMSWhSp
 AUoBIyDs72VFzwVS9gDH0DFw5Zb+GzHTEEyoQrT4Z+wPEfNIoNoQhJfFHQwIU3epJpqL
 1ZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp2AEai/LqbpuzZWc94vMMCZ8DEJ2lHZD1UKbwRHjaFp5TqgHWkDdAC9152nag8skBh9rbbqXHBB1FEGYJt26G7B8E
X-Gm-Message-State: AOJu0YzdIgsnm8RkxUjy4CkBtyUvXizHHoBs1EgQfRvRBIyDgJSwbWMm
 ZmMOdoXLoV8VwMKNGO2ANzkT7LZzkCl9vnPohZEtbdIAVwmgZt3a3l1H7A==
X-Google-Smtp-Source: AGHT+IESt+KmfIYJd2dETBqh50wtvn1zH9FJkpY7Brrn/sGC6Aqpzjtn8ngmwxaQcCajYf4vF6/KyQ==
X-Received: by 2002:ac2:5999:0:b0:52e:9407:ddcd with SMTP id
 2adb3069b0e04-52ea0628c53mr2001859e87.18.1720126752576; 
 Thu, 04 Jul 2024 13:59:12 -0700 (PDT)
Received: from archlinux.. (dynamic-077-188-087-180.77.188.pool.telefonica.de.
 [77.188.87.180]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7400456582sm526153866b.153.2024.07.04.13.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 13:59:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks
Date: Thu,  4 Jul 2024 22:58:51 +0200
Message-ID: <20240704205854.18537-1-shentey@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series first turns vt82c686's "INTR" pin into a named GPIO for better=
=0D
comprehensibility. It then continues fixing qemu_irq memory leaks in vt82c6=
86=0D
and piix4 by connecting out IRQs of the south bridges before they get reali=
zed.=0D
This approach is already used in the pc machines after it had been discusse=
d at=0D
KVM forum `23.=0D
=0D
Observe that out IRQs are callbacks such as an INTR IRQ handler in a CPU wh=
ich a=0D
south bridge wants to trigger. If, as an implementation detail, the south b=
ridge=0D
wants to pass this callback to a child device, such as the PIC, then this=0D
callback must be known to the south bridge before it gets realized. Otherwi=
se=0D
board code had to wire the PIC device itself, breaking encapsulation. This =
means=0D
that qdev_connect_gpio_out*() has to be called before realize() which this=
=0D
series implements. Another way to look at it is that callbacks apparently a=
re=0D
resouces such as memory regions which are also populated before realize().=
=0D
=0D
Please check if above paragraph makes sense.=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
See also:=0D
* https://lore.kernel.org/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@g=
mail.=0D
com/=0D
* "Remove intermediate IRQ forwarder" patches in=0D
https://lore.kernel.org/qemu-devel/20230210163744.32182-1-philmd@linaro.org=
/=0D
=0D
Testing done:=0D
* Boot amigaone machine into Linux=0D
* Boot pegasos2 machine into MorphOS=0D
* Start fuloong2e machine and check that it doesn't abort=0D
* Boot malta machine with https://people.debian.org/~gio/dqib/=0D
=0D
Bernhard Beschow (3):=0D
  hw/isa/vt82c686: Turn "intr" irq into a named gpio=0D
  hw/isa/vt82c686: Resolve intermediate IRQ forwarder=0D
  hw/isa/piix: Resolve intermediate IRQ forwarder=0D
=0D
 hw/isa/piix.c       | 13 ++-----------=0D
 hw/isa/vt82c686.c   | 12 ++----------=0D
 hw/mips/fuloong2e.c |  2 +-=0D
 hw/mips/malta.c     |  4 +---=0D
 hw/ppc/amigaone.c   |  8 ++++----=0D
 hw/ppc/pegasos2.c   |  4 ++--=0D
 6 files changed, 12 insertions(+), 31 deletions(-)=0D
=0D
-- =0D
2.45.2=0D
=0D

