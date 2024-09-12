Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6FEE644C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socQx-0006VG-BB; Thu, 12 Sep 2024 01:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQH-0003eC-68
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQF-00035K-3C
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7193010d386so14942b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119072; x=1726723872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7ulgV/0yhdaMUg8tOzbRsPvCYjJb8I3tzF5dANUGBA=;
 b=UVJx+1+0ZuYbxSl1r3TqglxbzTyqL24u1BZpjOaqmRUb7i2+gTIVEt7TnlCJPOVqlR
 L2IGck95KfGX52upsJ4Ng/Z72gUtCF2+PK2QuHvKTaaP9/04pM6gEYIv2y1Lxy2JMCJQ
 JvZcQZrj4ps2X4ksD0+QYMuoupmG+1JEPlcVuOXg0SSwJmsE+GfhsqjeLq2XlwqkGum8
 vjpp2EythPK92Gfr2z2jaXe4ScYQ37Qh3lWG+W4wPtmSdiFJhB5WqmlfHSVI8M3p/rtI
 Yon1SkY5ggiLSl4V7cMmdsiO401OnkNPz+aydMH+73U17EEpHPQ5yr76EHgsgwtpdKFf
 SI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119072; x=1726723872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7ulgV/0yhdaMUg8tOzbRsPvCYjJb8I3tzF5dANUGBA=;
 b=i7LS4833Wftte2sbw74lFVG36eQ7zqe2REcx/tRo/jA/lHAAq8RXkIug1wNaQfnDyD
 QYthg7nlRpicnyP6FTcnYSqcTb52ipiVJhoxJCM4X6LHKfJlKSNbnXF61pRsdIa3foAS
 XBTakbhLbrlDjpcthl4Yp5anm9COsKXXYL7ZMkoxiKWbxxLgxk3LWaUy826WCJsuGo7h
 6jmawWnhiCSGYOviMdXk2SDBW+yK6Bkt9GRjtM0l5hDDAU03olMb16umKZ99h5CXWURL
 S1dKzMVyhFo5fF2aJLNuMVU7ul8+8W5CQuFE79stXmv1xAvnf58K5CQAo6H5ZNABIQ/U
 plAA==
X-Gm-Message-State: AOJu0Yz7RqVdWvFIdtypwmL3GryN5R9/pYyqMow4Klhax8ZyBN5CwmXR
 swGqPLpY7xmswS/2FIzi6IJvJ1t1S3C0DAGY9dqmI4Q34X0+r2iDChH5GQ==
X-Google-Smtp-Source: AGHT+IHzBRYu2hGJ8CfGZx9UOtLNuldrBHc7EuWNHKAlQMqn6rO6/58YYq4cP7X24r5HjIOa6JZpUg==
X-Received: by 2002:a05:6a00:1953:b0:717:bce8:f8a9 with SMTP id
 d2e1a72fcca58-7192606086fmr2623640b3a.1.1726119071968; 
 Wed, 11 Sep 2024 22:31:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/47] hw/riscv/riscv-iommu: add DBG support
Date: Thu, 12 Sep 2024 15:29:28 +1000
Message-ID: <20240912052953.2552501-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

DBG support adds three additional registers: tr_req_iova, tr_req_ctl and
tr_response.

The DBG cap is always enabled. No on/off toggle is provided for it.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240903201633.93182-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


