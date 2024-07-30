Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D59C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHp-00034j-HP; Tue, 30 Jul 2024 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHl-0002pD-Mc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHj-0002ia-Rn
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jp7VZEVQDYINI8Rzoc3BkcHXv41GwbuLsiOqwgH+IJo=;
 b=b/vSopID8qIGBWmafgeUKFfkq1sJRg5CBt/HOkjV4vwFWGWE0YCUbR/VDTz2uFUWlcHWCU
 q0L0dxoG0tkH2OhVtiw5JwQUDlvf18XFJR3nedRytTsslXnSNVExoM7oYx6RiHNmEPJK1y
 s8wYRsVghj1kjAyJe2QncpvZDt13Whg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-34WOQ_zFN0W0f73JxGgTqg-1; Tue,
 30 Jul 2024 13:05:11 -0400
X-MC-Unique: 34WOQ_zFN0W0f73JxGgTqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9B801955F3D; Tue, 30 Jul 2024 17:05:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DB4E300018D; Tue, 30 Jul 2024 17:05:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 19/24] tests/functional: Convert the ppc_amiga avocado test
 into a standalone test
Date: Tue, 30 Jul 2024 18:03:39 +0100
Message-ID: <20240730170347.4103919-20-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

Use the Python standard zipfile module instead of avocado.utils for
extracting the ZIP file that we download here, and use the standard
subprocess module for running the "tail" command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/ppc_amiga.py         | 38 ---------------------------
 tests/functional/meson.build       |  1 +
 tests/functional/test_ppc_amiga.py | 42 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 38 deletions(-)
 delete mode 100644 tests/avocado/ppc_amiga.py
 create mode 100755 tests/functional/test_ppc_amiga.py

diff --git a/tests/avocado/ppc_amiga.py b/tests/avocado/ppc_amiga.py
deleted file mode 100644
index b6f866f91d..0000000000
--- a/tests/avocado/ppc_amiga.py
+++ /dev/null
@@ -1,38 +0,0 @@
-# Test AmigaNG boards
-#
-# Copyright (c) 2023 BALATON Zoltan
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from avocado.utils import archive
-from avocado.utils import process
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-
-class AmigaOneMachine(QemuSystemTest):
-
-    timeout = 90
-
-    def test_ppc_amigaone(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:amigaone
-        :avocado: tags=device:articia
-        :avocado: tags=accel:tcg
-        """
-        self.require_accelerator("tcg")
-        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
-        tar_url = ('https://www.hyperion-entertainment.com/index.php/'
-                   'downloads?view=download&format=raw&file=25')
-        tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
-        zip_file = self.fetch_asset(tar_name, locations=tar_url,
-                                    asset_hash=tar_hash)
-        archive.extract(zip_file, self.workdir)
-        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
-        process.run(cmd, shell=True)
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'FLASH:')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b4f5c9e38e..fba3891e16 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -56,6 +56,7 @@ tests_ppc_quick = [
 tests_ppc_thorough = [
   'ppc_405',
   'ppc_40p',
+  'ppc_amiga',
   'ppc_bamboo',
   'ppc_mpc8544ds',
   'ppc_virtex_ml507',
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
new file mode 100755
index 0000000000..8c356e1ba7
--- /dev/null
+++ b/tests/functional/test_ppc_amiga.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+#
+# Test AmigaNG boards
+#
+# Copyright (c) 2023 BALATON Zoltan
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import subprocess
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern, run_cmd
+from zipfile import ZipFile
+
+class AmigaOneMachine(QemuSystemTest):
+
+    timeout = 90
+
+    ASSET_IMAGE = Asset(('https://www.hyperion-entertainment.com/index.php/'
+                         'downloads?view=download&format=raw&file=25'),
+                        'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755')
+
+    def test_ppc_amigaone(self):
+        self.require_accelerator("tcg")
+        self.set_machine('amigaone')
+        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
+        zip_file = self.ASSET_IMAGE.fetch()
+        with ZipFile(zip_file, 'r') as zf:
+            zf.extractall(path=self.workdir)
+        bios_fh = open(self.workdir + "/u-boot-amigaone.bin", "wb")
+        subprocess.run(['tail', '-c', '524288',
+                        self.workdir + "/floppy_edition/updater.image"],
+                        stdout=bios_fh)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'FLASH:')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


