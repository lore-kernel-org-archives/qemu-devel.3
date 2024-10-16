Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24742D206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Apf-0004TU-LH; Wed, 16 Oct 2024 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Apd-0004RI-OH
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1ApZ-0004gN-Es
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:20 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso1037937a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729111275; x=1729716075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6e4dW1cp5peE6KKNKAL6QaGP0xTMGaTY7+aN0GuIOs=;
 b=lNIP9eLr6NAUVB3C1iu6Pi/EunghSbb7o5bQv1s/ExjW81AUUeOGWaxFPFZ0JVFA8/
 LCZ9Csm7BLAWko3hXG+evJQ8IibMTfUhCmFurjfrs8NCR7ikxATFeE2uDv2iCVJgwiEL
 YgdFyJKe5Wxcv9KR2cl4dZhHSR0+v/fJL/kBgls3pbtyoFh61la2phgUKKv4MpJ6+The
 Q66qitjRyi7yzIbOJY6CEhgA4oGYSwRn22BYxNVjoV80DGLjZMFZry5LBcbJbCXRq/7w
 yMDTzrv16mBNDE0pLGPz9NiQl9S7R7dktyMzEI4dVdyNKFjfgK7Ol9xpMzZd7X5ViMpV
 PhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729111275; x=1729716075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6e4dW1cp5peE6KKNKAL6QaGP0xTMGaTY7+aN0GuIOs=;
 b=aVKRQ6rHBu35WUM+8FkrK6AZ4DUwvHripdqiu0i+rKxVkJZrmvaFOFFeOL703h7bVb
 JxBkI+u9YJTSxIJ9YRrUOt3854i01dD1yUaEc7/sjNjDoVCJrlp8hQSdRuHKnQgnNJMV
 39s3VW/Jtl+eyBZbZ+Gl7MyV3UHVKZsSxi/WB3Sah4/zgJ1hTzPS1c/YLClW1qDuegZw
 Gg9umP3TDNtsjuIaapIxegDHWAD6QCHfoARpB9LiESCFx4V5BDkpH98wYnEpa1sfKjgb
 /fQ5qg1Y4tCibPxbFJXDI20KTbl4il8dBGWCzlnqQjTYDNbUOvmy/ZXpmWr/l4qCH30j
 b4Mw==
X-Gm-Message-State: AOJu0YxSp3Q4Bp4+I65xcpFSxXksd1HLZKKL2bZLhBuh+LxmV3bY8wS0
 Kt8Whh55/akQzag6n8roL32brq911bPygDgwPZu5DlG2ME8wpcp0wTIwVvf65v8GUJIhLv806of
 U
X-Google-Smtp-Source: AGHT+IFdFs17g2R2Uhs08Q+QlKp7Cac5tW0CGkhzw2AopCcV27rQzSKiFSRUzVsNbYDweZxRKRKN+g==
X-Received: by 2002:a17:90a:a796:b0:2d8:9fbe:6727 with SMTP id
 98e67ed59e1d1-2e3dc1f3ed6mr1314370a91.4.1729111275571; 
 Wed, 16 Oct 2024 13:41:15 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e09085cfsm242158a91.54.2024.10.16.13.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:41:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 09/12] hw/riscv/riscv-iommu: add ATS support
Date: Wed, 16 Oct 2024 17:40:33 -0300
Message-ID: <20241016204038.649340-10-dbarboza@ventanamicro.com>
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

Add PCIe Address Translation Services (ATS) capabilities to the IOMMU.
This will add support for ATS translation requests in Fault/Event
queues, Page-request queue and IOATC invalidations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h |  43 +++++++++++-
 hw/riscv/riscv-iommu.c      | 127 +++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h      |   1 +
 hw/riscv/trace-events       |   3 +
 4 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index b1c477f5c3..96a994b9aa 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
@@ -212,6 +213,7 @@ struct riscv_iommu_dc {
 
 /* Translation control fields */
 #define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
+#define RISCV_IOMMU_DC_TC_EN_ATS        BIT_ULL(1)
 #define RISCV_IOMMU_DC_TC_EN_PRI        BIT_ULL(2)
 #define RISCV_IOMMU_DC_TC_T2GPA         BIT_ULL(3)
 #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
@@ -273,6 +275,20 @@ struct riscv_iommu_command {
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
@@ -339,7 +355,32 @@ enum riscv_iommu_fq_ttypes {
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
index 7d291fa609..1a8da005c0 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -669,6 +669,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
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
@@ -689,6 +703,12 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
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
@@ -839,7 +859,12 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
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
@@ -1296,6 +1321,16 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
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
     iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
@@ -1347,11 +1382,11 @@ done:
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
 
@@ -1379,6 +1414,71 @@ static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
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
+    uint32_t pid;
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
+    pid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
+
+    QLIST_FOREACH(as, &s->spaces, list) {
+        if (as->devid == devid) {
+            break;
+        }
+    }
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
+        if (!pv || n->iommu_idx == pid) {
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
@@ -1534,6 +1634,25 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
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
@@ -1935,6 +2054,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
+    if (s->enable_ats) {
+        s->cap |= RISCV_IOMMU_CAP_ATS;
+    }
     if (s->enable_s_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
                   RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
@@ -2044,6 +2166,7 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
+    DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9f15f3b27f..da3f03440c 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -37,6 +37,7 @@ struct RISCVIOMMUState {
 
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
+    bool enable_ats;      /* Enable ATS support */
     bool enable_s_stage;  /* Enable S/VS-Stage translation */
     bool enable_g_stage;  /* Enable G-Stage translation */
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 3d5c33102d..0527c56c91 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -12,3 +12,6 @@ riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
 riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
 riscv_iommu_notify_int_vector(uint32_t cause, uint32_t vector) "Interrupt cause 0x%x sent via vector 0x%x"
 riscv_iommu_icvec_write(uint32_t orig, uint32_t actual) "ICVEC write: incoming 0x%x actual 0x%x"
+riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
+riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
+riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
-- 
2.45.2


