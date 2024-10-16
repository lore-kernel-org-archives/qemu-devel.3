Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39345D206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Api-0004Xt-13; Wed, 16 Oct 2024 16:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Apg-0004Vy-Lv
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Apd-0004h4-Gh
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:24 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso158043a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729111279; x=1729716079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWEKI+zZUZv2TI8aBcMqPBnyT//ildbsOIVr0rGHQtQ=;
 b=acnhsM4D2VcguqDmfsMWJFr/4RFQo6TU+IvXKkLH0VVlhK19hcxPmxGOYJNcScAAZS
 8vcYfvZROWPMfspU5nQ1gKV2YbQvf+dwlxJXp421YVZASggQo7BLR+lWkEeycMKlcyMF
 MZmBRlZePjeqEqWX4btFv1qEFfc2pl59ySnPQr/1K16ktMA7Yw/4bDKHU1jqcywfml7r
 2nHqqjletEqULfQV/As7UTUUhB+JGhQaKGqxcYs8C3/sM8d28Z48ruL2LFlcK4+ZTHqQ
 UJnuYfIuIKgJEfFX+/kLH77qBH8m8BCqEDnUMi97tClBLAyrIvPk/wjuDMhjTCpqgeuy
 pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729111279; x=1729716079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWEKI+zZUZv2TI8aBcMqPBnyT//ildbsOIVr0rGHQtQ=;
 b=Hf3mqxqjOwbxoZq3rtr3wm7RYBVwg6zbS5DMKCOFXbfOxwOJBsjiHLapb/kcQ8p51f
 JcsuraEAJ5s6eym2X0sG7JzQ/v/2sTpMaMuQwCoscWl9bxeSDPmDDs1bf78v1MQZkBjF
 tzu3/DSMrBNxzdKPXUDFpFh7hG3IZZQGeGacqbM5WbtOhgryOeTRPeLK6n+p0CwA4aRc
 7Sg9Hlyh7FuHKRvLTHKbGWfXzzAF8YyeGKtP7u8Pio6oJh6Mc7TFmEBMyuN8oV6qt9Ub
 fEbc/DDBhJl31rbyBLMX8d29rr+7DqcHGPihy5HzlaWRIMP8cU+WTZ/EpihQKnS3iVGn
 WaDw==
X-Gm-Message-State: AOJu0Yyuz5Ue1S8jicTUCaBeNLWs2Ntv0GO5nFUOEzyW5hxnvgWQqpaY
 L8NKlI09x9T5ZtKj3FA3PmW/irgqNPa8PwpAfY1OUcVDQHamfKXHXCKjUelYlhKkk6OKfzeMBhY
 i
X-Google-Smtp-Source: AGHT+IFNUHbMjjtGFGVjWXuWFkywtCMigxKUqqWf9pAcrtnZVjnm545OmhJbypJNKrQm4aB6LDlLyw==
X-Received: by 2002:a17:90b:4a81:b0:2e2:b3f8:b549 with SMTP id
 98e67ed59e1d1-2e3ab821750mr5869353a91.23.1729111278869; 
 Wed, 16 Oct 2024 13:41:18 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e09085cfsm242158a91.54.2024.10.16.13.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:41:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 10/12] hw/riscv/riscv-iommu: add DBG support
Date: Wed, 16 Oct 2024 17:40:34 -0300
Message-ID: <20241016204038.649340-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016204038.649340-1-dbarboza@ventanamicro.com>
References: <20241016204038.649340-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 1a8da005c0..feb650549a 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1764,6 +1764,50 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
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
@@ -1928,6 +1972,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
 
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
@@ -2065,6 +2115,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
+    /* Enable translation debug interface */
+    s->cap |= RISCV_IOMMU_CAP_DBG;
+
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -2121,6 +2174,12 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
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


