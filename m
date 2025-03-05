Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DCBC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDo-0002Ft-A2; Wed, 05 Mar 2025 01:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDd-0002E8-JX
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDa-0007eu-VR
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156019; x=1772692019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pkZwIs9/cYDv5hTZNoRRBNEigCZj1TZSZF90ccJyt/Q=;
 b=MGUHimjW/vRbOdLkqk7p/f1X5sf/XdBV74THI6ScZQfiA7ueO3tVrpd2
 VHTQsq4RbqVvwHoaCEFULTGhqz6Frg4wQQIujtZB89B9CjXVXaFy2gBRe
 JS3MCkog0aCl4OdjaxpiU7GvbCUAnkYApHagsSvRCynmOSypFt56ppWJC
 w7zTUCbBf+7izcgyz2IWqGrThwer911zojKmK7MImVozlqVH9J56VnLRg
 v6t08sI0cCYpwhJzXN8s+zYzJM4AmfmTPzsPcmCSjfl1zwhszx5+mTpaJ
 YQbC0BEtX6ItfBs7C8xopqyKOftPpqR4EWUp9sPthwSCz2i2Zz6TENHFR Q==;
X-CSE-ConnectionGUID: iQ9hm4bXRLips5PQdYqqyA==
X-CSE-MsgGUID: YRMDLhg8TzGEF/XPg6BWLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="179366760"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="179366760"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:54 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E25CD4809
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 40C65BDB65
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:52 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 890741A009A;
 Wed,  5 Mar 2025 14:26:51 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 3/6] migration: disable RDMA + postcopy-ram
Date: Wed,  5 Mar 2025 14:28:22 +0800
Message-ID: <20250305062825.772629-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 migration/options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index c6f18df5864..527ba05d413 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -449,6 +449,10 @@ bool migrate_rdma_caps_check(bool *caps, Error **errp)
         error_setg(errp, "RDMA and multifd can't be used together");
         return false;
     }
+    if (caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        error_setg(errp, "RDMA and postcopy-ram can't be used together");
+        return false;
+    }
 
     return true;
 }
-- 
2.44.0


