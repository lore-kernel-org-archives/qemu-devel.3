Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5F9C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQD-0004ax-91; Thu, 27 Aug 2026 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ8-0004ZR-W5; Thu, 27 Aug 2026 11:53:41 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ6-0003sl-Tw; Thu, 27 Aug 2026 11:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Gc6bSuw
 u55wVek3mTDpXK//zRneqEF1P6dwYFnv/IYt7WEaKTjmnA2mkVxPYVWtWaxZirg8U7MToq
 wXBZ6BS5X9464FNIBL0HGiqKFsYerDe0dDjj8Nrn4OU7YPbaP7ey9G9SCDra51Hzv5XgGr
 j2Lt7x0thKJgf5fl9jRiHpYGbaanTsMbmQGcDAJkHDkmtZVKkBVnlWvOBZZwie3BnKsPXa
 BGSN1Fy31xc4rwOF2wHqTOr6hbt5mUx/hay5iBntNP6hnyYhckvTUzsTTzA5LtdSsVzC4F
 +FFEK+fBAFjJKQOeLesFqBIuOZY4y8aTWvBVAG2A2Lpkd6YoFb/bCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=q
 A437rlrS/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ran/cS+NIAjxNW38ojOapW4vxmLS2WzmGWD7FWorW9ActyIsTXN8xCNFLVMIkM9ltkHF
 Sr6rTzc+QVMcPjehEfeanfVMF4iFGTn+7b2tVH0oI7mtmE8T6VP4UCJ+KGhom/+eWoyg1B
 F8b5tUugnNctZuKMHh47QT/uyMP10Jdm38nzg5VsZB5VmnYKvfzv6GyTb4MEmJa7+oKtJ7
 gtvBc0trzHp0cyYAv6SL30gQ0YpBTv0Wu4ORJRHo/uaVOD0oAcFap3tliKUZnBnlIpiL0t
 1MBDVXwpP5kPj1/imofUfGmfSqHdgm+y78hCWMPLR3wAL9mH7AXZggiV8Rg8liwA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=H++z03si; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=MbAo15KT;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=qA437rlr
 S/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=H++z03sildV+ViLJ9gZkF2EXYR/Se+urITZ
 TmxqBqvIe5D3heGhjVRmz+N3KD+h7bylTSZGN1fcita/DgNmqXmhZaHOE4kmtkOxQSR2SN
 NhBFSWA1unyns56iaw2/gp+/G955isLtgtrc+rTjcNLFWkCER5KImd3azHrPV/JXmYt7Kr
 wzVKbPpxwZe4V2VudaKkfEH4hb0WpvSNcPLEZgmaiGFQ6Eps1Mc4i19RasIB1/n4UX4Hm5
 JI3kbbs8WFpLfYii77jVgjzJwlkNjARF+IjSIJsF0JDq/aadXrZbtWIMm+HDnpmREmeFWz
 36xNVPAaL+JTemoIjNrlLWYo83w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=qA437rlrS/eneymJ21yfTMArrIp3PE7bMGZ/YzrWPHc=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=MbAo15KTXrEpyv1baC
 5hmPXIB/ZYgwe/wFiJXJx1CnycvQv1ZT6+B+IgXIbw91D561K+o9rt3l77kPqAlXIqDQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id edf47d46
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:36 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id dfe28259;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 5/5] tests/functional: Boot OpenBSD on mac99
Date: Thu, 27 Aug 2026 17:50:38 +0200
Message-ID: <20260827155310.7223-6-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
References: <20260827155310.7223-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD device discovery exercises CTPR masking, zero decrementer
writes, and CUDA reply timing and layout; regressions in any of these
paths stall the guest before the installer starts.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 tests/functional/ppc/meson.build     |  2 ++
 tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/functional/ppc/test_openbsd.py

diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
index ae061fe5a6..1055cdaa17 100644
--- a/tests/functional/ppc/meson.build
+++ b/tests/functional/ppc/meson.build
@@ -2,6 +2,7 @@
 
 test_ppc_timeouts = {
   '40p' : 240,
+  'openbsd' : 240,
 }
 
 tests_ppc_system_quick = [
@@ -15,6 +16,7 @@ tests_ppc_system_thorough = [
   'bamboo',
   'mac',
   'mpc8544ds',
+  'openbsd',
   'ppe42',
   'replay',
   'sam460ex',
diff --git a/tests/functional/ppc/test_openbsd.py b/tests/functional/ppc/test_openbsd.py
new file mode 100755
index 0000000000..cf45930a7c
--- /dev/null
+++ b/tests/functional/ppc/test_openbsd.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Test that OpenBSD boots on mac99 and reaches the installer.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class OpenBSDMac99(QemuSystemTest):
+
+    ASSET_CD = Asset(
+        'https://ftp.eu.openbsd.org/pub/OpenBSD/7.9/macppc/cd79.iso',
+        '227fef3d5089d56ce8376d8bfa28181ce5b19f0eceef0a6d82d58d8e52832b24')
+
+    def test_openbsd_79_installer(self):
+        self.set_machine('mac99')
+        self.require_accelerator('tcg')
+        cdrom_path = self.ASSET_CD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'via=cuda,graphics=off,usb=off',
+                         '-cpu', '7400',
+                         '-accel', 'tcg,thread=single',
+                         '-smp', '1',
+                         '-m', '2g',
+                         '-nic', 'none',
+                         '-device', 'VGA',
+                         '-global', 'cuda.sr-delay-ns=0',
+                         '-prom-env', 'input-device=ttya',
+                         '-prom-env', 'output-device=ttya',
+                         '-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
+        wait_for_console_pattern(
+            self,
+            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
+            'panic:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.55.0


