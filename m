Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E76C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5I-00027x-AB; Tue, 08 Sep 2026 02:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5C-00023c-Fv; Tue, 08 Sep 2026 02:13:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p58-0000jk-GQ; Tue, 08 Sep 2026 02:13:26 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG8v048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3wjH0e5JQ8wLuNyiv2/dVG4sWQoGp7DphpquhKTENgE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847946; v=1;
 b=pKaZ4zth1xRJaPMX3cEse9bEdPM2RdKzVYpwrgmVuu7Q00s8ORNeAA3yeFf0WWbz
 VvX9QkJIfLfDuuTUi5gjAE7zoX1Al7gMn9rZSbX66bimsboTtwq9Up5iAXg10KgD
 SfVGqQgInfYxjpG8mjPD0ju3/dizitTyqT2mIudBOWCfLD0Cij1SkkZ3fEhjOala
 OZh6jj86sUb/Z/shjdvCCDdNvXwswl+sWQVNPc0k8nJDzZb86/C88aMFPAhfz6Br
 BsgnXzZcVCYgyQUUGyN02TgjOHTj8HimgYkTL1HRG+QZdwfxGywDp7ELHOK4NS3N
 qQ5frFQJ0c/x27p86nAZig==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during
 reset
Date: Tue, 08 Sep 2026 15:11:17 +0900
Message-Id: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPTW7DIBAF4KtYrAvi14Sseo+qCxgGh1YJLthWo
 yh3L4nVRRddvqeZTzM30rBmbOQ43EjFLbdcLj2ol4HAyV8mpDn2TCSXRnDp6DSvFFTSxmqbbPC
 kT84VU/5+Km/vPZ9yW0q9PtFNPNq/+5uggqJCBRYxgMPX2iYGmWW20qV8XgvzwD5m8sA2+QuMX
 Eu9A5Jy6lKUCXiMIsR/gft+XsWvtf+27DeS4BtSKOdzXo5DlGgsB+DJ2eDU6Lj0JohwGINVvTX
 OHYK2pmP3H7y8uZ0wAQAA
X-Change-ID: 20251029-gpu-c3f45747f7ba
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=7343;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=IxKH4txKef2gooxhbGNKISeiB3/hau2P1OLZ5vUS2Pc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85Y4B9WuTX8xM8qpfv2WSwSzuyZ9WrXgozvIl34ftp
 bjgFR+3jlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIkoHWVkmN1ZLfiFp5XLP/zh
 +YtH5z6QmrOocp9cSVAD4xZm2y9nlzL897/GuIh7///MZie72KOF4dFiDInnDrxeb8pi+n8+T5c
 tLwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Compatibility note: This series makes virtio-gpu-rutabaga-device
incompatible with virtio-mmio-bus, as there is no straightforward way to
fix reset for this combination. I believe nobody uses it, but please let
me know if anyone relies on it.

Gurchetan, please confirm if this impacts the use case behind your
original virtio-gpu-rutabaga contribution.

=======================================================================

This series fixes a deadlock I previously observed with the test in [1].
It also fixes a command-ordering race exposed by the same BQL handoff,
along with command and fence lifetime and accounting issues found while
auditing device and virtqueue reset. Reset now drains command and fence
queues without dropping the BQL, while resource destruction and surface
replacement are deferred to the next control or cursor BH. Scanout state
needed for migration is cleared synchronously before that deferred
cleanup. The remaining patches detach popped queue elements before
freeing commands, track suspension independently of fencing, balance
inflight accounting, handle control-queue reset for the non-renderer
backend, and stop advertising queue reset for virtio-gpu-gl,
virtio-gpu-rutabaga, and vhost-user-gpu, whose current backend
interfaces cannot quiesce a single queue.

Finally, the virtio core changes split reset initiation from completion
so device reset handlers can choose when reset is complete. An error
during reset leaves the device broken and prevents its status from being
cleared. Rutabaga's same-thread API requires whole-device reset to
finish in the main-loop GPU BH, where the old backend is torn down and
reinitialized before completion is reported.

Note on the deadlock: I can no longer reproduce the issue reliably with
the test in [1], so I used Codex, a coding agent, to write a more
reliable local test case, shown below. I applied to Codex for Open
Source to get access. The test case is not intended for merge: current
policy prohibits that, and it is probably not worth carrying anyway
because race-condition tests are inherently fragile. The remaining
patches were written by me.

[1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/

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

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Rebased.
- Dropped the patch "virtio-gpu: Run reset cleanup in the same BH" and
  reworked reset cleanup to preserve control and cursor queue ordering
  and migration-visible state without dropping the BQL.
- Detached popped virtqueue elements before freeing reset commands.
- Added fixes for fenced blob unmapping and inflight counter accounting.
- Added control-queue reset handling for the non-renderer backend.
- Disabled queue reset for virtio-gpu-gl, virtio-gpu-rutabaga, and
  vhost-user-gpu, whose current backend interfaces cannot quiesce a
  single queue.
- Split virtio reset initiation from completion, moved completion into
  device reset handlers, and preserved errors raised during reset.
- Added Rutabaga teardown and reinitialization in the main-loop GPU BH
  before reporting whole-device reset completion.
- Link to v2: https://lore.kernel.org/qemu-devel/20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Added the patch "virtio-gpu: Run reset cleanup in the same BH".
- My assumption about the ordering was incorrect, so I changed the patch
  to follow the approach used by virtio-gpu-gl.
- Link to v1: https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (9):
      virtio: Introduce virtio_complete_reset()
      virtio: Move the virtio_complete_reset() call
      virtio: Preserve an error during reset
      hw/display/virtio-gpu-rutabaga: Reset Rutabaga
      virtio-gpu: Do not wait for the main thread during reset
      hw/display/virtio-gpu: Fix fenced blob unmapping
      hw/display/virtio-gpu: Balance inflight counter changes
      hw/display/virtio-gpu: Reject queue_reset when unsupported
      hw/display/virtio-gpu: Handle virtqueue reset

 include/hw/virtio/virtio-gpu.h   |   7 +-
 include/hw/virtio/virtio.h       |   1 +
 hw/9pfs/virtio-9p-device.c       |   1 +
 hw/audio/virtio-snd.c            |   2 +
 hw/block/vhost-user-blk.c        |   1 +
 hw/block/virtio-blk.c            |   1 +
 hw/char/virtio-serial-bus.c      |   1 +
 hw/display/vhost-user-gpu.c      |  10 ++-
 hw/display/virtio-gpu-base.c     |   2 +
 hw/display/virtio-gpu-gl.c       |  12 +++
 hw/display/virtio-gpu-rutabaga.c |  29 +++++++
 hw/display/virtio-gpu-virgl.c    |  25 +++---
 hw/display/virtio-gpu.c          | 174 +++++++++++++++++++++++++--------------
 hw/input/virtio-input.c          |   2 +
 hw/net/virtio-net.c              |   1 +
 hw/scsi/vhost-user-scsi.c        |   1 +
 hw/scsi/virtio-scsi.c            |   2 +
 hw/virtio/virtio-balloon.c       |   1 +
 hw/virtio/virtio-crypto.c        |   2 +
 hw/virtio/virtio.c               |  25 ++++--
 system/qdev-monitor.c            |   2 -
 21 files changed, 210 insertions(+), 92 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20251029-gpu-c3f45747f7ba

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


