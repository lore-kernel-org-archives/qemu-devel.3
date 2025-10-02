Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E476BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqW-0004kt-Ff; Thu, 02 Oct 2025 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqU-0004hp-GB; Thu, 02 Oct 2025 03:35:22 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq9-0008Hj-NA; Thu, 02 Oct 2025 03:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdHfjlXu0+WnkRFY/RONtzeQVjHoRzQ543KiKcQCYyYu3e0I9YKFjWCneztBPTxyQBuWUinruXPfJ2sNWS86vwA/Z9wken9DBBe8RRewxm3mJsy5dJLBejLjrDu65QCC2QszaDpXEFhpp4OqeCk/4a7j8/zo5tMVzCxsGxP0wO8Tw1vKrPVCRmZ0Fjwrvn0BNBAivBeYiLeYsCV1KTS3K8i9f5LIYFIDGPnFIoB8LLbZuTEJfV3cL2zQDx7G+8XMLPfHZJGyejtl6PVU1GW2gPhdbMT0/I+MuF+8QR1Q+uXxv7RUE9BOxTp6rvcy3VijVqN+mi70+/DK0v2o8pi/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yskr51P83ZxOa0+lm2COVP0WgQXWUxA3e4uiye8h1mE=;
 b=m1L9cG7s68JVLZ1fXPesaT7KQSHdNrAUoao7d5oZ07NBNTY0b/tEMlYX1a98S146hleNT2dK5Emjdpw25W699Nfwhi8910Wt1RwkfxHAqX47lv8dlNHg2eDjnl0kTCIKlWHb65fnL8OmTN/y8s1j1AdQGbnUgaRGZTyCi+DE36Mr0krUkm9fElGEW4hoNubSyZQBwNLLJxtu5XeP5T2bAXTP8o6Q96T3OmFniZOM0nmoQD+B40gOlr+w9mZ+WtOZpNja6pYiijFHlVY4V3HDwWM4aW7vhA6uuPF25EXfa2CMPr8Xbgbsr8SI5hUXyuXUHiqQbhBJpos8ujWvDtCR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yskr51P83ZxOa0+lm2COVP0WgQXWUxA3e4uiye8h1mE=;
 b=EDjEOfy50iBzQPzq32gwJ8eWp1CdZp4jTf7rvVeyprLRAzqoBtg/rhPKPbhYEfPwwib59xS8Wk4FYP6Y0g6wiF6k2b0FfyZdFna+BYBBjMdQjPbUf3RyMQOLItprXuDFqdVMQNUJRbN1vP4cAsqRxPE0EtGik5Wccj6a+ZS0GnQ=
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:34:44 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::e) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Thu,
 2 Oct 2025 07:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:42 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:42 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:41 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>
Subject: [PATCH v2 6/7] hw/net/can/xlnx-versal-canfd: refactor the banked
 registers logic
