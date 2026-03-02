Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F99EE9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1pF-0007fl-25; Mon, 02 Mar 2026 06:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1p9-0007dS-3o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:32 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1p3-0007XO-SU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrQJcmXlJE/ZMkLU5rDaNCseGactda2cPe/rTTkGmX8hS8Mp1jpafP19riWxbKLlYIZua8Nll8exuu13c2xkp+PbD0JdT3A8n+R3wFpzri1z4VmWLRvhK2yQyyCfEaBkEDh0jpq5v3BWSsI5n3XXm0oOihO0/115fbRZxAYwgiiDsZwt+uiEeugXJs6t7XAB2yPu60pUKYRUsel0NfrczGCGBfT/JuXgXW5koIsGWXUkR6oMFLHJPnh4UKJSqQWxwpiiJMJd7Y5Nk4nFBcVdL92vsfha+7E25wo6FsM2SQ47zz9tRW5v2TjmKv+UHZuw2/luSR/uq7NzD0LBkJ/bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1mJt2k18XxO76FGBGOVLFeBEWb+Y1m2+s1KTTc2rPc=;
 b=NdufezpvXBoKexqrB5UTDUTVd0seCZjMg/AZWHVPOqjW1pSFbOGiRvoRR/6YH0hWBVyLPq3mPgnj033/4V5XlO9HtWys0vqwBXCoSqXR595LEOaoqEibsuqAzKn613Khs97Er+pT2aWgkqNVdX3BGJZvBcyj3mcvwpJNtPKeOWQhXt5mRSEwH6T4u1ab+NuQB+bMJRYEew3xyEDikGJUxk0SMTEVpbq+tFItBC/FvDENZtXQa/6Qu6ABj+51WItFmRBmf9nybnCyJBxjShPNt1IvElrcp6vQ6f+WYuI6KdjGUHEbXmm6p2vcrZj5kK2jkXDhTPFUaP0tyYorp3ISBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1mJt2k18XxO76FGBGOVLFeBEWb+Y1m2+s1KTTc2rPc=;
 b=rR+3uICRNSYb06OFuQtbd4TUZRE7sGc2mJ5iIt4DiyvMX8L2WwbEzF5JCOZioRTe34YiEZ1KYfLg4h/J9n7NwiaSFk1RAHhAJaKEcYDSS+Jzq+1gNzflFwWnt0tV4x6nyoAC45lTF4bF5+60kEsF7vktgE+Q1J/DwEQAblocwWk=
Received: from IA4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::12)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 11:52:20 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::68) by IA4P221CA0004.outlook.office365.com
 (2603:10b6:208:559::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:52:19 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 05:52:16 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <clement.mathieu--drif@eviden.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v3 1/3] amd_iommu: Use switch case to determine mmio register
 name
