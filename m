Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4E1C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqnM-0001oY-KL; Mon, 20 Jul 2026 12:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlqmS-0001Yd-Ey
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlqmM-00014p-Gi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784564614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mXrlwnVbzcM2fb+MVW2b60/blCecSilqzwhqr8D3A5Y=;
 b=GjDJvtGPr5Zflt1ouQ+WSG4cfbMlHqQ++JVEjnAnuzgxYEpB4xYHt2KjD/++5QrymvoAAi
 kPTezq0r77RmCawZLinLs5Cb2G6i38L5IHM3jXoMQkO9xOclqNZuN9BQYhy1oQbXcMxR20
 VEhi8AKDdkF0GM2lHcrTJdzZQecxKCg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-eYk30ZzKO-6jIzotHfowew-1; Mon,
 20 Jul 2026 12:23:31 -0400
X-MC-Unique: eYk30ZzKO-6jIzotHfowew-1
X-Mimecast-MFC-AGG-ID: eYk30ZzKO-6jIzotHfowew_1784564609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC2D18002AB; Mon, 20 Jul 2026 16:23:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65C371800612; Mon, 20 Jul 2026 16:23:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional/aspeed: Fix remaining hostname-specific
 login prompts
Date: Mon, 20 Jul 2026 18:23:21 +0200
Message-ID: <20260720162321.3497633-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
index 61d9ac5284a0..23f1b5de92c3 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -76,7 +76,7 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         self.verify_openbmc_boot_start(enable_pcie)
 
-        wait_for_console_pattern(self, f'{name} login:')
+        wait_for_console_pattern(self, 'login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index 4c56cd1e68c9..17bf3093a5d0 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -76,7 +76,7 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
         self.verify_openbmc_boot_start(enable_pcie)
 
-        wait_for_console_pattern(self, f'{name} login:')
+        wait_for_console_pattern(self, 'login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index d28a850803a8..bd15c1d14c47 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -53,7 +53,7 @@ def verify_openbmc_boot_and_login(self, name):
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


