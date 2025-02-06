Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B0C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 05:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfuNl-0002YV-SY; Thu, 06 Feb 2025 00:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfuNe-0002Xt-IN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:24:52 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com
 ([40.107.223.44] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfuNa-0004tf-Mj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:24:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyAAqDBMS8BgvcFpPO6C/Y3+snlv4IydcaHw5ZnnMGcVu7s5KdlyM9V7WbzUM+Pt1O/monS8JJb7d1OL0pMqZdKeT7Y57UL8glH3xHC8CJO/ePBAAm9raS4U9bhXrP5xff6eBIiuhmGlgXRWHYVQMS1mXG8PZdTTstbqx/cgFab3b2DIziNJp8OLw5wAqyRAbCrarjKORiyZvfs59hgn7hHsz/5fGTcgpMaoew79nZUOmQgVtCtLuxYyDZdDQaRUBOpo1HrBs2G5Gfvv0Q1SvOsEumZFMqZ23wqoqgwSv0V7iOvcTeYUTJ0R12wq3uWZmY67leCyHPlUOFZszKslcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08FxTHvSQlUcHs5WuPSyPSaC+krpMLjB6dqZ/wni0Hg=;
 b=Y/xUHXcc7qitCP4L3ZKTJcknaP4J3tDPbvpzn+z4edQmSlbp9f24r2cPMUqShtC1jizdpGgZ6O6yV01/fcrgDPkz/nSTNyDrNk8Y6/yeT6yL8S0JVmDK4RiE0oGyFmEqq40j9ndWUppip1QGnkAykRKqnxSAqJXGARdNgvB0xBGMbgozp9z7jtJBJedpvBTeWaSgZ55hy5aFkVV4PZeOfIapkhTluzlE8g8CIMxmeqD9W3uxDu/ISSqO1AAMiVlgJ0P5/LjSfKwypx27H5gs4LpXZFOo2WzyjU3wqe8M9RgalTcvPW4fK2zHGYbvPEPY9d6kHXLmjWbu7doyNGyLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08FxTHvSQlUcHs5WuPSyPSaC+krpMLjB6dqZ/wni0Hg=;
 b=GLdgBwLdcOoi/b/0v8aXEO22jU+JnzqQ4qmm2psQm7TivuRuDSQkRMxV6CAXsSzH+uGU1VD4PmbTzOySIliEkpCWgfpgoV15+On4wcJqu3sZ3IaOb47wNKMDS3IckEBGeKXfAOzi8fqf32PhYGySKZ93NNMUKkKkahtyPq4Z0v0=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 05:19:37 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a3) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Thu,
 6 Feb 2025 05:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 05:19:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 23:19:09 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] hw/i386/amd_iommu: Allow migration
