Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB3CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE35w-00062V-Do; Wed, 29 Oct 2025 06:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE35u-000604-5T
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:07:54 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE35n-0004Z9-Nl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKuQaNfZ/R/4Jtom88YeIkoVrJlD1Mj1Xth/8Qs06ghDqUOylql/6LF4IRFvC7xUC2DsNXQXWEL222/TTMJft1wE4tWzBzwehcTMfD15roVOobsBpT3WhuZPR8Qv6LB7b9614dcPG146RvwkUCe+WOuNSCgHkiA9CetxdM1K/iFpEeNWPH4tHwecXdompmB/NIIgWclt+e8c7sBowEiWv8kIC7csYAtqHAKcOZYOQfHN4EW7IxJ7EFOeqVDNzU1VKV1pbvwbfr/iqBm64KNdqLt1Wr3I+CWWxS8pDg3xGgr8a7rsEqo90HxL+z5J2gzwI4reVN1QIow6N/0YFGx8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiNzlgvnvlDcQCcELpmPi9+HKXd8ggJUv8Hy4Y7i5dQ=;
 b=I+OqxfJyZnCF7P3b6lBAfO62mMER18/kyXqRUZCf3Z/8mZ5HqdUuwQSzN80auJJ/3wiy1wTyfND2GTc39h/C8unr3NJel1GjTGwbsZXCvO8NBPUfKrNu1u6dp5/CooY1fAEx+CT6uiM5mlW1TSDUfPXs4HRGz/UzUENVXqBhFR7DVy890T6fZuHVdl8Sm93k6YIG2VxUWzXg+Dk82CRY2+EzRF7JD1LW9TR7UMBDBsJMh8lmXrEzuiovhnt6pgnL5CKsXmm6dYXewNWHt/wIqLBwbtKNVNIfvdSuZXY917ASxOpOniHs26AD0d80lzwph/gg2vsKZVvM2JF7r41GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiNzlgvnvlDcQCcELpmPi9+HKXd8ggJUv8Hy4Y7i5dQ=;
 b=Iy99Rj1byLWU8ORshOxPhTaV4Smk+d/CAwJXY1FabNF76NYmFqkp/01Ny7JMhGLBRNvj8Kl6QcrfqMIq+cSURJEMV8b3zLiaZHykYn9ACWxQo85W8Cs9ycsFbm1F+mZqaeiYB56DaYCIPnETJDiDujbkyuerp+H5qfb4VlczdMc=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:07:35 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 10:07:34 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:07:30 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 4/5] amd_iommu: Add support for extended feature register 2
Date: Wed, 29 Oct 2025 15:36:55 +0530
Message-ID: <20251029100655.4859-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029100152.4807-4-sarunkod@amd.com>
References: <20251029100152.4807-4-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 544260ae-be05-4844-fd78-08de16d2fb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmwkoQtrcYLa6E/3bkvnYlEU64mvlHlqb0m3pkilj4IlHPqnKiK1EADAeY9/?=
 =?us-ascii?Q?Vk03aVm/XgfR1eUu1pxiXHUiNijVBhGd/yrq+51vDJm84CXp6ZYFW+H+7okV?=
 =?us-ascii?Q?xpTTjkdBwy4cq/JQe0hb97IcAvMElb/r2FnDv0v6XX+VnNcZpelz7IvtQVtl?=
 =?us-ascii?Q?53Yk0x6620e3lsytJnv9e+pBXRER+biNdkVDClqAxSU8KsyMbwpFWcHOtu8b?=
 =?us-ascii?Q?08RJhyBeig6SVIOlBhuRv0XUCVNB9LL629rPmhNxZB57Yztjzwd996BauX0D?=
 =?us-ascii?Q?l0bIiZ1B1n1pw8u6lwhL96EwP/lKE2NeXfhP8DT0cyn9vkCGA5uEGHzcpod5?=
 =?us-ascii?Q?wnSeRf9kX7EP26hCcoQH6QEUd+zMlBTuFBVMYNVMv3zUBwQfm7z5eB0EIAC1?=
 =?us-ascii?Q?anl9aVk9EQSxdrPZ/h0zMrulvbaF6fkmfR1wn37w1MaPmmZCugZo+0D0hpRf?=
 =?us-ascii?Q?lbFW9TCV4piPNoPogmfRqJT7zQMPnnDAeZCYaly5Z7TSoZHzi9/ast4h/aB9?=
 =?us-ascii?Q?pLi4QjQGxcMggufprEPz4HpyyaS+kP6irrJMX07yjZNK9P/aeMwBsBcmQFNQ?=
 =?us-ascii?Q?eWAWwhIcXfiePgQrulMVS2cIftDgC1nIBXFRRwnfSU3zgn1Jma3sS7lrdId7?=
 =?us-ascii?Q?kN9rSFNIRg+4s5Ou+pYkPhYMUFNuUa9QCPME8Ckoklj2dgTGnEniSZ/45yqE?=
 =?us-ascii?Q?X2zUFq78uWevGz3ga+8vEOqSA+5WtHoQ7x+R1nGG3OWuX2AHLC7wed+0XnNP?=
 =?us-ascii?Q?+ge3/bMlltAg7m7ygqWkPDM3JpHO6rfZOoGpVq2apLllPn6afeiTC773ThHK?=
 =?us-ascii?Q?SLh7v3LZI2ScQJdwXDB13u8XhxO4oIdK7hHJetU7G+6IJ8bxHclP3csVXuvg?=
 =?us-ascii?Q?eoDmroZiBjN3e0IQOJUQs42tllN8btx1ZicX6APVJllwWLhjzXXU7c8LxfIL?=
 =?us-ascii?Q?mXDOISHkaAHmQkoeLctpvbqGzyy1bG/gTMY1p2ghp96VpxdSP88BOmN5Vi1B?=
 =?us-ascii?Q?i8vL51ZQCOoeNLNfIbhTKPanOInAAGzZab7qnLapt6eQN5Y0uybJWZxxH9Ip?=
 =?us-ascii?Q?+pnN/CI/lNM4oEdTkr5Ifi9UMEzHSYKSi0iSecxJG+aRKwm+teZhhw0+tig2?=
 =?us-ascii?Q?OiLcDuGr4g83pGKRh4D3pMdK3XialF+BBPQ+h+2b/UBzjNNlbGeERaMTTue6?=
 =?us-ascii?Q?smGppKkMoeN/1AUYVuAz1S6AknOSRv1HRhSJyrctZg5s7obEQc/P8BvUCOa5?=
 =?us-ascii?Q?CTtGbV9Cq4NkKvZv4Y6n5RqygWkffiXFmu9cuda1wUOs+XGeDSlLAA5OcVFH?=
 =?us-ascii?Q?YrR6NC7MIM+5GQR4lKEwS7lfR3JTQqkt+5v+othi+eTM7ZBAq8kkaV1Q+yxs?=
 =?us-ascii?Q?z49ugngYIIvZ983Hp9wGxjZ59EUUGD8dRUCJ5lAHRql2rdKBfRqo0kVP81pc?=
 =?us-ascii?Q?r0KZLfM5z0va0NJJCi6fkG8C41SuVE0loHgHpOn7KH5IPbRBaTXAmsquISnS?=
 =?us-ascii?Q?+gOA+nW+D+8KmQSp1x+y8EU3P1GB69yA203jO0e3kXLNUv8DHjH3CEq9OKNw?=
 =?us-ascii?Q?Pfm10Tqw58azvOsUxXcASjvzk+pgcw/ahGlEjZMO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:07:34.9341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544260ae-be05-4844-fd78-08de16d2fb63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extended feature register 2 (EFR2) exposes newer IOMMU features such as
