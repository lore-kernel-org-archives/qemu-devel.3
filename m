Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08F0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGE8-0005UD-RQ; Thu, 07 Mar 2024 11:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGE7-0005TZ-71
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGE5-0006NZ-FT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:10 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dcad814986so8823915ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827447; x=1710432247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrjPn4v+JMxdhMjAUatZPIMLuNqO+d8n4xVa7+AkjLA=;
 b=a7lRHN421jzhKViYwtPr2D5dTPzrI8JnJcE+cOLkdFPLatUWILYGYWHo4wZLCUmTxF
 GmYmqUiBxQh5ic2HSMJdEIw/1FM6zn40b8eHmUF+xtEjpPC9JR+RPdnyH8fXWKgGxjCA
 JywmCt+lUsDXMfgXGNRYOPghq9VW61kODzQralGKsAX2tLTCQxckUMlg/4XeY0YE05WB
 E3lWmMHN1BghxWEj2NmOOM745iaZoRT9qYf4isz/9o4RmNWuTzXoT83PPXFknZ4f9H8H
 LAlAGbwOQekM0UtD+HUMbyGegK5n8QYg0eYeQzmiFb72BB+V9jMBgZcCLlMgw/PLZYsV
 BHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827447; x=1710432247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrjPn4v+JMxdhMjAUatZPIMLuNqO+d8n4xVa7+AkjLA=;
 b=grlG8k2q8HOMmGrueGjqrJXMOqpwxriKPJm4cVntiNYUfFz/VeADBaISkmKfR60JkI
 6DTaiBpM3NGoMNxUMorLt/Cr2F+swtgEBJVLOugKdrR9IQ55iobZ/UwgET6w0brtisBR
 F04OrECm1rYh7HI9q4j59+jpWf6BvJX6fjUrZ7CDSO6XTzit8dMlM8wLe5FCLEXYU40u
 jeZHuxOrZhMDth1iyFB3jKkqD/OrPBzrAs8IHhATLAZIMyZLYPdgeJtErNesmOdkCGnH
 MQNH+5SmFum6/kiQws70/lDxHy7AY5DrW8xMPpsYewx08PENiPV9XelBjSNDtR6a9xeA
 bkCQ==
X-Gm-Message-State: AOJu0YwRhADXund78v7xGfs8qhuzV6z7gPNAqm9rNNbP94scvrRiPe2D
 NBQcYTjK4/3OL3dbs1lBw8XpILQxIwBLJaswDEsAPOnsR1SCeBWmewoyNKfnIPkkVrAU0SHiE1M
 i
X-Google-Smtp-Source: AGHT+IG8pVQ09YsIJZ1mR5WL74lYX/wlEfOVZa2g2WvwZ2SpfBF1HLp1YWffGFn0ef61R+FZ/T8ktg==
X-Received: by 2002:a17:902:d490:b0:1dd:2b94:17d3 with SMTP id
 c16-20020a170902d49000b001dd2b9417d3mr11783522plg.43.1709827446829; 
 Thu, 07 Mar 2024 08:04:06 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:04:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/15] hw/riscv/riscv-iommu: add DBG support
Date: Thu,  7 Mar 2024 13:03:14 -0300
Message-ID: <20240307160319.675044-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

DBG support adds three additional registers: tr_req_iova, tr_req_ctl and
tr_response.

The DBG cap is always enabled. No on/off toggle is provided for it.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h | 20 +++++++++++++
 hw/riscv/riscv-iommu.c      | 57 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 0994f5ce48..b3f92411bb 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -83,6 +83,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
+#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
 #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
 
@@ -177,6 +178,25 @@ enum {
     RISCV_IOMMU_INTR_COUNT
 };
 
+#define RISCV_IOMMU_IPSR_CIP            BIT(RISCV_IOMMU_INTR_CQ)
+#define RISCV_IOMMU_IPSR_FIP            BIT(RISCV_IOMMU_INTR_FQ)
+#define RISCV_IOMMU_IPSR_PMIP           BIT(RISCV_IOMMU_INTR_PM)
+#define RISCV_IOMMU_IPSR_PIP            BIT(RISCV_IOMMU_INTR_PQ)
+
+/* 5.24 Translation request IOVA (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
+
+/* 5.25 Translation request control (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
+#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
+#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
+
+/* 5.26 Translation request response (64bits) */
+#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
+#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
+#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
+
 /* 5.27 Interrupt cause to vector (64bits) */
 #define RISCV_IOMMU_REG_IVEC            0x02F8
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7af5929b10..1fa1286d07 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1457,6 +1457,46 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
 }
 
+static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
+{
+    uint64_t iova = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_IOVA);
+    uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
+    unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
+    unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
+    RISCVIOMMUContext *ctx;
+    void *ref;
+
+    if (!(ctrl & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY)) {
+        return;
+    }
+
+    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
+    if (ctx == NULL) {
+        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
+                                 RISCV_IOMMU_TR_RESPONSE_FAULT |
+                                 (RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED << 10));
+    } else {
+        IOMMUTLBEntry iotlb = {
+            .iova = iova,
+            .perm = IOMMU_NONE,
+            .addr_mask = ~0,
+            .target_as = NULL,
+        };
+        int fault = riscv_iommu_translate(s, ctx, &iotlb, false);
+        if (fault) {
+            iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
+        } else {
+            iova = ((iotlb.translated_addr & ~iotlb.addr_mask) >> 2) &
+                RISCV_IOMMU_TR_RESPONSE_PPN;
+        }
+        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
+    }
+
+    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
+        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+    riscv_iommu_ctx_put(s, ref);
+}
+
 /* Core IOMMU execution activation */
 enum {
     RISCV_IOMMU_EXEC_DDTP,
@@ -1502,7 +1542,7 @@ static void *riscv_iommu_core_proc(void* arg)
             /* NOP */
             break;
         case BIT(RISCV_IOMMU_EXEC_TR_REQUEST):
-            /* DBG support not implemented yet */
+            riscv_iommu_process_dbg(s);
             break;
         }
         exec &= ~mask;
@@ -1574,6 +1614,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
         exec = BIT(RISCV_IOMMU_EXEC_PQCSR);
         busy = RISCV_IOMMU_PQCSR_BUSY;
         break;
+
+    case RISCV_IOMMU_REG_TR_REQ_CTL:
+        exec = BIT(RISCV_IOMMU_EXEC_TR_REQUEST);
+        regb = RISCV_IOMMU_REG_TR_REQ_CTL;
+        busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
+        break;
     }
 
     /*
@@ -1746,6 +1792,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
+    /* Enable translation debug interface */
+    s->cap |= RISCV_IOMMU_CAP_DBG;
+
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -1800,6 +1849,12 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
     stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
     stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
+    /* If debug registers enabled. */
+    if (s->cap & RISCV_IOMMU_CAP_DBG) {
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_CTL],
+            RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+    }
 
     /* Memory region for downstream access, if specified. */
     if (s->target_mr) {
-- 
2.43.2


