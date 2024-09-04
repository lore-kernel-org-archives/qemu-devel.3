Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC48CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slms8-0000or-Nz; Wed, 04 Sep 2024 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slms4-0000jc-5X
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:16 -0400
Received: from mail-dm6nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2415::630]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slms2-00067A-27
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rroHRAyObnmrXukEzhBakA6VTefnRiIQ0CtZGzvgzsuUsWL3ETAqwDnrqo0ByK3ssw5/vzD5/rpMTNZ8n0H43XIWkfNfXRexMVTB6GJbhTf2wY6cyeLDXqzOhH9TU6ig43mrzqOprFhzkpbRs6vwqp5PICbX8lpe2aAAdWaoDgrsjK/v5wQipB3ralV0NG92erL6NUVisgM808vB0zYnIqKtE86A7gIrP9ab8TIL8ytUPswq3bf7w9ObT/P6kk5o7FI8brKA+nArbu3soxW5Ucj/PzskKKNYXSz1iCTAxNbktjc+GNHcxNq4gfKwAlgav/hvn+C533fr40S5VB7NuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DlHsow6pooE0FOeI388EBmvdjDgAOq2ToelbU4aCWg=;
 b=NwaCV2zInoMike7vEfUnNnmivm1Kq1zXzdeS1SMzRcKez5xDMZEw+tnsxa1RpYFiyMchKLpXlqvPsTjCKWxtkBdf5lCGxFTBpsVlxce5pWZdcI7z6Kvd+xFy+Z8GZLntBC0Y9Hr8Sr36iPuBA5NLdx/Q4FZsIlq7pVP4J0WQ1Va+KGrsuJH6huhmvbc01seCUtlpaAdVQl9HQ3Z4IydT/+zKzcJW/4+3A99O9rJ3qjc7vI8oDCh/HwkbBOIHs/YSsYHBkePFC6UkxDJZApIkXSg6AzBSj6p5nPxOvPRV6Hfc2gY/QjJyHZdkJMY+UMg34dTfwy3azu+Q5jO/mqq6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DlHsow6pooE0FOeI388EBmvdjDgAOq2ToelbU4aCWg=;
 b=Oup1x2YtibMi6BkXAHSheWOhv/LEISPW8Gu8C3OUgyFIGpWAoUBlQdV24442LaMlWybhiJRO7l2xvgjc99MIgAalDOAldH6aqQavPw5LVMdz4TFP+V63S/LR9M642uvaDADwAwlTvdHEjwsnnum2Qsv1ll88As0f/OtVKVDThLg=
Received: from BY3PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:39b::11)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 4 Sep
 2024 10:04:05 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4f) by BY3PR05CA0036.outlook.office365.com
 (2603:10b6:a03:39b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 10:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:04:04 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:04:03 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 4/5] amd_iommu: Send notification when invaldate interrupt
 entry cache
