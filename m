Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A427C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwdq-0004fh-Ip; Wed, 16 Jul 2025 03:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwdh-0004XN-5b
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:33:17 -0400
Received: from mail-bn8nam04on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2408::611]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwde-0000dL-NV
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:33:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPqRUxtQtjcXXyyKp+dGCtdTJgxJWtdih9Hfk9z2zPGDzJpTdiCOON9Fw6ExVWqXEafd///4RB1TacSwlnS0uon/mPiKFW50z20JaZQe/Z9/lRMMWdNByqWIe2xAYl9TAXKEIGsujd9VFQeQpZfbYOlPplxtiviyaRFiqQJBgL50oeDbQrEdothTt7wzBWMH6mAjT40qbca7+R2v54m1RRC1TUNTGBgGU1oCurVKY9i5NISzE9tzIzXUCJbe2rAxuvdeeo04PHoVn9P54FAHqPB/AIpoVNiAD7P06d/oV9hOwL2i8Ofn6VM1TVvp4FPUanGAeiO3Tqfz1TVClsYfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUfxYJQQR96dKI25S4rOnMwX64hGlSO8SNQp/KZQRGE=;
 b=pfeacuErjJ/ppEE5Dk1TT4fJzssHJ7a9EVa66r6lt5h81G+BkJqf87qbg6LPqxKf6G2CwfnVG8+YzxyZfS9nldr3cjqwCPllqRULH+S2vwar84ct+xA5xMnIG6SHi/zETUrPlRB2d/pwLN+EARnsoJ6vtn4TAt8n4exueLGPuylb8folkXroOiSkyVHZKjy/eXjEF+aTdufPxUv1eXYMfA3dAJqev8JKoncTdcHN02dk57ROT7pKIVKV7Ze8+Rn/E3YfD7/5U9UBZ4GsFRfV10eHG5rSjO9WHxj+k1u/WnyTAuvgbEPRqYaK5oaQ4+fsDVS2/batc7iCKS/SzulYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUfxYJQQR96dKI25S4rOnMwX64hGlSO8SNQp/KZQRGE=;
 b=hFfMmPHXJxKMIHF622tsiP027v2RhkVeprQRBhCafNuQlWjaLPvTO9EmXKzWQ3wmzABBC8EIQINQQIz3NyRFpcusjfNt6rPreluIKpU7YoiDwEvDwmV22+IgUJ6joyDAPfDEQcuE/Je9ptWD0dE9CPogcM7JMTtkED2f2IwO04E=
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 07:33:06 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::bd) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 07:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:33:06 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:32:59 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH 3/7] hw/i386/amd_iommu: Move IOAPIC memory region
 initialization to the end
