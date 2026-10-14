Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EB5CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGreP-0008SK-5W; Wed, 14 Oct 2026 01:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGreN-0008SC-IY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:35:39 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGreL-00032g-6H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:35:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8TTnYWrF8ErKO5caF8tS9AF1t67YrThZ1GWK7m8wPmsvCqVvvduinEPEeytOF1t1ASTtojCJ7Bu/G/Xi/NQaCZxnx9zaKRftx7zKB6LIkBCdaCSet4DG+2RHeLnCGS/aHPF7wwlkI2iBNTT1+ddGZdQ+S4lP87e4G0v4wequ13+olbkOauHscXvdX4xRNyQr9Hv2t6sSJz7LiF65K78G79JsoMeCvikFi5DgOitmVM4Qndi7wjTvh4pqVV55j7YHSRAU+ZKbPox7VM25Od+Tblh/+bhrSFW33ugCbrOeItb4WaxVjZJkHBBxLGrFtQ0/yaWB8sLPgar3cgdB/UOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5ybgF4hcyJuJZiQYNAFayNlle4j3hFiXYEsFavR9Ng=;
 b=RUyLAKKeyTziz7QV1uZ+v9NiGhD1dY9jXsvUVsKOe7wtawHB6ghxvfdCHgj/eNDmatADsKynbehDdXandCJpkxjJKKs/U/kNNUgzlYaMN+Tjcd269yR3+YzYGmkYthAXKI4LtDrrp4NB2bJV/q7BRM9F3o1dYoMiKvsy1il3+BWI2ydgUdU/gFQNNJoMmxlVRMIF1tcGBclEdKf977NyZrKwFGEgwn28Vf4AjJyuj+7huJ1FlnJI6ipi8D4D3uJ1qUuoFR2SvEKDqxmHUxja3xKebtPTTvozt5dCimmKiAHlKdEsz29oZ9nLGx8bS6mvIqH4zyAVaO3mKUk3cp3/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5ybgF4hcyJuJZiQYNAFayNlle4j3hFiXYEsFavR9Ng=;
 b=wyr+DpGsubyRS2mH7UlmCLITuG1Zi7e5tUf84G5gAwfmcdMS9U6c6ru8AWRWBOJGAT1lZiIhBwcqGEsHUcnX+cOqcPnVdfHnOCAYBeN6a3ljzyn98NmYm09M8ADhNA7MejD3jhzW7J4p3jvPVefv9xV7hUM1afpmmo2sDGu7298=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 05:35:23 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3d) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:35:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014676.mail.protection.outlook.com (10.167.249.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:35:22 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:35:11 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/8] amd_iommu: Assign ioapic_as only when interrupt remapping
 is supported.
Date: Wed, 14 Oct 2026 11:04:26 +0530
Message-ID: <20261014053433.24564-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2589960b-dd3a-4118-dfe5-08df29b4f0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: c//bYF5yz4E3URwlh0HjTK/OFer2Cf6ZcI+7MKA8d1lISHQkfTT5tZlZ/9d2BFHf1Rhh7DDwC4F2w7AQ23+RBjzdXKi/va9QOh1hRD7dZS5Roe0VCzC/B3f3PVzjs1ZMKxZ6Zt0QlgdRQeuqDYh5j4F4H67i06LZ1yMSMc9G1JjuWIGCeVCi3SQErSP+XtTFdLL6yCwrerFFwg0liUOPbGF0wIwOa2kIi5R6gCnOCTq7SMgXdvJCvpJn/nCjH9+ESi9H1Rpp9QdaqjR7cQaiIYBuD8yjXv6ktrUD5jOhFQMb/YZhfy5+JRMOM+Dym5pJytLYR/MpQYKo+Ukcm4Getf8z3ahOQOxxPUV6+p6Fi9zF/4NQTYEa8/CKI87HE2T5Fv0g2TErfpnQwuk5P+QEOuDPCKUat1x+krnXsijDbbPzink8pbyUUxmJWZgwH30waNqac1UaczXO6eoZosL+jaUxEYheXUeDyv7bS12KOq9JGzn4k6WQk55v1RcWOvwD6RIw0BraehQtF4MqV4XzkLRuS/nPhuvlrnJ5JBGtsqZtx8NrdwTJryXUIglaY4qiZLU4Y1PAYPh+d/YHqhzUACdhJHVT6uV/Hbtl1nf5PzjX4/6T1tP37+BgGRY0FG8pVSvrvCXc1fWUVjAt8Tl3XO4W8YyaxF0TYH98RsqrpqkOLUKRtp3bL5vhU3mmEGIv9aZJnIMzGIMSPdbokuQSnMcUIlbQ1uLfsshlOw+KqkE70HtoaRh8UNK6VG+Sfhix
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrHNFO+oSjkyF2Om2e/ZOZqVz7yFxtzuQSDvJZBqPE/0+QJfwvXUCA3tsT4GcR9jTa1tJ9S/VnTYlestWHQU4gubwFri0p02hEq5macp0X6GYLdbWpcrhbYb62LywGPteROY/WpHFZ6+SVqPeFq1N3tCxE5YP9OIIsHrTXQjhXVVwMR41Fyr0bu6VIiKa7iQOMFFXQnPLu4aQ20gC9cEIXw67xYCoYq/9Rad6grZXB3Iz1d/7EMjyf0ra83UyENYTnUZj+Zjok0ntZsYV/Ng0hrfz2vWBLLa0UFLeu1kbYG09soy9TealanN0CH0HkNtK+crwl+1RBqPzzUkn7uf3acwOkgjqPZOvoCYLw/xqiGyRz+ZunvnjwTg8gVeGPMPsFM12oHEp4xlgQyaaIyVvyMf2bLGZBpGvZhBNC+eFPWWhplqAthb7xiHk3kAo8l6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:35:22.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2589960b-dd3a-4118-dfe5-08df29b4f0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Sairaj.K@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

When interrupt remapping is disabled (intremap=off), the IOAPIC should
use the system address space instead of the IOMMU address space.
Currently, the IOAPIC is unconditionally assigned to the IOMMU address
space, which causes IOAPIC-triggered interrupts to be incorrectly
translated by the IOMMU even when interrupt remapping is disabled.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 578c27ccbef6..614c7a131482 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2733,8 +2733,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+    /**
+     * Pseudo address space under root PCI bus.
+     * The linux kernel disables the intremap when it cannot find IOAPIC under
+     * AMD IOMMU IVRS, hence create a ioapic_as with root bus even though AMD
+     * IOMMU is not serving devices attached to root bus.
+     */
+    if (x86_iommu_ir_supported(X86_IOMMU_DEVICE(s))) {
+        x86ms->ioapic_as = amdvi_host_dma_iommu(pcms->pcibus, s,
+                                                AMDVI_IOAPIC_SB_DEVID);
+    }
 
     if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
         error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");

base-commit: 562bae590f194fb590beb5c65da44fc35ab9f64a
-- 
2.34.1


