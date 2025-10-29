Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E406CCF9F6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE37s-0007jL-04; Wed, 29 Oct 2025 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE37h-0007iY-9G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:09:46 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE37a-0004gi-OC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:09:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4uxNXi2xsgvJ6c7WxqrbOiWsJ3Xz8LW3DOeF2K0LEBUiLseLLDayKwDuOGlySm1dYX02gPhHdgV01kUwd3XD47YM9Q1lTVrcY8cshwZXu9ThqOOXJPQ8HvvppzTf2T/IVcDMgguiK1uY52A8v4Ctrj4PNu11SRqJW9N1YtAUCUFyfWOJc6Uu7hxJTmE91STfiJ/cqPMfmWl7DBtInH6KRJDyIyOBf4b8LRQHP0m5flZAt9RuEvLkivmmZSA2AnWd4xTol5bh8NE9Yhf7Ak0tney6p+JLxJawUX7GT3s/ozWF4gjhi8khsM+Y5HUgTcAgiI+4DXD6/q31Qh2Gst1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPb247kXyTQssEsEAwV+kA348DcMDvVmkdA9UCQknc8=;
 b=Yc7Zq0NONi0mTLLRfIu8oMD8aziO9sqOKLSaovWQza6spF1ZWpEiPVnx8KGfu9NCU1z4qvjrbq9lamQndYBBaFy9Fpt2FMJ5goPdEbuJtzXW3CuYTtVxsBsEJzN1sQVFButwvnR0zcn1d4e2+xyc9r+J/iMGb519B8KiDPvTzbq0oALhxIwLvlnOj6ffhGlYZ5Mlyeyv/hwXW+pB0oH97Y+rGWnB02lBqkxU2JsKCnyQgy++sEGsfOLiRPkOTRVvzgpPyWbL1MGuaVINOohlNewUWYE05SRBQs5l8JgaoC6p5u1cu22wX7ZvDItWdCVrNxUQgKzgNA6a7lpIMcU2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPb247kXyTQssEsEAwV+kA348DcMDvVmkdA9UCQknc8=;
 b=uhAMsJgzU2PuMTl+SaT+CUkVRrwnE2lwDRQvL+KmqGc1BWuG+g5HdIwfuh6BSGyKGGRMPv3giAt0u875NKQrZruNG9r0BSFwLhHdSDom26SMEd/m2vykfm5ylvVj4BamuVwMHs/rAsKmFoNrQ4jjokGVnFnmzxPrUovaHHu0j54=
Received: from BL1PR13CA0380.namprd13.prod.outlook.com (2603:10b6:208:2c0::25)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:09:25 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::bb) by BL1PR13CA0380.outlook.office365.com
 (2603:10b6:208:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 10:09:24 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:09:20 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 5/5] amd_iommu: Add support for upto 2048 interrupts per
 IRT
