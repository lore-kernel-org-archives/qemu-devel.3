Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ADCCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPy2-0004Bf-S7; Mon, 11 May 2026 08:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPxn-00041g-S4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:42:26 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPxk-000515-D7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7Vxxb+11P+lrEu6r2A7CogWh0vq9zii1MuF77lKD+hj9tvzcwJvEDlWxnRdUDmjSw7z3XXxrrG57mcFRrAd6tLY0uC2ZNiklh3tOaqceY3kiWf0kseyDqkHBnwMfzZ5zqmkqnmE124YxepxagdOKNIPKmoEjmgLogMqu51ddNAa1JRlwnQ9HL+QPaN7BHYbYQsC6iSGekV4/adt4layvVBoMM/YU4PsB97A6Sxg5hLrMifJ5FjaYAygxqkAIV8LIqe3wyXvUIsWq3TmFhMBNGV4Nrxkbwok3jeSuzFAWS5wtznurBCBsz873oiPfO9I9uzJpDZw+ooqwln0Vj3Q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfc/3YqGA5SiOR7dISChBYiixxxkseVllzZEKxQBx/Y=;
 b=GRsihhmDLARzxT/rOh4NZ6ewurd0gKIJqecO6fVt4pkvW5Hn22Q0OodDlOoKPF5WqJ8Hmo91AfLB+JEiglmRe4B67hNxO4+K7cl1j5A6BOEIvszYhg+49/0nO4YD+Odr/CNvjEJMxjJ3NLy2qL84gdyn39NtLgOobX0pQF/m+nuahVdxLg/v9rnRFGgJMIgkSB1uel267AtPE0wfxKZJEib3jaNuwmy5uw7TwhCeDYtpgbFSrV1i/8Ers+uwkn3wfg6qQv/w3ye+rEzszuFkyczK2vOiTDNX+60mI0jf3wKHxCw0M8lnC+DzBFktnoI5yNeeM8sbuO4bimgSKgvKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfc/3YqGA5SiOR7dISChBYiixxxkseVllzZEKxQBx/Y=;
 b=fxV08RUCuZ40ePuqJYjQxURUblZanKhh9NPLasOs0PQdw/PxaDecHa1uu8TsOLJGNJ1IqwS6DVX3CXzcoDwQyK9yfK64ICeoxphwVY0llQ6FVLsZy7e70z/KZuUvEP375+U4eryPm20uQHQGiBzKpzx7tNV7qY9SZWDZDc4vrYM=
Received: from PH7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:510:339::7)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:42:12 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::d9) by PH7PR03CA0024.outlook.office365.com
 (2603:10b6:510:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:42:11 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:42:07 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 5/8] acpi_build: Introduce necessary macros and structs for
 AMD IOMMU IVRS
Date: Mon, 11 May 2026 18:09:34 +0530
Message-ID: <20260511123937.32743-6-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2454fcaa-3800-4fb2-9806-08deaf5ab915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tp2xb1eOjFh1+ogVMLSqh7kLnQf7Dm5Ai9FmzD1FUX1DCI/rgkiVyH7i6q+tXNhZ642S+3OtTvcksukmShVoaAGIKcNDjkd3OLn05iRlwaVs9JR6DUJCsenRezJrfyXps8wj+VzB0grTLlmBEDmK5uCC+GnYbFxfpkyDVcwiDy7aOTOLkxiu07kQDiOrBNcu6LZVUPL4Q6X1S9KOyP9LavOds0Ac79kGkZGrPbTWMBv0o+0J37lIElw81TmjjlNz5vndinS7jfJN9Bkv9Dpb6wPzYCCECHNGZ4F7KkwI1BZGUrRFVjbxfNbpSBqmgIAXotZHK6No4LTXoM9hSMW3DOEYTMGlaIH/yvEphb6HYBCQgNnvuFfZiezIxOm/4Xsc7gSu2VhB3Vb1LtEbFBitRLB0lgaJDQRQNJWWsh3SxfrizdJfVaHbXcgZRy65o9fuxGH6XUcKdsL6lAlAHBh2LgDlDW2W81RvVneP/20EsCwYnexoa6exL6wAFSchlAcIwmXorOUiFr2cHbTCZSFrXeLZKex9a6Vl5L0kSRPC7LKpiV+k6Q43k0jTYlZU+kjsqp3VovHe4reds5gSKk+DPcch3HdYWkYUOJ7S/akVIZAjB0PICjq9TNIuf2/gcNY/xWLHqGXNG1FRaXwDDOL7NiaLqnGB3/xe6a6PDXXGuP/CcxV9J7jzf3aDMpQiE+eTiAtw34DOiNeuh7ThZ1d1kzLVzCMb3Zxjj6g6ojdELhwrkjghidznuOlk3kBCRDUxlyZ5N9f1Iw+0aVY7kbLhJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R1PRwh9pGhUPJ9HbrU101zoBlu0HNKaNnKFas61End62X/tq10ZAtFsnpJzu4rQHh1PqRWsPV58rVveVsF8kg8JZmmgZjG37tYigVN2s+WSX8QlNtv7+z5ZdVmLr5z2aDLXWHOu/Skka1Vk5MfJlCPOKXFbbR+jRP2Mz78a5AoL2N5XgzTv1ohXqLYeSjsRZcNkA6hjNn5VIiybTlFWLNzzRV2BhMqm3LyNMpF/7Tkr/UpQKD9KqqhM7ay9uajSbY4ub2lX7zOHZpysH8wamo2O8YtiT0/bChQNYKa0dLrwRJLcxR6sS4Wk6DWs4o4qz/KOyW7Wrp14lV8B91Id3+HVLOVmO8Qbrepa2TAA0iC0YSP7xqL+16rdeM2JA2Jaq/+J2tbzlrZ9D9MMAdAL07whnsM+uX7ZRI9Tbmu+7RK7xH1Y5rU8ALMsXbL4K+sPb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:42:11.9651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2454fcaa-3800-4fb2-9806-08deaf5ab915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Sairaj.K@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Introduce necessary macros, along with packed structs which represents
the AMD IVRS data structure, to hold the necessary information. This
will improve readability of the current code.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/acpi-build.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h  |  6 +++
 2 files changed, 98 insertions(+)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 8ba3c33e4831..9fd60a186db1 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -2,10 +2,102 @@
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
 #include "hw/acpi/acpi-defs.h"
