Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0941C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCmA-0003Lb-Gv; Mon, 16 Sep 2024 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCm6-0003Gp-FA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:22 -0400
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqCm4-0008T5-Cu
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaX59XyLOhMdtC0LuonesCRe8Z8CJjZSPSuWgkJReRQv5pfg5jZq2GF07CfMXU3BgqybPtwfERT3mM7lcuxKR959WFDX7mvLyxN0ip5jsqoKi7ac2xJizuQVaz/OdMCFkhAchT099AAyfJ21c+hTmLbY/cKK/r4Ew2w/pi8864OvSvT7bZgbIfmqBJTNwvlMqHb1WLsIcQ8yov8FC5+wxOwLzT+e2YOfCNZuHwBmUY8hFALLNqiIRCHXvbOt4LCZXg57jv+aKC6cNdXv/arrS80gcUTMu+rQTMp99jU/L3UrnyRnVltgh3WgQg6sB8FpOeHYBlOPUh8shv0EWMbUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thsc4BaUbibLidZ5Vwyrbhj7vXoVogOHQfhGZsu9eBU=;
 b=S/JXt4vT7QMPNnIXDhsPvKZRCJc5n5c03pfEsZZW3njgIb1+brWCsGOvYJO7VAZdqEYyupyqaNQx/oTankANs/ntk40m6s6ESLVQyBPby5mEVCPiORnh9vm8qdW+QK1upJs/YECU1o6DFLidppJUZq8x6ol9hXAvJKSR8tJJ2k6kUpCgrjW1U8LsOlQaIw8glrgp8ORJ4svkzbvHQ7T4fqoKbaUYFt9b7w5yNrjpHl3jjkiloEE1GkyE6w9GZzwJDtXgxfUHcFI25WB6aHGNPDNjEZO5sjiV+EjvAyZ9HAkL0g3vx4B57zNPGqrC+aiMFq692dWVeLEXDr96boEnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thsc4BaUbibLidZ5Vwyrbhj7vXoVogOHQfhGZsu9eBU=;
 b=CtGEXpvOe6tkJ+xDvLTaLXaCw753TqJ9GSf2CT/+/95vdDMYEhFXwpLNtWUqGQmb5N1SIFu0Ur5NLb9fGwYx81SHWrw0GSEr6Ac10rORjIlj2qk1prjrs6Hmih1WmQ56wNYJDGD5mcnJVTedmegAeYXKR2Qwj3uUoUYjF8JLRGI=
Received: from BYAPR08CA0048.namprd08.prod.outlook.com (2603:10b6:a03:117::25)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 14:32:13 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::88) by BYAPR08CA0048.outlook.office365.com
 (2603:10b6:a03:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Mon, 16 Sep 2024 14:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:32:12 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:32:12 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 4/5] amd_iommu: Send notification when invaldate interrupt
 entry cache
