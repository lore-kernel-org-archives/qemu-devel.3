Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A85FC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 06:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnAvA-0001jJ-8q; Wed, 26 Feb 2025 01:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnAv9-0001ih-3K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:29:27 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnAv6-0001vH-2a
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740551364; x=1772087364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pkZwIs9/cYDv5hTZNoRRBNEigCZj1TZSZF90ccJyt/Q=;
 b=hbXUs4nFfKspI5g3y4HVSJvAe5iac/532DvxZvKpJ3DB8xkVNFhtXIrj
 +DrV4VCOA9KjjIaia5wZrYaMAJFNES4eCA057HjbAPQAcdVH9jJimhfbV
 LRWoc+fFB7ga9QT5ZADCjLxWl8mjkftGQtsXBNBZI7DsXoaE4AsIgWeSN
 4hbZNlaAOkvEyZGhijxVtiwg1gQiHgPKYiHI/5RGIVyXZAsG2+AMHU7Om
 8p2QNvBZ7iTQ84JwHsdmoiATh6o6ve9sET1XJX4/pnrtIsfzow4wuGAH2
 ti0MqpCdjTXcZw7ISuOpex4GjN5+Uluu1dkfUlL7RzPWN3XyTw6yas5+J A==;
X-CSE-ConnectionGUID: xkZdEotmQZebUKJV1vBRuA==
X-CSE-MsgGUID: 5zixxtj9TGGopJqKb1vHpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="193851339"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="193851339"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 15:29:17 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A6E07E6146
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 15:29:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 70E80D6FE3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 15:29:15 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C857E1A006C;
 Wed, 26 Feb 2025 14:29:14 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 3/6] migration: disable RDMA + postcopy-ram
Date: Wed, 26 Feb 2025 14:30:40 +0800
Message-ID: <20250226063043.732455-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250226063043.732455-1-lizhijian@fujitsu.com>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=lizhijian@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
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


