Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E51C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkU2-00032x-0q; Mon, 22 Jul 2024 00:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMf-0003ZH-Oh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMd-0001v6-K5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621371; x=1753157371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J16J3bUUCCZz8SNQ1pnXVC0f4NBP6OpuoE09JYT9tFk=;
 b=rUdIVEDMApJ3CMBwHAUHFznrzvmbeXdAwf7FhQoXYLPLYQX+JexeVjga
 VDc38TPnLdi5z3j/JkXgPnLX4kUULqPSICQefiz/IDIoo7AAaftsC0XZE
 kQ5Xst55VqWoPw1B5014edYPds2sf9EXW4DgcxSwW+2GTL2aI7jmPf1kL
 vJZZxFq1gVfpVmew0k5kB4BwHOdneNbz+GphmbEbq/JWSNchSiIAjFlE9
 PZpudbJAB+r9F8eNz/Pe6B9jeBcACkwHAiKWws2AvYYaq1GxUxKBE5lni
 MbIVBBjIT4+5cbR0fZj01NtkHKJRQOsBAplcQyEag94jLZa9KpVPsArvX g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168189032"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="168189032"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:29 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6791DC68E1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A78EDD5084
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 411E06BEE3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id DA7011A000C;
 Mon, 22 Jul 2024 12:09:25 +0800 (CST)
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 12/13] dump: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:41 -0400
Message-ID: <20240722040742.11513-13-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10-1.466200-10.000000
X-TMASE-MatchedRID: aX2W24vmfqtrFdvBEmTnvE7nLUqYrlslFIuBIWrdOePfUZT83lbkEMJ0
 8DtUl59d4vM1YF6AJbbCCfuIMF6xLSdET58jp62S9M5PwAWtc78/e8WetA82gR8A5FKx/2CwHoy
 9hRvP6ZHWc/yVdeVbB9+rXFOMnFgVcT8bxD7i6R6YlW8M/ovaPK9ZlES3lzEjwGC8e6520fKw0P
 Jt06oJaHpaQl5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
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
 dump/dump.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 84064d890d2c..45e84428aea5 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -30,6 +30,7 @@
 #include "migration/blocker.h"
 #include "hw/core/cpu.h"
 #include "win_dump.h"
+#include "qemu/range.h"
 
 #include <zlib.h>
 #ifdef CONFIG_LZO
@@ -574,8 +575,10 @@ static void get_offset_range(hwaddr phys_addr,
 
     QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
         if (dump_has_filter(s)) {
-            if (block->target_start >= s->filter_area_begin + s->filter_area_length ||
-                block->target_end <= s->filter_area_begin) {
+            if (!ranges_overlap(block->target_start,
+                                block->target_end - block->target_start,
+                                s->filter_area_begin,
+                                s->filter_area_length)) {
                 /* This block is out of the range */
                 continue;
             }
@@ -734,8 +737,9 @@ int64_t dump_filtered_memblock_start(GuestPhysBlock *block,
 {
     if (filter_area_length) {
         /* return -1 if the block is not within filter area */
-        if (block->target_start >= filter_area_start + filter_area_length ||
-            block->target_end <= filter_area_start) {
+        if (!ranges_overlap(block->target_start,
+                            block->target_end - block->target_start,
+                            filter_area_start, filter_area_length)) {
             return -1;
         }
 
-- 
2.41.0


