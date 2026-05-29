Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406DDCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwZO-000112-NP; Fri, 29 May 2026 08:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYw-0000xn-Bv
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wSwYs-0004j5-T1
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:43:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so1178468f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1780058616; x=1780663416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhogzhFO7uDRTLBEbud3mZouqlv1sTkvv/Oi6WwVzrM=;
 b=KFsjwUgqo7HWCNY50FblVmdqvH3Nr+v+eivO2hqc8MMk1gFhBhVuSZMIY6jkCJYTQQ
 qnDVjIa3CCsXdF6jFvbco2njj80fqcVoubsITW78dG5witSDXvIk3xakzPPz2ld42SWu
 AiN4h0zaNq8+P1DRQ0f61c+CKJAe1UIt1tBQPieARCKuDQXCatDNJeYpbq880FYWsmMA
 +67tKvZTr/JKpVpuQyXdIerfhUd1wjWN2QGZ4NGoiwxCdxe/Yb0R++pA54hDK03XX7nD
 RR3iCc5N1eBVzE2xcg+PON4JRLrruTJ76wY+qlm8Sl0XkY72ranVdHzhkUR9I/8NnqGS
 Oriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780058616; x=1780663416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZhogzhFO7uDRTLBEbud3mZouqlv1sTkvv/Oi6WwVzrM=;
 b=U6BFQgdn7sYNfhUJHO+oeqbZHnqgtHJbg7vN/cwJEdEWMxiDFchOwf2P/6dQb55p1v
 sxsls55BVRZ4Q+1CDdi0qemYs7M8mG/lCqzyocD55ikMUOiWS9siWpyqmEA6CjDHxwK2
 2PsDN9vcmrHZbedkJaKIgnMpgrezXOHdIXAQEjz1uWpxvr4SVGtgssAK042PspMmzAnd
 xs+EboV4bw7Xfx+DEWKOwkN/ZcYN57gYFK6Zn8Lo4Iy0PL0NWfrouWUPMGUlYUQD9Nvc
 Io2zw8HMRHkDsmEQqMr5FWMRQkvRlZiH0MqSxG3BN0tXxS9AQPhRQvebT0Hi+A2lpB3+
 fIzA==
X-Gm-Message-State: AOJu0Yw/ZaiUlXu1SnY9V3DzaNkVf9F4OlO3bg4FkJtdcsKWViYCGR1j
 HhKZk3lKEQblwL+XY9F1OY0jXdS0izQ16Lz9Eb1izixsZseVFEZiTwfkEg88nNUkwgKiUlao1es
 2vlvYf6c=
X-Gm-Gg: Acq92OFqhRzuKtgWSxMxpClbonQcTTZMEzPRY6iq7+yq/sMtOxW4dXPKqWgnDVtAERY
 4h8r9OXthzNlFtKejACCGT3MfsjTsFlSQUC4dQy0krRufE43Q9H7SXN7n3xWL+H2d+cSQR4Dbl7
 t8erQHMHuBYd34LJTvOfFzZuV5l9N4ctLapfm89wB+4qXBNvQxBDENAHbs6n6C8mcri/RdkZqCZ
 1w9lRB9DbBN3/Jq7ppwXuR33ZwEAxUtllLVHC2WNUEwOE/scNlSmSZj4ETSzRpNipKyuBJNCUtL
 K/CwTxuQZTV7JQTG84v3r0n+jkRMHRYdo1U1mLF3sbK04DaTfIzIknxQIxSx9Vk/UbpLO3PAMWI
 /mvoIMMV9nj6T3rPbnjJCIYRl/lL3A0U1nCxgZNKg+vqd2LT/3fGjMh+LVIWQ21aN8QwOHJqsR7
 LLJO56wqCuUgRoeqttLwuew3XGUd4N6qMpkgtLoj3hw+RhC2VXFd1t5Mw=
X-Received: by 2002:a05:6000:41ec:b0:45e:ce28:666a with SMTP id
 ffacd0b85a97d-45ef140196fmr5051697f8f.1.1780058615755; 
 Fri, 29 May 2026 05:43:35 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm3163354f8f.27.2026.05.29.05.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:43:35 -0700 (PDT)
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
Subject: [PATCH v5 2/5] ast2600: yosemite4 functional test
Date: Fri, 29 May 2026 14:37:31 +0200
Message-ID: <20260529124237.94087-3-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529124237.94087-1-alexander.hansen@9elements.com>
References: <20260529124237.94087-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x434.google.com
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

Add a functional test for the Yosemite V4 (fby4-bmc) machine
that validates:
- U-Boot initialization and kernel boot sequence

The test uses an OpenBMC image built for the yosemite4 board and
validates console output through the boot process.

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
 tests/functional/arm/meson.build         |  2 ++
 tests/functional/arm/test_aspeed_fby4.py | 45 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..19331b3f16 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -15,6 +15,7 @@ test_arm_timeouts = {
   'aspeed_anacapa' : 480,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
+  'aspeed_fby4': 480,
   'aspeed_gb200nvl_bmc' : 480,
   'aspeed_rainier' : 480,
   'bpim2u' : 500,
@@ -50,6 +51,7 @@ tests_arm_system_thorough = [
   'aspeed_anacapa',
   'aspeed_bletchley',
   'aspeed_catalina',
+  'aspeed_fby4',
   'aspeed_gb200nvl_bmc',
   'aspeed_rainier',
   'bpim2u',
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
new file mode 100755
index 0000000000..a521834f79
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from qemu_test import wait_for_console_pattern
+from aspeed import AspeedTest
+
+
+class YosemiteV4Machine(AspeedTest):
+
+    ASSET_YOSEMITE_V4_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
+        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')
+
+    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
+                                   cpu_id, soc):
+
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
+                         '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern(f'U-Boot {uboot}')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
+        self.wait_for_console_pattern(f'ASPEED {soc}')
+        self.wait_for_console_pattern('/init as init process')
+        # yosemite v4 does not emit the hostname log which is
+        # different from the other machines.
+        self.wait_for_console_pattern('yosemite4 login:')
+
+    def test_arm_ast2600_yosemitev4_openbmc(self):
+        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
+
+        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3')
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.54.0