Date: Wed, 4 Sep 2024 05:02:56 -0500
Message-ID: <20240904100257.184851-5-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904100257.184851-1-santosh.shukla@amd.com>
References: <20240904100257.184851-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: ac321275-4ead-4ae5-109c-08dcccc8e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mAJimC1wfJ3fQpjQQf1gF5AEP5n6PxqTx+8kuAR/8FGXwhdiXdM4arxXK3ok?=
 =?us-ascii?Q?Usog4f/V2VygTDLP1pvlURNpbHtxsSaPgROJJDaAWCzviDVWduF60x2cFFTC?=
 =?us-ascii?Q?9l2C7P45Ok01zS95JIzEHXBo+UMtBJi8FNavAOSyQm/N4GTmXO1n7Ao+/IM+?=
 =?us-ascii?Q?IfGLQl7M7YfqK4RtjGCGic+7eZvjbOOZi4bGmasboUN3yI676T7DIfFNfnH8?=
 =?us-ascii?Q?7OgPFr+d54G8aXZD8WeQmUGqF86N0N9HJ2RFjxQlvP/L1ztfF/zgsjmkh2Rx?=
 =?us-ascii?Q?Fg2xxyo/2PMJvHUxT1lw9Ww5dFskQgGAqZ3mbDoPSvf1GaJbyYBRtMc9tpUw?=
 =?us-ascii?Q?a133hIrPp+cXQsWB/SLIqP61UAw0Z7y7GpzXQpbMMsX+nDFOqnwQVYD/NWxW?=
 =?us-ascii?Q?tm5Vphyn2YXtkwlYoZ7d/8ri90MEpu5XQnALkYjwR4bKDCVotk2msR6F7dLx?=
 =?us-ascii?Q?9JL20ZlNPDtZ94nWSzMrtq05HbsaYr6w5zwgIJ6ZHmRaScr9XCSgyijgZSEf?=
 =?us-ascii?Q?25fs+R3LunCL/hdV3fSIzJ7UxhcrL1OuomS7/xFKVAmXAjCS5KQdbO+MnUXB?=
 =?us-ascii?Q?yfHsx1IjhSKIjpG2qeGgRTlhDOod1ui3bEwn/5kYl1zh0NKVlyW98qTgLjXG?=
 =?us-ascii?Q?H+kgXfTfVBB1xoLkFyoKfAxmTUzM3mt9SL34U8Pp1xCOo8hygcqF1ZsfIWrK?=
 =?us-ascii?Q?75lCKelAXZHWeJINZJ8gysbbxM/QZIlylFU4ijAXBg6TU850vHCeZIkbaKj4?=
 =?us-ascii?Q?8gOdcJccpXq4BSA8wRoAefmfAo2LDw9qJrIglO69N8BWC+CAJZzf7onMD463?=
 =?us-ascii?Q?lmqeTA8M4nA5xHRhLER99rRnNLOCkzDkZVr5HAZmO1nnOmiwKVI93OtidMqX?=
 =?us-ascii?Q?9/o5QI/IAyazRmtx8jjgtN/2VywzFrmjxtIV+oOPEjHzNuCviHOnu0Fyt6U4?=
 =?us-ascii?Q?pJH9OxrwVyEjrYeceL63UenAr77MNkMdWYOYMMPrS9CmaFdyoQoJaNwHh0pc?=
 =?us-ascii?Q?8NWr2lj62+WB9EMXdSxhAC3lBwhb6B55UjRA6c1RqIyAnGJ1hbGG3YP4D64L?=
 =?us-ascii?Q?uL5oCs9w/dM9AggToAmQtrOKrtRKFfCW7w2ndtjpvsut6kdTD6fwLY3xOaj9?=
 =?us-ascii?Q?FtNQnx4dMqTi+HzujrYwgLk+z7lbL1d81gTtoBFdDmC4vAsNf7CwsjMh5bhj?=
 =?us-ascii?Q?kpUcf5BUQuGV1L0Oyhzf7Ydcb1otviXLtVEI3j8gDDMjcQbtBb0xCt9ApXdp?=
 =?us-ascii?Q?hr7LCjA5RRj2/KtMfKCOM4H3HRDSh8pAn0UO/V91xaKXmdApyp1n1AcB6CBK?=
 =?us-ascii?Q?hO0cPFpOjNW/F9kzspXymIr23OU/3HLmG66L071PYJMz5oA62pyJAM3SKSby?=
 =?us-ascii?Q?9TmCXTgHjrA4l2r3+qZpWKarK/TXSswotaW9E0WxIqzcJY90gs0Sjc/0brTS?=
 =?us-ascii?Q?+R1Q9eczbN7y+1NTCFtDeN8c/cPnRjvn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:04:04.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac321275-4ead-4ae5-109c-08dcccc8e873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
Received-SPF: permerror client-ip=2a01:111:f403:2415::630;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
index ffe91dff3986..5acb40fb909c 100644
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


