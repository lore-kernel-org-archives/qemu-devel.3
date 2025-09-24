Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C78CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JBB-0002XU-QL; Wed, 24 Sep 2025 02:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAz-0002VB-VD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAj-0006iI-MV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGT5yZawBfpewna4QY4pYw7nr+SMBxcX+jH7B46b0yI=;
 b=QFNQ4T3iVW0iD3V2b56bIK73uLpS+YM2jjLDS1m3RGOOmslZ1LKxHVOc4zY1MjfSPGARWu
 iOB4dWzAloRk0Y9fpvuw74Y+q84JJcBv9SErpxopKKNUXi4OntbcxIlEMTii2AeiWN2yqj
 MeygmD2Uk8//s0Gq/LLsIM/huAWVhFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-S_LfaPJNOB2QDQKK0sQIJQ-1; Wed,
 24 Sep 2025 02:40:06 -0400
X-MC-Unique: S_LfaPJNOB2QDQKK0sQIJQ-1
X-Mimecast-MFC-AGG-ID: S_LfaPJNOB2QDQKK0sQIJQ_1758696006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028B4195608B; Wed, 24 Sep 2025 06:40:06 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F9E71955F19; Wed, 24 Sep 2025 06:40:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/12] tests/functional: Test whether the
 vmstate-static-checker script works fine
Date: Wed, 24 Sep 2025 08:39:48 +0200
Message-ID: <20250924063956.519792-5-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We've got two vmstate dump files in the repository which are meant
for verifying whether the vmstate-static-checker.py works as expected.
Since running this manually is a cumbersome job, let's add an automated
test for this instead that runs the script with the two dump files
and checks for the expected output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250912100755.316518-3-thuth@redhat.com>
---
 MAINTAINERS                                 |  1 +
 tests/functional/x86_64/meson.build         |  1 +
 tests/functional/x86_64/test_bad_vmstate.py | 58 +++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100755 tests/functional/x86_64/test_bad_vmstate.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 79abe5f6c9a..24c061aff35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3613,6 +3613,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/functional/migration.py
 F: tests/functional/*/*migration.py
+F: tests/functional/x86_64/test_bad_vmstate.py
 F: tests/data/vmstate-static-checker/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8a..ef12ac43b37 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -10,6 +10,7 @@ test_x86_64_timeouts = {
 }
 
 tests_x86_64_system_quick = [
+  'bad_vmstate',
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/functional/x86_64/test_bad_vmstate.py b/tests/functional/x86_64/test_bad_vmstate.py
new file mode 100755
index 00000000000..40098a8490b
--- /dev/null
+++ b/tests/functional/x86_64/test_bad_vmstate.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+'''Test whether the vmstate-static-checker script detects problems correctly'''
+
+import subprocess
+
+from qemu_test import QemuBaseTest
+
+
+EXPECTED_OUTPUT='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
+Section "fw_cfg" does not exist in dest
+Section "fusbh200-ehci-usb" version error: 2 > 1
+Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
+Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
+Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
+Section "cfi.pflash01": Entry "Description" missing
+Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
+Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
+Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
+Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
+Section "sun-fdtwo" Description "fdc": version error: 2 > 1
+Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
+Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
+'''
+
+class BadVmStateTest(QemuBaseTest):
+    '''Test class for testing vmstat-static-checker script with bad input'''
+
+    def test_checker(self):
+        """
+        Test whether the checker script correctly detects the changes
+        between dump1.json and dump2.json.
+        """
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump1.json')
+        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump2.json')
+        checkerscript = self.data_file('..', '..', 'scripts',
+                                       'vmstate-static-checker.py')
+
+        self.log.info('Comparing %s with %s', src_json, dst_json)
+        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True, check=False)
+        if cp.returncode != 13:
+            self.fail('Unexpected return code of vmstate-static-checker: ' +
+                      cp.returncode)
+        if cp.stdout != EXPECTED_OUTPUT:
+            self.log.info('vmstate-static-checker output:\n%s', cp.stdout)
+            self.log.info('expected output:\n%s', EXPECTED_OUTPUT)
+            self.fail('Unexpected vmstate-static-checker output!')
+
+
+if __name__ == '__main__':
+    QemuBaseTest.main()
-- 
2.51.0


