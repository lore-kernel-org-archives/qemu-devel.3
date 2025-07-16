Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5DDC83F2D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwdH-0003RZ-4n; Wed, 16 Jul 2025 03:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwd6-0003Fo-SY
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:32:43 -0400
Received: from mail-co1nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2416::628]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwd4-0000Xr-E0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EErU4fVJKHuhlaY51dDaqj261grM3N9iRrR4UAEtAvEogwiQyK+Ip59HN26XZoPMS5o2L6tSm1yVGFRneYMrOPGtN4EhDvecIWF8xmlxgzZ2XA6WFBmfxaWEP0I4yHp9kK7QRzYF632JB1hxsp7pFarZdgqCle70lg8pKYJq4MV2B1Hgcb1KOIzvsXGVG1nnwKzdhxoJUlBCz+nBxoH9shmJqu1+63wy65OLVcBxu0FtmL16UQCuQUMyB3Tcz/TWW1kf/AJfs3+64vSr/9a3kX2raK4wcCo4mVhpKZFY+ZvGb9H39eNLbca+sfmvGDghzoxogT0FbltjU2RAza+I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH8hnZY7PY4+xVU9HwCbZyA5htoi0iRO9EEvKGFP4Ws=;
 b=zDuBV40ZR6Csatr8hbLPVsoAIIxOwV0A+BXY74RIp9H25CxdNnBe+1F+kn+mIumxkqrzxT3nhVwUgwvOB8qnxhyi07qjz7XRE4Hb79AfJgdATDR5q/gLknQ84k3saIba7bh6vMunIx/QmP3rMXbrW7NiCeLDpTdb2fjL9BkdIsewoY64YlZIa52yC3TsA3imn2hlQoJUu06nJImVF6q7kyaGx+EV9AkfSBwjxD0GZUNGxYvP+/0ghryHfCyGvQRFuZfS8bKEd+fcEJpvXaSgEaTpjb7UQweZRfN2TQ8aawMYG13n2aTIwAmEKbrziR6mrFn58Dto+T7T/8IaDE7wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH8hnZY7PY4+xVU9HwCbZyA5htoi0iRO9EEvKGFP4Ws=;
 b=15CwmIbF2nb5xG54e2piBPA1xz4y/UTLoDi+kc/qavQpsVo6IDTLQqykljm1x2w/UBRqDDu39rthM4mI2AaYKmi5YXb03iybbKvC+2yt97TBCqrurUttqusgiu7QMePnrteqOPhu83ImxP1Ufl+ExE+u2xrHe13jDrwSS9nvpDI=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 16 Jul
 2025 07:32:31 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::4d) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 07:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:32:31 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:32:26 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH 1/7] hw/i386/amd_iommu: Fix MMIO register write tracing
