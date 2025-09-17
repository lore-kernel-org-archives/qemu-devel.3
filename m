Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B72CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqh7-0001yV-Us; Wed, 17 Sep 2025 07:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbN-0002ll-LP; Wed, 17 Sep 2025 07:45:38 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbK-0001qi-CI; Wed, 17 Sep 2025 07:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0jHB3GHyD7Ay1AUliJREH8fmC+kdhTZCpSWRpFtVCI0RARDChO1TxjYmlETjrucKG0/bjxeFMhAafRPREIOGGn1ydeLvrmxWq0qBb2alV8hj+b7LjuNQtpRJY26dr740iTSNnwxJfNsWoC5mKWlWIE9Pocef9M/gc0dpaXn1YrD2oYcNEcINvMvkxPDTkHUy5ywWcWO1lZtU9Q1hGvvhn85i5fJX/W19dr+3Ol//R8cSPJLx/F6Oy7mqK4UTyEM7jLHFWIfBmZXFNrlLiP62l5jVqLzAoIA57tElu6hZncv1AIHxbCz5m/vUer5bSkbuaVTGYye7NahMk/qvSi5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHLqCSh80f+pJzfPw5wqXSO6whRkVPN9ypm0TIK6AU0=;
 b=DbVP0VIAO01CYQPaZpSrneisnRrhBH/bjpfGwgu5g+ZzuAWUvhIaR7oFL1IGIbPmWi7b15HjKozeJjMT08J9ehJoEK+BTRl/YDxOloGcmOF8oCUBj3uyBpTg6vF/s2ZGNR+UkdlIadam4jHDskqGJBNWnQ0hnmtBMr54QPLqqp4Z7apXvvNz4q6HmH4Z95+olarZgsLc9h2AegCnh/+rKboYVvMw9LsJjef1Xnyq+KbSIzkKOEJPpRwND62vHgcq+UErEfclgKuwsqaumfJuuUOrCTSGdR4RFQPeKhyqZ3F/q37board5npGMHB11GqcYmwnARZ45TZN4VxUtlgEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHLqCSh80f+pJzfPw5wqXSO6whRkVPN9ypm0TIK6AU0=;
 b=UhkT3g3WkPTHnN+SIkEkQJJYp5NV8SBOEcGiVeAVnLqjEXQKMPym8q830nHpY1P5mJWtMRKHFJy0GrP6hq15//5XICH5wJeXFbUl/oNgHRdTK/x7G5QYgRYUEeK9VM1pUjgj3iT9B9mzvgfWyYwjO1LhWWxSF9vagehttHXkaDw=
Received: from SA1P222CA0106.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::11)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 11:45:25 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::82) by SA1P222CA0106.outlook.office365.com
 (2603:10b6:806:3c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 11:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:10 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 06:45:10 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:09 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 6/7] hw/net/can/xlnx-versal-canfd: refactor the banked
 registers logic