+#include "qemu/bitops.h"
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
 void acpi_setup(void);
 Object *acpi_get_i386_pci_host(void);
 
+#define AMD_IVINFO_EFR_SUP       BIT(0)
+
+#define AMD_IVHD_FLAG_HT_TUN_EN    BIT(0)
+#define AMD_IVHD_FLAG_IOTLB_SUP    BIT(4)
+#define AMD_IVHD_FLAG_PREF_SUP     BIT(6)
+#define AMD_IVHD_FLAG_PPR_SUP      BIT(7)
+
+#define AMD_IVHD_FEATURE_REPORT_XT_SUP_SHIFT      (0)
+#define AMD_IVHD_FEATURE_REPORT_GT_SUP_SHIFT      (2)
+#define AMD_IVHD_FEATURE_REPORT_GLX_SUP_SHIFT     (3)
+#define AMD_IVHD_FEATURE_REPORT_GA_SUP_SHIFT      (6)
+#define AMD_IVHD_FEATURE_REPORT_GATS_SHIFT        (28)
+#define AMD_IVHD_FEATURE_REPORT_HATS_SHIFT        (30)
+
+#define AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT        (0)
+
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_RESERVED             (0)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALL                  (1)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT               (2)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE          (3)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE            (4)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE    (0x43)
+#define AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE       (0x48)
+
+#define IVHD_VARIETY_IOAPIC (1)
+#define IVHD_VARIETY_HPET   (2)
+
+/*
+ * Vendor(AMD) specific fields in the IVRS header
+ * Excludes fields in ACPI table header
+ */
+typedef
+struct AmdIvrsVendorHdr {
+    uint32_t ivinfo;
+    uint64_t reserved;
+} __attribute__((packed)) AmdIvrsVendorHdr;
+
+/* IVHD type 10h */
+typedef
+struct AmdIvhdHdr10 {
+    uint8_t type;
+    uint8_t flags;
+    uint16_t length;
+    uint16_t devid;
+    uint16_t capab_offset;
+    uint64_t base_addr;
+    uint16_t pci_seg;
+    uint16_t iommu_info;
+    uint32_t iommu_feature_report;
+} __attribute__((packed)) AmdIvhdHdr10;
+
+/* IVHD type 11h */
+typedef
+struct AmdIvhdHdr11 {
+    uint8_t type;
+    uint8_t flags;
+    uint16_t length;
+    uint16_t devid;
+    uint16_t capab_offset;
+    uint64_t base_addr;
+    uint16_t pci_seg;
+    uint16_t iommu_info;
+    uint32_t iommu_attributes;
+    uint64_t efr;
+    uint64_t efr2;
+} __attribute__((packed)) AmdIvhdHdr11;
+
+typedef
+struct AmdIvhdDeviceEntry {
+    uint8_t type;
+    uint16_t devid;
+    uint8_t dte_setting;
+} __attribute__((packed)) AmdIvhdDeviceEntry;
+
+typedef
+struct AmdIvhdDeviceEntryExt {
+    uint8_t type;
+    uint16_t devid_a;
+    uint8_t dte_setting;
+    union {
+        struct {
+            uint8_t handle;
+            uint16_t devid_b;
+            uint8_t variety;
+        } __attribute__((packed));
+        struct {
+            uint32_t ext_dte_setting;
+        } __attribute__((packed));
+    };
+} __attribute__((packed)) AmdIvhdDeviceEntryExt;
+
 #endif
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index fe8f4a6cdc74..d97ddbd612dc 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -175,9 +175,15 @@
 #define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
 
 /* AMDVI paging mode */
+#define AMDVI_GATS_MODE_SHIFT           (12)
+#define AMDVI_GATS_MODE_MASK            (3ULL <<  12)
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
+#define AMDVI_HATS_MODE_SHIFT           (10)
+#define AMDVI_HATS_MODE_MASK            (3ULL <<  10)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 #define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
+#define AMDVI_GLX_SUP_SHIFT             (14)
+#define AMDVI_GLX_SUP_MASK              (3ULL << 14)
 
 /* Page Table format */
 
-- 
2.34.1


