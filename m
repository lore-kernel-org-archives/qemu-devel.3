Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26503CFC526
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 10:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcwM-0001ne-65; Fri, 21 Nov 2025 21:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbyl-0000Aw-MM; Fri, 21 Nov 2025 19:59:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbwj-0001il-5j; Fri, 21 Nov 2025 19:59:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 77F5C16CA82;
 Fri, 21 Nov 2025 21:44:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 01C2B321CBE;
 Fri, 21 Nov 2025 21:44:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 71/81] nvme: Kick and check completions in BDS context
Date: Fri, 21 Nov 2025 21:44:10 +0300
Message-ID: <20251121184424.1137669-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Hanna Czenczek <hreitz@redhat.com>

nvme_process_completion() must run in the main BDS context, so schedule
a BH for requests that aren’t there.

The context in which we kick does not matter, but let’s just keep kick
and process_completion together for simplicity’s sake.

(For what it’s worth, a quick fio bandwidth test indicates that on my
test hardware, if anything, this may be a bit better than kicking
immediately before scheduling a pure nvme_process_completion() BH.  But
I wouldn’t take more from those results than that it doesn’t really seem
to matter either way.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-8-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7a501bbd51941fb1867d78e6b0d1dc69e396b9e2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nvme.c b/block/nvme.c
index bbf7c23dcd..3366519e57 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -480,7 +480,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
-static void nvme_deferred_fn(void *opaque)
+static void nvme_kick_and_check_completions(void *opaque)
 {
     NVMeQueuePair *q = opaque;
 
@@ -489,6 +489,18 @@ static void nvme_deferred_fn(void *opaque)
     nvme_process_completion(q);
 }
 
+static void nvme_deferred_fn(void *opaque)
+{
+    NVMeQueuePair *q = opaque;
+
+    if (qemu_get_current_aio_context() == q->s->aio_context) {
+        nvme_kick_and_check_completions(q);
+    } else {
+        aio_bh_schedule_oneshot(q->s->aio_context,
+                                nvme_kick_and_check_completions, q);
+    }
+}
+
 static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
                                 NvmeCmd *cmd, BlockCompletionFunc cb,
                                 void *opaque)
-- 
2.47.3