Date: Wed, 17 Sep 2025 13:44:47 +0200
Message-ID: <20250917114450.175892-7-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2054cdb9-667d-4614-1cae-08ddf5dfb117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/+oydm2vi30jO1sIvOjt0Ch5kByr7t8DmaDU0faRg5muajkIimvhuN3XWSYC?=
 =?us-ascii?Q?tLhsFWS1hpYWUY9cjbtKbDrpAkm7DtNb1omOTUoVHi8c6CVpzkJNbjnxLSvZ?=
 =?us-ascii?Q?7RIPu8LIooh7RqVJbDLeeF9wtrmyWu7eBa7vm8INDBg3Cr19SjmzPTmZR8ro?=
 =?us-ascii?Q?u9SdcfSQ90l2NOBA+E9dB/YwsYx/EImHu64vY+8IyLpigstxyBnax2/rsp0O?=
 =?us-ascii?Q?eKTNmZKqbsrGsQJ1flEFRRyV8CQxfzXLuwVpXcdo+ZHzRMjHTY+oqvl1/Upc?=
 =?us-ascii?Q?aD6ixPDd/02m9aJ1l9LL41ZKz3B8EnlniY/h3iuVrEjQ0h3LbuQsE5yjPGQl?=
 =?us-ascii?Q?LzjafNqPZ4g8BMhfZsKEbTgNmVEHSsOfAOtPPsiq8+qSjuckOtzsyrz2ydET?=
 =?us-ascii?Q?asXFqA11IjtpzFA4swtQAks2ZsXfhI+pljKvCKWXmp2JjTQjcANHg/OoU4Fj?=
 =?us-ascii?Q?tNarrU/uC8XQ9XjSpVQaZ1LFoFmjQkLe2q8drT66CbXwKy9QEtI2HoAaRhDZ?=
 =?us-ascii?Q?Q6jw51baOwRorIEu5h/LOMjXpNuLCoVwtpidXHKC9NRvNr551g7ttbgFcSn+?=
 =?us-ascii?Q?oNgLyfJcNgwSxev+nDlTGsbxq6pg5/tPjrB5fCTWgxgaQ6WEO8H9mTdEFXbH?=
 =?us-ascii?Q?dTL5ZZdUiWbciv6hMJrpVfHi3PW932X/B4z8lFIwqoXK5BFNQ+mFCaSjDvD3?=
 =?us-ascii?Q?WRia4aAT9TBJa7UJc2SkdVk4tdCFzYeeYBKro+S/FwFWGgT10DqENsLpnEGK?=
 =?us-ascii?Q?LKtaE/pUehG/Cx4HCkbh+bG2AHl0QLk/gRB1TihMtmvRk7LhYYqpDxaPfyMv?=
 =?us-ascii?Q?5FJsEJFwCUj04HbnGCZywmH9dZWAVbZ2nCxQf89f+Q2AuzcxQP3YS+qWpxOS?=
 =?us-ascii?Q?fP3HqkaJAQ1vW/wt7im9TcYLYodfGFKohxTYRrl88WcGxWT3h0D8Qzh+9KLO?=
 =?us-ascii?Q?7Q0iTFRyiTtPbu1GMAG/5x4Nw1PsKvVEqB+WVuEnBTzh1KaBc5SVv1TQu+U3?=
 =?us-ascii?Q?LwRl3zA8SCEkAFijBI10kkabUdbUoo/J8KnU50laJX2Nl/LZTql7CMwJe19W?=
 =?us-ascii?Q?PWgaZ1EW68+c4Y5UWSBfjeJwiyvb3H3mEeSdWIZebD9hsLDUnFNRjZhLcrH6?=
 =?us-ascii?Q?0gEi4mpThnvzATnCQVwlJEO3Hyh1FAdaEUTkfwTGr9wvndlOd65VSRn/EeD6?=
 =?us-ascii?Q?+SB8vzWV3gckm20flvh5HLLAlK1Fl79MfYuzqYizNgvh62b8zh/UpMhXblOy?=
 =?us-ascii?Q?ADQ5QlOXGz0pZ4yDFvKZvlxqN8UjoJVuSTLDrLif/7hPA2lxOiAfEOXc/zF3?=
 =?us-ascii?Q?3t1FtBQohqtdlLkSRQ4cDzouxYx6mfOkrD4JAHbre+Rk8/EC8/nlRNs6xRB4?=
 =?us-ascii?Q?8A3tGnb8ZqOq1+kC2wt85+DkxdW8vMSF9csp4k99BqHNVScIFZKBQuMSM8N2?=
 =?us-ascii?Q?uMHW51aZVtuEzlBw27hr1jZZPvY6+TJalxWGnMJMjgqbG4NqZpEgpXODQiBB?=
 =?us-ascii?Q?9EDk9+IxSMJfF594YZNVliN2fHZp0AflGAB3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:25.3698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2054cdb9-667d-4614-1cae-08ddf5dfb117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
2.50.1


