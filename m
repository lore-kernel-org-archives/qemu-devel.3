Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F08C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 08:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ08O-00007N-8E; Fri, 13 Jun 2025 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uQ08N-00007C-9g
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:51:35 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uQ08L-0008Q3-4a
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1749804693; x=1781340693;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+3TOcpTxi9mK4IV8I/nyRY5m6fVt28OeBORAHhi1yqs=;
 b=qzaZB+S70zRTcYt4MzZsjZ0Uuk1YE0Mfqd1NhlxTPMDtxX6rdQiPbIY2
 Jd7A9IZwwZezQ5ynelO3pmzddY/21eMSXTlrrsZIpka6P8FNRh+2b5F6F
 ibMtHv9lB+sqeqzCRacx7yo4pgAdymn33fnbs5OEefrUynL4nwgd9gODC
 Tep9n8h/ZJIMI8f4m2lVpAdLqWh38R3I+1veGymWyx18LIFD4uUMc++VR
 RBZanYZIYf76PbWU5TyVQi1vEAFdVP3b6pBapjfB8+00BNp3J/36ew/bn
 sA0nkCoFXf2jL81BieEQaDND9zIO9tQJ0wphsggqMmeoxqdlcGbLDf5iW A==;
X-CSE-ConnectionGUID: uZrpzOvkSsuRwwzw0ogF/A==
X-CSE-MsgGUID: qdD6QnkXScK0kE34X3e5/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="182124110"
X-IronPort-AV: E=Sophos;i="6.16,233,1744038000"; d="scan'208";a="182124110"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 17:51:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 27AFBD5004
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 17:51:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B648BE6475
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 17:51:26 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4AE131A006C;
 Fri, 13 Jun 2025 16:51:24 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, anisinha@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Date: Fri, 13 Jun 2025 16:51:10 +0800
Message-Id: <20250613085110.111204-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.137; envelope-from=lizhijian@fujitsu.com;
 helo=esa11.hc1455-7.c3s2.iphmx.com
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

This leak was detected by the valgrind.

The crs_range_merge() function unconditionally allocated a GPtrArray
'even when range->len was zero, causing an early return without freeing
the allocated array. This resulted in a memory leak when an empty range
was processed.

Instead of moving the allocation after the check (as previously attempted),
use g_autoptr for automatic cleanup. This ensures the array is freed even
on early returns, and also removes the need for the explicit free at the
end of the function.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Ani Sinha,
I didn't pick your Reviewed-by tag since V2 changes the proposal.
Please take another look.

V2:
- use g_autoptr for automatic cleanup # Suggested by Daniel
---
 hw/acpi/aml-build.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66c8..cb817a0f31f1 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -160,7 +160,7 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
  */
 static void crs_range_merge(GPtrArray *range)
 {
-    GPtrArray *tmp = g_ptr_array_new_with_free_func(crs_range_free);
+    g_autoptr(GPtrArray) tmp = g_ptr_array_new_with_free_func(crs_range_free);
     CrsRangeEntry *entry;
     uint64_t range_base, range_limit;
     int i;
@@ -191,7 +191,6 @@ static void crs_range_merge(GPtrArray *range)
         entry = g_ptr_array_index(tmp, i);
         crs_range_insert(range, entry->base, entry->limit);
     }
-    g_ptr_array_free(tmp, true);
 }
 
 static void
-- 
2.47.0


