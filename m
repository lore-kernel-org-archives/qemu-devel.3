Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35028C021BB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 01:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn5o5-00040p-Oe; Tue, 25 Feb 2025 20:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nd-0003rI-Pa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:24 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nV-0004yF-CL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740531674; x=1772067674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7PBvoitHF7A+13zdpcsFHx6PTRDE0C2rhaDiyx486rU=;
 b=j0nzDPKgNB7J1C5gvprFtSnRliJBIL7xhJQXcR/oR2bgTDkqELb3d40T
 uBUQEub0GDCX/lrOkxpW5QlIzfAtuYIWhlzmJ8n3icnNzQr7/oP2sGEZr
 czENYSSy/bKRvqCObjTGoxJKX54HnlwamzKxPUlHfcFdHpaiqWa3a0P7k
 jVnm/Fh3wkfDrPzXsRqJKb7jwusJK7IBDw5w1Rg5bONwknOV3MC783Efg
 sU/x5aIklnZyHoh2uzX6ayjycauu6NtW4JrmHQRib/Ye4vWg7cYIhazPj
 0TsgrtnRVUfg/dy0EVZ7Zbl/5/iperBGaVnkQJSkH5r2v4fFm/TVoL8cQ w==;
X-CSE-ConnectionGUID: YukOeBzDSbSnblT1JUQuaA==
X-CSE-MsgGUID: ZXZWfFqlR5WENfjxWY77hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="191194312"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="191194312"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 10:01:10 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9B72BD5042
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 617F1D50B1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:07 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B85711A006C;
 Wed, 26 Feb 2025 09:01:06 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 4/6] migration/rdma: Remove redundant migration_in_postcopy
 checks
Date: Wed, 26 Feb 2025 09:02:36 +0800
Message-ID: <20250226010238.727348-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250226010238.727348-1-lizhijian@fujitsu.com>
References: <20250226010238.727348-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.48; envelope-from=lizhijian@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
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

Since we have disabled RDMA + postcopy, it's safe to remove
the migration_in_postcopy() that follows the migrate_rdma().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  reorder: 7th->4th
---
 migration/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238..e5b4ac599b1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,7 +3284,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
@@ -3829,7 +3829,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
 
 int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
@@ -3861,7 +3861,7 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
 
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
-- 
2.44.0


