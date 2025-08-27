Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED0BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB14-0005nn-79; Wed, 27 Aug 2025 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB10-0005jM-5q
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0t-00023Z-Ag
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4utTOPUhgszeNK5WdCxlTW49pYy5GMu2gr5oD1CdlX8=;
 b=TjEPGh/9W9ZZbAJNsTMaV/WInf0O9AMrx5sN0rZa9B+RaY2qiSy+XO4P5uoFSsEKxoRZnF
 jomQvsR7ETn4Q/N5PJx/72kEYxRhwKGvXI9iMcF4K2cMYVJd/XBWnFIhea4U/pcB4poGLx
 uouyVH7h1YbXjoumGq5dHU9U0bA415Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-lNyWQHr7NU-Ql5C1avRmzw-1; Wed,
 27 Aug 2025 03:56:03 -0400
X-MC-Unique: lNyWQHr7NU-Ql5C1avRmzw-1
X-Mimecast-MFC-AGG-ID: lNyWQHr7NU-Ql5C1avRmzw_1756281362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0023B18002C2; Wed, 27 Aug 2025 07:56:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D7AB1977687; Wed, 27 Aug 2025 07:55:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/31] tests/functional: Move mips tests into target-specific
 folders
Date: Wed, 27 Aug 2025 09:54:29 +0200
Message-ID: <20250827075443.559712-20-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The tests/functional folder has become quite crowded, thus move the
mips tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-15-thuth@redhat.com>
---
 MAINTAINERS                                   |  8 ++--
 tests/functional/meson.build                  | 47 ++-----------------
 tests/functional/mips/meson.build             | 11 +++++
 .../test_malta.py}                            |  0
 .../test_replay.py}                           |  0
 .../test_tuxrun.py}                           |  0
 tests/functional/mips64/meson.build           | 10 ++++
 .../test_malta.py}                            |  2 +-
 .../test_tuxrun.py}                           |  0
 tests/functional/mips64el/meson.build         | 14 ++++++
 .../test_fuloong2e.py}                        |  0
 .../test_loongson3v.py}                       |  0
 .../test_malta.py}                            |  4 +-
 .../test_replay.py}                           |  0
 .../test_tuxrun.py}                           |  0
 tests/functional/mipsel/meson.build           | 12 +++++
 .../test_malta.py}                            |  2 +-
 .../test_replay.py}                           |  0
 .../test_tuxrun.py}                           |  0
 19 files changed, 59 insertions(+), 51 deletions(-)
 create mode 100644 tests/functional/mips/meson.build
 rename tests/functional/{test_mips_malta.py => mips/test_malta.py} (100%)
 rename tests/functional/{test_mips_replay.py => mips/test_replay.py} (100%)
 rename tests/functional/{test_mips_tuxrun.py => mips/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mips64/meson.build
 rename tests/functional/{test_mips64_malta.py => mips64/test_malta.py} (96%)
 rename tests/functional/{test_mips64_tuxrun.py => mips64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mips64el/meson.build
 rename tests/functional/{test_mips64el_fuloong2e.py => mips64el/test_fuloong2e.py} (100%)
 rename tests/functional/{test_mips64el_loongson3v.py => mips64el/test_loongson3v.py} (100%)
 rename tests/functional/{test_mips64el_malta.py => mips64el/test_malta.py} (98%)
 rename tests/functional/{test_mips64el_replay.py => mips64el/test_replay.py} (100%)
 rename tests/functional/{test_mips64el_tuxrun.py => mips64el/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mipsel/meson.build
 rename tests/functional/{test_mipsel_malta.py => mipsel/test_malta.py} (98%)
 rename tests/functional/{test_mipsel_replay.py => mipsel/test_replay.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_mipsel_tuxrun.py => mipsel/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6a835777bb..b8f0ce33605 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1406,8 +1406,8 @@ F: hw/acpi/piix4.c
 F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
-F: tests/functional/test_mips*_malta.py
-F: tests/functional/test_mips*_tuxrun.py
+F: tests/functional/mips*/test_malta.py
+F: tests/functional/mips*/test_tuxrun.py
 
 Mipssim
 R: Aleksandar Rikalo <arikalo@gmail.com>
@@ -1423,7 +1423,7 @@ S: Odd Fixes
 F: hw/mips/fuloong2e.c
 F: hw/pci-host/bonito.c
 F: include/hw/pci-host/bonito.h
-F: tests/functional/test_mips64el_fuloong2e.py
+F: tests/functional/mips64el/test_fuloong2e.py
 
 Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
@@ -1438,7 +1438,7 @@ F: hw/mips/loongson3_virt.c
 F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
-F: tests/functional/test_mips64el_loongson3v.py
+F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
 M: Paul Burton <paulburton@kernel.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index fee68056145..52969a3ff87 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -19,24 +19,10 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('microblaze')
 subdir('microblazeel')
-
-test_mips_timeouts = {
-  'mips_malta' : 480,
-}
-
-test_mipsel_timeouts = {
-  'mipsel_malta' : 420,
-  'mipsel_replay' : 480,
-}
-
-test_mips64_timeouts = {
-  'mips64_malta' : 240,
-}
-
-test_mips64el_timeouts = {
-  'mips64el_malta' : 420,
-  'mips64el_replay' : 180,
-}
+subdir('mips')
+subdir('mipsel')
+subdir('mips64')
+subdir('mips64el')
 
 test_ppc_timeouts = {
   'ppc_40p' : 240,
@@ -84,31 +70,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_mips_system_thorough = [
-  'mips_malta',
-  'mips_replay',
-  'mips_tuxrun',
-]
-
-tests_mipsel_system_thorough = [
-  'mipsel_malta',
-  'mipsel_replay',
-  'mipsel_tuxrun',
-]
-
-tests_mips64_system_thorough = [
-  'mips64_malta',
-  'mips64_tuxrun',
-]
-
-tests_mips64el_system_thorough = [
-  'mips64el_fuloong2e',
-  'mips64el_loongson3v',
-  'mips64el_malta',
-  'mips64el_replay',
-  'mips64el_tuxrun',
-]
-
 tests_or1k_system_thorough = [
   'or1k_replay',
   'or1k_sim',
diff --git a/tests/functional/mips/meson.build b/tests/functional/mips/meson.build
new file mode 100644
index 00000000000..49aaf53b02d
--- /dev/null
+++ b/tests/functional/mips/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_mips_timeouts = {
+  'malta' : 480,
+}
+
+tests_mips_system_thorough = [
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/mips/test_malta.py
similarity index 100%
rename from tests/functional/test_mips_malta.py
rename to tests/functional/mips/test_malta.py
diff --git a/tests/functional/test_mips_replay.py b/tests/functional/mips/test_replay.py
similarity index 100%
rename from tests/functional/test_mips_replay.py
rename to tests/functional/mips/test_replay.py
diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/mips/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips_tuxrun.py
rename to tests/functional/mips/test_tuxrun.py
diff --git a/tests/functional/mips64/meson.build b/tests/functional/mips64/meson.build
new file mode 100644
index 00000000000..3ff21189879
--- /dev/null
+++ b/tests/functional/mips64/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_mips64_timeouts = {
+  'malta' : 240,
+}
+
+tests_mips64_system_thorough = [
+  'malta',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips64_malta.py b/tests/functional/mips64/test_malta.py
similarity index 96%
rename from tests/functional/test_mips64_malta.py
rename to tests/functional/mips64/test_malta.py
index 53c3e0c1221..a553d3c5bc7 100755
--- a/tests/functional/test_mips64_malta.py
+++ b/tests/functional/mips64/test_malta.py
@@ -5,7 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/mips64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips64_tuxrun.py
rename to tests/functional/mips64/test_tuxrun.py
diff --git a/tests/functional/mips64el/meson.build b/tests/functional/mips64el/meson.build
new file mode 100644
index 00000000000..69ec50174c4
--- /dev/null
+++ b/tests/functional/mips64el/meson.build
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_mips64el_timeouts = {
+  'malta' : 420,
+  'replay' : 180,
+}
+
+tests_mips64el_system_thorough = [
+  'fuloong2e',
+  'loongson3v',
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/mips64el/test_fuloong2e.py
similarity index 100%
rename from tests/functional/test_mips64el_fuloong2e.py
rename to tests/functional/mips64el/test_fuloong2e.py
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/mips64el/test_loongson3v.py
similarity index 100%
rename from tests/functional/test_mips64el_loongson3v.py
rename to tests/functional/mips64el/test_loongson3v.py
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/mips64el/test_malta.py
similarity index 98%
rename from tests/functional/test_mips64el_malta.py
rename to tests/functional/mips64el/test_malta.py
index 3cc79b74c18..8fdc49b3005 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -16,7 +16,7 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
 
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -191,7 +191,7 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
-from test_mipsel_malta import MaltaMachineYAMON
+from mipsel.test_malta import MaltaMachineYAMON
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
diff --git a/tests/functional/test_mips64el_replay.py b/tests/functional/mips64el/test_replay.py
similarity index 100%
rename from tests/functional/test_mips64el_replay.py
rename to tests/functional/mips64el/test_replay.py
diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/mips64el/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips64el_tuxrun.py
rename to tests/functional/mips64el/test_tuxrun.py
diff --git a/tests/functional/mipsel/meson.build b/tests/functional/mipsel/meson.build
new file mode 100644
index 00000000000..8bfdf0649b5
--- /dev/null
+++ b/tests/functional/mipsel/meson.build
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_mipsel_timeouts = {
+  'malta' : 420,
+  'replay' : 480,
+}
+
+tests_mipsel_system_thorough = [
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/mipsel/test_malta.py
similarity index 98%
rename from tests/functional/test_mipsel_malta.py
rename to tests/functional/mipsel/test_malta.py
index 9ee2884da8e..427e163d19d 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/mipsel/test_malta.py
@@ -13,7 +13,7 @@
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
 
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/mipsel/test_replay.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_mipsel_replay.py
rename to tests/functional/mipsel/test_replay.py
diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/mipsel/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mipsel_tuxrun.py
rename to tests/functional/mipsel/test_tuxrun.py
-- 
2.50.1


