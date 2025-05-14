Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2460C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAHP-0001ZK-JA; Wed, 14 May 2025 07:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHL-0001Xx-71
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHI-0002Fg-V6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBT4hYmsb0TweLp2rWxreoLY89nvdW4z8t01VceREM8=;
 b=f2bmq1wpQyHgj5MJAG7fU/095h4e0DA4wkl997cEXKxZRy+iXS4uknDi7UrtQdTsmN2KUf
 1a1ttAoIC8ORmbO0kDmojpZ8TDtk6W2v5CBy8qNyhAKAZwxkdnME+sbSzIVhCB7147DZqu
 Sa9rJ8WJ9tT1NvRKsRrxEjGWibHFEyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-_H0Hs5hvO82bMQujnYW9ew-1; Wed,
 14 May 2025 07:27:58 -0400
X-MC-Unique: _H0Hs5hvO82bMQujnYW9ew-1
X-Mimecast-MFC-AGG-ID: _H0Hs5hvO82bMQujnYW9ew_1747222078
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C6D71800115
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 11:27:58 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 360F219560A3; Wed, 14 May 2025 11:27:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 13/13] tests/functional: Skip the screendump tests if the
 command is not available
Date: Wed, 14 May 2025 13:27:33 +0200
Message-ID: <20250514112733.456644-14-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

It is possible nowadays to compile QEMU without pixman support - in that
case the screendump command is not available and the related tests fail.
Thus skip these tests if the screendump command could not be executed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250325081713.283490-2-thuth@redhat.com>
---
 tests/functional/test_arm_integratorcp.py | 6 ++++--
 tests/functional/test_m68k_nextcube.py    | 6 ++++--
 tests/functional/test_mips64el_malta.py   | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
index a85b339d772..4f00924aa03 100755
--- a/tests/functional/test_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -73,8 +73,10 @@ def test_framebuffer_tux_logo(self):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screendump_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
         logger = logging.getLogger('framebuffer')
 
         cpu_count = 1
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index ff773a7994f..13c72bd136a 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -32,8 +32,10 @@ def check_bootrom_framebuffer(self, screenshot_path):
         # TODO: wait for the 'displaysurface_create 1120x832' trace-event.
         time.sleep(2)
 
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screenshot_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screenshot_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
 
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index dd37212f9df..3cc79b74c18 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -155,8 +155,10 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         self.wait_for_console_pattern(framebuffer_ready)
         self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='screendump %s' % screendump_path)
+        if 'unknown command' in res:
+            self.skipTest('screendump not available')
         logger = logging.getLogger('framebuffer')
 
         match_threshold = 0.95
-- 
2.49.0


