Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CC4C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOfK-0000qv-9r; Sun, 23 Feb 2025 21:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfE-0000og-DC
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:50 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfC-0001A2-AS
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c4159f87so52511555ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740365864; x=1740970664; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bFiHejFbGdbLneg1PMfRNsRHZmY62voLe0kDtLpm8UU=;
 b=cSB+T8F1MBI1a4rGfb8VQfQPm+i8Fxr5RDeNWZjDRSbtU7yju+gt0hiuvk13ALjPRK
 yJJHaTz+n+/EH8+hn/JHw2sUbaBIjNLcsFswQTKy5eGGu/oKuIqPCmkRY2fYgGpMqMuO
 fVpe8S6mLbOYC23YS2FT534C1OC8dlA++nsb5EJ6Kff8h5Yn8ezeyon9AmmOkspAwGkY
 MlTprNrvZ6uGj52vjJD6XIKeyjnrn6OE4ho5JY/HcFilmijD6fgG83LIj5pzTpqmCZJS
 DSEtHyOcwCRnSvqWOojNKdwS1OVFEsaa1j+l0E0k+cywbShKGIWpGDSKO1c4/0tRXXGr
 R++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365864; x=1740970664;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFiHejFbGdbLneg1PMfRNsRHZmY62voLe0kDtLpm8UU=;
 b=JTL3XlFcitHx5GHaInyf2y34ruFYib2/uFCIrtyHWwJTHvLjRsrlhT2iMzLGe4h9cs
 nhYjCXFq7IQaKYU2mcRFyvyTya9Xvm8kWEZ/wIR+W7ejieRPtGVa4luPGL9nfu9cL4mv
 m/qnEDpQjehc9x/EgMwyUA/FBB35QVEniTzf7FHRhaJVuvJDEJoq5zRV3XKRYbnHY+Vg
 RBkAoVsAFqBBmuX7CrPcC2/DYbs+gEiSPVT6X9WCK9yW864u64C3ZC5Ks1rhAgZ5j6kR
 M5cUfdabcbnfdHkQX/AZ2nm5YYi5ud9Y3CQS0hyIg1qJwE/sQFfV3ZzN3HHWb8tdR2Xi
 iIqA==
X-Gm-Message-State: AOJu0YwwIHVVOVBhwYeHWDILQ2tt8Wpdlx3yAJdFlGeEeQoVFKQGnyij
 D6D5BWKPvlVrHck+g4YBUh/tKQzLfVG/nT9zEa0ggr9fx/wNtSD5yfXGlGZkJQ0QySJCiF7pXen
 Uoxw7GwrOPy9CGS7GJAW+zGsZ++V0VYFGfooXfi9dBrNWvRAxvSECZiIOOqy/QQGoKaQt1M5sod
 rQ/TXy5DYuLb+7Ew7A0VMFxhsZOuUDKNr4SkLaJhBjjQ==
X-Gm-Gg: ASbGnctsoHsIJgFJmhvG1+GvCvu5mKQdFu4Qn1hU4U4ueX59meN/7kcouFE6bszG4kK
 1Lyzb0EjiticdRIHvjbi+1T4CoDqJSPwfkgGB67cjWX3P6CfGmU4Se5f0CBNrpjCbXgaN99xQN1
 5pceG1uT/YBXMibv/sxEsxZHy6X9xyPueXNBHe8wDuopyQHrCMx0c8/gJJcQ4z3aqWM8XKp8YEu
 tR7KrHApXzWU6sX1vJKrfNv3E64Updd0bGLdubALbKbQwyDEEYzduAyxjNwnPB6nmDNeQEs5dOU
 fO9jB81H44w8jWaj0tJ1KfPytMq7VOxxk7eLtsr2Vw1KA7ojOnVJs44a
X-Google-Smtp-Source: AGHT+IEuT95L670KejSIr7xKuMc3nv+d93LmpYKidJ3/LNcSnFG2A8WJYcFiBHy0bHT9wVRLWg6S9w==
X-Received: by 2002:a17:902:ea08:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-2219ffa36c6mr220846915ad.41.1740365864232; 
 Sun, 23 Feb 2025 18:57:44 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490c2sm171660665ad.47.2025.02.23.18.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 18:57:43 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 2/3] hw/intc/aplic: refine the APLIC realize
Date: Mon, 24 Feb 2025 10:57:19 +0800
Message-Id: <20250224025722.3999-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224025722.3999-1-yongxuan.wang@sifive.com>
References: <20250224025722.3999-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x635.google.com
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

When the APLIC is emulated in the kernel, the GPIO output lines to CPUs
can be remove. In this case the APLIC trigger CPU interrupts by KVM APIs.

This patch also move the code that claim the CPU interrupts to the
beginning of APLIC realization. This can avoid the unnecessary resource
allocation before checking failed.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/intc/riscv_aplic.c | 49 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 0974c6a5db39..e5714267c096 100644
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
2.17.1


