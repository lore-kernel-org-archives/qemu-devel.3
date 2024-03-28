Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C2DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqMQ-0002pq-IR; Thu, 28 Mar 2024 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqMM-0002oe-Fo
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:04:02 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rpqMI-0003VH-BY
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2k7/urcRJv6gqAlLyFHhYSEgEI+wc1WoK306YaskIh7roqcqriKLr9mTUfJnJBBOzMh7CwC3+JULKpzPrDQSBtIx2KYozqKDSfoRNwvWxC+lD3zflLDP/TsSwWfIfjfI2+w/kmiDB5MI+JKtN7Y2TDhyNL2VjZHax9PO8Aawj1GQmLL+RQwW+PI2KJlJhB8Ezx+GtDMpAJbXUOkIuG8NW4yVpvwWFk4Xsd4m+hWiuJCEUzQ+jOVZPe89b2OK+yzojWMxs3gCiHgEJcMaZ0sxKjzVAikYpGg7sXiH8rv3PYhGo8Cg3RgsJhe6L2h1L8ObkVzI8B5V5Knk+fmtS00AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73sNag/yzbu3j+kA6R9jGFHPgr6MhpwoKxS8rE6g3Ek=;
 b=TBsL9hPyhwgiiJqzrg0fNj/vevD4qgNcKjAN9aBdK1EvrzUOrmnnsP4ld1A3NaAZqkK1WLNyQ5nEmZLvB+0uj6RROyYJkLpe6g13hmbWJr+uukSVP5maxI02RVkj7Gl38cGLROllFgqFB34//0OnCxm6qEwiMMmDigFD/9Ijr25ZDlOJ7UgkDy38cPDSvVUh6yNSSTg5Ik/HCrLYvpw/EGjwzeT7IhRIKSK34SjO7lRSTSCdmGSQ1Gvd0fIqtdLYQJ+aXI7mXmkqng4oprMGU3p+b+klutN7+uIslZcpjKpBKsIdnZpUE7yMbwJ+SWVN7P2E18UZdR5e4s/MaD9s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73sNag/yzbu3j+kA6R9jGFHPgr6MhpwoKxS8rE6g3Ek=;
 b=OKQHkQsifX4TZxHTYrgUndeq+CZATNAaBMkqb1ryu8WussESt9HtillKLLntSSt6z5Cexe9xPBqpX9Gql9HXJqmE/7M3EufHTgk0qHVxxIJRYiMjO2i9Fl6dFxewbMF/XYvpxZPMbjN2zQffoLO0XTzTrDcjfXVvVNQHIVkEPG4F/XDNhmhVNDkwVKVJiBmGmDVWDqwJRCNvgX6BGgDSpuj+EaCKpq0NRbopEYQ8kWvKJxmFU+7+pn9TfjsU3HhwW5QKGQUaxTVd2juVMpzORa7HbpDdjmXNTwq7JsNkyxkdJgBdnOlizmsCTIX4ChrUGGFCv1AL06RXQXVq0oZooQ==
Received: from SN6PR16CA0066.namprd16.prod.outlook.com (2603:10b6:805:ca::43)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:03:43 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::8) by SN6PR16CA0066.outlook.office365.com
 (2603:10b6:805:ca::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 14:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 14:03:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 07:02:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 28 Mar
 2024 07:02:58 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 28
 Mar 2024 07:02:57 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH for-9.0 2/2] migration/postcopy: Ensure postcopy_start() sets
 errp if it fails
Date: Thu, 28 Mar 2024 16:02:52 +0200
Message-ID: <20240328140252.16756-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240328140252.16756-1-avihaih@nvidia.com>
References: <20240328140252.16756-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c126d5-61b1-468f-51b5-08dc4f2fe0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc2uSjF7ceWdAnGOVFqahbrzT6slzFchpv2LpDdUnZv5Y8mZf1AII4vZOx6i1i+DQkj1N1A+KfuupSXh9+RPlWMQl1P25FStfUW0oK6vkdig47a0IGzVr7osqGYaEzkCPd/BGXij2PMH2tgvhXuIavTwNBrBBOFwOA/j9V5fAdxrn8q8fe5+oB9Hhla6mWNwuJcd3jrXqW9D2NOqkaV6pQfKyUJAIa6FTtQrdI4/xeAwVi/cxdHAXWWA0cBrw78xFWVTq0QkHLPYphnDXFjdGfs/1EqFmPdjqVuKs2NGScbVcjK9Gr+qMobqA/UqTo12Y23hwThknoBfJFBYH9XU0LwEjScrAcsQjUDkohiDtNotu7h7h87TFkwrCfc918qK7DxT5c4v2GDKPqpXCX6nf7l7jFKUq7usblYIjeBxRt9skM/hFSBqN++HyTseF81E6mAKUX4D1At6tPxiZGsaXCJJd/Twfo7ArAhzJowO3WrzbTHTtsDt7yuK/PKb75fUcYdHnn/t50qlTx2cGpPBjm4iTbfQqIhX59uW4rRjfckSNeTZ/ygg+dPq7RxLd2CO13dYBjTgu9fxRJr1Wfe4gyEnklVIhUEA/NMvowprwHlc9ETiDJZT8cauaI+mq4+G8HxOkiH2kxv2QN8/t+4ICKQpw/6G+Vlpwmd3EXQtQvRihNXoFAuTLcxxRGWiIvyKeUZSStESewbMNaPKRk9cvP9WAb8gw0fK8AO3vEIY/WrI/zJex6akP1JsxgDuQbH1
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:03:43.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c126d5-61b1-468f-51b5-08dc4f2fe0eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There are several places where postcopy_start() fails without setting
errp. This can cause a null pointer de-reference, as in case of error,
the caller of postcopy_start() copies/prints the error set in errp.

Fix it by setting errp in all of postcopy_start() error paths.

Fixes: 908927db28ea ("migration: Update error description whenever migration fails")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b73ae3a72c4..86bf76e9258 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2510,6 +2510,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
             migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            error_setg(errp, "%s: Failed to establish preempt channel",
+                       __func__);
             return -1;
         }
     }
@@ -2525,17 +2527,22 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
         goto fail;
     }
 
     ret = migration_maybe_pause(ms, &cur_state,
                                 MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
+                         __func__);
         goto fail;
     }
 
     ret = bdrv_inactivate_all();
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
+                         __func__);
         goto fail;
     }
     restart_block = true;
@@ -2612,6 +2619,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
+        error_setg(errp, "%s: Failed to send packaged data", __func__);
         goto fail_closefb;
     }
     qemu_fclose(fb);
-- 
2.26.3


