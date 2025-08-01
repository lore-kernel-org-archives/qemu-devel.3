Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821C8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiuK-000327-1n; Fri, 01 Aug 2025 02:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiu3-0002vZ-D8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:08 -0400
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:200a::631]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiu0-0004yC-Vh
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/9vg1w57FPsMR6FIQh1ibsPcEKWGqYibXnQsktc6Q2cRanC8hKX7brf9DbUT2kxKjM4LqmSTPqWrjmVLx0C4add/K1jDvGUotrdOZLUQOrIgJliVDdow4eJ5V4Bv9/pi/SdlFGYNDOOyH/okioRxCqk7U+1UwVeOiGkSSeL2yxYRsOM7X9yVSOvZe+ODJKB1AT0dsiK4RuzqJI26ZpqhuBVBXIw1CPDQtoujZjZvUziIbP9pd7lRKfOdOX21jc3hhsMOAR+3j3antYflozfLZJxYkvtOeOO/ba6sT584vV0CpUFhWrhGh5b5ZPFCERjnr3Cp42MN3vgwt+Wlddt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9GBtGZKdd06p03YAUcrjJKCG+Dz1eLjPx5d9+uOzww=;
 b=DDJaMMA2zf2IPQO1l+eHUpP8HjHpVxZOlXFTdgnxjlA1hdDtegku4IVTyk0J1dSFMZHg1e/zCDLw9bqcBkT1R6yw9+tISkBxlpXz+s1kd9ICVjdG/y2eueHQDUZdkZ34tf1tNqWKKprWIwD9b0MiZ2m+e6XW0OGjPm0cV1kmNsGGE+unujWMCAbVDe3qM2dxv5Xl2Vvioh/LAvXn5P5bUUjEcmRsRwBDTsd5CQ12oA8BboyHMeZQiiQcYWWDDGLV/4SP4yViuBqA8ucv8BblK6634ZvdZwR043ew75SJVqu8QpMStCuTkxncBkGfBVZdmi6ZAGhtWD2o2KSZqjyrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9GBtGZKdd06p03YAUcrjJKCG+Dz1eLjPx5d9+uOzww=;
 b=UsEjgzIwc1wOrD84NaHm0XrD4KQ9Vrj9Ad5ADYZXXoKvF/GfvlaFvk1iIiDFAiyO7+Aru7VDlBXhjpGdwI48yLMmx3lPKzlXtgyuAq9R0Mge+BJ2wPWwMBUF2uNc5UoxXnRo9G+3lbRKjDtObSgEM/1acHJ5hwYMiROEcMGd2HE=
Received: from BYAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:c0::22)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 1 Aug
 2025 06:05:56 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::8) by BYAPR05CA0009.outlook.office365.com
 (2603:10b6:a03:c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 1 Aug 2025 06:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:05:55 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:05:52 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 2/6] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
