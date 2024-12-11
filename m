Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652A0E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGH4-00065E-V3; Wed, 11 Dec 2024 01:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGB-0004kZ-VD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGG4-0008UZ-3H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laezA729Jrqs4I9HRYeFkOfoE0lAAG2rG7GSzzynBOA=;
 b=MrrsgziLmJYf/kC4EVWNEqk0y89nC3+P+2g5QCBQWpFtbKzQXeAZwaloA3+oJeicCYxtX5
 n7E8EXX8VAos/SiXApa3HJD9x8dg8hkhiJEkqZpKWcFRsFO7CLCOAyy8lZs+Z/d6ch82Mh
 PR4mImdXsGFLiMovpusjUCRg5qsLd9k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-2eahP898Mm6RST89UTM2Rw-1; Wed,
 11 Dec 2024 01:31:35 -0500
X-MC-Unique: 2eahP898Mm6RST89UTM2Rw-1
X-Mimecast-MFC-AGG-ID: 2eahP898Mm6RST89UTM2Rw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6284195605F; Wed, 11 Dec 2024 06:31:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 760A51956054; Wed, 11 Dec 2024 06:31:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/24] tests/functional: Introduce a specific test for
 rainier-bmc machine
Date: Wed, 11 Dec 2024 07:30:47 +0100
Message-ID: <20241211063058.1222038-14-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This simply moves the rainier-bmc test to a new test file. No changes
in the test. The test_arm_aspeed.py is deleted.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20241206131132.520911-7-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/meson.build                  |  4 ++--
 ...m_aspeed.py => test_arm_aspeed_rainier.py} | 22 +++++--------------
 2 files changed, 7 insertions(+), 19 deletions(-)
 rename tests/functional/{test_arm_aspeed.py => test_arm_aspeed_rainier.py} (71%)
 mode change 100755 => 100644

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b5fd3bededde..96f2291a39bd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -22,7 +22,7 @@ test_timeouts = {
   'arm_aspeed_romulus' : 120,
   'arm_aspeed_ast2500' : 480,
   'arm_aspeed_ast2600' : 720,
-  'arm_aspeed' : 600,
+  'arm_aspeed_rainier' : 240,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
   'arm_orangepi' : 540,
@@ -69,12 +69,12 @@ tests_alpha_system_thorough = [
 ]
 
 tests_arm_system_thorough = [
-  'arm_aspeed',
   'arm_aspeed_ast1030',
   'arm_aspeed_palmetto',
   'arm_aspeed_romulus',
   'arm_aspeed_ast2500',
   'arm_aspeed_ast2600',
+  'arm_aspeed_rainier',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed_rainier.py
old mode 100755
new mode 100644
similarity index 71%
rename from tests/functional/test_arm_aspeed.py
rename to tests/functional/test_arm_aspeed_rainier.py
index 8cf86795af3c..a60274926d6f
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed_rainier.py
@@ -1,25 +1,13 @@
 #!/usr/bin/env python3
 #
-# Functional test that boots the ASPEED SoCs with firmware
-#
-# Copyright (C) 2022 ASPEED Technology Inc
+# Functional test that boots the ASPEED machines
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-import time
-import subprocess
-import tempfile
-
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import has_cmd
-from qemu_test.utils import archive_extract
-from zipfile import ZipFile
-from unittest import skipUnless
+from qemu_test import Asset
+from aspeed import AspeedTest
 
-class AST2x00MachineMMC(LinuxKernelTest):
+class RainierMachine(AspeedTest):
 
     ASSET_RAINIER_EMMC = Asset(
         ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
@@ -49,4 +37,4 @@ def test_arm_aspeed_emmc_boot(self):
         self.wait_for_console_pattern('IBM eBMC (OpenBMC for IBM Enterprise')
 
 if __name__ == '__main__':
-    LinuxKernelTest.main()
+    AspeedTest.main()
-- 
2.47.1


