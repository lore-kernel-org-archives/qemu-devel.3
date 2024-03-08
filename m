Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E0C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridd6-0000Y6-F3; Fri, 08 Mar 2024 12:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridd2-0000Up-C5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:30 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcx-0000kP-5c
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:24 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcv-0006Gi-KF; Fri, 08 Mar 2024 18:03:21 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] hv-balloon: define dm_hot_add_with_region to avoid
 Coverity warning
Date: Fri,  8 Mar 2024 18:02:44 +0100
Message-ID: <546987284a7da9106bbead1063553cbfe7ddd697.1709916836.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709916836.git.maciej.szmigiero@oracle.com>
References: <cover.1709916836.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since the presence of a hot add memory region is optional in hot add
request message it wasn't part of this message declaration
(struct dm_hot_add).

Instead, the code allocated such enlarged message by simply adding the
necessary size for this extra field to the size of basic hot add message
struct.

However, Coverity considers accessing this extra member to be
an out-of-bounds access, even thought the memory is actually there.

Fix this by adding an extended variant of this message that explicitly has
an additional union dm_mem_page_range at its end.

CID: #1523903
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hv-balloon.c           | 10 +++++-----
 include/hw/hyperv/dynmem-proto.h |  9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 35333dab2434..3a9ef0769103 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -513,8 +513,8 @@ ret_idle:
 static void hv_balloon_hot_add_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
 {
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
-    struct dm_hot_add *ha;
-    size_t ha_size = sizeof(*ha) + sizeof(ha->range);
+    struct dm_hot_add_with_region *ha;
+    size_t ha_size = sizeof(*ha);
 
     assert(balloon->state == S_HOT_ADD_RB_WAIT);
 
@@ -530,8 +530,8 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
     PageRange *hot_add_range = &balloon->hot_add_range;
     uint64_t *current_count = &balloon->ha_current_count;
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
-    g_autofree struct dm_hot_add *ha = NULL;
-    size_t ha_size = sizeof(*ha) + sizeof(ha->range);
+    g_autofree struct dm_hot_add_with_region *ha = NULL;
+    size_t ha_size = sizeof(*ha);
     union dm_mem_page_range *ha_region;
     uint64_t align, chunk_max_size;
     ssize_t ret;
@@ -560,7 +560,7 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
     *current_count = MIN(hot_add_range->count, chunk_max_size);
 
     ha = g_malloc0(ha_size);
-    ha_region = &(&ha->range)[1];
+    ha_region = &ha->region;
     ha->hdr.type = DM_MEM_HOT_ADD_REQUEST;
     ha->hdr.size = ha_size;
     ha->hdr.trans_id = balloon->trans_id;
diff --git a/include/hw/hyperv/dynmem-proto.h b/include/hw/hyperv/dynmem-proto.h
index a657786a94b1..68b8b606f268 100644
--- a/include/hw/hyperv/dynmem-proto.h
+++ b/include/hw/hyperv/dynmem-proto.h
@@ -328,7 +328,8 @@ struct dm_unballoon_response {
 /*
  * Hot add request message. Message sent from the host to the guest.
  *
- * mem_range: Memory range to hot add.
+ * range: Memory range to hot add.
+ * region: Explicit hot add memory region for guest to use. Optional.
  *
  */
 
@@ -337,6 +338,12 @@ struct dm_hot_add {
     union dm_mem_page_range range;
 } QEMU_PACKED;
 
+struct dm_hot_add_with_region {
+    struct dm_header hdr;
+    union dm_mem_page_range range;
+    union dm_mem_page_range region;
+} QEMU_PACKED;
+
 /*
  * Hot add response message.
  * This message is sent by the guest to report the status of a hot add request.

