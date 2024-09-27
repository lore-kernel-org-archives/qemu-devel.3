Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC36CCDD1CE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEnW-0008SI-JU; Fri, 27 Sep 2024 13:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEnU-0008Jq-NN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:28 -0400
Received: from mail-dm6nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2409::620]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEnR-0002rr-V6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHalfYaSUESeWaqwoZeLCzYBfwfza3sRcUdH8bzJE/pgaH6vKjYF6sTLAzL4r41pmd8TtiUvZ0n9ukFloAjvSomt1WP7CEbZnjsOW+UE5PiK/rIVQCPNAOtDh6GP1jly8DGm3YID8555whGWh0QdX+iphJxgDeuXAwh0Imlef3cjVv965IvvhDgNk3Sqc6c0FY56jsRv1WY33nkdqC4PbTh7v0jy6ZdgGcozBhLY3g40thWZGbu7YWaAKJQ9KlYwMTzXGyhqWdb0o6uMJPn05aePmPnoWHZciz5TnGcez7lG/chBpyxpc6gvJY8TP3hg1btCJ+FPD8dILfMRXMf/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiUFtG59lhwAG6HF/G8uqYCoEBCj23N1msfxsyHPVus=;
 b=rCMdzLBZ/uR2UgEwok4HOvrjUgJFrmAKd6zcJ+TbLEHJoiCz9jFB1SQkX3ucz4TNhMlqKRNUix2FMNb+/UG8k4CFez1m7KrgFWB2RFfxuaql39b96O54o1/Br5w6kjWDv1M1yweqSN4gcP1FMyfFXrqTvyyIJze7tOMeiEaXoT28aax5lVqyCaGuO/lOOjWrxZG4J64WYTwKw0jfpP/jzsxufrSxQKa5Ok3uFSXUhOdF56Kv9U8i616QueQl5xmi3cjI+cJQImloHcX6W7JEfJxo8QS+zMpHDOFkIjs5XBct7ka2WSvXtxplnmQeUQdQV79bSpy5phKbxJ5MpBrNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiUFtG59lhwAG6HF/G8uqYCoEBCj23N1msfxsyHPVus=;
 b=BgL1xRYFP2hv5bOeGoMFpHEMKkH8JIJu1Z+VskdqwdvIORlPGnJiKLnkyNaEWMzvq9k/k0hYJyRC8AxAYIEWFal8Gfmk8ZYcL+5J8YtW9YN5u8jB8snjWfgHSjaXEyTuKA2kXaZ/3sWCK5SVnUYJwvZLbhhcRdiHvo3gstZBKw0=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 17:30:14 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::d8) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.19 via Frontend
 Transport; Fri, 27 Sep 2024 17:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:30:12 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:30:10 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 4/5] amd_iommu: Send notification when invalidate interrupt
 entry cache
