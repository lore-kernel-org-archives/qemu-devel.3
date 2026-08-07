Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14029C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDuA-0005zH-5R; Fri, 07 Aug 2026 02:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDu8-0005rR-D2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:04 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDu5-0002eD-BD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxw6jjVsyuQK3zpmO2abJ6IEWHfQUGREOW61J+pRzVfGbWA1HbYM5f+95x/2QqQovhbqyVK/Z8R9KKzW6Atz9TQ5t8qZNsoNj7n8UlE4j4DW96OoBGEhMRQupdg9vijIYJ13PgVkgYprii1gpbRUV++IaQDagDqdnb+cfaPo3lQz3Vvvnc45kH4I72oFeCh7wJtiVC0AL3LRGvQtXZNwp3HqJAuYDwnKemmtk7SRbhswvdYp9BgOvcSGY/ZS9IPNbcvUD9gLnzgSwWlu+h60oCQIxiRO17iKrWlqgfHJEP6Ahw3mREIZ0zjegMM1dZqkdXiRTzcT3McaItHqFp8ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RujqY4Wm+6IrnjBFtPwDQ2D3qRme8OOar44GJuXqIWk=;
 b=yEpufvdFpZ/8eJQKJZ5wbVJGhfO1K++JrGZCdSXyk5lNNBKZ0g6Jno9DCxT+597s1RcMeATU7Cu7VG5NSS+fzZxNOPQrIbQggsrpVBXbHBqzILis1JjhWKjWBg/QXKNvWcE/6Nv9MWki3atqmmBXzisWtHTOxDIovN/HKGa2ZbbPLBj+/EEVraqbzv1q6qn2MCClk/oW41uQ6QY1ABxEfiLTmVlRXzmQfj9J46qmV2uH60hD8dbS9E14GAP8GkDdD3X9Ybc2oM+WITne6msK5l7he+qH8AS4GNChu1sPXkBtaQOijUBUz6GL7GPGcmJE2wnLyExLNk88V8kI0iLLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RujqY4Wm+6IrnjBFtPwDQ2D3qRme8OOar44GJuXqIWk=;
 b=iOSFzk7VgQiLCyAGMyT3I+oeu2VREk2ss4514BXbPuONpygZpjRaDzK4kIQT/TGH+BmeeArH3qcaquP3CRh6X6iwgVH/oznqRzs27rbeoL3Q5zVdHtg1z5F9Vi6TXcC0B4rY9EPcVPLlXUOW0kDyiKD9eUVMYFyWri1e7WbaFRw=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 06:17:53 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::3b) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:17:53 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:17:49 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 6/7] amd_iommu: acpi-build: Remove unsupported PPR and HE
 feature
Date: Fri, 7 Aug 2026 11:42:49 +0530
Message-ID: <20260807061250.27739-7-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d184cb-7d9d-49d4-3914-08def44b9d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5NyjKHXMeT5YXzWpHp/sEetDh/WGB3+SKGqZ+hl2prnUerwdvBFJT+m/fpNy9wKCa8YGIitZGniQTMIr8NJjgm9saJcnN2TLInZyOOJNZrqh7TOeNsm13g0RORi7fD+lIJI+H9lDwZPdhW0XitAc22NKb2RyrtUYkziAgCOFnaytD2SNKLlQxxs2NociN3D7p+50xvZakbyUdKa+U2VoZbR8cocV3E35lT996gYc+dLOoK5QEb/8ij9cRgLNtqas/TdIQVAY0820bROCF13DaI0HLSvEYDltya3wa4/LNGkRQ9RI90Z0BG1XdAlF4//UYGBa1j4PqC4rv+ZgL2MS2O/YkfDH5Rb1rYEmJXXCGW6tyTinc76Wnu1GeOJtQQY3NqbbzwUyDGP619oiOUzE9LF+HBVmsB46n8wi+YLo08dqow+RHMerr1CI8EFxnyruKoHwIt/YR9eVut6LVRlcJHKFqzoja1DEylQGTL2k4sGyfKn4wvho4VSGu/uFmXxGEY68UIDnpl4HLgBto6LW0FNUmiYAs5IUAoOX4pCaU4Aje0dRDsY16X1SbvUJg6D1t7xMEHO+ZZd+jB7gCZgV0Mt+QUK51FoBCkceiq3CjxHL0qhJB+t43kWbCcbsKar/rUNon5Az7eXsQZR9IzMmDiErdnrBq6Qytbn7LEdThC4paAAiOcnE9otIj2DWlY+o/A/GL+W9ePFK2URHZDH7/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aXysqSPbbNT3Puv+BuZQpLK/2HP14wQjPGeqafkCJL/67o6El9Lq4S7co7NRUqwBEIbaes8v3PhzSBJM7PIUylPXgZ7XqUYC0pWLg70FIs/14vEBu3l7p/crRc1Ouo/C3ejD7jFrvjCkhzk/ghJddjdAQtgz7tIc2lj60wLBmBjawsBMrOb4ZFmzBLyjuZulNJy+b4CS16degJw6c0V4gtyTWrtbEMPcODEqkZwLjua0NUW9AMr6RASfkIEU5Ay4m/q09WXVDXfBTwf0OR0mgARlVN1xtzJQ38AdL9lwW4FZvhT+hJZ9bYCuHogeiIQ+3VvIVEgVhC/g0+QU74Lrri/Hqb8IAJYEH9MSb/SJpeonUMdYYuBUmr/Gm/Sf2taVAgoeacMPe0+4AA8tCN19Fu3oQIthvld3XoviuZusN8SNISC1dHviqe6NCx75WVTs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:17:53.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d184cb-7d9d-49d4-3914-08def44b9d49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Sairaj.K@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

AMD IOMMU does not support ppr and hardware error registers. Hence do not
publish these features to guest through extended feature MMIO register
and IVHD 10h flags field.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 3 +--
 hw/i386/amd_iommu.h  | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 656a693e661f..749a1fe0d27e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1935,8 +1935,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* HtTunEn      */
                              (1UL << 4) | /* iotblSup     */
-                             (1UL << 6) | /* PrefSup      */
-                             (1UL << 7),  /* PPRSup       */
+                             (1UL << 6),  /* PrefSup      */
                              1);
 
     /* IVHD length */
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 319db1861820..c5b346cc356c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -227,9 +227,8 @@
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
-        AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
+        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | \
+         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
-- 
2.34.1


