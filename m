Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A2C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txq2I-0002Bc-NE; Thu, 27 Mar 2025 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq2H-0002B7-QU; Thu, 27 Mar 2025 12:24:53 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq2B-00043A-41; Thu, 27 Mar 2025 12:24:53 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 57C8023382;
 Thu, 27 Mar 2025 19:24:44 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Denis Rastyogin <gerben@altlinux.org>,
 Vasiliy Kovalev <kovalev@altlinux.org>
Subject: [PATCH 3/4] qemu-img: prevent stack overflow in bench by using bottom
 half
Date: Thu, 27 Mar 2025 19:24:22 +0300
Message-ID: <20250327162423.25154-4-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <20250327162423.25154-1-gerben@altlinux.org>
References: <20250327162423.25154-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

Previously, new I/O requests were launched synchronously inside the
completion callback `bench_cb`, leading to deep recursion and stack
overflow. This patch moves the launching of new requests to a separate
function `bench_bh`, scheduled via `qemu_bh_schedule` to run in the event
loop context, thus unwinding the stack and preventing overflow.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 qemu-img.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 71c9fe496f..5cbf3d18d7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4426,6 +4426,7 @@ typedef struct BenchData {
     int in_flight;
     bool in_flush;
     uint64_t offset;
+    QEMUBH *bh;
 } BenchData;
 
 static void bench_undrained_flush_cb(void *opaque, int ret)
@@ -4479,7 +4480,16 @@ static void bench_cb(void *opaque, int ret)
             }
         }
     }
+    if (b->n > b->in_flight && b->in_flight < b->nrreq) {
+        qemu_bh_schedule(b->bh);
+    }
+}
 
+static void bench_bh(void *opaque)
+{
+    BenchData *b = opaque;
+    BlockAIOCB *acb;
+    
     while (b->n > b->in_flight && b->in_flight < b->nrreq) {
         int64_t offset = b->offset;
         /* blk_aio_* might look for completed I/Os and kick bench_cb
@@ -4737,6 +4747,7 @@ static int img_bench(int argc, char **argv)
     }
 
     gettimeofday(&t1, NULL);
+    data.bh = qemu_bh_new(bench_bh, &data);
     bench_cb(&data, 0);
 
     while (data.n > 0) {
@@ -4755,6 +4766,9 @@ out:
     qemu_vfree(data.buf);
     blk_unref(blk);
 
+    if (data.bh) {
+        qemu_bh_delete(data.bh);
+    }
     if (ret) {
         return 1;
     }
-- 
2.42.2


