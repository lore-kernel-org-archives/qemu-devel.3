Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C65C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 04:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPwDS-0004xn-On; Fri, 13 Jun 2025 00:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uPwDP-0004xc-QC
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 00:40:32 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uPwDB-0004Nz-HK
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 00:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1749789618; x=1781325618;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ArXwXdTlXKYXVQXJTgffx5QFKi4535Xey/oWW31JuzI=;
 b=RWq8HzJB1epGGQ7Myfd3+lFeCdYyZFhV58cxUSptz68W+ZGQsL6ARWTR
 0O/KbQ3izK5TH1CLzu320HoA8QWllKLex+lKgYDxYwvQlprDEAIIvJ1oL
 pDxhj6bT6n7EgkwSh2bsBy/I/o3zeJhdGF5resOKMUNyQqis00ZWWP6Xs
 XBvN5tAG/4k0tvkSWg1qSsu/L/LiAxVVeoKDLjX1O2FkrdqiTi7at47jK
 leS0zmwREgJJyypXZh39xReeqOUAnSDvL4DeGAgetQGhPmWiTWJyJAfJH
 ACqky8VXQwKIavE1iwZMfdkM1NTJaLKdN9xCl2ZUUqDlE0mslsmx+uDlO w==;
X-CSE-ConnectionGUID: enyDLMJPQaOy3gfLraPgLQ==
X-CSE-MsgGUID: 3XLF9/5wRvq1+TkGj/mCpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="202577964"
X-IronPort-AV: E=Sophos;i="6.16,232,1744038000"; d="scan'208";a="202577964"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 13:40:12 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 948A3E9E80
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 13:40:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 384F3D4C03
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 13:40:09 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C1C3D1A0071;
 Fri, 13 Jun 2025 12:40:07 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, anisinha@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Date: Fri, 13 Jun 2025 12:40:02 +0800
Message-Id: <20250613044002.106396-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=lizhijian@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
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

Fix this by moving the GPtrArray allocation after the empty range check,
ensuring memory is only allocated when actually needed.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/acpi/aml-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66c8..cf1999880119 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -160,7 +160,7 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
  */
 static void crs_range_merge(GPtrArray *range)
 {
-    GPtrArray *tmp = g_ptr_array_new_with_free_func(crs_range_free);
+    GPtrArray *tmp;
     CrsRangeEntry *entry;
     uint64_t range_base, range_limit;
     int i;
@@ -169,6 +169,7 @@ static void crs_range_merge(GPtrArray *range)
         return;
     }
 
+    tmp = g_ptr_array_new_with_free_func(crs_range_free);
     g_ptr_array_sort(range, crs_range_compare);
 
     entry = g_ptr_array_index(range, 0);
-- 
2.47.0


