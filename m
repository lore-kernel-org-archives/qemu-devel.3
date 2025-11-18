Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AB1CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLH1p-0006z1-5h; Tue, 18 Nov 2025 03:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH1l-0006rv-Pm
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:25:30 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH1j-0006yk-OT
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:25:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVog1vqBtI4ng9iZzfglelstqbmhum8H7Hbg3xJHTjfnXXHLwU2W9DRzLWdOLNFt8H9bIHpJeE9iU5NogH3R1AKn4gcS/gF/On3kUQfR7vnQ7Ng2lZH/bSOBAf3gI+PEAfRG6oEM/FltO/GTGXehxuWm5eKuG2QxzHaY2/g1e6OxtZoi+wHGAaRFvTMAvHRbDDIPFdDn0fQ2cucbzTtF03bCuTvHie3uZGS/w32vej0BJfG8CG/QznFGqBiVVPw2YuF2dJ1CgF1cPZujtELpGSBlfvfcRRhyMn/2dXRbV1qnd+LZaeRt4oW/W4m0oefeg07W9zzprdx7LAZAmBD8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9ZoiEkq/vcp6DoYOLATw1zmFdL+lcISmzxxghqL9Sw=;
 b=W0NOdGDejecvLilGjOTCG+XhB9LsMD/hBVUqiFo7ch00xDb8YLYjNh9NZ8KarQLqFDz13rPJBt5fqqwANX8uyVFgTblBwsDcirwE92hi/l4kBYf9T3WTqzf/cLfFIwXT7TfIJ2n+lCQjQ63FWHzpDr44A68WvdGKjKz/s3hM8jeOMJWV8o+ExvEVrneUgtnZsi0oP5E8PUqNx7fMZ7ssOcKf0R1L9RHnfkh6FAeqthU9BxRTR8Z1VAMSftmVycsf9h7VY6UhfdF1hHRilL9OTsQSM630yvn+Ldk/vtAIRln/l2tWmEFs5gilgLGx/WQd/U7K5vRkVTV3k13KXY/P1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9ZoiEkq/vcp6DoYOLATw1zmFdL+lcISmzxxghqL9Sw=;
 b=uH/O2IRR7d9IKC5VFrcTutrwT8LQ0CmfJLmWiTcQHsMdJ/CzyLZNa1GwGf8N7NWl21UaTykgo3Y57qHFqtG5qy+xcZvxR/r58upco6VyaKK+tb1CnpjYUIJGTzMqDFZM6VVKioIPwa7zDnU+tIVIF57vcmswLa2R7UYIM1yYzzc=
Received: from CYZPR17CA0018.namprd17.prod.outlook.com (2603:10b6:930:8c::15)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 08:25:21 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::2b) by CYZPR17CA0018.outlook.office365.com
 (2603:10b6:930:8c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 08:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:25:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 00:25:13 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 3/3] amd_iommu: Generate XT interrupts when xt support is
 enabled
