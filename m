Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4175CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZxo-00064c-G8; Tue, 03 Sep 2024 16:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxn-00060X-BR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxl-0004Sw-Gf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2068bee21d8so370715ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725394636; x=1725999436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUTEWkc1hElLf+L1D5CIFRPB99zr1ONPfWusYPl18R4=;
 b=e3uYWGzDkkmTF+PoL1kntSXvHcqfrrmzryuZoi55VASrzhkrxZeBHh/71GamjBUBq7
 tmXYXJzngVXAaFWBhHEV2Nx/63wDrKaiVd5drJv9I9V8bc5c96kYCJ08Xm6fsUfMSGMc
 wZWtgF+vasNnN/KBndAHA+4shn0zdupNUoOIp8tqzIpIE6+CrLWHH+lkhAiG1OEVjuGR
 rqAZLb+DfO395uTFQymTBVq9MM3v/2h2N+qy/6+IVfBaENnNOKsqI76155eZ3avKlq76
 ETgZdkymc3EhymUAguPtNXcB6B9y7fUxgEDHyoWRI+A6M4aMbQGZc8feq0sDxEA+89DD
 n9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394636; x=1725999436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUTEWkc1hElLf+L1D5CIFRPB99zr1ONPfWusYPl18R4=;
 b=efwKM/UUB/C5Fs4zdbCYwvC67Xrr2rZuNor7O+F3B3+5qvZmAFKYRdr/HE0sTjPZSP
 525Uo6GOIz2DzA3yocuzaJJ1laIUa1fGUNNeT9tfQ3MlWerjEkPVSorR4Kr4MYkAOtNR
 5EZ/7OgLlcwtoEh0InxfSGvlxMHjDeVJ7h8+yKwADH8PKBxR+kd42+qCV6W//M4/Fyay
 Mq3+PpWEktyrtv7i0VqQ3OK/BBfwv3z6fKHXx8tXS3tubwa9Y16vMc7rtbIVlpXdQZLM
 XdzwhWhuu5TyK4abZRM7APW64jVEUw7Wdlx2y1/hfcsOCcaTME6ogeip4dcwZU6zU0Vm
 SYHw==
X-Gm-Message-State: AOJu0YzaaHB2xtvB+OTH0pvi+47hZCCr5eLjqYmRlYUmagGyDqRAKaMO
 +SC/md2p38XOF+1FStkRx7OIFTS6zNZzxHc4RGzIo5bP6ndKdcFKTq++TwHeq9CgkEmn4okKcLd
 G
X-Google-Smtp-Source: AGHT+IHm4D6muoCknMrfTpjuuLMyMHqIO5InfMr4lqEPwvnsKZ5Z+hLXaTFkwqpE+OwsRx4mwmS5CQ==
X-Received: by 2002:a17:902:ce05:b0:205:94df:e087 with SMTP id
 d9443c01a7336-20594dfe1bcmr69598775ad.9.1725394635935; 
 Tue, 03 Sep 2024 13:17:15 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea531b3sm2189745ad.216.2024.09.03.13.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:17:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 10/12] hw/riscv/riscv-iommu: add DBG support
Date: Tue,  3 Sep 2024 17:16:29 -0300
Message-ID: <20240903201633.93182-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903201633.93182-1-dbarboza@ventanamicro.com>
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 17 +++++++++++
 hw/riscv/riscv-iommu.c      | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 96a994b9aa..6359ae0353 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -82,6 +82,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
+#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
 #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
 #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
@@ -184,6 +185,22 @@ enum {
     RISCV_IOMMU_INTR_COUNT
 };
 
+/* 5.24 Translation request IOVA (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
+
+/* 5.25 Translation request control (64bits) */
+#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
+#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
+#define RISCV_IOMMU_TR_REQ_CTL_NW       BIT_ULL(3)
+#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
+
+/* 5.26 Translation request response (64bits) */
+#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
+#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
+#define RISCV_IOMMU_TR_RESPONSE_S       BIT_ULL(9)
+#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
+
 /* 5.27 Interrupt cause to vector (64bits) */
 #define RISCV_IOMMU_REG_ICVEC           0x02F8
 #define RISCV_IOMMU_ICVEC_CIV           GENMASK_ULL(3, 0)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 50740442bb..135f461ccf 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1769,6 +1769,50 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
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
+            .perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMMU_RW,
+            .addr_mask = ~0,
+            .target_as = NULL,
+        };
+        int fault = riscv_iommu_translate(s, ctx, &iotlb, false);
+        if (fault) {
+            iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
+        } else {
+            iova = iotlb.translated_addr & ~iotlb.addr_mask;
+            iova >>= TARGET_PAGE_BITS;
+            iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
+
+            /* We do not support superpages (> 4kbs) for now */
+            iova &= ~RISCV_IOMMU_TR_RESPONSE_S;
+        }
+        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
+    }
+
+    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
+        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+    riscv_iommu_ctx_put(s, ref);
+}
+
 typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
 
 static void riscv_iommu_update_icvec(RISCVIOMMUState *s, uint64_t data)
@@ -1922,6 +1966,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
 
         return MEMTX_OK;
 
+    case RISCV_IOMMU_REG_TR_REQ_CTL:
+        process_fn = riscv_iommu_process_dbg;
+        regb = RISCV_IOMMU_REG_TR_REQ_CTL;
+        busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
+        break;
+
     default:
         break;
     }
@@ -2094,6 +2144,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
+    /* Enable translation debug interface */
+    s->cap |= RISCV_IOMMU_CAP_DBG;
+
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -2150,6 +2203,12 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
     stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
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
2.45.2


