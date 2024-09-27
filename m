Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EA1CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEnm-00019u-DW; Fri, 27 Sep 2024 13:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEng-0000ig-Eq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:40 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEnV-0002vW-3o
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh7m4UTr9w2F6bHShdPxtKqd4bJ6XzgHtNgGgOgT0bdXkeLc3Jpqvu9UuAyD11urfyYV3qMRNN+WSAXgndhOVBXXALaDlr9q8sfguQAJ/oUVqQAXyir5L6OnNX9Zw9R9dW4cH4eeUGPo7qdiSHTW23oO8mp1/HXvsCZwDhCcSHrH+WChPTWmlgzNg1noBEaN2e4uCN7wtutZ/WE5gb7ltXSbJSAxSzttgOnbA6ZtbwKuNg7LyYT3JjDs63hfOjrOgG8obqWFdlc9eBL8BnvW1nmrJ7UrXLLai1tixwnFpXQAAP7TVwV3bWgz3NEWnip4oWfv+mpJro+IR2tnC/YCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB4nL9do8VncuAP8fGf7RmTilnxf3oaNojoJJX9+JeQ=;
 b=c+IvBgYz5j/oIaRBDCMGy2eFQXys2Z4lUC6+al3kJF5d5G+WxLe82h0PnkAgUsUG6V9XlH7+7kSVQhExPqhc8ysHwh558Q54U5dAQ0Lug9LAeYFtpziw+pwmIUg5p+2828yB/a4XJZ4FwxLNWuAkzWL6aDl3okUoHOC3V1U4C9YyjE1qrD3uWr6S5tcCE70t0pYyXjxmOrr5W2x61PM6SzM+RZksuCB8j1JUsD4Zo6rLkxUnrVASjlUIDAg8QXK19pfQKcrrSTLwntfm74KJ3sSt0LajkoxFlGuExLUdHo3e5Em0+2KLoMfMKhsnJxx/orplfNKSu87kvK2umcE+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB4nL9do8VncuAP8fGf7RmTilnxf3oaNojoJJX9+JeQ=;
 b=VFrvg6ZuNHG19YLIO/JpgiX4XRWFqyyx88Bt6qORkXzcjoMpMaXSTJKG8bnMTxhz7RsMhvbgx8H5XIK+E7fdG2r7nGk+3fU/nJrV4uESfDTpfhtZAmcZ+TyfF1t3ILfiCQHa1Qy0ctxkzgDi53bpcgrFOkGZQ2ECAlMfFREX9RE=
Received: from CH2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:610:58::24)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 17:30:23 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::36) by CH2PR20CA0014.outlook.office365.com
 (2603:10b6:610:58::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 17:30:22 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:30:21 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 5/5] amd_iommu: Check APIC ID > 255 for XTSup