Date: Tue, 18 Nov 2025 13:54:03 +0530
Message-ID: <20251118082403.3455-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118082403.3455-1-sarunkod@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: b555c422-0925-47c3-2639-08de267c0379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RnBu2J9+8zsIHQ+quiGEHvOByLFnc9+AgtZ6YsPp/usIe8p/6iO0bFJnnpvj?=
 =?us-ascii?Q?Qkeq+uvFVTIWoLaHMi8J5aTujQ4pcYZVYpm4g0Aklf66j7lWDpKy9Y6X2XzO?=
 =?us-ascii?Q?qB1+s2NGpUHIRV3K+R2OfoGLu6XhXft1sxNV02p3Sz52akdcaasY8+8gUF8u?=
 =?us-ascii?Q?L7CRZqU373wLJS8DIw54tkfZneL4A+T8h10dnzctQq2BZ6IV2v6TYMNwBXJY?=
 =?us-ascii?Q?02JOjcHChs2dk3BfBpdJ6XESpF66ziIpB8+ID+SW70e6aKw4G8eCi8U7FUqQ?=
 =?us-ascii?Q?zYBLg+GCQamdeF5LxlSIdKKPz1p7GrfZGLqvCu/Vu3vdWA/cXR1hNXPY0qUI?=
 =?us-ascii?Q?ufarzaSSl7jOWNXzsAbSY6zqIVze+DkXjIpoft2xhyDVv9NvWdgasFmnFRq8?=
 =?us-ascii?Q?NQzqXtsXzz4AbvSd/EMdlYQEZ2KUJHRoNoMthmcNiIYZNFXeVK+DFTkKxUeg?=
 =?us-ascii?Q?z6ZXgvTy7c8pztRJAy+Wi8dHYEK6QTWCZjGBJF9Qe+6hnd1VAxrcyX8T7OjA?=
 =?us-ascii?Q?4gXEkhDzBMcXJwXVDB7CC73LSgcMl0VkgGt/DfCwFTDB+WOqvQNZSUzVWq16?=
 =?us-ascii?Q?edZQRk6E6R/aP9D61JS0oDJiTSjpqk5GC5XQIx7NEwyegqiurQ8DtpbY1C4/?=
 =?us-ascii?Q?i1WVRZkL42IvbJFXA8/Zak9WYMpUlpwRZWIXIky1CZcBKvV67Gid4Vd3Fnw0?=
 =?us-ascii?Q?Y0QUGHZhBFCs///eKHCb3kJmJ0H91AVjvti/7PewvtCzWn/uflv4UV/gsqUj?=
 =?us-ascii?Q?Gk52F/jL6YTQlvdGD9t9JZsmRnJqFYXXdmD82bpgRmYs8GfsWfTiej+4zvXf?=
 =?us-ascii?Q?hQFUfL8sPEKmpkdju+08NN4F911DeRGqVZAfh5XjI6hWd5xuEBWX92PyxyYf?=
 =?us-ascii?Q?zDSed7CAP6AT1ValB6SFqKdCTx+YVPM1CjEJ1K69RivLriSKAkxKTuBlZcES?=
 =?us-ascii?Q?2gC/aKvwT8qtylNc4VXTX7qlkobFtNnGpDugDVVbUL88Xm1y8i7lH68NS2Rc?=
 =?us-ascii?Q?Zp31uToE1c8ttiX4nZVrF5lZrhquejF5cHMP7lVNKBTldeM4edKja+IAjUJD?=
 =?us-ascii?Q?bbPzvAOBdO4Ptj0b6Ynu/o2JQXT+m7HGOD/BcsvT1MKEEUAqr3trAqhMQ2Ep?=
 =?us-ascii?Q?p8OGQH5+gPd5QPE1vLmWEuzQJUgWSg8DKnacBvnFPduhXzUT3nEAovm1HJhU?=
 =?us-ascii?Q?M2JqI+Myko8Eom89vBRAzxk0vPOKIH5IqDJCJplLF/zC6fB8nNLmrBZDUukb?=
 =?us-ascii?Q?BdZs3Os29M7/iATa/KowoUCfkZzxDe3jb/b2l14mzbROrayaU+M+n9wE5Xt5?=
 =?us-ascii?Q?EnotTaXPFrtqVDlGKZQJo5USnJQ2NJ6YHBhV5gk4j+m15cK6+nJznD7j5iAC?=
 =?us-ascii?Q?22y6DncUqilHEZr2fK16M+u3o83AjRmY1VZ5yxKsFjveKcAvt6VoG9DVNC70?=
 =?us-ascii?Q?ai79SrJLJS7yRxqaryXWtqxXgICiSkx342eSHix8cpZvk9v/oahyBrsHY32G?=
 =?us-ascii?Q?vgno/Sj5p7A5TXAhU437SIpAzbLvV1lzMREPGjD99SdARCP6d8s4J7T7DqR8?=
 =?us-ascii?Q?yybVtBF0Y/UsCov3kyg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:25:20.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b555c422-0925-47c3-2639-08de267c0379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts
