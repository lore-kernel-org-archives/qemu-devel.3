Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B832CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY65-0003GO-Nc; Tue, 13 Oct 2026 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY46-0000Hc-HT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY42-00084P-Cq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so1898024f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880849; x=1792485649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NCZsMS7sqb9Y3VaE0qbPpa4SMwY97DnFRVA8VMcGapM=;
 b=SCdh7EQLbpai6/47uTSd+7jtTc1DsCEOpnfNBBn88v47SNHF72N+XFjzICv96vBm4n
 3s6qDQNNTH3UFepPuLN4ThRC+MDnxf9D+zbNRVTGyhQdoVla3sJg42uaCJukH3Mn+4Sg
 xOkZARmegfrD8eFVyKW14SfZceW5EcNlBM83IeX4F01zTnxsd3Ty0zk73SLfEbXdcpUh
 9ViXkH1Isvpt1ADzsqE/oQSJDhzamvXuwr2kagcwmZwIMRomzw6dzVjhGpslaqwrrrrm
 x0S61nQAptxC5OTXH73MZ6ZIafc4F8Plnqk6DHAWnFkSens+XKh3Sssvu/CuRdS6ccUh
 xqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880849; x=1792485649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NCZsMS7sqb9Y3VaE0qbPpa4SMwY97DnFRVA8VMcGapM=;
 b=CTtm4ohXM6DVsCTgzO4LEg5sEE7jMlpOS8kxtBk9l/dY/M7MoUlfq2rSBTHDjaxUfL
 ijf0AEuZZZbtmcbSQCZtsAHHwEV6Fd7k4EqFkCPPtr4Lz1pVenfTP4qJM/ASuVuxSUAg
 8GxizV+oBkxqk00czug0FadfvAsow62dWcxTrSGJyKN/P/F1obdPgZO+i/JbpMwD5ga1
 NtPlumpqmHSR6WQpBdCmYByvSC8S6+BP7kwJ0GroBJGcY2D4v8M0Xd/XvMnvS0H4uamt
 tKNjQhF+gs6UWPqbooC9XiBmrUa9iJXGnJfExdtlyg80Dj8X2316sNlQCEHixQvcxAOB
 vg5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0p2DDDMCb3r5cQHUKQQ5knJd2tS5G625XlbtdZXDjan0/fbs+0V47mCUxfuvCOt6CQzSkIvwwQZK0@nongnu.org
X-Gm-Message-State: AFq9FYJmN4xVpCpHuK+rTJ5nNqwfiPYVhjF73/RtReSpVHpVVjdkfXNy
 6S9qolIoGcep9A3X0VNiz4dW1lbszxXGcejJ0GPfhTcuAqICP5v+8GtouIXotp70g29ApcGnIhP
 YWxoen8o=
X-Gm-Gg: AYBFou3LgGDPus2/cjjYIwiLTMlPzLXX8lGRRhmL9idHfs058SINjMAbpL8E4vxq6tX
 hJx9ZgOtltRBOJxST9teUNt/yzrPz+HqN4kkDUw25+3A/EImzXZB9Qy5a9YrAXYrhN+Tjkwbrx5
 rUPbYtQLbbK3wwmZxbpV2uS6z9gWrn4vIBOmn+t8nxpkq/3xyYbf+kejCGNxDais5oAx/dFZXkV
 qpTfdbYoa1jPOToPigd96G80trzvFNMEL/S/BENPi8X8sw+mgnd8UFdz2O+LpANij1XLMe/shNE
 /sG3NnYP143YUq9LUK8MQ1HWecKoDttQA8Ug3ofTVS5yXs18afnAlobVnV3doLIaKQENSI/1tn7
 SAKOP1l72eUtyOjTrIslgGPgWZFBJ8k/yDaP4oCjB4+6OVPf5B/ChDI67XF046ybSPUWJ6/I2sO
 AbDv1KYWBgWKxSvVwYWk0zTxlHEvhdGZdnUWB1AvhtqIYHcrwwsB1jVHApmLbHEdpEstDNBblHw
 AQrqbzsWT37fkR11ns03T67UTpb43MXlv0PEgbp3noLbE5ZKaDPpICDqILERaMzsfroj6A8T8wK
 Jas=
