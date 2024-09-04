Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C763CCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRN-00040H-DI; Wed, 04 Sep 2024 06:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRG-0003Av-TO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRD-0000JE-J3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7+9G9J1HMF5PQuYeNwEa8IF2ct+txUWxNksvH1klOc=;
 b=bCXFmmHID3fsfPHEnaSExzVEahx3IsUW39hyjD8gwXjdO2Bv/h6b/y59tjvAXch5MQ0Us1
 BBO2SuAQZyqwbkgHP6ldk83gynXcADV6Oc1qXm6wWN/UiEq53iy0ql8LZBNxubA2hULhBf
 p72F7lFADp72Bb+TgH7o5ly9pAfMIIk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-_NBm42gvMva1Ln28fb77mw-1; Wed,
 04 Sep 2024 06:40:33 -0400
X-MC-Unique: _NBm42gvMva1Ln28fb77mw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B713B1956088; Wed,  4 Sep 2024 10:40:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17B5F195605A; Wed,  4 Sep 2024 10:40:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/42] tests/functional: Convert the virtio_gpu avocado test
 into a standalone test
Date: Wed,  4 Sep 2024 12:38:58 +0200
Message-ID: <20240904103923.451847-24-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-25-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_virtio_gpu.py}                       | 64 +++++++++----------
 2 files changed, 30 insertions(+), 35 deletions(-)
 rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (73%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b721b6ec44..8e4ea9cff7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -79,6 +79,7 @@ tests_x86_64_system_quick = [
 
 tests_x86_64_system_thorough = [
   'netdev_ethtool',
+  'virtio_gpu',
 ]
 
 precache_all = []
diff --git a/tests/avocado/virtio-gpu.py b/tests/functional/test_virtio_gpu.py
old mode 100644
new mode 100755
similarity index 73%
rename from tests/avocado/virtio-gpu.py
rename to tests/functional/test_virtio_gpu.py
index 6091f614a4..441cbdcf2d
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
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
 
 from qemu.utils import kvm_available
 
@@ -28,25 +30,18 @@ def pick_default_vug_bin():
 
 
 class VirtioGPUx86(QemuSystemTest):
-    """
-    :avocado: tags=virtio-gpu
-    :avocado: tags=arch:x86_64
-    :avocado: tags=cpu:host
-    """
 
     KERNEL_COMMAND_LINE = "printk.time=0 console=ttyS0 rdinit=/bin/bash"
-    KERNEL_URL = (
-        "https://archives.fedoraproject.org/pub/archive/fedora"
-        "/linux/releases/33/Everything/x86_64/os/images"
-        "/pxeboot/vmlinuz"
-    )
-    KERNEL_HASH = '1433cfe3f2ffaa44de4ecfb57ec25dc2399cdecf'
-    INITRD_URL = (
-        "https://archives.fedoraproject.org/pub/archive/fedora"
-        "/linux/releases/33/Everything/x86_64/os/images"
-        "/pxeboot/initrd.img"
-    )
-    INITRD_HASH = 'c828d68a027b53e5220536585efe03412332c2d9'
+    ASSET_KERNEL = Asset(
+        ("https://archives.fedoraproject.org/pub/archive/fedora"
+         "/linux/releases/33/Everything/x86_64/os/images"
+         "/pxeboot/vmlinuz"),
+        '2dc5fb5cfe9ac278fa45640f3602d9b7a08cc189ed63fd9b162b07073e4df397')
+    ASSET_INITRD = Asset(
+        ("https://archives.fedoraproject.org/pub/archive/fedora"
+         "/linux/releases/33/Everything/x86_64/os/images"
+         "/pxeboot/initrd.img"),
+        'c49b97f893a5349e4883452178763e402bdc5caa8845b226a2d1329b5f356045')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(
@@ -57,16 +52,14 @@ def wait_for_console_pattern(self, success_message, vm=None):
         )
 
     def test_virtio_vga_virgl(self):
-        """
-        :avocado: tags=device:virtio-vga-gl
-        """
         # FIXME: should check presence of virtio, virgl etc
         self.require_accelerator('kvm')
 
-        kernel_path = self.fetch_asset(self.KERNEL_URL, self.KERNEL_HASH)
-        initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-machine", "pc,accel=kvm")
         self.vm.add_args("-device", "virtio-vga-gl")
@@ -83,7 +76,7 @@ def test_virtio_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
 
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(
@@ -92,18 +85,15 @@ def test_virtio_vga_virgl(self):
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
 
-        kernel_path = self.fetch_asset(self.KERNEL_URL, self.KERNEL_HASH)
-        initrd_path = self.fetch_asset(self.INITRD_URL, self.INITRD_HASH)
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
 
         # Create socketpair to connect proxy and remote processes
         qemu_sock, vug_sock = socket.socketpair(
@@ -129,6 +119,7 @@ def test_vhost_user_vga_virgl(self):
         )
 
         self.vm.set_console()
+        self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
         self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
@@ -147,7 +138,7 @@ def test_vhost_user_vga_virgl(self):
             self.vm.launch()
         except:
             # TODO: probably fails because we are missing the VirGL features
-            self.cancel("VirGL not enabled?")
+            self.skipTest("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
                                           "features: +virgl +edid")
@@ -155,3 +146,6 @@ def test_vhost_user_vga_virgl(self):
         qemu_sock.close()
         vugp.terminate()
         vugp.wait()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