Date: Wed, 29 Oct 2025 15:39:10 +0530
Message-ID: <20251029100910.4879-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029100655.4859-1-sarunkod@amd.com>
References: <20251029100655.4859-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: af808ca8-4409-4c0c-61d4-08de16d33cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwWtHND+tL3/FlJaIA7ldCQ/cg6f30YCZAjfwPmpi/Pczm2Vj2GogtN6nybu?=
 =?us-ascii?Q?CTmVyBVBZ7b0rqM4gEBwGvmmgepwy4gBqpH5Zv+wOTuMoP9MpywbFdIx1Tdo?=
 =?us-ascii?Q?UkqixR9nR9d01rep4UBATShQqQKyEGyRsguVJ82sRkw1pk1TeMGA7ExQhfLC?=
 =?us-ascii?Q?4zyHkWiLvUGinO2VtRZW1D08/y8Ylxvwxoi3BbuVTbetiVoLpt86pQkJ+rr4?=
 =?us-ascii?Q?zdJOb3vEii3mgWUlxo45rAGqdwZZNzpobxwTV8K/oUOuodFlBcq0svw+9DLa?=
 =?us-ascii?Q?mBsdDWZVQF+6stScoQa2cK3ZiESx/7tyorie4zGmrIoRncgKQKcJ/22V+h59?=
 =?us-ascii?Q?eP8YowpIfRFyfVMSCbstQ0kvg0o398NUlV7WT1PnP8kTbtSPX2C7/DnWQ2nI?=
 =?us-ascii?Q?tTS+2Sdq3mDZdgzdhiWrUrMZPCNHiAcRZH1vuQTM6cHHHWt3GN6f2aOKhO4k?=
 =?us-ascii?Q?9BCvzkFG5TxUjgu3+9JZ+X7hGgXXOIg9Rh6fxKbSxW6lGdbqKk6h2lDKJrG5?=
 =?us-ascii?Q?Ljh38qH/aW7RQRbUMexyP2U0hxs/UF29z74tTIa32GHVyieG9fmTKz5xhVhA?=
 =?us-ascii?Q?6yBjYZaJXxs7nZLHopkAOrq9c2zIdTp9fj/bWRph0Y82ANA8TY7VlHv++erb?=
 =?us-ascii?Q?PRX/PelUYJvckJKGUlj8X0nvQX+xAjAGDwQDKdpjctvg5skf8Spo2BuSLnbh?=
 =?us-ascii?Q?6+8XbWMo64iqHil3TBkOGAgGxGPL1hwIjDHcUQYuSqm+sqCVuIcE5m1+AXIG?=
 =?us-ascii?Q?OhcFuMidANwavFyWWX8zOTS9MS1hRXnx2OFGEDxafvM422wCJdpgi9Z++nN+?=
 =?us-ascii?Q?v1lS+HLLjecnf8JB8ewMwBbSMnFE3E0c3yNPSnzIdkmRZgynuT+6yNzgZlF1?=
 =?us-ascii?Q?GmgMqHydkqW3RIH22RuRA4plaGDGLUyDZF4PhAstJaLhyaaababTCe+LrQIJ?=
 =?us-ascii?Q?sLbEO1RHwdYk8Nfdu6WPReVzLC6590iaS7Un+h0Ync1XGb3MmmFNb/GhpXEI?=
 =?us-ascii?Q?BnNuHFY1BzNYmYljTzcrFLrquQn2j0zotMUJblbNF3mP12qS56LNdRf1kEzU?=
 =?us-ascii?Q?8Rb29rmRzqVsUXnJrtHgt/JTXZ9gKrUhHXPNHkMyoJjjVWUwIS4tpy/sBFfD?=
 =?us-ascii?Q?/R/QBQYY+XTJSwKx/pmHuZMZrW+vdrd3kAvUa8y8NMCSQnxuhl4OuwEhQjeW?=
 =?us-ascii?Q?4KZb9TjTP7WFkrFWYNQ+mtxPMne5ZjwHtItC7Mlmax9nWiKHp/8GxfpA+IhL?=
 =?us-ascii?Q?3okyWYXlz9NpK2qGBDUv18ubUopmNWwvkFkqY0uPzgoa8UMTFjeE3G7st1do?=
 =?us-ascii?Q?UTUuVcQZK+c/hxA1O3zqJ1O4A5Ce67a69314mOUL/w6QP1kzGa+/8QI+Tupc?=
 =?us-ascii?Q?bHwt3/yUJU/Lq8Yqq3BnZWrjcvR9v60BBYWTOAejlfMuweioqWs94xKTguA0?=
 =?us-ascii?Q?axNvbwOmFSAizMQdB+UPV4gSnWs6DOXNzj7AK1cP2mdXEfg0CBHDqi/UIKOh?=
 =?us-ascii?Q?zlgu3XNl7d2BPs5kWwkQZhUD3KUKINtnDjYf0onGNqYWwSkJ6mCPqqYW+z8d?=
 =?us-ascii?Q?dwzUDKmaleVywZI+IKzl6LOLVI7H1BdzPrwN+qE3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:09:24.7421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af808ca8-4409-4c0c-61d4-08de16d33cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

