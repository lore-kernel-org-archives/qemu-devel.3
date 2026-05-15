Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536B2CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu7Z-0002za-Qp; Fri, 15 May 2026 11:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7R-0002yC-UC
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7N-0006Kt-U0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so80648755e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778857584; x=1779462384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zo2FMFqonW654LP1Jtt6iFVrlkL0gbIkLqrfgu4FXnw=;
 b=hSrutyljDsJlZ+cnh1PuD+Qjjq2lm5x2CLU74PPmn9lEvfGkSOxA32B6CGquNj/EUG
 d2A+1tfyQjHzWsRMdqlC9gnpNyQSaBRVPD9v6lGzU3ENrj6U0H6+Xf4BiqsYG+WCp0xO
 +nLqHSiFp8uwZ8yYP03qkd05gIkGm9rfO1aHWGu8qWViUVY/9Au/fBuvrdf+DRzDaFtF
 DP5kWXNqR8/zfJcdHdvmD/wto1S0saQIfkU3voRlO4abh0IT9IRk2gOxaET8hBY2SNZi
 66Y6xWlnjRaO6Oj+MfDcGXZM/HIxR4Aygksc15rgv5r+CUxAPcAHnsTHzz/yISpiiBU1
 TCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857584; x=1779462384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zo2FMFqonW654LP1Jtt6iFVrlkL0gbIkLqrfgu4FXnw=;
 b=rk9IMRXl/CTKzC8O6FqqG0VxpdVKdc4ZX8JUJNVYfwNUH4cCT8yfwPanOYC7lWttov
 Co9X5URHylfavzon4cxT825F0/5impbTbd7lN4sn5gFN0HO2WmsFsf/gcTbsA2PWvINY
 UDMnDNsjFO79MdS4May+7gK0vBZB8vzItpIE6se8r03AcGI5HF4UQJw3snO2rc/L2dpl
 qQ3N5FMKkhZb4LsbD/Z2yV+OWr4y1DPe1qHPNCdF9G18L6ay+9Yul0LRijPLJFCEwE6O
 UgPF1rcfJmc+wwyZzFAHapDXmx6s0TWI8K53F3ldjW482hyPXpwQoWg6jb4xVkgilURv
 ie8A==
X-Gm-Message-State: AOJu0YxRWZjHbhfQz0Az/QjkFTBRM5LCQKNqmdGbHWgEjtzO5uWjuFYF
 tH9pc6P6n77+l3jCv8mynGdxOfbTZu96cWitm0QhWkLxTbtm2cKNIGZg0G/QUEQxi7UsiJab9jE
 wqyfGhyY=
X-Gm-Gg: Acq92OEhiLaH7JcrooQ7FPxzO5mkmSh++FzOzhQk9B9+6eptUAH1yzOZdWZ+2Mv/rIq
 PrhbKriQIxLi9p9dVx7BG5cK4BebIEpxfk/+h9dmcQJhvtSlXo9wPao4qw6lWgH0xYJEWhC6C0J
 FhoATtvr39F44N7ukuJNqlYoFm7XasHaTrhrL6b8TjEk1S+AkN7v9luFMngNuFMFWGf82Z3pYyR
 KqKBLCIhkJRbv6zIGc8r87x5m/26tv7HZqbIH+FeQxs+NEYAu+kzCX4Y/7DNM11olgdnmNmVfGo
 fE+z57PTV9o0vTM8ujHGbTuhsoXHHjpmj6aA5F4GYF4aRX5LLP6Ybn8CaoE9FYYY/cpJsJKHozz
 xpineCqg8FqzUaKO2z6SQyY5xfvjQppngD/kXVWNIZmNFFG4CZlXyb56iAf0e3RW0vpH5XW7vvM
 ghW0GEg8Yy2MmRMGK+3xcYsh8gPpmzZvh+//FzYtdOgWRL
X-Received: by 2002:a05:600c:8b47:b0:48f:dfe3:dae3 with SMTP id
 5b1f17b1804b1-48fe63223edmr65350385e9.17.1778857583920; 
 Fri, 15 May 2026 08:06:23 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab290e1sm29444715e9.2.2026.05.15.08.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:06:23 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH v4 1/5] ast2600: yosemite4 initial support
Date: Fri, 15 May 2026 16:57:58 +0200
Message-ID: <20260515150610.381066-2-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515150610.381066-1-alexander.hansen@9elements.com>
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32b.google.com
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

