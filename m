Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB92C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDo-0002Fr-AS; Wed, 05 Mar 2025 01:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDd-0002E9-KH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDa-0007es-VH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156018; x=1772692018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kf7nUzx6bCEoflN6wH/5kN4a9SJ7oJCr6a8XCP/ryZQ=;
 b=KFRYd/AnNPYsZSOl2ZScphO92Htx+raxGTQfFz3+knMvI43xrS3R4ESV
 Xa7obXXsAgBT8XZav7d+4NvQ/NV0RpqcrYd5XSFCDp720epxzdk6hgRkU
 z7DQVNS6uiXekQcGsvE0kkpQ+0eK0BHe94bBqEkPHzKTg+ZT4D/BZKfxp
 3YfA0fiNPJyl7vrTupO7oAEPj8OEoq+IbPxt8lhSMXrzcVeNZiB0Aq5d/
 wCn5ODQk9sSuVxThRwdFDJRyH7cLzBue3Gcvjs9En2HLOa3V7YcvPdAeM
 ju90q1K0/I3WfkJuQXRUZr7RyqIk+u7kjNSYzB6RAkqlXHMur0cyuVwDO Q==;
X-CSE-ConnectionGUID: CoscqJ2BRgybZGaWcVAZ0w==
X-CSE-MsgGUID: /eRXmp2JSKezmJ275wcmOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="192279487"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="192279487"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:54 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 065B8D4C39
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BA8D9BDB65
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:51 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 186A61A00A0;
 Wed,  5 Mar 2025 14:26:51 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 2/6] migration: check RDMA and capabilities are compatible
 on both sides
Date: Wed,  5 Mar 2025 14:28:21 +0800
Message-ID: <20250305062825.772629-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Depending on the order of starting RDMA and setting capability,
they can be categorized into the following scenarios:
Source:
 S1: [set capabilities] -> [Start RDMA outgoing]
Destination:
 D1: [set capabilities] -> [Start RDMA incoming]
 D2: [Start RDMA incoming] -> [set capabilities]

Previously, compatibility between RDMA and capabilities was verified only
in scenario D1, potentially causing migration failures in other situations.

For scenarios S1 and D1, we can seamlessly incorporate
migration_transport_compatible() to address compatibility between
channels and capabilities vs transport.

For scenario D2, ensure compatibility within migrate_caps_check().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

V4:
  - Remove Reviewed-tag and cover above D2 scenario

V3:
  - collect Reviewed tag
  - reorder: 5th -> 2nd
---
 migration/migration.c | 30 ++++++++++++++++++++----------
 migration/options.c   | 21 +++++++++++++++++++++
 migration/options.h   |  1 +
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c597aa707e5..0736d3a6728 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -238,6 +238,24 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
     return true;
 }
 
+static bool
+migration_capabilities_and_transport_compatible(MigrationAddress *addr,
+                                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        return migrate_rdma_caps_check(migrate_get_current()->capabilities,
+                                       errp);
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
@@ -716,7 +734,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -735,14 +753,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
@@ -2159,7 +2169,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
diff --git a/migration/options.c b/migration/options.c
index bb259d192a9..c6f18df5864 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -439,6 +439,20 @@ static bool migrate_incoming_started(void)
     return !!migration_incoming_get_current()->transport_data;
 }
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp)
+{
+    if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
+        error_setg(errp, "RDMA and XBZRLE can't be used together");
+        return false;
+    }
+    if (caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        error_setg(errp, "RDMA and multifd can't be used together");
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @migration_caps_check - check capability compatibility
  *
@@ -602,6 +616,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    /*
+     * On destination side, check the cases that capability is being set
+     * after incoming thread has started.
+    */
+    if (migrate_rdma() && !migrate_rdma_caps_check(new_caps, errp)) {
+        return false;
+    }
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index 762be4e641a..82d839709e7 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -57,6 +57,7 @@ bool migrate_tls(void);
 
 /* capabilities helpers */
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp);
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 
 /* parameters */
-- 
2.44.0


