Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD31FC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubweg-0005zl-O1; Wed, 16 Jul 2025 03:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubweG-0005UM-57
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:34:01 -0400
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubweE-0000i2-1H
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:33:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC5qgxL8J520+iv//9vzDE6F4ptySe2+6TkjfPNhlnCKqZRpkjwpe9nHMeIpikVNjlhb/sc+qN+JQTUrNndIqpdjf14Ti+G+zrwsH7+nwyhJTWXo7xJazxA/4x9Wb/NArm1VGC56TZFkMiQGiSZpGMqsvvyv7ZxcFSISHkxb9DtN8C/3SstHlKdu33uP+QsBHAi/diu4e2NztAtTZHvahmftfKl3E+3QT0pqdC8C2cJsJsaLXTX12sqCbCfvhRG/xdnrOLdTQB+1HFiQgQqfVoIQLOC+8pJ+4nzfjakPTErSJfRlG8T/Vk8vTjzcVZUrjme4eNweSqFC1qkRaqBvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdDEiwv48SvxLbuxY9cdS7A6992pT23iHxOCDadvXCY=;
 b=pa5SzFnRRKioPECYfIPPvZtGXqU2sMKeNwuNid2vTgbc9N9CCWRw6W9OgAdbSS/5jwp45MCty4e2vi5et6Ya8dxaCsGvVpmEZ+eGMU+nyrEADEbSKIiA817Jy5D8QRCCe/THT3jAp3HKnKMIkKc9wQbnUZ6snRBirsGt3YyKlU9PHjwalnSLq5lvaURk9GYkmLzTu5EuQRiPcu0vsn+tTbYOvUMyUAyeNXxyZW9v6h4WjOshndYClBw0tO+jDFmsh2ot55ApOHatPUB4wmizYe+OT0UmVd8eJ0k3w0mmyRjyWTIk3jQbCmoOERkeWWkBBolowEOFzCvU9AgfwB+xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdDEiwv48SvxLbuxY9cdS7A6992pT23iHxOCDadvXCY=;
 b=nOANSTh06TA+dNcoF809zOAvzEIwK90G/5F9VwX3sUpOm/04zDftSRnJaCDddhb3ddYvg8Rd3SjF57V0641O/daQbimiKpie+uPPOKytKcjvSbevlTeiVwF4Fir8cnaj4Oi898rRNQSx6cFoZbp/LhFhYQtEDojHmo7bAoHQwLI=
Received: from MN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:52d::16)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 07:33:40 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::85) by MN0PR04CA0027.outlook.office365.com
 (2603:10b6:208:52d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 07:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:33:40 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:33:37 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH 5/7] hw/i386/amd_iommu: Fix event log generation
Date: Wed, 16 Jul 2025 13:01:43 +0530
Message-ID: <20250716073145.915-6-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 61332a1f-cace-4853-5e8e-08ddc43b15d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NQfgAzW9BwFqinhXKSJS0lqa/VCyCWkXU7VYvz8VO3jPd+ofYWHztu8MXLWs?=
 =?us-ascii?Q?cesG5ptafY3W3qpdvq0Abfocjx/XRUm6URGtU8NbW/dE9tJxxQdt2XTOSGRe?=
 =?us-ascii?Q?XeB0MmzdxehHcDDrljQK9uNcAn0ta4ERzxQXm5M2Tdu3BkDEOHOg5yu7eHrt?=
 =?us-ascii?Q?m5O2GmRVxMYDxjvVm6qEDtOLMn42nao8zkbYBY/CGjzCG3coMegk3AoYm32Y?=
 =?us-ascii?Q?IskL0lcp6tKJ68RtsrVS/36x3vKt6rvQ5TuvWj9drVmlerPyldGQGlP3S1hu?=
 =?us-ascii?Q?qc8SePW8k5NkIfhYyVt2YI81rtK13/ibDDpBxSikw4BKa4fcx1WD7l9aU/mB?=
 =?us-ascii?Q?ZVvRMV4mqRvg+SQu+x7GmwVxiibn+/yp24gvrxvLIJT3AfEwwDVs8rdm1BrZ?=
 =?us-ascii?Q?6irR7wBJfydDQOzHjlMGr1xydU7T9BnbPPLUwy4muV3ud+VtU8sOQ5Ridvcf?=
 =?us-ascii?Q?Tc8C3c/2CB7Ew3TICgge8EZM7Tz2BXw+Ild9Sf95NmYJFzVw+OSWvEf6gYZM?=
 =?us-ascii?Q?uIDEGq9mabOmFOC05X1TNDFG2f6xr16HgXI6DM1JsznAShwQy8pGCwJ1mOFr?=
 =?us-ascii?Q?IRTe8B8bTruNz0c6sjxI+E/hl3h7vxrKgn9SOVnkLeRNNWHZMJFVlycMDI8Z?=
 =?us-ascii?Q?S922/Dn9liXv9LPitD/NX4lr9i5DMWjupgPQMYDkD0J4EL81HSOxrmvmixTQ?=
 =?us-ascii?Q?FSGIsNY7+YQ4QZQTM5+wb6S/HrqtSMzLU0AV04OPCCem4j9YTHbWRAvgCWQ2?=
 =?us-ascii?Q?xQu5dRLkpadSCQYE/Y/I/qgb1mnOFY27QuTNSkuU8mzZhke2qhXMjyAnOy+H?=
 =?us-ascii?Q?e+p6bSfNH/DT41FCcGLJBK6NRMAT2cMAccUCebBx27a3R2VyCVWrant+tzqD?=
 =?us-ascii?Q?3qcQYN6MdsHgSlHDNOYpjwgKwZX8snwv5Kf+sEoQnEuGtgH9riEbhMAcAM58?=
 =?us-ascii?Q?r6aOMYupXiM9yS9gqT/7IusoQGBk+JVVBhHaLTxPUEj6acQ5w5wlUlxqs4bU?=
 =?us-ascii?Q?WXWwIBbwifpFkMGFHNvXzMCsUN16vQsU04uYhmlSK0fbCzyk1dGfHkd0QO0f?=
 =?us-ascii?Q?8D93ANjBnkIffyO6d+ePm5xsoUOqXF2bGiKNTV89GYWf5cMMT42XJW8/K29b?=
 =?us-ascii?Q?T0p3lJo1/UrwztovHbIbXB5ND/FAehgmloEbpVRpzMMVK4L1lZog3feIIzKN?=
 =?us-ascii?Q?3yDI7cZ4MRp2MEyqClBQ21/jcSQFrqpt6X7DEr9mBIAqvQR+gNRf5xkm07A0?=
 =?us-ascii?Q?VvCkcnrOtWImqrK9nnOVRm+N3cjnAy/+hRRXkBjyCEIjlXSGbf8GmQ4KoKvF?=
 =?us-ascii?Q?FZACpSBPqDobjPz1YHfM75c6kzJbOZGuGkIGGxAwuCwgx3VbVm5ZSjMZZf/P?=
 =?us-ascii?Q?QITrlT7MBSK2nW6jMIE2WkqTlhYm0cmurc4WTK4l1xRC5b9RK1lQFUcK1nR3?=
 =?us-ascii?Q?4U+QDjko9peN2mrccw2jP+Lx/zkugTmWYqQAlKVZlolGYSCz5OKLiFFaptSU?=
 =?us-ascii?Q?l3SKTecSmCp8eC0IGhzsIAx8pbXC7N8r5ntb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:33:40.4177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61332a1f-cace-4853-5e8e-08ddc43b15d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
