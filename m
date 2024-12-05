Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4AFE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByd-0003ZO-FQ; Thu, 05 Dec 2024 08:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwW-0001LH-6J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:31:02 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwR-00054p-TX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:55 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21572ca3cccso7289865ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405425; x=1734010225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXGwejsncW7L66450j232NWWj2M2NTNIsKpmlhWdnb8=;
 b=iyQu/LXGLucRqF176kIzOsbagkJRcQh6kw7SkCEoKt/ZLvSAqOSrsjVA5bBw08rZ4k
 kykm99xjy2PNYgXHdUrCVLmFFZ4StSWUu/vzCznyyuJt3MIMmdO767C4/LxyAr2ZEpbD
 LYXNDrFxxcofpKdu1sYz7JjmRMq7F+yttRiwXTyPQRJJv5s41DDA+yCPiRLouibJOoNp
 3zgQ5xQV4BbQI6icsJ0EZ2iTslm/xl6CB65STHhnllL8Ro5voOhoB8LOfJMe2Cm64+P7
 qQ13cexpHufi/H+tMfICgSe8i3tm1PuLnwjfTBpKEJrK0CuUq3HQ9gXZvMQUjW/qPvLO
 n5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405425; x=1734010225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXGwejsncW7L66450j232NWWj2M2NTNIsKpmlhWdnb8=;
 b=c7YTF+BbZSyerhwpJqNuKRKeBqzb21INtIoelnoZvTGy2kOofz4J8NboyKxjHlpjaU
 seRSR5q2rR+lCW3w2gJQGj1oITcdkoyHnD7d7TehQVt/0pS9JVlDYEhTg+/t9Om+2All
 5pb+/MxolkDU5e0qh3Yp7fk5g2TspI9pmn1pv7mJfmcVGb0Q56aoSJFK6KYAnQNvQad6
 r2O396nNRqhhiNzOckLuJAIEpubVC2l9ramyA726080CAXqcYLt1S1XU1TQmNCmnklae
 vW21wT6pbAd4u3Qv3l7DXulRr8pZPhIh813lyFV0sIOaL9tHRHCSPJT9RjhmMA55PVpR
 02Bw==
X-Gm-Message-State: AOJu0Yxy809JcIQBLtNAvy262pGjnR5Jj1WwOSSiaECKovTR0D5tVzUz
 muSrH51Oxa4KF3ffj+IdOWGaGlEhQGR22NeNAM0svfst80kPPdCjgjb27L00rKL3f8z6QADD2bz
 +
X-Gm-Gg: ASbGnctXkEqL5Z7Eo9wqYyrh2k24MP2/a+gFM/Ku86/ug3BwKz5VrHSmamkuJIVdN5w
 2Wk8C7lz26K75D84ln0Ng21VZdxyMMz0q4EREQvtjUCY3NSY5FimykVT2EzAcNn1pJjEYB2Th2c
 xSHbZYhkexWX6bwFFkXVrfj9y4Z9EKHdNb8mZDnH0A5DxwfV7tCFahVo0j95Ne09G7UnKs9j/cc
 6LnOigw7QNePMdaz/VDMvl/D7hAzB/T0Fv/04X3Ah658+i3Cn2ZS/owNGMHvNZqDjhNNFvAPkvY
X-Google-Smtp-Source: AGHT+IGov7zxqmNNPOGNNj3g/WuaS8swbG81XAYYK4L43a+kfmvLZFpB3pwXthQ5cfCyCdBHM3TvxQ==
X-Received: by 2002:a17:902:e88b:b0:215:6816:6345 with SMTP id
 d9443c01a7336-215bd1cc3e9mr146835205ad.16.1733405425580; 
 Thu, 05 Dec 2024 05:30:25 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 05/11] hw/riscv/riscv-iommu: instantiate hpm_timer
Date: Thu,  5 Dec 2024 10:29:57 -0300
Message-ID: <20241205133003.184581-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

The next HPM related changes requires the HPM overflow timer to be
initialized by the riscv-iommu base emulation.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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
index 5ce0d24359..2ec388ff3d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2281,6 +2281,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
 
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        s->hpm_timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, riscv_iommu_hpm_timer_cb, s);
         s->hpm_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
     }
 }
@@ -2294,6 +2296,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
+        timer_free(s->hpm_timer);
     }
 }
 
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index a21ab51491..6ddc59f474 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -88,8 +88,10 @@ struct RISCVIOMMUState {
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
 
     /* HPM cycle counter */
+    QEMUTimer *hpm_timer;
     uint64_t hpmcycle_val;      /* Current value of cycle register */
     uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clock */
+    uint64_t irq_overflow_left; /* Value beyond INT64_MAX after overflow */
 
     /* HPM event counters */
     GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
-- 
2.47.1


