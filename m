Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14708C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMdA-0001Ux-7E; Fri, 21 Feb 2025 01:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd3-0001RT-Rz
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd1-0003l4-MZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119715; x=1771655715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Aq8SNc7rV72DFQv8V4a5SuEOqjhqhl4aZY+tkt+16uI=;
 b=MoZzumlSdZB2HV/Kk0f7WgZ0liQAKJ0mJBY3tjkZ+JV5i9Be/7qB5wCu
 TpN5HAYEi2QRfniy38Dk88EL9r0RBZoxgmOC1AFjeIWw603sWWe0zK8hL
 P1CN/6WKTzHLQhfnI5E9JRFL/l52BCUAeFcABm7PFnhaisvAxHIV22lJz
 r5B9KfU42iNKIT/xgYnTZ7UKgW+ekzwDv2hv/to0Fn7wz7wOZQCK6/jFg
 69MQyuC3OFoTI+qfZg9JKnHJswgujBD/sFLvL78EpZu+X7oTTTe9RwY/s
 b9tS1Lff0Sm7iWtAVSmT1yPipFpRmSbj6S9s3hJjZ0DLZ9g01fUsHJ9r4 A==;
X-CSE-ConnectionGUID: 35W+rgOgRaC9DXFAZqduzw==
X-CSE-MsgGUID: hAFxGNyoSWOpCelzXfzbSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="179148616"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="179148616"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C6CDEE60BF
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8DA02D9A77
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:05 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F0E1B1A000B;
 Fri, 21 Feb 2025 14:35:04 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 4/8] migration: Integrate control_save_page() logic into
 ram_save_target_page()
Date: Fri, 21 Feb 2025 14:36:08 +0800
Message-ID: <20250221063612.695909-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=lizhijian@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor the page saving logic by integrating the control_save_page()
function directly into ram_save_target_page(). This change consolidates the
RDMA migration decision-making process into a single function, enhancing
clarity and maintainability.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/ram.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b7157b9b175..e07651aee8d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1143,33 +1143,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     return len;
 }
 
-/*
- * @pages: the number of pages written by the control path,
- *        < 0 - error
- *        > 0 - number of pages written
- *
- * Return true if the pages has been saved, otherwise false is returned.
- */
-static bool control_save_page(PageSearchStatus *pss,
-                              ram_addr_t offset, int *pages)
-{
-    int ret;
-
-    if (migrate_rdma() && !migration_in_postcopy()) {
-        ret = rdma_control_save_page(pss->pss_channel, pss->block->offset,
-                                     offset, TARGET_PAGE_SIZE);
-
-        if (ret == RAM_SAVE_CONTROL_DELAYED) {
-            *pages = 1;
-        } else {
-            *pages = ret;
-        }
-        return true;
-    }
-
-    return false;
-}
-
 /*
  * directly send the page to the stream
  *
@@ -1966,7 +1939,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     int res;
 
     /* Hand over to RDMA first */
-    if (control_save_page(pss, offset, &res)) {
+    if (migrate_rdma() && !migration_in_postcopy()) {
+        res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
+                                     offset, TARGET_PAGE_SIZE);
+
+        if (res == RAM_SAVE_CONTROL_DELAYED) {
+            res = 1;
+        }
         return res;
     }
 
-- 
2.44.0


