Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD44CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwZ4-0000y4-BM; Fri, 29 May 2026 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYo-0000x6-Jm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYm-0004h9-2w
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so1181050f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1780058610; x=1780663410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiatuOl2+dyGsu3brL4iC0xQDkMxt6rEepwRrvFN+Xs=;
 b=ftSPtaxA9zRa2DwoQOhdRM4Kx7WHc6y7muF89T36nqNBCGzjOFm/qaTqO4y+Y6BWiF
 V2cZ8sa7dbXvCWlvkzUrbo1IFP+8u1MnUfObFHI61b76VO3HE9lfB3/JR7aYyXpa8lVh
 x+eGucDv+4u0/O0C32D6elrm8Vj3/+0BnIlhQ/NLRCsjJqZTqm4JGy7n/lYjGl3INfT1
 yOqGPaA4Ls0e1+SpH29RCYJEkF8kw4uUvGU+pZ5Qs1dNR6kuBlfrb9fmW03cC/Mw92LC
 3SQ1g0G45QAGnAncxRhgHxdKU3MU3fwr+D7as1Zhyl2doCo4q2sKG767s5F6o1t9jkgn
 IWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058610; x=1780663410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GiatuOl2+dyGsu3brL4iC0xQDkMxt6rEepwRrvFN+Xs=;
 b=f9t9knUyHfPMgKlO/prgS3h+bwjYemJHNlTdAOGkPjNqel94HSUg77VQVOaB/mx7DJ
 sKHZPqXsPq711ZOQwConvMVXQTxaQiNDnjo+Dy7MwyYgepdm5t9+yieA7hg9ixzcVlFq
 eBdpXwg9c/audrqoiOaDONmu8MVgm87rleVuRUp4PqaeKSx/AebOSCKUuHFyd+v/e1RT
 yNy/P4dB9yW5GUC5hyHuGsGJZsVBQwRHbHMzFu3hfK1sDDza9PpjAurHxObgdQN3RFo8
 H6uWFyrA915me+1YdQg7SVcu1d4lI0105DtmUEGzwTBq82+AFaZvOdICZkmUwyHGhnI8
 IP6w==
X-Gm-Message-State: AOJu0YzsHRI2+uefSoMLMhWcChBbiPV7Grx2y7m8z6Oc3yu2VnDCVrZ4
 ly3GB5TApP1uCleWi73Bn9m3qKPPKWk6H+gf0q0rzWWFibWxODaQDBwA63Ma4PA+Up+KBtqGlwm
 yuURiCWQ=
X-Gm-Gg: Acq92OF2qVtKP3fEhUAO4UIMS/9UaB2c/wKWa7/aclusevj5mQXznCOuLQiTahvz7xX
 Ss8ybuuHvmysl+cG5F+i5mpr6NC7cyA3hTrOpod0t5IwB7gKIK/1pm51kMuJV3PV3Hs7oFKyTTS
 xrGcQ/2nyQ40I39v7UIISD4kUSRoHA84T+fLpl1zQEjTVXLPeVdXBA5Dwt2tHWq77/rm2YZdgIR
 CfXaict7NRtSEH+laMlwvg3gF9cjSOXgzQ1s2pp0Bu6/SDMWcVXBokf2Bt5VeayR7jliixJf2Cv
 YX5HDZX0LopgdoUf6eWe8AmGSmD5J8Dpodpk2c7ZMiqiW1OeYzrH377stvIZcCjRhJJsDEV30Xj
 7PxmSxanfcSL7fACEndInrW6dVdHC8jLPifdCAjVk2olFIWXOmE6dhSinn73o17WklMcpmnMTS6
 LGiTUigIYF+8Vq7LBplDullt7ocg0QSsNH0bLrK7FogK7+j0UwogJqh2o=
X-Received: by 2002:a05:6000:c04:b0:45e:651c:47bb with SMTP id
 ffacd0b85a97d-45ef144d494mr4053179f8f.28.1780058610428; 
 Fri, 29 May 2026 05:43:30 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm3163354f8f.27.2026.05.29.05.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:43:30 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 1/5] ast2600: yosemite4 initial support
Date: Fri, 29 May 2026 14:37:30 +0200
Message-ID: <20260529124237.94087-2-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529124237.94087-1-alexander.hansen@9elements.com>
References: <20260529124237.94087-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
index 68d204bb4e..30d92c3f33 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_catalina.c',
   'aspeed_ast2600_evb.c',
   'aspeed_ast2600_fby35.c',
+  'aspeed_ast2600_fby4.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
-- 
2.54.0


