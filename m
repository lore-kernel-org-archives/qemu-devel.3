Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D626D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfGV-0008Q6-46; Wed, 20 Nov 2024 02:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tDfGT-0008Pi-AP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:36:41 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com
 ([40.107.92.59] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tDfGR-0003mV-8w
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:36:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB2XLNrxP21k1dQCq2jI7JCOH47PSckEUjUBsL+nGP9BGrw6Q/WhXb1vgLOT2Jz3mk9uSl78WRUqEC/QMkElECNy8bb+7SZ/2FTfmmC8bJMhiCoZ8tqqCxFqIx5/VHW0NsHC0fiGqwVCrgqxlaSLzA038HZJmhsFIdrOEkpbQ1wFLW/5gWZejHOdvHeLnxnVuGmqzndYsZDrUTNFoD9YcHO3d1rcmpwDtbIo0aFlvhH5IPfNAom6OvhBAnE+uBf0xVwGshqMeaoW9uQTQzJR6AIWjenHjtVvINLg3gXauOx8rXnWkUdojECUBmRsisnyPvdu8P8KfPj2BmOTwPkmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFg2l/hxOrg2BvkFZnjhmT+xeZNx3kViaZfGSoC2nJM=;
 b=hvF/ZAirI95ppx12XCj0P05z2mUnhbmq72clX5wxHR4+KxastGk2hydTDUegSS+XtCsVcbUuXWG2HpdRjSbG0DG44LxMD67Syg05aDJTbzYfV18CdLx6dTxGXb/RnCpbVYVeULD0mNUh2keXdpsTxGn1Z9574GsKNR75bRtC0mrDApEmASHkyn0JrWpC264uQT9KRxdrOoTVj0uRG05WYuZaWpbyyrVyT2yC+qgDn8IdF2uG43uqXkKODTaYXbIFCHCCLuhvMvedXdAeK9P+xaz7by5UieHm0L9bNFGwjJkQMUDb5/WGRXbu/Jf3y/eZ9rrFWQIgvlWxu5C2iT0ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFg2l/hxOrg2BvkFZnjhmT+xeZNx3kViaZfGSoC2nJM=;
 b=L3szujz3OYH+vxId7xsS4AE6Hijo8bBCbxKXo2/4KHZixNhuFp6DqFj8fP2MRbB2S0eXG7w8sddl5wDgbQWtnq1O+q+bw9gbA7W852U+UCeUqarKELzCff6G8niyhGjuWuqDkXLmJ0RNdxO522V18wY8V9be5nrBf1CdbOuePwU=
Received: from BL1PR13CA0149.namprd13.prod.outlook.com (2603:10b6:208:2bb::34)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 07:31:32 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::9a) by BL1PR13CA0149.outlook.office365.com
 (2603:10b6:208:2bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Wed, 20 Nov 2024 07:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 07:31:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 01:31:27 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <Ruihui.Dian@amd.com>,
 <bsd@redhat.com>, <berrange@redhat.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH] hw/i386/amd_iommu: Allow migration
