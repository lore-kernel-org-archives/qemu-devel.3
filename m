Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC1CE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEO-00064m-DH; Thu, 19 Dec 2024 20:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEM-00063X-RI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEL-0004Ca-2U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:06 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso1182271b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659703; x=1735264503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqX4t4W+sF7YgqE2uzUJNl59paoesC5M/4gUQM7L+H8=;
 b=ICzk282cQB67Rq83nz2n0Oo7h26R3bO6DmLrXUfZnBksf7KlLk679I9u21HK/E1D4i
 3zhjhnsMMpCgIndmA9ikSWMZepHNT9ax9kXJ8etqoxAbz5zfxbfD3mUFqKtGol+gbLBt
 zRhQkRNBlLeTYxQyqhZMwgt9eqac+zTtCoQQjYzhgdW8iqdlRLSBLD4HVIkfIYG5aSjx
 ZmPOHm3QY4rlJ50oTwtxUe9D00HgzVnWNN7dTlHbL7ltT6+Tvh99yxWDBsRer33vdIEE
 vAT3H55wr084WWtSlLMVwQ5IA7VIKJ2Xm4EaKA3TH3RrAi2gLnoRxS25U1tGSB2NmOM5
 r43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659703; x=1735264503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqX4t4W+sF7YgqE2uzUJNl59paoesC5M/4gUQM7L+H8=;
 b=oqEx2oGnhdhZFSBP6do7P1RETceAZ+afnPT44PiM4Dopt/xdmEfKeWtKwd8xJLtWp/
 t/i9WamnQ/PXx89pYoLLjfH7BkKhAbdoI+cvw9So6qmF+r+IT0Gm1yILCSbtspHfPeB5
 sBDr+KU2IKN+4QFHNtswNR+KpJelBDL4W8g3/B1M58t7hYfBKrqMBKU/VUCfw2wvRies
 Vfm6td1A4tEbJRc1Bfb3HM4TRBBBKNeHDnh/xm/ouOLOe9mk+qVtzjqdMCjqov0N5dFy
 RR9nEXivj+yx6UU0eAgJwAD4DS135agEIeK9XIsTRfL2lgkHd9XKbKnyRV/fNBCCyfJM
 hopw==
X-Gm-Message-State: AOJu0YxEjjR9yXbVhdvKnSEjmj7p0OPa9hawaZX4EBpMX0nXHCn9bEtU
 aRjjUAgSeNxwdakuqKfzwDdkS4PVELy9KHfhWyDeN4TWzZKSiN83eoxvNvhl
X-Gm-Gg: ASbGncvwtJFIw8I0P2z4qlXJ4aEWkgr2eNAwj4C89/piSO+VLlyj4QdTVF4UO6ZQVwf
 VN4WgLkLMUdDs5t0+gv1zwgZl0cG+5jeHS7U3Sod9Kqkc5fGG0JGVePlFCGQPfrv/UPoDpg7U01
 USHTDSauAUvW6g77rW4IKS9+5mELLZWipWXkqCiC66PSjG1WG2x09cPI8ESxyolAj7idUb73F3D
 +DMw/49oiKwCH+v8UJu6CfZzWy10mhxILPHTNJxU+x5N+aEwnpL5DcPxBF3mGzB425QXFw/Ngz7
 yeBNf2e83WJx96ZKLk/ZKwF9axnfUGM2afii31jY1mhleYIwL3CcD5qZMBS65pU=
X-Google-Smtp-Source: AGHT+IFEodT7LG+6ktjcVqVPWBoZlYvUpRohHV4gRdy4rW+htWYXi9ZAnDwCHtNaVQp9TBpq7aKOnQ==
X-Received: by 2002:a05:6a21:101a:b0:1e1:94a2:275c with SMTP id
 adf61e73a8af0-1e5e046565bmr2241973637.18.1734659703352; 
 Thu, 19 Dec 2024 17:55:03 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/39] hw/riscv/riscv-iommu.c: add
 riscv_iommu_instance_init()
Date: Fri, 20 Dec 2024 11:54:03 +1000
Message-ID: <20241220015441.317236-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Move all the static initializion of the device to an init() function,
leaving only the dynamic initialization to be done during realize.

With this change s->cap is initialized with RISCV_IOMMU_CAP_DBG during
init(), and realize() will increment s->cap with the extra caps.

This will allow callers to add IOMMU capabilities before the
realization.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 71 +++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b6b9477129..c461ebbd87 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2130,11 +2130,48 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     }
 };
 
+static void riscv_iommu_instance_init(Object *obj)
+{
+    RISCVIOMMUState *s = RISCV_IOMMU(obj);
+
+    /* Enable translation debug interface */
+    s->cap = RISCV_IOMMU_CAP_DBG;
+
+    /* Report QEMU target physical address space limits */
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
+                       TARGET_PHYS_ADDR_SPACE_BITS);
+
+    /* TODO: method to report supported PID bits */
+    s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
+    s->cap |= RISCV_IOMMU_CAP_PD8;
+
+    /* register storage */
+    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+
+     /* Mark all registers read-only */
+    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
+
+    /* Device translation context cache */
+    s->ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
+                                         riscv_iommu_ctx_equal,
+                                         g_free, NULL);
+
+    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                         riscv_iommu_iot_equal,
+                                         g_free, NULL);
+
+    s->iommus.le_next = NULL;
+    s->iommus.le_prev = NULL;
+    QLIST_INIT(&s->spaces);
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
-    s->cap = s->version & RISCV_IOMMU_CAP_VERSION;
+    s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
@@ -2149,29 +2186,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
-    /* Enable translation debug interface */
-    s->cap |= RISCV_IOMMU_CAP_DBG;
-
-    /* Report QEMU target physical address space limits */
-    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
-
-    /* TODO: method to report supported PID bits */
-    s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
-    s->cap |= RISCV_IOMMU_CAP_PD8;
 
     /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
     s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
                         RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
 
-    /* register storage */
-    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-
-     /* Mark all registers read-only */
-    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
-
     /*
      * Register complete MMIO space, including MSI/PBA registers.
      * Note, PCIDevice implementation will add overlapping MR for MSI/PBA,
@@ -2229,19 +2248,6 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
             "riscv-iommu-trap", ~0ULL);
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
-
-    /* Device translation context cache */
-    s->ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
-                                         riscv_iommu_ctx_equal,
-                                         g_free, NULL);
-
-    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
-                                         riscv_iommu_iot_equal,
-                                         g_free, NULL);
-
-    s->iommus.le_next = NULL;
-    s->iommus.le_prev = NULL;
-    QLIST_INIT(&s->spaces);
 }
 
 static void riscv_iommu_unrealize(DeviceState *dev)
@@ -2283,6 +2289,7 @@ static const TypeInfo riscv_iommu_info = {
     .name = TYPE_RISCV_IOMMU,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
+    .instance_init = riscv_iommu_instance_init,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.47.1


