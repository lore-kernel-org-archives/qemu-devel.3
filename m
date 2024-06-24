Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB11C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqA0-0004hQ-Od; Mon, 24 Jun 2024 16:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9y-0004cz-Q7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9w-0003j4-JJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:30 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-713fa1aea36so2178722a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260367; x=1719865167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQ4FlhY3/Lu4bLgHs+WzO5Cge8pPMqoPtiJNS+XGSKc=;
 b=Pq1UFunKXw3Rdp5xrRXzM1XTF03TPrxEthrvYinXBYpUrV55qjpqxeXeoTcEnsjwGO
 XMFNUinxMlr1FnLUwBhqDKJJk5LmbpG0gzw07GFSjrGeqIR4VutT/0zU6gABWtKgY0D4
 0E5Z3Hba+PcxtbsN7MEAV3e2EJGsUL1h3IR/37ngqVFjjCqQ4jyqxUF+rf31NawzW68g
 wmj+15KWAB6BP10CSB3WADar2Yfbeu/Op+HBhalxf9/aXYSf1IjBuHuCCB5g7UoRXUX1
 fn+ZAOdurv7xsEBhnC4eAPv7rlfgER+Tw/VusFh3tLmcLaXYIb31vCBLM5+1mRyd7r/M
 q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260367; x=1719865167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQ4FlhY3/Lu4bLgHs+WzO5Cge8pPMqoPtiJNS+XGSKc=;
 b=mkAqlYOGPhpKcG616dZ6OjQb9CCKpzfV9MKMZnO9HHL0AOSMu0qJOJAqLu9RBJRcPp
 YnYWxJMJOpTYL7NfT1DspVOr4LfG5TwPspgu55gPVntVRRlqcD12VcrzvubNSAeFvbSK
 ldK7YBRne3rC15LTbelDU19whmTM5xif5V/c8C6qknHOIgWyZidZktQlQ1cFU0luo7xv
 wM3nkCX8SwELtgP57qQZE59Ep1Yt73s7tAdVvcMtHN3CpRELDn4jGLIXAi24K60VYGu/
 TBtC8jX8GgYfHS0/O8yDTn7hnLtVdtgt6pD/7iNOt/X6/hg7vaiV+/ULqAYcwk+MgGRh
 qqsw==
X-Gm-Message-State: AOJu0YxVU8VcFEhsl8Yvd2iaH3a3N1Afpq3mrgtL4GFilrpZ8oSlYSq9
 CMGMdoNJnrCyqljzegGKVPoHZd3HlkVrX4fsIJFOB70a8MGosXQxunUsNGWKqB/ACK2qSFYXRUM
 d
X-Google-Smtp-Source: AGHT+IH3x/cHqcNFHyqJd/XmuKUxjeyzuqmgxEEWLiBhNKHIjcBMLEPBh6HeJuSe1RcxjqbJ6OH6vQ==
X-Received: by 2002:a05:6a21:9993:b0:1af:7646:fc14 with SMTP id
 adf61e73a8af0-1bcedf7f493mr7040285637.0.1719260366860; 
 Mon, 24 Jun 2024 13:19:26 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:19:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 10/14] hw/riscv/riscv-iommu: add ATS support
Date: Mon, 24 Jun 2024 17:18:20 -0300
Message-ID: <20240624201825.1054980-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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

Add PCIe Address Translation Services (ATS) capabilities to the IOMMU.
This will add support for ATS translation requests in Fault/Event
queues, Page-request queue and IOATC invalidations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu-bits.h |  43 +++++++++++-
 hw/riscv/riscv-iommu.c      | 129 +++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h      |   1 +
 hw/riscv/trace-events       |   3 +
 4 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 75b431fed0..c61207e618 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -81,6 +81,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
@@ -210,6 +211,7 @@ struct riscv_iommu_dc {
 
 /* Translation control fields */
 #define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
+#define RISCV_IOMMU_DC_TC_EN_ATS        BIT_ULL(1)
 #define RISCV_IOMMU_DC_TC_EN_PRI        BIT_ULL(2)
 #define RISCV_IOMMU_DC_TC_T2GPA         BIT_ULL(3)
 #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
@@ -271,6 +273,20 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
 #define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
 
+/* 3.1.4 I/O MMU PCIe ATS */
+#define RISCV_IOMMU_CMD_ATS_OPCODE              4
+#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL          0
+#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR           1
+#define RISCV_IOMMU_CMD_ATS_PID         GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_CMD_ATS_PV          BIT_ULL(32)
+#define RISCV_IOMMU_CMD_ATS_DSV         BIT_ULL(33)
+#define RISCV_IOMMU_CMD_ATS_RID         GENMASK_ULL(55, 40)
+#define RISCV_IOMMU_CMD_ATS_DSEG        GENMASK_ULL(63, 56)
+/* dword1 is the ATS payload, two different payload types for INVAL and PRGR */
+
+/* ATS.PRGR payload */
+#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE      GENMASK_ULL(47, 44)
+
 enum riscv_iommu_dc_fsc_atp_modes {
     RISCV_IOMMU_DC_FSC_MODE_BARE = 0,
     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 = 8,
@@ -337,7 +353,32 @@ enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
     RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
     RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
-    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 8,
+    RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ = 8,
+    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
+};
+
+/* Header fields */
+#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
+#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
+#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
+#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+
+/* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
+#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
+#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
+#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
+#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
+
+
+/*
+ * struct riscv_iommu_msi_pte - MSI Page Table Entry
+ */
+struct riscv_iommu_msi_pte {
+      uint64_t pte;
+      uint64_t mrif_info;
 };
 
 /* Fields on pte */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index fd5b5ab50d..b20a09df2a 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -641,6 +641,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
                                             RISCVIOMMUContext *ctx)
 {
     uint32_t fsc_mode, msi_mode;
+    uint64_t gatp;
+
+    if (!(s->cap & RISCV_IOMMU_CAP_ATS) &&
+        (ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS ||
+         ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI ||
+         ctx->tc & RISCV_IOMMU_DC_TC_PRPR)) {
+        return false;
+    }
+
+    if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS) &&
+        (ctx->tc & RISCV_IOMMU_DC_TC_T2GPA ||
+         ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI)) {
+        return false;
+    }
 
     if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
         ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
