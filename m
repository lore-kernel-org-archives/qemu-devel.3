Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE0CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JBI-0002Zj-L4; Wed, 24 Sep 2025 02:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JB5-0002Wc-Gh
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAs-0006kF-P5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9bO/FBfh6fhBzvvDHXJehrK4hQVreAPaWELrmWUx2M=;
 b=REDHyVE9JIQnb3S7D4BlhciiHj9Cfpmxyt5Y/9SPrAJMDoiamx7z6DLVxGdBS1xy9GJvCs
 eMvJGF8Hg837Up6ULvXTRcGPTUQmQNCo3aPV/Clx3YkfIm8DzccmMomKzk6rroFd6b1fh4
 RsaCAY88/FmMyJ5+VKy4OAzJifDz7oo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-2yMavWpjMA2Ujif6iXVKFQ-1; Wed,
 24 Sep 2025 02:40:17 -0400
X-MC-Unique: 2yMavWpjMA2Ujif6iXVKFQ-1
X-Mimecast-MFC-AGG-ID: 2yMavWpjMA2Ujif6iXVKFQ_1758696016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C456E1800366; Wed, 24 Sep 2025 06:40:15 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 277DD1955F19; Wed, 24 Sep 2025 06:40:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/12] tests/functional/hppa: Add a CD-ROM boot test for
 qemu-system-hppa
Date: Wed, 24 Sep 2025 08:39:53 +0200
Message-ID: <20250924063956.519792-10-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Add a test which boots a HP-UX firmware upgrade CD-ROM. It exercise
the PCI LSI53C895A SCSI controller. The ISO image comes from:
https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/kernels/712/PF_C7120023
The test is very quick, less than 3s.

Based on an old patch from Philippe that has been posted here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg651012.html

Suggested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[thuth: Adjusted the patch to the functional framework,
        and adjusted the commit message]
Message-ID: <20250918122447.105861-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |  2 +-
 tests/functional/hppa/meson.build    |  4 +++
 tests/functional/hppa/test_cdboot.py | 38 ++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/hppa/test_cdboot.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d1f88a4bbe..24b71a4fc54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1276,7 +1276,7 @@ F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
-F: tests/functional/hppa/test_seabios.py
+F: tests/functional/hppa/
 
 LoongArch Machines
 ------------------
diff --git a/tests/functional/hppa/meson.build b/tests/functional/hppa/meson.build
index a3348370884..df2f7ccc9c3 100644
--- a/tests/functional/hppa/meson.build
+++ b/tests/functional/hppa/meson.build
@@ -3,3 +3,7 @@
 tests_hppa_system_quick = [
   'seabios',
 ]
+
+tests_hppa_system_thorough = [
+  'cdboot',
+]
diff --git a/tests/functional/hppa/test_cdboot.py b/tests/functional/hppa/test_cdboot.py
new file mode 100755
index 00000000000..84421e8d63e
--- /dev/null
+++ b/tests/functional/hppa/test_cdboot.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# CD boot test for HPPA machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class HppaCdBoot(QemuSystemTest):
+
+    ASSET_CD = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/raw/ec1b741/'
+         'hppa/hp9000/712/C7120023.frm'),
+        '32c612ad2074516986bdc27768903c561fa92af2ca48e5ac3f3359ade1c42f70')
+
+    def test_cdboot(self):
+        self.set_machine('B160L')
+        cdrom_path = self.ASSET_CD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Unrecognized MODEL TYPE = 502')
+        wait_for_console_pattern(self, 'UPDATE PAUSED>')
+
+        exec_command_and_wait_for_pattern(self, 'exit\r', 'UPDATE>')
+        exec_command_and_wait_for_pattern(self, 'ls\r', 'IMAGE1B')
+        wait_for_console_pattern(self, 'UPDATE>')
+        exec_command_and_wait_for_pattern(self, 'exit\r',
+                        'THIS UTILITY WILL NOW RESET THE SYSTEM.....')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.51.0


