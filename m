Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE1C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZAy-0004AF-Pf; Mon, 07 Sep 2026 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZAw-00047T-SL
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZAu-0006Qv-Uh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhF+LPeY+OhWtZ9Geb9k4VAyQa5iXbXu/6wp/DbPS44=;
 b=i4EOXIh9Ign++x5YkhMER/+DElpefaNfo5l3pDSWWk6zD/FP3bMP0ddDeltQzp7mpuZWQ8
 YjtFPQs8DVg4h6oCIQTkRji2wrKfHFVJebWoRexf1dfTGgPqJFXeWFE/UK8nW8TXV2HzYM
 xlsqlogoTE8okDwe7m9uStOTGiEomeQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-YHoJYyqqOBeamVSfpbveXQ-1; Mon,
 07 Sep 2026 09:14:11 -0400
X-MC-Unique: YHoJYyqqOBeamVSfpbveXQ-1
X-Mimecast-MFC-AGG-ID: YHoJYyqqOBeamVSfpbveXQ_1788786849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F871955D7D; Mon,  7 Sep 2026 13:14:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48A001955F07; Mon,  7 Sep 2026 13:14:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:13:55 +0400
Subject: [PATCH v3 1/9] tests/functional: replace HMP with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-1-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wRP0TTU7tHgaAz5ePxRNTdw8coJZsHYYMWkGMZmWUDw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXqpm8t6dRjU2H+9fKTGG5Aox2fIJkJm2PB
 +geu4U89RSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5XKUD/9naAU5Hv7O5qygDUwAEtbGyF/vOErv8EQ+Z6pDcfgcXgjmcWGVPzaDy58yJbceOTcZ3xt
 CNeHHWOkUtJjOkGvSXRiFgJW0gWoAXKzIvehmFrlHXh4VJn8jS1zRXohdn8Od6FscgrlDr8/lnR
 /q3vRu60xAMgZ8nN/c0tApdKbgqpe3NZSnzd4YK9Lu8esAtDPRSTIWbDe+HpgbO66VO6fEFJlgg
 Cz0uzM+V+6z1OQfC5oTSHgRJ3j0pv02ArlHkvKvigpNeV5LGTpwuCf+vpRsdUVa7JsAJgwVSHhG
 Vsta1zgDbi0qxdBnF1K9keza/S5emFwZv3rnocUD3tODhMf5rZVR8gGI38ZX6x1fMM0SlJsdWjz
 J0RZ65lnTeiUQRGWwGP1UQMB5g5CCsVPT6R31uQ1QmOBXvOyUo/NDFUeezz+voS3KmLaa5c0sgP
 6viNGfcraVZ1+w5wAGIf/+FoSj3IQyXt+iGZB8DMhKiEojirdaIfAdpe1zJqIwnWZH2eByhpZLn
 2fvZ0+8fMiq0hNnVq12CLHArGeX36WCYUIgOFdXucUq4ajOAde2PYNTcgF74cIAmasDnHcSv8BP
 4BNw24cAs5fmZip1hSXrnOyIuN5roduMWsZxuEvWV8MrTbJThbckt2rB8gMesJRxSnRR2N9SqJ7
 qgW7cWh1FrS20sQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace HMP with QMP equivalent.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/arm/test_integratorcp.py | 13 ++++++++-----
 tests/functional/m68k/test_nextcube.py    | 11 +++++++----
 tests/functional/mips64el/test_malta.py   | 13 ++++++++-----
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tests/functional/arm/test_integratorcp.py b/tests/functional/arm/test_integratorcp.py
index 23ae919359d5..b79e81393547 100755
--- a/tests/functional/arm/test_integratorcp.py
+++ b/tests/functional/arm/test_integratorcp.py
@@ -14,6 +14,7 @@
 
 import logging
 
+from qemu.qmp.qmp_client import ExecuteError
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import skipIfMissingImports, skipUntrustedTest
@@ -72,11 +73,13 @@ def test_framebuffer_tux_logo(self):
         self.boot_integratorcp()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='screendump %s' % screendump_path)
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        self.vm.cmd('stop')
+        try:
+            self.vm.cmd('screendump', filename=screendump_path)
+        except ExecuteError as e:
+            if e.error_class == 'CommandNotFound':
+                self.skipTest('screendump command not found')
+            raise
 
         cpu_count = 1
         match_threshold = 0.92
diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index d917cf5424fe..f3d92034b127 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -9,6 +9,7 @@
 
 import time
 
+from qemu.qmp.qmp_client import ExecuteError
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import skipIfMissingImports, skipIfMissingCommands
 from qemu_test.tesseract import tesseract_ocr
@@ -39,10 +40,12 @@ def check_bootrom_framebuffer(self, screenshot_path):
                 break
             time.sleep(0.1)
 
-        res = self.vm.cmd('human-monitor-command',
-                          command_line=f"screendump {screenshot_path}")
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        try:
+            self.vm.cmd('screendump', filename=screenshot_path)
+        except ExecuteError as e:
+            if e.error_class == 'CommandNotFound':
+                self.skipTest('screendump command not found')
+            raise
 
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index 163bbaf5ca36..3b6d53799616 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -11,6 +11,7 @@
 
 import os
 
+from qemu.qmp.qmp_client import ExecuteError
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
@@ -154,11 +155,13 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         self.vm.launch()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         self.wait_for_console_pattern(framebuffer_ready)
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        res = self.vm.cmd('human-monitor-command',
-                          command_line=f'screendump {screendump_path}')
-        if 'unknown command' in res:
-            self.skipTest('screendump not available')
+        self.vm.cmd('stop')
+        try:
+            self.vm.cmd('screeandump', filename=screendump_path)
+        except ExecuteError as e:
+            if e.error_class == 'CommandNotFound':
+                self.skipTest('screendump command not found')
+            raise
 
         match_threshold = 0.95
         screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)

-- 
2.55.0.543.g5ebe2ebe4ea8


