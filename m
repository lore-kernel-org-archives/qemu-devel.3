Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E956CF258C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdXB-0003JR-8c; Wed, 19 Nov 2025 03:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdX7-0003Ff-Fd
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdX5-0000uP-KP
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+q3mVibePYLUik1mVn4Fz+mDEP/c6DtcHtf4f9LUDRw=;
 b=g9N8XNkszY2JeN/ijBBAzepyZUnewYQ1v7rcl5srFqUCHz6dJ9qL0SkwGctaHW8nYO1+2I
 ZkI+E4mYP38saMcvA6MPcU18dpL3tfTAAzlouLCpan2WOBpAZK97VLL2C1kO8DeP+SPz6+
 66/CWjmscoazoP+RmS1vtCXW//fGgLM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-bBmgug75OuKRzpzfjvhSaQ-1; Wed,
 19 Nov 2025 03:27:14 -0500
X-MC-Unique: bBmgug75OuKRzpzfjvhSaQ-1
X-Mimecast-MFC-AGG-ID: bBmgug75OuKRzpzfjvhSaQ_1763540831
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FAEF18AB428; Wed, 19 Nov 2025 08:27:11 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F313180047F; Wed, 19 Nov 2025 08:27:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 04/15] tests/functional/x86_64/test_virtio_gpu: Fix
 various issues reported by pylint
Date: Wed, 19 Nov 2025 09:26:25 +0100
Message-ID: <20251119082636.43286-5-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the recommended order for import statements, specify the kind of
exceptions that we try to catch, use f-strings where it makes sense,
rewrite the vug_log_file part with a proper "with" statement and
fix some FIXMEs by checking for the availability of the devices, etc.

Message-Id: <20251113114015.490303-1-thuth@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/test_virtio_gpu.py | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tests/functional/x86_64/test_virtio_gpu.py b/tests/functional/x86_64/test_virtio_gpu.py
index be96de24da2..58b0f72ba42 100755
--- a/tests/functional/x86_64/test_virtio_gpu.py
+++ b/tests/functional/x86_64/test_virtio_gpu.py
@@ -5,22 +5,23 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
+import socket
+import subprocess
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import is_readable_executable_file
 
-
-import os
-import socket
-import subprocess
+from qemu.machine.machine import VMLaunchFailure
 
 
 def pick_default_vug_bin(test):
     bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost-user-gpu")
     if is_readable_executable_file(bld_dir_path):
         return bld_dir_path
+    return None
 
 
 class VirtioGPUx86(QemuSystemTest):
@@ -46,8 +47,8 @@ def wait_for_console_pattern(self, success_message, vm=None):
         )
 
     def test_virtio_vga_virgl(self):
-        # FIXME: should check presence of virtio, virgl etc
         self.require_accelerator('kvm')
+        self.require_device('virtio-vga-gl')
 
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
@@ -68,7 +69,7 @@ def test_virtio_vga_virgl(self):
         )
         try:
             self.vm.launch()
-        except:
+        except VMLaunchFailure:
             # TODO: probably fails because we are missing the VirGL features
             self.skipTest("VirGL not enabled?")
 
@@ -78,8 +79,8 @@ def test_virtio_vga_virgl(self):
         )
 
     def test_vhost_user_vga_virgl(self):
-        # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
         self.require_accelerator('kvm')
+        self.require_device('vhost-user-vga')
 
         vug = pick_default_vug_bin(self)
         if not vug:
@@ -95,27 +96,29 @@ def test_vhost_user_vga_virgl(self):
         os.set_inheritable(qemu_sock.fileno(), True)
         os.set_inheritable(vug_sock.fileno(), True)
 
-        self._vug_log_path = self.log_file("vhost-user-gpu.log")
-        self._vug_log_file = open(self._vug_log_path, "wb")
-        self.log.info('Complete vhost-user-gpu.log file can be '
-                      'found at %s', self._vug_log_path)
-
-        vugp = subprocess.Popen(
-            [vug, "--virgl", "--fd=%d" % vug_sock.fileno()],
-            stdin=subprocess.DEVNULL,
-            stdout=self._vug_log_file,
-            stderr=subprocess.STDOUT,
-            shell=False,
-            close_fds=False,
-        )
-        self._vug_log_file.close()
-
+        vug_log_path = self.log_file("vhost-user-gpu.log")
+        self.log.info('Complete vhost-user-gpu.log file can be found at %s',
+                      vug_log_path)
+        with open(vug_log_path, "wb") as vug_log_file:
+            with subprocess.Popen([vug, "--virgl", f"--fd={vug_sock.fileno()}"],
+                                  stdin=subprocess.DEVNULL,
+                                  stdout=vug_log_file,
+                                  stderr=subprocess.STDOUT,
+                                  shell=False,
+                                  close_fds=False) as vugp:
+                self._test_vhost_user_vga_virgl(qemu_sock,
+                                                kernel_path, initrd_path)
+                qemu_sock.close()
+                vug_sock.close()
+                vugp.terminate()
+
+    def _test_vhost_user_vga_virgl(self, qemu_sock, kernel_path, initrd_path):
         self.vm.set_console()
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
         self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
-        self.vm.add_args("-chardev", "socket,id=vug,fd=%d" % qemu_sock.fileno())
+        self.vm.add_args("-chardev", f"socket,id=vug,fd={qemu_sock.fileno()}")
         self.vm.add_args("-device", "vhost-user-vga,chardev=vug")
         self.vm.add_args("-display", "egl-headless")
         self.vm.add_args(
@@ -128,17 +131,14 @@ def test_vhost_user_vga_virgl(self):
         )
         try:
             self.vm.launch()
-        except:
+        except VMLaunchFailure:
             # TODO: probably fails because we are missing the VirGL features
             self.skipTest("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
                                           "features: +virgl +edid")
         self.vm.shutdown()
-        qemu_sock.close()
-        vug_sock.close()
-        vugp.terminate()
-        vugp.wait()
+
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.1


