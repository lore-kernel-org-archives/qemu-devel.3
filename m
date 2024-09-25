Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E388C369D0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPv9-00072Y-2k; Wed, 25 Sep 2024 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv5-0006oJ-9t
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv3-0003UZ-JU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqMKBXe0Hoi2TJnCj9hPXem8jMkCoMI9j3NKCdrJ8fU=;
 b=NkxDtpl1rJb+xhL5qOIqiEetFcQ+usU20nQEiqRHXSNkMUkjy3h0WCwwjZQpSmdTmdseKZ
 zWRSQ7fYzf1/AjAzv+DV528w6nnmgyyifDdaSVlzlFVCoUCl1Nm6GIVbGr+G7yHq0o5jYu
 3GrfxfWJiBYzvNcTYlTvagZHYwH8MgY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632--vCJm03HO06q7rH7AbzBQg-1; Wed,
 25 Sep 2024 07:10:51 -0400
X-MC-Unique: -vCJm03HO06q7rH7AbzBQg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DE661944DF4; Wed, 25 Sep 2024 11:10:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 786121956094; Wed, 25 Sep 2024 11:10:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/44] tests/functional: Convert the SPARCStation Avocado test
Date: Wed, 25 Sep 2024 13:09:45 +0200
Message-ID: <20240925111029.24082-5-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the new launch_kernel function to convert this test in a simple way.

Message-ID: <20240919185749.71222-5-thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |  1 +
 tests/avocado/boot_linux_console.py  |  8 --------
 tests/functional/meson.build         |  4 ++++
 tests/functional/test_sparc_sun4m.py | 25 +++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100755 tests/functional/test_sparc_sun4m.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a75d6ba7d2..b85a3fc529 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1693,6 +1693,7 @@ F: include/hw/nvram/sun_nvram.h
 F: include/hw/sparc/sparc32_dma.h
 F: include/hw/sparc/sun4m_iommu.h
 F: pc-bios/openbios-sparc32
+F: tests/functional/test_sparc_sun4m.py
 
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index cf58499c84..900af67412 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1019,11 +1019,3 @@ def test_sh4_r2d(self):
         tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
         self.vm.add_args('-append', 'console=ttySC1')
         self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
-
-    def test_sparc_ss20(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:SS-20
-        """
-        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
-        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8fd852f4ab..8aacd15cf3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -125,6 +125,10 @@ tests_s390x_system_thorough = [
   's390x_topology',
 ]
 
+tests_sparc_system_thorough = [
+  'sparc_sun4m',
+]
+
 tests_sparc64_system_thorough = [
   'sparc64_sun4u',
 ]
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
new file mode 100755
index 0000000000..b334375820
--- /dev/null
+++ b/tests/functional/test_sparc_sun4m.py
@@ -0,0 +1,25 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a sparc sun4m machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class Sun4mTest(LinuxKernelTest):
+
+    ASSET_DAY11 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz',
+        'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
+
+    def test_sparc_ss20(self):
+        self.set_machine('SS-20')
+        file_path = self.ASSET_DAY11.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day11/zImage.elf',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


