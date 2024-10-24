Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61133D0BB6F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 08:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tCG-0004BJ-NA; Thu, 24 Oct 2024 04:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tCF-0004B3-17
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tCD-0000R2-II
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729758470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XziFmZ+lAwRWE/bkSVGhRiGMCujQABPJVmK1c0C+ayA=;
 b=VgbsbL482gYN0XbMdp+3gdlk9awL+46UGqhauHC41K9VjXBGFIqYuwCBPnvgqCla9J48bR
 G3eUoYjQ58sn86ua2KPX3ynVkQxKy5lHYQ7LSkspiBCwVRLBJivZiEIOnocDfuM15Gyef9
 CJKX8Zxhy1YP31x3vhihbZJ6t84UPiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-D6jJnA9aMHu4aD66tRe8Rw-1; Thu,
 24 Oct 2024 04:27:46 -0400
X-MC-Unique: D6jJnA9aMHu4aD66tRe8Rw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7B61956080; Thu, 24 Oct 2024 08:27:44 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87697195607C; Thu, 24 Oct 2024 08:27:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 2/2] tests/functional: Add a test for sh4eb
Date: Thu, 24 Oct 2024 10:27:35 +0200
Message-ID: <20241024082735.42324-3-thuth@redhat.com>
In-Reply-To: <20241024082735.42324-1-thuth@redhat.com>
References: <20241024082735.42324-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Now that we are aware of binaries that are available for sh4eb,
we should make sure that there are no regressions with this
target and test it regularly in our CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build       |  3 +++
 tests/functional/test_sh4eb_r2d.py | 33 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100755 tests/functional/test_sh4eb_r2d.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d4b675bf63..d642c11516 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -160,6 +160,9 @@ tests_sh4_system_thorough = [
   'sh4_tuxrun',
 ]
 
+tests_sh4eb_system_thorough = [
+  'sh4eb_r2d',
+]
 
 tests_sparc_system_thorough = [
   'sparc_sun4m',
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
new file mode 100755
index 0000000000..d9c022c8b8
--- /dev/null
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+#
+# Boot a Linux kernel on a r2d sh4eb machine and check the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+from unittest import skipUnless
+
+class R2dEBTest(LinuxKernelTest):
+
+    ASSET_TGZ = Asset(
+        'https://landley.net/bin/mkroot/0.8.11/sh4eb.tgz',
+        'be8c6cb5aef8406899dc5aa5e22b6aa45840eb886cdd3ced51555c10577ada2c')
+
+    def test_sh4eb_r2d(self):
+        self.set_machine('r2d')
+        file_path = self.ASSET_TGZ.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.add_args('-append', 'console=ttySC1 noiotrap')
+        self.launch_kernel(os.path.join(self.workdir, 'sh4eb/linux-kernel'),
+                           initrd=os.path.join(self.workdir, 'sh4eb/initramfs.cpio.gz'),
+                           console_index=1, wait_for='Type exit when done')
+        exec_command_and_wait_for_pattern(self, 'exit', 'Restarting system')
+        shutil.rmtree(os.path.join(self.workdir, 'sh4eb'))
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.0


