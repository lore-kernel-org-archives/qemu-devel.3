Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75816E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdMa-0000vd-ID; Fri, 06 Sep 2024 14:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdMY-0000nv-D2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdMR-00054y-AY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GntpAht59yV/R8tQt+YIxckQaTpkDbmEj51XFzA1VAA=;
 b=You5Rc4BOdeBx+UvUyTD5LqwtFe1Bf7KVt1hQvqpJDCevxG9PnkdvWqPD2M+tMDTeE4gfz
 5YBv45tt5EBIoFwzaI8faX2mS6ueKcoNjbni2rF7Y3BGsE/oyB2RWj+L7zmgL86lanTmYd
 c4MDqD1HZHQUT4AmCJeCRc/JeghtPoY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-pldUc-tLMFuWnCetuhTiyQ-1; Fri,
 06 Sep 2024 14:06:38 -0400
X-MC-Unique: pldUc-tLMFuWnCetuhTiyQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79DC91955DC8; Fri,  6 Sep 2024 18:06:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D79919560AA; Fri,  6 Sep 2024 18:06:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 14/14] tests/functional: Convert the or1k-sim Avocado test
Date: Fri,  6 Sep 2024 20:05:49 +0200
Message-ID: <20240906180549.792832-15-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We've got to do_test_advcal_2018() here now that the test resides
in a separate file. Also switch back to the original URL (since
the site did not vanish as originally expected) and update the
hashsum to use SHA256.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py |  8 --------
 tests/functional/meson.build        |  4 ++++
 tests/functional/test_or1k_sim.py   | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100755 tests/functional/test_or1k_sim.py

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index db72bd1b5e..6c50284986 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -927,14 +927,6 @@ def test_arm_ast2600_debian(self):
         self.wait_for_console_pattern("SMP: Total of 2 processors activated")
         self.wait_for_console_pattern("No filesystem could mount root")
 
-    def test_or1k_sim(self):
-        """
-        :avocado: tags=arch:or1k
-        :avocado: tags=machine:or1k-sim
-        """
-        tar_hash = '20334cdaf386108c530ff0badaecc955693027dd'
-        self.do_test_advcal_2018('20', tar_hash, 'vmlinux')
-
     def test_ppc64_e500(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8f9694244f..68a7570119 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -94,6 +94,10 @@ tests_mips64el_system_thorough = [
   'mips64el_malta',
 ]
 
+tests_or1k_system_quick = [
+  'or1k_sim',
+]
+
 tests_ppc_system_quick = [
   'ppc_74xx',
 ]
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
new file mode 100755
index 0000000000..aa2a1f08d2
--- /dev/null
+++ b/tests/functional/test_or1k_sim.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on an OpenRISC-1000 SIM machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class OpenRISC1kSimTest(LinuxKernelTest):
+
+    ASSET_DAY20 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day20.tar.xz',
+        'ff9d7dd7c6bdba325bd85ee85c02db61ff653e129558aeffe6aff55bffb6763a')
+
+    def test_or1k_sim(self):
+        self.set_machine('or1k-sim')
+        file_path = self.ASSET_DAY20.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day20/vmlinux')
+        self.vm.launch()
+        self.wait_for_console_pattern('QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