Date: Fri, 27 Sep 2024 12:29:12 -0500
Message-ID: <20240927172913.121477-5-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927172913.121477-1-santosh.shukla@amd.com>
References: <20240927172913.121477-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce5044d-6ae9-4cfa-090e-08dcdf1a0b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQUqonsNO3UHrqV7ArciE0Da7ewrOTxOf1QfJXQK++TrJY9puB9LORVMVZQb?=
 =?us-ascii?Q?HlUQctzUjg8MkqKN58mlaL+7UpIFU8CVREvlYaJOUjBKn6tkZ1rnfwik6sTc?=
 =?us-ascii?Q?9zqxUJ3Y9gMJNeiH2qbDxHyOCGDxhWjzdub5ivgoUOIw8Js/K+O8Zl9Fr8n5?=
 =?us-ascii?Q?3p3ec1UzfpzhHehmS/Gr9IU5TR3qfKDKxbQb/v3KUewb3xeylaZOz4WJviBk?=
 =?us-ascii?Q?mU//fh1zJgTpveFDbXkQkPr+3hurrQToYNukSEbaIbzeyTghnuVqxvEwxKU4?=
 =?us-ascii?Q?WMehKHPGLHWz+JPzvMLHcPRGQlRf5bP443kHMKhGFxV6xwnWZMJAj3YFeDvj?=
 =?us-ascii?Q?1tEXnx/59Ro6phGz0fyYo976+NtlW91eqQIEKGXHe1qOzkbg2ckzxPrNNPHB?=
 =?us-ascii?Q?MpZzpfsJyvW4a7P2Xpf8kdtOrcjDsB4c4KfPqhl0fKPOURqMEcMqxSVYrtd6?=
 =?us-ascii?Q?u6beQIg6pTBQoMg5b6I9brZf8ApPYjOITuYbESU2TgZGzSkTuUMZS651k/Jg?=
 =?us-ascii?Q?xu8akkT3zEGShEdTe6vgYzsuMsSQAISMuo3UOWWqs4DEBJGz6HRk9EgK7WdT?=
 =?us-ascii?Q?1+3Q7cJDXVcT9SfOgZKXx//OXZJcvT7TOnIPpVp5gqJ1Ab/fyjgen0YttRn4?=
 =?us-ascii?Q?MEHxq5vanAsqOK6M1OHMBEk6AA3C1/5crSWQ0/HxJ520ntY0L3q+Wsrv36uu?=
 =?us-ascii?Q?186p5RMm8WVKPr5cbxxo+URktdFhga9S3MQFyviLUwWog1ThFEawFseqnVe8?=
 =?us-ascii?Q?ub/+isF+M4/mP1UOf8p9W9PCRIp5rivqxTZJcRmVqGb/CGLurSnioOPAMl4k?=
 =?us-ascii?Q?BqF9Sg5Oj/yhhQUEIBUyqQn0DbsDxFj4ocKRxcdJVVEpsW4edf4pZAJSZc2h?=
 =?us-ascii?Q?AplCs3ec0EcW7v319MHUAzklRQ2mzTwVNbmKPpAxcG0IGzYWXNMUTJPCNbgU?=
 =?us-ascii?Q?hVWgoS43DLGpOAF7ZY2Z8OU68ntdY5J2etmfOF/ka5M6qzXHyD5GGUVry/fa?=
 =?us-ascii?Q?JDirsOd/5+C9FOsFWbB//o+Ypp1MHv/f6TeoCMrafdzpchim4ckSwWrNzQrm?=
 =?us-ascii?Q?Wl2H6DGZVQyFR7PdbvJ+s+EEp/QjeG5rlrdoPgdhL3uqInYwzaeM/vXV4EgZ?=
 =?us-ascii?Q?RNUe0s9enQVgNmSTSq5Zp/IpkbICkvPMl6hnPLGo9R/7eZwHGo4YiFUxrLvv?=
 =?us-ascii?Q?Vs7/FEz+/sbtP6yR5wItuTL+jJfD+w87hqEZLl6e7AevsARCrbyrLhkw3V9D?=
 =?us-ascii?Q?DX1JtdSefRnzmmBBAMPDElfU1uohenEC6569sZevS/vXSdCikqr4Dosj8tOq?=
 =?us-ascii?Q?+2kjWnnY45l6Sozq7eOKadZgpr6OwzQcD67IP0XHsgE/HMdAluggNbK9P9kC?=
 =?us-ascii?Q?AFMRimjo/PRihW4CVsQfk4jz1a9VgswdvbA6oBx72vQZ3QCJ55iZK86vcCJY?=
 =?us-ascii?Q?xpnWyk8nT7HV5S0Dd6TtYk2nqjTxNPNK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:30:12.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce5044d-6ae9-4cfa-090e-08dcdf1a0b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
Received-SPF: permerror client-ip=2a01:111:f403:2409::620;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

Therefore, send notification when guest IOMMU emulates the IRT
invalidation commands.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
v3:
- Fixed the typos in patch description.

 hw/i386/amd_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9b923f6eb482..38297376e7a9 100644
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