Date: Fri, 1 Aug 2025 11:35:03 +0530
Message-ID: <20250801060507.3382-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-1-sarunkod@amd.com>
References: <20250801060507.3382-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 3572848b-b6b2-490a-3b0f-08ddd0c17a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y2N2MojPFWbO1BUBGSBcWbSivAN5eMsJaMA1KbOr3Pzp0hzUi+/l7bLv4ln2?=
 =?us-ascii?Q?pgJtr8HFGJZAzfABjUI0DBoZ/8FAi7O8qnBvzjOcVp8SxoSdnEURphk67XM4?=
 =?us-ascii?Q?WeYbVLzIXF51+I7CDYRGDGSQ1qckCNNnSCVeXLRrCYPg5LJ6gBL4HlcMfFxH?=
 =?us-ascii?Q?yHL7aToTn6sBEgKKn0qZM9LhMAHlim4ofL6431BghbNK03gzBUk/Y+UKm24+?=
 =?us-ascii?Q?jQrtaQo0hybryLl1ZPGLAAbD+YSefCqk41squY7YVV3bxswakHLNVrf3rGZk?=
 =?us-ascii?Q?2Ibln6h4rC2RZYhjvFCDzFgCfie5K5Si4goW9o6osARLOEY1YZkIer7iypJF?=
 =?us-ascii?Q?JmhVWOZlAOgRHa8AZSUx9Y6CISJPKVevY8fRSLVRrXXNYBwMeJmWQZ3bYhI1?=
 =?us-ascii?Q?7vUn9Pod8Y3Ue2BclIYHz892G1XdwzS3uCPm0MWofNVRQOAOaQyyHr93llqD?=
 =?us-ascii?Q?MwdXksZedrKxN3IEcrYoiwrgLs998GAXARLo+llV+jCQCw91RXn6US6XnRgT?=
 =?us-ascii?Q?J5d/4hwrKiGjq5UcbaauFDkGrxZ7UAQ8a/TcGpxVdNUdqDHwWkOSUvUj4cLn?=
 =?us-ascii?Q?+M9Cf2e5s8Y8zGhu8FJRz12M+4lZC6XONhCOFItRNLISh2bE3/hfCNuq8xZg?=
 =?us-ascii?Q?qRZMtUV/BHxP5/2M/NA/S3Cg7qOcI/YqHQuHNCdbca8Rm1OxTkZChpMIAw91?=
 =?us-ascii?Q?JyPEYba3g5Yarm4zch+Zdm8huJQyCVU0LkXS5GpC+NQHD3iwrpkSdxriPpih?=
 =?us-ascii?Q?gM+XPCzuat0LYaG616WESGNUsQ5haLRCkXow5VKctd0ybdJudL0oyWst9p+r?=
 =?us-ascii?Q?mJ/rUMejzBCX29tyY6pyRG35aEK2DIRsjomQi1/2J0gXcgSD5wdUoGh/AKXq?=
 =?us-ascii?Q?QAKtFbh6XAeN7zunCp+CO99N6mCyTZ/sEnT8xl8XhVew3X8C8vu36WUZ+cs8?=
 =?us-ascii?Q?DBrFOIK1SUsCSBQxEilvbICEG855KunOY6qaNgYGEZ0a24GSqkgiD6+WFq1n?=
 =?us-ascii?Q?Aqrpb1gdmH2jgU2UCeD89L6C+ECRsn4dIE1eQVJAY4XVY5OPXAXs93PdThoM?=
 =?us-ascii?Q?ldk+jPn0S83/V6WPTueqfo4MsYzqL5QkCN4dbJtjYNH0qwmFK3D5zOYvmA+L?=
 =?us-ascii?Q?OZ8PakOyDMljgDdqymi+t9WNmWxugfQmREu6r8wgAwb0GnimmHgASDXDTwyP?=
 =?us-ascii?Q?Q7fc4f7SRzWM16vCMbUUQyghfxWwt7dntSaH5D39NZgYpB9vnhX3NLeV/VAA?=
 =?us-ascii?Q?Gl7EUDDLaS6v3OMPhiAkP4V89LHzdNBBkQwxVv6kC04QsoYWAv1XJZ2WjzS3?=
 =?us-ascii?Q?UMwA+q3R+Cp1gnPZMSeCvyUHP8eXVMSpq5wf/9TD1es/eiTKvdxkDzixVb0Q?=
 =?us-ascii?Q?85uhETbynZZLeMp1ZvcasbSPd5P1VAqjIJEGRhKqb5cp2gcQsmnCKJEqe4/M?=
 =?us-ascii?Q?jMM4tBSxV/hwLj6UO4NTBBTrzA2zpOpCP3tXKKXpA34zgC/fOSHcu9RTYVU7?=
 =?us-ascii?Q?UGxSEyEEbCKRteccZZ/iLvfSl+pwOXM/wany?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:05:55.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3572848b-b6b2-490a-3b0f-08ddd0c17a96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
Received-SPF: permerror client-ip=2a01:111:f403:200a::631;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

The ats_enabled field is set using HTTUNEN, which is wrong.
Fix this by removing the field as it is never used.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 5 ++---
 hw/i386/amd_iommu.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7fb0bb68f008..d4e10d63a606 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -646,7 +646,6 @@ static void amdvi_handle_control_write(AMDVIState *s)
     unsigned long control = amdvi_readq(s, AMDVI_MMIO_CONTROL);
     s->enabled = !!(control & AMDVI_MMIO_CONTROL_AMDVIEN);
 
-    s->ats_enabled = !!(control & AMDVI_MMIO_CONTROL_HTTUNEN);
     s->evtlog_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_EVENTLOGEN);
 
@@ -1555,7 +1554,6 @@ static void amdvi_init(AMDVIState *s)
     s->excl_allow = false;
     s->mmio_enabled = false;
     s->enabled = false;
-    s->ats_enabled = false;
     s->cmdbuf_enabled = false;
 
     /* reset MMIO */
@@ -1626,7 +1624,8 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       /* Updated in  amdvi_handle_control_write() */
       VMSTATE_BOOL(enabled, AMDVIState),
       VMSTATE_BOOL(ga_enabled, AMDVIState),
-      VMSTATE_BOOL(ats_enabled, AMDVIState),
+      /* bool ats_enabled is obsolete */
+      VMSTATE_UNUSED(1),
       VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
       VMSTATE_BOOL(completion_wait_intr, AMDVIState),
       VMSTATE_BOOL(evtlog_enabled, AMDVIState),
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8b42913ed8da..67078c6f1e22 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -322,7 +322,6 @@ struct AMDVIState {
     uint64_t mmio_addr;
 
     bool enabled;                /* IOMMU enabled                */
-    bool ats_enabled;            /* address translation enabled  */
     bool cmdbuf_enabled;         /* command buffer enabled       */
     bool evtlog_enabled;         /* event log enabled            */
     bool excl_enabled;
-- 
2.34.1


