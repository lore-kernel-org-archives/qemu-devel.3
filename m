Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478ABC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE0p-0000vu-Qu; Mon, 27 Jul 2026 01:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE0o-0000uo-52
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE0l-0003Je-Os
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhhFiG9dtTliGJi4wpYlM68+OjMm1Le3t+nf8bh37JE=;
 b=DTjqWpBZsFQA6srWRhKgA4RSdByg3JaPMWiKV0jKD9SpGhFHhcB69xiWt4s298Nt2mCBK6
 OTEN9vlFEtl/7d6q+w57BWvXfch34zz8I0Q4jPpARzmoXniprdus+BRjt9Vzp2ahvfaQzC
 plGQoVndZAJkPTUhMZk7m73GCh8KkOE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-aJkb3BhhPg-oimivyPdKXg-1; Mon,
 27 Jul 2026 01:36:19 -0400
X-MC-Unique: aJkb3BhhPg-oimivyPdKXg-1
X-Mimecast-MFC-AGG-ID: aJkb3BhhPg-oimivyPdKXg_1785130578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21A071801345; Mon, 27 Jul 2026 05:36:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E7821800591; Mon, 27 Jul 2026 05:36:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/1] tests/functional/aspeed: Fix remaining hostname-specific
 login prompts
Date: Mon, 27 Jul 2026 07:36:11 +0200
Message-ID: <20260727053611.1388339-2-clg@redhat.com>
In-Reply-To: <20260727053611.1388339-1-clg@redhat.com>
References: <20260727053611.1388339-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit b04746bd0d7c unified boot completion detection on the generic
'login:' prompt but missed several SDK test files that still matched
on hostname-prefixed patterns. Apply the same fix.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4059
Fixes: b04746bd0d7c ("tests/functional/aspeed: unify boot completion detection on 'login:' prompt")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260720162321.3497633-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700a1.py   | 2 +-
 tests/functional/aarch64/test_aspeed_ast2700a2.py   | 2 +-
 tests/functional/aarch64/test_aspeed_ast2700fc.py   | 2 +-
 tests/functional/arm/test_aspeed_ast2500_sdk.py     | 2 +-
 tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 2 +-
 tests/functional/arm/test_aspeed_ast2600_sdk.py     | 2 +-
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
index b0c08854daa9..ddddd2d47a95 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -81,7 +81,7 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         self.verify_openbmc_boot_start(enable_pcie)
 
-        wait_for_console_pattern(self, f'{name} login:')
+        wait_for_console_pattern(self, 'login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index ed414999f4fa..0fe04a6eca7f 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -81,7 +81,7 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         self.verify_openbmc_boot_start(enable_pcie)
 
-        wait_for_console_pattern(self, f'{name} login:')
+        wait_for_console_pattern(self, 'login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index df889134edaa..86270e6111f3 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -51,7 +51,7 @@ def verify_openbmc_boot_and_login(self, name):
         self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Starting kernel ...')
 
-        wait_for_console_pattern(self, f'{name} login:')
+        wait_for_console_pattern(self, 'login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functional/arm/test_aspeed_ast2500_sdk.py
index 5ab36b99ab47..6ab498b3ff54 100755
--- a/tests/functional/arm/test_aspeed_ast2500_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py
@@ -22,7 +22,7 @@ def test_arm_ast2500_evb_sdk(self):
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2500-default", "image-bmc"))
 
-        self.wait_for_console_pattern('ast2500-default login:')
+        self.wait_for_console_pattern('login:')
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
index 2b257986f622..8d39dc65daaa 100755
--- a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
@@ -22,7 +22,7 @@ def test_arm_ast2500_evb_sdk_515(self):
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2500-default-515", "image-bmc"))
 
-        self.wait_for_console_pattern('ast2500-default-515 login:')
+        self.wait_for_console_pattern('login:')
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index 01548dd1354d..cabbe230c4cc 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -63,7 +63,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default-image", "image-bmc"))
 
-        self.wait_for_console_pattern('ast2600-default login:')
+        self.wait_for_console_pattern('login:')
 
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc',
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
index ec043e7d6116..a8e7faff4890 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
@@ -22,7 +22,7 @@ def test_arm_ast2600_evb_sdk_515(self):
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default-515-image", "image-bmc"))
 
-        self.wait_for_console_pattern('ast2600-default-515 login:')
+        self.wait_for_console_pattern('login:')
 
 
 if __name__ == '__main__':
-- 
2.55.0


