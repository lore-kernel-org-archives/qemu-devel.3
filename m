Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B9606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+86S87K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxj1-0003LB-Hv; Tue, 24 Nov 2026 16:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVxiz-0003Ja-KA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:49 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVxix-0003hN-J3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:49 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 747A2628B4;
 Tue, 24 Nov 2026 21:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A441F000C0;
 Tue, 24 Nov 2026 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795554405;
 bh=4V+K8RA0GL1PuPEHBSfQcfKfXJEH3bGYLevnOEjU7I4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h+86S87KZ30YwVssFA/CADDHs6SWX6OFpKwxxR3hjGyGMBKZFyfKybzLAG6N71nAE
 VkK5JUnJ6rZjMEM84r7EVHLEylWDCQDFv0CD9aQloE0S4EV2M0JKhMv4uphbbEv/7x
 76brxlXrvSFbPuu0CkYu+IYcWHkxGDUFkO4CJ/j4HDR2ytz+l6tt8umNy/pMvw8aWR
 pDhcWdybsa14VsxHpWRaVojXRP00RPDNm+cX/cYhsysqh3BTejgToAkf6mxCIKnS7O
 QWtsb2kt788RU8VvzwuUD0Uwj5bcmGWl+UjM7r+ORIhE/8IrEts60WfApqHbcTZCYV
 kdw4tvxgBqivQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brad Smith <brad@comstyle.com>,
 "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 2/3] tests/functional/hppa: add OpenBSD CD-ROM boot test
 for qemu-system-hppa
Date: Tue, 24 Nov 2026 22:06:38 +0100
Message-ID: <20261124210639.133084-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124210639.133084-1-deller@kernel.org>
References: <20261124210639.133084-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Test that OpenBSD boots on a B160L and reaches the installer.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 tests/functional/hppa/meson.build     |  1 +
 tests/functional/hppa/test_openbsd.py | 37 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/functional/hppa/test_openbsd.py

diff --git a/tests/functional/hppa/meson.build b/tests/functional/hppa/meson.build
index df2f7ccc9c..d34feb69ae 100644
--- a/tests/functional/hppa/meson.build
+++ b/tests/functional/hppa/meson.build
@@ -6,4 +6,5 @@ tests_hppa_system_quick = [
 
 tests_hppa_system_thorough = [
   'cdboot',
+  'openbsd',
 ]
diff --git a/tests/functional/hppa/test_openbsd.py b/tests/functional/hppa/test_openbsd.py
new file mode 100755
index 0000000000..22ab1e655c
--- /dev/null
+++ b/tests/functional/hppa/test_openbsd.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+#
+# Test that OpenBSD boots on B160L and reaches the installer.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class OpenBSDB160L(QemuSystemTest):
+
+    ASSET_CD = Asset(
+        'https://ftp.eu.openbsd.org/pub/OpenBSD/8.0/hppa/cd80.iso',
+        '9b3971dc3d2362e5d694495f2c2e10795513b87c9bcca5666df5a2bfea071663')
+
+    def test_openbsd_80_installer(self):
+        self.set_machine('B160L')
+        self.require_accelerator('tcg')
+        cdrom_path = self.ASSET_CD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-nic', 'none',
+                         '-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'OpenBSD 8.0 (RAMDISK)', 'panic:')
+        wait_for_console_pattern(
+            self,
+            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
+            'panic:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.54.0


