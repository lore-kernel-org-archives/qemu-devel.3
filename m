Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6D3C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzc-0001Bu-5W; Tue, 04 Mar 2025 20:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyv-0007Ip-Ue
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyt-0000Rn-OM
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so119457645ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139730; x=1741744530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hg6ctHTleBalPPYSEjbmnNlFJNx67RnPs15e9jCuTs8=;
 b=kMZctoyoO6C1xbc05MAAIDw1b0X3rM35kCbLJRuKmB85C5MWqV2+kwTFHycmsAx9ZN
 Cy9BgpS4YLYd9uqvpl9FMA+IzHKdhQBHOLeeILSR0roAzg5LHDmJiV+6XnJyFIpp9fLn
 JdyVZr9x4UyyXqZefs0xNgNoYNzuqGzLFAfT6yjFyyrjxMaxsTNVluGKttyvpgPyweAc
 krXzyGmIWC7u81R3RdWcEp1FRMdO1GXSwr7ecTaEJ1GivNDILjnkAH9L+iOS2nIVr8Xq
 clc3xxSSpvL7XqHnb+Rbi2uq7CCF4Zapc/3YL6mio4dB47eYLjtPrgoEIzcvLXbF0w6j
 nolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139730; x=1741744530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hg6ctHTleBalPPYSEjbmnNlFJNx67RnPs15e9jCuTs8=;
 b=BDIbJy7q9RLhtbzDJhOlzTqkaCNR5q8U/WFHEYoApSjLDifYJ5hfBEMmH05ziXJ829
 qz1NRdMc8bEX/utptQ3D1aCUTcaeIzOEEVSEbhpXNWKyRGc5TSLH+ZEGE7XyDe4HMF1I
 /FwstsHLt4rlNVGGM7JopiKuJJz9GxsmopOYkNPJwCbd/ydfZZ/V4kMxSDgrphZh1Erd
 NmZDnWvalDy6zkhPnpJ93XK+VSbznpOYOQREAmecEN1q9uDBzQQheB8Va6RBmt5dvsBp
 N9HSNIJTkBPOkeA0ojXG950MAnQVyqfObhvXoJeiPI/bbdhVlDTkJHA41hjsxxd19Q3F
 ddEQ==
X-Gm-Message-State: AOJu0YyvOXi2WzWJxkbt/tSwYZjEssTp50Axn/YxYAgSpctdcTmX+Gtn
 1pEIeSeqTEsOAxKcmlf5n7U/q52FZJtSunjNlgEIn8G1g6wv4ippSfmwQ+XiU9I=
X-Gm-Gg: ASbGncvT+19OtnSSIZum2sZo3N1DfQmIKz1FpbgWM8Awt0q6kXTP8lYD4JqOC16Fcxm
 Gwr5yY8Tumyi8QtxdCix6seX8OJwrAKya9Rd6l9z1pVAHZ74HDhrvTPrr7JPmvcWExD3r2Ftfvy
 SbCcxe/wgI7b4AWl8gs6FStwtI7FP08ugbL6XrzSnydo4as7X8AVMyag2tHVT9W0WWV9i8s5gqG
 aqJyy4ghVZ4TVGv5CrqmKZHy9MH2nVqWRSvHDReMg7pDZXs7BF3mjhSBUeZBBmsFMGCyeDvIfkQ
 KiO/AXNOeXPsCkWhtSUylShE20gzPNGKOYhJdiDrIpz2WEXHTx4qJIG6YApX4G5czt6UmPUdnAy
 aJuqgadObvt+Li3GTOVH3TQi9lCrUB3GRhVGNkJjYesVxHxJmYSI=
X-Google-Smtp-Source: AGHT+IEaf+xPuBDhoyTq9BBMPhv3jgUAwKTHGAKqti1UvoLK0ddcLYhNEOmRUWxx2/gAi4zIr2F4QA==
X-Received: by 2002:a17:902:e787:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-223f408c554mr14459675ad.21.1741139730116; 
 Tue, 04 Mar 2025 17:55:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/59] hw/riscv/riscv-iommu: add hpm events mmio write
Date: Wed,  5 Mar 2025 11:52:54 +1000
Message-ID: <20250305015307.1463560-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

To support hpm events mmio writes, done via
riscv_iommu_process_hpmevt_write(), we're also adding the 'hpm-counters'
IOMMU property that are used to determine the amount of counters
available in the IOMMU.

Note that everything we did so far didn't change any IOMMU behavior
because we're still not advertising HPM capability to software. This
will be done in the next patch.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.h     |  1 +
 hw/riscv/riscv-iommu-hpm.c | 88 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     |  4 +-
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index 0cd550975d..5fc4ef2e8b 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -28,5 +28,6 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 void riscv_iommu_hpm_timer_cb(void *priv);
 void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
 void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
