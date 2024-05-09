Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F10EC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 03:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4uRl-0003cs-DK; Wed, 08 May 2024 23:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRj-0003bz-0E
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:51 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRh-00045x-7X
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715225269; x=1746761269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cyF0sig8Swsz9tk18ZpIx7U0Oapo1ebsJLo4It/k2PM=;
 b=svd0MuYXkTbnqEu3yuMJN9Hk1ql2cwULnl4ZwnAIXqMetSkVfMUhkR70
 OPT7LGWr6adX28FbKDK7KwAIaLsHclwBGXXM9fBzvXWtcP/GEwWQuIkqp
 6LLW4pUD835hgDE3VH9e3hkqLbKVH1MSVfpGvxK2kZhMc9jX5KKewiW2P
 sGrLBkY374REuTPLf2qrmyDXK2NrIU34uYTvvFaWzOsXaRLPkNNLClXtb
 ZURdbc/mV5MUR6E7rWxQqmzVcxuE1u053UBU8YHte+XkuoqI4wkLuI7Rt
 8qRUKMIE9P9vhAhyFKfk0UPYUBTZ/S4WlY0Xk79BBmuGEbZmAo39FuDSY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="158023995"
X-IronPort-AV: E=Sophos;i="6.08,146,1712588400"; d="scan'208";a="158023995"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 12:27:43 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 72A61D64BE
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:41 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 93F24D949A
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 254F420097CE6
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A0BEB1A000C;
 Thu,  9 May 2024 11:27:39 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Date: Thu,  9 May 2024 11:31:05 +0800
Message-Id: <20240509033106.1321880-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240509033106.1321880-1-lizhijian@fujitsu.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28372.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28372.002
X-TMASE-Result: 10-5.088600-10.000000
X-TMASE-MatchedRID: PoiqctUOquXxTNB2h2oY6UhwlOfYeSqx+f2tDgd++7AgUEQTkIWiYgGU
 wLdEyRc22X3YOaN7LRO12HagvbwDji/7QU2czuUNA9lly13c/gEG9HFKXsmjKdzuSrL7Eh5g04H
 opDMC5OEQhc6ZJs+yuR3kdXUuScbhAtMbsAHP2bW6kMgL3jbYOpki3iIBA3o/fsZmhE+Kc5OjxY
 yRBa/qJShNCXvA0fw+jaPj0W1qn0SyO81X3yak8/T+wXTQtc97goABUJDPefkZJp7h9xtibCdDv
 GW+2ibN1wiZLuOix9K93y+RUCO33tJMWudUVp1YlKRAAhLJCbWCUjmmAAZaIQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
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

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/colo.c      | 9 ++-------
 migration/migration.c | 6 +++---
 2 files changed, 5 insertions(+), 10 deletions(-)

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
index b4a09c561c..6dc1f3bab4 100644
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


