Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06001C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wj7-0000YO-O7; Mon, 07 Sep 2026 06:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wit-0000RY-FU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Win-00048I-00
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cGBVc64aixvB++qc7RppwSp5/9PtciqMdVtjMAEwcM=;
 b=DC/XXofYOY9GFuh6wXjkbMeKwO2QOeuMV7CjtaH+rR/do+elXXiwpM2wU5eldgIyUFTOz2
 mbvDvky+/SSTIZxRLEGopixRubfxCOP3T9o7IY00J81HjtUpnhkFrRxU6KPhi3af2k8qWR
 b46tDySZg38IuTxM7/4vieeJFv4k4Jk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-ATUV2tD4Pbec_LuEi3QE9g-1; Mon,
 07 Sep 2026 06:30:44 -0400
X-MC-Unique: ATUV2tD4Pbec_LuEi3QE9g-1
X-Mimecast-MFC-AGG-ID: ATUV2tD4Pbec_LuEi3QE9g_1788777042
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E7B91955E96; Mon,  7 Sep 2026 10:30:42 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14BCA5B1; Mon,  7 Sep 2026 10:30:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:21 +0400
Subject: [PATCH v2 03/10] tests/functional: skip if CONFIG_PIXMAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-3-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4623;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=63ZiKVOC1t8wXBgD9jtUermXawOaBss0w62gKXXWiNc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJC41pd36Eo3JwGXpq/ryJgrIbzXUS7E+8xT
 /JnLdQ2OWyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5fgaD/99GUMSRBwLxJ9UjY9dWuXVYg14WU6GKNkDCb5ZgoVH55GSRXlr3triKaluNoV2WBxMtdp
 6nzvxgNAJfOhNJhoXsRQHMqNrXF1xqfQxOnX0zlBn44C8ud7V5tcZU18Y6Dr1d1FbcufHh3GgAr
 TXywC+Vwt+YmBj31dQ0UnQYBIYQafiV5GfwKvTg/7ouQ7EVOugfpK2X7RFARC6jfKmRyal3cTwO
 xjAKRxRBbGn2uioKxR08PUAIzEExSzTjYfSMcT5fQ61IlVOsIvfFPGZx8tW3yRk0muZo8lnoYUQ
 clco+xJnHf4QNCe7E4li9fWABGHU44T9utKM1kE6NiKThLZSZKJjeNdlZT0jAI2qTQNp9VbLQ+b
 UIQfwEsZ861uC9HQP0cJgBH8VBv9fASlNWIH1jn+A0Wb3clH1PiN1Fh78uxphxA03AJZLVsegjP
 3ctMBQ4GP3K90Di+tLwpBa+8w+90uFtvoyh1MD4z2JvgnXySvJuDLfSQfFAr1HF15qZFiv0OzdY
 EZDtYR13Y7h2zBHGEr7KQxcB/SAWQcjswLZX9/XkS8u3vqKWeAgPUAqyeCgb/Vwoo6MLC+Dl9Sl
 ublXcAyDQuM/+n5xuNQ9n7O20ZEQIjrcaUrWJ6ouoPOQnqy6J/aiGWWNRercXaawwJaofF3WumJ
 5ee4hnD/t2XKgJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

PIXMAN is required for screendump.
Replace test-time check with earlier @skipUnlessConfig check.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/arm/test_integratorcp.py |  9 ++++-----
 tests/functional/m68k/test_nextcube.py    |  9 ++++-----
 tests/functional/mips64el/test_malta.py   | 10 +++++-----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/functional/arm/test_integratorcp.py b/tests/functional/arm/test_integratorcp.py
index 23ae919359d5..f7551ff7cb88 100755
--- a/tests/functional/arm/test_integratorcp.py
+++ b/tests/functional/arm/test_integratorcp.py
@@ -16,7 +16,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test import skipIfMissingImports, skipUntrustedTest
+from qemu_test import skipIfMissingImports, skipUntrustedTest, skipUnlessConfig
 
 
 class IntegratorMachine(QemuSystemTest):
@@ -58,6 +58,7 @@ def test_integratorcp_console(self):
         wait_for_console_pattern(self, 'Log in as root')
 
     @skipIfMissingImports("numpy", "cv2")
+    @skipUnlessConfig("PIXMAN")
     @skipUntrustedTest()
     def test_framebuffer_tux_logo(self):
         """
@@ -73,10 +74,8 @@ def test_framebuffer_tux_logo(self):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='screendump %s' % screendump_path)
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screendump_path)
 
         cpu_count = 1
         match_threshold = 0.92
diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index d917cf5424fe..f38f294bad67 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -10,10 +10,11 @@
 import time
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import skipIfMissingImports, skipIfMissingCommands
+from qemu_test import skipIfMissingImports, skipIfMissingCommands, skipUnlessConfig
 from qemu_test.tesseract import tesseract_ocr
 
 
+@skipUnlessConfig("PIXMAN")
 class NextCubeMachine(QemuSystemTest):
 
     timeout = 15
@@ -39,10 +40,8 @@ def check_bootrom_framebuffer(self, screenshot_path):
                 break
             time.sleep(0.1)
 
-        res = self.vm.cmd('human-monitor-command',
-                          command_line=f"screendump {screenshot_path}")
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        self.vm.cmd('human-monitor-command',
+                    command_line=f"screendump {screenshot_path}")
 
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index 163bbaf5ca36..80fe3424b234 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -13,7 +13,8 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
+from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest, \
+    skipUnlessConfig
 
 from mips.test_malta import mips_check_wheezy
 
@@ -114,6 +115,7 @@ def test_wheezy(self):
 
 
 @skipIfMissingImports('numpy', 'cv2')
+@skipUnlessConfig("PIXMAN")
 class MaltaMachineFramebuffer(LinuxKernelTest):
 
     timeout = 30
@@ -155,10 +157,8 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         self.wait_for_console_pattern(framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        res = self.vm.cmd('human-monitor-command',
-                          command_line=f'screendump {screendump_path}')
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        self.vm.cmd('human-monitor-command',
+                    command_line=f'screendump {screendump_path}')
 
         match_threshold = 0.95
         screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)

-- 
2.55.0.543.g5ebe2ebe4ea8


