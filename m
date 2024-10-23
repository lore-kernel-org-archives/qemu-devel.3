Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D3FD2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 05:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Tl9-0005ZL-4p; Wed, 23 Oct 2024 01:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Tl6-0005ZD-V3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 01:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Tl3-0001f1-RY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 01:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729660687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFfRyhkIyZoadExmEh7v3ltcHOjFFFy96Lccf4CQTWs=;
 b=SeysRFuLqeoJVq9hrb3qMC4niCBWJypzZ7c7XPeJALRZER4IJy+vcnBP7F3WI4N0cKaoat
 WgIO7VNgIZN9xaj7m638dSoaa8Dq6BQGiwrnER7QmRmjnl4suhJK1sd3/dG+e1bNuPNGiQ
 kHO70j56yNIQBu5IMt68zrCtJ/CE3TQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-PHS7uIfFPPeVQjWbmXurtg-1; Wed,
 23 Oct 2024 01:18:03 -0400
X-MC-Unique: PHS7uIfFPPeVQjWbmXurtg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FE321956088; Wed, 23 Oct 2024 05:18:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25DD21956046; Wed, 23 Oct 2024 05:17:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/functional: Convert the tcg_plugins test
Date: Wed, 23 Oct 2024 07:17:54 +0200
Message-ID: <20241023051754.813412-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A straight forward conversion, only the usual changes were required
here (i.e. adjustment for asset downloading, machine selection).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 .../test_aarch64_tcg_plugins.py}              | 37 ++++++++-----------
 2 files changed, 16 insertions(+), 23 deletions(-)
 rename tests/{avocado/tcg_plugins.py => functional/test_aarch64_tcg_plugins.py} (78%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index ad59e67d67..5115199f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3716,7 +3716,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/tcg/plugins/
-F: tests/avocado/tcg_plugins.py
+F: tests/functional/test_aarch64_tcg_plugins.py
 F: contrib/plugins/
 
 AArch64 TCG target
diff --git a/tests/avocado/tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
old mode 100644
new mode 100755
similarity index 78%
rename from tests/avocado/tcg_plugins.py
rename to tests/functional/test_aarch64_tcg_plugins.py
index a6ff457e27..01660eb090
--- a/tests/avocado/tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # TCG Plugins tests
 #
 # These are a little more involved than the basic tests run by check-tcg.
@@ -13,7 +15,7 @@
 import mmap
 import re
 
-from boot_linux_console import LinuxKernelTest
+from qemu_test import LinuxKernelTest, Asset
 
 
 class PluginKernelBase(LinuxKernelTest):
@@ -53,22 +55,14 @@ def run_vm(self, kernel_path, kernel_command_line,
 
 class PluginKernelNormal(PluginKernelBase):
 
-    def _grab_aarch64_kernel(self):
-        kernel_url = ('https://storage.tuxboot.com/20230331/arm64/Image')
-        kernel_sha256 = 'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7'
-        kernel_path = self.fetch_asset(kernel_url,
-                                       asset_hash=kernel_sha256,
-                                       algorithm = "sha256")
-        return kernel_path
+    ASSET_KERNEL = Asset(
+        ('https://storage.tuxboot.com/20230331/arm64/Image'),
+        'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
 
     def test_aarch64_virt_insn(self):
-        """
-        :avocado: tags=accel:tcg
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:cortex-a53
-        """
-        kernel_path = self._grab_aarch64_kernel()
+        self.set_machine('virt')
+        self.cpu='cortex-a53'
+        kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
         console_pattern = 'Kernel panic - not syncing: VFS:'
@@ -92,13 +86,9 @@ def test_aarch64_virt_insn(self):
 
 
     def test_aarch64_virt_insn_icount(self):
-        """
-        :avocado: tags=accel:tcg
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:cortex-a53
-        """
-        kernel_path = self._grab_aarch64_kernel()
+        self.set_machine('virt')
+        self.cpu='cortex-a53'
+        kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
         console_pattern = 'Kernel panic - not syncing: VFS:'
@@ -120,3 +110,6 @@ def test_aarch64_virt_insn_icount(self):
             else:
                 count = int(m.group("count"))
                 self.log.info(f"Counted: {count} instructions")
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.0


