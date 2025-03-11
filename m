Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12D0C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzF3-00060f-A0; Tue, 11 Mar 2025 09:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDX-0004bJ-DJ; Tue, 11 Mar 2025 09:00:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDM-00086E-2A; Tue, 11 Mar 2025 09:00:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so10792074a91.3; 
 Tue, 11 Mar 2025 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698002; x=1742302802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=by3/ZI8Vkw6A3nNqZvSfEcf780vJNiwWvMG40uDK0x8=;
 b=FkTHtluBCmu8Fb+XRMfU9juHCRqhUDEBTrsn2JWTE1mVdAmyN5VcQmM+3TFrKFxIq7
 Me4rsZshA3f7ShH9XlRzbsrMXszrNCUZUxxw8i4swBWeqE27O5RV4hB8J3wRBUaEhoT7
 ONmj7MyDuUGP9AQSO5Wykkqn6mA9IF9NmVLJ5nhbM62lqZ3c5gqlIrdbTKndQMBqdjK1
 FKbJ0nMDF7m9qygKdn3tmpqzWB6A0KGWCfn9E4Nl0k88W/dsao2CwHj+ts8KLEi52/NC
 PbNQGyQwbvYEvsyFAaMKsmkzewTSzJb8sb0QUSE1lAObc3EbU+sxN1tgd4JflcF8kKWh
 wSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698002; x=1742302802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=by3/ZI8Vkw6A3nNqZvSfEcf780vJNiwWvMG40uDK0x8=;
 b=vsEO1UXtQddw3YR4azBN0beCY+UZFtdFQdKWLxstuR2LvMpuQP9xlvkhGyUjMM3pwk
 ACSzI8V68XJZ8Pgs5DI+kRonPd8zJMdltraMxpc7BvrHXeZC1U0a0uLx//Gf2z9EQYEN
 gsf5h80Vu5krhsIzFZ0oHLNy2T8g4yJqqbBs7BN3Rz2ftocNGbXc9eEytNP8BcBgRGS1
 L6Xku3zQp8BrTfrAS7WyN7KJl3I+pqueE6Br3CEmK3b32MqF29hYSR7bJ0uEnRJX4fqT
 AAlAhwWcxjGEMERtVPLGrRX09ttC0fzmiTKHcRH1C4Xvb4gXN3T3qDSY8RvTk+K09F10
 qgLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEYKBSUpWfLL9l6T/DYrgj33T4DclM4LxCaNb8WpMAsra1jVLCP6ztgAh9MDVHfaBSr0gyJM1vyg==@nongnu.org
X-Gm-Message-State: AOJu0YxewOb21H9pW7dgIocBZYqjcGuBDVXJhtk4Zf+AReShSblw9WiD
 Mwa5+iSlIf5N1WWTdGQjZJDrfH1WODV4reibBzFbVkoRaCtVmmcNhM6vzg==
X-Gm-Gg: ASbGncsNj0F1rf7mSXnHyCjj8rNhV87v8ucYAbiig888rifEi997ISv2MKehOFULyoe
 63BPzhfPG8RQybeMFzl7kBX/340MOozNCEVk5IhOkmQhnnKZb0isruHqBhH10s9BS6t1/T/PsDK
 u2IbfH1E7G+ASdlYMxLiRur/hwjD9ZEsJHVHIYOk6pLqk82jXPFV14hkOoIfEXiO3u9rB2ozoCr
 U+UIcwSVj7pprNzzipd0UhFLYrDtUyBvsqkc/h0mdiBX+6OYpyBR2dzQ+knao9UyTL/wa4LOMjr
 O5E/qkqU0GCXVNe2N2jerYRxbMf8NASyu9FCif7CHO/pGyT6ZEqUGmjQ7eAc2w==
X-Google-Smtp-Source: AGHT+IFFev1f83NDL/uuWb5ctq6PRHelu6ZBjZNhO9IoU+0pOqaK1j1KPPfzBSRu9zdhHzFS5zLy1A==
X-Received: by 2002:a17:90b:3849:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2ff7ce9114dmr26940394a91.10.1741698002458; 
 Tue, 11 Mar 2025 06:00:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 31/72] ppc/xive2: Add support for MMIO operations on the
 NVPG/NVC BAR
Date: Tue, 11 Mar 2025 22:57:25 +1000
Message-ID: <20250311125815.903177-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Add support for the NVPG and NVC BARs.  Access to the BAR pages will
cause backlog counter operations to either increment or decriment
the counter.

