Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8663DC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepmI-0000Wa-40; Thu, 24 Jul 2025 02:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepmE-0000Lp-AV
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:50:02 -0400
Received: from mail-bn8nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2408::620]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepm9-00047Q-Lw
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:50:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcb7K0cA6wdyxHl9aSBwAtNw80KnlgUxJYevoaw8xql4NGGEK3P00dzG7fH/2nnSxpWvswL+euTfbQk2INoKR8L2ElnZpi8N0niH7ITDY4xUN0NcQJVodvGWsOPkrZz1EWlCyN6MMZnEnba7cKqPoWu+TJ67lY+VzbmaSxlerq7aUMKy26QStEdoQMEchmvsDOre/IimA7Alk9L271q41YwWZy/T7+3z6vgm14rK1N8ie1TCcTRKETyOZswS2Eie4VJ6vaJNXt4BQI25CHQRUyJGU3EKiELior3zUAMxXZEPAaVRlX+uzJ/LmaUAkepwx4ydWhFMxO7NXv95iKxgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iR8rUVt0THI8qQsog4zMDP1xFHMekxednvOp9dHCQA=;
 b=UOZ1ncABIBR004E/6mrv88Vb1XvuSLW5Th/x/xo6ARbxsRpmg37ju5Yg9QgCAzlXOFQCiH8ALSi2n9RMPmFFFhPNbZIFcshm9ugTliQdRhLlnnD+Ztb4WYV3DawzOTfozygB31eku4W4+K/9wD7N6QfMeHyF37W3cP3jRTwdFuw+3t0UQRC+6P3ulMuPMX1oFF6+5ghsEuE1b+CZmcVJcvb7Q5UEwnpEFyOozPEgNyjfOa4jIyTbl0a7Lux3cOfk2tdBPjD2aA7Elmpx5UFQkSCkWI+7lxURR0rgQX5grOXVGa0A9t4S9l020ztDSxksFpmSwj6ZxCC9sAT7t2dEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iR8rUVt0THI8qQsog4zMDP1xFHMekxednvOp9dHCQA=;
 b=PH/19aoml647OgiiAKTs3wlSjIKs54P5Cm24Ndr7nMA1uRLqyK1HuG73n8nCPJFY/ETCj2fXyZ8Gw8dEd7WQ6UwKhgWE+MWRx0dAYYazvvLDFcnMcjqeYZOoyZFXYSQy0/sFmeeymwEFwmWqnZQSH+ZPEF2dzUdt3FnXhKo/hfc=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 24 Jul
 2025 06:49:50 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::22) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 06:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:49:49 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:49:45 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 6/6] hw/i386/amd_iommu: Fix event log generation
