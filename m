Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25022C021B4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMd6-0001Tk-B4; Fri, 21 Feb 2025 01:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd3-0001R8-9h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd1-0003k0-9e
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119715; x=1771655715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EeqxOxnfJGp1OeklxYaU7QutfMay++/S+GaNNIxlkvY=;
 b=oVdB4Cd7/b0xRyAp3/fbwncNf5aS3a4O6l24C6b4X7quOBnr/9q6MwvT
 Ml59Gt0LcMSyeIDYoln/Nq/aHaq1yR+wnyBwG9dO93xqJ8hAdCJw4odmf
 yc1aHc40U6C1foQBhuQMBGZtS6XPXwpXT7wUbSafC/x1eficEprLUIqVJ
 90379Jw3licM+0JizNZHvbSqdTWEfrvHUoUkMTqmNGxHmM7KcB2MbrAgm
 O4sa292abSOifKBg7EuSgbCHuIuaTh8h00B9wBOa6nsuPJ/k1DxHCh2Hm
 VGc9P0T6vDwUTx9UB24AEwtcxyqJSpPHv7/zc0eHmSvVo3kY5wq60Z4Bm A==;
X-CSE-ConnectionGUID: nOdJyc5MQlSkUphRsTGdIg==
X-CSE-MsgGUID: 0YLmBaTuSCCHrfzFOtNqMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="189940651"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="189940651"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:09 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 008DC7C24E
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BC204D9A7E
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:06 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 20C321A000B;
 Fri, 21 Feb 2025 14:35:06 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 6/8] migraion: disable RDMA + postcopy-ram
Date: Fri, 21 Feb 2025 14:36:10 +0800
Message-ID: <20250221063612.695909-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250221063612.695909-1-lizhijian@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=lizhijian@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
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

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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