@@ -661,6 +675,12 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         }
     }
 
+    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+    if (ctx->tc & RISCV_IOMMU_DC_TC_T2GPA &&
+        gatp == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        return false;
+    }
+
     fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
@@ -811,7 +831,12 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
             RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
         ctx->satp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
             RISCV_IOMMU_DC_FSC_MODE_BARE);
+
         ctx->tc = RISCV_IOMMU_DC_TC_V;
+        if (s->enable_ats) {
+            ctx->tc |= RISCV_IOMMU_DC_TC_EN_ATS;
+        }
+
         ctx->ta = 0;
         ctx->msiptp = 0;
         return 0;
@@ -1273,6 +1298,16 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    /* Check for ATS request. */
+    if (iotlb->perm == IOMMU_NONE) {
+        /* Check if ATS is disabled. */
+        if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
+            enable_pri = false;
+            fault = RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
+            goto done;
+        }
+    }
+
     qemu_mutex_lock(&s->iot_lock);
     iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
     qemu_mutex_unlock(&s->iot_lock);
@@ -1320,11 +1355,11 @@ done:
     }
 
     if (fault) {
-        unsigned ttype;
+        unsigned ttype = RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
 
         if (iotlb->perm & IOMMU_RW) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
-        } else {
+        } else if (iotlb->perm & IOMMU_RO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
         }
 
@@ -1352,6 +1387,73 @@ static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
         MEMTXATTRS_UNSPECIFIED);
 }
 
+static void riscv_iommu_ats(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd, IOMMUNotifierFlag flag,
+    IOMMUAccessFlags perm,
+    void (*trace_fn)(const char *id))
+{
+    RISCVIOMMUSpace *as = NULL;
+    IOMMUNotifier *n;
+    IOMMUTLBEvent event;
+    uint32_t pasid;
+    uint32_t devid;
+    const bool pv = cmd->dword0 & RISCV_IOMMU_CMD_ATS_PV;
+
+    if (cmd->dword0 & RISCV_IOMMU_CMD_ATS_DSV) {
+        /* Use device segment and requester id */
+        devid = get_field(cmd->dword0,
+            RISCV_IOMMU_CMD_ATS_DSEG | RISCV_IOMMU_CMD_ATS_RID);
+    } else {
+        devid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_RID);
+    }
+
+    pasid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
+
+    qemu_mutex_lock(&s->core_lock);
+    QLIST_FOREACH(as, &s->spaces, list) {
+        if (as->devid == devid) {
+            break;
+        }
+    }
+    qemu_mutex_unlock(&s->core_lock);
+
+    if (!as || !as->notifier) {
+        return;
+    }
+
+    event.type = flag;
+    event.entry.perm = perm;
+    event.entry.target_as = s->target_as;
+
+    IOMMU_NOTIFIER_FOREACH(n, &as->iova_mr) {
+        if (!pv || n->iommu_idx == pasid) {
+            event.entry.iova = n->start;
+            event.entry.addr_mask = n->end - n->start;
+            trace_fn(as->iova_mr.parent_obj.name);
+            memory_region_notify_iommu_one(n, &event);
+        }
+    }
+}
+
+static void riscv_iommu_ats_inval(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd)
+{
+    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_DEVIOTLB_UNMAP, IOMMU_NONE,
+                           trace_riscv_iommu_ats_inval);
+}
+
+static void riscv_iommu_ats_prgr(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd)
+{
+    unsigned resp_code = get_field(cmd->dword1,
+                                   RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE);
+
+    /* Using the access flag to carry response code information */
+    IOMMUAccessFlags perm = resp_code ? IOMMU_NONE : IOMMU_RW;
+    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_MAP, perm,
+                           trace_riscv_iommu_ats_prgr);
+}
+
 static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
 {
     uint64_t old_ddtp = s->ddtp;
@@ -1507,6 +1609,25 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
             break;
 
+        /* ATS commands */
+        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_INVAL,
+                             RISCV_IOMMU_CMD_ATS_OPCODE):
+            if (!s->enable_ats) {
+                goto cmd_ill;
+            }
+
+            riscv_iommu_ats_inval(s, &cmd);
+            break;
+
+        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_PRGR,
+                             RISCV_IOMMU_CMD_ATS_OPCODE):
+            if (!s->enable_ats) {
+                goto cmd_ill;
+            }
+
+            riscv_iommu_ats_prgr(s, &cmd);
+            break;
+
         default:
         cmd_ill:
             /* Invalid instruction, do not advance instruction index. */
@@ -1902,6 +2023,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
+    if (s->enable_ats) {
+        s->cap |= RISCV_IOMMU_CAP_ATS;
+    }
     if (s->enable_s_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
                   RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
@@ -2014,6 +2138,7 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
+    DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 82ba549268..e6bb82b498 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -38,6 +38,7 @@ struct RISCVIOMMUState {
 
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
+    bool enable_ats;      /* Enable ATS support */
     bool enable_s_stage;  /* Enable S/VS-Stage translation */
     bool enable_g_stage;  /* Enable G-Stage translation */
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 42a97caffa..4b486b6420 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -9,3 +9,6 @@ riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iov
 riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
 riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
 riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
+riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
+riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
+riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
-- 
2.45.2


