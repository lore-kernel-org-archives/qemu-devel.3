Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981AC021BE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 01:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn5o8-00048M-Ar; Tue, 25 Feb 2025 20:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nf-0003rU-0m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:24 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nb-0004xu-DT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740531679; x=1772067679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CSirQC4EObPjqlof3ujDjuP/Nb1WlYAJXM11TAR57ys=;
 b=UEe6KEA4TgKTS+YsedFVSwq6ywx63b7dIKcw9bA8RWv/UFIvzq5XzkuQ
 ZFYTgAItb1sHTUHCrocrGKtSnfgOFftJcDmMcTwNjX6ytaCvR3JMe1A+l
 FblPraa0jNN4FRcRb/847aFYX+SSzyh4mVRRSI/BJl93WrFm3OCstUBKH
 4XCCaMHDR6nPYuB+wH5UCAoJkFolc4nHu+P3fz5CP+drc97p9mLD7I0Lb
 2guPz3f5BIiyvv7g7JvdhB5y4bQYIFR11HCNIlbwYvmDmWFeVBKroqsAq
 XV7MoQirAbiMsiUrz1Y3s7dLMBvqGs4PZ9SOhYzWM546FPtTSHt4fFR9i Q==;
X-CSE-ConnectionGUID: 4go/2eHGTsSR5RNNtYJw2w==
X-CSE-MsgGUID: flp0eF/eTBe39ir6kndDxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="178520693"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="178520693"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 10:01:09 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 25374D5052
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DE24BD50B3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:06 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4143B1A000B;
 Wed, 26 Feb 2025 09:01:06 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 3/6] migration: disable RDMA + postcopy-ram
Date: Wed, 26 Feb 2025 09:02:35 +0800
Message-ID: <20250226010238.727348-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250226010238.727348-1-lizhijian@fujitsu.com>
References: <20250226010238.727348-1-lizhijian@fujitsu.com>
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

It's believed that RDMA + postcopy-ram has been broken for a while.
Rather than spending time re-enabling it, let's simply disable it as a
trade-off.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  - collect Reviewed tag
  - reoder: 6th -> 3th
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 2eacae25e0e..d414a4b1379 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -251,6 +251,10 @@ migration_capabilities_and_transport_compatible(MigrationAddress *addr,
             error_setg(errp, "RDMA and multifd can't be used together");
             return false;
         }
+        if (migrate_postcopy_ram()) {
+            error_setg(errp, "RDMA and postcopy-ram can't be used together");
+            return false;
+        }
     }
 
     return true;
-- 
2.44.0


