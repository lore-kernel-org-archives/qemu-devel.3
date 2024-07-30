Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58CBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHo-00032i-Vr; Tue, 30 Jul 2024 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHf-0002LS-CL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHd-0002g9-1R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjlgpD5P7qLljlAU2U6tl3mQoLOHtwiybEiwl2bUdmw=;
 b=eTZWqrHBy13t+Ao6LVaxuE85EkxA5Emg06EDtAQME20DcCuIeVGS6PBRlqnx6woTTe3wcs
 QC0vtEyG1J/Z+IM36nOEbcrnc8VNdzpl2+EOGLTXvSgtrABzf9KPek1SeCYQIpfp0a9kDL
 qOLFDCZgiG9eFcjWXOgQ6Lcu4UpNpoQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-0N7extT0Pb-ho-UM_Pn7rQ-1; Tue,
 30 Jul 2024 13:05:03 -0400
X-MC-Unique: 0N7extT0Pb-ho-UM_Pn7rQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0425C1955D42; Tue, 30 Jul 2024 17:05:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FC0E3000193; Tue, 30 Jul 2024 17:04:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 17/24] tests/functional: Convert the virtio_gpu avocado
 test into a standalone test
Date: Tue, 30 Jul 2024 18:03:37 +0100
Message-ID: <20240730170347.4103919-18-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Nothing thrilling in here, it's just a straight forward conversion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_virtio_gpu.py}                       | 64 +++++++++----------
 2 files changed, 30 insertions(+), 35 deletions(-)
 rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (73%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 55021c4e4d..8fbd7c4129 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -82,6 +82,7 @@ tests_x86_64_quick = [
 
 tests_x86_64_thorough = [
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
index 6091f614a4..e74da39444
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
+        '1433cfe3f2ffaa44de4ecfb57ec25dc2399cdecf')
+    ASSET_INITRD = Asset(
+        ("https://archives.fedoraproject.org/pub/archive/fedora"
+         "/linux/releases/33/Everything/x86_64/os/images"
+         "/pxeboot/initrd.img"),
+        'c828d68a027b53e5220536585efe03412332c2d9')
 
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
2.45.2