Date: Mon, 2 Mar 2026 17:21:28 +0530
Message-ID: <20260302115130.5903-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302115130.5903-1-sarunkod@amd.com>
References: <20260302115130.5903-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c025519-7cda-4434-2bc6-08de785228a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: 7t41ESUHnh3D7oRJNtJCnGC6H+pLg0vCTeCl/uil6mKKS6BwpVMQOWIYbhuYdYeoDwjz8kQ76iVpdjBNaWWC+NEAhHa11qqf0FOC+kMvx6Hfx9689a7icQcUyUG4oxzbKfUwa3WCulQUkUez3W2k/U/gAo7n3ZaBizZkzD2E7mXLvbWSjg/y79m2Yd8FN8Vu6CSiOH6+dB59RXHQoNVVKLFl+HJXtKci4NLOidm3tOuTmQn8Ti1jhNBQiY5+QQcmYEt0yvDXimZQbz5pRV9v6TUX3EbAxhb4HFWuZ0ddFAVD1izE/L3u+z428KFiZcdkg9Dd90CijzYiSxLupFr+AiuLV+m7KSuPwbMfUlUUm+FEl6JXMkGQZs6KayvvCQQZ+fj0/tBMBUVmeGpy52wJdidZBpbYb2Oanpu+/yi4toGrsSgc9UYIIZlo9HYFMvAoaKbxopSkrJKenxajEkTg8Z397JrD9AV3cB+jkJdemYxZIdF829a2/Az/OpY05OqZclLeV4fvTykeI2zyldG/5IHNE/8qxZ/pbBAVE23h/fd07unqoXQazbEYhQkalzv5yEM436uJx5zlRr90xPnKlOfJd6fsAmPVfsq87UCP6VmWvJnwMEqE+Iwq4u6V4Ve3eXhp+WjvYoU56AkbiC2BjFGAAKAdmmyaeQTFcBmpeBOYFUKrZ+yrTko1AbUulXWxkUu7t4GU2QjHqTBrdbTJgrSJwM4cR/Tc5g/ScUfDylVDpwsCKuTrOwbbEpPDBKo7BYMITTFdmWnGUIaETrTTir3lMQFxmi5Il9T901UUOT2HvrOqxBhj4NrfzfoGrODbD3RhAAR08if2x+E0+Re4+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPvENBaKDRlpDDj0i0jcQJkPkGlwiuZaRB/bx6Kij6SsFxofTk1KexibPqqyRpzkhjyeiJwlRCcUQzbfmr3ZBmUNiOgMn11J3pmpwlyenPPouvOG7ILtl+Xd0Gkb21dPoLcp0lIMeRf4FEGbCIwqTZcNDDdMPFSpg/WnfnePnxcAF6lyURwBUax6og39ON4UOwqrxXkBiYqJAryD29F0pr0nC+l+iVnt/hg6ua8sHxFNvEgxXU0SLKr8mRvXg+Ah+8GAfrIbq362S6VhGPlWHGChA4qq4EEziSXRF6ffRbTZsDWt1WL/Tkt7BSwC5tIKQMK8m9aAwZb4WGq+eBxoblMZ5j9uj/tK0JZLaKpqXxDE5X6ww6d69CdpiGWJzCAR2iVI46cT6n3TVpPE2H0gqzzP9WqcMMt3NpkFxkbFu9OX8LQQGLUzhjA5nTt1hedi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:52:19.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c025519-7cda-4434-2bc6-08de785228a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This makes it easier to add new MMIO registers for tracing and removes
the unnecessary complexity introduced by amdvi_mmio_(low/high) array.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 76 ++++++++++++++++-----------------------------
 hw/i386/amd_iommu.h |  4 ---
 2 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2bc..f5aa9c763d02 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -35,29 +35,6 @@
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
 
-/* used AMD-Vi MMIO registers */
-const char *amdvi_mmio_low[] = {
-    "AMDVI_MMIO_DEVTAB_BASE",
-    "AMDVI_MMIO_CMDBUF_BASE",
-    "AMDVI_MMIO_EVTLOG_BASE",
-    "AMDVI_MMIO_CONTROL",
-    "AMDVI_MMIO_EXCL_BASE",
-    "AMDVI_MMIO_EXCL_LIMIT",
-    "AMDVI_MMIO_EXT_FEATURES",
-    "AMDVI_MMIO_PPR_BASE",
-    "UNHANDLED"
-};
-const char *amdvi_mmio_high[] = {
-    "AMDVI_MMIO_COMMAND_HEAD",
-    "AMDVI_MMIO_COMMAND_TAIL",
-    "AMDVI_MMIO_EVTLOG_HEAD",
-    "AMDVI_MMIO_EVTLOG_TAIL",
-    "AMDVI_MMIO_STATUS",
-    "AMDVI_MMIO_PPR_HEAD",
-    "AMDVI_MMIO_PPR_TAIL",
-    "UNHANDLED"
-};
-
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
     uint8_t devfn;              /* device function                      */
@@ -1484,31 +1461,31 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
-{
-    uint8_t index = (addr & ~0x2000) / 8;
-
-    if ((addr & 0x2000)) {
-        /* high table */
-        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-    } else {
-        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
+static inline
+const char *amdvi_mmio_get_name(hwaddr addr)
+{
+    /* Return MMIO names as string literals */
+    switch (addr) {
+#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
+    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+#undef MMIO_REG_TO_STRING
+    default:
+        return "UNHANDLED";
     }
-
-    return index;
-}
-
-static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
-}
-
-static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
-                           addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1528,7 +1505,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace_read(addr, size);
+    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & ~0x07);
 
     return val;
 }
@@ -1684,7 +1661,8 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace_write(addr, size, val);
+    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val, offset);
+
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca5121f..ca4ff9fffee3 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -45,10 +45,6 @@
 #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
 #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
 
-/* No. of used MMIO registers */
-#define AMDVI_MMIO_REGS_HIGH  7
-#define AMDVI_MMIO_REGS_LOW   8
-
 /* MMIO registers */
 #define AMDVI_MMIO_DEVICE_TABLE       0x0000
 #define AMDVI_MMIO_COMMAND_BASE       0x0008
-- 
2.34.1


