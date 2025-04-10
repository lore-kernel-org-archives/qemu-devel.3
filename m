Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F27C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2luL-0004Iq-L6; Thu, 10 Apr 2025 03:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2luE-0004IM-MD
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:00:59 -0400
Received: from mail-dm3nam02on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2405::616]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2lu5-0007fa-8R
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1utYWVeZJpnnaKVfpvAjrNtzkb1j652QKmPPWXnbLpuHEm7FPjN/xJuRoLZTv8kgVFB28RPqGyS7aohvNkIeKBQAD/umGZEdEFnIfHSbWp5LOycz5MxVVxyTi1FI1AuOXLWhn8fy5Snuo1iCXz5UWz5z3fWEJ9KRlK2XxL6/66JBmZqdbfUX5LXTWVVRHMi6WeXCSWwbqH2tOoUax86GRoqN7lyoY+JzUe7iQqq9iDi2O4sNHZpbndIFt/rQxsB9eaoMCTxPv/G1joJY0JvTNYHiMFb9S9Om+wr9k6440IRoL1gbQNPM1xfBRzfzGS8fBHuGMT5pdFZiBR/TotyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy/uOvYWuMhhxrZreNST0N9hvsc6f879J57gffLm8yA=;
 b=vDRhdgEkHXt8yYRkfs8a4/sLf+k7NMT5dHv/EOfrNR0nWiGdgxWEUSAXuxYbmTS9jIArliFC5fm0UAmZnxgk6SvNzfeLeBJ5Ax4umc0LmXTjmKKTCXrgp4IP667IHjnp82k22536NOJo97/MQoY5FglxZ2ktnYxRLWpFoDTU1R/Ml1k5DaMX4vVXOonicLBduzJhXoqpy0jmS9zLTsk8EuCWNR33QOamlPYsB0H3KPgOrug8mgsSjGo3VgoobdGTip4W+lRH5FCkMlBh3G4gU7s9IxQbcTIClkg/lSAFaWCmRRoUyh0uySheQ40k4zC0nbpSIQSgawfSYsHd6hgmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy/uOvYWuMhhxrZreNST0N9hvsc6f879J57gffLm8yA=;
 b=vOIwtpBpsTgPi5nV15Mh17yinzBMOX2yBldBJr2tSeRuf+FqVLLNsS5L8Vz7OOCxbgtUZcXsrU+djSI1a62VGBH/YoxR5pKVpKBoP3glu1qAPrxZek8v3sa9uxVjyOlCOhQJqjpVoBymUqDnL3X61vK16gaOICWnzCtKF+x3Gak=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 07:00:40 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::4b) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Thu,
 10 Apr 2025 07:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:00:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:00:37 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <philmd@linaro.org>, <sarunkod@amd.com>,
 <vasant.hegde@amd.com>
