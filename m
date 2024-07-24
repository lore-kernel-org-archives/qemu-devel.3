Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F614C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgCx-0001F6-V3; Wed, 24 Jul 2024 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCH-00068V-09
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCC-0005xK-Ke
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUe7Q96P9b55uMJqmEeKA60XBXRo4Xodz951JEg/wy4=;
 b=VyiplDIlGynbOKiW+QOSqGrBn4/rmtpGeS7e0MSfIP4k0vRViV8+n/fuGCz2sNdI7U8AVx
 w/DO8ZZsmuZJOY/rQjhou/ehOP3NoRRbAoz8frcUTxwte9P9nbhsNCiuIEmrmU3Hqm/CQP
 scwXNmSiuYL8YkpVkj9hXWVq4NCkSz4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-rCinRGmHOfOBDZbleE5iDw-1; Wed,
 24 Jul 2024 13:54:30 -0400
X-MC-Unique: rCinRGmHOfOBDZbleE5iDw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6A331955BF1; Wed, 24 Jul 2024 17:54:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E8931955D45; Wed, 24 Jul 2024 17:54:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 16/23] tests/functional: Convert the virtio_gpu avocado
 test into a standalone test
Date: Wed, 24 Jul 2024 19:52:34 +0200
Message-ID: <20240724175248.1389201-17-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Nothing thrilling in here, it's just a straight forward conversion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_virtio_gpu.py}                       | 34 ++++++++-----------
 2 files changed, 16 insertions(+), 19 deletions(-)
 rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (88%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ebc6e2d1c6..91fe835e8f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -82,6 +82,7 @@ tests_x86_64_quick = [
 
 tests_x86_64_thorough = [
   'netdev_ethtool',
+  'virtio_gpu',
 ]
 
 foreach speed : ['quick', 'thorough']
diff --git a/tests/avocado/virtio-gpu.py b/tests/functional/test_virtio_gpu.py
old mode 100644
new mode 100755
similarity index 88%
rename from tests/avocado/virtio-gpu.py
rename to tests/functional/test_virtio_gpu.py
index 6091f614a4..911b4119c6
--- a/tests/avocado/virtio-gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -1,14 +1,16 @@
+#!/usr/bin/env python3
+#
 # virtio-gpu tests
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
 
-from avocado_qemu import BUILD_DIR
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import is_readable_executable_file
+from qemu_test import BUILD_DIR
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
 
 from qemu.utils import kvm_available
 
@@ -28,11 +30,6 @@ def pick_default_vug_bin():
 
 
 class VirtioGPUx86(QemuSystemTest):
-    """
-    :avocado: tags=virtio-gpu
-    :avocado: tags=arch:x86_64
-    :avocado: tags=cpu:host
-    """
 
     KERNEL_COMMAND_LINE = "printk.time=0 console=ttyS0 rdinit=/bin/bash"
     KERNEL_URL = (
@@ -57,9 +54,6 @@ def wait_for_console_pattern(self, success_message, vm=None):
         )
 
     def test_virtio_vga_virgl(self):
-        """
-        :avocado: tags=device:virtio-vga-gl
-        """
         # FIXME: should check presence of virtio, virgl etc
         self.require_accelerator('kvm')
 
@@ -67,6 +61,7 @@ def test_virtio_vga_virgl(self):
         initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-machine", "pc,accel=kvm")
         self.vm.add_args("-device", "virtio-vga-gl")
@@ -83,7 +78,7 @@ def test_virtio_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
 
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(
@@ -92,15 +87,12 @@ def test_virtio_vga_virgl(self):
         self.wait_for_console_pattern("features: +virgl +edid")
 
     def test_vhost_user_vga_virgl(self):
-        """
-        :avocado: tags=device:vhost-user-vga
-        """
         # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
         self.require_accelerator('kvm')
 
         vug = pick_default_vug_bin()
         if not vug:
-            self.cancel("Could not find vhost-user-gpu")
+            self.skipTest("Could not find vhost-user-gpu")
 
         kernel_path = self.fetch_asset(self.KERNEL_URL, self.KERNEL_HASH)
         initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
@@ -129,6 +121,7 @@ def test_vhost_user_vga_virgl(self):
         )
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
         self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
@@ -147,7 +140,7 @@ def test_vhost_user_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
                                           "features: +virgl +edid")
@@ -155,3 +148,6 @@ def test_vhost_user_vga_virgl(self):
         qemu_sock.close()
         vugp.terminate()
         vugp.wait()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


