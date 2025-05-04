Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71646C3ABB6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 17:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBclg-0006vC-OZ; Sun, 04 May 2025 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBcle-0006un-8f
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:04:42 -0400
Received: from mail-co1nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2416::630]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBclb-0005JZ-V7
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYEROnmIgKY6CxeTm3258gPFELCxW8YpRttI4GVAstg7RyEfdrZKHugrbzBGm9/Czoa2Rhb1AS59owjbk1NoXbg5bFADytysx5xiBVPhnatC5YPvXUbNOJO24ExiSTKPHk9tfhcExseZcQU4GLIOE9Z1OrWa/nd8xQp8KoQEctavGyjqTCBE9cwmtSbfsSVZo6ndDjBKuVmc8QNtFvLaDq+btrqeIco6wCU74SAYQzt3UtHXYpehxNWBNUMr+YZ4IdEnGT0Avb4OYXQd9AgEPP6AWpLe0HTIxaC5AYocM7o43yM6fKTyw0E+miKtSJ2wfhXBVzs6lyBNmRoAYrYb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqU/Qv+WSNXmCO13v3CFdl+DaNQMspts1AKGD/ijmBA=;
 b=KDynHfBfbegIAzmYVv95UboR/6pwK548i8TIpaRqU4yGSA8ALwCTNUyBb7TuIXU60zhdBmlX2r1nbw3tiFd2oyCbiKxMv84yI/33eIRwJQCRBnsoPH63jS/G2+h69h+oxAHlruJvLjUByRcgmwZjNzBi6RZ4juYDrfaMfNWbKkuhSsb8CvyqoIgVYas9lbQh+mMCnK6orISJ34yZvbrbHCyXTbsS9BptIVe0ilQbIbg9CxfK3Z3GQn3KykWBJqqEtawflvb9kZ7GYWJNjZvstyZgNV/e8KRF6cSpvrYrFCwvfec9ipFtz+kEZplbCj7A+hWFBILTemxErTK+jBdMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqU/Qv+WSNXmCO13v3CFdl+DaNQMspts1AKGD/ijmBA=;
 b=f0gDQTEZ6vHg3vKE/W2f/x7eyf01NNalZ4uvd6Qx8anuqSz8/Tfd2yaIK0TStXb0lyVYYbmTB3gXgcDMh5Rvc2eb4W9Mvh16f8rPJqpopJt7vB4CHzYCPcOTYk+9g2n+MTV7vNWHCKQv6zeqeBC1Rp96Fn3dObJl1O914fLhGqU=
Received: from CH2PR14CA0042.namprd14.prod.outlook.com (2603:10b6:610:56::22)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 4 May
 2025 17:04:32 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::5e) by CH2PR14CA0042.outlook.office365.com
 (2603:10b6:610:56::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Sun,
 4 May 2025 17:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Sun, 4 May 2025 17:04:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 May
 2025 12:04:28 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 2/2] hw/i386/amd_iommu: Allow migration when explicitly
 create the AMDVI-PCI device
Date: Sun, 4 May 2025 17:04:05 +0000
Message-ID: <20250504170405.12623-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504170405.12623-1-suravee.suthikulpanit@amd.com>
References: <20250504170405.12623-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: ff575100-ceef-49ee-a587-08dd8b2dbd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4SAgFlJU9wDw+hBdaieDxVM3DXsgXOFZ5203S8o2rzLiKJ1yBspBUqnxmxwm?=
 =?us-ascii?Q?GHNvsjFYtIMfESJrRHk1nsr4wOaWoZjHn4Pf6cMAGL7OIpIPpEy0pHspt4tF?=
 =?us-ascii?Q?KX5U5SiH9HJwPjtKkbvDFtlaNECk1O8yrdNgKAgGXD3DyfSKEJbCAGA1j5AR?=
 =?us-ascii?Q?wpy65TIdL8vbrQXsuxd9qM5ZeWtocZAia9aAEnsg9AKUxW9oXT3B1QvwhHl8?=
 =?us-ascii?Q?oHrigDitnWEmA6PqyM7mVGY+uqXxKA3DSxCFlHfUo53izbatgdeNPYxEm4yj?=
 =?us-ascii?Q?asQlcjdiqpodoCrBEdfkEYcd112X7W+B3kv9s3EcHxDqjlfReZjnqgBmH6nx?=
 =?us-ascii?Q?M5kZIx1lWkvptLttDzfNMpu3BTLCAlRtijhkM+Kg0cGAbOpSMW2zDOrytFAW?=
 =?us-ascii?Q?Yq3Eq6Eq2MyTzaEX9gOfU7oGtti3xhsS8EVqmqvKmWFprgpz9jJgXbgWuJ3v?=
 =?us-ascii?Q?EWndHFH5Q1Z/n+ovn/CfYd6/zPJCcrKgpsWQz3XqOxninaG+LR8HuI4//cfE?=
 =?us-ascii?Q?TKcEn8j0HtuQBtCVdq8EJBHgY2QUCBcnZPYnshWbVU1omKTxi8aJ1gxRaW+B?=
 =?us-ascii?Q?7nrYApbrTBZttwAgLJDh3CnNK0BA9Peb1hpFNO26n1SU7c8JCOYD/+uEW70X?=
 =?us-ascii?Q?FceqkGoQxPP6PadD4mVYSfdUFLUFC/F61chKQSxO3OkqNSPVJg9JZzYtZ5uZ?=
 =?us-ascii?Q?J4nuoiScBo29pNggS5xeEle7HgQCweEN4erpMgVjsRe4D0N+9t7ViJNBCvYZ?=
 =?us-ascii?Q?MB6ye+BwxR9kQVs3pUOi9xcV3U203HbpJlxE61CA2RibGOdGKqbSh9y9w7hf?=
 =?us-ascii?Q?dYvh0X96PAGNOVViZPwuuxwRiBsZ6+qJxIF7vUtkiodsP07RIO+yiAJa5yHf?=
 =?us-ascii?Q?ca2plqND8r726NOxE/9NmCvKZML8tZkRNxNefx8ISY155u3YE10vQ0ou0T2y?=
 =?us-ascii?Q?R2NIMEr7NuC67HibpYGb36nK4XWHJ3Wy0FrHZ8k1IRe0/JOTMej6vyJrEA3z?=
 =?us-ascii?Q?nfzJFIt61yVIsURQtR3LmoiZ9OEOR/EnRjzeunilqw1whxNp2zo+XuRaW81o?=
 =?us-ascii?Q?I/yebs0XR9OQLMOJVklp3XxJxiN4jwMXEunTjZ3wKHSpiuRMcKxpvtyS1NNW?=
 =?us-ascii?Q?fOWyDwSAwb9JlBooQzUX6VPBCzEbHZUR+kPcctnJ7ku8+PyV505S6SaGiapp?=
 =?us-ascii?Q?kRcqdvkTux9hiyT/xpb5Yc4kIhzRfl1OKJQUFyHWPWwlwFN5T7JS3oUo2VE5?=
 =?us-ascii?Q?WBEfJMbJ21WImsKnaeKJ6Q62XDEWmxaUV3uI/qizVLbAhnXVc2ISTiHP/6LS?=
 =?us-ascii?Q?TwuEDa+4P1GxNIUNbr4FT0R7gITn+k5zmUQhzpdZPbTAXrj0yawmkgWCfMu3?=
 =?us-ascii?Q?7efczkBhLB+YKsLlAzbX5qeKFUSNxispV9pz1SseYxMqpzp3la48XKpf8Jg3?=
 =?us-ascii?Q?a+WQGcm2mmdDnLDjpj1ohUVwkmQKV1+s8a+xtncSeWJt1QUkUvNsxoHMxwBy?=
 =?us-ascii?Q?2d9+/D2scS5x955osj+OtRuy0XwPdS3mgph3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 17:04:32.4667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff575100-ceef-49ee-a587-08dd8b2dbd7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
