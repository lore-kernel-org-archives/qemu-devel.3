Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5933CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVXt-0001VB-SO; Wed, 12 Jun 2024 17:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXp-0001PA-7c
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:13 -0400
Received: from mail-mw2nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2412::629]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXm-0002o7-Ui
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq8FZZ4cmbC8kpW+HwXQinPmacIs5AyPT4J5apDpX07xwOvxMPtexStmGBPCnrq0fAh0dfAuGVGpoHbNXPUMcwR6hd/sQGutY1hHD6oguq26Gkby+q9uRNOOh67bXApRc3qa6At5XOou7zx+H/CmOxesytm9pa7+UbkMEtNt7DJPtzzKHfyibZXguS0fMoLfqn8DSwtjufiBhCJoK2WyKQkDz95LQCKaUXKEbGINBgp1yCOcKQX5CPWlCQKij/pdRNCXfJN4bpZGCzcearz42EeEIEehu7c8lHGzeP+0AeCZT9EUYY6iBNF1Gr0bPa05oWdNj6dYIDaLjy04VxyG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMJ7KkTrwysosIa9wix1W+C3OTxXI/gaCPR0zSc7XW0=;
 b=XkFc1qjoIMkwFxtnWH6CIO4/y3xNcZ5YKPEbgPtXzelhPsjQ4cMYdwMu4IThsUAAzLM5BfVCS/qQ9yK4UYLEwNc2Q0A1hj/RuUwuwMXU5HS6XdpECkftp4QS/3Tv1FidOdTIaLImnVun0AQF1xVthkuG8wBHVcBRo3iVGU5TvtlQMRMEZTnjf0aTGWM4PRqCc13RUQrioXmJAPbxloMzkp8RCGP2995eFa3KbLElNoy//vm/9rBYDGN3GEcjnyFwGKg6iTstebV2azdIYuLDcrr9DLxaKKMN10d76gCour8rHUBAWBbrf+zcOLHrDQuGRiBe5kvvXPOhq7r2Jg8keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMJ7KkTrwysosIa9wix1W+C3OTxXI/gaCPR0zSc7XW0=;
 b=VQOWTdBG//GoDBF5DBo15eMI6R1AaHAhDVFwP/uiB1fKADYAjSwItFcAguKfVwYXH1EbC0RscbsWaSC2Iw6nWEqmfyz+OGoKb+ojucxb7Weh14IwtpkWc4cSOrms9OHoZpoH0u9ijff3aVk7+1iVnZiF0cNbK00jhP0P1bfgtpQ=