AMD IOMMU supports upto 2048 MSIs for a single device function
when NUM_INT_REMAP_SUP Extended-Feature-Register-2 bit is set to one.
Software can enable this feature by writing one to NUM_INT_REMAP_MODE
in the control register. MSI address destination mode (DM) bit decides
how many MSI data bits are used by IOMMU to index into IRT. When DM = 0,
IOMMU uses bits 8:0 (max 512) for the index, otherwise (DM = 1)
IOMMU uses bits 10:0 (max 2048) for IRT index.

This feature can be enabled with flag `numint2k=on`. In case of
passhthrough devices viommu uses control register provided by vendor
capabilites to determine if host IOMMU has enabled 2048 MSIs. If host
IOMMU has not enabled it then the guest feature is disabled.

example command line
'''
-object iommufd,id=fd0 \
-device amd_iommu,dma-remap=on,numint2k=on \
-device vfio-host,host=<DEVID>,iommufd=fd0 \
'''

NOTE: In case of legacy VFIO container the guest will always fall back
to 512 MSIs.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 74 ++++++++++++++++++++++++++++++++++++++++-----
 hw/i386/amd_iommu.h | 12 ++++++++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 3221bf5a0303..4f62c4ee3671 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -116,7 +116,12 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
 
 uint64_t amdvi_extended_feature_register2(AMDVIState *s)
 {
-    return AMDVI_DEFAULT_EXT_FEATURES2;
+    uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES2;
+    if (s->num_int_sup_2k) {
+        feature |= AMDVI_FEATURE_NUM_INT_REMAP_SUP;
+    }
+
+    return feature;
 }
 
 /* configure MMIO registers at startup/reset */
@@ -1538,6 +1543,9 @@ static void amdvi_handle_control_write(AMDVIState *s)
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
 
+    s->num_int_enabled = (control >> AMDVI_MMIO_CONTROL_NUM_INT_REMAP_SHIFT) &
+                         AMDVI_MMIO_CONTROL_NUM_INT_REMAP_MASK;
+
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
         amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_CMDBUF_RUN);
@@ -2119,6 +2127,25 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
      * (page 5)
      */
     delivery_mode = (origin->data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 7;
+    /*
+     * The MSI address register bit[2] is used to get the destination
+     * mode. The dest_mode 1 is valid for fixed and arbitrated interrupts
+     * and when IOMMU supports upto 2048 interrupts.
+     */
+    dest_mode = (origin->address >> MSI_ADDR_DEST_MODE_SHIFT) & 1;
+
+    if (dest_mode &&
+        iommu->num_int_enabled == AMDVI_MMIO_CONTROL_NUM_INT_REMAP_2K) {
+
+        trace_amdvi_ir_delivery_mode("2K interrupt mode");
+        ret = __amdvi_int_remap_msi(iommu, origin, translated, dte, &irq, sid);
+        if (ret < 0) {
+            goto remap_fail;
+        }
+        /* Translate IRQ to MSI messages */
+        x86_iommu_irq_to_msi_message(&irq, translated);
+        goto out;
+    }
 
     switch (delivery_mode) {
     case AMDVI_IOAPIC_INT_TYPE_FIXED:
@@ -2159,12 +2186,6 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         goto remap_fail;
     }
 
-    /*
-     * The MSI address register bit[2] is used to get the destination
-     * mode. The dest_mode 1 is valid for fixed and arbitrated interrupts
-     * only.
-     */
-    dest_mode = (origin->address >> MSI_ADDR_DEST_MODE_SHIFT) & 1;
     if (dest_mode) {
         trace_amdvi_ir_err("invalid dest_mode");
         ret = -AMDVI_IR_ERR;
@@ -2322,6 +2343,30 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &iommu_as[devfn]->as;
 }
 
+static void amdvi_refresh_efrs_hwinfo(struct AMDVIState *s,
+                                      struct iommu_hw_info_amd *hwinfo)
+{
+    /* Check if host OS has enabled 2K interrupts */
+    bool hwinfo_ctrl_2k;
+
+    if (s->num_int_sup_2k && !hwinfo) {
+        warn_report("AMDVI: Disabling 2048 MSI for guest, "
+                    "use IOMMUFD for device passthrough to support it");
+        s->num_int_sup_2k = 0;
+    }
+
+    hwinfo_ctrl_2k = ((hwinfo->control_register
+                       >> AMDVI_MMIO_CONTROL_NUM_INT_REMAP_SHIFT)
+                      & AMDVI_MMIO_CONTROL_NUM_INT_REMAP_2K);
+
+    if (s->num_int_sup_2k && !hwinfo_ctrl_2k) {
+        warn_report("AMDVI: Disabling 2048 MSIs for guest, "
+                    "as host kernel does not support this feature");
+        s->num_int_sup_2k = 0;
+    }
+
+    amdvi_refresh_efrs(s);
+}
 
 static bool amdvi_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                    HostIOMMUDevice *hiod, Error **errp)
