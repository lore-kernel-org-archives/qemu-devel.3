Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE56EC021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdq3-0005tw-4R; Mon, 24 Feb 2025 14:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpA-0005hU-Nu
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:06 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdp6-0004rP-GZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:03 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220f4dd756eso99449935ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424137; x=1741028937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdvxoA7MO1HEsVdmxpLT+H+KWWtGcf6+0kEyDaOkd9I=;
 b=hVimHlHnVWUPdVOQCt2PUaMy4LC9RwKh3oI4utkedSi9+mCwVRFAyabMVfExipcvBs
 fSlAdr6Hd6CJ+onjhZfHXK1VQkhLr0F5/V+LXxJaL7vOh8zTYGt9W0pnBKkQVq03Nzlt
 sO2JM8pZmuiPFH2aksu8yjC+nIBKnr7mI4ONwTJ2/9Yst3QbqiXw0oyvm0Uw6i1pyMcN
 hvCEcPYEWYdGpqFEmfD+mzfWKV70UilUrKJp0cCbU4gW84AhhpTzVAocXX5azIrA9W2i
 5y/lC1x9gRKu3PjWvDwEnEh17BGrJJBauqKOTEh2IZscC6Cw2Ocfh2EymdkjGF6gQ1fv
 5BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424137; x=1741028937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdvxoA7MO1HEsVdmxpLT+H+KWWtGcf6+0kEyDaOkd9I=;
 b=MVNmP2xRmi8bO6xKJr24PM9Dzjk7beIzNHz4xqk0pjjo+0G5pWqSfu0W4QuKgdUKsw
 fUL4G2ZoXpMhr84wWbt0v8aLeWbnI5d2LOzpRMkHCktmD6c1Rv3uSciAX+MP3YPRF8gk
 M4Po3u4WAzQGa7YvQJvHwDRLG06D8NbfEtihtQ7MjDPV17tMH5BI6VDxcod2q/xBA1NW
 0a7JMRYBHTLt4Hs7+HoC7xxwhB2z9ntdQmXe0jTPEXGDCKMjBCeLyElyICoYwMikr5jd
 S8I4CCEKK3Er4hacoLmOz88J6cDNiCohJCdfFGQsbKBqxU00VYqANW0RhpaJKA37c/HI
 B90Q==
X-Gm-Message-State: AOJu0YxYDWSJCSGKW0FHeIez0yrOh8WlFI9IsfyEvpPMzgawgVGgYGkc
 f9syKFmBAHsD68d3hLbaif3jw+yHi69tgd70YaaglR8hmEEyIjU/ywkXonz7toMCbDhvP5dxKUR
 L
X-Gm-Gg: ASbGncvm2ALH5I1txR4/3QdbcjaYsko9wrqKGAo1RSLokDdtCJtxmEjQ763rnA7uBW2
 WEVpveXEak/vOR9qgiI+tEtv12yedbRmkCgH/TJra7psd6CU1uZ/n1oOgvPDvLBM87bwkVXdPuH
 3r579MtKwQttXfw8SueeO5Nf6KHcfcHSE9KUz7mMidmRATYU0a6HlOrqa2bTTYpkl8xGSohm7lL
 wutvpp43PpfoNJJdtkWNgB720cZmq0M49fKC+wuiNqwPKto0w6VnHP+miQHaAM4rMtHFB1k5vqg
 FH++/h4xmiEM3033BG/jJoEJNK9Qfg==
X-Google-Smtp-Source: AGHT+IEKv1W+/QME25fbgS5noawmtF0rlKUg3xy2kwI4RfKKE47Xf9N9drGHa9BBPFJjnVJ7AKT1hQ==
X-Received: by 2002:a17:902:e5c2:b0:215:9470:7e82 with SMTP id
 d9443c01a7336-22307b455dcmr6044625ad.4.1740424136969; 
 Mon, 24 Feb 2025 11:08:56 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:56 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 08/11] hw/riscv/riscv-iommu: add hpm events mmio write
Date: Mon, 24 Feb 2025 16:08:23 -0300
Message-ID: <20250224190826.1858473-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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
-- 
2.48.1


