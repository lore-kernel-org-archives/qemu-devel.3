Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B9AC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASz-0000bS-U0; Tue, 25 Mar 2025 16:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASQ-0000V5-0d
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASN-0002i5-J8
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoAhBr9atFbCUVyAYuIo4C09XPH1YR1z+WJjp38g6Fc=;
 b=JfZLTV1Ka10Rulf3HAgs6ISKSfcGDtOkzdR5UHpbJ/bxbma+I4Z1qIB+dHAOcn7C9KkkTX
 JL3Ml24GsVsqg1M/CNKzUJyftoI1wGjCB/n2HVEK7iuA6h7PVHQDQYkokCA7qewbOKxSbG
 tKw733bR5PexLRM1WLPyvlHDaYjZTNw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Yy_9Up50P02dNStRepbYpg-1; Tue,
 25 Mar 2025 16:00:57 -0400
X-MC-Unique: Yy_9Up50P02dNStRepbYpg-1
X-Mimecast-MFC-AGG-ID: Yy_9Up50P02dNStRepbYpg_1742932856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9752E180035C; Tue, 25 Mar 2025 20:00:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89C211801747; Tue, 25 Mar 2025 20:00:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/15] tests/functional: Convert the 64-bit little endian
 Wheezy mips test
Date: Tue, 25 Mar 2025 21:00:16 +0100
Message-ID: <20250325200026.344006-9-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Reuse the test function from the 32-bit big endian test to easily
convert the 64-bit little endian Wheezy mips test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/linux_ssh_mips_malta.py   |  8 --------
 tests/functional/meson.build            |  1 +
 tests/functional/test_mips64el_malta.py | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
index c1300aec961..2fa5cf9a6c1 100644
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ b/tests/avocado/linux_ssh_mips_malta.py
@@ -179,11 +179,3 @@ def test_mips_malta64eb_kernel3_2_0(self):
         :avocado: tags=device:pcnet32
         """
         self.check_mips_malta('mips64', 'be')
-
-    def test_mips_malta64el_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=endian:little
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips64', 'le')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c7bd4eb4edf..63876bc7c42 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -42,6 +42,7 @@ test_timeouts = {
   'mips_malta' : 480,
   'mipsel_malta' : 420,
   'mipsel_replay' : 480,
+  'mips64el_malta' : 420,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index a8da15a26b3..dd37212f9df 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -16,6 +16,8 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
 
+from test_mips_malta import mips_check_wheezy
+
 
 class MaltaMachineConsole(LinuxKernelTest):
 
@@ -90,6 +92,26 @@ def test_mips64el_malta_5KEc_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'vmlinux-3.2.0-4-5kc-malta'),
+        '5e8b725244c59745bb8b64f5d8f49f25fecfa549f3395fb6d19a3b9e5065b85b')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mipsel/'
+         'debian_wheezy_mipsel_standard.qcow2'),
+        '454f09ae39f7e6461c84727b927100d2c7813841f2a0a5dce328114887ecf914')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line, cpuinfo='MIPS 20Kc',
+            dl_file='/boot/initrd.img-3.2.0-4-5kc-malta',
+            hsum='7579f8b56c1187c7c04d0dc3c0c56c7a6314c5ddd3a9bf8803ecc7cf8a3be9f8')
+
 
 @skipIfMissingImports('numpy', 'cv2')
 class MaltaMachineFramebuffer(LinuxKernelTest):
-- 
2.49.0