Date: Thu, 2 Oct 2025 09:34:15 +0200
Message-ID: <20251002073418.109375-7-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: aa318b60-8aec-40eb-6ddd-08de018627ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X1wZqICQAUfhfmAaqUoSwX1VoyPe8veHfDDKpQPDawBIiAgj1JcRQCmx8T8b?=
 =?us-ascii?Q?T1rSs9w/+MD2sWAJTnKHw1QbB8Mvclnl0DO3XQfPeG4ySmGky9EInIQASSXf?=
 =?us-ascii?Q?F25Vgu6oFzAMK49fl3hO2LzwTx6crMhhc5vgpzUQRX+uYAWAAvbRYIniFj9y?=
 =?us-ascii?Q?KxtY50nPhRkBYRNfYy/SrfyektK5hlOShjhtHfSY5HU7IFvGeKCFNVr9N1My?=
 =?us-ascii?Q?ihNq3zM1aaSQGKHfR9worszratu8jxVlrkf7w6+pJq3aX2J1fiTHso0ae6ll?=
 =?us-ascii?Q?7SUuMikKPsOGCi6FcMtaUMZ7tesNPfAUSeiDTF6ws719MkudMu1cbGUQVycI?=
 =?us-ascii?Q?FpksnXs5CoCzMxuK00Ivbxy4XbeeJhsr177yZG1wfQ9lf4R3n5JcwRMRzxTT?=
 =?us-ascii?Q?aFdLyGHoCLxbE++Li2ErjJvpoTUtRkmmo9sMc93iYTZw4b8HFSfX1kPu0fD3?=
 =?us-ascii?Q?ds5Jy6rGu0Rs/feBjIHe4t5iqXiF0y6uRViiTgKPm4TMwQL2aA1qhsIMKGCN?=
 =?us-ascii?Q?5u7n29rEZcCMhBQXIodjqTl2hQCEgNDzZW9FwAIrjxoRuKSsaS0XD/2UFm8m?=
 =?us-ascii?Q?5G7QZ1PiW6ryKIBmc7pnIWA8dmbwoBILFUqBEiYGyittSX0zGiXkB3hxb7EW?=
 =?us-ascii?Q?MafZ5YOuEwd1D3LmXvjqlyfBZKSpvh5XdcD9TSNACn2x7BrWLwIHaz6zaxHz?=
 =?us-ascii?Q?w6X8B1PNTQISRCMjGOHIbcyfd3UhuHJc0PWfUBo0DWZgMzr+Bdn6z4hWmBgp?=
 =?us-ascii?Q?qu1RcXssCEXB5TRlud+Kwbg3O8uE2u+CCwYfrIhp7jre02ps8JfaWAq6VZMO?=
 =?us-ascii?Q?goS0wufRXKTLUsxxR4FFraeDD/eTwFitleSNHEhVf3k2hCeYIwp7R0o+HUV+?=
 =?us-ascii?Q?JUQkhv9wy8UxDzkx94vF1E79c2c1altEkaypS3svPPRapVYjHCnC/aGtOQpk?=
 =?us-ascii?Q?L7TphYzmhuH6gzMrO3XIlQCzCxqUDZ9a6iIdwquHOeCJch7GgEwDHTGaAuU1?=
 =?us-ascii?Q?jR4/5nte4XthOFrQXfHkoBj3Y1PEW0vpYPr/FxgMMIj9mu0MMEaAau4Rx53D?=
 =?us-ascii?Q?DvaVkHRkf3RBVkEtkd0QDFJg8++/O7nQ8GrC0bQ76G1d6uOrQHk85qinUFUl?=
 =?us-ascii?Q?y/LGrDUIbv8PmxJ4tQ3xii/lpeQmW9k+Ur9bhbbxkqz6SQcwxvg0YcqBp8Ox?=
 =?us-ascii?Q?8A/DjgztHtoK9WkChQRoPD2Nk6WKm8ugtWu+hV80EBCNHMv585wmPvk5Aowv?=
 =?us-ascii?Q?32N2mSVOvSNBhwi5VGbPhbNCgfEU26t3cyKNwB0DxIcOIMP6DNyGieTHDaXJ?=
 =?us-ascii?Q?kHzDO5gx1PUaKlH4bJxID3WqrvBDu7rxZXexIkmfQvZErZV2txrDpeRWQSFy?=
 =?us-ascii?Q?gMAM8KhCym9XpfvC0XZmcwW+VbZLg/b8SclVXzyQwb0KK8PbWQAUQSuQlSMh?=
 =?us-ascii?Q?BoJZzkooce+RZsAXMfkhgsGbO+sYEgx1jCT+eg4NgkVhuFvZ/wSBSMtt+Ag7?=
 =?us-ascii?Q?8rizC8AWu7x1vRyxckiSoStnOIs9z8sZpnGu2M3u5Wgd99WvI1CqbCfOpIdA?=
 =?us-ascii?Q?sJgaq5eOEb+EIRr8+IA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:43.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa318b60-8aec-40eb-6ddd-08de018627ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The CANFD device has several groups of registers:
  - the main control registers from 0x0 to 0xec
  - several banks of multiple registers. The number of banks is either
    hardcoded, or configurable using QOM properties:
      - Tx registers
      - Filter registers
      - Tx events registers
      - Rx0 registers
      - Rx1 registers

As of now, all the registers are handled using the register API. The
banked register logic results in a convoluted code to correctly allocate
the register descriptors for the register API. This code bypasses the
standard register API creation function (register_init_block). The
resulting code leaks memory when the device is finalized.

This commit introduces decoding logic for the banked registers. Those
registers are quite simple in practice. Accessing them triggers no
side-effect (only the filter registers need a check to catch guest
invalid behaviour). Starting from the Tx events registers, they are all
read-only.

The main device memory region is changed to an I/O one, calling the
new decoding logic when accessed. The register API memory region still
overlaps all of it so for now the introduced code has no effect. The
next commit will remove the register API usage for banked registers.

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 155 ++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 343348660b5..81615bc52a6 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1408,10 +1408,27 @@ static uint64_t canfd_srr_pre_write(RegisterInfo *reg, uint64_t val64)
     }
 
     return s->regs[R_SOFTWARE_RESET_REGISTER];
 }
 
+static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
+                             size_t bank_idx, uint32_t val)
+{
+    size_t reg_idx = addr / sizeof(uint32_t);
+
+    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
+        (1 << bank_idx))) {
+        s->regs[reg_idx] = val;
+    } else {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter register 0x%"
+                      HWADDR_PRIx " changed while filter %zu enabled\n",
+                      path, addr, bank_idx + 1);
+    }
+}
+
 static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
     uint32_t reg_idx = (reg->access->addr) / 4;
     uint32_t val = val64;