Date: Mon, 16 Sep 2024 09:31:15 -0500
Message-ID: <20240916143116.169693-5-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916143116.169693-1-santosh.shukla@amd.com>
References: <20240916143116.169693-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f30eb4-4034-4b67-1dcc-08dcd65c5afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnwaETVQQLrSzzhZpW3g9z2AgWPGBOHee4LX6bPR6Iqvk7/yZp0T8Hcop27/?=
 =?us-ascii?Q?S15o/uTBP6WVs5nhKVgJIJxbHZhdLH6FjAgxK7m23TsARnk01pjvx/PMBq/Q?=
 =?us-ascii?Q?sbSiqMI2opFGhUIcrQ5nBI39D1YJNLzqeGCS2bnrYKwUeR7ao8BaSEu8Rof2?=
 =?us-ascii?Q?KE0BYAq6f4qHvSZ9YDfGE/UnUFOdwfCQQY/NplPRrGrjIJ7xvVnODLFx3i1I?=
 =?us-ascii?Q?dJWgnsN3OVhEWOLzY6RqEKd7IGnM6K08eMl/S1VjCr+W7ykR1ZMGX+wiIsrJ?=
 =?us-ascii?Q?0S2mzDbXSkGzsieSMaLUqNQ5+gDNOUwYfdiBMesLXCFJ0e21c6BWhXqLoZqs?=
 =?us-ascii?Q?gLitEVNBV5tkAa/YkLSW3mQqoEb/Tleu2fUQgVLvdNZ81+yDfmyP9LPWfVQK?=
 =?us-ascii?Q?RwPMK4zPDdXphcuW/b6W7rr9eUjkbaCE0ibS60x7uUZprUOi/DQBBl3LtJNL?=
 =?us-ascii?Q?cFjTnG4Iaw+Aydkc9jwqTGZeeA1c6JCwZElg28wIMHbRnHGAdHMMBOjWr1wh?=
 =?us-ascii?Q?sRSAflRBAbi8c2YWvkh6RK9muvylYCd9ztQD78ABVAH2MKRVMd6E1gg6jIZE?=
 =?us-ascii?Q?mr26f2b9TFaoUbWg0Am+qdgX/50z4FQnwMd7mRBK2905dqTquuqkONE1QLMD?=
 =?us-ascii?Q?9QRh3+3gzN/9BzbcIMl+I/yH11BZh0GucGAas9tpshapSreFeN8l0EntkwDW?=
 =?us-ascii?Q?I7SbJ0IsP3dRf11W2+gGSJmGF6OjnHUgCJzlS8nXJxLryTot122Lnq1U38As?=
 =?us-ascii?Q?opI8WvEmBxD98alnvcgl7Y7GwBCD1XjH8GOiixj6iVI+3JARvf3tqfwQ9dsq?=
 =?us-ascii?Q?CT09WTvftr36hsWMm12s9Ll1ebKPNw6QNUabeOgKw+GmJnbNu+xGJ0tiH23d?=
 =?us-ascii?Q?z0+noIcbjd4oqMYA+b81XNqvtJUXz0sYdFk+CfHUoqXocL2tOpqRK1e+svFM?=
 =?us-ascii?Q?BylPSs/PlLP8w82wS8ZAHnPU1wWlcDpTMtkL3BFjOloAEsUVZM60H8VLyLgH?=
 =?us-ascii?Q?xhNGAmHS6W4uPfL7QPaGXXIUHLp94g4vbU1hRQ3CtuTcuqNQdSY4Gv+YgoZN?=
 =?us-ascii?Q?KZ1VvKxfJXLGxFEiYJRNd4GhB6xHNn1zC+m0wBFg7RMux1+UJQC1JgzIDJvR?=
 =?us-ascii?Q?X07pGTDghDEKW0f8DJC5QIKq/KLAJgYrWm31bduvxpkmJZXhhOjURT13nhJy?=
 =?us-ascii?Q?JJrpjNMxADpBp9pIMwE2Sb59Zbxsed57uicY892/62643vjQIUlpMW/NO8/V?=
 =?us-ascii?Q?5B+fjFwmIvcnF+8vUGH4HF7bWmtooZhT5ZKEKR8AbASOd8wFNRwkeVB5xhH+?=
 =?us-ascii?Q?rUetELE+HPMR9qIgkPjHjT6WttrhPmcPvujRwHY0PutPmkqByFFtDfACYKxJ?=
 =?us-ascii?Q?zQYUunrgJtVC6UHfYZf39hIzyIrJ5l33DCA26rtLmr3xLDOQH1K9adIrds0O?=
 =?us-ascii?Q?2VdCFTN870ylJIZaLivTZlD983bDUTC+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:32:12.9987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f30eb4-4034-4b67-1dcc-08dcd65c5afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
Received-SPF: permerror client-ip=2a01:111:f403:2405::600;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In order to support AMD IOMMU interrupt remapping emulation with PCI
pass-through devices, QEMU needs to notify VFIO when guest IOMMU driver
updates and invalidate the guest interrupt remapping table (IRT), and
communicate information so that the host IOMMU driver can update
the shadowed interrupt remapping table in the host IOMMU.

Therefore, send notification when guet IOMMU emulates the IRT invalidation
commands.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 24fcd561345c..9095146525e6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -431,6 +431,12 @@ static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
     trace_amdvi_ppr_exec();
 }
 
+static void amdvi_intremap_inval_notify_all(AMDVIState *s, bool global,
+                               uint32_t index, uint32_t mask)
+{
+    x86_iommu_iec_notify_all(X86_IOMMU_DEVICE(s), global, index, mask);
+}
+
 static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
 {
     if (extract64(cmd[0], 0, 60) || cmd[1]) {
@@ -438,6 +444,9 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
                                    s->cmdbuf + s->cmdbuf_head);
     }
 
+    /* Notify global invalidation */
+    amdvi_intremap_inval_notify_all(s, true, 0, 0);
+
     amdvi_iotlb_reset(s);
     trace_amdvi_all_inval();
 }
@@ -486,6 +495,9 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
         return;
     }
 
+    /* Notify global invalidation */
+    amdvi_intremap_inval_notify_all(s, true, 0, 0);
+
     trace_amdvi_intr_inval();
 }
 
-- 
2.43.5


