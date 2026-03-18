Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB6B10775E9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uAs-0000c3-BC; Wed, 18 Mar 2026 12:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w2uAf-0000Zd-UO; Wed, 18 Mar 2026 12:55:01 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w2uAd-0006IZ-0o; Wed, 18 Mar 2026 12:55:00 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 356474216F;
 Wed, 18 Mar 2026 17:54:55 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	hreitz@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 2/2] iotests/041: add test for duplicate job-complete with
 throttled target
Date: Wed, 18 Mar 2026 17:54:34 +0100
Message-ID: <20260318165446.709541-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318165446.709541-1-f.ebner@proxmox.com>
References: <20260318165446.709541-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773852852395
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This would fail without commit 9ac85f4cc7 ("block/mirror: fix
assertion failure upon duplicate complete for job using 'replaces'").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/041     | 31 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 7b4a701aba..22fe13d3fa 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1529,6 +1529,37 @@ class TestThrottledNBDTarget(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
+    def test_duplicate_complete_with_replaces(self):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    replaces='source',
+                    sync='full')
+
+        self.wait_ready(drive='mirror')
+
+        self.set_throttle_limits({'iops-write': 1})
+
+        # Issue requests that will be throttled.
+        for i in range(0, self.reqs):
+            req = f'aio_write -P 7 {i}M {self.req_len}'
+            self.vm.hmp_qemu_io(self.drive_qdev, req, qdev=True)
+
+        self.vm.cmd('job-complete', id='mirror')
+        # The fact that the target is externally throttled ensures that the job
+        # won't be finished yet when the second command is issued.
+        self.vm.cmd('job-complete', id='mirror')
+
+        self.disable_throttling()
+
+        self.wait_until_completed('mirror')
+
+        self.target_vm.shutdown()
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 5273ce86c3..96a0752f44 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-............................................................................................................
+.............................................................................................................
 ----------------------------------------------------------------------
-Ran 108 tests
+Ran 109 tests
 
 OK
-- 
2.47.3



