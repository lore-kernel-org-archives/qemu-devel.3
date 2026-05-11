Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAA0CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPxR-0003nc-Nm; Mon, 11 May 2026 08:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPxO-0003iT-AM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:58 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPxL-0004Vy-SM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3V0c3cJ9uJbwcugfKyM2H9nBkNKz+ULS7tF05L+EAMv8qGm7+gA6vfl1EYFOfsVNMwh3mDV4CefFD/qV2FCpr41YIvs3sGGO+NCXXwjIMWnu0lISdsD5Ll6DpQp7VBv4UGP3gntxB8fVDWqgUDrJhtuM0m7/FcPyzf1BOBohVJBdLUSBElivKqP6eUnyIkaFlB512frge4Xuik+tBCxdavg92+PYsN2ZPWIbNnJHQCbiuroZ7eKZPitlBABQm3ZbXJ35wfefAh605FGQhmxYniK+H4ZhxwN5sbyxmaVhd4QNylWLze+3Ozxc6+fwPe5H9aevf+N0/GLtok53wmPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxSZi6fEtizG/Cwtcc/WVIF56W0QHW/05H9fa/wGAUA=;
 b=udhZIcrgDWpxnbLVriGZZEamt0rAr0QNT5tJNhgcXQ/e7nIurdYZEtSTQIs2NAmVoWQyJxbto1enea6vSmc2lpBJsJcPwohvWy55e5XWOrD4auO9FfKmCl3qlw/GRjmKYCkkIfL9xGTApJ42Qf/+3EM3JUztZbIN3n8u8LaRSUYflcx+HpY0aDtJvGSH2/TOj5v4522CyXCV2BWhHAY3yY29M0OLkISlk1ROfzrjJqbJH2g+vrDUgN1uYGDc7hBdQ1eu9QfQ4SRT79SCgcBEUEdMisFxcLoYThkJrG8OZakXet9ho4QWfCbntXGj0bFHIX4hHsDJZzLYmY7IQeVuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxSZi6fEtizG/Cwtcc/WVIF56W0QHW/05H9fa/wGAUA=;
 b=hUC1BcH3hhQaO1YstLnmUQqqWO897cbp7L3h/oWdYQDGg/+hMTHyI2sDl/WfhjwkWW01aX91jz/M5H6/WUNDzIJFj1iP+y4Jl2nw6I8nDH/4uooYUNOefn0LlzwVaBXhe53FfE7Kk7Wm8FCiCDv+JYxl4qZMGvWN3XDFpr4DOZo=
Received: from SA9PR13CA0157.namprd13.prod.outlook.com (2603:10b6:806:28::12)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 12:41:49 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::7a) by SA9PR13CA0157.outlook.office365.com
 (2603:10b6:806:28::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 12:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:41:49 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:41:45 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU device ID
Date: Mon, 11 May 2026 18:09:33 +0530
Message-ID: <20260511123937.32743-5-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BL4PR12MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: 18869513-3a80-481d-3288-08deaf5aabbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|11063799003|921020|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: R05PB1yDu5QyQ5eXCoDHPiFa6juNtNKNLFqOULOM0NYipeQp7z23ma+/zUhcynbGA0oyTXjFI/9OZUwGdGaLT6i9etMGs/3JZxRMswdfF5OQD71DXAG+oFGXt0ft4FKYTIiUahRnpp1gfX+hUU222G1flBHK7cI2cRor/z7l2hWCy3Aa0n5jobV9eOX4uHIh8b31rYbYm/phhaIIfwYJttHkE+gDpzf4i4ywtiJeWDv+kI2gJ5rG1KyZTWIvR5LAlB5zl3yz6MUeFzkZfe4wxMn4UMNDXP6gBVUmcA6Bnn4HR6ZEwF3B1UySCstdpha5dAWCRA0UsJTnVZS1catUys5NSStxlTpqoxJ74qc3VPG+XxfmnQ6qtHXsI8I+taiE4NXT/rcpWgjeKhgPRKPWyGXDrZI26N6pNAIVZZJBSshLEa16H1UmY1JFUwqvWmRRRuYs2tbBPzltSD2i7dVp8I75YM1J9OCajmxUxRw0Hld/TJfYLYBRXNihGS2YH0Q6qC0fjF3sfiLDfWYwcsM4lwG4GWWegIx6i+z4oLMZR1N3N0U4w4Uk0x35t6BmcVfqjXMEnElpiQrLPZwRR7QUpXE0TsZnQQMeao8Jt5kszqeNEgqmYDquVR33W7Jl7x6frzsI+UQWbX5haRigxdPOo0r9Fvr3eYF/0M+2wIMNYsnp4dv7CCzbAfCXklBLNzN6ygCHoxJDTfLLxhFWfpg+tvxZartNoQlHzluLjwgky37tDICcFMbHBVixuftZsvnw8WfXgrQTqGNr2nj0GOK45Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(11063799003)(921020)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X3U2EWP009itnsDDXYq4LJYSo5iuyGQ3nnBLs0urktRWW28VA1fcz3xk8LK4/H791kl+t7aE5daM2c01p34sYmxlEiG4/GWOA7a0cwug7V73i6Ns/yfpDQfVhtWUdFEpUyCXyl1LjOAaa/aEAkmCa0/X1T/IezWIw3txix/+MomBJkjXBQe7gamI1NLyur5pRHctHcNyldC6KY4tpZtiNhWPTPVJGOtmmQCkf5W1tI6wYUW38Frak+KRs2+eiwUFujPQxqbMWcGnuUHGc6A/ru0vzlESZ4uyKh5Qr/qnt3/Wjun1ShEb3L/k75S0Y5RAxqu8fjQgbuPe9mrOF9ikWEbpd4P8MXLpgqGFooXFxQu2XJCLUjHCfU7MGluCrKbT4TmXpyFAHdO/jOeJjX1MDK8GnqvPHQ/9OoDZy8w8T/FWPqBgcotC3/aPAUR43aZb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:41:49.5895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18869513-3a80-481d-3288-08deaf5aabbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Sairaj.K@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, build_amd_iommu() uses "addr" property to build the device ID for
IOMMU device and advertise it throught IVRS. But this property does not encode
IOMMU bus. This will be a problem if IOMMU is attached to different bus.
Hence use iommu pci device which provides bus, to build the IOMMU device ID.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e4ad01eec037..718e3f546b18 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                 const char *oem_table_id)
 {
     AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
+    PCIDevice *iommu_dev = &(s->pci->dev);
     GArray *ivhd_blob = g_array_new(false, true, 1);
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
     uint64_t feature_report;
+    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
+    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
@@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
 
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
+
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
-- 
2.34.1


