Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f162cebF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35N-0005lm-3J; Sat, 31 Oct 2026 03:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33t-00039H-3B
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33m-0002s3-Db
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e716O5xxLeB24D4PTUnfKRKw4B18+ABRJmTBcI3Wh04=;
 b=f162cebFQZprLTZP2dwpDVkl+aIHuHvwqEEgqebrAPS7VG6wf8waMKmwrBdPVD2+TCQK25
 55I0uWCcVsKI0EcfLc10FnXL/we3BU8BlOAxk0QZ+10i6MKaypSNRzQx+0hp0ZrTjzXGQO
 U5qSZInlbNakiLiO8W9JbrXmRb/5fnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-AitZ28RQOPOOnbRgW2i2Fw-1; Sat,
 31 Oct 2026 02:59:17 -0400
X-MC-Unique: AitZ28RQOPOOnbRgW2i2Fw-1
X-Mimecast-MFC-AGG-ID: AitZ28RQOPOOnbRgW2i2Fw_1793429956
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C903B195608D; Sat, 31 Oct 2026 06:59:16 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 634621803A40; Sat, 31 Oct 2026 06:59:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/34] tests/functional/arm/aspeed: Add AST1080 test with
 ASPEED MCU FW Hub v01.00
Date: Sat, 31 Oct 2026 07:58:10 +0100
Message-ID: <20261031065823.191966-22-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a functional test for the ASPEED AST1080 EVB using the
Zephyr firmware from ASPEED MCU FW Hub v01.00.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build            |  1 +
 tests/functional/arm/test_aspeed_ast1080.py | 37 +++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/functional/arm/test_aspeed_ast1080.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index e657ecd27824..72c7afc84a1f 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -38,6 +38,7 @@ tests_arm_system_thorough = [
   'aspeed_ast1030',
   'aspeed_ast1040',
   'aspeed_ast1060',
+  'aspeed_ast1080',
   'aspeed_palmetto',
   'aspeed_romulus',
   'aspeed_witherspoon',
diff --git a/tests/functional/arm/test_aspeed_ast1080.py b/tests/functional/arm/test_aspeed_ast1080.py
new file mode 100644
index 000000000000..76f3cc09835c
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast1080.py
@@ -0,0 +1,37 @@
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
+class AST1080Machine(AspeedTest):
+
+    ASSET_ASPEED_AST1080_EVB_01_00 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/aspeed-mcu-fw-hub/releases/download/v01.00'
+         '/ast1080a0-evb-v01.00.tar.gz'),
+         '7c8a95bc51945d70591b20f1a22f8fffebc2b164e6fda47f73ff67f37bed8d87')
+
+    def test_arm_ast1080_zephyros(self):
+        self.set_machine('ast1080-evb')
+
+        kernel_name = ('ast1080a0-evb-v01.00/ast1080/ast1080a0/evb/'
+                       'zephyr-shell-module.bin')
+        kernel_file = self.archive_extract(
+            self.ASSET_ASPEED_AST1080_EVB_01_00, member=kernel_name)
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
2.56.0


