Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B5DCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHr-0000ER-4W; Tue, 21 Oct 2025 16:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHo-000075-KO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHg-0001B5-0r
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso64862905e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079721; x=1761684521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KarjRMReFBr6aXs6DXwNVmSxe1Qqf0rq+Hp4zCMDXIw=;
 b=kvtJbHfyf8OBcxD1Of72yGSzcQN0i17qPiDCmm2sUmPNWFFOez0jxK+NUv/Zp6ZMUy
 44fiP2KeSlM0Bg4jVuQrmgfWfEed9DDFvExXoMmS1GZLD5aOT94Tut2vsJUKj7ygv//T
 11MH3cUJTnMCWvS4o/DTmdDGn1QR1nDLEEM7tCVLH/OIp3fjlNQrleyqcnmTvxqwiUP2
 byvuqEryzPbe/IaszDv18JbhBy2w2Gl3DNvBLyEsdaFf2VIsqQrxtKzUkCfxXidbVunn
 ARk1HVUbXNt9V2dHdV6CMNGpZN1TizfX5Ql1bOhKa+QTHnR3QNaXh4ScZqflwBFQJFtp
 URDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079721; x=1761684521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KarjRMReFBr6aXs6DXwNVmSxe1Qqf0rq+Hp4zCMDXIw=;
 b=sBfDPwPbFiis+3yxKFi+A8JcDsM/c0kaNLv0rwRIHTkUqG9QUjPi/iyqhykfKhsqae
 5mWdTfRtdYfw5iZ1AWDvkpfU7JkWtP1SGYWU8+ZLLt5lrBjRh18fY6tm4FeSOwiOOUUp
 RnruME7RdU5l4HdXBg7bzNjJs8wmSrO0/9lklE800RfL+cfCi+gZS+GoL/zuJf93WllM
 +6Pc3zkyrjcfIxfoQdn15O2jxkHcFmmRqEmOmAmhaVpS1f0fFdaHVi3LPRHIDkch5dcS
 gorA+418X5gbOcJxvXlAdViQi9xviRojr/2UGP5tU9ODwkaV8zogrXdrbqo4GMBmsaMm
 Xzfg==
X-Gm-Message-State: AOJu0YzK31BH4vyIFYzFt1uBorfUNB3EbG3eR8AmIVIU6hCXKvfiCWcS
 LVMfHpAHOpVwOfiA4AQEx983y5CcuGXO4MBRxVCSfpBJoTHhyoGdGM3z/q0YdYD5DRoD0cSyFl5
 Oof7xe9U=
X-Gm-Gg: ASbGnctvBPNZMYCFAbjh6NVukTjfdniHxVa/BGAlx4Z9KZ/46UZco2zx6Uc+NnO4yL6
 840tQEVJjsfCh6eMs0gtO39Y3Gte1AG9ExmTnf/g7c9F3zg1C0T2l1JGSbJStvXYf9eVAH4fl/R
 /KxiDACcyXZkHLFVKU0eqsWVLRSi1kVbzlH7BX9LNV8e7ecUyb5j2JPiCHOrYWfYde0Fq5xfme+
 66x1Lf1+NQ5jmGiatocxBH1INLj+6IEp1JzaVn414cISjdIdoUzQ+xRlcHtwH11CRMDmtxJfx4o
 IUlOU99d8/tVHP2C1W3nBUFpy6hjG8rqGCIBEMkZwXG2csmpMhmef4bPSdm1MquVwPoL+eZkxbG
 0sN+GUN7nHNs/h+Td28npIFso/DcHI1CputeZCg1fSMsn1J1Fd2ktupbA+8c9GXS7DiX8V6yYov
 ocOd7TtAUqW2zUUGHJnbY6qhqXJrXyJoO+WAwGBFRkxlwWKs4jwg==
X-Google-Smtp-Source: AGHT+IGAJhewCXhBudnXN1xErnFhAK2LieWkMn/v0aeG2RhSEB29iRjOdQsaATDfvlMNNT5GgayXYw==
X-Received: by 2002:a05:600d:416b:b0:46e:1f92:49aa with SMTP id
 5b1f17b1804b1-4711787c0b3mr141642025e9.15.1761079721363; 
 Tue, 21 Oct 2025 13:48:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427ed3fsm11788005e9.1.2025.10.21.13.48.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/45] hw/net/can/xlnx-versal-canfd: refactor the banked
 registers logic
Date: Tue, 21 Oct 2025 22:46:35 +0200
Message-ID: <20251021204700.56072-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Luc Michel <luc.michel@amd.com>

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
Message-ID: <20251017161809.235740-6-luc.michel@amd.com>
[PMD: Have canfd_decode_reg_bank() take optional @idx, types fixups]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 150 ++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 99bbdd7d3fe..04f9a6d57d7 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1410,6 +1410,22 @@ static uint64_t canfd_srr_pre_write(RegisterInfo *reg, uint64_t val64)
     return s->regs[R_SOFTWARE_RESET_REGISTER];
 }
 
+static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
+                             unsigned bank_idx, uint32_t val)
+{
+    size_t reg_idx = addr / sizeof(uint32_t);
+
+    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] & (1 << bank_idx))) {
+        s->regs[reg_idx] = val;
+    } else {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter register 0x%"
+                      HWADDR_PRIx " changed while filter %u enabled\n",
+                      path, addr, bank_idx + 1);
+    }
+}
+
 static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
@@ -1763,9 +1779,135 @@ static void xlnx_versal_canfd_ptimer_cb(void *opaque)
     /* No action required on the timer rollover. */
 }
 
+static bool canfd_decode_reg_bank(XlnxVersalCANFDState *s, hwaddr addr,
+                                  hwaddr first_reg, hwaddr last_reg,
+                                  size_t num_banks, unsigned *idx,
+                                  hwaddr *offset)
+{
+    hwaddr base = addr - first_reg;
+    hwaddr span = last_reg - first_reg + sizeof(uint32_t);
+    unsigned index = base / span;
+
+    if (index >= num_banks) {
+        return false;
+    }
+    if (idx) {
+        *idx = index;
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
+                              unsigned *idx, hwaddr *offset)
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
+    hwaddr reg_offset;
+    uint64_t ret;
+
+    if (!canfd_decode_addr(s, addr, NULL, &reg_offset)) {
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
+    unsigned bank_idx;
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
@@ -2018,8 +2160,8 @@ static void canfd_init(Object *obj)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(obj);
 
-    memory_region_init(&s->iomem, obj, TYPE_XILINX_CANFD,
-                       XLNX_VERSAL_CANFD_R_MAX * 4);
+    memory_region_init_io(&s->iomem, obj, &canfd_ops, s, TYPE_XILINX_CANFD,
+                          XLNX_VERSAL_CANFD_R_MAX * 4);
 }
 
 static const VMStateDescription vmstate_canfd = {
-- 
2.51.0


