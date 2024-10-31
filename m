Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198FFD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZI9-0006tJ-1w; Thu, 31 Oct 2024 13:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZI4-0006r9-Ha
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZI2-0006a4-Ta
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730396937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKgvT7QI3fvTAagcZfNbkg2ZuyHVKtMBvbBBeExmbBc=;
 b=clnUG7i6yOpFO6M853trRyOzVY4jQpzqAf6nLaAUvFcHydWySGgbxzDfcYEhZSPTYOypku
 jC2DOZ17kn84brE2kfXgmN1ARwY+aXZUyh5AYAGMhyOeFxmfjz9PGjc5QDK3jdahSTQCmQ
 v1dtO+AZ8cdvgVxENj0BaDuWmx1WED0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-TwlKqza-M-2KSR6r_Pl_uQ-1; Thu,
 31 Oct 2024 13:48:53 -0400
X-MC-Unique: TwlKqza-M-2KSR6r_Pl_uQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DE771955F54; Thu, 31 Oct 2024 17:48:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8927B300019D; Thu, 31 Oct 2024 17:48:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] tests/functional: Add a test for sh4eb
Date: Thu, 31 Oct 2024 18:48:23 +0100
Message-ID: <20241031174832.6574-6-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-1-thuth@redhat.com>
References: <20241031174832.6574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Message-ID: <20241024082735.42324-3-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build       |  3 +++
 tests/functional/test_sh4eb_r2d.py | 33 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100755 tests/functional/test_sh4eb_r2d.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 97c1c597e8..a9f1addf77 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -159,6 +159,9 @@ tests_sh4_system_thorough = [
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


