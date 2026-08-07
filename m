Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC42C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDtr-0005Ka-D7; Fri, 07 Aug 2026 02:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDtk-00059a-10
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:41 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDth-0002cM-VP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSzuR3YiUaC2mNWyJVLC1G+M5egOaPWg40RbaW32ayhI2JYFQIRsamLZ6tJZKpzsZoZcUECo4Fo3y2UQFr2XM/re8b9EkM2VYWspvhOkbzK5dm/t8GEcGBiNvZrtbn6s3Xy4w0m+PINg4vQo1ecP7scJhZxaYZ+uZy7mwEVgk4dmwh8Ixtn4rdRI4oeT8pxi2l6z79J2h1dOtuWASTRsT5bF9ReYQwTdg/bn2rUdZXW71iKQWUaKiEaF++sSHJF8JvdFwbjFhsiW0duMfsqLKIN71dfzrYh211RAvq5bajWICB55eb3PqFAbT9i71Cz48RxqtvL09kPkpXrGuhBjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWjC9M3Wy6rvTQ+QMVrVXu70895B8sgnCdwPWOAupGo=;
 b=iv+hryHjv4b/E24JE5xNT9Y9ncpEaqzBU4BGIEe8xrx0+QSPEPzB6i/j+GM/ksRxH33173mJfzK5Kirbw56yZM1BFAbKzUIwjJbu8fCvtjKTZdtOcIEQraECTEzokkfXcqXTgskC5s8IAOMz6t5o79anre4zJSO1ErrUnyhUAbJbmy4WcmIqdJ1zM91ahgz53rkFDcL6KgVRFhNaF9ZIRBGZeb7BqZy5xifSOlJ6slFZHOr2loo+S/d1v0kfHUWn+5XZCYhrB5BmEbG5Lpqs964p5UJP8udktvuVldCLAhfnP7KoOCfvITU+tpGIeVNb7z8y7ahFkHS612TndJrnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWjC9M3Wy6rvTQ+QMVrVXu70895B8sgnCdwPWOAupGo=;
 b=pfjBysiP7pk5wifquofsRly724pvydM+qxSRbcN21pNJX/t7x3/920vHWxIjuK7SvkE/ebcGgYJm+ouWt9cFNbCJ7tgJdySsZPbAeh02TyF134YIoIHzVRBE8wvCoGOutml3HV6tJ+35OpEW3rwIC/QgO+ob58VLrDP4CfY6Pg8=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:17:32 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::2e) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:17:31 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:17:28 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 5/7] acpi_build: Build IVRS feature report using extended
 feature register
