Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CA9CCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAX-0005S1-CX; Fri, 17 Oct 2025 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAT-0005Qy-CF; Fri, 17 Oct 2025 12:19:01 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAN-0007dh-Dl; Fri, 17 Oct 2025 12:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI2MFaVyBUH3a6t+as3jThdAKSUQ6E9Mksvw3TSPla1UcGyq/N/U6nGLdlQa9TdbpwFNvNBZKg4ZzyVWD6iWygCVJpzXP7iMqQcZAgg74oTuF1oz0qUiLmHspyuPBVU46UIm7mDq51bZOI/iGZuV0nrz6oZI8Vz2qSmsk6CwYHNLvrJnTShQ8gMb96dvMZtpsLNiUG4S1XbkWcLeGG8qucKP/SfHBYjQvitD+4opRIJ+YtV/tShKWYvQgPqetravJsbBv6NSdmCW+UejkdejXIvZ0c69O8VE7Q4LgByHq5WBql4iYnau+SWITdTXU63TsCu+Yt+MwLjqcagG0V3OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh+Yya1wHvbBuLqOYpdP4I0kGXHgz9h1lYdmYyGbL7Y=;
 b=qLISv+FdjspRA8oEp9yf4H1tof2U/Gpk63F+t6n9RQLriU62RXwNrK2Evucj0RycWmuVna+6QcwGQqvEjPHbZPTfizmMkKquvALz2TOrN0t+GAOyKioFXbe87w/8Q8GoaJdyWKpNxZNd5i+sYQ9EKR8Bn2pNc5bSXSuIk9W975QsMpNnhDPGwWjLMJScJwA/Lixd3wn2Lx4R/EpKaz/ZgEHG84imMaRnR8V+a7xE7/l+F3Nhb0Q8yXPEARjzxlkCizJsXy+kz/huM/9yzt9xh34OWN1DSQTzqV2qHmAQdbQB/Ua86v6Oqreesjvrk0LrlDQI+SmNZizxUc8cO5kx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh+Yya1wHvbBuLqOYpdP4I0kGXHgz9h1lYdmYyGbL7Y=;
 b=jG7o3Fpb5pZmNO/cQdKVOhBXHRgoBlxIhLX4ROHYE4qZBM2MnUOVUZcxsHbqrIc62eBuw12UFpv783I+0f+C+TaKlvLo36ZbHPBG9UGtxLTE6mTb/ZhtCyhgPTmSz3s8/h2lyFST8LfGTpG3lDEbNn21o2bZVBhEsYdq6LjgHyg=
Received: from PH8PR21CA0011.namprd21.prod.outlook.com (2603:10b6:510:2ce::19)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 16:18:40 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::c2) by PH8PR21CA0011.outlook.office365.com
 (2603:10b6:510:2ce::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via Frontend Transport; Fri,
 17 Oct 2025 16:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:39 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:37 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 5/6] hw/net/can/xlnx-versal-canfd: refactor the banked
 registers logic