Received-SPF: permerror client-ip=2a01:111:f403:2416::62a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Current event logging code is broken, because of following issues

1. The code uses '|' instead of '&' to test the bit field, which causes
   vIOMMU to generate overflow interrupt for every log entry.
2. Code does not update the eventlog tail MMIO register after adding an
   entry to the buffer, because of which guest cannot process new
   entries (as head == tail means buffer is empty).
3. Compares eventlog tail (which is byte offset in the buffer) to
   eventlog length (which is number of maximum entries in the buffer).
   This causes vIOMMU to generate only fix number of event logs, after
   which it keeps on generating overflow interrupts, without
   actually resetting the log buffer.
4. Updates ComWaitInt instead of EventLogInt bitfield in Status
   register. Guest checks this field to see if there are new event log
   entries in the buffer.

Fix above issues, so that guest can process event log entries.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 20 ++++++++++++++++----
 hw/i386/amd_iommu.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e0f4220b8f25..a34062153194 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -172,7 +172,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
 /* OR a 64-bit register with a 64-bit value */
 static bool amdvi_test_mask(AMDVIState *s, hwaddr addr, uint64_t val)
 {
-    return amdvi_readq(s, addr) | val;
+    return amdvi_readq(s, addr) & val;
 }
 
 /* OR a 64-bit register with a 64-bit value storing result in the register */
@@ -201,16 +201,26 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
     }
 }
 
+static uint32_t get_next_eventlog_entry(AMDVIState *s)
+{
+    uint32_t evtlog_size = s->evtlog_len * AMDVI_EVENT_LEN;
+    return (s->evtlog_tail + AMDVI_EVENT_LEN) % evtlog_size;
+}
+
 static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 {
+    uint32_t evtlog_tail_next;
+
     /* event logging not enabled */
     if (!s->evtlog_enabled || amdvi_test_mask(s, AMDVI_MMIO_STATUS,
         AMDVI_MMIO_STATUS_EVT_OVF)) {
         return;
     }
 
+    evtlog_tail_next = get_next_eventlog_entry(s);
+
     /* event log buffer full */
-    if (s->evtlog_tail >= s->evtlog_len) {
+    if (evtlog_tail_next == s->evtlog_head) {
         amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
         /* generate interrupt */
         amdvi_generate_msi_interrupt(s);
@@ -222,8 +232,10 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
-    s->evtlog_tail += AMDVI_EVENT_LEN;
-    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_COMP_INT);
+    s->evtlog_tail = evtlog_tail_next;
+    amdvi_writeq(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
+
+    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
     amdvi_generate_msi_interrupt(s);
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 62641b779ca3..3dd4e7e3e8b8 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -111,6 +111,7 @@
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
 #define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
 #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
+#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
 #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
-- 
2.34.1


