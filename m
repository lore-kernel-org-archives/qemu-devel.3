Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405FCD44D5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gB4-0001fk-1E; Wed, 06 Nov 2024 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB2-0001ek-67
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:28 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB0-0001a1-Ik
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:27 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so5788654b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900065; x=1731504865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DV1MjcpJEaxpGdQy9Gd1H5P1SEK291KM48+bJCTEyMY=;
 b=EFtgFazXrLZ4iu4+A3e44Dh3zvYFIqGIuP/S7lYhOg7h2fgpgyvbqWNIljgJSmJ0ix
 woW62nrY+qBME1BXU0AlP5JuNpmXyTLsxN4LoCepAn9ZMckPSHSzwvZKs3WdjAHEOj0Y
 /rj0O6p8DjoKG1NOWllAU2tlpjsEWwwjsIC6uTkeUXJ/htzNSPiETEJuPGm0b1h2z6+J
 Xv7I2Vfocx4eOcPsG6TQKn3u+Y3QHHVk8mZBY8muantDp4hLMRD5x+JIVu2FnDkgP0D0
 nmCm0Zt7HRbmydy4T3Ms3ar+vujYYPrb2ASUxIjU5esgvg8D/YYcLXdPtbzfaeZ9CpNF
 +XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900065; x=1731504865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DV1MjcpJEaxpGdQy9Gd1H5P1SEK291KM48+bJCTEyMY=;
 b=a3V64H9ql4VqGNbmhd07NkTHVF20WNVS/7Cb2u3J7K9NWPJaWhoLeslmjU0izb0jDy
 0ywNBWk3Iqyi0bM0j3zzXwWUXGfUo4Ne7AEGS4TcsFISOvSnMD6FFX3AHFxnO0MOVbw+
 B+ldxvTOQankhP+UTdV6B3NKZbtrrxp+3XIongtxNu4e/Y0JxofbtWOs9JK03b0gk3BA
 kisEEXe238dgbQDeNpMcLTk+hm9di4w8T/93RGokK8kqGZch1SErVDv1nll6AT++qjzw
 ZEHArM5qO68qF9Lwbf7IsVsfUD4JpSih7R6ayEIPZemknvPQNK/TnVJjvBsLMi4OBH5C
 ixOg==
X-Gm-Message-State: AOJu0YwPO2ckDwg+Bsni4CLg60uezZDwzgsmhQDG+SZUE9NXwl0aayKN
 1yugDc4wdZu4ccO5k9RI6WOuMyDZh8a5EY+L1sFxL7BEEe5SZaWVYD7BjcldPftQjZIjgBlyqGT
 4
X-Google-Smtp-Source: AGHT+IEB5oPOCmOejpH0nzi6fbQmE+UJZk87xvkXYpc4FLcMxHgPvZkwzaWVBIEQ6kjuFLWToEDaTw==
X-Received: by 2002:a05:6a00:23ca:b0:71e:6122:5919 with SMTP id
 d2e1a72fcca58-7206306ed56mr52310286b3a.20.1730900064624; 
 Wed, 06 Nov 2024 05:34:24 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:24 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 1/7] hw/riscv/riscv-iommu.c: add
 riscv_iommu_instance_init()
Date: Wed,  6 Nov 2024 10:34:01 -0300
Message-ID: <20241106133407.604587-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

Move all the static initializion of the device to an init() function,
leaving only the dynamic initialization to be done during realize.

With this change s->cap is initialized with RISCV_IOMMU_CAP_DBG during
init(), and realize() will increment s->cap with the extra caps.

This will allow callers to add IOMMU capabilities before the
realization.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu.c | 71 +++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index feb650549a..1893584028 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2096,11 +2096,48 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     }
 };
 
+static void riscv_iommu_instance_init(Object *obj)
+{
+    RISCVIOMMUState *s = RISCV_IOMMU(obj);
+
+    /* Enable translation debug interface */
+    s->cap = RISCV_IOMMU_CAP_DBG;
+
+    /* Report QEMU target physical address space limits */
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
+                       TARGET_PHYS_ADDR_SPACE_BITS);
+
+    /* TODO: method to report supported PID bits */
+    s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
+    s->cap |= RISCV_IOMMU_CAP_PD8;
+
+    /* register storage */
+    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+
+     /* Mark all registers read-only */
+    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
+
+    /* Device translation context cache */
+    s->ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
+                                         riscv_iommu_ctx_equal,
+                                         g_free, NULL);
+
+    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                         riscv_iommu_iot_equal,
+                                         g_free, NULL);
+
+    s->iommus.le_next = NULL;
+    s->iommus.le_prev = NULL;
+    QLIST_INIT(&s->spaces);
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
-    s->cap = s->version & RISCV_IOMMU_CAP_VERSION;
+    s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
@@ -2115,29 +2152,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
-    /* Enable translation debug interface */
-    s->cap |= RISCV_IOMMU_CAP_DBG;
-
-    /* Report QEMU target physical address space limits */
-    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
-
-    /* TODO: method to report supported PID bits */
-    s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
-    s->cap |= RISCV_IOMMU_CAP_PD8;
 
     /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
     s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
                         RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
 
-    /* register storage */
-    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
-
-     /* Mark all registers read-only */
-    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
-
     /*
      * Register complete MMIO space, including MSI/PBA registers.
      * Note, PCIDevice implementation will add overlapping MR for MSI/PBA,
@@ -2195,19 +2214,6 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
             "riscv-iommu-trap", ~0ULL);
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
-
-    /* Device translation context cache */
-    s->ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
-                                         riscv_iommu_ctx_equal,
-                                         g_free, NULL);
-
-    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
-                                         riscv_iommu_iot_equal,
-                                         g_free, NULL);
-
-    s->iommus.le_next = NULL;
-    s->iommus.le_prev = NULL;
-    QLIST_INIT(&s->spaces);
 }
 
 static void riscv_iommu_unrealize(DeviceState *dev)
@@ -2249,6 +2255,7 @@ static const TypeInfo riscv_iommu_info = {
     .name = TYPE_RISCV_IOMMU,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
+    .instance_init = riscv_iommu_instance_init,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.45.2