Date: Fri, 7 Aug 2026 11:42:48 +0530
Message-ID: <20260807061250.27739-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807061250.27739-1-sarunkod@amd.com>
References: <20260807061250.27739-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0a3c2d-491a-49ac-1e20-08def44b90bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|22082099003|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: tZ/5CFrunijJGjXPoq66j519BRxzSEdDu0zzzNu3pCT+W8bogZERCtfA4CLs6TeDAUnakiCJogkqUkRGrVlauZzcacWJrecVJoe7rhOVQWojIfWZ/+mHZX/OERu4aROLWo4WEYAbT/LRU5rXfZwM3FHhWl5o4Rnh+qFMAYWO0QeVgBxj70tzUHcj7rfQnJAgSPNQL42nCAjXpjl06XWnx3l+1rHlogsFYPdUSvTIl0modKipfrpc+thp1jS9ldwjitNK7qYjfSY2V7uSsFxRxlQIHkxtGJICLwcL0bAUQqkx9Y0tbPFUz4bRyMxi+2D0MyXxKJtsVb6TJ5WS2PIuxswjTSS1VKIIq0CE2ln++l570/Wfya8L4dmL02bCb8u9gLfRRweCoEphCm3X6cj2ygUORtYIBc6wJq3AJn6f5UxpIUUJYFaS3jGYfn+buFAolf1/k0z+TxE2wfqxJuzg38qP5CzHS9DGUeQuZkX+6gzVSxJIVQH61POgyIqWjqfYjdlOnVQLfRmFVfdq2MdwOI2cW4AhKcki5OYE/Gq/q+/0rPXVE4B5BoIpXUl440ay3bDPIdnN6bPA54K7fc2kpAwtIwBV1bQnEbxEM9w+0ynIIQRp6nTZq+41cDtIeT8qghdq4NvfcfXgLWWyh3Y3Dvfg0eYWv3tMw90VSzZg0NnwfC64IhxlqfKqnA0fxxxzdFAGjK+tT3oGIL7M5p3UTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(22082099003)(18002099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zfMlblicqr7OXztH3hGPfwwToKgRMM5SwUoSDTRhsMLiJpG7ipROoy4vbgp0BdBmldqqyc1mseVN1YLOmWBBiRY3qVCsSyORlXBoG//DktJGC3Tc4ObxfyUhZrmSr9tbs2HgpqsTQgHt35RFWDk7YJIxC10xJ7MLttz1XcCtLOnWX5pHxNTdbY/AewP3xIaHMcJSRrEDC/eahTGuIFKCn0ZiyYlIJzX42A/su7lKrMAmGVzra69P/5Wk7dtgBWDKAqVW+9nbgi0U9jC/Kiu/yb/Ab/dpVLxZEiFZEl+nBSY1fGDuJuzXFxsAbsZ81vugofyO7KBI3jm1huxYZc6cTkaXpew1czM40hVbr70Chlh4hu3EwV9zSkI52GX5piIkwzw9X4PjoTu3w995bCwZN8F3INg28wDeG2KsGkPghGHUf66rXpiau7BaNeUWSd7n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:17:31.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a3c2d-491a-49ac-1e20-08def44b90bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Sairaj.K@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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
it, current feature report does not have GATS and HATS set. Hence use
the extended feature registers to build the IVRS feature report.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 48 +++++++++++++++++++++++++++++++++-----------
 hw/i386/amd_iommu.h  | 11 ++++++++++
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6e174f20a4ef..656a693e661f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1839,6 +1839,37 @@ ivrs_host_bridges(Object *obj, void *opaque)
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
+get_amd_ivhd_feature_report(uint64_t extended_feature)
+{
+    uint32_t feature_report;
+    uint64_t hats_mode = (extended_feature & AMDVI_HATS_MODE_MASK) >>
+                         AMDVI_HATS_MODE_SHIFT;
+    uint64_t gats_mode = (extended_feature & AMDVI_GATS_MODE_MASK) >>
+                         AMDVI_GATS_MODE_SHIFT;
+    uint32_t is_ia = !!(extended_feature & AMDVI_FEATURE_IA);
+    uint32_t is_ga = !!(extended_feature & AMDVI_FEATURE_GA);
+    uint32_t is_gt = !!(extended_feature & AMDVI_FEATURE_GT);
+    uint32_t is_xt = !!(extended_feature & AMDVI_FEATURE_XT);
+
+    feature_report =
+        hats_mode << AMDVI_IVHD_FEATURE_REPORT_HATS_SHIFT |  /* HATS[31:30] */
+        gats_mode << AMDVI_IVHD_FEATURE_REPORT_GATS_SHIFT |  /* GATS[29:28] */
+        is_ia << AMDVI_IVHD_FEATURE_REPORT_IA_SUP_SHIFT |    /* IASup[5]    */
+        is_ga << AMDVI_IVHD_FEATURE_REPORT_GA_SUP_SHIFT |    /* GASup[6]    */
+        is_gt << AMDVI_IVHD_FEATURE_REPORT_GT_SUP_SHIFT |    /* GTSup[2]    */
+        is_xt << AMDVI_IVHD_FEATURE_REPORT_XT_SUP_SHIFT;     /* XTSup[0]    */
+
+    return feature_report;
+}
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                 const char *oem_table_id)
@@ -1847,8 +1878,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     GArray *ivhd_blob = g_array_new(false, true, 1);
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
-    uint64_t feature_report;
     uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);
+    uint64_t extended_feature = amdvi_extended_feature_register(s);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1921,14 +1952,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
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
-    build_append_int_noprefix(table_data, feature_report, 4);
+    build_append_int_noprefix(table_data,
+                              get_amd_ivhd_feature_report(extended_feature),
+                              4);
 
     /* IVHD entries as found above */
     g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
@@ -1961,9 +1987,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
         build_append_int_noprefix(table_data, 0, 4);
     }
     /* EFR Register Image */
-    build_append_int_noprefix(table_data,
-                              amdvi_extended_feature_register(s),
-                              8);
+    build_append_int_noprefix(table_data, extended_feature, 8);
     /* EFR Register Image 2 */
     build_append_int_noprefix(table_data, 0, 8);
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index d01f9b41dfae..319db1861820 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -174,7 +174,11 @@
 #define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
 
 /* AMDVI paging mode */
+#define AMDVI_GATS_MODE_SHIFT           (12)
+#define AMDVI_GATS_MODE_MASK            (3ULL <<  12)
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
+#define AMDVI_HATS_MODE_SHIFT           (10)
+#define AMDVI_HATS_MODE_MASK            (3ULL <<  10)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 #define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
 
@@ -296,6 +300,13 @@
 #define AMDVI_DEV_LINT0_PASS_MASK       (1ULL << 62)
 #define AMDVI_DEV_LINT1_PASS_MASK       (1ULL << 63)
 
+#define AMDVI_IVHD_FEATURE_REPORT_HATS_SHIFT        (30)
+#define AMDVI_IVHD_FEATURE_REPORT_GATS_SHIFT        (28)
+#define AMDVI_IVHD_FEATURE_REPORT_GA_SUP_SHIFT      (6)
+#define AMDVI_IVHD_FEATURE_REPORT_IA_SUP_SHIFT      (5)
+#define AMDVI_IVHD_FEATURE_REPORT_GT_SUP_SHIFT      (2)
+#define AMDVI_IVHD_FEATURE_REPORT_XT_SUP_SHIFT      (0)
+
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
-- 
2.34.1