Date: Wed, 20 Nov 2024 07:31:14 +0000
Message-ID: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: e959cbbe-ee5e-4bde-a813-08dd09355aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GwGi4BVQLfGwhbM7hRktyfyzcicPk6jmquSjI0NE/9Hq5xmgyQlSx8W4Hhxc?=
 =?us-ascii?Q?LMMPKaXWmrDrjhqVQ8+jBU/0D9Iybn6INGIpryh1bYRYj2qk1fhGTI5rSBIK?=
 =?us-ascii?Q?8GCYk4lJFmKRKI900pVoL/EzTrTCY02L/jqPtLSfTVyNuEe2aUbcutPsgUjA?=
 =?us-ascii?Q?yQkrFUaLeYjHaNS/CWXiQxJYBmOnM9vdjVNgrLQhTcdaqmKJ9uGvbV1l1pam?=
 =?us-ascii?Q?L3bKJ7gJ6SKdr6GdLpcHgIpM2IkHSZRjPkhmXQQUKKXhxgYjtvPfQdeysA6J?=
 =?us-ascii?Q?2o3LWTJEmaHMOdO2MgfrZ53pGHNqxJkosRmcfkr3WSM94JGSZsADgq/g6mx8?=
 =?us-ascii?Q?EsnzYzRM41V8vaKeeeQE+MDowlhHAgWXHVRpnAtnyV01lsUYCgnAW1F+HfMT?=
 =?us-ascii?Q?jCQCSDnnVa2YuEHXCWw5FpZLBfGpCgmtVLPQFSZ0vBMsW2ZsS7mDxE8t0cx0?=
 =?us-ascii?Q?+g1Dqi1DgjjAvU5l6tTH3VEQ+HQ+/JHEamgIauBwqwYbVRPc05qHiUvKZ671?=
 =?us-ascii?Q?Fn9O2RnBD88jwG36fDuujwtu+MT2dYQe6w8h7NKs58rpJaHx3pS4FDN/ohAV?=
 =?us-ascii?Q?Bc/Pyt54XBCgFAAS21j7cUbuzTdMlShun+5gf9TRBziz4gWh7UcmXZiKmU7a?=
 =?us-ascii?Q?7dtdocg+9AE8icCghsvYycL70UEeFc4qqpfzUeca6WULcTodeNJXuS67fktP?=
 =?us-ascii?Q?8yNrDwZWCO4M4cPlxWZGmwGzXP9jJAaeooMOZHlhFuzoUQh/or1InbT/bKsd?=
 =?us-ascii?Q?O101CmcUP9N2eyjAy3br1AmzWFhl7kWj6eretc9JAYPsV6qovHJsO7tolLFM?=
 =?us-ascii?Q?nZxvl1msrIQcBJnUvb8E+hH7xRcIXPvsqe+tC9M7uYoGdKJY/bjFNyRdIZvN?=
 =?us-ascii?Q?+xQe49d+G20lqYpqxwODGmkLIFrmXqN6zKwhZlNoApqV0CEj+hWoh5APUBYR?=
 =?us-ascii?Q?PQFUcdXxogEt9r4mI2Ur54skINJgQB5UC8D88JI4Q6Ji1pvS9s4yzX1dTHQ6?=
 =?us-ascii?Q?9LQLs2IkBfTKuRUlXrtDXjOzFfKvAboK8i9llkkSi25xOIxP2U3zEmKZPx5m?=
 =?us-ascii?Q?zoOkbn6GLHcGNigCoYPip0FsHTYE3KaB38Xo07GUMIMq1Vv/0QxbZgq524nO?=
 =?us-ascii?Q?ULEOx59/2hsNLkgkVLgGs7fU32kyPsugbbFf/xVHU7KW58hJqLGQpAs7WJGU?=
 =?us-ascii?Q?5BkACDVJQZdgq5PGJSjeTYTqpTRid1yUHuVOI7IiGhcbfcIRxjQ7q4pzgaLo?=
 =?us-ascii?Q?dRTnV5/aO/TpVxmAUPQ0IB7sAYDGBOrd4ZVcxyj/v9GM8QmSFdRq4WBY2DIA?=
 =?us-ascii?Q?VEyKVjBKsjN+yk3HHStsvnnURmA+2VXxbuwBZXK/SnVsIdlbtXrTq/uxC/mx?=
 =?us-ascii?Q?LpVy1Z+k5/5iC9Ho7M7P/UBg3xxEK3DcAhkBJLx9GSwvuDL25Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 07:31:31.4394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e959cbbe-ee5e-4bde-a813-08dd09355aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
Received-SPF: permerror client-ip=40.107.92.59;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e1..3d2bb9d81e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
     .name = "amd-iommu",
-    .unmigratable = 1
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
+      /* MMIO registers */
+      VMSTATE_UINT8_ARRAY(mmior, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_END_OF_LIST()
+    }
 };
 
 static void amdvi_sysbus_instance_init(Object *klass)
-- 
2.34.1