Initial patch based on [1] to support yosemite v4 bmc emulation.

The goal of this machine support is to support OpenBMC development.

Reference linux devicetree from openbmc linux is [2].

Status:
- Enclosure FRU:         showing up
- Management Board FRU:  showing up
- Blade Board FRU:       showing up
- Blade Board sensors:   not implemented
- Blade Chassis FRU:     showing up
- Fan Board FRU:         both showing up
- Fan Board sensors:     supported

Overall the emulation is incomplete but already helpful in development
and testing.

The focus of this initial support is on the FRU eeproms and fanboard
sensors.

Tested: booted an OpenBMC image for yosemite4 target.

References:
[1] https://github.com/9elements/qemu/commit/32139f913c2bd0ebe4bd26c46765861f6f9f2d49
[2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
[3] https://github.com/legoater/qemu-aspeed-boot/pull/5

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 hw/arm/aspeed_ast2600_fby4.c | 267 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build           |   1 +
 2 files changed, 268 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_fby4.c

diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
new file mode 100644
index 0000000000..89fb0ac2fd
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -0,0 +1,267 @@
+/*
+ * Facebook Yosemite V4
+ *
+ * Copyright 2026 9elements.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/gpio/pca9552.h"
+
+#define FBY4_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+/* START OF EEPROM CONTENTS */
+
+/*
+ *./frugen -s board.mfg="Wiwynn" \
+ * --set board.pname="Fan Board FSC-MAX ADC-TI LED-NXP EFUSE-MAX" \
+ * --set text:board.pn="BRD-PN-345" \
+ * --board-date "10/1/2017 12:58:00" \
+ * --set board.serial="123456" \
+ * --set product.pname="Yosemite V4" \
+ * --set product.mfg="Wiwynn" \
+ * --set product.ver="v1.1" \
+ * --set product.serial="123456" \
+ * --set product.atag="PLACEHOLDER" \
+ * --set product.custom="Fanboard Custom1" \
+ * --set product.custom.1="Fanboard Custom2" \
+ * --set text:product.pn="PN-345" \
+ * fru-yv4-fanboard.bin
+ */
+/* EM Config: yosemite4_fanboard_fsc_max_adc_ti_led_nxp_ons_efuse_max.json */
+/* Yosemite4 fan board */
+static const uint8_t fru_yv4_fanboard_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xea, 0x46, 0x61,
+  0x6e, 0x20, 0x42, 0x6f, 0x61, 0x72, 0x64, 0x20, 0x46, 0x53, 0x43, 0x2d,
+  0x4d, 0x41, 0x58, 0x20, 0x41, 0x44, 0x43, 0x2d, 0x54, 0x49, 0x20, 0x4c,
+  0x45, 0x44, 0x2d, 0x4e, 0x58, 0x50, 0x20, 0x45, 0x46, 0x55, 0x53, 0x45,
+  0x2d, 0x4d, 0x41, 0x58, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42,
+  0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00,
+  0x00, 0x00, 0x00, 0xdb, 0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
+  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
+  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
+  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
+  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xd0, 0x46, 0x61, 0x6e, 0x62,
+  0x6f, 0x61, 0x72, 0x64, 0x20, 0x43, 0x75, 0x73, 0x74, 0x6f, 0x6d, 0x32,
+  0xc1, 0x00, 0x00, 0x9d
+};
+static const size_t fru_yv4_fanboard_bin_len = sizeof(fru_yv4_fanboard_bin);
+
+/*
+ *./frugen -s board.mfg="Wiwynn" \
+ * --set board.pname="Sentinel Dome without Retimer" \
+ * --set text:board.pn="BRD-PN-345" \
+ * --board-date "10/1/2017 12:58:00" \
+ * --set board.serial="123456" \
+ * --set product.pname="Yosemite V4" \
+ * --set product.mfg="Wiwynn" \
+ * --set product.ver="v1.1" \
+ * --set product.serial="123456" \
+ * --set product.atag="PLACEHOLDER" \
+ * --set product.custom="Yosemite V4 T1" \
+ * --set product.custom.1="Yosemite V4 T1" \
+ * --set text:product.pn="PN-345" \
+ * fru-yv4-sentineldome-board.bin
+ */
+/* product.cust maps to PRODUCT_INFO_AM2 */
+/* EM Config: yosemite4_sentineldome_t1.json */
+/* Yosemite4 Sentinel Dome without Retimer Boards */
+static const uint8_t fru_yv4_sentineldome_board_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x09, 0x00, 0x00, 0xf5, 0x01, 0x08, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xdd, 0x53, 0x65,
+  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x20,
+  0x77, 0x69, 0x74, 0x68, 0x6f, 0x75, 0x74, 0x20, 0x52, 0x65, 0x74, 0x69,
+  0x6d, 0x65, 0x72, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52,
+  0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0x78,
+  0x01, 0x09, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59,
+  0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50,
+  0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91,
+  0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64,
+  0x29, 0x03, 0xc0, 0xce, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65,
+  0x20, 0x56, 0x34, 0x20, 0x54, 0x31, 0xc1, 0x00, 0x00, 0x00, 0x00, 0xeb
+};
+static const size_t fru_yv4_sentineldome_board_bin_len =
+    sizeof(fru_yv4_sentineldome_board_bin);
+
+/*
+ *./frugen -s board.mfg="Wiwynn" \
+ * --set board.pname="Sentinel Dome" \
+ * --set text:board.pn="BRD-PN-345" \
+ * --board-date "10/1/2017 12:58:00" \
+ * --set board.serial="123456" \
+ * --set product.pname="Yosemite V4" \
+ * --set product.mfg="Wiwynn" \
+ * --set product.ver="v1.1" \
+ * --set product.serial="123456" \
+ * --set product.atag="PLACEHOLDER" \
+ * --set text:product.pn="PN-345" \
+ * fru-yv4-sentineldome-chassis.bin
+ */
+/* EM Config: yosemite4_sentineldome_chassis.json */
+/* Yosemite 4 Sentinel Dome Chassis FRU */
+static const uint8_t fru_yv4_sentineldome_chassis_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcd, 0x53, 0x65,
+  0x6e, 0x74, 0x69, 0x6e, 0x65, 0x6c, 0x20, 0x44, 0x6f, 0x6d, 0x65, 0x85,
+  0x91, 0x34, 0x51, 0x95, 0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e,
+  0x2d, 0x33, 0x34, 0x35, 0xc0, 0xc1, 0x00, 0xb6, 0x01, 0x07, 0x19, 0xc6,
+  0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d,
+  0x69, 0x74, 0x65, 0x20, 0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34,
+  0x35, 0xc4, 0x76, 0x31, 0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05,
+  0x89, 0x30, 0x1b, 0x8e, 0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1,
+  0x00, 0x00, 0x00, 0x59
+};
+static const size_t fru_yv4_sentineldome_chassis_bin_len =
+    sizeof(fru_yv4_sentineldome_chassis_bin);
+
+/*
+ *./frugen -s board.mfg="Wiwynn" \
+ * --set board.pname="Management Board wBMC" \
+ * --set text:board.pn="BRD-PN-345" \
+ * --board-date "10/1/2017 12:58:00" \
+ * --set board.serial="123456" \
+ * --set product.pname="Yosemite V4" \
+ * --set product.mfg="Wiwynn" \
+ * --set product.ver="v1.1" \
+ * --set product.serial="123456" \
+ * --set product.atag="PLACEHOLDER" \
+ * --set text:product.pn="PN-345" \
+ * fru-yv4-eclosure.bin
+ */
+/* EM Config: yosemite4_chassis.json, yosemite4.json */
+/* Yosemite 4 Sentinel Dome Enclosure FRU */
+static const uint8_t fru_yv4_eclosure_bin[] = {
+  0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xce,
+  0xc2, 0xa8, 0xc6, 0x57, 0x69, 0x77, 0x79, 0x6e, 0x6e, 0xd5, 0x4d, 0x61,
+  0x6e, 0x61, 0x67, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x42, 0x6f, 0x61,
+  0x72, 0x64, 0x20, 0x77, 0x42, 0x4d, 0x43, 0x85, 0x91, 0x34, 0x51, 0x95,
+  0x05, 0xca, 0x42, 0x52, 0x44, 0x2d, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35,
+  0xc0, 0xc1, 0x00, 0x26, 0x01, 0x07, 0x19, 0xc6, 0x57, 0x69, 0x77, 0x79,
+  0x6e, 0x6e, 0xcb, 0x59, 0x6f, 0x73, 0x65, 0x6d, 0x69, 0x74, 0x65, 0x20,
+  0x56, 0x34, 0xc6, 0x50, 0x4e, 0x2d, 0x33, 0x34, 0x35, 0xc4, 0x76, 0x31,
+  0x2e, 0x31, 0x85, 0x91, 0x34, 0x51, 0x95, 0x05, 0x89, 0x30, 0x1b, 0x8e,
+  0x25, 0xfa, 0xb2, 0x64, 0x29, 0x03, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x59
+};
+static const size_t fru_yv4_eclosure_bin_len = sizeof(fru_yv4_eclosure_bin);
+
+/* END OF EEPROM CONTENTS */
+
+static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
+{
+    /* 2 fan boards */
+    for (int i = 0; i <= 1; i++) {
+        /* downstream bus */
+        I2CBus *bus = pca954x_i2c_get_bus(fan_mux, i);
+
+        /* ti,adc128d818 @ 0x1f    (adc) */
+        /* TODO */
+
+        /* maxim,max31790 @ 0x20   (pwm) */
+        /* TODO */
+
+        /*
+         * ti,tca6424 @ 0x22       (gpio)
+         * linux handles tca6424 with PCA953X_TYPE, same as pca9535
+         * { "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
+         * { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
+         * so we _could_ be fine here unless more than 16 gpios are used
+         */
+        i2c_slave_create_simple(bus, TYPE_PCA9535, 0x22);
+
+        /*
+         * NOTE: above works and could use for gpio presence:
+         * $ gpioget gpiochip2 2
+         * 1
+         */
+
+        /* maxim,max31790 @ 0x2f   (pwm) */
+        /* TODO */
+
+        /* maxim,max11615 @ 0x33   (adc) */
+        /* TODO */
+
+        at24c_eeprom_init_rom(
+            bus, 0x52, eepromSize,
+            fru_yv4_fanboard_bin,
+            fru_yv4_fanboard_bin_len);
+
+        /* LED blink driver / gpio expander */
+        /* nxp,pca9552 @ 0x61   (gpio) */
+        i2c_slave_create_simple(bus, TYPE_PCA9552, 0x61);
+    }
+}
+
+static void fby4_i2c_init_blade_chassis(I2CBus *bus, size_t eepromSize)
+{
+    /* Sentinel Dome Blade EEPROMS */
+
+    /* Board */
+    at24c_eeprom_init_rom(bus, 0x54, eepromSize,
+        fru_yv4_sentineldome_board_bin, fru_yv4_sentineldome_board_bin_len);
+
+    /* Chassis */
+   at24c_eeprom_init_rom(bus, 0x55, eepromSize,
+       fru_yv4_sentineldome_chassis_bin, fru_yv4_sentineldome_chassis_bin_len);
+}
+
+static void fby4_i2c_init_multiple_blade_chassis(I2CBus **i2c,
+    size_t eepromSize)
+{
+    /* there is 8 blade chassis, but we only emulate 2 for performance reason */
+    for (int bus = 1; bus <= (8 / 4); bus++) {
+        fby4_i2c_init_blade_chassis(i2c[bus], eepromSize);
+    }
+}
+
+static void fby4_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16];
+
+    for (int i = 0; i < 16; i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Enclosure (EM Config: yosemite4_chassis.json, yosemite4.json) */
+    at24c_eeprom_init_rom(i2c[1], 0x51, 128 * KiB,
+        fru_yv4_eclosure_bin, fru_yv4_eclosure_bin_len);
+
+    fby4_i2c_init_multiple_blade_chassis(i2c, 128 * KiB);
+
+    /* Yv4 fanboard connection */
+    I2CSlave *fan_mux = i2c_slave_create_simple(i2c[14], TYPE_PCA9546, 0x74);
+
+    fby4_i2c_init_fanboard(fan_mux, 128 * KiB);
+}
+
+static void aspeed_machine_fby4_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook fby4 BMC (Cortex-A7)";
+    amc->fmc_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC3_ON;
+    amc->i2c_init  = fby4_i2c_init;
+    mc->default_ram_size = FBY4_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_fby4_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("fby4-bmc"),
+        .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
+        .class_init    = aspeed_machine_fby4_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_fby4_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 80068f70bb..bb354a44ba 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -58,6 +58,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_catalina.c',
   'aspeed_ast2600_evb.c',
   'aspeed_ast2600_fby35.c',
+  'aspeed_ast2600_fby4.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
-- 
2.54.0


