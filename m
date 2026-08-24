Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2F5C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTm4-00025A-Um; Mon, 24 Aug 2026 08:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1wyTm2-00024Y-2p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:27:34 -0400
Received: from va-2-114.ptr.blmpb.com ([209.127.231.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1wyTly-0007mC-1h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787574432; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5e28Y5s6epPrp4ARipdNeMVPNC+1pKrudq/1/HJ+wZA=;
 b=encuA2T7hUOGUis2NkaLkdFFevd/4vsSe4UMPnleAWVp1xu7dvOrIWCS+qWZse0pNHSQed
 NcJId4n4hNJ9u2eB7FrYwR6glbsXn0Hgta1zRM/xictldGGFxndcWY6DZu044sUPI3zzx2
 cNR4j8hasxgVdAltJAnz3SwzlHtSDmQBYvh89HqZ5S+5nnKkNQbdDwtTSFQrDAL6qX1uK0
 ccYWwzYjLUAQyPR4ODsZBMdzC50gVB77nXBCy2yuZpKEWctkaNC+Tca5r434Bz2MMQe0Tq
 QGrrUddf06JFyCKHOaAmBmuJkpGLo1q7WJOcxx4RBXADSoWISs5rVbG/ZftiSw==
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <caixiangfeng@bytedance.com>, 
 <yanfei.xu@bytedance.com>, "hongmianquan" <hongmianquan@bytedance.com>
From: "hongmianquan" <hongmianquan@bytedance.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 7bit
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 20:26:56 +0800
Message-Id: <20260824122655.63646-2-hongmianquan@bytedance.com>
X-Lms-Return-Path: <lba+26a8c389e+1cf892+nongnu.org+hongmianquan@bytedance.com>
Subject: [RFC v1] migration/postcopy: fix page_requested leak for vhost-user
 shared pages
Received-SPF: pass client-ip=209.127.231.114;
 envelope-from=hongmianquan@bytedance.com; helo=va-2-114.ptr.blmpb.com
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

With postcopy-preempt enabled, a postcopy migration of a guest with a
vhost-user device can hang at the very end on the destination, after all
pages are transferred (query-migrate: status=postcopy-active, remaining=0).

Root cause is an add/del key mismatch on mis->page_requested:

- add: a backend fault goes through postcopy_request_shared_page() ->
  postcopy_request_page() -> migrate_send_rp_req_pages(), which inserts
  the request and bumps page_requested_count keyed by client_addr.
- del: qemu_ufd_copy_ioctl() removes the entry and drops the counter
  keyed by this QEMU process's host address for the page.

client_addr is a VA in the external vhost-user backend's address space and
never equals QEMU's host address, so the removal misses and the counter
leaks. postcopy_ram_incoming_cleanup() then waits for it to reach zero
forever, which also stalls the source (it waits for the return path).

Racing threads:
  dst: postcopy_ram_listen_thread -> postcopy_ram_incoming_cleanup ->
       qemu_cond_wait_impl              (waits for page_requested_count==0)
       (postcopy_preempt_thread already placed/woke the pages)
  src: migration_thread -> migration_completion ->
       await_return_path_close_on_source -> qemu_thread_join
       (source_return_path_thread blocked in recvmsg)

The leak is only triggered when the vhost-user backend faults on a page
that has not been received yet: only then does the request take the
shared-fault slow path and register an entry in page_requested. If that
page is subsequently delivered while the request is still outstanding,
its entry is never removed. (Pages already present when the backend
faults just take the wake path and never register.) So a run may leak
only a few entries (9 of ~244k requests in our repro) yet still hang.

Fix: key the request with the same host address the removal uses
(rb->host + aligned_rbo) instead of client_addr. The backend wake still
happens at placement time via postcopy_wake_shared().

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
---
 migration/postcopy-ram.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a3314d3180..98268b3c55 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -992,7 +992,20 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
     /* TODO: support blocktime tracking */
-    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
+
+    /*
+     * The page will be placed by qemu_ufd_copy_ioctl(), which removes the
+     * matching entry from mis->page_requested (and drops
+     * page_requested_count) using this QEMU process's host address for the
+     * page. Register the request with the same key, rb->host + aligned_rbo,
+     * not client_addr: client_addr is a VA in the external vhost-user
+     * backend's address space and can never equal that host address, so the
+     * removal would miss forever, leaking page_requested_count and hanging
+     * postcopy teardown.
+     */
+    postcopy_request_page(mis, rb, aligned_rbo,
+                          (uint64_t)(uintptr_t)qemu_ram_get_host_addr(rb) +
+                          aligned_rbo, 0);
     return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