when guest enables xt support through control register [IntCapXTEn]. The
guest programs these registers with appropriate vector and destination
ID instead of writing to PCI MSI capability.

Current AMD vIOMMU is capable of generating interrupts only through PCI
MSI capability and does not care about xt mode. Because of this AMD
vIOMMU cannot generate event log interrupts when the guest has enabled
xt mode.

Introduce a new flag "intcapxten" which is set when guest writes control
register [IntCapXTEn] (bit 51) and use vector and destination field in
the XT MMIO register (0x170) to support XT mode.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c  | 51 ++++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h  |  3 +++
 hw/i386/trace-events |  1 +
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7f08fc31111a..c6bc13c93679 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -200,18 +200,52 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
    amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
 }
 
+union mmio_xt_intr {
+    uint64_t val;
+    struct {
+        uint64_t rsvd_1:2,
+                 destination_mode:1,
+                 rsvd_2:5,
+                 destination_lo:24,
+                 vector:8,
+                 delivery_mode:1,
+                 rsvd_3:15,
+                 destination_hi:8;
+    };
+};
+
+static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
+{
+    union mmio_xt_intr xt_reg;
+    struct X86IOMMUIrq irq;
+
+    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
+
+    irq.vector = xt_reg.vector;
+    irq.delivery_mode = xt_reg.delivery_mode;
+    irq.dest_mode = xt_reg.destination_mode;
+    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
+    irq.trigger_mode = 0;
+    irq.redir_hint = 0;
+
+    x86_iommu_irq_to_msi_message(&irq, msg);
+}
+
 static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
-    MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci->dev)
-    };
 
-    if (msi_enabled(&s->pci->dev)) {
+    if (s->intcapxten) {
+        trace_amdvi_generate_msi_interrupt("XT GEN");
+        amdvi_build_xt_msi_msg(s, &msg);
+    } else if (msi_enabled(&s->pci->dev)) {
+        trace_amdvi_generate_msi_interrupt("MSI");
         msg = msi_get_message(&s->pci->dev, 0);
-        address_space_stl_le(&address_space_memory, msg.address, msg.data,
-                             attrs, NULL);
+    } else {
+        trace_amdvi_generate_msi_interrupt("NO MSI");
+        return;
     }
+    apic_get_class(NULL)->send_msi(&msg);
 }
 
 static uint32_t get_next_eventlog_entry(AMDVIState *s)
@@ -1490,6 +1524,7 @@ static inline void amdvi_mmio_get_name(hwaddr addr,
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR, name)
     default:
         name = "UNHANDLED";
     }
@@ -1549,6 +1584,7 @@ static void amdvi_handle_control_write(AMDVIState *s)
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
     s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
+    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1755,6 +1791,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case AMDVI_MMIO_STATUS:
         amdvi_mmio_reg_write(s, size, val, addr);
         break;
+    case AMDVI_MMIO_XT_GEN_INTR:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 32467d0bc241..399a4fb748e5 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -57,6 +57,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_XT_GEN_INTR        0x0170
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -107,6 +108,7 @@
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
 #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
+#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -421,6 +423,7 @@ struct AMDVIState {
     bool ga_enabled;
     bool xtsup;     /* xtsup=on command line */
     bool xten;      /* Enable x2apic */
+    bool intcapxten; /* Enable IOMMU x2apic interrupt generation */
 
     /* DMA address translation */
     bool dma_remap;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index b704f4f90c3d..fe7aea4507ae 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -114,6 +114,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
 amdvi_ir_target_abort(const char *str) "%s"
 amdvi_ir_delivery_mode(const char *str) "%s"
 amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
+amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
 
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
2.34.1


