Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A0ECD484B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRP-0004FT-5d; Wed, 04 Sep 2024 06:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRN-000445-KG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRL-0000LU-HN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9lUhlwmmGx7wKs+jjceiAFrC/JioYt5A/Uj0iFNjfI=;
 b=E8tLI9Hjc+Ng0yEe8PciMLIMZBvzjfZxNoSJjfxzMgRtRMXEb0xEsrxc8mkaK/L3q5T5Ij
 Q2UAGm0SXHduF78Zw+ViYzhebwoE+fG55TtRYhyqnqOadEfXWQjTl40wfMEbG2ljcyub64
 cHA6y9IQR+QtCecxR6ularEyY36cE9k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-lzD2LAQzOnulhTccFRbq2Q-1; Wed,
 04 Sep 2024 06:40:39 -0400
X-MC-Unique: lzD2LAQzOnulhTccFRbq2Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29EDA1955F40; Wed,  4 Sep 2024 10:40:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DA83195605A; Wed,  4 Sep 2024 10:40:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/42] tests/functional: Convert the ppc_amiga avocado test
 into a standalone test
Date: Wed,  4 Sep 2024 12:39:00 +0200
Message-ID: <20240904103923.451847-26-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use the Python standard zipfile module instead of avocado.utils for
extracting the ZIP file that we download here, and use the standard
subprocess module for running the "tail" command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-27-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                        |  1 +
 tests/avocado/ppc_amiga.py         | 38 --------------------------
 tests/functional/meson.build       |  1 +
 tests/functional/test_ppc_amiga.py | 43 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 38 deletions(-)
 delete mode 100644 tests/avocado/ppc_amiga.py
 create mode 100755 tests/functional/test_ppc_amiga.py

diff --git a/MAINTAINERS b/MAINTAINERS
index cb55ead291..ee291e6d55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1596,6 +1596,7 @@ S: Maintained
 F: hw/ppc/amigaone.c
 F: hw/pci-host/articia.c
 F: include/hw/pci-host/articia.h
+F: tests/functional/test_ppc_amiga.py
 
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
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
index 38aaa03a58..f0f0cbd500 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -61,6 +61,7 @@ tests_ppc_system_quick = [
 tests_ppc_system_thorough = [
   'ppc_405',
   'ppc_40p',
+  'ppc_amiga',
   'ppc_bamboo',
   'ppc_mpc8544ds',
   'ppc_virtex_ml507',
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
new file mode 100755
index 0000000000..b793b5c432
--- /dev/null
+++ b/tests/functional/test_ppc_amiga.py
@@ -0,0 +1,43 @@
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
+    ASSET_IMAGE = Asset(
+        ('https://www.hyperion-entertainment.com/index.php/'
+         'downloads?view=download&format=raw&file=25'),
+        '8ff39330ba47d4f64de4ee8fd6809e9c010a9ef17fe51e95c3c1d53437cb481f')
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
2.46.0


