Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB54C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMo-0004CK-K0; Mon, 22 Jul 2024 00:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMf-0003ZO-Ow
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMc-0001uq-UZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621371; x=1753157371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AFWX7oe4e/py8/GcIXfzLu5/oY6d0nTsj9DRGpkoYDg=;
 b=oxD96JM5cf8InlZ8nB5awfpdfw4gEgCUuajP/p0hK1fv/cIpDdbtqpTH
 BKbVquF50BFiPFQAvgFFsxw5DSsL+uFTVWG2dDlf1jX2UMRz9RL7rzw/A
 rM/cCfEw6/pYKgQ5icmuhq1IHR86l8UtWs6be+tsxfDt8DeIBrpv/yw+r
 7b7PE00ZXBal/2TesH2sILmRojf6AlaiHeVo1vzfppkXJqLyrUznuUvSe
 h/fU69ww4GI7fxaw+M66AStzOasLEqTjme7J5q/IhotJtSHZ+HZqpEgp4
 ruOyBeD0jFECXvDiP0RKMXbcEsTF2/0dVNG7GEpOR4KlePo+vcEpIDr5W Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="169998105"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="169998105"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:29 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DA1DD64AF
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C8DD0BF3D1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CCBB6CB34
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D4A201A000A;
 Mon, 22 Jul 2024 12:09:24 +0800 (CST)
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 09/13] system/memory_mapping: make range overlap check more
 readable
Date: Mon, 22 Jul 2024 00:07:38 -0400
Message-ID: <20240722040742.11513-10-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10-4.578200-10.000000
X-TMASE-MatchedRID: x/wzmLbLaAVrFdvBEmTnvE7nLUqYrlslFIuBIWrdOeM3ZbGC9oP/O34O
 FrQCV6cJPE7FMRuDJPKAMuqetGVetk6N1CbkSyKE3QfwsVk0UbvqwGfCk7KUs6TLRbQb4IgNSKe
 N5H+uitBo6pnXeuP4iIaPtB0U19+SuFhJm7N3ILWb91fmSdHviCr4ymhFUnjPPn+4l+IOCsn2yu
 uu62RRliHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
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
 system/memory_mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index 6f884c5b90c9..ca2390eb8044 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "qapi/error.h"
 
 #include "sysemu/memory_mapping.h"
@@ -353,8 +354,7 @@ void memory_mapping_filter(MemoryMappingList *list, int64_t begin,
     MemoryMapping *cur, *next;
 
     QTAILQ_FOREACH_SAFE(cur, &list->head, next, next) {
-        if (cur->phys_addr >= begin + length ||
-            cur->phys_addr + cur->length <= begin) {
+        if (!ranges_overlap(cur->phys_addr, cur->length, begin, length)) {
             QTAILQ_REMOVE(&list->head, cur, next);
             g_free(cur);
             list->num--;
-- 
2.41.0