Also added qtests for the same.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c              |  80 +++++++++++++---
 hw/intc/trace-events             |   4 +
 hw/intc/xive2.c                  |  87 ++++++++++++++++++
 include/hw/ppc/xive2.h           |   9 ++
 include/hw/ppc/xive2_regs.h      |   3 +
 tests/qtest/meson.build          |   3 +-
 tests/qtest/pnv-xive2-common.h   |   1 +
 tests/qtest/pnv-xive2-nvpg_bar.c | 153 +++++++++++++++++++++++++++++++
 tests/qtest/pnv-xive2-test.c     |   3 +
 9 files changed, 328 insertions(+), 15 deletions(-)
 create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e7a7d1b50f..c55d596e48 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2202,21 +2202,40 @@ static const MemoryRegionOps pnv_xive2_tm_ops = {
     },
 };
 
-static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr offset,
+static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr addr,
                                    unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVC: invalid read @%"HWADDR_PRIx, offset);
-    return -1;
+    if (size != 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc load size %d\n",
+                      size);
+        return -1;
+    }
+
+    return xive2_presenter_nvgc_backlog_op(xptr, true, blk, page, op, 1);
 }
 
-static void pnv_xive2_nvc_write(void *opaque, hwaddr offset,
+static void pnv_xive2_nvc_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvc_shift;
+    uint16_t op = addr & 0xFFF;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVC: invalid write @%"HWADDR_PRIx, offset);
+    if (size != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc write size %d\n",
+                      size);
+        return;
+    }
+
+    (void)xive2_presenter_nvgc_backlog_op(xptr, true, blk, page, op, val);
 }
 
 static const MemoryRegionOps pnv_xive2_nvc_ops = {
@@ -2224,30 +2243,63 @@ static const MemoryRegionOps pnv_xive2_nvc_ops = {
     .write = pnv_xive2_nvc_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
 
-static uint64_t pnv_xive2_nvpg_read(void *opaque, hwaddr offset,
+static uint64_t pnv_xive2_nvpg_read(void *opaque, hwaddr addr,
                                     unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint32_t index = page >> 1;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVPG: invalid read @%"HWADDR_PRIx, offset);
-    return -1;
+    if (size != 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvpg load size %d\n",
+                      size);
+        return -1;
+    }
+
+    if (page % 2) {
+        /* odd page - NVG */
+        return xive2_presenter_nvgc_backlog_op(xptr, false, blk, index, op, 1);
+    } else {
+        /* even page - NVP */
+        return xive2_presenter_nvp_backlog_op(xptr, blk, index, op);
+    }
 }
 
-static void pnv_xive2_nvpg_write(void *opaque, hwaddr offset,
+static void pnv_xive2_nvpg_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint32_t index = page >> 1;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVPG: invalid write @%"HWADDR_PRIx, offset);
+    if (size != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvpg write size %d\n",
+                      size);
+        return;
+    }
+
+    if (page % 2) {
+        /* odd page - NVG */
+        (void)xive2_presenter_nvgc_backlog_op(xptr, false, blk, index, op, val);
+    } else {
+        /* even page - NVP */
+        (void)xive2_presenter_nvp_backlog_op(xptr, blk, index, op);
+    }
 }
 
 static const MemoryRegionOps pnv_xive2_nvpg_ops = {
@@ -2255,11 +2307,11 @@ static const MemoryRegionOps pnv_xive2_nvpg_ops = {
     .write = pnv_xive2_nvpg_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index e9fe1978f9..0ba9a02e73 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -286,6 +286,10 @@ xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t v
 xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring, uint8_t group_level) "found NVT 0x%x/0x%x ring=0x%x group_level=%d"
 xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
 
+# xive2.c
+xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint8_t rc) "NVP 0x%x/0x%x operation=%d priority=%d rc=%d"
+xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
+
 # pnv_xive.c
 pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 017c0f8bb4..34628f2922 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -88,6 +88,93 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
     }
 }
 
+uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
+                                         bool crowd,
+                                         uint8_t blk, uint32_t idx,
+                                         uint16_t offset, uint16_t val)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t priority = GETFIELD(NVx_BACKLOG_PRIO, offset);
+    uint8_t op = GETFIELD(NVx_BACKLOG_OP, offset);
+    Xive2Nvgc nvgc;
+    uint32_t count, old_count;
+
+    if (xive2_router_get_nvgc(xrtr, crowd, blk, idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No %s %x/%x\n",
+                      crowd ? "NVC" : "NVG", blk, idx);
+        return -1;
+    }
+    if (!xive2_nvgc_is_valid(&nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n", blk, idx);
+        return -1;
+    }
+
+    old_count = xive2_nvgc_get_backlog(&nvgc, priority);
+    count = old_count;
+    /*
+     * op:
+     * 0b00 => increment
+     * 0b01 => decrement
+     * 0b1- => read
+     */
+    if (op == 0b00 || op == 0b01) {
+        if (op == 0b00) {
+            count += val;
+        } else {
+            if (count > val) {
+                count -= val;
+            } else {
+                count = 0;
+            }
+        }
+        xive2_nvgc_set_backlog(&nvgc, priority, count);
+        xive2_router_write_nvgc(xrtr, crowd, blk, idx, &nvgc);
+    }
+    trace_xive_nvgc_backlog_op(crowd, blk, idx, op, priority, old_count);
+    return old_count;
+}
+
+uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
+                                        uint8_t blk, uint32_t idx,
+                                        uint16_t offset)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t priority = GETFIELD(NVx_BACKLOG_PRIO, offset);
+    uint8_t op = GETFIELD(NVx_BACKLOG_OP, offset);
+    Xive2Nvp nvp;
+    uint8_t ipb, old_ipb, rc;
+
+    if (xive2_router_get_nvp(xrtr, blk, idx, &nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n", blk, idx);
+        return -1;
+    }
+    if (!xive2_nvp_is_valid(&nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVP %x/%x\n", blk, idx);
+        return -1;
+    }
+
+    old_ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
+    ipb = old_ipb;
+    /*
+     * op:
+     * 0b00 => set priority bit
+     * 0b01 => reset priority bit
+     * 0b1- => read
+     */
+    if (op == 0b00 || op == 0b01) {
+        if (op == 0b00) {
+            ipb |= xive_priority_to_ipb(priority);
+        } else {
+            ipb &= ~xive_priority_to_ipb(priority);
+        }
+        nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
+        xive2_router_write_nvp(xrtr, blk, idx, &nvp, 2);
+    }
+    rc = !!(old_ipb & xive_priority_to_ipb(priority));
+    trace_xive_nvp_backlog_op(blk, idx, op, priority, rc);
+    return rc;
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index fc7422fea7..c07e23e1d3 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -90,6 +90,15 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t nvt_blk, uint32_t nvt_idx,
                                bool cam_ignore, uint32_t logic_serv);
 
+uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
+                                        uint8_t blk, uint32_t idx,
+                                        uint16_t offset);
+
+uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
+                                         bool crowd,
+                                         uint8_t blk, uint32_t idx,
+                                         uint16_t offset, uint16_t val);
+
 /*
  * XIVE2 END ESBs  (POWER10)
  */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index e88d6eab1e..9bcf7a8a6f 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -233,4 +233,7 @@ typedef struct Xive2Nvgc {
 void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
                                GString *buf);
 
+#define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
+#define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
+
 #endif /* PPC_XIVE2_REGS_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b23fe67db7..3ecb23e610 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -368,7 +368,8 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
-  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
+  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
+                          'pnv-xive2-nvpg_bar.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 9ae34771aa..2077c05ebc 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -107,5 +107,6 @@ extern void set_end(QTestState *qts, uint32_t index, uint32_t nvp_index,
 
 
 void test_flush_sync_inject(QTestState *qts);
+void test_nvpg_bar(QTestState *qts);
 
 #endif /* TEST_PNV_XIVE2_COMMON_H */
diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvpg_bar.c
new file mode 100644
index 0000000000..028512bddc
--- /dev/null
+++ b/tests/qtest/pnv-xive2-nvpg_bar.c
@@ -0,0 +1,153 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *  - Test NVPG BAR MMIO operations
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "pnv-xive2-common.h"
+
+#define NVPG_BACKLOG_OP_SHIFT   10
+#define NVPG_BACKLOG_PRIO_SHIFT 4
+
+#define XIVE_PRIORITY_MAX       7
+
+enum NVx {
+    NVP,
+    NVG,
+    NVC
+};
+
+typedef enum {
+    INCR_STORE = 0b100,
+    INCR_LOAD  = 0b000,
+    DECR_STORE = 0b101,
+    DECR_LOAD  = 0b001,
+    READ_x     = 0b010,
+    READ_y     = 0b011,
+} backlog_op;
+
+static uint32_t nvpg_backlog_op(QTestState *qts, backlog_op op,
+                                enum NVx type, uint64_t index,
+                                uint8_t priority, uint8_t delta)
+{
+    uint64_t addr, offset;
+    uint32_t count = 0;
+
+    switch (type) {
+    case NVP:
+        addr = XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
+        break;
+    case NVG:
+        addr = XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1)) +
+            (1 << XIVE_PAGE_SHIFT);
+        break;
+    case NVC:
+        addr = XIVE_NVC_ADDR + (index << XIVE_PAGE_SHIFT);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    offset = (op & 0b11) << NVPG_BACKLOG_OP_SHIFT;
+    offset |= priority << NVPG_BACKLOG_PRIO_SHIFT;
+    if (op >> 2) {
+        qtest_writeb(qts, addr + offset, delta);
+    } else {
+        count = qtest_readw(qts, addr + offset);
+    }
+    return count;
+}
+
+void test_nvpg_bar(QTestState *qts)
+{
+    uint32_t nvp_target = 0x11;
+    uint32_t group_target = 0x17; /* size 16 */
+    uint32_t vp_irq = 33, group_irq = 47;
+    uint32_t vp_end = 3, group_end = 97;
+    uint32_t vp_irq_data = 0x33333333;
+    uint32_t group_irq_data = 0x66666666;
+    uint8_t vp_priority = 0, group_priority = 5;
+    uint32_t vp_count[XIVE_PRIORITY_MAX + 1] = { 0 };
+    uint32_t group_count[XIVE_PRIORITY_MAX + 1] = { 0 };
+    uint32_t count, delta;
+    uint8_t i;
+
+    printf("# ============================================================\n");
+    printf("# Testing NVPG BAR operations\n");
+
+    set_nvg(qts, group_target, 0);
+    set_nvp(qts, nvp_target, 0x04);
+    set_nvp(qts, group_target, 0x04);
+
+    /*
+     * Setup: trigger a VP-specific interrupt and a group interrupt
+     * so that the backlog counters are initialized to something else
+     * than 0 for at least one priority level
+     */
+    set_eas(qts, vp_irq, vp_end, vp_irq_data);
+    set_end(qts, vp_end, nvp_target, vp_priority, false /* group */);
+
+    set_eas(qts, group_irq, group_end, group_irq_data);
+    set_end(qts, group_end, group_target, group_priority, true /* group */);
+
+    get_esb(qts, vp_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, vp_irq, XIVE_TRIGGER_PAGE, 0, 0);
+    vp_count[vp_priority]++;
+
+    get_esb(qts, group_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, group_irq, XIVE_TRIGGER_PAGE, 0, 0);
+    group_count[group_priority]++;
+
+    /* check the initial counters */
+    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
+        count = nvpg_backlog_op(qts, READ_x, NVP, nvp_target, i, 0);
+        g_assert_cmpuint(count, ==, vp_count[i]);
+
+        count = nvpg_backlog_op(qts, READ_y, NVG, group_target, i, 0);
+        g_assert_cmpuint(count, ==, group_count[i]);
+    }
+
+    /* do a few ops on the VP. Counter can only be 0 and 1 */
+    vp_priority = 2;
+    delta = 7;
+    nvpg_backlog_op(qts, INCR_STORE, NVP, nvp_target, vp_priority, delta);
+    vp_count[vp_priority] = 1;
+    count = nvpg_backlog_op(qts, INCR_LOAD, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+    count = nvpg_backlog_op(qts, READ_y, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+
+    count = nvpg_backlog_op(qts, DECR_LOAD, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+    vp_count[vp_priority] = 0;
+    nvpg_backlog_op(qts, DECR_STORE, NVP, nvp_target, vp_priority, delta);
+    count = nvpg_backlog_op(qts, READ_x, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+
+    /* do a few ops on the group */
+    group_priority = 2;
+    delta = 9;
+    /* can't go negative */
+    nvpg_backlog_op(qts, DECR_STORE, NVG, group_target, group_priority, delta);
+    count = nvpg_backlog_op(qts, READ_y, NVG, group_target, group_priority, 0);
+    g_assert_cmpuint(count, ==, 0);
+    nvpg_backlog_op(qts, INCR_STORE, NVG, group_target, group_priority, delta);
+    group_count[group_priority] += delta;
+    count = nvpg_backlog_op(qts, INCR_LOAD, NVG, group_target,
+                            group_priority, delta);
+    g_assert_cmpuint(count, ==, group_count[group_priority]);
+    group_count[group_priority]++;
+
+    count = nvpg_backlog_op(qts, DECR_LOAD, NVG, group_target,
+                            group_priority, delta);
+    g_assert_cmpuint(count, ==,  group_count[group_priority]);
+    group_count[group_priority]--;
+    count = nvpg_backlog_op(qts, READ_x, NVG, group_target, group_priority, 0);
+    g_assert_cmpuint(count, ==, group_count[group_priority]);
+}
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index a4d06550ee..a0e9f19313 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -493,6 +493,9 @@ static void test_xive(void)
     reset_state(qts);
     test_flush_sync_inject(qts);
 
+    reset_state(qts);
+    test_nvpg_bar(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.47.1