Received-SPF: permerror client-ip=2a01:111:f403:2416::630;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
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

Add migration support for AMD IOMMU model by saving necessary AMDVIState
parameters for MMIO registers, device table, command buffer, and event
buffers.

Also change devtab_len type from size_t to uint64_t to avoid 32-bit build
issue.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  2 +-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f5466fdc98..0775c8f3bb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1611,8 +1611,55 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_init(s);
 }
 
+static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
+    .name = "amd-iommu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .fields = (VMStateField[]) {
+      /* Updated in  amdvi_handle_control_write() */
+      VMSTATE_BOOL(enabled, AMDVIState),
+      VMSTATE_BOOL(ga_enabled, AMDVIState),
+      VMSTATE_BOOL(ats_enabled, AMDVIState),
+      VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
+      VMSTATE_BOOL(completion_wait_intr, AMDVIState),
+      VMSTATE_BOOL(evtlog_enabled, AMDVIState),
+      VMSTATE_BOOL(evtlog_intr, AMDVIState),
+      /* Updated in amdvi_handle_devtab_write() */
+      VMSTATE_UINT64(devtab, AMDVIState),
+      VMSTATE_UINT64(devtab_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdbase_write() */
+      VMSTATE_UINT64(cmdbuf, AMDVIState),
+      VMSTATE_UINT64(cmdbuf_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdhead_write() */
+      VMSTATE_UINT32(cmdbuf_head, AMDVIState),
+      /* Updated in amdvi_handle_cmdtail_write() */
+      VMSTATE_UINT32(cmdbuf_tail, AMDVIState),
+      /* Updated in amdvi_handle_evtbase_write() */
+      VMSTATE_UINT64(evtlog, AMDVIState),
+      VMSTATE_UINT32(evtlog_len, AMDVIState),
+      /* Updated in amdvi_handle_evthead_write() */
+      VMSTATE_UINT32(evtlog_head, AMDVIState),
+      /* Updated in amdvi_handle_evttail_write() */
+      VMSTATE_UINT32(evtlog_tail, AMDVIState),
+      /* Updated in amdvi_handle_pprbase_write() */
+      VMSTATE_UINT64(ppr_log, AMDVIState),
+      VMSTATE_UINT32(pprlog_len, AMDVIState),
+      /* Updated in amdvi_handle_pprhead_write() */
+      VMSTATE_UINT32(pprlog_head, AMDVIState),
+      /* Updated in amdvi_handle_tailhead_write() */
+      VMSTATE_UINT32(pprlog_tail, AMDVIState),
+      /* MMIO registers */
+      VMSTATE_UINT8_ARRAY(mmior, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_END_OF_LIST()
+    }
+};
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
@@ -1634,6 +1681,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
 
         s->pci = AMD_IOMMU_PCI(pdev);
+        dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 7a28181d9c..5672bdef89 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -329,7 +329,7 @@ struct AMDVIState {
     bool excl_enabled;
 
     hwaddr devtab;               /* base address device table    */
-    size_t devtab_len;           /* device table length          */
+    uint64_t devtab_len;         /* device table length          */
 
     hwaddr cmdbuf;               /* command buffer base address  */
     uint64_t cmdbuf_len;         /* command buffer length        */
-- 
2.34.1