X-Received: by 2002:a05:600c:e557:20b0:49f:dd9f:6038 with SMTP id
 5b1f17b1804b1-4a18e4bff94mr148687545e9.25.1791880848728; 
 Tue, 13 Oct 2026 01:40:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 55/86] hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VMTR
Date: Tue, 13 Oct 2026 09:39:02 +0100
Message-ID: <20261013083933.1024405-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The IRS_VMAP_L2_VMTR register allows the guest to make a level 2 VM
table valid.  It's similar to what the IRS_MAP_L2_ISTR register does
for the IST, but it's 64 bits, and so it is R/W and has an M bit for
"actually do the operation" so that the guest can write it as two 32
bit halves.  Since we don't cache anything yet, all the "make valid"
operation needs to do is write to the VALID bit in the L1 table entry
in guest memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 110 ++++++++++++++++++++++++++++-
 hw/intc/arm_gicv5_common.c         |   1 +
 include/hw/intc/arm_gicv5_common.h |   1 +
 include/hw/intc/arm_gicv5_regs.h   |   9 +++
 4 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index e12b73dcefe..a81f7803ca5 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -49,7 +49,6 @@ static const char *inttype_name(GICv5IntType t)
     return names[t];
 }
 
-
 #define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
 
 static uint32_t gicv5_idreg(int regoffset)
@@ -489,6 +488,19 @@ static void put_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
     write_l2_iste_mem(cs, cfg, h->l2_iste_addr, h->l2_iste);
 }
 
