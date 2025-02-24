Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301A5C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpL-0005ka-IA; Mon, 24 Feb 2025 14:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdox-0005fH-UX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdov-0004pI-7W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220e989edb6so130908315ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424127; x=1741028927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UfwpO8Eu9sCwL2GSf/WbzwHM6yqn5zegav9+WOljQY=;
 b=HWrKF5T7LvdY5uffVLPiKXwRo4XPaRbXkAnBAcZnAKcrZrLmmKi8+ZJ4JTOklTWTXc
 clQRz4YgWWW8dN+/X4V8K0y8AbpvXOnFSt6XGT5Dlc7CcVs+Ntez31wayXqODV/WwSBX
 rq31GI35Z1AAOyTR73/8gAmU6BJENJid/j+Qmc0HF7Y5q2wR3tmpfy0KoxZIvJoHQbYf
 pX/aQoYuOAyfKinwo/aWYeCnvMwJO6vOPzAKjd6D3I8aKgGrSg7nDtwSmQ3CMk4FnsZj
 vHD7B9CU1KZ3ocr91EfxNknwc/xAfqZCN8OzcJ+b22sAxm67DoEEnRWsHJQYE99g+IP1
 BjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424127; x=1741028927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UfwpO8Eu9sCwL2GSf/WbzwHM6yqn5zegav9+WOljQY=;
 b=RpLZuwZxA62mzip6+i26qjER6ffT2Bt0kM2o0n6nGVZU8f3D3hI6Y07WAKA8U7FwRU
 ooocM2IziWDmyGEtcIVsOCNQZ6P7umh468KlHRRATNsmlsivL9Z3WX5nUkEUMU8mF+EW
 qFTkxgsyc2I9P74Op0E/pPChEoKnimVEsyuvWRmL8Phvr2LD7FdsGlxndXLutIoWL3GL
 3N3O1+N6xhHynHwuiShKKv4gj0khuU+YQ7BeA/0z9ALIEdzjUQGfEZel22mTy4at7y8z
 tLqG2emyGF1Psd3ZaLzfT9dLqBMgENV9IJHBGTx69eTcW2QvWyaFHjTMllNAlWJ2Zx8F
 YHzg==
X-Gm-Message-State: AOJu0YwodgCpSi2lIkF1gfSTadQHpeZZVLOjzi9/v77yswfsDfL5InQ7
 8459saRx+F0bSuWpB2ll3pK5wq6B7qpNgmXLCCtGIwYkgexDHVFxmA5WZ8F0N0jlTE7b0EMpPrv
 H
X-Gm-Gg: ASbGnctMbEWbUKclXa2M1tw/9+M383XBPOe0zSTcyzEZ6ldM27Lb72rSzakEhXPupEc
 n6LQTraoigAJ2G5b6zKJyi1jmHg3o9WuiqAOI+BI7Lk/DCs6GuHTXC0U44UZH8iLgoUJJ6T67GT
 coiKGfk+GuYSnPa5kviddDEmlw8u3AmbrWb849Z+rsp4IJozNuh5ZkJVpWfM1DXN6ihjv3MxGuA
 t2omVUZGD2rQgznwmuwSwaH0dxqe48IDXBQjhaUzCFKheAU8kjmxP69d/CvGvbJxJK5eOHgxcW6
 Ye9AekH2A69oBp/MoM4u9oY2LFhJOw==
X-Google-Smtp-Source: AGHT+IHDTySX0ti5ZDneN6q495ON+qmdfsWi9TgpHRAU0rtkXq22UCK/zoXsNyZQWPF1qQ4meAA9Vw==
X-Received: by 2002:a17:902:f54b:b0:220:d28a:c5c7 with SMTP id
 d9443c01a7336-22307b4bc13mr5406275ad.21.1740424127265; 
 Mon, 24 Feb 2025 11:08:47 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/11] hw/riscv/riscv-iommu: instantiate hpm_timer
Date: Mon, 24 Feb 2025 16:08:20 -0300
Message-ID: <20250224190826.1858473-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

The next HPM related changes requires the HPM overflow timer to be
initialized by the riscv-iommu base emulation.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.c     |  3 +++
 hw/riscv/riscv-iommu.h     |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 8eca5ee17e..325088333e 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -166,3 +166,39 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         hpm_incr_ctr(s, ctr_idx);
     }
 }
+
+/* Timer callback for cycle counter overflow. */
+void riscv_iommu_hpm_timer_cb(void *priv)
+{
+    RISCVIOMMUState *s = priv;
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    uint32_t ovf;
+
+    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
+        return;
+    }
+
+    if (s->irq_overflow_left > 0) {
+        uint64_t irq_trigger_at =
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->irq_overflow_left;
+        timer_mod_anticipate_ns(s->hpm_timer, irq_trigger_at);
+        s->irq_overflow_left = 0;
+        return;
+    }
+
+    ovf = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
+    if (!get_field(ovf, RISCV_IOMMU_IOCOUNTOVF_CY)) {
+        /*
+         * We don't need to set hpmcycle_val to zero and update hpmcycle_prev to
+         * current clock value. The way we calculate iohpmcycs will overflow
+         * and return the correct value. This avoids the need to synchronize
+         * timer callback and write callback.
+         */
+        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF,
+            RISCV_IOMMU_IOCOUNTOVF_CY, 0);
+        riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_IOHPMCYCLES,
+            RISCV_IOMMU_IOHPMCYCLES_OVF, 0);
+        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
+    }
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index 411d869dce..cd896d3b7c 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -25,5 +25,6 @@
 uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
 void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                               unsigned event_id);
+void riscv_iommu_hpm_timer_cb(void *priv);
 
 #endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 0b15acf4e6..f26aa15f55 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2382,6 +2382,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
 
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        s->hpm_timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, riscv_iommu_hpm_timer_cb, s);
         s->hpm_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
     }
 }
@@ -2395,6 +2397,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
+        timer_free(s->hpm_timer);
     }
 }
 
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 4384f39515..2fef6eed27 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -83,8 +83,10 @@ struct RISCVIOMMUState {
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
 
     /* HPM cycle counter */
+    QEMUTimer *hpm_timer;
     uint64_t hpmcycle_val;      /* Current value of cycle register */
     uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clock */
+    uint64_t irq_overflow_left; /* Value beyond INT64_MAX after overflow */
 
     /* HPM event counters */
     GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
-- 
2.48.1