Date: Fri, 17 Oct 2025 18:18:04 +0200
Message-ID: <20251017161809.235740-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: decae2b2-56e7-4791-5e8b-08de0d98d595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p0vgx8JlQyI4C9fwwomrVn+eTGzU/untgyYlZ5nPXiLs7DOHYxZxwlu1/LXG?=
 =?us-ascii?Q?eFotm76E2jJfqFqVIJ6RFqlaE6vN3ej4juLLeYmhE5aDd91z7kvm3AoQm0sq?=
 =?us-ascii?Q?gAsqb5f1h0aGywJuqLQCqouIpAS+tRCAkszQJXR3GTiaaBDpP/SgYohb7HlC?=
 =?us-ascii?Q?WHF6XxmW0lNbWoseZVAQduW8suh5rP7TQEwgNbZ4tCRo1i8TeHXsrFt36TyF?=
 =?us-ascii?Q?tOAfNKtTZ1U9wi21n5TB99qLJB6R50F2ineqwLOTGy7ZAvJKyZDlJBzOl0yd?=
 =?us-ascii?Q?Cgd0RiqZbcDsaWqzqesGkWPzovJ9KgDxbFf8zkyXrfzbxSOuE7CME/gS2JyD?=
 =?us-ascii?Q?N60zM7XZ4ck9SP/OxarS8TLhXQyghkefcStS6SdqD/qK2KVPoPodMLm7oJLj?=
 =?us-ascii?Q?+LWf8UeKnOOyUEYbZV77O8SnaEqK72no5Dnf9X5JTVUeRPbskI2S3PWfmV9G?=
 =?us-ascii?Q?GWb4PhaDDlW5QQHGu0DQIaGe//nQ4JhCfOGgk6wYHPm/lW2Lva/5Xnx2iWP0?=
 =?us-ascii?Q?SnOWugHrAICN9nXtnZqQt2kSYZtji2hCdK+9KCoIX10yWQIh3PXYXcEqFO5b?=
 =?us-ascii?Q?3XE8H11QlHYkBKf8ijeGRnmIkDMAnLE8KdLf62h11ReV0mk9Ui6HRvtdIgdM?=
 =?us-ascii?Q?9VWL1OGufJfyp76Zj0JZ6Ez/rqzYug+ePqtdySczukgDmZ6k/tX8dv12aEHF?=
 =?us-ascii?Q?ykpmXTDICrBam38nfO0NncZAnnknp9PNjoK6WQ6+irrINHdAdBUZf2/73ZEG?=
 =?us-ascii?Q?5d1bcMS7KFjgbpC1xFQCFBxWPtjxZwVSurw/daDiKJJaj4ORn/hd/rFvT4Zd?=
 =?us-ascii?Q?JZIuR85gHQx0v7PodkwVpH9fktLp/Z8Yxu+uGsksDxMtd9ivnRi1g/XXR60S?=
 =?us-ascii?Q?Ze0R8Md/s+FsEEt2vvNr6fnoF1u9ygZr/oWSAtritLDzX0JNQ3j+l3XVOoGe?=
 =?us-ascii?Q?1V/RD9NiuCZGD8IolH2TGryxryUe0d3XPaNlgEQ2riYCD1L5q6fdvQevySFC?=
 =?us-ascii?Q?1RBu9xgzRbkZGR9N9CwlaR+QDVYCvH44tBrQlbE3eRO284ZAFKX+AkLhtRc/?=
 =?us-ascii?Q?6KQwKtZLmOd0nz35yjENaqppzTcF0KAMXAp5Bd3Vv8+A+LdTflcW+LBagSYd?=
 =?us-ascii?Q?oRR5ZZZ07KDIsJFWCplnsm+7y5h6jFUL391/S5asWkJZcy2HhfavWNWPZ6/+?=
 =?us-ascii?Q?hULy0fo51Ya16hSFhE/C6qn66I+pxsRmtLNO6MlLfTef5L0aboxLpyGSgZ9k?=
 =?us-ascii?Q?ZX14auhR/ZSGpHA3ZPPjC7AGuzaieex69FSetuwoex18+l7taVoo2UhOghXA?=
 =?us-ascii?Q?nOIQJ2YznVgDeqEO1HokNO7fO4Axy1vvgXbgHCjGApxDiEgSW/rljvk8v1iX?=
 =?us-ascii?Q?FMcMaTeTFLEEDL1dIZcrK7ulSn6WBYuml0omNUdfuKW/Qykz7yhVEtGinKni?=
 =?us-ascii?Q?6QP8oVbIeEsEedTgXXEdkUGJ86d1JTxkYVK2bVgXM98OaJp1ils5MXm1FX7Z?=
 =?us-ascii?Q?3giihnGw2V9EnQKCG8uKfHmpzCsOwodhDqqod2FiOonQnf8zEPB3gFpGL2k0?=
 =?us-ascii?Q?2YFYP6pxv/9IMZzY2UU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:40.1834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decae2b2-56e7-4791-5e8b-08de0d98d595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Luc.Michel@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/net/can/xlnx-versal-canfd.c | 149 ++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 99bbdd7d3fe..c493664c2f1 100644
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
@@ -1761,13 +1778,137 @@ static const RegisterAccessInfo canfd_regs_info[] = {
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
+                              size_t *idx, hwaddr *offset)
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
-    .read = register_read_memory,
-    .write = register_write_memory,
+    .read = canfd_read,
+    .write = canfd_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
@@ -2016,12 +2157,12 @@ static void canfd_realize(DeviceState *dev, Error **errp)
 
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


