Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE06E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByO-0002T0-S4; Thu, 05 Dec 2024 08:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwN-0001F6-Mz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwH-0005Vo-L7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:44 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725a84ff55dso402432b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405436; x=1734010236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tutdiXYnPaTXlirs7ckWO4V30sAs5114Oq+7VqOZ6lY=;
 b=YTranjlENjBzKjmpN6Myt6umHk4NfnZ9sbWjSqMsh9SmmptKb36ShDqTPdLsaMv4DY
 yle0v38kBGCWKBPiTGX4MOLhj4SFs9aQf2BM2kfjNVkL1GkNO56HsafTsvL1+R5UqJ9q
 bo4ZvAGk5rbNssMMD5GOh/Yt5HTQWUknF0OTJIhVqFWPe+YezqFviuwRdLWKThK1xXAu
 ZwecCcP72BDN7F8KYeq6DNdn/Tv7lwWfaIaxgSZ2EtoG2kVfjCPnbqJvVDIbk28dvnox
 HCaM4m2vmsIWqi3dSVXYMFVSc+hgdWtTdKn4smzqwGDmNanulXUQS2HphdzGhiwisSRc
 ALwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405436; x=1734010236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tutdiXYnPaTXlirs7ckWO4V30sAs5114Oq+7VqOZ6lY=;
 b=s1VPhs5HsvNGtKfEOAibYK1HX3H1HhfqEWCDUkR6yiHm7FcP5127mw3oHLj05yFGgd
 ZTTLjwlQoC/qUBMuTG4Y/0QFJ7FQip1EszySGk8j0BahfmY5wE56pF6I0mbltfxCeWZz
 qA826ZfymK0jEnlow5wDZmU3HmODl/+zjct3/wGHLoSaStpcJfNIhQmKKR4StkskksvX
 GBxIbE599kGdYZaQ1QAsznBX2C5fSL8LDJ/QCuXUR8398OjEDHoWDm3Cy37MlHmip39p
 JXk1KEZz2GoJwIaADQTIrL9BYmZ5/uoiMlCFvEs7v9+/cWYwbG/cBZ6V+1yyomV2eW2n
 mmyw==
X-Gm-Message-State: AOJu0YyOvGlj8ozuZNo1xG6tvaGv77uCtuWt53kVW2CmhvoLZA7WmnUL
 zl31sEQEEL+5PG1HLGRapXioa2M3oUmD/dyCxOsa1am46fV2wR0/1mgcVDRgIhwTf7s6puU8xgU
 u
X-Gm-Gg: ASbGnctv0j8NsguuuEq0rOgQLwwvKAk6P6sVcn3R+jdbkGIV/VKTRSR9dHBCHAvLBjm
 VYB73GkthGxASuZzx4uwV9Q4FI7GT3Z5sAg6ayhQCHKz4YZC/xlHfM9TnZ6SVlewMf7PE2QXWf4
 QXxEEJRFOXrTl+9yYZYjB4QQ31kYEZpE/U5PNRQZX1ucBV7Abj8IVGXnumirpHOpUAGWyALClaf
 QkhaKGHJ1/B5urBStEbB9ddiE2ciIqN5d6yxKMdvHY+1YyrZcFZb5poPIfFLWAikZnTVAhkObb8
X-Google-Smtp-Source: AGHT+IGQhCloQLNqi3qnphtJY9NOGO12JDZUbIkBGrYHF7ar7fN2b6VoXcuOeIpuQTpLFFF6UWFY/g==
X-Received: by 2002:a05:6a00:3d10:b0:725:9f02:489a with SMTP id
 d2e1a72fcca58-7259f024c07mr4192288b3a.17.1733405434738; 
 Thu, 05 Dec 2024 05:30:34 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 08/11] hw/riscv/riscv-iommu: add hpm events mmio write
Date: Thu,  5 Dec 2024 10:30:00 -0300
Message-ID: <20241205133003.184581-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 hw/riscv/riscv-iommu-hpm.c | 88 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.c     |  4 +-
 hw/riscv/riscv-iommu.h     |  1 +
 4 files changed, 93 insertions(+), 1 deletion(-)

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
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 3bdd88df4a..83cd529844 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1939,7 +1939,7 @@ static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
 
     case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
         RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
-        /* not yet implemented */
+        riscv_iommu_process_hpmevt_write(s, regb & ~7);
         break;
     }
 }
@@ -2386,6 +2386,8 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
         TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_UINT8("hpm-counters", RISCVIOMMUState, hpm_cntrs,
+                      RISCV_IOMMU_IOCOUNT_NUM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 6ddc59f474..5aaa66fae5 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -95,6 +95,7 @@ struct RISCVIOMMUState {
 
     /* HPM event counters */
     GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
+    uint8_t hpm_cntrs;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.47.1


