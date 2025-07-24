Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C28C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepm2-000890-Ps; Thu, 24 Jul 2025 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueplw-0007xn-La
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:46 -0400
Received: from mail-dm6nam11on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2415::616]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueplq-0003h7-TA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTRh4Q0WidOT+GyBkvCX/L6hwp0In5rUxQoWtDEVxfU8bqzLLaInlxB6mofQR+gyxdcZlV+hFcx2mtz5tgp8GrzVM+nVKQdfjOaiE8oaF4ihpsWznHPYOoWjNO5R0TLGvDH7b95qgaU43IoQruVeNvLSaQd9bKepM5La+FLbESufOAj81uM441gowMMGXhkVrcLosjLWttjWVmk/hsiukM/ewWROurIM6IOT8t32y69ssBMo5ta1nvAYZQkof8XmuDCdRE4kdp9+Glgh3DUEZVBjfWXe+fLK86ncczFbR2n0y79L68abh4w+DR9CsPHdlUZGAFkZYhQ6FkVc+86TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INdmkIJ2kVyjQtWchIEIFsEqRw5cfVpN28DIfIixNIM=;
 b=J+3RbIo3fYLMhtykhdM4om1/DTxtFZ+g2aXk48x+0Vv3sxV5Vc+k+PnYAaiBWoLgDswMO3tO9lRMpmdhXwaNlqxnu3djgvkkSoJvUOwWuBD8nwijpOmRiYlLhOEgZxop4WSv5MncrL1Zvqb1bLeuIq7+cqLKnbpx17Uf1WjAZ0oQY4TZwccsRwWbYRQxycD9Ziju+m5pXyrbqCB7/c3RlgpARkaE0a6U+CL4GkXTHWhOTPmNwrxzLEbt0VEdsIaZ8CLnOOTJABT9ZykpxY/q0o75bzUZFlHwGcmGE2OakqV98kyUhXMNHodvwi7EBnp8suEFj4tattraOvM4fMF16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INdmkIJ2kVyjQtWchIEIFsEqRw5cfVpN28DIfIixNIM=;
 b=intFx2N6SlRSNd9Fa2BtobLGDdeJsayw+f0GvTy9px0aGi9y/jbLhThXiXDnLLYQjwR+qOW8KPhllwh41R04WapoE72HuGKwd+CnEOT7nrQPaQXtBRr/DhYuxMiObVww0j1hTaiWOVc87FsBTUgSfc3c8JCurRWjk0UVeeZhlh0=
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 24 Jul
 2025 06:49:34 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::ab) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 06:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:49:33 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:49:29 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 5/6] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Date: Thu, 24 Jul 2025 12:17:44 +0530
