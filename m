Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8B5C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMl-0003od-U8; Mon, 22 Jul 2024 00:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMZ-0003FA-7Z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:29 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMX-0001uQ-D5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621365; x=1753157365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1S+uLU4M1bz23lQZv9KvoQgTqNV7fhGmAEQi5Fa/Q9s=;
 b=kJktTUFkFxWLBNahKUhrIrf58ORJXuy5iZt1LFYOGWSkQgiQi2mQfSqc
 hU/fTSaxfSv4EtvcAN5SnNX7NFfiNCWrLlROutSEfLOHv2FO4B8d68F/G
 FRHnOTmoDuB6Pf+ysP59zLtI/qxTMjS0AkWYW7ka00y9G07jYz48iq9I/
 1RHkyV1n/+W+cSmaodvuLk33HqTlrRm7i05SfkAnyNVzt30n/q9l2gtax
 Oy8jXSYguT9xgoQwWziDpw/DK2j1DTCFdhkmTXnp13sAWj2NG53g7n++T
 xlBOvGJfc7dHkxSVy/4Omevr9tsRP2q9qUD9ltDJpBVrfuvaiTyN2q7iD g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="156365923"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="156365923"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:22 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E70C1E7521
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 39A77D4BF7
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D07956BEE3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 43A661A000A;
 Mon, 22 Jul 2024 12:09:19 +0800 (CST)
To: qemu-devel@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 04/13] cxl/mailbox: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:33 -0400
Message-ID: <20240722040742.11513-5-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10-8.191900-10.000000
X-TMASE-MatchedRID: ugBf8Q6n0CxnpJOZcTss/UhwlOfYeSqxoYPqi9eoDbfAuQ0xDMaXkH4q
 tYI9sRE/jqQ82yy1I7TAkg7CB3yudJH0YXYnbGozFEUknJ/kEl5lVdRvgpNpe/oLR4+zsDTtoSB
 RDpzc4nBTIhEBXNI5aqO5GuoY629glS+unzcbs/k1CJIE/9zH1gw3830maoNlfuUkC4A/hNCjPM
 wLVKwCR6CCN9KKKznu4vM2xBdXMyY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/cxl/cxl-mailbox-utils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 74eeb6fde739..507690c0dd16 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1086,8 +1086,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
 
     QLIST_FOREACH(ent, poison_list, node) {
         /* Check for no overlap */
-        if (ent->start >= query_start + query_length ||
-            ent->start + ent->length <= query_start) {
+        if (!ranges_overlap(ent->start, ent->length,
+                            query_start, query_length)) {
             continue;
         }
         record_count++;
@@ -1100,8 +1100,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         uint64_t start, stop;
 
         /* Check for no overlap */
-        if (ent->start >= query_start + query_length ||
-            ent->start + ent->length <= query_start) {
+        if (!ranges_overlap(ent->start, ent->length,
+                            query_start, query_length)) {
             continue;
         }
 
-- 
2.41.0


