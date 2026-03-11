Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0522A112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLJ-0007Z4-Tk; Wed, 11 Mar 2026 15:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKv-0007Sb-4W; Wed, 11 Mar 2026 15:35:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKr-000056-RB; Wed, 11 Mar 2026 15:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257666; bh=AkGdtL1378GuYkw9TJKFVH4lXWbLXsqU//G2VlqmrT0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=o6FFREF6OdLxWQBA78ng80EZGxIAwha7top/k4P4rxq60CLjOOfhSGY2a5h64LV1N
 xZPokuIy660QnOof133zdLhP0a+Igv1bEG59uVNUuJe5hi9D35Iua5ahJDxg65Hew6
 12oUOpgQOhsVnLBEb2GJMniWMm2niehtjp4xF1G10hd80GO4AyOMhjn0SnSjzFnuYi
 pDpqc6JSHUZFkGh2+nGXAtlkjboIGKDeq43afDWpfcTb/8LJqci+j0j43fFSK/relk
 vzUtDbBBC5ww1/xyZaEFgrN6fKRmshc5NNimxmbheb4oyTIZeBVIUBshrDJyK/KTo4
 d781b6R9hfyGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 51CFA1920EC;
 Wed, 11 Mar 2026 22:34:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93C9C37C451;
 Wed, 11 Mar 2026 22:35:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 04/53] iotests: test active mirror with unaligned,
 small write zeroes op
Date: Wed, 11 Mar 2026 22:33:57 +0300
Message-ID: <20260311193449.1096110-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This tests the scenario fixed by "block/mirror: check range
when setting zero bitmap for sync write" [0].

[0] https://lore.kernel.org/qemu-devel/20260112152544.261923-1-f.ebner@proxmox.com/

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260120113859.251743-1-f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 267d7ae99a1d3b5be9d3421db3bdf651cc18c7ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 06ee3585db..9b9c815db5 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -191,6 +191,26 @@ class TestActiveMirror(iotests.QMPTestCase):
 
         self.potential_writes_in_flight = False
 
+    def testUnalignedSmallerThanGranularityWriteZeroes(self):
+        # Fill the source image
+        self.vm.hmp_qemu_io('source', 'write -P 1 0 %i' % self.image_len);
+
+        # Start the block job
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking')
+
+        # Wait for the READY event
+        self.wait_ready(drive='mirror')
+
+        for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 512' % (offset + 512))
+
+        self.complete_and_wait(drive='mirror', wait_ready=False)
 
 class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
     image_len = 128 * 1024 * 1024  # MB
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index 3f8a935a08..2f7d3902f2 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.47.3


