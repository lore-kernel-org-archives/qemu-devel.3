Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C4AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridd6-0000Y1-6A; Fri, 08 Mar 2024 12:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridd2-0000Uz-Ch
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:30 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcy-0000k7-GT
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:03:27 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1ridcq-0006GY-At; Fri, 08 Mar 2024 18:03:16 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] hv-balloon: avoid alloca() usage
Date: Fri,  8 Mar 2024 18:02:43 +0100
Message-ID: <1d3b82eabb1ad6b6fdeae0d94f2fb37506a351af.1709916836.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709916836.git.maciej.szmigiero@oracle.com>
References: <cover.1709916836.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

alloca() is frowned upon, replace it with g_malloc0() + g_autofree.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hv-balloon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index ade283335a68..35333dab2434 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -366,7 +366,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     PageRangeTree dtree;
     uint64_t *dctr;
     bool our_range;
-    struct dm_unballoon_request *ur;
+    g_autofree struct dm_unballoon_request *ur = NULL;
     size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
     PageRange range;
     bool bret;
@@ -388,8 +388,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     assert(dtree.t);
     assert(dctr);
 
-    ur = alloca(ur_size);
-    memset(ur, 0, ur_size);
+    ur = g_malloc0(ur_size);
     ur->hdr.type = DM_UNBALLOON_REQUEST;
     ur->hdr.size = ur_size;
     ur->hdr.trans_id = balloon->trans_id;
@@ -531,7 +530,7 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
     PageRange *hot_add_range = &balloon->hot_add_range;
     uint64_t *current_count = &balloon->ha_current_count;
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
-    struct dm_hot_add *ha;
+    g_autofree struct dm_hot_add *ha = NULL;
     size_t ha_size = sizeof(*ha) + sizeof(ha->range);
     union dm_mem_page_range *ha_region;
     uint64_t align, chunk_max_size;
@@ -560,9 +559,8 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
      */
     *current_count = MIN(hot_add_range->count, chunk_max_size);
 
-    ha = alloca(ha_size);
+    ha = g_malloc0(ha_size);
     ha_region = &(&ha->range)[1];
-    memset(ha, 0, ha_size);
     ha->hdr.type = DM_MEM_HOT_ADD_REQUEST;
     ha->hdr.size = ha_size;
     ha->hdr.trans_id = balloon->trans_id;

