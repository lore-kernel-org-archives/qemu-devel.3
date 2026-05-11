Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24408CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPy6-0004Ko-5N; Mon, 11 May 2026 08:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPy2-0004BJ-L5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:42:38 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPy0-0005Dx-LL
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTg99AudyEL0nJ7jNcr0Q0vmmu7A5vejbDKsF0ioS3S6Z2NgLfFICQzQET7HHnGB3+dE6JpMoGs8j1iJ6L/jVxABBh371eXVaNTlgdQalHVKk1hzvRe/P75xz41VEhNQCov/W6TfPmM1lzEACsz1EUmmbf8x2xT18BMDaTdpBdWl3SORwQS68plqswgutP1PFfFU5PyusOic1c7wT6cs5Hvnt0hA4xWE7dBNO/AAUDZOGhCSTVM/xmBENVoCi+rRRaxIqh9WjdpbeKRQxPImspQJUR/COpAw4SIbMzaRIPo0aPW/gff4lYd3siNkeHFvySpdUSx9u3PrN4vRlKt7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcM3xGSIZb8mpGAk28y5nTntwx7j1DvqF2sWnLbvL+A=;
 b=Md7AgbKpYg4KGL/TpnpLtLHRmxxG4EALGrRozgmp7v3UhouLuq3seMDEAsfzkB/ziQCCJtYehFsjjLs5tTBY0KB39Eedy8lxO0+m6ZW+iyImeGYTG4n2cxORQmVydDJbTb0M38PIf9/bzjzpxp8BEtTShRKGincgWvsF6jL8j/0epW3j1suVFlHN/dV2elKOMYoZ+2c/eMK3XOahSELr+6lc9vyFb86CZGxeqUBx81ymt9mw49p28/5S9U71rjz6SFqt70MH9cx8/w4YZGe2PoU6y5eFXDUdmr5kFJ93rGRJP2hMYvcqXPiewMD4UfAO8VKUJMRHaE3aft+hcevF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcM3xGSIZb8mpGAk28y5nTntwx7j1DvqF2sWnLbvL+A=;
 b=5pTrx39fBUflP2E5NrIO+/D4Dl2xWGFj2OCWLK7VmYXcmL12fJ1O2Sux3kQMV0ZL7BsfCE+TLNr7mvCS6q/7HKDccC/0yZ+IzrwgwLD5Y5n0lDE9e6TezTtYjr/XL7Ij0IHzbtXh5YkDO0qqj53ryDA38Lv5MeuHn2tRQdrYx+g=
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 12:42:30 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via Frontend Transport; Mon, 11
 May 2026 12:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:42:29 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:42:25 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 6/8] acpi_build: Build IVRS feature report using extended
 feature register