Date: Wed, 16 Jul 2025 13:01:39 +0530
Message-ID: <20250716073145.915-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073145.915-1-sarunkod@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0d61a6-cffb-4c21-2147-08ddc43aec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJs2Qb66vNic4BcQOg9B33s/i99WCecG1EJYQyykUY2WWd0FAvhIA0Hutu9Q?=
 =?us-ascii?Q?fMTy1QNUzFwYEBWAeejQvLtPDdYaW/1DCiL0e8IKlXKGiLr+M2qriOt0QvIB?=
 =?us-ascii?Q?xlGLSmxiGX+YGKoCfC8KG5hIqwv1HrZRZkSur0g1fYWutab/cTb0Khgq54Tg?=
 =?us-ascii?Q?CJlnJYxjI/IAYYWsgjnjjmjGvDQbjiwiB4XrPUnzFqK7mH3ENcMWu+vVupGs?=
 =?us-ascii?Q?5ABMRhCT4uUJVj5FCbdBRPZb+m3UnNpM2RC6utArqcfC2VnFdws62I0j2J4x?=
 =?us-ascii?Q?CJYQjW4c2VzLdFok2Nsx80xWWWi0It7KRmLlY1b03rWr9hueSyRExd4BhMvH?=
 =?us-ascii?Q?D9UasLob3YCGE5BgPEil0asQzxOZ9/+ZzqsQ0IYdeqaQwhh0IlnWP2AamQlv?=
 =?us-ascii?Q?UCOKDEZF5Xiu2MRPxCYFCY5bEELjtYIUg5q/xCTRX+MW0duK38oXQisPixDc?=
 =?us-ascii?Q?xQCjEbRB+xy4VuR1iDzkhhOJZmogOM9HOo2Mgxpbq4R0VieRRxbOgt9R6VMk?=
 =?us-ascii?Q?DHdZuZZNrFPhbeiyYEpvziVmn9FMdAqDcX2uvVwPOV/Nav/d6xScnvNwlHtt?=
 =?us-ascii?Q?edX8hhhNl/OrgLDFNJVLIBMWMbbkSPIFJl5s5VwTejl1r0NlJnN0klTgBgKl?=
 =?us-ascii?Q?MpNiXO55Nmz+wY0LUb6pG1QycCJYYoNJDJ7PappucqPjuA+Qn/Ob8arkJzSN?=
 =?us-ascii?Q?k7LslR2Y27igBDAsYd0pI7Rd/9bTCFzXHWikPjPw/cmCocYttTTCJ+bkMsHM?=
 =?us-ascii?Q?howp+utSPxNgTCbipDwU95AZRlcu9hoclwZ5+xCYudCfLZfiIKkmCWn+383u?=
 =?us-ascii?Q?QH5s4K2+iJ1AAePtRzsps9Kt40rq8BK1D36gY2B7HVrrMuC9l4uwZ3qM/ftR?=
 =?us-ascii?Q?vuDU5YrfZjiElcbU1c1BfdbnvbPHQVbMHBVxxYt9+e8RVzmv4crkgq1WlXDv?=
 =?us-ascii?Q?JAS+IWlLKSz37Nn/gCEOXg/7+PamwC9VuS6Pdu32HD3PkXzQsqH60yElTqYe?=
 =?us-ascii?Q?SZ/g4BrbedaGcDVxSxvePDQauGQj1mHjmv2nx263/86kG+AiwXY22YFBdmzq?=
 =?us-ascii?Q?ZCicJ02jBXBoGlsNA9pQP0OhfpRYlTbnB28Zbdd4ma4eWg3IFFNwSa/43lSz?=
 =?us-ascii?Q?CUWEG8sf5BMpXNoSZ7rXKA/38PdqZhYO7uz9/twzTYTVtrP5suHSwtP/M3hL?=
 =?us-ascii?Q?BGI0pcSAkcDIIoeBktmkdTw/FNOUobhSxtB85AkFN/5dHZ1/H0VjLYxaMKCb?=
 =?us-ascii?Q?FgyCa661RB2qfuNDMMvDk5+dkuBv6KVvRmbvwZvHLVtSTkYAHgSmjYaJB83s?=
 =?us-ascii?Q?wFPWX1h7tDr6jDvJ5nhxaV/U8Y3K3tnJskNpt3eCby8pbubr8Ys6cYaDYyqM?=
 =?us-ascii?Q?x90HvcUiCslUPi+hq2yvuD3oKnWMRlshQOCdl7/sDYWMauBIbS+LM38bdv+p?=
 =?us-ascii?Q?c1xcuEd7v8BgecT7t6oxLnSfIbYLAhFH5h7dt+L3G9yUnUNNurZQcRHqDtxf?=
 =?us-ascii?Q?tc0xwkG0L3ncCvCJp7YfzBaMSmo4BPUkGYaM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:32:31.1986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0d61a6-cffb-4c21-2147-08ddc43aec8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
Received-SPF: permerror client-ip=2a01:111:f403:2416::628;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Define separate functions to trace MMIO write accesses instead of using
`trace_amdvi_mmio_read()` for both read and write.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e8af24cedb02..7a9d90f00bee 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1358,18 +1358,31 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
+static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
 {
     uint8_t index = (addr & ~0x2000) / 8;
 
     if ((addr & 0x2000)) {
         /* high table */
         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
     }
+
+    return index;
+}
+
+static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+}
+
+static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
+                           addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1389,7 +1402,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_read(addr, size);
 
     return val;
 }
@@ -1536,7 +1549,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_write(addr, size, val);
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
-- 
2.34.1