Received: from DM6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:5:174::23)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 21:29:58 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::c2) by DM6PR21CA0013.outlook.office365.com
 (2603:10b6:5:174::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.15 via Frontend
 Transport; Wed, 12 Jun 2024 21:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:29:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:29:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:29:53 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 16:29:47 -0500
From: Stefano Stabellini <stefano.stabellini@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <peter.maydell@linaro.org>,
 <sstabellini@kernel.org>, <Edgar.Iglesias@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@amd.com>
Subject: [PULL 2/5] xen: mapcache: Unmap first entries in buckets
Date: Wed, 12 Jun 2024 16:29:37 -0500
Message-ID: <20240612212940.2178248-2-stefano.stabellini@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 11834b92-4515-4722-343b-08dc8b26cd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvlOh3WRi1uCzyLb/+09x6bnH9hfmZwzcgFhWMOuxYOH7Z0jsKI3Mjvnrnm0?=
 =?us-ascii?Q?Z/rdR9xrtm5KOLfGtsdoT/Tc6bs5XQ/r2oxfFC1IKnEw+1MzioCNU3a7j1Ow?=
 =?us-ascii?Q?QsdRQ8c51QvzBKpvxNAd7wbrV70xZo1E/61nzCyc4NtIJzHqviU1HlXw+E9C?=
 =?us-ascii?Q?5ktHBvGT4UyphdX6sV+hQHo2diqaQmiTCQM1FDlP5QUXtr6cUa0H2CDw4CVy?=
 =?us-ascii?Q?xhptu5BWqNbK6wnMJKR7D5rGLKh4lHd+FDc6El9itIMQNnA2jvIAgVL4AdEE?=
 =?us-ascii?Q?MSG90tfpBwkqm093JfuG0DKKRUITC78QelrGwP1NXeydm95pd4WgyWkTUsqH?=
 =?us-ascii?Q?dqaI8IhcKiEqYUkyUaqZ8zIMvCAIu1HrH7cYjR63NsYzydXl/tUr29J3rK7H?=
 =?us-ascii?Q?T+cuBG/KZLliQSqv5T1Dx9f+CdVMtNZUIFgK9mitwJJ+Mg67UmaEXcVDsbIO?=
 =?us-ascii?Q?5wNClBaHni00aGuN+W5yg43HctAeIlLqhHjKozNgjncZ589fT3TH3w9ItFjR?=
 =?us-ascii?Q?sHOOO3JJdKACDPC2t8FR5KXY7+zLn4yojSQQqu9/VjQAAUN5DRYfCFbX4XJ2?=
 =?us-ascii?Q?UVe9fsZbUHmKyXrvO50fPeQirHLh5I1Im30jT8yOTE0ztIogKSFwGa2gvtic?=
 =?us-ascii?Q?ZUoxVB2KeQg3qH0sCkIMLNzgJpGiyXbdkxPEVF7hUHBqM4Z+uAydUE8Lw5ZW?=
 =?us-ascii?Q?+2hZwnjqoFF46vC9YCOeUMYh2JJ7uWlr/mLhIYLaVPsi4PRXZk6qSSlYdwYK?=
 =?us-ascii?Q?tIhYfiMj3HDyG9W1R1QjDsUMijvGpaUPDg7J+c7mrmqrhdR5vwm97Xq8/5sR?=
 =?us-ascii?Q?mNA1EaVtRZssu5run7w+e5671cqkY60BkkMQKbOxwy7ux+78CbZtM8CYVCb3?=
 =?us-ascii?Q?b3uDfCmjDzx+7UO6S0OsjpX+OD+St2DN4W2Etm0UnlAynm1QvnsEhsTdQ2Ww?=
 =?us-ascii?Q?lkl3ngvy9XTGejDsyv7iOzQsbcAeuQOPG7atviGExS1cTmunhumXY1AWtGBO?=
 =?us-ascii?Q?iPXKvOMA5PdzaABki/M0EHcHHZcO8a2eNfV6PmAV8VrhsSdoZyaGDAocLgwH?=
 =?us-ascii?Q?u5UAPxB65Edu6JDzRERa+Zu+11XZsM1wkJp/XFsIWlij4ugLlUIiRRnR7hVl?=
 =?us-ascii?Q?7dUMvjEG8l4dq05nqHyVGLpm81Pr4jg0UaXKD2zGPzc8Oh6UC5N6TJUWYFHC?=
 =?us-ascii?Q?3kvwYqSmMlQgsIaolCXd5qfwWijYGeEHx9w+aFdmsDbGYG3+5R4ZQWQ/BSiD?=
 =?us-ascii?Q?/HdEJ+RbkxZMzN5EHibv7rE2lrf/+5xBDbVlgxoLN4UFXfy/2n66tMqRSvGU?=
 =?us-ascii?Q?EZMBhpBe4mHjUQHm+sHgOgqbctOS53RYHnd0jiej2661NDYObv6zlVQU1Vzx?=
 =?us-ascii?Q?3IWNra42s+4FfSt5o+okgczO1y5YR57cK+cIaTOcUGGIEj9qYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:29:54.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11834b92-4515-4722-343b-08dc8b26cd77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
Received-SPF: permerror client-ip=2a01:111:f403:2412::629;
 envelope-from=stefano.stabellini@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

When invalidating memory ranges, if we happen to hit the first
entry in a bucket we were never unmapping it. This was harmless
for foreign mappings but now that we're looking to reuse the
mapcache for transient grant mappings, we must unmap entries
when invalidated.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index bc860f4373..ec95445696 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
     entry->lock--;
-    if (entry->lock > 0 || pentry == NULL) {
+    if (entry->lock > 0) {
         return;
     }
 
-    pentry->next = entry->next;
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
     }
+
     g_free(entry->valid_mapping);
-    g_free(entry);
+    if (pentry) {
+        pentry->next = entry->next;
+        g_free(entry);
+    } else {
+        memset(entry, 0, sizeof *entry);
+    }
 }
 
 typedef struct XenMapCacheData {
-- 
2.25.1


