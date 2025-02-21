Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EB1C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMd7-0001UG-R3; Fri, 21 Feb 2025 01:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd3-0001RA-B4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd1-0003jz-6b
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119715; x=1771655715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=23C5J9GjiTBVLzzFhi4s9G3Cy0DKVtnCKHfbmfdFK7M=;
 b=YW3o+ZSC7bKtSrZYxrCHmu8YWI2Ah3LHPuArC37paSfg+6lZcap3eo7s
 x87x/5RQ659RHOqI7Pu01chIRKueCZhVkUCq0EtGSpbaGC4LpTy3RspqC
 pwN9YoFQd20ZIVhvSeQcBw4Het0UiGhrYOueudvbic8qp5P4QOnezCfFW
 EfV9t0VBkJCcYCgL4mjpRZWGDdI20UNvWSiw7CR25bcTWLkniSl/o9Dty
 DTzgzDtlV6O7a+Bhuq9PMug/FgR1VPgRvRoVJ3Nd3TTRfqB1UN5VZ9ter
 c0fXC7JMWHrP/gjcgaHxNilGzuvymKUl0nDKm7cwniywY8X8aQ/bxj3MA Q==;
X-CSE-ConnectionGUID: syoDI4VORyyAmE44My2plw==
X-CSE-MsgGUID: 8REujhPOSuS22j2CIkhA7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="169689017"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="169689017"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:07 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5A81DD6EAD
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 22AFA17D1C
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:05 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 83EF71A006C;
 Fri, 21 Feb 2025 14:35:04 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 3/8] migration: Kill RAM_SAVE_CONTROL_NOT_SUPP
Date: Fri, 21 Feb 2025 14:36:07 +0800
Message-ID: <20250221063612.695909-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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

Refactor the migration control logic by eliminating the
`RAM_SAVE_CONTROL_NOT_SUPP` return value within the migration codebase.

This involves moving the checks for RDMA migration status and postcopy
state from rdma_control_save_page() to control_save_page()

With this change, control_save_page() now takes responsibility for
determining whether RDMA operations can proceed, based on the state of
migration.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/ram.c  | 19 ++++++++++---------
 migration/rdma.c |  4 +---
 migration/rdma.h |  3 +--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f13..b7157b9b175 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1155,18 +1155,19 @@ static bool control_save_page(PageSearchStatus *pss,
 {
     int ret;
 
-    ret = rdma_control_save_page(pss->pss_channel, pss->block->offset, offset,
-                                 TARGET_PAGE_SIZE);
-    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
-        return false;
-    }
+    if (migrate_rdma() && !migration_in_postcopy()) {
+        ret = rdma_control_save_page(pss->pss_channel, pss->block->offset,
+                                     offset, TARGET_PAGE_SIZE);
 
-    if (ret == RAM_SAVE_CONTROL_DELAYED) {
-        *pages = 1;
+        if (ret == RAM_SAVE_CONTROL_DELAYED) {
+            *pages = 1;
+        } else {
+            *pages = ret;
+        }
         return true;
     }
-    *pages = ret;
-    return true;
+
+    return false;
 }
 
 /*
diff --git a/migration/rdma.c b/migration/rdma.c
index af8e6234a9f..c6876347e1e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,9 +3284,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
+    assert(migrate_rdma());
 
     int ret = qemu_rdma_save_page(f, block_offset, offset, size);
 
diff --git a/migration/rdma.h b/migration/rdma.h
index f55f28bbed1..8eeb0117b91 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,7 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
@@ -56,7 +55,7 @@ static inline
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    return RAM_SAVE_CONTROL_NOT_SUPP;
+    g_assert_not_reached();
 }
 #endif
 #endif
-- 
2.44.0


