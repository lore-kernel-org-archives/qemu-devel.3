Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A54C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzP-0008TI-HJ; Tue, 04 Mar 2025 20:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdym-00070H-DM
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:28 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyk-0000Q7-PT
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2239aa5da08so54604715ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139721; x=1741744521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A73XJ0Y/Xq4uZE3+xdi4gk31mZXLIPaNqu/XCdbpndo=;
 b=jbW8h2j+uaOgBm8bjzmkWUk47kH1Wf8H7CUD7tupR9MSDKluHgm8MhoCso5U1lbf72
 nfH7slgtRJK8wTltLDzMqiZa99owN+MolO54ygy7ZVfO5fwW7dV3z7Y638xiVB0ip1nZ
 TeLvb/RjxJRs6gdVKFAEvL6W9PeCK//irii3ZNEVrYdL/3wjscZFV/c401tbVAJyrIe8
 UQXb5aWVWQMSCSgi8BhjPz/aXptyo5nnYx65I07CrCmmgpWgAifGiZU3p0sjpnialddY
 oTKBgHXOGnCcvxUDnKc55XBR71U1kz8irKVsNxcoeSeaUpY1h6XoTutV4erV6z4uMaKs
 6vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139721; x=1741744521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A73XJ0Y/Xq4uZE3+xdi4gk31mZXLIPaNqu/XCdbpndo=;
 b=p20OxmapvHfDp2MlgWRzKj5bY7SWWL0PNGv1QS2Qw799ooNVlqHKbIiGSaeSAK4uY9
 IaQ5BQPskt0uurY1w+ONJQfU/7RukaGLCFKNd0z9MgK+Z7ak6TqVAEVOUn4R0DNFkh23
 QaDVDm6FsYHftXSuqUJycHXUS5z0wFpZq1T66uWaUdDli9CP/wehpgq00wmubUeph8BS
 aXkpIQ3c8KWSEdx4e7L4t6+7aq+dWnZtJDZJBhoCoIEvgdqmUs6tWWHaE3xn3sEaBfU0
 Llp3eyVNtWr7PfNw8Fsba7Hkjmrb4mAOw7am9/0g8c4gyfkZp3hZ4qD3QzQGurl4Z6Nu
 9CbA==
X-Gm-Message-State: AOJu0Yy1xLjBagX5tqZBGS60Rv4jVl4oxRzLYPq3VQ3yAEGkQ4oe9S1H
 zyTN2csHfWu6G8zKI06fv8r4DcejEA6vKLQGqy7vlW01ddRQk8GJgDzxcbtywSU=
X-Gm-Gg: ASbGncuEVRrdFG3XW0jZ2dptWdLpzYPOw1X+n3EcM/YV46WMz2QrG8Cdc31TfxC8PYp
 ZFwDYSR74hT41xtfa9xXY9MAcOys0wgFbcm5mKDhFxQtpFZ64arxlx5sdjvTbw6639nb2sHMTZZ
 Y3GQDPqqIBIQ9YV+9nxKsXxtPzx61ABMg96wc7srHRddP541uSsd3moMGamI+DK+Omy3pGOXIRD
 zgvvn6IIMMpyjBzqBEUZrs5s69LyFAOzIZfWzfBRz2gZygjOGwjAR01txCU5IXGbALOJfBVv0IW
 lf9Jk9JstN9T+0QKpgWvuzku+UdnUj3EipBKGJVVk0mjrkwFmC2W9TDubA7U33EzRYiPUemdDCU
 QWhnERFrB9cVkYmKh1uCNSVYaBtq2FGpvjR3v4XeKQwgUGyVpxeE=
X-Google-Smtp-Source: AGHT+IH1pCGYjXFm6zL6OMokGQOVg+wtJBPP6+wXUdTjoOnnY/iRqQuJzDEEufAHcHtqfJ9EY5GyxQ==
X-Received: by 2002:a17:902:f548:b0:21f:6cb2:e949 with SMTP id
 d9443c01a7336-223f1d8427cmr16366715ad.52.1741139720962; 
 Tue, 04 Mar 2025 17:55:20 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/59] hw/riscv/riscv-iommu: instantiate hpm_timer
Date: Wed,  5 Mar 2025 11:52:51 +1000
Message-ID: <20250305015307.1463560-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The next HPM related changes requires the HPM overflow timer to be
initialized by the riscv-iommu base emulation.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.h     |  2 ++
 hw/riscv/riscv-iommu-hpm.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c     |  3 +++
 4 files changed, 42 insertions(+)

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
 
-- 
2.48.1


