Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC79C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1F5-0001r6-AB; Wed, 01 Jul 2026 16:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weykH-0007sJ-PR; Wed, 01 Jul 2026 13:29:10 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weykF-0006CJ-E8; Wed, 01 Jul 2026 13:29:09 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id A35A920039C;
 Wed,  1 Jul 2026 19:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1782926942;
 bh=LF147eDd1ycYKOfzBDN8vTNLdCVRJi4vNCHJE9wfPmQ=;
 h=From:Subject:Date:To:Cc:From;
 b=IdmJRGKrH3mD9wARXem9v+heGBin0BsZ8HjPTJPa18wbFZA4WxhtZ9j/X1DfoZ/be
 uJOjtx2rnYGGF+We0tdyX44E4MSlRZh2dWOSHxkU98BROjkkp+731zxkHAb16FIYMr
 EIeDLQloKgDNOaaN3zWAywKSernL9jF0rhn2tyvfJq0v4i1o17W7/y1A7DRrOeh1dL
 rUdXLe6N8rk7ZeQv4iJ9d19XHTCpWhvEUITC752kLVwnaVeLZAsQaJwxXFgEsa6i0M
 S4uI6Fjkp24TllFeYmp2dPa3GfBojb4dFt6vCC4uiEHVm0OpZmMzDRBMBu58py+kWI
 /AAG0RJg7o4pg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Subject: [PATCH v5 0/8] hw/sensor: Add new device emulation for TI ADC128D818
Date: Wed, 01 Jul 2026 19:28:30 +0200
Message-Id: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNzWrDMBAE4FcJOkdFWikrKae8R+lBP6tGgdjBc
 kxL8LtXTg81AdPjwMw3D1ZpKFTZcfdgA02llr5r4bDfsXj23SfxklpmIAAFSuAFIvcpSrDJSst
 956O/eS5VREXO5JAEa+PbQLl8PeH3j99c7+FCcVy0pXEudeyH7+fzJJfevyeT5II70qhFTBJ1O
 F1p9G+xv7LlY4K1YjYVaEpOyhrUWWg8vChqpcC2opoSc3AajPDOihdF/ylGyE1FN8W6hB4yhQC
 4UuZ5/gGChJd1nwEAAA==
X-Change-ID: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, 
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Corey Minyard <cminyard@mvista.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782926919; l=3533;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=LF147eDd1ycYKOfzBDN8vTNLdCVRJi4vNCHJE9wfPmQ=;
 b=10NzA0tiEdpXzB0IiuN/4iH+U+BrQ2n1nCvBr83dHs5h94ieVg2FKrlr1YOuQzaZ0xBwZtLs6
 +VF07TrxufqCpysGExUX5XHyqVsXwyaCtF3sXSyBKMmVUNN7fHDDLd6
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2026 16:09:06 -0400
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

This is a 12-bit, 8-channel ADC I2C device, which is used on several
OpenBMC platforms.

QOM properties can be used to change input ADC values and external VREF at
run time.

Add it to AST2600-based Anacapa machine, along with some functional tests
that use QOM properties to inject voltage values into analog inputs.

Datasheet: https://www.ti.com/lit/gpn/ADC128D818

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Changes in v5:
- Change author/committer/signed-off-by address to circumvent SMTP issues
- Link to v4: https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v4-0-89d6a2febb26@meta.com

Changes in v4:
- Better follow QEMU coding style (lowercase hex number, signed integer
  constants, parent object variable name in Device)
- Split adc128d818 test large commit into smaller ones
- Link to v3: https://lore.kernel.org/qemu-devel/20260627-i2c-adc128d818-anacapa-v3-0-cfb94270a980@meta.com

Changes in v3:
- Update anacapa test image with proper DTB
- Make I2C device in i2c_slave_create_simple a child of the I2C bus
- Simplify tests/functional/arm/test_aspeed_anacapa.py
- Use g_test_message rather than fprintf
- Keep review trailers
- Link to v2: https://lore.kernel.org/qemu-devel/20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com

Changes in v2:
- Remove clang-format useless comment sections
- Link to v1: https://lore.kernel.org/qemu-devel/20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>
Cc: Troy Lee <leetroy@gmail.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Kane Chen <kane_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

---
Emmanuel Blot (8):
      hw/sensor: adc128d818: add 12-bit 8-channel ADC device
      tests/qtest: adc128d818: add test harness and register access
      tests/qtest: adc128d818: test voltage and temperature conversion
      tests/qtest: adc128d818: test limit interrupts
      tests/qtest: adc128d818: test operating modes and power control
      hw/i2c: parent slaves created with i2c_slave_create_simple
      hw/arm: anacapa: add ADC128D818 devices
      test/functional: anacapa: test ADC128D818

 hw/arm/Kconfig                              |   1 +
 hw/arm/aspeed_ast2600_anacapa.c             |  21 +-
 hw/i2c/core.c                               |   3 +
 hw/sensor/Kconfig                           |   4 +
 hw/sensor/adc128d818.c                      | 696 ++++++++++++++++++++++
 hw/sensor/meson.build                       |   1 +
 hw/sensor/trace-events                      |   8 +
 include/hw/i2c/i2c.h                        |   7 +-
 include/hw/sensor/adc128d818.h              |  14 +
 tests/functional/arm/test_aspeed_anacapa.py |  69 ++-
 tests/qtest/adc128d818-test.c               | 856 ++++++++++++++++++++++++++++
 tests/qtest/meson.build                     |   1 +
 12 files changed, 1669 insertions(+), 12 deletions(-)
---
base-commit: c682d7d73adfddbbcfb2613942d7c96fb43534af
change-id: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