@@ -2354,6 +2399,20 @@ static bool amdvi_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     object_ref(hiod);
     g_hash_table_insert(s->hiod_hash, new_key, hiod);
 
+    if (hiod->caps.type == IOMMU_HW_INFO_TYPE_AMD) {
+        /*
+         * Refresh the MMIO efr registers so that changes are visible to the
+         * guest.
+         */
+        amdvi_refresh_efrs_hwinfo(s, &hiod->caps.vendor_caps.amd);
+    } else {
+        /*
+         * Pass NULL hardware registers when we have non-IOMMUFD
+         * passthrough device
+         */
+        amdvi_refresh_efrs_hwinfo(s, NULL);
+    }
+
     return true;
 }
 
@@ -2641,6 +2700,7 @@ static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
     DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
     DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
+    DEFINE_PROP_BOOL("numint2k", AMDVIState, num_int_sup_2k, false),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c8eaf229b50e..588725fe0c25 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -107,6 +107,9 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_NUM_INT_REMAP_MASK        (0x3)
+#define AMDVI_MMIO_CONTROL_NUM_INT_REMAP_SHIFT       (43)
+#define AMDVI_MMIO_CONTROL_NUM_INT_REMAP_2K          (0x1)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -160,6 +163,7 @@
 #define AMDVI_PERM_READ             (1 << 0)
 #define AMDVI_PERM_WRITE            (1 << 1)
 
+/* EFR */
 #define AMDVI_FEATURE_PREFETCH            (1ULL << 0) /* page prefetch       */
 #define AMDVI_FEATURE_PPR                 (1ULL << 1) /* PPR Support         */
 #define AMDVI_FEATURE_XT                  (1ULL << 2) /* x2APIC Support      */
@@ -169,6 +173,9 @@
 #define AMDVI_FEATURE_HE                  (1ULL << 8) /* hardware error regs */
 #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf counters       */
 
+/* EFR2 */
+#define AMDVI_FEATURE_NUM_INT_REMAP_SUP   (1ULL << 8) /* 2K int support      */
+
 /* reserved DTE bits */
 #define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | GENMASK64(63, 63))
 #define AMDVI_DTE_QUAD1_RESERVED        0
@@ -380,6 +387,8 @@ struct AMDVIState {
     bool evtlog_enabled;         /* event log enabled            */
     bool excl_enabled;
 
+    uint8_t num_int_enabled;
+
     hwaddr devtab;               /* base address device table    */
     uint64_t devtab_len;         /* device table length          */
 
@@ -433,6 +442,9 @@ struct AMDVIState {
 
     /* DMA address translation */
     bool dma_remap;
+
+    /* upto 2048 interrupt support */
+    bool num_int_sup_2k;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
-- 
2.34.1


