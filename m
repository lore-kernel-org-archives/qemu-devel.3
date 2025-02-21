Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3034BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMdC-0001VJ-8c; Fri, 21 Feb 2025 01:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd8-0001UH-9G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:22 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd6-0003mC-HY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119720; x=1771655720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uziJ79JcjjLUelIQEISwlLOaz+nkR8/k+C5OgBg9cr8=;
 b=sHLgSr7yXaxGloEGL1gYosGa25QQA2fIWH1PzHsdKxTNiA40zTTlITvQ
 pYi+98m95os6G10MxFjijl3Vjl4V9CxP5JB714C0Yv+Y2gi5UsACRpvcK
 V2LYW/L8/cFYoT6YYIc5pz2nyKXqiwOhS0RpYldbDvaUe41osifDJarNl
 Uhnb3qILS16OSPwyrByWevZVymdAYMGcoCl666yrRa88aOFEwamijCZx+
 V8snFJIYxWtSTggpx/IirKlXoy4R/D9CnDTlUvgDFu64/yOs+dAUiNF4P
 77lBunj6lqELhRWEZM7d/PHtWG0kVU4EkDsFjFudZFP1Mjt+tRlxMPKYy Q==;
X-CSE-ConnectionGUID: RozmevsRSoadCFnflvfhjQ==
X-CSE-MsgGUID: Bgxq6NClRwWEI3cJataq4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="178123240"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="178123240"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:09 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id AB80CC2272
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 72630BDA5D
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:07 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D56201A000B;
 Fri, 21 Feb 2025 14:35:06 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 7/8] migration/rdma: Remove redundant migration_in_postcopy
 checks
Date: Fri, 21 Feb 2025 14:36:11 +0800
Message-ID: <20250221063612.695909-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
the migration_in_postcopy()  that follows the migration_rdma().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/ram.c  | 2 +-
 migration/rdma.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e07651aee8d..c363034c882 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1939,7 +1939,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     int res;
 
     /* Hand over to RDMA first */
-    if (migrate_rdma() && !migration_in_postcopy()) {
+    if (migrate_rdma()) {
         res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
                                      offset, TARGET_PAGE_SIZE);
 
diff --git a/migration/rdma.c b/migration/rdma.c
index c6876347e1e..0349dd4a8b8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3826,7 +3826,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
 
 int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
@@ -3858,7 +3858,8 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
 
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    /* Hand over to RDMA first */
+    if (!migrate_rdma()) {
         return 0;
     }
 
-- 
2.44.0


