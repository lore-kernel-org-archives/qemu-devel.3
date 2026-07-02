Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BA2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKXu-00039u-CH; Thu, 02 Jul 2026 12:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXr-00037N-Cl; Thu, 02 Jul 2026 12:45:48 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXo-0003VU-AW; Thu, 02 Jul 2026 12:45:45 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0BD552003D0;
 Thu,  2 Jul 2026 18:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783010743;
 bh=EUeKINjg7CGBQX2Etv44obZlaiZ6I+u6rrG2JIcxyVg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Awi375iBdMzpDIsQSEzxcttctfH9zC6rRUUyjh56CBfvc1X3GksDPCJvPMVAsDw2Y
 2b5+Yde3XS/OmPb4DCmXhacSODJIsIf0Tak3auMNrKiNxf+dcGS56ALNYVNYLwgeG4
 9+Wd5sGu0agsL/RIotqvjhO21QFlGnyAFv4nLyvZN3hoWnXUtayioONeOMTjC/zwn/
 uHxAxAOWLF9Q0yaxy8jbUL5jEpPqh6E2aNAcv5Lx0VVEbMyPtdL9spa0YZPM7kmr6I
 Kbhrsh6LE8sLtX8CuW/e5DiPPALAwqrh4ji+7hSc5/7hkDMxJeUcBSiEBM+yMzds3g
 1MIidGG7eez7A==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 02 Jul 2026 18:44:31 +0200
Subject: [PATCH 4/4] tests/functional: arm: add SanMiguel BMC boot test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sanmiguel-bmc-v1-4-b176b840aee3@free.fr>
References: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
In-Reply-To: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010682; l=2157;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=EUeKINjg7CGBQX2Etv44obZlaiZ6I+u6rrG2JIcxyVg=;
 b=aPBadd20+BiCAQGGoXlX/em4teKtc9Ye9THUKI03G/7s6hHqtCSw2uHtJ8tQ8tWe0Ga2rU7at
 oCIPnN+q0LFCaxBwyHlD+0qtPn3QPI6P2Bs5YHt66bm1Wwu27ebMB29
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

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/meson.build              |  2 ++
 tests/functional/arm/test_aspeed_sanmiguel.py | 33 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..68e75b7ea1 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -17,6 +17,7 @@ test_arm_timeouts = {
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
   'aspeed_rainier' : 480,
+  'aspeed_sanmiguel' : 480,
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
@@ -52,6 +53,7 @@ tests_arm_system_thorough = [
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
   'aspeed_rainier',
+  'aspeed_sanmiguel',
   'bpim2u',
   'canona1100',
   'collie',
diff --git a/tests/functional/arm/test_aspeed_sanmiguel.py b/tests/functional/arm/test_aspeed_sanmiguel.py
new file mode 100644
index 0000000000..6409d12341
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_sanmiguel.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the SanMiguel BMC machine
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import FacebookAspeedTest
+
+
+class SanMiguelMachine(FacebookAspeedTest):
+
+    ASSET_SANMIGUEL_FLASH = Asset(
+        "https://github.com/eblot/qemu-aspeed-boot/raw/refs/heads/sanmiguel-bmc/images/sanmiguel-bmc/"
+            "openbmc-20260616025450/obmc-phosphor-image-sanmiguel-20260616025450.static.mtd.xz",
+        "f0b79a09cd861d79919facc16af1dbdc85a3df55b06dd62ba0318a01580d447b",
+    )
+
+    def test_arm_ast2600_sanmiguel_openbmc(self):
+        image_path = self.uncompress(self.ASSET_SANMIGUEL_FLASH)
+
+        self.do_test_arm_aspeed_openbmc(
+            "sanmiguel-bmc",
+            image=image_path,
+            uboot="2019.04",
+            cpu_id="0xf00",
+            soc="AST2600 rev A3",
+            dt_model="Facebook SanMiguel BMC",
+        )
+
+
+if __name__ == "__main__":
+    FacebookAspeedTest.main()

-- 
2.50.1