+void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg);
 
 #endif
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2fef6eed27..a31aa62144 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -90,6 +90,7 @@ struct RISCVIOMMUState {
 
     /* HPM event counters */
     GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
+    uint8_t hpm_cntrs;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 1cea6b1df1..5518c287a5 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -281,3 +281,91 @@ void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s)
     s->hpmcycle_prev = get_cycles();
     hpm_setup_timer(s, s->hpmcycle_val);
 }
+
+static inline bool check_valid_event_id(unsigned event_id)
+{
+    return event_id > RISCV_IOMMU_HPMEVENT_INVALID &&
+           event_id < RISCV_IOMMU_HPMEVENT_MAX;
+}
+
+static gboolean hpm_event_equal(gpointer key, gpointer value, gpointer udata)
+{
+    uint32_t *pair = udata;
+
+    if (GPOINTER_TO_UINT(value) & (1 << pair[0])) {
+        pair[1] = GPOINTER_TO_UINT(key);
+        return true;
+    }
+
+    return false;
+}
+
+/* Caller must check ctr_idx against hpm_ctrs to see if its supported or not. */
+static void update_event_map(RISCVIOMMUState *s, uint64_t value,
+                             uint32_t ctr_idx)
+{
+    unsigned event_id = get_field(value, RISCV_IOMMU_IOHPMEVT_EVENT_ID);
+    uint32_t pair[2] = { ctr_idx, RISCV_IOMMU_HPMEVENT_INVALID };
+    uint32_t new_value = 1 << ctr_idx;
+    gpointer data;
+
+    /*
+     * If EventID field is RISCV_IOMMU_HPMEVENT_INVALID
+     * remove the current mapping.
+     */
+    if (event_id == RISCV_IOMMU_HPMEVENT_INVALID) {
+        data = g_hash_table_find(s->hpm_event_ctr_map, hpm_event_equal, pair);
+
+        new_value = GPOINTER_TO_UINT(data) & ~(new_value);
+        if (new_value != 0) {
+            g_hash_table_replace(s->hpm_event_ctr_map,
+                                 GUINT_TO_POINTER(pair[1]),
+                                 GUINT_TO_POINTER(new_value));
+        } else {
+            g_hash_table_remove(s->hpm_event_ctr_map,
+                                GUINT_TO_POINTER(pair[1]));
+        }
+
+        return;
+    }
+
+    /* Update the counter mask if the event is already enabled. */
+    if (g_hash_table_lookup_extended(s->hpm_event_ctr_map,
+                                     GUINT_TO_POINTER(event_id),
+                                     NULL,
+                                     &data)) {
+        new_value |= GPOINTER_TO_UINT(data);
+    }
+
+    g_hash_table_insert(s->hpm_event_ctr_map,
+                        GUINT_TO_POINTER(event_id),
+                        GUINT_TO_POINTER(new_value));
+}
+
+void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg)
+{
+    const uint32_t ctr_idx = (evt_reg - RISCV_IOMMU_REG_IOHPMEVT_BASE) >> 3;
+    const uint32_t ovf = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
+    uint64_t val = riscv_iommu_reg_get64(s, evt_reg);
+
+    if (ctr_idx >= s->hpm_cntrs) {
+        return;
+    }
+
+    /* Clear OF bit in IOCNTOVF if it's being cleared in IOHPMEVT register. */
+    if (get_field(ovf, BIT(ctr_idx + 1)) &&
+        !get_field(val, RISCV_IOMMU_IOHPMEVT_OF)) {
+        /* +1 to offset CYCLE register OF bit. */
+        riscv_iommu_reg_mod32(
+            s, RISCV_IOMMU_REG_IOCOUNTOVF, 0, BIT(ctr_idx + 1));
+    }
+
+    if (!check_valid_event_id(get_field(val, RISCV_IOMMU_IOHPMEVT_EVENT_ID))) {
+        /* Reset EventID (WARL) field to invalid. */
+        val = set_field(val, RISCV_IOMMU_IOHPMEVT_EVENT_ID,
+            RISCV_IOMMU_HPMEVENT_INVALID);
+        riscv_iommu_reg_set64(s, evt_reg, val);
+    }
+
+    update_event_map(s, val, ctr_idx);
+}
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 821ecba3a4..cdbb848181 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2040,7 +2040,7 @@ static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
 
     case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
         RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
-        /* not yet implemented */
+        riscv_iommu_process_hpmevt_write(s, regb & ~7);
         break;
     }
 }
@@ -2487,6 +2487,8 @@ static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
         TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_UINT8("hpm-counters", RISCVIOMMUState, hpm_cntrs,
+                      RISCV_IOMMU_IOCOUNT_NUM),
 };
 
 static void riscv_iommu_class_init(ObjectClass *klass, void* data)
-- 
2.48.1


