Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F7BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueplO-0007QR-Ep; Thu, 24 Jul 2025 02:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueplI-0007N2-IP
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:04 -0400
Received: from mail-mw2nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueplG-000384-9F
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb0i0x6KdkImcz6MMBFQFcL8+LN5FzmaCs+OumbHc7a1JxuvSTXBw/mKGRJV1WXJ6+O2cKDVp+LDnlQQKL1hqyVAGyqDtR1GxDswYwS1kEzdXd0tGMZqUrHKP1VS00SeyK7M+sGN9jG3Mvhb0TiXIZfiETxksYB6CeM4tjBinuGiWbw3mMuspOL3f8D+FWa8F2a/jwya8pQXH6MWg9vGa9IpqVbKxHacv5TkKu7a10v92p1IMVg4dNNIbhuw6bGEVxHhhHAfu4qmkjMO7yqf2Hs6C02ssapRjXRt0nwjs5j/9fQpFZCkV7PlHwP5CE0rpsMDDkwn1YvQa0tIDkQ1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OajnXpkteswnnVqvPrcK1t0zb9OWc48/R6TnAR+nkcY=;
 b=s6KgEtQ0XbIkJWA4eGYgfRtLMtESk5s2rCw9rhsW3CtLyenl4J2egC57r+zrBVPcrMvwHY+98kUBPqS6xBKh9gP1Wl9sWSW1ZcGqRgJPd0WKg0mMd6sz8LgLPsKlVio1Q6E6lrm5VEuE7l5asb6ZSy7bigkk/fz28vqC4l/ZaLyw0CWDkCPBN5MSEla/it6endvu6UYFfRyoYgPplbsnPc6+CZlKcfEOG0Ohjvek0yH5xlI472MiuDjpjZVR7HqOwmmTwt5WsYQfoQBrCvAj0gIKgv42kvUM8LaW6v4lcEBY5pU8DV2G5xKwDWNADQZe4aWTfyKbJseZxofEjY1nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OajnXpkteswnnVqvPrcK1t0zb9OWc48/R6TnAR+nkcY=;
 b=stgL91QNX+rhGyaYeYSSG/curq/TNTbb6g7NyTe8i0jD+YTDAvZk3t6x6LZTSSyirsc4WunZMI6ItCyJFfDKfSTXRI7r6vp0S34NMjIsHyLtt7k8bPBpxTGDsW8UKNOUFC9DbrHCbbSlkOGuheqFMidxf08uSRmzrlB/FiezOUQ=
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 24 Jul
 2025 06:48:57 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a8) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 06:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:48:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:48:51 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 3/6] hw/i386/amd_iommu: Move IOAPIC memory region
 initialization to the end