+static hwaddr l1_vmte_addr(GICv5Common *cs, const GICv5VMTConfig *cfg,
+                           uint32_t vmid)
+{
+    /*
+     * In a 2-level VMT configuration, return the address of the L1
+     * VMT entry for this VM ID.  The bottom VMT_L2_IDX_BITS of the
+     * ID value are the index into the L2 table, and the higher bits
+     * of the ID index the L1 table. The L1 table entries are 8 bytes.
+     */
+    uint32_t l1_index = vmid >> VMT_L2_IDX_BITS;
+    return cfg->base + (l1_index * 8);
+}
+
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual)
 {
@@ -1249,6 +1261,62 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+static void irs_vmap_l2_vmtr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+    uint32_t vmid = FIELD_EX64(value, IRS_VMAP_L2_VMTR, VM_ID);
+    bool m = FIELD_EX64(value, IRS_VMAP_L2_VMTR, M);
+    hwaddr l1_addr;
+    uint64_t l1_vmte;
+    MemTxResult res;
+
+    if (!gicv5_domain_has_virt(cs, domain) || !cfg->valid || !cfg->structure) {
+        /*
+         * The whole register is RAZ/WI if no virt, or if the VM
+         * table is invalid or not 2 level.
+         */
+        return;
+    }
+
+    /*
+     * Otherwise, write to the register. The M bit is WO/UNKNOWN,
+     * and we make sure it is 0, so that a 32-bit write to the low
+     * half of the register never appears to have the M bit set.
+     */
+    cs->irs_vmap_l2_vmtr[domain] = value & ~R_IRS_VMAP_L2_VMTR_M_MASK;
+
+    if (!m || vmid >= (1 << cfg->vm_id_bits)) {
+        /*
+         * If guest didn't actually ask to make the L2 table valid, or
+         * the ID is out of range, do nothing except the register update.
+         */
+        return;
+    }
+
+    /* Find the relevant L1 VMTE and set its VALID bit */
+    l1_addr = l1_vmte_addr(cs, cfg, vmid);
+
+    l1_vmte = address_space_ldq_le(&cs->dma_as, l1_addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    l1_vmte = FIELD_DP64(l1_vmte, L1_VMTE, VALID, 1);
+
+    address_space_stq_le(&cs->dma_as, l1_addr, l1_vmte, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    return;
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L1 VMTE update failed for VMID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n", vmid, l1_addr);
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -1386,6 +1454,24 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_L2_VMTR:
+        if (gicv5_domain_has_virt(cs, domain) &&
+            s->vmt_config[domain].valid && s->vmt_config[domain].structure) {
+            *data = extract64(cs->irs_vmap_l2_vmtr[domain], 0, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table or VM table not 2 level */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VMAP_L2_VMTR + 4:
+        if (gicv5_domain_has_virt(cs, domain) &&
+            s->vmt_config[domain].valid && s->vmt_config[domain].structure) {
+            *data = extract64(cs->irs_vmap_l2_vmtr[domain], 32, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table or VM table not 2 level */
+            *data = 0;
+        }
+        return true;
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1508,6 +1594,16 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             }
         }
         return true;
+    case A_IRS_VMAP_L2_VMTR:
+        irs_vmap_l2_vmtr_write(s, domain,
+                               deposit64(cs->irs_vmap_l2_vmtr[domain],
+                                         0, 32, data));
+        return true;
+    case A_IRS_VMAP_L2_VMTR + 4:
+        irs_vmap_l2_vmtr_write(s, domain,
+                               deposit64(cs->irs_vmap_l2_vmtr[domain],
+                                         32, 32, data));
+        return true;
     case A_IRS_SPI_SELR:
         cs->irs_spi_selr[domain] = data;
         return true;
@@ -1599,6 +1695,15 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_L2_VMTR:
+        if (gicv5_domain_has_virt(cs, domain) &&
+            s->vmt_config[domain].valid && s->vmt_config[domain].structure) {
+            *data = cs->irs_vmap_l2_vmtr[domain];
+        } else {
+            /* RAZ/WI if no virt or no VM table or not 2-level */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -1614,6 +1719,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_VMT_BASER:
         irs_vmt_baser_write(s, domain, data);
         return true;
+    case A_IRS_VMAP_L2_VMTR:
+        irs_vmap_l2_vmtr_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 6a9d727bb65..945257fef2c 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -108,6 +108,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
     if (cs->has_virt) {
         memset(cs->irs_vmt_baser, 0, sizeof(cs->irs_vmt_baser));
         memset(cs->irs_vmt_cfgr, 0, sizeof(cs->irs_vmt_cfgr));
+        memset(cs->irs_vmap_l2_vmtr, 0, sizeof(cs->irs_vmap_l2_vmtr));
     }
 }
 
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index fb88c39e8b4..19700c7d5e3 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -91,6 +91,7 @@ struct GICv5Common {
     uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];
     uint64_t irs_vmt_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_vmt_cfgr[NUM_GICV5_DOMAINS];
+    uint64_t irs_vmap_l2_vmtr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
diff --git a/include/hw/intc/arm_gicv5_regs.h b/include/hw/intc/arm_gicv5_regs.h
index 1d0fb8b147e..d675a10c37f 100644
--- a/include/hw/intc/arm_gicv5_regs.h
+++ b/include/hw/intc/arm_gicv5_regs.h
@@ -270,6 +270,15 @@ FIELD(L2_ISTE, HWU, 9, 2)
 FIELD(L2_ISTE, PRIORITY, 11, 5)
 FIELD(L2_ISTE, IAFFID, 16, 16)
 
+FIELD(L1_VMTE, VALID, 0, 1)
+FIELD(L1_VMTE, L2_ADDR, 12, 44)
+
+/*
+ * L2 VMTEs are always 32 bytes, and the L2 table is always 4KB,
+ * so the lower 7 bits in a VM ID index the L2 table.
+ */
+#define VMT_L2_IDX_BITS 7
+
 /*
  * Format used for gicv5_request_config() return value, which matches
  * the ICC_ICSR_EL1 bit layout.
-- 
2.43.0


