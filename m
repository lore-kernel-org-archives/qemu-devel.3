Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5EFED3CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHBa-0002Yv-9Z; Fri, 24 Apr 2026 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBY-0002Yf-1R
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBU-0007Oc-Ln
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:11 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63OE6rPa008037
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 23:06:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7G78Igp1Lu4v5hrzs81W2MRUUjdazJoXCvgc1oemwsU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777039614; v=1;
 b=I+86AiLMnFnJDxIxqZaO5Min/1beEcY3PNZoegX8oO7wWphDoNVAZNoYHzbQVzby
 JNYQw/0tpo+jlm/LU04ezqi8EvkIaHa1MTaUpy54n4eoZ3yRhjS/X5OzIHDWQ0jv
 1Wq1GoUXMg/T+ev7bNWqWUmulJXHuXk9Vm8gyYalqj2mEomSAGY88olhlAbHKLai
 S2fIj2NBCoGBvU4g4r7ql8HvrwiT3OCbKjXNk/Irtc4OkawJilTPGxnV1bC8t5sh
 EGZOxtrMZQse0DX3ar0AgNbKEMfnLqVVHjBRSI26hYqEmpwkA5q7bhBTSLOCpK3w
 FV8ibtY3Trin2WcgjqJc9Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/2] virtio-gpu: Do not wait for the main thread during
 reset
Date: Fri, 24 Apr 2026 23:06:40 +0900
Message-Id: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOQQ6DIBBFr2JmXQigxuiq92hcIB112lgsIKkx3
 r1UV12+yZ/3/wYeHaGHJtvAYSRP9pVAXTIwo34NyOieGJRQpRSqZsO8MJP3RVkVVV91GlJydtj
 T57Dc2sQj+WDdekij/F3//6NkkmGOuakQO1Pj1fmBG+LEFxbsc7VcG/6Yod1Pu8P3kqaFswI67
 ZEZO00UmixKyQUXKbt/AY0yuJ7OAAAA
X-Change-ID: 20251029-gpu-c3f45747f7ba
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

This fixes a deadlock I previously observed with the test in [1].

However, I can no longer reproduce the issue reliably with that test, so
I used Codex, a coding agent, to write a more reliable local test case,
shown below. I applied to Codex for Open Source to get access. The test
case is not intended for merge: current policy prohibits that, and it is
probably not worth carrying anyway because race-condition tests are
inherently fragile. The remaining patches were written by me.

[1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/

To: qemu-devel@nongnu.org
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Below is the Codex-written test case:

diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/functional/aarch64/test_gpu_blob.py
index a913d3b29c84..52627b4541f9 100755
--- a/tests/functional/aarch64/test_gpu_blob.py
+++ b/tests/functional/aarch64/test_gpu_blob.py
@@ -13,7 +13,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu.machine.machine import VMLaunchFailure
+import subprocess
+
+from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure
 
 from qemu_test import Asset
 from qemu_test import wait_for_console_pattern
@@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):
                        'download?path=%2Fblob-test&files=qemu-880.bin',
                        '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34e42eb')
 
-    def test_virtio_gpu_blob(self):
-
+    def launch_blob_test(self):
         self.set_machine('virt')
         self.require_accelerator("tcg")
 
@@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
 
+    def test_virtio_gpu_blob(self):
+        self.launch_blob_test()
+
         self.wait_for_console_pattern('[INFO] virtio-gpu test finished')
         # the test should cleanly exit
 
+    def test_virtio_gpu_blob_shutdown_race(self):
+        self.launch_blob_test()
+
+        self.wait_for_console_pattern('[INFO] unmapping blob object resource')
+
+        try:
+            self.vm.shutdown(timeout=10)
+        except AbnormalShutdown as excp:
+            if isinstance(excp.__cause__, subprocess.TimeoutExpired):
+                raise AssertionError(
+                    "QEMU failed to exit while virtio-gpu reset was racing "
+                    "with shutdown") from excp
+            self.log.info("QEMU exited before the shutdown request completed: %s",
+                          excp)
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()

---
Changes in v2:
- Added the patch "virtio-gpu: Run reset cleanup in the same BH".
- My assumption about the ordering was incorrect, so I changed the patch
  to follow the approach used by virtio-gpu-gl.
- Link to v1: https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (2):
      virtio-gpu: Run reset cleanup in the same BH
      virtio-gpu: Do not wait for the main thread during reset

 include/hw/virtio/virtio-gpu.h |  4 +--
 hw/display/virtio-gpu.c        | 60 ++++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 34 deletions(-)
---
base-commit: 14f38a63b9adc02c0ebe3b5ada1f1208abaf21ea
change-id: 20251029-gpu-c3f45747f7ba

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


