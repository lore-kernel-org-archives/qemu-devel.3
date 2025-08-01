Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B006C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhivO-0003rj-Md; Fri, 01 Aug 2025 02:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiv7-0003Z7-7l
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:07:12 -0400
Received: from mail-bn7nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2009::625]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiv4-00059i-UL
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI4s4LnEgnLt0WVHuJ8bS+iS5wVJf/Qzo4rwQ3/vSEPEt/wCSs4JqyelElJhPd9lfxeYS+MZvY1CSlJS8u8QpbX7RDezF0JPBXkqD2ba1rMRV3iCgUrbrSDVRMqautlsqqn2r4+ChziDpqqUHy6HXLcS+tr0fD3DH8RsXg1XByORPA5iPWpAG3PaxWXl13HwXJY5pH/6OrCDDhrJhnAtWHE+ppCAND0Mk8V0UyetZfDowYr4iLktdCsIulwb2bhn8GrlK3ztodHHPxJENT9dntJVwCvYjqOc0AWc28nvdgncV8spN+nroofd53gXkkir+WHRDjvzDLMk0m6E63LIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0riHtrPdHLVtBmHR6f6qMVXyJ1UvWeOYBRjfLQbK2wQ=;
 b=piCuvNVU5MJQkHCQStVDh8XKB4GDo/v3U0pFSE8n4P8HzTbFYSkXyG1VAh4udBIKcG5OT4MrkHmIFMN5F0Z8MV6UMgjwB2xW91bProAmbNeWg0Zfh3tn14gwPo+AhgqlUwpZLSaREO3W5TR+kSoQ4tDPBBHH3VT0ojCBaGrua1G+vKucrDvY/+BdUEVjHEb3ZzqlJYitqba025XflJqlN+uKhFBsLk4ax5Sb8zVYhXfatBy++BxrwGpFNL8rpaYOXY/u44/SMtQJdDRSFrJh7K+IZSinF+YOmAdClKLyycisxQT6KQ96SEcdz95vVhuwQEMcYLCMFoGLu9Brhs6WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0riHtrPdHLVtBmHR6f6qMVXyJ1UvWeOYBRjfLQbK2wQ=;
 b=PcVYQRM+4NtQoq67cz3t2S2+ihmXVSx65hWJ4Y5iCw2WeANCgf35zjPRv2gq71opy6R0XH4Tpr3kKUrZeUWaGjsHPM8FT5TW+vWGeBro2Wh3avRodJfgOCX2xZdEBPkF6DeIwN8yUW2jmqip62PfFdXtuEBqVZBOIgHZurEHiBA=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 06:07:01 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::71) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 06:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:07:00 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:06:56 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 6/6] hw/i386/amd_iommu: Fix event log generation