Subject: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT is on.
Date: Thu, 10 Apr 2025 12:14:46 +0530
Message-ID: <20250410064447.29583-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410064447.29583-1-sarunkod@amd.com>
References: <20250410064447.29583-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 619717b9-05ae-4779-a01a-08dd77fd673a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hi9sD0JaYx6ih56GMvNr1eeZMGOEJi05gOdeYvxeoPBOxImU38tHHxzFMkr?=
 =?us-ascii?Q?r0Avx7+5shcKdg+RqkfoIRQfbOjbACalTvg0YzDBArCdR9GdVUPUXDQZ0LMP?=
 =?us-ascii?Q?znmocMnYxjeiGAO7s37eLYvEKwqyD1Ow1BoLsb69012Lnaa/JLfiAsEUZXtA?=
 =?us-ascii?Q?abcxcSeSfv4mtIG+YRLsrne6j8jFFUv86h+XdcR6RX2Apt11A8CdRsKPKQPD?=
 =?us-ascii?Q?WYFFRyQx8P4kcpiNgubdLPZGoI9G5Qrh37W7iywIHeyXR9UbRbawRzWoed5N?=
 =?us-ascii?Q?NJf6oIVOk0reOf0bkkSHwnyyYzhqIeXu5IiyRb2j6vK4G1P/3HrMXtQl8M2y?=
 =?us-ascii?Q?EoSYxOQI/FRKCKoZrhxED8Rg0uf1lqUESgMKiymn2hyKiozYEhC27L3NWxX2?=
 =?us-ascii?Q?jXINRqD65XafbEJv8Dt7EOmoe+UgcEnL/0WVmkXOf3re4zAXpWo+8XumU2aj?=
 =?us-ascii?Q?x4OAub/fbj8ORkYLIvEUBeuqCgWtiI636i68LA4tjx0zoMKF7nWXpUwEtaU2?=
 =?us-ascii?Q?ALbNrKDZrLCWMAGUMZYxlXpDl9EImPBZO5boQCG5MccnExMqXCPq1Mudjgpn?=
 =?us-ascii?Q?DzjrO1mVZGVg1TuRtGSWi8sj0P+tOJF3smIu586JmHR/VvKrU8LSp0XISAlY?=
 =?us-ascii?Q?UIElHnM56qBEyzamYJP3Gxe43+tjrhAWB60++E9mAiV4QjCelUQHh9+0x+yU?=
 =?us-ascii?Q?yJ25Z9EXPx4I6pFMiIUR8Vj7Q+2dGywxlik8SsDFUDoPMiO2GPWB/W8ycCZo?=
 =?us-ascii?Q?cdLZN6HDkXdryYWxNBnDAG9Vg6w4s58aPeTYGljQzMeJZqZRmw7F2lW7tpHE?=
 =?us-ascii?Q?UCEcOXToT0wE1gqw6IoHMADg/WCmFfcbrRjNAJ4mtxLAJ4iNnLpRVO0DwRVt?=
 =?us-ascii?Q?O4kJBGUcXj1T9VZIH49EfA0ntWR2MelYHTt8GDzNwjkeRlA4KR9oNe0DTXo1?=
 =?us-ascii?Q?ecUXXHRyvq8mXiH+PeoTLD1L09k4013CnPjnNoGjBj49JHzIQh3uOOvAW/m8?=
 =?us-ascii?Q?Yvb5okXhGvjvrLFjqoV0O9M97dahgBtUyCWP61uqPJ8Tv/tfi+/fxa/zxcok?=
 =?us-ascii?Q?zYCXdHgFchYo6zQMD8uZBXSFSKbdlObJnDfBuhgSa/HvYfYmcRVaW35jjtvw?=
 =?us-ascii?Q?QYAEl1JwxlIBZzrFteo0Uvs9wOmYBC1ntD/CbePWy9XzPGgrMxaAoREVeKSI?=
 =?us-ascii?Q?sKLgwjYg0P+GaZa3HAJAN4xBgtBC1lqz0L53TBisC7jCvqbu6yqa1Mj3GcqA?=
 =?us-ascii?Q?qYhOM3F7wwj84WGQEZohOHh8UW/fT0Gl+OiWehMotCwiqH5rxL6cHf/yuSUF?=
 =?us-ascii?Q?h7JG3qU7rEPaDgASQkFvCVwjtEt/H43YcBZUro3+c3N00s7/0KXm8dOxlpyc?=
 =?us-ascii?Q?CICBnCnMnkE/KflDe7AuXFkGuxQign1AyAdCDGxk5ux3INcU/kBW61/lYFvf?=
 =?us-ascii?Q?am2n2jOAXtbbgOzKI8gMWky+RJpIK7KKOQYxdIJJk1BTUB7DFjo0sy4HhDf4?=
 =?us-ascii?Q?Pxhd4zOZUZJ6s+1EYD9x9xw9dAdTKuXCr2Iu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:00:39.8336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619717b9-05ae-4779-a01a-08dd77fd673a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
Received-SPF: permerror client-ip=2a01:111:f403:2405::616;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Current amd_iommu enables the iommu_nodma address space when pt_supported
flag is on. This causes device to bypass the IOMMU and use untranslated
address to perform DMA when guest kernel uses DMA mode, resulting in
failure to setup the devices in the guest.

Fix the issue by removing pt_supported check and disabling nodma memory
region. Adding pt_supported requires additional changes and we will look
into it later.

Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f9b95279997..df8ba5d39ada 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.34.1