Date: Thu, 24 Jul 2025 12:17:42 +0530
Message-ID: <20250724064745.4091-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724064745.4091-1-sarunkod@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd18d47-f933-458a-cf36-08ddca7e2987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4pPeM8SfvmuEkkjY6/ymXLU+UDat53ygJpD17blmZuXQ2doWW0NPcDyQNs+?=
 =?us-ascii?Q?ynd0Fs1Lg5AJD1i2izpf6empaXvseEnr7T+qROY3+MeTTv5/FX8O31ZPjVit?=
 =?us-ascii?Q?M+nzWsiWsndE1F7vajaUafT3RmT/qQQlAdmXkfWBbhgPSp/dw3zAAcY83iQR?=
 =?us-ascii?Q?kHFQfeGZE+p1zf4sX1Zhsi+xxDTk7pd7uakAdApmXW1nseTDmCvvNJ3NtOp4?=
 =?us-ascii?Q?a3P5buscQble8VYtzD2Xbu+1i1KJRx8WJGRhzSCRLk15aomCRVTPrG30idPA?=
 =?us-ascii?Q?tri0602rd2sO2XHAMy1jfaproQLUWUJi1scCM16E77QUgn9jnH2uMf9KL23U?=
 =?us-ascii?Q?82Mr7E5cg8NfNoEFaltJ7o+MutCxdbuodsAVGNqGqtY2tsnS1C5hrWnZDkbv?=
 =?us-ascii?Q?jqAHkunv8EMwrEprOvzJhaKEDLgvffthJnvSWrayiZZad7dMJN4Rdl6iIdRq?=
 =?us-ascii?Q?5DAAVfspUl0Ni+EIAwGbUcpBP4r8ryTK2RnnV4z6Af/K3Jq6SQdDaeyzn8nI?=
 =?us-ascii?Q?XQ4Ogp2RTxiuXQLqS2SfydO7Ktblu0VELsrKBqOeLCpIOhS2SwJOPcR0HygM?=
 =?us-ascii?Q?Yc0QVhNK9au253ZfXUYZ0puNHv/Zf49ZU21rFsxZF5WwmUhQA+kUdw8ssX+j?=
 =?us-ascii?Q?2wTAV9QVxQHZ1gCxbTrl9NyNlK477LIUbTcxlThRbvY4WJK4NEJQbFeqcCE0?=
 =?us-ascii?Q?SQ6xKufbqaYnF6a+CfqKvG4F9MmRlQWugj3nbGQJjhNnkW8vG2+Tew4IYB1r?=
 =?us-ascii?Q?93LwfDGqchFjcXh71aW+pyqYEt5RJiLMJlgyMqp2fw6e7yVFJOUeApIxrjNl?=
 =?us-ascii?Q?wiXrpBGiTDmKak4urrpgg1jTAvc8dC8gzLQgSzfjFkl7/Z0qfMEkHBAFtkcR?=
 =?us-ascii?Q?ACTCstJM7u0IJ/dw6ikAy/f4R/idqBfdQ5vputOvxTRA/RFHXfHR5DCNataT?=
 =?us-ascii?Q?EBoqx4QvbHGBEvFAgYAfa2KUV3y1t3Cq8ltHhmDU70bpj2pxUMKIV6sU4AwX?=
 =?us-ascii?Q?qf2ZS2n+12uunxdWyobVYAwDY4W6bUgUDiRKEEztkyRAZn6UG1ixdcxH3ktA?=
 =?us-ascii?Q?r6+gcqmtpMapOxolKLNXAVUQx/T1bCcu9V47H8P47+BhO3G/ONqrd7z/6yg3?=
 =?us-ascii?Q?qOWdUSoB1Km6gCThcHvpZ2rMGE4BnDtIFfd/6LXfObzo4GD2Bn3k2TTECPMh?=
 =?us-ascii?Q?14MR3Oh+EVWx1xrN4bqQpEF56kH5nqmc2U7HPIAty3ZFoQh8PPKpQpz6LrBe?=
 =?us-ascii?Q?tOQcLUT0EHREBusqAyGI7iLS/cAj/gRz1hP3nb9JtV5tr9CPDYcOhaonbdue?=
 =?us-ascii?Q?ubyrtFmB45V9dXNXwtmrHtP+JgZJL40uvvxTzWhOcOMmkhKnwlb98C/5LLah?=
 =?us-ascii?Q?4zqZcL3H8JfMhCYTqN+C3I9sW6yEF06PfPyVQsbHFyeq+SVqRjmgs6BXwTvS?=
 =?us-ascii?Q?dLfRgl2nRecDPgGLVCNT4nii1vCduXYiG/xyBtY0Ju6WALBCcFa4flpqlviw?=
 =?us-ascii?Q?wqnOKabosaEuB0xcCVrRBoKkQiA4oc6TJFnv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:48:56.6572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd18d47-f933-458a-cf36-08ddca7e2987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
Received-SPF: permerror client-ip=2a01:111:f403:2412::61a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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
index 39bb04fd9b18..2183510d227c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1696,9 +1696,6 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
-
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
@@ -1721,6 +1718,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
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


