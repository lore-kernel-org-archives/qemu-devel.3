Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2631FC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7S4Z-0001n2-Cx; Wed, 15 May 2024 23:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4M-0001G5-NO
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:14 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4H-0003Ih-AT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715831169; x=1747367169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7MOyPOW+68JPQBCRIdeLsyQh+oVQxyzXLW3yvf2y1Qs=;
 b=OxHFkdyNJMTroWtZmkN7J2BtArBeC+1+RowalMsP1uytGcOutITMmrIk
 WBS0mdR/LBzia8d4xNYl4rt8rE+akDlUmREqzxFTkJinoiJGSsTffnjKa
 o61QwTjgH4/oVyQ4sJah8u2bEqj4HIpicY5PekhZUsw/PkxsDgzj4ylX1
 KPe2ig+QMKZo0Z+YqZLSQrgADSq35N+vj3SCBUGjR7CdFyX4Ws2AxBTlY
 PtVPgrxJNeCmznCnhpjrKmoBQ7Ul+7HIQ9IIcvZwMKbfZU0+DHQkiPWf3
 BwobwG2DvAEKN1TiUvG7E4gg5V9D/jVLbR1TlkeMiglINyNyAKG+Pnq3D g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="137733512"
X-IronPort-AV: E=Sophos;i="6.08,163,1712588400"; d="scan'208";a="137733512"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 12:46:05 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 04959D9DC8
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CBDEFD62D
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BF83B20094ACB
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4DD7E1A000C;
 Thu, 16 May 2024 11:46:01 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 2/3] migration/colo: make colo_incoming_co() return void
Date: Thu, 16 May 2024 11:45:16 +0800
Message-Id: <20240516034517.1353664-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240516034517.1353664-1-lizhijian@fujitsu.com>
References: <20240516034517.1353664-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28390.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28390.004
X-TMASE-Result: 10-4.820000-10.000000
X-TMASE-MatchedRID: Q+hQf2RULEHxTNB2h2oY6UhwlOfYeSqx+f2tDgd++7AgUEQTkIWiYgGU
 wLdEyRc2zg1WcxCRWO3BfxgMG/6GqGrs+r6+nS7OTbFVCYPBTqYJlr1xKkE5ucC5DTEMxpeQfiq
 1gj2xET+CpWo1JYSZWg9neHJxPRoybHw3hiEs7YQp1j2WdPxkF7KyARzLntncBy7BPw6XwfeYpu
 G7kpoKR3oFeyJkMWJDl4qUL05WUbinHiZUnbcPRJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyHEqm
 8QYBtMON6DcrJoh7syJChTSexa+DeBjtbUA6T/A7yGfhMw23lvQCCbBr9T2X4Bocw86CYooSqTt
 +or/8Ux+W1nz9EQ8V5nVT+Oed1s6W4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, it always returns 0, no need to check the return value at all.
In addition, enter colo coroutine only if migration_incoming_colo_enabled()
is true.
Once the destination side enters the COLO* state, the COLO process will
take over the remaining processes until COLO exits.

Cc: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Fix compilation failed, reported by Fabiano Rosas <farosas@suse.de>
    Collected reviewed-by tags
---
 include/migration/colo.h | 2 +-
 migration/colo-stubs.c   | 3 +--
 migration/colo.c         | 9 ++-------
 migration/migration.c    | 6 +++---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index eaac07f26d..43222ef5ae 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -49,7 +49,7 @@ void colo_checkpoint_delay_set(void);
  *
  * Called with BQL locked, may temporary release BQL.
  */
-int coroutine_fn colo_incoming_co(void);
+void coroutine_fn colo_incoming_co(void);
 
 void colo_shutdown(void);
 #endif
diff --git a/migration/colo-stubs.c b/migration/colo-stubs.c
index f8c069b739..e22ce65234 100644
--- a/migration/colo-stubs.c
+++ b/migration/colo-stubs.c
@@ -9,9 +9,8 @@ void colo_shutdown(void)
 {
 }
 
-int coroutine_fn colo_incoming_co(void)
+void coroutine_fn colo_incoming_co(void)
 {
-    return 0;
 }
 
 void colo_checkpoint_delay_set(void)
diff --git a/migration/colo.c b/migration/colo.c
index 5600a43d78..991806c06a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -929,16 +929,13 @@ out:
     return NULL;
 }
 
-int coroutine_fn colo_incoming_co(void)
+void coroutine_fn colo_incoming_co(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QemuThread th;
 
     assert(bql_locked());
-
-    if (!migration_incoming_colo_enabled()) {
-        return 0;
-    }
+    assert(migration_incoming_colo_enabled());
 
     qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
@@ -954,6 +951,4 @@ int coroutine_fn colo_incoming_co(void)
 
     /* We hold the global BQL, so it is safe here */
     colo_release_ram_cache();
-
-    return 0;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 0feb354e47..607fb44842 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -789,9 +789,9 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    if (colo_incoming_co() < 0) {
-        error_setg(&local_err, "colo incoming failed");
-        goto fail;
+    if (migration_incoming_colo_enabled()) {
+        /* yield until COLO exit */
+        colo_incoming_co();
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
-- 
2.31.1


