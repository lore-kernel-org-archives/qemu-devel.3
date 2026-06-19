Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2EACD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX90-0004mN-C7; Fri, 19 Jun 2026 07:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8y-0004ky-FG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:16 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8w-0001sf-NT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUfyuPOoqzv3oE8t+E34glvylbnTgEI3jE0P6lfWhEhOT1BsqRRZsqPjERJlh2YUARqZIH7NwTRumUzLejcGfnSoH/Bf1Vdadh3NniYKZ1ZJxkNE5ISI/tKWsu3fA7zksk+AqHpZWLOstvVZvjms6zGNkYO6iNPwW0NllG6OkpScw5A1WkeDY2nN+HaOwE+vyCiPwGIA7LtwIIA/J7iDikuVwCnw3t6YXJ52j7OqZj9WmqC/l2ozBYVTXsHCnq/xc4cXUUSE0hI2ALSyBolJQS8zPIbztvSTV5wVgL6uhBYoqnevvWyscyN6yTvm5XVIiNc37dnA9GKm8cNqTvkSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI5ScM+oJRFbfYfZjtlPlPXO6mvy8/mwyn0hWf88JaQ=;
 b=UrDkKbD9XllPDkp4yPDLpaBAi6+VsDBxPFeDl4tStYOx2LwXIWlhqm++qkDN0odnHtjfXVtLdYehnzEYp365fLkIQVinpOxFgQ00OIkMbd7a0ZR204h/aJ9tk/OkuN/TtT8UIYZ/VvtG3yOZETzW82O5yEGlWP+3DnOtGpcm2GzzHu4b0ziGTZv8MAPgpPb6PfEGNEmNtUN6N6jt3DJvzfbYmRJ8pEvnsYKtpjHlzsCoQHY1CwtYLUzzVUEpTWmYaF6BJN80dOnsx51D43P4CGeJXwbvMScCibPp6hndMmtoUPUU6dhOPyJ18ERiAeLCDu/BQLAjP9Cva3A90W//gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI5ScM+oJRFbfYfZjtlPlPXO6mvy8/mwyn0hWf88JaQ=;
 b=vKnfBMwQwwIhnC5B/ND1STqD9n1WhYagaX9wJFBS4HKThXcf5CQmbQxSBbXfbxg9FMXQsVxlDO1GA+fGvGnTKNHTouH97EwNwka+CqKi7n4LZbxLQ/Tgj+RyPyTGUpm4t2zhx/JwT4gc+amQkfWtxEc7YqF2uVQGu0VOVLL8ks8=
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 11:12:09 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::af) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 11:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:09 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:06 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 05/10] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Date: Fri, 19 Jun 2026 19:11:31 +0800
Message-ID: <20260619111136.3481329-6-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4147c695-0a02-484a-1004-08decdf39af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: /EpCal9ad5s91Mf4FZsFTg0so1vsXUFwXZHwPmA54QkJBlWGywJ6CKU5gJPLJLre6k3bw04VHDjuUkp62SI14sWY4dHBvzFwVc/qn2pGW7osw/UTX0pT6Km55PpflEue7yXKxkvboL+hqaZkqCzR8AHapZqVdZdkE48odJANUoxMbECdOMYhLSWROPWWM3fLx2NZ9pGeTiWcOZ118V9hyS6TDWieXd6rdj0rj59M/J4GPXwT0HA/A53Xwj7UrxuJEd/7uaQ5AI3bfEeeQE8o5Rrd1k6t66E6Npph2/rPqYzD/gwIoJrY1u6yyJ7fb4iNs6u2WvyndQHsfmIl0M78ld52hJo3hmDOOK6teDGGT77lJXrONt+GPVPgnUF/7zmus9zRP95UzCTuQ+p9DZYEWMNige3qLTsPSF5KE+OZ0H55PZkd0X9sxMISxX9bfW3G25Z8VZovGYWHtAglsb1SEInE+0qvFlFjInvC6Ncb3+B3e7EH4CmZ9+ToAMuXcMe39AcbR8Qs3bB6blqoig0TDWnCY9k3/OoVM4UjgMXPkT8pl6xY/Z8lOdCprFxpMWf0C+am1Au2Nqtab+oqhJ1lVr9n9DxofVOH2DpQY8sWVE+4ta/mxK+Zb4vnKMn9zu0TZHTH+O19gWWw08RkCtkyNDYYnUWy8eSDkPNUuRyF8NpYCUw46JBug99JdcxE6+ZsdQiicgFGa1ZMUKiHtgUkLzSAY39BYsbf7QSGOVTBzI7LXshMkSD+/k4QTMPubh4B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QJAJzYpItgG1TZ9Vo4oG8IH0VIXwDiAOqhhaIydFssMrHBh2Vhjj/ORXaEl3JKqT0e+lIQFJF9MwTMhhbEWDYgVRrM9kLUFxy7u2Dm18W2yagrEuhZerNr7p8PZQs10b5iUI67e/56B6d8YvCgP6NFt3slAzKhuYATPZj2LyY2QWuDl4EOcf5ZHgcTx8Umm5BDiNof2H6f1sRwfOHkkqNahJRHEmB5fM0muJ3SXV/uWxP3yWca/GDvCqHaHog8hbEBAVdnUhtXGBTzPKnuBPE5fLR+ODVjXWzWcVBetf7OUuvSVZHCKORbNYe9F+/wIkBehJcYQY6nqe0Adda1EbSZz6Bb+JmLKzDZJqnwtcGppAU0XjoWYksMhX3Lbij7YVLohHU0yFfDonH2v5tADJvL9ftSz7rYpB18WwJekG146FXfzlqdQxwjjelyQwttI0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:09.3073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4147c695-0a02-484a-1004-08decdf39af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..08f0d11a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3364,13 +3364,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