Date: Mon, 11 May 2026 18:09:35 +0530
Message-ID: <20260511123937.32743-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9bd0ed-3bbc-4f37-92ca-08deaf5ac384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|921020|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: EMbrvrToEyQTpkn6N5ho4Q7mK2xBMu6TI0fgBCQESrHzNSZalngJQG2aGLDcoOuiEDjjUnjnO3uRmeK3Uyk77EHFJIlH+S05Ly6GtdupQzaGwtRoyzP3VfnT5MiXpPuo+AAWQ48gjtepkKYMk7W+fCsdxzhuSvDSYv4g1rgSbZDg1jWIXuVKXiewlVuTW5DMC0pEvV8dX7wns4Rsd4cO6wQJi6DkYzeb2rY+k2Tn2b7lb+tidvc1xwsRc0hXDDKeZshXUAhJi3pBqOsVXS+L7bPByrhWlUBK8Rc5RtnaTtCOzkiz//Q0eqdBpxl4X/6VsIJDzLW/CabG9SdeCcQk0t0Yml0sH2rDZu7m48ExUe5Ky/TN0WFKwV9gtHg3LdHfRr4GYRMZjB+wePKTnarDrGxKvt/ZLDrBsDF7NrT67I2fGUSzamZ7IkpTrf2b9CJAFbtLu3JUtcTt15EaUbjB94wfPw5qVAY+i3z3W33JJLDXbWSijjK6DhvQ42sHIpXGf5C1Y0pJlTeJ/cIz90rG+6VGSTPV0t6OwPVaxnAl07uJI5WTtNMyj7WcY+VYNbltNOSumWd1LG8XmtIILzP8eACtQcZFffl2jtU0rTRUAsH+q+M7bTHwBf6F7FmdSZWo0b5ZVAt7z5flnXlkDxL3UDOzw9TYM75ban65RIMOnG0LSs17x1EQxymFRrv5wr4PXxyUiG+HLGeoOQm2rdiZMY7N4aeMrApEaYv1CvUkxQOsOFhs0i9O/NXtJ2zm0dl29NmJjsY84FzDdhA+nB2oWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(921020)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Th0M5yNFbNbajQx4uniErlV3BU/mZ2hSEQm4ZSAAwQtcNOd+GNEzoym7DUL8U51t8lfydHELlxIRcAgQ/GZRwOice5naRXYCFtiFLsJkiQRfVlSQZydu8W33akAtOeKsyFCW49ndZe6iXLynCtkTWXpgY8dj36LrLlO+Opo+cn092Q5y1gbo2eChl9DExVLClBcUBemxTR9HzgxEA6dxEaqtSYfpA1NPc1GybetNkmy2PtJcpe4uos9hHZHxs+LSMvuJKMBN57J6iAgvCqbS4OYIVYRh97OpjOl9fOqtwXCNi9rnnO70PQusAxlaSb3ZR+g2kInPjuuTh7916mcDHtGJuoI/OB+YTXwoQy08V1SEXBBMp8mkhamcE+G6aJvfOthMVinOrEKvZbt/6iUOFcI/5sMXo9ufMTEhT30aI83ww1x/2BXkzOk6OJi/eTB/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:42:29.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9bd0ed-3bbc-4f37-92ca-08deaf5ac384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.K@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Currently IVRS feature report values are hardcoded, this is difficult to
maintain as any updates to extended feature must be synced. Along with
it current feature report does not have GATS and HATS set. Hence use
the extended feature registers to build the IVRS feature report.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 38 +++++++++++++++++++++++++++++++-------
 hw/i386/acpi-build.h |  1 -
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 718e3f546b18..82208e06e155 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1747,6 +1747,36 @@ ivrs_host_bridges(Object *obj, void *opaque)
     return 0;
 }
 
+/*
+ * IVHD type 0x10 reports features using Feature Reporting field, which has
+ * different format than extended feature register (EFR) in the IOMMU MMIO
+ * space.
+ *
+ * Convert the EFR format to feature reporting format.
+ */
+static uint32_t
+get_amd_ivhd_feature_report(AMDVIState *s)
+{
+    uint64_t feature = amdvi_extended_feature_register(s);
+    uint32_t is_gt = !!(feature & AMDVI_FEATURE_GT);
+    uint32_t is_ga = !!(feature & AMDVI_FEATURE_GA);
+    uint64_t glx_sup = (feature & AMDVI_GLX_SUP_MASK) >> AMDVI_GLX_SUP_SHIFT;
+    uint64_t hats_mode = (feature & AMDVI_HATS_MODE_MASK) >>
+                         AMDVI_HATS_MODE_SHIFT;
+    uint64_t gats_mode = (feature & AMDVI_GATS_MODE_MASK) >>
+                         AMDVI_GATS_MODE_SHIFT;
+    uint32_t feature_report;
+
+    feature_report = s->xtsup << AMD_IVHD_FEATURE_REPORT_XT_SUP_SHIFT |
+                     is_gt << AMD_IVHD_FEATURE_REPORT_GT_SUP_SHIFT |
+                     glx_sup << AMD_IVHD_FEATURE_REPORT_GLX_SUP_SHIFT |
+                     is_ga << AMD_IVHD_FEATURE_REPORT_GA_SUP_SHIFT |
+                     hats_mode << AMD_IVHD_FEATURE_REPORT_HATS_SHIFT |
+                     gats_mode << AMD_IVHD_FEATURE_REPORT_GATS_SHIFT;
+
+    return feature_report;
+}
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                 const char *oem_table_id)
@@ -1829,13 +1859,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IOMMU info */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU Feature Reporting */
-    feature_report = (48UL << 30) | /* HATS   */
-                     (48UL << 28) | /* GATS   */
-                     (1UL << 2)   | /* GTSup  */
-                     (1UL << 6);    /* GASup  */
-    if (s->xtsup) {
-        feature_report |= (1UL << 0); /* XTSup */
-    }
+    feature_report = get_amd_ivhd_feature_report(s);
     build_append_int_noprefix(table_data, feature_report, 4);
 
     /* IVHD entries as found above */
diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 9fd60a186db1..d81b7890e6e2 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -1,4 +1,3 @@
-
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
 #include "hw/acpi/acpi-defs.h"
-- 
2.34.1


