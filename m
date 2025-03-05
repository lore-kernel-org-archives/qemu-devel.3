Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7EBC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0L-0003IZ-AL; Tue, 04 Mar 2025 20:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzL-00082M-QV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:59 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzK-0000WV-0T
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22349dc31bcso110917995ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139756; x=1741744556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA9/qkL7QiKfu9QsEJoocWtmDkHHjX3b28F0moNSlvo=;
 b=ZgP8cZ98cdXiXxqE4R3zFs5EDVlHG7FtGIuv7VyFuQxzLzWn+vOwOEeiJnvT37Fafa
 LuUGlqGbub3EZNqMuRAf/dRf7mGAfUHqJO7jhAAz1wkvZAySDRW03DNUEESIp+fgAXyL
 s25IEeIPv1B94q+Q2Z3GucMPCRty1e0pYz7oAwpHdaVisPHKh/W+Evux4mT5VXdobiIf
 qDm2HgidwAX59uoGPuA+ob+ehcdBZ+i10co+IMJFbtJ+zqTcSJZm4/EwIjeJDH4y8rbw
 3hLVqLjVWUfTwz02a0nZjkSTuyflnhs7nWvlPrSiIaIN+dIfclkX3Iw6AhFfP3OFtwA0
 dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139756; x=1741744556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uA9/qkL7QiKfu9QsEJoocWtmDkHHjX3b28F0moNSlvo=;
 b=fKeQYyDDoX3dN3yoBieskWUVhFS4CGjvq1u7N8yVJtQzQmBpBIG4bp+XNHZeop4Z5P
 6unRoWRZa24di9xsWnkEXZpWH67nfxN/MK6GEh+h+w0g4W2HsDxu4sPvqTUFt7IiKHjJ
 j7d204iL5wZZKPhf5pqjHj0jdcu/ZE2iI1PMacIwD+u6UIqdbAr0HR+SO6X7I+vKo4fc
 IMDtpGHzzOtNth8TA8mO20sUShFbAbGmhuTxPVOq6UugI9MKuThS3T86D+QlidNJBeKN
 ZymiyhDzavo9R1/0iaKaUFKANhocySyF59JmMJ3cK1K2RkWAg5DBrZRb3uJ9pAfj1Vc8
 eERg==
X-Gm-Message-State: AOJu0YzdGMt0aM1OXTZHO42pHf3BH5fYmog0XB1l3eINyrOCEvgqhmpJ
 x0ESdICWKjZa6FdjY14og4phi9X578zdiXJ0gn4khP8zuxwTebj14lfGm+RRAOM=
X-Gm-Gg: ASbGncvPsTTVDqGkBbhUgTmXj+p47w3FeUHcRucECIqY0hghBcg6vzSVpE/RvyHxGlX
 nQopXTHbGHcDcqo3coBzqd7y8A5OE+58HAglDo9gzxvPo4HivWJKOVSaOnB+h4sIj+3V8kz0dlN
 XK7N8b5kNGhh2o/XouAMz1Z2itkI4kT6HYkvOcB8NoO+l3if+hCu3QkCXEQEYWfMJIo38EYwOpM
 r3sl92KeqE9zpRCTe0utD+PXMpV/kVlrwWlaq28qDW4OGqgot6xTMWDUUuApgpnoEAv+ORLwPsD
 KBCYIq9a8IiPwlCmiBZz8S96Zgr0nxhKaMMeFoIlOB7GlsvOvBMB9VkG3SKw9TjnSlh546vABqG
 5YEWjAW06oUN/BJZTsH8LCE9QLYkMTbp4XQCUNcNEVRnAeIJRjNE=
X-Google-Smtp-Source: AGHT+IGkS27zoc6gJSs9Ai4ZPrg2LUumSWCx6JnjxHRri6uF909kQpCIqom0nvXDPc3PXxHn+dfnJg==
X-Received: by 2002:a17:902:db0c:b0:220:fb23:48dd with SMTP id
 d9443c01a7336-223f1d18c76mr21495755ad.50.1741139756353; 
 Tue, 04 Mar 2025 17:55:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:55 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/59] hw/intc/aplic: refine the APLIC realize
Date: Wed,  5 Mar 2025 11:53:03 +1000
Message-ID: <20250305015307.1463560-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

When the APLIC is emulated in the kernel, the GPIO output lines to CPUs
can be remove. In this case the APLIC trigger CPU interrupts by KVM APIs.

This patch also move the code that claim the CPU interrupts to the
beginning of APLIC realization. This can avoid the unnecessary resource
allocation before checking failed.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250224025722.3999-3-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 49 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 0974c6a5db..e5714267c0 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -893,6 +893,26 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
     if (riscv_use_emulated_aplic(aplic->msimode)) {
+        /* Create output IRQ lines for non-MSI mode */
+        if (!aplic->msimode) {
+            /* Claim the CPU interrupt to be triggered by this APLIC */
+            for (i = 0; i < aplic->num_harts; i++) {
+                RISCVCPU *cpu;
+
+                cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                if (riscv_cpu_claim_interrupts(cpu,
+                    (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
+                    error_report("%s already claimed",
+                                 (aplic->mmode) ? "MEIP" : "SEIP");
+                    exit(1);
+                }
+            }
+
+            aplic->external_irqs = g_malloc(sizeof(qemu_irq) *
+                                            aplic->num_harts);
+            qdev_init_gpio_out(dev, aplic->external_irqs, aplic->num_harts);
+        }
+
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -927,23 +947,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    /* Create output IRQ lines for non-MSI mode */
-    if (!aplic->msimode) {
-        aplic->external_irqs = g_malloc(sizeof(qemu_irq) * aplic->num_harts);
-        qdev_init_gpio_out(dev, aplic->external_irqs, aplic->num_harts);
-
-        /* Claim the CPU interrupt to be triggered by this APLIC */
-        for (i = 0; i < aplic->num_harts; i++) {
-            RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
-            if (riscv_cpu_claim_interrupts(cpu,
-                (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
-                error_report("%s already claimed",
-                             (aplic->mmode) ? "MEIP" : "SEIP");
-                exit(1);
-            }
-        }
-    }
-
     msi_nonbroken = true;
 }
 
@@ -1067,15 +1070,15 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     if (riscv_use_emulated_aplic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
-    }
 
-    if (!msimode) {
-        for (i = 0; i < num_harts; i++) {
-            CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        if (!msimode) {
+            for (i = 0; i < num_harts; i++) {
+                CPUState *cpu = cpu_by_arch_id(hartid_base + i);
 
-            qdev_connect_gpio_out_named(dev, NULL, i,
-                                        qdev_get_gpio_in(DEVICE(cpu),
+                qdev_connect_gpio_out_named(dev, NULL, i,
+                                            qdev_get_gpio_in(DEVICE(cpu),
                                             (mmode) ? IRQ_M_EXT : IRQ_S_EXT));
+            }
         }
     }
 
-- 
2.48.1


