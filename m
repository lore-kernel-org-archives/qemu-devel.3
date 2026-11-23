Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE8606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQVL-0005Ql-AO; Mon, 23 Nov 2026 04:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVF-0005PX-3O; Mon, 23 Nov 2026 04:38:25 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVD-0003V0-2c; Mon, 23 Nov 2026 04:38:24 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6ACAB418F2;
 Mon, 23 Nov 2026 10:38:13 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com
Subject: [PATCH v4 2/2] iotests/041: add test for duplicate job-complete with
 throttled target
Date: Mon, 23 Nov 2026 10:37:41 +0100
Message-ID: <20261123093808.185781-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123093808.185781-1-f.ebner@proxmox.com>
References: <20261123093808.185781-1-f.ebner@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795426692444
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This would fail without commit 9ac85f4cc7 ("block/mirror: fix
assertion failure upon duplicate complete for job using 'replaces'").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---

Changes in v4:
* Rebase on current master.

 tests/qemu-iotests/041     | 31 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index ea03a9ace5..d251516da7 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1650,6 +1650,37 @@ class TestThrottledNBDTarget(iotests.QMPTestCase):
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
index 4fad1fcbcf..8295da2ffc 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..................................................................................................................
+...................................................................................................................
 ----------------------------------------------------------------------
-Ran 114 tests
+Ran 115 tests
 
 OK
-- 
2.47.3



