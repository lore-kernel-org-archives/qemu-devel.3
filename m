Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E984D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qb-0003gY-5I; Fri, 29 Nov 2024 12:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qU-0003Z6-CF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qS-0000vA-Jl
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BUYSjvolfDFV0ebffP6TEYi5KdSjqHPy0TkERoTTJE=;
 b=fZ6zzuUjTWorin3FmIuNhrcSiCkNExQjddOFJhbO2L2xwELHJttW+dCriGIKl39EYFQree
 iQF2hnHUj/8aTZ4pcXOafD1ZciM8oCDBPiKsKHKeUYZb5kHhwKIxXW+MCFydBUKEfE3B65
 Ss44qTbb//EtAbp2bOfwJR8awOsLejU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-58q73RILOVulhGZ_XZbtUg-1; Fri,
 29 Nov 2024 12:31:52 -0500
X-MC-Unique: 58q73RILOVulhGZ_XZbtUg-1
X-Mimecast-MFC-AGG-ID: 58q73RILOVulhGZ_XZbtUg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 359BF1955F68; Fri, 29 Nov 2024 17:31:51 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35DA61955F41; Fri, 29 Nov 2024 17:31:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/22] tests/functional: switch over to using
 self.build_file(...)
Date: Fri, 29 Nov 2024 17:31:08 +0000
Message-ID: <20241129173120.761728-11-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This removes direct access of the 'BUILD_DIR' variable.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 4 ++--
 tests/functional/test_aarch64_virt.py  | 6 +++---
 tests/functional/test_virtio_gpu.py    | 9 ++++-----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 5b1e6ba04f..2f32742387 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -127,8 +127,8 @@ def setUp(self, bin_prefix):
         self.arch = self.qemu_bin.split('-')[-1]
         self.socketdir = None
 
-        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
-                                      self.arch, self.id())
+        self.outputdir = self.build_file('tests', 'functional',
+                                         self.arch, self.id())
         self.workdir = os.path.join(self.outputdir, 'scratch')
         os.makedirs(self.workdir, exist_ok=True)
 
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 07b78f6a84..29eeb8e32d 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -14,7 +14,7 @@
 import os
 import logging
 
-from qemu_test import (BUILD_DIR, QemuSystemTest, Asset, exec_command,
+from qemu_test import (QemuSystemTest, Asset, exec_command,
                        wait_for_console_pattern, get_qemu_img, run_cmd)
 
 
@@ -52,8 +52,8 @@ def test_alpine_virt_tcg_gic_max(self):
                          "mte=on,"
                          "gic-version=max,iommu=smmuv3")
         self.vm.add_args("-smp", "2", "-m", "1024")
-        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
-                                               'edk2-aarch64-code.fd'))
+        self.vm.add_args('-bios', self.build_file('pc-bios',
+                                                  'edk2-aarch64-code.fd'))
         self.vm.add_args("-drive", f"file={iso_path},media=cdrom,format=raw")
         self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
         self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index c4562618d9..39dcf376dd 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -6,8 +6,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from qemu_test import (BUILD_DIR, QemuSystemTest, Asset,
-                       wait_for_console_pattern,
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
                        exec_command_and_wait_for_pattern,
                        is_readable_executable_file)
 from qemu.utils import kvm_available
@@ -17,12 +16,12 @@
 import subprocess
 
 
-def pick_default_vug_bin():
+def pick_default_vug_bin(test):
     relative_path = "./contrib/vhost-user-gpu/vhost-user-gpu"
     if is_readable_executable_file(relative_path):
         return relative_path
 
-    bld_dir_path = os.path.join(BUILD_DIR, relative_path)
+    bld_dir_path = test.build_file(relative_path)
     if is_readable_executable_file(bld_dir_path):
         return bld_dir_path
 
@@ -85,7 +84,7 @@ def test_vhost_user_vga_virgl(self):
         # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
         self.require_accelerator('kvm')
 
-        vug = pick_default_vug_bin()
+        vug = pick_default_vug_bin(self)
         if not vug:
             self.skipTest("Could not find vhost-user-gpu")
 
-- 
2.46.0