@@ -1761,11 +1778,145 @@ static const RegisterAccessInfo canfd_regs_info[] = {
 static void xlnx_versal_canfd_ptimer_cb(void *opaque)
 {
     /* No action required on the timer rollover. */
 }
 
+static bool canfd_decode_reg_bank(XlnxVersalCANFDState *s, hwaddr addr,
+                                  hwaddr first_reg, hwaddr last_reg,
+                                  size_t num_banks, size_t *idx, size_t *offset)
+{
+    hwaddr base = addr - first_reg;
+    hwaddr span = last_reg - first_reg + sizeof(uint32_t);
+
+    *idx = base / span;
+
+    if (*idx >= num_banks) {
+        return false;
+    }
+
+    *offset = base % span;
+    *offset += first_reg;
+
+    return true;
+}
+
+/*
+ * Decode the given addr into a (idx, offset) pair:
+ *   - idx is the bank index of the register at addr,
+ *   - offset is the register offset relative to bank 0
+ *
+ * @return true is the decoding succeded, false otherwise
+ */
+static bool canfd_decode_addr(XlnxVersalCANFDState *s, hwaddr addr,
+                              size_t *idx, size_t *offset)
+{
+    if (addr <= A_RX_FIFO_WATERMARK_REGISTER) {
+        /* from 0x0 to 0xec. Handled by the register API */
+        g_assert_not_reached();
+    } else if (addr < A_TB_ID_REGISTER) {
+        /* no register in this gap */
+        return false;
+    } else if (addr < A_AFMR_REGISTER) {
+        /* TX registers */
+        return canfd_decode_reg_bank(s, addr,
+                                     A_TB_ID_REGISTER, A_TB_DW15_REGISTER,
+                                     s->cfg.tx_fifo, idx, offset);
+    } else if (addr < A_TXE_FIFO_TB_ID_REGISTER) {
+        /* Filter registers */
+        return canfd_decode_reg_bank(s, addr,
+                                     A_AFMR_REGISTER, A_AFIR_REGISTER,
+                                     32, idx, offset);
+    } else if (addr < A_RB_ID_REGISTER) {
+        /* TX event registers */
+        return canfd_decode_reg_bank(s, addr,
+                                     A_TXE_FIFO_TB_ID_REGISTER,
+                                     A_TXE_FIFO_TB_DLC_REGISTER,
+                                     32, idx, offset);
+    } else if (addr < A_RB_ID_REGISTER_1) {
+        /* RX0 registers */
+        return canfd_decode_reg_bank(s, addr,
+                                     A_RB_ID_REGISTER,
+                                     A_RB_DW15_REGISTER,
+                                     s->cfg.rx0_fifo, idx, offset);
+    } else if (addr <= A_RB_DW15_REGISTER_1) {
+        /* RX1 registers */
+        return canfd_decode_reg_bank(s, addr,
+                                     A_RB_ID_REGISTER_1,
+                                     A_RB_DW15_REGISTER_1,
+                                     s->cfg.rx1_fifo, idx, offset);
+    }
+
+    /* decode error */
+    return false;
+}
+
+static uint64_t canfd_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XlnxVersalCANFDState *s = XILINX_CANFD(opaque);
+    size_t bank_idx;
+    hwaddr reg_offset;
+    uint64_t ret;
+
+    if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
+        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
+                      ": read to unknown register at address 0x%"
+                      HWADDR_PRIx "\n", addr);
+        return 0;
+    }
+
+    switch (reg_offset) {
+    default:
+        ret = s->regs[addr / sizeof(uint32_t)];
+    }
+
+    return ret;
+}
+
+static void canfd_write(void *opaque, hwaddr addr, uint64_t value,
+                        unsigned size)
+{
+    XlnxVersalCANFDState *s = XILINX_CANFD(opaque);
+    size_t bank_idx;
+    hwaddr reg_offset;
+
+    if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
+        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
+                      ": write to unknown register at address 0x%"
+                      HWADDR_PRIx "\n", addr);
+        return;
+    }
+
+    if (addr >= A_TXE_FIFO_TB_ID_REGISTER) {
+        /* All registers from TX event regs to the end are read-only */
+        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
+                      ": write to read-only register at 0x%" HWADDR_PRIx "\n",
+                      addr);
+        return;
+    }
+
+    switch (reg_offset) {
+    case A_AFMR_REGISTER:
+    case A_AFIR_REGISTER:
+        filter_reg_write(s, addr, bank_idx, value);
+        break;
+
+    default:
+        s->regs[addr / sizeof(uint32_t)] = value;
+    }
+}
+
 static const MemoryRegionOps canfd_ops = {
+    .read = canfd_read,
+    .write = canfd_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps canfd_regs_ops = {
     .read = register_read_memory,
     .write = register_write_memory,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -2018,12 +2169,12 @@ static void canfd_realize(DeviceState *dev, Error **errp)
 
 static void canfd_init(Object *obj)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(obj);
 
-    memory_region_init(&s->iomem, obj, TYPE_XILINX_CANFD,
-                       XLNX_VERSAL_CANFD_R_MAX * 4);
+    memory_region_init_io(&s->iomem, obj, &canfd_ops, s, TYPE_XILINX_CANFD,
+                          XLNX_VERSAL_CANFD_R_MAX * 4);
 }
 
 static const VMStateDescription vmstate_canfd = {
     .name = TYPE_XILINX_CANFD,
     .version_id = 1,
-- 
2.51.0


