Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028FACD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0d-0005Rz-Qn; Tue, 26 May 2026 04:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0W-0005LK-O6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0V-0007iZ-24
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFhFJk4wW847wXcDxweUhmJvk4UnLP+9BFlsu69yODg=;
 b=Lhek2G/70CS4iHlCy3sQl25IZkIVM2A/5ag73ueHsSsMofp3IFXjb1HrAXLw4b7P8qvjzA
 /eComKe4b2mvIYBx272qiWK1qDYtx+hIuTNQmCKsL/SmAoA//MAYEvm2yAWeDlCyb7lh9Q
 hl0FL4ApfmykSHXqem0tOKlBAzUzY8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-SgLOwYwKN0uYm44Y1GCM0g-1; Tue,
 26 May 2026 04:19:20 -0400
X-MC-Unique: SgLOwYwKN0uYm44Y1GCM0g-1
X-Mimecast-MFC-AGG-ID: SgLOwYwKN0uYm44Y1GCM0g_1779783559
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8A91956067; Tue, 26 May 2026 08:19:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACF151800267; Tue, 26 May 2026 08:19:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/37] tests/function/aspeed: Add AST1040 functional test
Date: Tue, 26 May 2026 10:18:24 +0200
Message-ID: <20260526081848.651835-14-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a new functional test for the ast1040-evb machine to
validate Zephyr firmware boot flow in QEMU.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build            |  1 +
 tests/functional/arm/test_aspeed_ast1040.py | 35 +++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tests/functional/arm/test_aspeed_ast1040.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 959179a56f6d..61b00932db93 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -34,6 +34,7 @@ tests_arm_system_quick = [
 
 tests_arm_system_thorough = [
   'aspeed_ast1030',
+  'aspeed_ast1040',
   'aspeed_ast1060',
   'aspeed_palmetto',
   'aspeed_romulus',
diff --git a/tests/functional/arm/test_aspeed_ast1040.py b/tests/functional/arm/test_aspeed_ast1040.py
new file mode 100644
index 000000000000..e4d8ecb37a58
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast1040.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2026 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from aspeed import AspeedTest
+from qemu_test import Asset, exec_command_and_wait_for_pattern
+
+
+class AST1040Machine(AspeedTest):
+
+    ASSET_ZEPHYR_3_07 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/zephyr/releases/download/v00.03.07/ast1040-evb-demo.zip'),
+         'b5189797c22c2d732ddc27670c1efdeba821a2747c9c7434f190791125baa121')
+
+    def test_arm_ast1040_zephyros(self):
+        self.set_machine('ast1040-evb')
+
+        kernel_name = "zephyr.bin"
+        kernel_file = self.archive_extract(
+            self.ASSET_ZEPHYR_3_07, member=kernel_name)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern("uart:~$")
+        exec_command_and_wait_for_pattern(self, "help",
+                                          "Available commands")
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.54.0