NUM_INT_REMAP_SUP. Set MMIO offset 0x01A0 and ACPI table entry to EFR2.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c     |  4 +++-
 hw/i386/amd_iommu-stub.c |  5 +++++
 hw/i386/amd_iommu.c      | 20 +++++++++++++++++---
 hw/i386/amd_iommu.h      |  4 ++++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862ca..1d4fd064e9a5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1873,7 +1873,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                               amdvi_extended_feature_register(s),
                               8);
     /* EFR Register Image 2 */
-    build_append_int_noprefix(table_data, 0, 8);
+    build_append_int_noprefix(table_data,
+                              amdvi_extended_feature_register2(s),
+                              8);
 
     /* IVHD entries as found above */
     g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
index d62a3732e60f..39b1afc0c751 100644
--- a/hw/i386/amd_iommu-stub.c
+++ b/hw/i386/amd_iommu-stub.c
@@ -24,3 +24,8 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     return AMDVI_DEFAULT_EXT_FEATURES;
 }
+
+uint64_t amdvi_extended_feature_register2(AMDVIState *s)
+{
+    return AMDVI_DEFAULT_EXT_FEATURES2;
+}
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8b146f4d33d2..3221bf5a0303 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -114,6 +114,11 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
     return feature;
 }
 
+uint64_t amdvi_extended_feature_register2(AMDVIState *s)
+{
+    return AMDVI_DEFAULT_EXT_FEATURES2;
+}
+
 /* configure MMIO registers at startup/reset */
 static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
                            uint64_t romask, uint64_t w1cmask)
@@ -123,6 +128,16 @@ static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
     stq_le_p(&s->w1cmask[addr], w1cmask);
 }
 
+static void amdvi_refresh_efrs(struct AMDVIState *s)
+{
+    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
+                   amdvi_extended_feature_register(s),
+                   0xffffffffffffffef, 0);
+    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES2,
+                   amdvi_extended_feature_register2(s),
+                   0xffffffffffffffff, 0);
+}
+
 static uint16_t amdvi_readw(AMDVIState *s, hwaddr addr)
 {
     return lduw_le_p(&s->mmior[addr]);
@@ -2307,6 +2322,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &iommu_as[devfn]->as;
 }
 
+
 static bool amdvi_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                    HostIOMMUDevice *hiod, Error **errp)
 {
@@ -2434,9 +2450,7 @@ static void amdvi_init(AMDVIState *s)
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
-    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
-                   amdvi_extended_feature_register(s),
-                   0xffffffffffffffef, 0);
+    amdvi_refresh_efrs(s);
     amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e6f6902fe06d..c8eaf229b50e 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -57,6 +57,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_EXT_FEATURES2      0x01A0
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -229,6 +230,8 @@
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
+#define AMDVI_DEFAULT_EXT_FEATURES2 (0)
+
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
         AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \
@@ -433,5 +436,6 @@ struct AMDVIState {
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
+uint64_t amdvi_extended_feature_register2(AMDVIState *s);
 
 #endif
-- 
2.34.1