Date: Wed, 16 Jul 2025 13:01:41 +0530
Message-ID: <20250716073145.915-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b0735e-ad02-496e-0985-08ddc43b01c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LSPwm6heK4/tiSp2uV5lK41I/BSgghWOnD+NmUbHTED1ZO5fv9yzg7WdO3S3?=
 =?us-ascii?Q?Wmihf1cNF8loNVfyJU0Z90O3c+jDdr9FtGepdAXkR2ojYGKwTttU7rd5jCDE?=
 =?us-ascii?Q?+EGvNyTtnmuiol3eP8eHkjqGbSZkPkmZA1rP/XmpfPWC/aNXHYRszHC5nD8y?=
 =?us-ascii?Q?AiWLTgeWA26jic9dxFt4PKHr9VWoCfZFtS5EM2llP6Z/2YGg0z7CTG7bF+zI?=
 =?us-ascii?Q?zdgWCqTv4zDgVsGlBzhdbm8Uhmjj+Z3HGjG2xPBPS/EG4LIXdOrmg3dUtu3h?=
 =?us-ascii?Q?tv6UQpBb28eBclCkWIqcq1XKaiT4BQKJ/qKyL32x8mK/oULUFMw+HXs5eg+8?=
 =?us-ascii?Q?8bdQsYD8gRUCTR7tvyrwMwAtf9W0bPH37Eu4WX4EOzYSKFvVCnryvha5YJ4f?=
 =?us-ascii?Q?oG9MWwCtTTXPG50Dyibp3CpTWZN8RPeTgPwsV3LoyTAPPR6nqJgGmLgkXFeM?=
 =?us-ascii?Q?Qv9LWvmwYITAJpHFyQjj5+K5uggeEXEUEECmoOyfNSMHBds6wAt2h+hcgdzu?=
 =?us-ascii?Q?s5wPaBWviuEUd0ErNCMkeW5PWkrcY0KYy4M8pOwp7Zt27e3WtMCyWqU0rCDz?=
 =?us-ascii?Q?VCN/GrnJ7kBaPwE4ch1WdzS9g1zcUv2m4q4WJpxH881rDdQ3Gtgo+NOkrX+F?=
 =?us-ascii?Q?WwKSScF1Xj+codIbJkV5Gz2SEZ9TwS364gn1fYv1i9NbKe0OLg+S0sJ9aRUl?=
 =?us-ascii?Q?u4We43JISAdbafWb6W1MEAnazl9Bqjr7Z+OJrnRDwzam4Cq7rWy10UtvCFXW?=
 =?us-ascii?Q?571I1KMYuGWx03BAzvViB8q4hiLqmhHTVm4jrZkPns5hg2wm/0bopDtJ6Oea?=
 =?us-ascii?Q?aFnc0sSqXrHSKClxKvj32y1JkALGAOm5sFW1EHkkTU/eCo1X27YO4sv4Ur8Z?=
 =?us-ascii?Q?LmceDegOJmKUTByGEsg1gPitKP0ycSUbc4NaDM1eodfNCqnISdaCoFwJ0eUX?=
 =?us-ascii?Q?JxlB8ZTDMGBc+X6CvPM817e7n8wF/z+3DFFlFqPhmd0FY8F3FYdSk4rxeou/?=
 =?us-ascii?Q?Qa1Bizb0AreaYZ8Lmob2xrcaN2gBXIX+i/R4WfTAmWf0eDdRWIXMRUEJ2wCE?=
 =?us-ascii?Q?LfQuVaADxDqpEBAnWQYJUcQWpMzZyW6mm9uLwN/J2bKwfRuLDJcvDP/zWu53?=
 =?us-ascii?Q?xxDo3zVxiCaLVhjMZBHGnrBAoZGpdP9rmEYUWZMsHvb7BqTKjCnytGR5mAfc?=
 =?us-ascii?Q?T7GyGG5i5tEVliJXM3lEdxjDjDJeSwOCA6DGjsCLPt8UcbZpTga58JDRWBuP?=
 =?us-ascii?Q?bgl6Q2Mksl+yoeXZnB9xQeedNbG15Foo1GZ8qtGX+GnhtwFaarIwtLpMvEwM?=
 =?us-ascii?Q?CZ9Qf/J88Wo6Qzjv5Gh+U4Uo6OPw26u6AKGGc7uvW3Hu2kuhxvlISelXEp8P?=
 =?us-ascii?Q?O7+8stcGt+p76wu/Sj7NEJJi+p0KstHWZmbQnh0usqfDUKYUN6CeoW1C2g3f?=
 =?us-ascii?Q?198iPNE6W0VYne7mBfvnK0bADNIi8oi1sn+doxteNAznnr4frl3WRbtoTibi?=
 =?us-ascii?Q?9exiQA6hICcfFkZXM6i9Dx8jKzeUD4wBWNCd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:33:06.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b0735e-ad02-496e-0985-08ddc43b01c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
Received-SPF: permerror client-ip=2a01:111:f403:2408::611;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Setting up IOAPIC memory region requires mr_sys and mr_ir. Currently
these two memory regions are setup after the initializing the IOAPIC
memory region, which cause `amdvi_host_dma_iommu()` to use unitialized
mr_sys and mr_ir.

Move the IOAPIC memory region initialization to the end in order to use
the mr_sys and mr_ir regions after they are fully initialized.

Fixes: 577c470f4326 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c8fa98142940..784be78f402d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2343,9 +2343,6 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
-
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
@@ -2368,6 +2365,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* Pseudo address space under root PCI bus. */
+    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+
     if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
         error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
-- 
2.34.1