Message-ID: <20250724064745.4091-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724064745.4091-1-sarunkod@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f7f525-91c8-49af-c1c9-08ddca7e3f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?01Hjf2IviH1sg8f4P4LUQiAOqiHz7D1e8c1v8n29Ok5tIquJCxBxxtg/4sCd?=
 =?us-ascii?Q?nQKVSjWQJkuU3WS0GH87u3HqSiMyQrWao6u9fKlopzV3fFP3O7iEA6xARD9I?=
 =?us-ascii?Q?JwJ5OAHiGkV2sw1+AhYx6MibfCj+sKF1jK9zplbKPYIUAvKVjs/X5W93/glK?=
 =?us-ascii?Q?FoHUDzrUsrjFWX/3MgTopA022LL9iH/nWGzPqQo3J9zM7IfxkJOsdEkwrBUG?=
 =?us-ascii?Q?2JCRdSr2YpktKny0q2FVeICA3O30ePgG9/x3y0K3LwOUWxOnWhjkvW+I0qx4?=
 =?us-ascii?Q?J/tcSwNJ+IcgjlbSLqWRBLkKaMxQ7xMPYk5514t5/80iScdxyVPyOeyvViUu?=
 =?us-ascii?Q?ZDAfVh4Nc8VbZIPq4qMW6GZ0ssPEXDG+5MAQy5NZq+2lpWbXIBJ1BxmA9dYO?=
 =?us-ascii?Q?y9PGXxLJL1wJmsOC5wbk9qUffmEPlbbMv2sTqPrjnglbshjc7yzMZRd6aBhY?=
 =?us-ascii?Q?tAFNsiLs6CT+odOkhnKmrC1aHv64WS2AQPpqQlr2d3OVFR7+1kSdMhfjoS7E?=
 =?us-ascii?Q?Pb1tBJ5S5SsQ68WLKayaX2tZt1DP8kd4hhPtZZDsrxhUIS65aNrgt5buOjEd?=
 =?us-ascii?Q?XZOBIkgDPLuPO9uAw06SYWREjF9VG/BCYpuMLthuqm/DG0pKkcuN54KcD8AD?=
 =?us-ascii?Q?eCmgp8JwOJ9vBtwwoSWxpKfsUC5xwxV/ciFMOLz3Pi/hD4VuNTzklu8byeBX?=
 =?us-ascii?Q?erKEdSPFwkpJEoIt6F3z4ieBUgSGeS4ETBTuwEPlgGbrFKOGWpCj9+n1weg+?=
 =?us-ascii?Q?7YUwf4KMDg3NlWNUAdTZZQe+5w9a8Lfq2ptKP6uQa3wJQg8zb6Axw92iTQBy?=
 =?us-ascii?Q?YJz8w95jXPJIX5fahCurVCgKt+D1GCdp6FimqSCXo7O1V9RBfPd8TbZx2uyI?=
 =?us-ascii?Q?cvwXE/7WNNbGQiqADKKqtz1qtpMaU73sTd3p9DDeGVvOQJC/tH58nSSCqMUc?=
 =?us-ascii?Q?lnCuXq+ogw/hx+9hMZxNQrheVQJEbuRTeaKDMRMBayhusP0kS2LwOdmQ8ggx?=
 =?us-ascii?Q?FqpFU8Ht0JILOE8QPjh4t5yicTEOy/h2sBnTaiEbPKRsvsgVIz0ML1/ykg8p?=
 =?us-ascii?Q?dtzOgSIKZ/WueWPWVEIU1muEpAYAINpYwqfCSQ+gIyq2FUxuW24g8/BINNEU?=
 =?us-ascii?Q?EoIK96wRWKSh3i4acukwvX/SOJjPJHbGptrJ0kbe9esn7hoXG9CnmZhIeD1N?=
 =?us-ascii?Q?wO89xLLy0BPlsARnT9L0jB6vDMiNilD4O+xBPsgY5zZNdg1Sp10MqMXlNFRr?=
 =?us-ascii?Q?b7AZxpZzDeHgY7m1PZ2k1XzYCnKXz29T/CJRkgVjw4/RODO98dwcAHWXbWn4?=
 =?us-ascii?Q?o2yTzEhpU46TJFVkSV+w06X+VvNHtVLZl6XXu7QToUlKvEjRPBIhKMZe8pGV?=
 =?us-ascii?Q?skEZ0hynth65xTxeWuK1+o3rljVELQJeYraqyaP/yegT6BCCW+ZhkuPyMTmd?=
 =?us-ascii?Q?emOIFxL36FFiP57LkuItDgMrVtbGa07QHvEcD+73g/OsFOBViGTiKrCZpx6x?=
 =?us-ascii?Q?S9AKVFLnqoeldD1Y352XOeAki3bQ4TTUk4JN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:49:33.6918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f7f525-91c8-49af-c1c9-08ddca7e3f9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:2415::616;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Support the writes to the status register so that guest can reset the
EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
respective interrupt.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index bbffd07b4e48..7c2fa80d14ff 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -850,6 +850,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
         amdvi_handle_pprtail_write(s);
         break;
+    case AMDVI_MMIO_STATUS:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
-- 
2.34.1


