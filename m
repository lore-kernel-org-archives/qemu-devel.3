Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E936C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rLX-0000Zm-1M; Tue, 29 Apr 2025 16:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLK-0000UV-FW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:15 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLF-0001HU-2E
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:12 -0400
DKIM-Signature: a=rsa-sha256; bh=zkSu4yIS7+YQyZiHy8m5iK9pPqaKovZJQ0CeGa5pW1k=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1745957643; v=1;
 b=e9bBj4LLp6QVvxoa2FO+EH64ujJfulS3flz7WZJ47nOUv4J0PiNaSl28d1UlTQqQEnvydgxN
 vAVrsVXkMLkrOzVWiNXKUJCABUvqVsVFkh0vDXt5K/h18sefb0mu367dbcjZr5b6+wsTkzs7ZzD
 zRF2K5RjOfcQYVUyNIWp3AuaFfcp9v4/fqF+/h9+mOynxd/1wWMblvI+2qbEbWI4jh1cGQC768G
 pKYKS/aBA3SBA2YpqkumwJKN53/W6ZirsqIAQC0qZy4DpgvKUbZk6F160RLPTBTK7Isliv6XljG
 CfgbNxQBiTaZ4Sp/P3bh27wR3oyDSh16C+LsyD2CXn+Yg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 61FAC21569;
 Tue, 29 Apr 2025 20:14:03 +0000 (UTC)
From: ~percival_foss <percival_foss@git.sr.ht>
Date: Tue, 29 Apr 2025 12:12:10 -0400
Subject: [PATCH qemu v2 2/2] tests/functional: Added cross page overflow test
Message-ID: <174595764300.3422.13156465553505851834-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <174595764300.3422.13156465553505851834-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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
Reply-To: ~percival_foss <foss@percivaleng.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Percival Foss <foss@percivaleng.com>

This test utilizes pegasos2 to show the cross page overflow bug on 32 bit sys=
tems. We patch the firmware
image to cause the overflow. The instructions to do this are as follows:
li r3, 0
li r4, -1
lwz r5, 0x0(r4)
lwz r5, 0x0(r3)

This test will add an invalid translation when ran and then crash QEMU. If th=
e fix is applied then pegasos2
will start properly and not crash.

Signed off by:Percival Engineering <foss@percivalemg.com>
---
 tests/functional/meson.build          |  1 +
 tests/functional/test_ppc_pegasos2.py | 69 +++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/functional/test_ppc_pegasos2.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0f8be30fe2..6641b878c3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -213,6 +213,7 @@ tests_ppc_system_thorough =3D [
   'ppc_bamboo',
   'ppc_mac',
   'ppc_mpc8544ds',
+  'ppc_pegasos2',
   'ppc_replay',
   'ppc_sam460ex',
   'ppc_tuxrun',
diff --git a/tests/functional/test_ppc_pegasos2.py b/tests/functional/test_pp=
c_pegasos2.py
new file mode 100755
index 0000000000..ef76745068
--- /dev/null
+++ b/tests/functional/test_ppc_pegasos2.py
@@ -0,0 +1,69 @@
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
+from qemu_test import wait_for_console_pattern
+from zipfile import ZipFile
+
+class Pegasos2Machine(QemuSystemTest):
+
+    timeout =3D 90
+
+    ASSET_IMAGE =3D Asset(
+        ('https://web.archive.org/web/20071021223056if_/http://www.bplan-gmb=
h.de/up050404/up050404'),
+        '0b4ff042b293033e094b47ac7051824fc45f83adb340d455a17db1674b0150b0c60=
ffc624ac766f5369cd79f0447214d468baa182c1f18c5e04cd23a50f0b9a2')
+
+    def test_ppc_pegasos2(self):
+        self.require_accelerator("tcg")
+        self.set_machine('pegasos2')
+        file_path =3D self.ASSET_IMAGE.fetch()
+        bios_fh =3D open(self.workdir + "/pegasos2.rom", "wb")
+        subprocess.run(['tail', '-c','+85581', file_path], stdout=3Dbios_fh)
+        bios_fh.close()
+        subprocess.run(['truncate', '-s', '524288', self.workdir + "/pegasos=
2.rom"], )
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/pegasos2.rom')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'SmartFirmware:')
+
+    def test_ppc_pegasos2_test_tcg_crosspage_overflow_bug(self):
+        self.require_accelerator("tcg")
+        self.set_machine('pegasos2')
+        file_path =3D self.ASSET_IMAGE.fetch()
+        bios_fh =3D open(self.workdir + "/pegasos2.rom", "wb")
+        subprocess.run(['tail', '-c','+85581', file_path], stdout=3Dbios_fh)
+        bios_fh.close()
+        subprocess.run(['truncate', '-s', '524288', self.workdir + "/pegasos=
2.rom"], )
+
+        with open(self.workdir + "/pegasos2.rom", "rb") as bios_fh:
+            bios_data =3D bios_fh.read()
+       =20
+        # Patch the firmware image with the following instructions that will=
 cause tcg to crash for 32-bit guests on 64-bit platforms:
+        #   li r3, 0
+        #   li r4, -1
+        #   lwz r5, 0x0(r4)
+        #   lwz r5, 0x0(r3)
+
+        bios_data_new =3D bios_data[:0x6c10] + b'\x38\x60\x00\x00' + b'\x38\=
x80\xff\xff' + b'\x80\xa4\x00\x00' + b'\x80\xa3\x00\x00' + bios_data[0x6c20:]
+        with open(self.workdir + "/pegasos2_new.rom", "wb") as bios_new_fh:
+            bios_new_fh.write(bios_data_new)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/pegasos2_new.rom')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Releasing IDE reset')
+
+        # set $pc =3D 0 and expect crash
+
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.45.3

