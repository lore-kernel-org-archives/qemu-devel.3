Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73821E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Ys-00031m-8b; Wed, 18 Dec 2024 17:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yo-00030w-65
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:30 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yl-0002PH-GU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:29 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21661be2c2dso1514605ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561026; x=1735165826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqX4t4W+sF7YgqE2uzUJNl59paoesC5M/4gUQM7L+H8=;
 b=FdYdtLO1JvgXu2FWRvvnueqD9hj7AAEibo8bdxPAfD5UV9kLx7RPQGOL/hnQwfC6dE
 6UAcCvOiJ+HZucLqeOjhFPuewecCBv5oBN2JmKW5+2ANkY7w1xmjMEl6O7c/9rHLCROd
 Ypg4gTNVQ5+HeWiVbzWPRPVnrOOEC1NLZD7SLw0/a6FhiPGdlCvK1WdyFJqNdpiXsi6m
 9ytyzLL+fOS4FBE7TOAlOjtXLffJwE+6R51Iksj1VwydN0nF+yT8ZjJctPjYGFFHttl0
 GinkIPegOAMQQ4J3wexJ5RjQI5ftQJTT7aO71Kw2Tueu9C5FzSIVKIUUGSp4EAc66BQj
 01+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561026; x=1735165826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqX4t4W+sF7YgqE2uzUJNl59paoesC5M/4gUQM7L+H8=;
 b=kRg6f/zack2KnDZgLaUCqx7H+SIpSJUTJx0A7fhkvsy4xBO0sqlfty9XG2FCrwI/vS
 rsuSiwo4gwFRl3UNy1gKAXOQuz2RilHizTQPubrZyQx6Z5maV2/2Ug3Hg+MpQl6t5+iK
 d78asYbyEDcJUqMOvgScF44ojrbsyrE2S6OyZ0WnH9DfqbBm2RviWebDuMxlZADWogPj
 ZLk2EPzO3JYD1iuNpgP/wgvXXbN5HOTxk/D8VdwPsy+1PWo57/e6zRHemjHbu84jXT3K
 HSyaIkyrdlME8ThOMznJRv6Rmap98GhmgAnIPEBwtrtfj8LP+J5Nahe5379+BiQs9agA
 lOPA==
X-Gm-Message-State: AOJu0Yx/xj2CZy8ymCi+tFZzthdrVvYhyX0NGlG3s8UMSwIklnURWgyQ
 +aMiZ/h9WRDcU5qrexRb+ayTzrsASu/OQUCvI7MRCJCf5YO9h3lQcV2lsfxj
X-Gm-Gg: ASbGncuLdKY072O9CdwIiPjaK2cAS7vvaZ0nNZDU/E/IAiv+7g5UJqhrWuIweG+EP0L
 cW9tMhvi/qdkSUgfxOHsSGGoiTrrTtimlVaMEyp2S60vBzsbjaLFXjx+M/2xJYgN1Lg6KShlWIy
 s2IsfKnTKLCAa2PRXvpMjx+3kyUItaR+CLbcTj4Kkq0fF+WEStfhXxO+wgyTBVirJGHXStt1ldV
 KZsIH1MPG2eM5WEzpymzVgG5jQ8jLHfBcPnO1IgTN6em5uFTKfDfAufNAsaoQL8v5zPLl2R8vN5
 5m5AZLL8HrThwc2BLWsQQ6CUL/ml651H32Z5uTzJ1cP3zUhgli46YOX3ZKe1trs=
X-Google-Smtp-Source: AGHT+IEiJBNYCo/qiuCdC43tU6RN+sBVFKpM8aNFOT8LBzTkKJzV6XDdEc2Xk3purdMJ3CO4SvuzXA==
X-Received: by 2002:a17:902:e54f:b0:216:59d4:40e7 with SMTP id
 d9443c01a7336-219d96ab567mr15360515ad.55.1734561025791; 
 Wed, 18 Dec 2024 14:30:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/39] hw/riscv/riscv-iommu.c: add riscv_iommu_instance_init()
Date: Thu, 19 Dec 2024 08:29:33 +1000
Message-ID: <20241218223010.1931245-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Move all the static initializion of the device to an init() function,
leaving only the dynamic initialization to be done during realize.

With this change s->cap is initialized with RISCV_IOMMU_CAP_DBG during
init(), and realize() will increment s->cap with the extra caps.

This will allow callers to add IOMMU capabilities before the
realization.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 71 +++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b6b9477129..c461ebbd87 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2130,11 +2130,48 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
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
@@ -2149,29 +2186,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
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
@@ -2229,19 +2248,6 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
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
@@ -2283,6 +2289,7 @@ static const TypeInfo riscv_iommu_info = {
     .name = TYPE_RISCV_IOMMU,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
+    .instance_init = riscv_iommu_instance_init,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.47.1