Date: Fri, 1 Aug 2025 11:35:07 +0530
Message-ID: <20250801060507.3382-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-1-sarunkod@amd.com>
References: <20250801060507.3382-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: e867ece8-5f62-48c9-1b21-08ddd0c1a130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GRjbFoixL/PU+HnxyKgctsBU9cFDyFvKFfD1rmYvZEHiHTSMaDrMRJ/hDDr3?=
 =?us-ascii?Q?4yNF38YK3KpCdkpC8F820Ij6K8cWhsQeTG+U/0ThCSFCFDoUZJgvkESuLmUt?=
 =?us-ascii?Q?eJiN1Ub8hSqACWzEfmdjFMhmvuCPLI43PxlElIuckScJeKF0IJBbBAeW7bLT?=
 =?us-ascii?Q?4ooaen7LcUBpDlCpfIYMhz/Wek0VRoWu6QgZOGVjGDsb5w7Bs2C/nsllDWsc?=
 =?us-ascii?Q?qYwrS5o1bPAfxlq5SyGe1EkyEU8mbZFdNxnA1ehkfHEWKhmdziKBVmb510Ku?=
 =?us-ascii?Q?eote/bRT72MW7yBTEes9Py3zyKuYRNqZVE4DhDyAO49n8LA+4ceQ0WUxmPMu?=
 =?us-ascii?Q?f1zvsygOuTvZRImREkdRKo5WHD/lwu+WQ0hR94PjblilwXEu6S4UaZkAWqb4?=
 =?us-ascii?Q?rzQl6lDap/s9msBWZVUJFDI84vgtKbClAfe/K3UxXsM2INXzFB6mnJOGTcDj?=
 =?us-ascii?Q?hTwx8o2Chk1rwOP0Cxma3yYWqdZBfrc1jI42Xnz2OjWHYj9GE7L/HyPNv5Rp?=
 =?us-ascii?Q?eEjEZgwTt7NvUisv8y8u+AviDhUNNoIWcBOPe9idAZyLT0i9D3AdAeYdax+c?=
 =?us-ascii?Q?N4juOw+7iddEaGYpGA0f+zne5Rd/lM9Ey2gZhDOfepsYN6APjg6WAE6T5FXJ?=
 =?us-ascii?Q?zB7rfFk8Ol3JdMtgQOj6Vh7C1+0iCj6irSgzya0B21+dY4HAHMqiG8XWkpvC?=
 =?us-ascii?Q?uUMJOeNoxwewR5GF6uhfNcLNSL4IsSOVzG6OOh7c7uaGHbuDPIuJ0zvanuGs?=
 =?us-ascii?Q?VlGkCAE5DSPHx47pZ9iYYBZ1b81WG/SxXxw5tH4ifTEH3NY0miqd/Rhxv7Cz?=
 =?us-ascii?Q?QKLvSHYADq+mmjLAVM+lcF4aEEEbGsOFwMy03/Ubx8vSDIFco4K4ZYWoG/Rm?=
 =?us-ascii?Q?1NEFQLzLMuQ8r1JfovTuG7fGx+lDT3o20uurjQWNkcxdiRvXrhIl1OxRlzW7?=
 =?us-ascii?Q?dNRvvhrfnKbv0woGD/2LJjGwwhHAu+1qgr34zEFH2k/8ja4SzknJ7n4kaIws?=
 =?us-ascii?Q?Q4K4AcpnZMPDT4Y4AY/e8zN6iRbbTLnVf3rITlMyOqK1yIxRvnN/5Ece24Xv?=
 =?us-ascii?Q?lLHqyBwbEhpMajgviP86mqKpx2ucptwQBz9Vg84ORzMUaITZueJ+CLoD4dcQ?=
 =?us-ascii?Q?mQk6nMtWW1h3WThHAq7Z1UgG7JPLGwQSRXlr5g+WKK59ASVwroVmhoShaIrD?=
 =?us-ascii?Q?lJkkvyCfkMLblxxXRULQIxY/yuLh1nUpINZsrdjPWIKRKx5ks6B+HCoSO8dN?=
 =?us-ascii?Q?TjzDWGTlK5nDdcQ1R3c92DXSFpTheMLlGlsOPs51YR8ZZERPW1yo/NE+17Vy?=
 =?us-ascii?Q?JNH5GRhp0KpE3+ueLItV/GyiQVZ1XtfUGDH61kLMrQX1sF67Hs8f4Zra9Iap?=
 =?us-ascii?Q?TNydL8CU1wPDS/cX7t1Nzql4vMltX4Yy9GQlnOB+1X4RbB2RsMoSw7aB9MIl?=
 =?us-ascii?Q?AC0CiROZ0GH/U3/61amXc6Br9UJ8JFfJZ55x1mrAttkpUGdAyW7RipmJbS+8?=
 =?us-ascii?Q?jEHbU1Qpj0LaEcuoftTZEtWQ+GSqq44lO3f0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:07:00.6702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e867ece8-5f62-48c9-1b21-08ddd0c1a130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
Received-SPF: permerror client-ip=2a01:111:f403:2009::625;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
index 681a46c3ceb8..bcc21c3d7930 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -160,10 +160,10 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
              (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
-/* OR a 64-bit register with a 64-bit value */
+/* AND a 64-bit register with a 64-bit value */
 static bool amdvi_test_mask(AMDVIState *s, hwaddr addr, uint64_t val)
 {
-    return amdvi_readq(s, addr) | val;
+    return amdvi_readq(s, addr) & val;
 }
 
 /* OR a 64-bit register with a 64-bit value storing result in the register */
@@ -192,19 +192,31 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
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
 
@@ -213,9 +225,13 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
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
@@ -731,9 +747,19 @@ static inline void amdvi_handle_excllim_write(AMDVIState *s)
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