Date: Thu, 24 Jul 2025 12:17:45 +0530
Message-ID: <20250724064745.4091-7-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b0fa8a-4b9d-4583-9e33-08ddca7e48c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7wxPo4T6CW2ZQnVvCs0wns9Vh+jew22w197SMOCTGk69eaBeKzc9rC9Yox9/?=
 =?us-ascii?Q?N77ATCjsm4izkSrGG82tOrkYU5qH3TKipvHT5by0RiCn3Q2sFSUL3dExNGVl?=
 =?us-ascii?Q?UWL0r7ousvyM235cvOgeUh+fRqtAM3cdfII4dVkyUEea9ZLSJt7IwW6jkuZH?=
 =?us-ascii?Q?oL7c8P0LsJGLUWpH7f6E+0qLG6pAq0qUYZraSBADOqQ5rri9uYCCludTix2b?=
 =?us-ascii?Q?WhKKaD48EuAqe6VrPmJyI+zKJQLVLdpTu93L9YD4MANV4KmIPlbDudAx/nC2?=
 =?us-ascii?Q?MQCJhB6ab8JKsvBWLW70ZnzeliBbA6o/A0fhwbWIHzBS+xGAaf5q3H8fCMRI?=
 =?us-ascii?Q?yORvEj/ys0p1GMclmD/0H35Y3Sc9pWGNM9s9cgpS4ST8s1E0sttp9e6Nzw4L?=
 =?us-ascii?Q?Hg96Uhra8hXwD8ttUSfm9piSjDqMWbnUaelCzwHyE5GzzyCcaIskgwKb4JzF?=
 =?us-ascii?Q?hTMhxZMeCny2Cn61CaIKFYuv/T6NZTo3znRtLBaxtWakWYxi3JSWPLSupag1?=
 =?us-ascii?Q?KPoVwe4bc64Ayqwa0vqfRD3feeuJvwpuZZrEOLZA+NNneQiSByT19dCG8G4f?=
 =?us-ascii?Q?c2n/C/IoRwHuAZem7rXnEGKQowyV4JAV9aDXFRbd4eArmpxuIx+9zr1ymuqT?=
 =?us-ascii?Q?k2oAhXGOxqJK5mvtqvDbGu7THJBVov/UC84e3CyNI4beSkdnRTm4w+67wV0o?=
 =?us-ascii?Q?a0KcpSOUJ1Ri6B4x4QzJTsTvRkal+ImJualab1KxUXJO/D1gKsugjPDRxxKy?=
 =?us-ascii?Q?yS0ElYSyu+Ey6VaXLtkYVQuzTuMpO4zt4ykyfujBeIlQwy9nojnHsnb77ncx?=
 =?us-ascii?Q?3Trv58X1c2bFHbeWhTELeOXLs24GorK4l1X+1Ap6bo3ZwrthqNxoy6krsDvy?=
 =?us-ascii?Q?e8O3uxvIDUj2s27oG7gBm/Plz5AMY36g+GDOiQdBSCuODVwmCZul0eYAjHTb?=
 =?us-ascii?Q?zoqQXRyI/sCikFs+TeICYbHmpA7K21StAlI34Bbrx9iEQQ1rDGyGGTX44w4L?=
 =?us-ascii?Q?QuEYm89qe5Kn1VGGwou8c3N8JeMWCuCPS3wPSp25gZZqmtfakJdZy2gDgKH6?=
 =?us-ascii?Q?h1dGqdcRXwFhEaDkzeHUYDGWHLuIhS5nTBY5xrR7ZkrpbMcEDi2GILwRWHPl?=
 =?us-ascii?Q?a4ans02W5MTw4sRwLIgePSOv0a7wpQfpnujKuBjthmTDDPsbHClR1vcrpx/t?=
 =?us-ascii?Q?Dt4rMwD5g1c7pk4zi7mToAgXyGBnpSedT3DLHnsiOVNaKJgy3cEOapBK/bGe?=
 =?us-ascii?Q?PvABfcom6EW/iRhM7pEoGf4Le76NGCH0uB+vAT35ldFcGbQ8U/qwomTweACg?=
 =?us-ascii?Q?2aIVgcWlDhv0fK/GceKk6z8nIs1u5POZncVumSOQX9B2f6mzFSJ3e7D7KAEx?=
 =?us-ascii?Q?DMCMv5zGyp/8C1NXieMJTMvrrAwi1nKez8XCFM1aZp3xjqBCH/Clr1U/rqJj?=
 =?us-ascii?Q?6YyZCFIMzRHcXbRSfEe+paZISTbO491rJN+M25qpvDb4bC45xZo7Me0xz9/x?=
 =?us-ascii?Q?1KNUGAuBKSGRgXp9P9xt2lxWSf0VzcuavZpL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:49:49.0730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b0fa8a-4b9d-4583-9e33-08ddca7e48c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:2408::620;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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
5. Does not reset event log head and tail pointers when guest writes to
   eventlog base register.

Fix above issues, so that guest can process event log entries.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 44 +++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h |  1 +
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7c2fa80d14ff..df564bc90fa9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -148,10 +148,10 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
              (val & ~romask)) & ~(val & w1cmask));
 }
 
-/* OR a 64-bit register with a 64-bit value */
+/* AND a 64-bit register with a 64-bit value */
 static bool amdvi_test_mask(AMDVIState *s, hwaddr addr, uint64_t val)
 {
-    return amdvi_readq(s, addr) | val;
+    return amdvi_readq(s, addr) & val;
 }
 
 /* OR a 64-bit register with a 64-bit value storing result in the register */
@@ -180,19 +180,31 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
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
-        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
-        /* generate interrupt */
-        amdvi_generate_msi_interrupt(s);
+    if (evtlog_tail_next == s->evtlog_head) {
+        /* generate overflow interrupt */
+        if (s->evtlog_intr) {
+            amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
+            amdvi_generate_msi_interrupt(s);
+        }
         return;
     }
 
@@ -201,9 +213,13 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
-    s->evtlog_tail += AMDVI_EVENT_LEN;
-    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_COMP_INT);
-    amdvi_generate_msi_interrupt(s);
+    s->evtlog_tail = evtlog_tail_next;
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
+
+    if (s->evtlog_intr) {
+        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
+        amdvi_generate_msi_interrupt(s);
+    }
 }
 
 static void amdvi_setevent_bits(uint64_t *buffer, uint64_t value, int start,
@@ -719,9 +735,19 @@ static inline void amdvi_handle_excllim_write(AMDVIState *s)
 static inline void amdvi_handle_evtbase_write(AMDVIState *s)
 {
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_EVENT_BASE);
+
+    if (amdvi_readq(s, AMDVI_MMIO_STATUS) & AMDVI_MMIO_STATUS_EVENT_INT)
+        /* Do not reset if eventlog interrupt bit is set*/
+        return;
+
     s->evtlog = val & AMDVI_MMIO_EVTLOG_BASE_MASK;
     s->evtlog_len = 1UL << (amdvi_readq(s, AMDVI_MMIO_EVTLOG_SIZE_BYTE)
                     & AMDVI_MMIO_EVTLOG_SIZE_MASK);
+
+    /* clear tail and head pointer to 0 when event base is updated */
+    s->evtlog_tail = s->evtlog_head = 0;
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_HEAD, s->evtlog_head);
+    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
 }
 
 static inline void amdvi_handle_evttail_write(AMDVIState *s)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 67078c6f1e22..2476296c4902 100644
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