Date: Fri, 27 Sep 2024 12:29:13 -0500
Message-ID: <20240927172913.121477-6-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927172913.121477-1-santosh.shukla@amd.com>
References: <20240927172913.121477-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a932e8-3f6d-4b35-edac-08dcdf1a10eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F6twd2G5ISZb5Vf9AEQ9AlRX8PKh2fqmE6m389bxcX3VxwQ053Z6vDAby838?=
 =?us-ascii?Q?9WDD+yWPr+oJjVsYkZTKq1Bxpav7YDhk/5ZXkgNnzIfLyDbz/bArhklS67M5?=
 =?us-ascii?Q?Fc7Oat/RiccCNV9SqjAuPp6/qJrtvJk2uLoQ1Hw4riZ375S/lIGUAqRuboJP?=
 =?us-ascii?Q?+HiTB+bMNDSL29S/NiU02tgEwChKDjW5/hN4xR4OsuWNYaExWTpo8Py73EGR?=
 =?us-ascii?Q?adxflFTU5e4vSWiRe/rC6f4Xg4GPfmMJWqUfnfdudygiLZlyjBZwr0JA71Fv?=
 =?us-ascii?Q?KGLOvUFxWb+7GDFTqEr7AKKekDN/TI56Z1MP8M3q2R3OJu+n5MM0B3k8oyYr?=
 =?us-ascii?Q?xMBJEWoiZlWwdMVCV8rb7dZTUAqmw9I9psFa1pZOwSmtxang0o5icPT3+2kD?=
 =?us-ascii?Q?nlJol+00T/CApr+qqq3Ej+L64lD4SuHxOcy0yqAw6esadM2T+kf2oweMdr9c?=
 =?us-ascii?Q?MS6/zeHDrUNZgCeRp8xBOg69IfSroi+zSn2sVEekMKa5h1hl3IVtspHwDl1x?=
 =?us-ascii?Q?Uat+n6ilQl90E9g1ra0q1oLCjQMQ7bN6fx3Vbmn32qqFw/+XUSc7jQ7r5Axu?=
 =?us-ascii?Q?IdlR/ffteL0fBmxAwqiULCRyimdrdrrq8lo/MoVXF9i8JjB70OT+KYyl608p?=
 =?us-ascii?Q?eVavwWnFXPu/Y4LW3idrspNEmJS6jaJstuSGYnSOIzdLb9jlLO6A+5A+SWrj?=
 =?us-ascii?Q?gKlkqKPY9bHziyn9Cs8OQ9/8aN2loKWBAdIY7pqEJdm+LpjM7ppUic1G38lp?=
 =?us-ascii?Q?AVmYIai/2alMd59+8zNh5URDIazJv9AOiGQ8biPoQ95qsLr6j9+abAzyJIeC?=
 =?us-ascii?Q?Bsfm3++iqf5GE+1KyuaR+JriuSGNF92mDKbXwZyQV9QRvG7E4oQbJFgOu184?=
 =?us-ascii?Q?kZRVGWaOmHAzYn8CTz1MpFFAnMvmEIcYimIrFwM9MSYP5gZJMUfmz157EDVR?=
 =?us-ascii?Q?ndtrHSiy+8c8H0TGuTUOmPUKvjV0llHvrswEJSVh9BOm2vo9gvYp+fL3vMVb?=
 =?us-ascii?Q?/am4BmmxEuQ2Q1yO6fMzZWmyZjuxmjEH5KM4DpTFTyiB7+OZc2sx0cfWoHZD?=
 =?us-ascii?Q?3eVSLwxmgTeclZp7G28zXBLgp2t/1xpTtSN3f/Wbj8OK5pbMc85HbXUKnxtj?=
 =?us-ascii?Q?U7izpZ2KYuVgDxWbHRUOYA9DshHm0HiRdB9n4crcQMI85oPSk13WcazHkOUK?=
 =?us-ascii?Q?3SuSTptVOejUecpR0y3nlXXJAQldl9pZKP//rmaaNMMcq00B8A0zcfXzknir?=
 =?us-ascii?Q?WHijiabTK/eIsApFqoRddPhYmqMUu1wxG1iGTZuG4B3JTn4V49IYY+3kfU8i?=
 =?us-ascii?Q?SRcIuowfnXZP+bLG4fQziN1SfE6eBv7/7zwevcH81EIUUA2Ntx04cbiUTuI/?=
 =?us-ascii?Q?dZEFD4k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:30:22.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a932e8-3f6d-4b35-edac-08dcdf1a10eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
Received-SPF: permerror client-ip=2a01:111:f403:2414::600;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
to support vcpu w/ APIC ID > 255.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
v3:
- Fixed the typos: s/xt/xtsup at error_report()

 hw/i386/amd_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 38297376e7a9..13af7211e11d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
+#include "kvm/kvm_i386.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* AMD IOMMU with x2APIC mode requires xtsup=on */
+    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+        exit(EXIT_FAILURE);
+    }
+    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+        exit(EXIT_FAILURE);
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.43.5


