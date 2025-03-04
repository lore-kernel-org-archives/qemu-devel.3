Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2DFC282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpT6f-0005P2-5A; Tue, 04 Mar 2025 09:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpT6b-0005OQ-FI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:18:45 -0500
Received: from mail-mw2nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f403:200a::614]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpT6U-0003Qx-NO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo4Ub+DUZ3OCEk6KvjrZV99s4irruz/UUud3aqsFnTtIxuZBnJ+9NayyGE9BOuA8HhBWLTpXYxPOxOJnrSGRG3yzXas3Qq1qNw1Uk+IIBxXDr+BVX2QxXLZXLE5wLaFkqL3V2gPhavpmowTVykYQjmB3wvfdavwdg8Ll7U0/KmqnL7BIv17dX31/nj6FYYlwv5Ehlym6cRgUJEc98rq7UClMC4zRENV6PN0KJX+rzM2PDimtowQZcnDrgjsJ2sNtMeIjR5WocrYkr0DV70rwXk3ZRJua91Kl5dKXUdgzdlOJJA/BuIYvN240vSm7yHyThFvE5tFYUV853ySj2+jquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJyrjFXf/jYQHtvwfs6mGuwJpy5+1cY0q83/V7N7FKA=;
 b=JQZulcRj5CI8pL0ay0cTbiLrFu6MsI9T5NuBcwkyrnVFfw0gV3AcpDRTXYiRcs7xdjWFXzD2zgI7u0Sa3NYc1pBzhHsdCqoa/Tc1tKFT+lwyDRjYwKqg2TmyaQDpbQqkXRfnZSLXydzgJzGaH8qvShGTDG9Rf9e4gsjjRt2aA6KJMWhUcxmHipbSZ2gqm76XTeCHcFGOidDaC077JFW06w6207tyRngmf5psRVdANW9ns+zFE83cMQXEOHUlN8iXl1YBdoupw6lu1GM0ikEcqwrw+NSvMUPFzmgJmcEm02SYBSzNqODY23jt8aqECe+aP7YCLiQaEJyLgMZEdEtw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJyrjFXf/jYQHtvwfs6mGuwJpy5+1cY0q83/V7N7FKA=;
 b=4MXFZ5Fo/qXQPViHz0Sc1bUWNW2L6A8ByTcpYAw92Y3kS/jfqv3wOPKvJfJn52PFuWCeSdYkAfSaV8uOv7wx+sqNArecpGLQFDas+VoLfv9dKge0myRsdOUzL8dXweLm/ysdbbNJRp92A4lzIeaLvMa/pEW6A4qHtJt7GgNzzyc=
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Tue, 4 Mar
 2025 14:18:31 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b4) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 14:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:18:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 08:18:27 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 2/2] hw/i386/amd_iommu: Allow migration when explicitly
 create the AMDVI-PCI device
