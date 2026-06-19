Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1164CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXpE-0003qH-Mr; Fri, 19 Jun 2026 07:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1waXpD-0003px-L1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:55:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1waXpB-0007LL-KJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:55:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso19528375e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1781870152; x=1782474952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gazc7DoCz2maUunxSRhWfMPAB4XKEzEdNOyTzDmIFM=;
 b=FOz3msgUxi0JNmxGI53USUuKhagfbCX9WaNN6bIamFYp7A5P42Q5yca+6nX3LorMPR
 sJQfCfgZA2N86g0m6nRIM5r4Bc3pKnwFOUWIhx30nJiQ6D4AeTiCnGM4yaqzWXAsfW9v
 7Ht+GlLrDC3/38RZ9RRWHOL7URWsP8qFvSZQXvw9dSygOFmEsKhnkn74LIC1+HtupRsr
 gs1sZlnb5hgQM6WTPxhCGNSDNl/yyfRlLqYxn6JJLFAYdld2Q1jveogOG8++gnJCFfyB
 Z1t8u2jX9jHDpMyRhZxdGVrkxDEI6XQh4BBKV4HsLKUwCxbBssRd6I8ZcnY+XOf/WKGn
 geLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781870152; x=1782474952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4gazc7DoCz2maUunxSRhWfMPAB4XKEzEdNOyTzDmIFM=;
 b=tU92/4qz57dnanjFJMhBcdMAoAk6UT/KnrvUaPnlvaGNBib5oLMAU5XoRbR5QDIsOL
 J2NyYDVto0W53ZiiQGcw9o2tYjzF9oXnki9ch4n1GUG5dNMoa8r23fsY1ZtlYpZMqAAi
 yx68EF86cC3mZ39pLy62YDEBiUijt5+5mzGHTns7CV0n+DVzclbflnauucrZQq7brcqp
 i0g5NQSmWJnUgWPv0tsxjYP0p6rUvqj4Ow+JYsn3C7sMKEqz2v4FPxbsXPvvJbeq4gB9
 h3EQ/w4nKJ84BSGgcWB2uR9il1IdufWyG7ePL0s/b0s8e+W8EXhBobXVk222yjVXDxZA
 XRGQ==
X-Gm-Message-State: AOJu0YwWZHc9OANdwq70hHyjx7aW6z4QrHnt0nossU149rhIqDSOo8m3
 C2jUBaIWTPVlt8gK3/haA7H5tJa0Lqg1psN8LLwecikFShP5sISTHHKJAZkVBOLg0jEyjmd/o52
 x4mHODlI=
X-Gm-Gg: AfdE7cmNtEBI+Xxu1n5hFkM3K8lYwVc3ECX2i0uyf5OXRoc6QekAllZ1iGPtufd/cbc
 1RR7coAcfiOzgylRoH7Yu3g6XtL9QIT/tEWD9VIpjzqRkIXpy/F8iG0gqmNSDtkB5moiZbukGa6
 1wnYZHxafdTU8mOqLIRCLKr2TMiLH+ys8B8ilrdkYfuussyBp8pqOjNyHsISCJC7Um4RbCoktpq
 YSnuzFxZsgvzaPHgEN4DCXcMe6yGQQiPHpoWFjOMEmrBwSBhgPA/Xw2/WkbqPoLccV3KHj2qj5f
 kp+AzgBzX3fVOOxflfZxNfm4fY65ALO7POVpzTZpqVX5JXFm47sgUzf0tPZ9OvsGPrPYOoNzzG+
 ddfdJZpez+nIPNEKulrbCO+CFUV8VnYpo2jTKZDU4b+TxkBQHx/Gjv1ZMD4QbuF+vS2DDPbP875
 ZYA4bzXYCl6UVRy/f52J0y8j5tANtk8XPrs96VYQ==
X-Received: by 2002:a05:600c:8716:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-49240e4635emr51719175e9.14.1781870152044; 
 Fri, 19 Jun 2026 04:55:52 -0700 (PDT)
Received: from localhost.localdomain ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm64439975e9.12.2026.06.19.04.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:55:51 -0700 (PDT)
From: <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com, clg@kaod.org,
 Alexander Hansen <alexander.hansen@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 2/4] ast2600: yosemite4 functional test
Date: Fri, 19 Jun 2026 13:55:31 +0200
Message-ID: <20260619115533.5664-3-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619115533.5664-1-alexander.hansen@9elements.com>
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x32d.google.com
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

From: Alexander Hansen <alexander.hansen@9elements.com>

Add a functional test for the Yosemite V4 (fby4-bmc) machine
that validates:
- U-Boot initialization and kernel boot sequence

The test uses an OpenBMC image built for the yosemite4 board and
validates console output through the boot process.

Cc: Emmanuel Blot <eblot@meta.com>
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


