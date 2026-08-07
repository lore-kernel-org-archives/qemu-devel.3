Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA624C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDtp-0005Ab-Cw; Fri, 07 Aug 2026 02:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDtf-00051N-4s
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:36 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDta-0002c3-4u
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxDJcle0G9Ke1v0h9hYI6Io3nMZNF+wlYeYPPjznQkVYHWa22m/ucGwziIAWH4oxrcUEnst1hU2GtQPN+2E6Rj1joIc++zdjSesuOuUY2GBAWjg9Ton+xxy5lC7XsuJKtf35256j36eaJoRlJ6bpPwHyDmisEMVGVYefjTDYsPIhyuFEN4+WF00PUdP7IZLk8hWzHpbJHBKZo9jZPEl3s7zXlHyrxmm15lFrGztXAo1CpuNWZBEovzGID+x5PD5qDZo5mOtl1XYhzzropq8GrOMHe0mXyrbHptltC8M+TreOvj3bsDJepAMaHK9oc4ZSVpnLV/4hJfR29dt2PQMe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY/y66LEAyaaKrhDNsAiv82/QqopRd5J6e9tUmMORMA=;
 b=Kln7gfOmetr2FXony+sAO9hPDfvsKa8aDiy/CtuL+7fRGouB6hKpk4vXtFtz2CQgaVy2t2IsQ/1FMfCjbinekalzM8kzDq77+jAGW+DfrSoc3x4BwpCtTa+Cp/517dgMh2mT2Hldo1yl7owPWPRrLj/p9i4B3+C+gefNWcxGcmLbYDXkwDyljMQEj6V+onlw78haFCifNvZGpvXmjx+kWURVc3TLsR9cT0LJBeLkJyaHz1Cj5rAYJRYbmIZLWYq5nll1Khew9Lpg+ViPcGA1oZzfAioZnNMhMJWLdX7FHp3rMbSpoWkY9hLfjruINlwiIMGq3IndVVy9Rk56M7S4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY/y66LEAyaaKrhDNsAiv82/QqopRd5J6e9tUmMORMA=;
 b=dV5oVINfUkS3b7l7BkseFmoEryTz4ve09AkBz1HWy7Vg0RsTKNmI4jz354E3/oOVC4v4iZkQdgSCWj3EfEntp8bk3T1B8X1e12DHt5jj517ZjWrzNTouDHA076RkcL7LbnjSEPcOhW8/75d2iWzGGlxSux0GqR2goh+3BeeWzDY=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:17:16 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::6e) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:17:16 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:17:12 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 4/7] acpi_build: Use IOMMU pci device to build IOMMU
 DeviceID
Date: Fri, 7 Aug 2026 11:42:47 +0530
Message-ID: <20260807061250.27739-5-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 24296f58-ed19-4193-399d-08def44b878c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|22082099003|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: KH+Br3ljnum4PDMHNF9H6Ds6E1JU1oTHwZGYO2F5tz6WKh6hHP6ZDVm4NsNwlYu07JjhKHNWeBsDZzSlr2dh6C8u7qrDBrsv2OEPMPHol9b/LYl+KUl2gNmpESH/UqTfjW4fC1PFXR9IlomOKZAEd8NVHhmzzqFK04ks6ykr9ayDEp1ocQ7zqBodyxwO2Zat7SAtnUZTZVhkJYw9tE1O5FqiBUeLreQ+OWIp6Qp9RNkWlGemBoQ3NDzrmf/QKAXjiAzXKbWpur7lnF+4d/BcT5YLdPQSs0C14bTvz3zDjmCY/Zhe5lTFq92WSYAxRwoz9WUze6n4tW2D9yThlCsWtMvwK1Xxiflcj6Ik7FHUNTOGfexo7eYSoYyhuWIYKy5VYwIckdPW8GygtXPgC4OaFCCbN+675loAGOI96pBg2RveCGS9NCzOvPX7Zfs2eYifPCr5iYmZ6ptXkJkYe6iGWgCwwQgnU+23lmkNPiqf3TgI/J4jJ1y3mOvMVpas8nGxVfkW5pi9rapz6y2U/t/l9swzqllVST3DJc6qw/y3/Rp6Qc56oNv6ycfOObDasn3rWrkYLJNUfG6wsiO799JPfpQOUlwlURmEo2fmv3KyxRm33K6dELuPJutx6vJHUFn3pIZ0i8rRq1dy+ua6bVPEo4dbdDqxMXEABBCnjZv1Ss7agHJjksaGr3z7g+FWc2eC8Vvm+UjBPEjpB+KOyGsCag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(22082099003)(18002099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tOEK3M/lX+sZeS4P7AkzXJcAoj5ISKbJXzcxrIz404JrAP+TwVjpd2mE7RwmQPHL1SOVEomMXqPNDyuWT9RCOgPIU1BHCqRvAeRq3wqDp1fTlRE3c+J1HRKVLMS1qll1UwWjqGs5U794LRVyuEY3w+CNz5RBOlpft7qleKXR0FoBke2WVZUxKBHHxwXnCh1DTcNkfRpKjwFdF8VOAP8RQvfzPNbqdt4v1RGhLuw3aeidh2i630bijuXBj4A4EQhsBEzfzBXP8s/f55mSPccLCOibAn6y1tebJSelNuITIuZ6TUDYC5iogptW1fiTtm6N4lcCSjf3ucbI/kPTkg+BFfGvfM9btIC2ORgaiJXNGfc9NuJrvQelvBRhvWcnzP7ExdcsVe4LK0XUB8UNkJk+2KVEIk8C7eMiLifCNGzWXXE850ScgI57HOcgF5Kn+51B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:17:16.5759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24296f58-ed19-4193-399d-08def44b878c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.K@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Currently, build_amd_iommu() uses "addr" property to build the DeviceID for
IOMMU device and advertise it through IVRS. But this property does not encode
IOMMU bus number, only the device and function number. This creates an
incorrect DeviceID when the IOMMU is attached to a bus other than the
default one with bus number 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/acpi-build.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d8c14644e62e..6e174f20a4ef 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1848,6 +1848,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
     uint64_t feature_report;
+    uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1910,9 +1911,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
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
@@ -1944,10 +1943,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
 
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