Date: Tue, 4 Mar 2025 14:17:16 +0000
Message-ID: <20250304141716.638880-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
References: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 338584e5-fcd2-4596-a14f-08dd5b27711d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ns3pKg2wCywuTp1aH0yRq/oVvls9BnrF9dkw+4JH5Q6hnwjvD92jd9AjuZhd?=
 =?us-ascii?Q?3b/4Ch9qRkClVIYRg0f7OZIYwCZlBhgM3cq3ewRRfgl7D4muyG0xBT3Peo2Q?=
 =?us-ascii?Q?6aTuMibyXyyJb0PmXGDN5pKp/8WYa8/U23FlOBFjJRcUlQXuM3cM3WHw15c3?=
 =?us-ascii?Q?qEfuIgTEJfSdRyyLS5LKd/fYl4bKM3LB1XzeIetQ/wSD72lNoiRbE6UjOqZb?=
 =?us-ascii?Q?I4y02jsEyOP5koOB3Gwr7+KNVt63MB87l2G4Hnn9UabXNrq+lu5lJErg4XKJ?=
 =?us-ascii?Q?meQtCyQc0hOe0I5KE9FOb7vIRSPkB81VYAfF5p+Nch4fvuAUkzZkdNHGvvtu?=
 =?us-ascii?Q?249R0fyEvN1Vo8/PeYhe4Itocuz5MCPxMprvhd0aamyiWADk3383s84bwzX6?=
 =?us-ascii?Q?Xsv819n4x5XWmcNzqaMk79hlp0EXkP2pHfSQdacBjttRryBWgCs7/UeH61sN?=
 =?us-ascii?Q?owK/mgorzwAV2gDMfB0Yn2pjr+W+qsWl5b9KxcKuBniovtW8zJbyyUgkaMQ9?=
 =?us-ascii?Q?W9QMRTpBl6Ay48tqMucpDnYXBhtLTksaQJY3ZNJifN/cBI105IV6MV60XEha?=
 =?us-ascii?Q?2Tiz7bU9OWk9++byrBqb1Z9yyA1tNolopgurm4Z6E/wsePs2iLI3lSCsTiDg?=
 =?us-ascii?Q?KQpLGQtvs8LM3gj1WNmcNW1qKxVPpMcB9Cp+vuR3cTgb8PGVrqXyAOyMeOk2?=
 =?us-ascii?Q?U60a6fvBRPizyoMoSRA4xssYXNnAUOBi6eBRAyEH4bme94GnO8h8yvuUOpTd?=
 =?us-ascii?Q?EZmlJT4aqSY183kYvr2CtDnOyS6V0YuU04vwuub99/GUj9gqAw0Fx+HC9JzQ?=
 =?us-ascii?Q?IsACq2i97hkdCx0w5ko1TU+AeAdJKhNajjuLMK7XN0EXHxlD9wzFthnNgbpH?=
 =?us-ascii?Q?LZmsLp72lAtDl2/qPcSAZbXUSw/hXq4jNpGaCHYDmGA5SMVOm3fEowKPXYhM?=
 =?us-ascii?Q?xO0nYKwQalpxPqEa2P7NigRaQbb/l8v5zpojsWkyVZX7xKW4VlfguZBSFlgq?=
 =?us-ascii?Q?46GZQrfEx2TfFplfXTKDuKRDmspehJ+uEBbdjTvSVCDeVfKIEMiAH39Hgvvg?=
 =?us-ascii?Q?szpObE3IHbiv5v8mpf5uNLSAsAVCf3d+R4hxREUDAChGqxZIJw5PsPLsAwzJ?=
 =?us-ascii?Q?UudNWkAGqKAVxxugIn7nvuM+goRvRLdsISHYXhwP7vvNN/VDANQdlPrE0Mkl?=
 =?us-ascii?Q?c1zG6BhRCrIxpilmTQV8D/gVBvr//qb22Q3TbjumN3hSzhYL22NJeYCYMm3C?=
 =?us-ascii?Q?r8tsdBILxr0TVC1EqBlrGlsrndOQz5BFG7Y9H5Wa/FPVKanHbzQ9Q1IX/YFs?=
 =?us-ascii?Q?RrquUsMGF5l6iS1+lHrmZNQDWa1kUJogvW6nrLYgZzHij2lai7qBJXgZPdt2?=
 =?us-ascii?Q?dt1/ixBMSZL5AQ3aReGokHNK20LR9wS05GkIi/VwMCSz1aLEEv6g08UNb+IJ?=
 =?us-ascii?Q?EX6oJDsPOsp/978BCDGqfs/KjrcyUsEhAZW+Kwp183e8cm8lH5xC+0fbGC1b?=
 =?us-ascii?Q?Y2x7ZZSSem695ts=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:18:31.5472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338584e5-fcd2-4596-a14f-08dd5b27711d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
Received-SPF: permerror client-ip=2a01:111:f403:200a::614;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Add migration support for AMD IOMMU model by saving necessary AMDVIState
parameters for MMIO registers, device table, command buffer, and event
buffers.

Also change devtab_len type from size_t to uint64_t to avoid 32-bit build
issue.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 59 ++++++++++++++++++++++++++++++++++++++++-----
 hw/i386/amd_iommu.h |  2 +-
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4c8b2dbdf1..4d8564249c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1611,8 +1611,60 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_init(s);
 }
 
+static const VMStateDescription vmstate_amdvi_sysbus = {
+    .name = "amd-iommu",
+    .unmigratable = 1
+};
+
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
@@ -1634,6 +1686,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
 
         s->pci = AMD_IOMMU_PCI(pdev);
+        dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
@@ -1684,12 +1737,6 @@ static const Property amdvi_properties[] = {
     DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
 };
 
-static const VMStateDescription vmstate_amdvi_sysbus = {
-    .name = "amd-iommu",
-    .unmigratable = 1
-};
-
-
 static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index ece71ff0b6..741dd9a910 100644
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


