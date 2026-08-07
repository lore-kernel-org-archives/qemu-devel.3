Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6357C5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDtK-0004gG-Pj; Fri, 07 Aug 2026 02:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDtB-0004bR-Bv
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:10 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDt9-0002FE-G7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVVlMb1DZsZq1xMtu/4Uoy7aqXwIhTs+Lv0tTDzjDveQv29TuCr+Etm/jMEe4JCYWoebB9c7Z2uSVrS8FrP0Zv7Frv/R777V3rO7rhRw3sRhXNEBBODMlSfAVaxJm4FVuipZcNzA+14r+Qw4Na2/PRTYB7FSmQ0zLItFgw0HRFS5UpTyp7B8S1tQ4ETd2vRVmvc2SmsyXFJppGz21k0SdLA7JS6wfDjZF/YCBx/rtBZY1bUkw0TyA953bMoRZ2JEUmroadTMf+xx1RIv/nrpRw29vnNSqpx+JrKHjRBecycyyPQ7tB3R4Dq4BxoHEHZSgp3hgft9UYjVaFpgE6p85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOfTPP1Oshxu2zDEswZRe6ScGMLf2qOrZl1EBjdOviE=;
 b=EbodjRfJ68yommYsuiuZhNmUp9yCjSNaP5tQE54nmc94C5gPHNnNeftvaFf+Rqck3+hXccqC8K3Bsh12y3sDgO/OGXTgPFuXbIcgOHy+PepwzzutTQauxtoi96pyhV8LNn+MxHNpudh0fmpbsHu5uxImRTLfSxGmNR1s5bef8rjRuoD7IKn3sgvryEy+DUvDjvXvtgd2CGI7Nk/tLpAGipPkITivRkp3BpMJcGtlXeTu4Q/phqlBK6zH2auyxRj+kfYYTFtM7e8eewd0oDLl+2KuQMvoLt1kt7QBcKk/Jls78W19GPStKf45rtwtiSypepM+68LFkqmzmjzyktnJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOfTPP1Oshxu2zDEswZRe6ScGMLf2qOrZl1EBjdOviE=;
 b=qbObudvGRfz5sjqF03nsKkEI1knuqAS63jHWU11x5170Ib1fIEwaP/9ifZ1LJS/BL4IRIodKh3ZF3pWY8Rie1qMuU8JcTczBMlNQzAWIbBGP1O7+L2/6uHuuz9xCYZy/+zfB/JIg5J5QP7LlAp7R/F1ynHdXDvUrklGTdwmaEeQ=
Received: from SJ0PR03CA0203.namprd03.prod.outlook.com (2603:10b6:a03:2ef::28)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Fri, 7 Aug
 2026 06:16:54 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::81) by SJ0PR03CA0203.outlook.office365.com
 (2603:10b6:a03:2ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Fri, 7
 Aug 2026 06:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:16:54 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:16:50 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/7] amd_iommu: acpi-build: update PA,
 GVA and VA size macros
Date: Fri, 7 Aug 2026 11:42:46 +0530
Message-ID: <20260807061250.27739-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ffb97d-24d1-4412-a28c-08def44b7a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /l36Qp+vVeUjm6tI2AEDLZNWf0GqYhg4aVLvsWUzcLQyo/g92BS2ht/MNoJQp97YL1AsXXbiFhp0tjYwCPDDSjHZzWo9IkWIbuLeFzfPiha8PYZGUuuvPgrswID4kkH+nzNtXLfKnFk1V6LV8r7w2kq2pvwgYWwHIkpjECP5UNquqAHXegcVx1CYjyfB8U+PJWp0Xcxd/+u85wszyZmAm0ZlDyep6Hs+ORSU5rA3m9Z2kZXgSa7yt2S8twfn5etel3ZTtIDhxX4f/aS5v2p+VXoAUXV9KkLBshn7Nf8lyWN8RaGd0FDcZN04Z9f2xzqHsKVFyWS5G5sk2YZPwq1ZJ5wfCEOWGLOeDKccaK26R0jsw60FbiP4e9TRzRNSZXiGwOYUjvLl2sa/5JIteF8W31RiXxk877J3gJUa0xcgG1egaC6PeCvpfMViHHzWxVtKZdWlA7idzIwAdwaHZ37Jib5wPtpwEQMPy/EfN6s1Eziu7iQgkzF3ofh1A/tTjjlnfKR9QeaG6p+m6NNaYHDCnGqt/9HrhUcn9C+uGlix/082tdQgQdJbFdq8q9O7+T97glhY0hXTXV/MGKNPn/OTKAGWZDFgYDactbvEmFSHQkuCxYJa9ovWk931iQb/S22C6K/OkguzkcVC/5O6jpwtAoK/C7OzwnjnjQBKBaV+wssbKHKGOlZeCwtdZGtXK+vxvkSNhc3p25ksErWJccwKPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qLHOOm63U6C2r4Ug7LYbj7yYkqbGXbJoZU7qq4h7tvy2tPXv9G272bO3Nhv4N29+8XJzkIVscCC0kMlEeUHnzw9sDACmsNZOY7zVtb+YXPsWVClnFn7FtzIHqCZElIR2lhHIpizJrO3/0FmV8YqFcduWG+tCWEQ0ZwYv5OJXNmfY2lPLf5NhYNkjezb7RLWBZVCd9iid8c5lgdx+gPYcWXG/PRnXUV8xOVrRnG15NFLcH5z8h6H6c0jB38jG9qzciT4PGJ+cg3XEABJS3schRu/PV4p5+WQCxbK8S0LGzpUJ8fU3IRwMEh+Zt1uZSvbmcxWWmrTud0YZ3go3zchNozA8q46OQOXVJH3iM2lyPuHiy+WdahZD4OVA2aOnRjSnPVOI7uy82T2I23Dll3sVeIYrRq7Gb+DqAD7Q5drvOmTrQjlOfqpMwGpKBv1LB0Dc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:16:54.2825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ffb97d-24d1-4412-a28c-08def44b7a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.K@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current implementation supports up to 64 bit IOVA and up to 52 bit PA.
Modify related macros so that guest can see right size.

Also, use these macros to build the IVINFO field in the IVRS.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/acpi-build.c |  4 +++-
 hw/i386/amd_iommu.c  |  2 +-
 hw/i386/amd_iommu.h  | 11 ++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687d1..d8c14644e62e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1855,7 +1855,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* EFRSup */
-                             (40UL << 8), /* PASize */
+                             AMDVI_GVA_SIZE_48 | /* GVASize:     010b = 48 bits */
+                             AMDVI_PA_SIZE_52 |  /* PASize: 011_0100b = 52 bits */
+                             AMDVI_VA_SIZE_64,   /* VASize: 100_0000b = 64 bits */
                              4);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 8);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 90252c52af47..b840c40d872c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2595,7 +2595,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
-            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
+            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
 }
 
 static void amdvi_sysbus_reset(DeviceState *dev)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1cce..d01f9b41dfae 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -243,9 +243,14 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
-#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
-#define AMDVI_MAX_PH_ADDR       (40UL << 8)
-#define AMDVI_MAX_VA_ADDR       (48UL << 15)
+/*
+ * IOMMU Capability Offset 10h: Miscellaneous Information Register 0.
+ * VAsize[21:15], PAsize[14:8], and GVAsize[7:5].
+ * These fields use the same layout in the IVRS IVinfo Field.
+ */
+#define AMDVI_VA_SIZE_64        (64UL << 15)
+#define AMDVI_PA_SIZE_52        (52UL << 8)
+#define AMDVI_GVA_SIZE_48       (2UL << 5)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
-- 
2.34.1