Date: Thu, 6 Feb 2025 05:18:56 +0000
Message-ID: <20250206051856.323651-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5830f8-6a1d-43cb-ddfb-08dd466dd8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+1/gvLbsx+p4YxE4KHt5x8/5LcdTzHRwBxz2PeQdkF4MopK0kmbeV6c03tt3?=
 =?us-ascii?Q?Cg5gLCLS31/zak04Eeb/n+p1QecxTwzVTLudQ3AjhVtZbWpbHCwAv0Ty6yN1?=
 =?us-ascii?Q?RKY2qenH4RHLzvg1kHJXP92c3zIG47c1zEbeNvzi6JcMUKP9CWbroH+886na?=
 =?us-ascii?Q?ORYYUo39c/aahou0ZndsUjRrc/gI/m1sP0REW3KVkOdbWPkNzaq2nHchn6Qn?=
 =?us-ascii?Q?7GTPtV/VqLLbLTr4g6+ZsYWwMgBVcGO3u4dfAuURpexaAVwA5dXR7v9K7VGh?=
 =?us-ascii?Q?JxY6aU9yRLjh2bhXCy35rs4CnDnnpxSq1oIfxHFBmlBPyjM9TOTAIkJz+5jv?=
 =?us-ascii?Q?b4j5HYAdBLugXDZq0n8ouZrUU+1W3auexsnJ7FetXeoHTRkH1v1Cu116zNED?=
 =?us-ascii?Q?ptfUqk8IblkoHj79llbkyFUe2PYE/7ZkBYyQXm912qGQAR0YE7jEfdDhYhF1?=
 =?us-ascii?Q?uB0fgyn6JD5I6P8mCx+F/1mk7c1yN9RJS/Jy0csKNqfKALyaHg5JeJ2P79oM?=
 =?us-ascii?Q?/TczCjVsm73aM0FkjrHkH6Dc05mLipI0BxBBuLV9EJnzzTbe3DfjLmFFLeBF?=
 =?us-ascii?Q?NC45X2w+FdCKenTDfjDE0N9HbXiNtGGMO9jj1Wcx3a18n1KYiEOhq/RkXi8x?=
 =?us-ascii?Q?XE+hyT0LHw78vHJ/NjlFRVJT0t1x6J1J9LdvzPMQgxCwGJ1+WH00LgAlmYue?=
 =?us-ascii?Q?SmD0hIzqGe7chmEp0PTKEZidabQ40mLW/h9NwVAMyLvXQELQnwh1eF0Oofwn?=
 =?us-ascii?Q?UyPfJhGAXHa7DhBvMDL7AynDO/ce5SmLEEkOsbvLqJpRr9DFsRwr1BQAZnHc?=
 =?us-ascii?Q?GFysEq25DQ8E63k4cCX23VtHm1WOZWczc1Tm9AoG0WyE3zZUPt+rP1iLt1iv?=
 =?us-ascii?Q?VuxjYToZd2E+yVjQL35bvsoFyckmp7hr25G/qY/Wsq3xKu+3Lr12A+NU0AA1?=
 =?us-ascii?Q?vUfN/oonKCvSd+Pbn3gp01bS+zf3kfMssafT0krm/7vLs/0Zdj3i62FyFL9x?=
 =?us-ascii?Q?kphpzMyNsiOkjehRkuHc3rpYwuh3h62ewaNydKEZxsPlu/hhdHlgTkwZv1lc?=
 =?us-ascii?Q?mgGG/vtC+FA9WmIcTf2HUk5BS5oJhZ/ejKyJAsGQs3g0uYR8ukUki+0lE35n?=
 =?us-ascii?Q?g5yIPrIudG23LmB4WWUL8bdPl++0rDl/vWrxm4D0S5MBOozWAKlgJU6UsUkq?=
 =?us-ascii?Q?6WQ7LZTV9M2Rze+zR58l9I5wzV5WyWyn5mR0YlG1xMSUIKDZ0ZUaUJ9fCf7j?=
 =?us-ascii?Q?9UNF/LtSTrlVg2jiA0ze31DQG6hvdugETJrvsTZY6lxIkiX1aH54Wd1BQIgC?=
 =?us-ascii?Q?YXKzukephGsLb3fwhhJaaHeOaU8kiqAOb//vxHCKnv7eRM7igM3kq6o4FWF+?=
 =?us-ascii?Q?1zmHUDAhm8R91HpEBYSUs/CBdzKCFZ0IWJzaCUSIecFUsRbJdTUWDkL33buu?=
 =?us-ascii?Q?MGfwMH0aSQ4VXIHShD8DshpDc8Hi+kfD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 05:19:36.0025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5830f8-6a1d-43cb-ddfb-08dd466dd8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
Received-SPF: permerror client-ip=40.107.223.44;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Changes from v1:
(https://lore.kernel.org/all/9ecffa7a-f4c6-45a5-a066-84826ccb55dd@amd.com/T/)
* Include ppr_log, pprlog_len, pprlog_head, pprlog_tail per Joao.

 hw/i386/amd_iommu.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e1..a1940a0ab3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1673,7 +1673,48 @@ static Property amdvi_properties[] = {
 
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
 };
 
 static void amdvi_sysbus_instance_init(Object *klass)
-- 
2.34.1


