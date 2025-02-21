Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFA5C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMd5-0001TP-8a; Fri, 21 Feb 2025 01:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd1-0001QE-3t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:15 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMcy-0003kN-6v
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119712; x=1771655712;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k/LqOSlmor1UQwuRbxoZIb/A4xPPUncC4VvDl/x5/zc=;
 b=MtmXkztnShLN/0Eb4cIxIq7Vwde83ErVa8TIxaW+Dv12HCHq5rXp0pS9
 TjkxMXxeXxZwFMMLhkmMdoTExIInwb4D9axOKJQXl+eOxjjdQgQurU2De
 hObzR+N3PViTiqpyoYt1JITxztkujoUDtZjaKtaJ/2QR9g/p+a5K/feaF
 1LCMj5X3ZEQLLIA/jMfefgRJpbYTTGsWsiIBF7skxbtsVcWgUhi/o6KdK
 /wKKOfU8fmxvEB8cei3CI13n2aXhDgBRTghYRSUyriNzKOj11Sd5hziIc
 0Njiqdc88W32blOH5TNOmFokSyv+BFH7P85U8V6wxS7Zn4MKvm79HDAUx g==;
X-CSE-ConnectionGUID: s81hMSPbRyq+mfbOKvPtkg==
X-CSE-MsgGUID: hUt+Ac9BSQ+r88H12oKC+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="178755519"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="178755519"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:08 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EB6BE60C5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4480CD9A77
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:06 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 69CDB1A006C;
 Fri, 21 Feb 2025 14:35:05 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Date: Fri, 21 Feb 2025 14:36:09 +0800
Message-ID: <20250221063612.695909-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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

Similar to migration_channels_and_transport_compatible(), introduce a
new helper migration_capabilities_and_transport_compatible() to check if
the capabilites is compatible with the transport.

Currently, only move the capabilities vs RDMA transport to this
function.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/migration.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c597aa707e5..2eacae25e0e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -238,6 +238,30 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
     return true;
 }
 
+static bool
+migration_capabilities_and_transport_compatible(MigrationAddress *addr,
+                                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        if (migrate_xbzrle()) {
+            error_setg(errp, "RDMA and XBZRLE can't be used together");
+            return false;
+        }
+        if (migrate_multifd()) {
+            error_setg(errp, "RDMA and multifd can't be used together");
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool migration_transport_compatible(MigrationAddress *addr, Error **errp)
+{
+    return migration_channels_and_transport_compatible(addr, errp) &&
+           migration_capabilities_and_transport_compatible(addr, errp);
+}
+
 static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 {
     uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
@@ -716,7 +740,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -735,14 +759,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        if (migrate_xbzrle()) {
-            error_setg(errp, "RDMA and XBZRLE can't be used together");
-            return;
-        }
-        if (migrate_multifd()) {
-            error_setg(errp, "RDMA and multifd can't be used together");
-            return;
-        }
         rdma_start_incoming_migration(&addr->u.rdma, errp);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
@@ -2159,7 +2175,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
-- 
2.44.0


