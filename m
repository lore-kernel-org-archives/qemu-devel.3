Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200DC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuwd-0008U2-Gn; Mon, 17 Aug 2026 06:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwb-0008Rl-LQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:53 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwa-0005Kh-5B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786963901; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2FsRJH0EtbgoAnU9VEA61B6WUwpkCLdDGB2Fom+vdiU=;
 b=ZEDO+XCpIvEpGD8JevtnvUdVWjOq5oz58CzxTJNgzJaYpixlo/6adjZYBlPz/bnZ0Gbutf
 fUDWR9Dc3gFLrGEem8Yw/B51x9/Qg2dXTJn0rbesZtD8l+gA689kadMOJK6XNZakNsK7/T
 YpKZ1mJc/482QLWwpEzVc06q5BVU5sKUOyYr767sGqzbjnahgUY88EhjLgOcGlvVmj8Kix
 d112YS6aooYLYGH+v3e6ZLYm7rEnzYKqSRhvOKrA1jwxSi9f+GYHzrBseu1ff1yPd02Y20
 +7WKMHfCJjB83K0M1akBlruRKgi2UuPCRN3PrRWzJY3L7GQHqq6lXa7yKzUAgw==
Date: Mon, 17 Aug 2026 18:51:16 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] migration/rdma: Post initial receive before accepting
In-Reply-To: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260817105117.3072040-3-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a82e7bb+e4fbbf+nongnu.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-113.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The source return-path thread can send READY before the destination has
posted its initial receive.  Since RNR retries default to zero, the send
can fail and abort migration.

Post the initial receive before rdma_accept() to close this window.

Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e17ace62b0..6e8436ccc1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3263,6 +3263,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         }
     }
 
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
+    if (ret < 0) {
+        error_report_err(err);
+        goto err_rdma_dest_wait;
+    }
+
     /* Accept the second connection request for return path */
     if ((migrate_postcopy() || migrate_return_path())
         && !rdma->is_return_path) {
@@ -3295,12 +3301,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma_ack_cm_event(cm_event);
     rdma->connected = true;
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
-    if (ret < 0) {
-        error_report_err(err);
-        goto err_rdma_dest_wait;
-    }
-
     qemu_rdma_dump_gid("dest_connect", rdma->cm_id);
 
     return 0;
-- 
2.20.1

