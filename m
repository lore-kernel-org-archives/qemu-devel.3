Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81784C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPRH-0001t7-NL; Fri, 21 Aug 2026 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPRF-0001kE-KG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:41 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPRD-0000m5-Ug
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787319455; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mbrMK7SfgERS/fcoW3zju5EVeBLTM8IbfFvNM3o/rlI=;
 b=Sb7+S53herlQRmn6N/UazkH2g96aZBKdUejtUmWiZh5WffuGzNG5kR6I2GL/nVsgGybw3f
 VlHlEyyyvNvYrq7phbkbt/vjj9d7BJZucwBF/C+CAVPHUdj7/txSuOJbTpJmN7aoe7AE3C
 T33n5aDcbpAuhlDUu+ISZE5QYUpT+Euc72qs5AGw+W+ILTQ9Gav6827npcZzYFFVHd+9m3
 2WpzS1GbjV53hJEBPxyUvH6xY1RkhbhpWvSTHTSm3L8LzQ8OIRLf7uQR5jHkChq1U6hOFP
 6MwfJp+Za322n5ZONRnKxqIWgQmLZxR7ph+CAMRrBDTMameErstaBPXtcqgN7g==
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/3] migration/rdma: Post initial receive before accepting
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a88549d+1aefd3+nongnu.org+yanfei.xu@bytedance.com>
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Aug 2026 21:35:58 +0800
Message-Id: <20260821133559.3815727-3-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-112.ptr.blmpb.com
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

Adding delays can easily reproduce it. For exmaple with sleep(1), error
could be found at the source side:

2026-08-20T05:55:11.471421Z qemu_rdma_exchange_get_response_start CONTROL: READY receiving...
2026-08-20T05:55:11.471422Z qemu_rdma_post_send_control CONTROL: sending QEMU FILE..
2026-08-20T05:55:11.471447Z qemu_rdma_poll_other other completion 2000 received left 0
2026-08-20T05:55:11.471589Z qemu_rdma_poll_recv completion 0 received (4000) left 0
2026-08-20T05:55:11.471592Z qemu_rdma_poll_other other completion 4000 received left 0
2026-08-20T05:55:11.471594Z qemu_rdma_exchange_get_response_start CONTROL: READY receiving...
2026-08-20T05:55:11.471596Z qemu_rdma_post_send_control CONTROL: sending QEMU FILE..
2026-08-20T05:55:11.471617Z qemu_rdma_poll_other other completion 2000 received left 0
2026-08-20T05:55:11.705561Z qemu_rdma_close
2026-08-20T05:55:11.705587Z qemu_rdma_close
2026-08-20T05:55:11.705626Z qemu-system-x86_64: rdma migration: send polling control error
2026-08-20T05:55:11.707001Z qemu-system-x86_64: warning: Early error. Sending error.
2026-08-20T05:55:11.707031Z qemu_rdma_post_send_control CONTROL: sending ERROR..
2026-08-20T05:55:11.707038Z qemu-system-x86_64: warning: rdma migration: send polling control error
2026-08-20T05:55:11.707301Z qemu_rdma_cleanup_disconnect
2026-08-20T05:55:11.710569Z qemu_rdma_cleanup_disconnect

Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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

