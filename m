Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A0C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWq4-0007ei-P2; Wed, 22 Jan 2025 04:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taWpp-0007cQ-9U
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taWpn-0004x5-Dt
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737537337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LBm4xsqcyi0CTkYq7bhZmD9hUKCAAfGetIKqX1St/f8=;
 b=MbWc17k0txCBRqSkfQ8ddVvi1tTVFWEVDZF5LNbiZ/3eZuucdueJRHluYjtlUO6yy8beMD
 pze+zAcJv6Cy6caNj4tKDXzNeDV4RwFJI8DYJDRDIEscdt1f0d9AnKuC3DZHBFtEkoYnL1
 hoXvXZOSMY3FOLE4i4qJHlHZHBnBWWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-ubrmFrhAN56xbb5Wh4TdvQ-1; Wed,
 22 Jan 2025 04:15:31 -0500
X-MC-Unique: ubrmFrhAN56xbb5Wh4TdvQ-1
X-Mimecast-MFC-AGG-ID: ubrmFrhAN56xbb5Wh4TdvQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EB851955F69; Wed, 22 Jan 2025 09:15:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB257195608A; Wed, 22 Jan 2025 09:15:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional: Fix the aarch64_tcg_plugins test
Date: Wed, 22 Jan 2025 10:15:17 +0100
Message-ID: <20250122091517.1429734-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Unfortunately, this test had not been added to meson.build, so we did
not notice a regression: Looking for 'Kernel panic - not syncing: VFS:'
as the indication for the final boot state of the kernel was a bad
idea since 'Kernel panic - not syncing' is the default failure
message of the LinuxKernelTest class, and since we're now reading
the console input byte by byte instead of linewise (see commit
cdad03b74f75), the failure now triggers before we fully read the
success string. Let's fix this by simply looking for the previous
line in the console output instead.

Also, replace the call to cancel() - this was only available in the
Avocado framework. In the functional framework, we must use skipTest()
instead.

Fixes: 3abc545e66 ("tests/functional: Convert the tcg_plugins test")
Fixes: cdad03b74f ("tests/functional: rewrite console handling to be bytewise")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                 | 1 +
 tests/functional/test_aarch64_tcg_plugins.py | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 5457331643..e0a276f349 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -72,6 +72,7 @@ tests_aarch64_system_thorough = [
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
+  'aarch64_tcg_plugins',
   'aarch64_tuxrun',
   'aarch64_virt',
   'aarch64_xlnx_versal',
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 01660eb090..357eb48477 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -46,7 +46,7 @@ def run_vm(self, kernel_path, kernel_command_line,
         except:
             # TODO: probably fails because plugins not enabled but we
             # can't currently probe for the feature.
-            self.cancel("TCG Plugins not enabled?")
+            self.skipTest("TCG Plugins not enabled?")
 
         self.wait_for_console_pattern(console_pattern, vm)
         # ensure logs are flushed
@@ -65,7 +65,7 @@ def test_aarch64_virt_insn(self):
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        console_pattern = 'Kernel panic - not syncing: VFS:'
+        console_pattern = 'Please append a correct "root=" boot option'
 
         plugin_log = tempfile.NamedTemporaryFile(mode="r+t", prefix="plugin",
                                                  suffix=".log")
@@ -91,7 +91,7 @@ def test_aarch64_virt_insn_icount(self):
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        console_pattern = 'Kernel panic - not syncing: VFS:'
+        console_pattern = 'Please append a correct "root=" boot option'
 
         plugin_log = tempfile.NamedTemporaryFile(mode="r+t", prefix="plugin",
                                                  suffix=".log")
-- 
2.48.1


