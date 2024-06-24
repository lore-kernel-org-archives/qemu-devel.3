Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10476C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjWx-0001K7-Iv; Mon, 24 Jun 2024 09:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sLjWs-0001Hy-Jx; Mon, 24 Jun 2024 09:14:42 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sLjWq-0004sX-Bg; Mon, 24 Jun 2024 09:14:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 6E4C9261A9A;
 Mon, 24 Jun 2024 15:14:36 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id uWWOjACehWCi; Mon, 24 Jun 2024 15:14:34 +0200 (CEST)
Received: from applejack.lan (83.11.22.244.ipv4.supernova.orange.pl
 [83.11.22.244])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 722FF261A90;
 Mon, 24 Jun 2024 15:14:33 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Mon, 24 Jun 2024 15:14:22 +0200
Subject: [PATCH v2 1/2] tests/avocado: sbsa-ref: switch from OpenBSD to FreeBSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240624-b4-move-to-freebsd-v2-1-64ea7b04998f@linaro.org>
References: <20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org>
In-Reply-To: <20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
so we can stay on 14.x for longer.

Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.

Timeout messages expanded to mention being affected by PAuth emulation:

test_sbsaref_alpine_linux_cortex_a57: PASS (24.00 s)
test_sbsaref_alpine_linux_neoverse_n2: PASS (82.24 s)
test_sbsaref_alpine_linux_max: PASS (81.10 s)
test_sbsaref_alpine_linux_max_pauth_off: PASS (23.54 s)
test_sbsaref_alpine_linux_max_pauth_impdef: PASS (28.96 s)

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 53 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 6bb82f2a03..d52f89f756 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -1,4 +1,4 @@
-# Functional test that boots a Linux kernel and checks the console
+# Functional test that boots a kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
 # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -165,7 +165,8 @@ def test_sbsaref_alpine_linux_max_pauth_impdef(self):
         """
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
@@ -177,14 +178,15 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu):
+    def boot_freebsd(self, cpu):
         self.fetch_firmware()
 
         img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
+            "https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/"
+            "14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso"
         )
 
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
+        img_hash = "44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461"
         img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
 
         self.vm.set_console()
@@ -196,43 +198,42 @@ def boot_openbsd73(self, cpu):
         )
 
         self.vm.launch()
-        wait_for_console_pattern(self,
-                                 "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
+        wait_for_console_pattern(self, "Welcome to FreeBSD!")
 
-    def test_sbsaref_openbsd73_cortex_a57(self):
+    def test_sbsaref_freebsd_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("cortex-a57")
+        self.boot_freebsd("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
+    # We use Neoverse-N2 as default cpu
+    def test_sbsaref_freebsd_neoverse_n2(self):
         """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:openbsd
+        :avocado: tags=cpu:neoverse-n2
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("neoverse-n1")
+        self.boot_freebsd("neoverse-n2")
 
-    def test_sbsaref_openbsd73_max_pauth_off(self):
+    def test_sbsaref_freebsd_max_pauth_off(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth=off")
+        self.boot_freebsd("max,pauth=off")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max_pauth_impdef(self):
+    def test_sbsaref_freebsd_max_pauth_impdef(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth-impdef=on")
+        self.boot_freebsd("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max(self):
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
+    def test_sbsaref_freebsd_max(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max")
+        self.boot_freebsd("max")

-- 
2.45.2


