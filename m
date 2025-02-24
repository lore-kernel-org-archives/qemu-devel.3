Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599E0C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOfI-0000pm-2d; Sun, 23 Feb 2025 21:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfC-0000oN-La
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmOfA-00019u-UC
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 21:57:46 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220ec47991aso51041045ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 18:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740365863; x=1740970663; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ozjelzQsJJoPTKxV2xpdh1WowibHwhpYwqjQER97V8=;
 b=QGJvn9Y+2MwYA2RlqiF0RvdhX0HKcsp/GFllg+H+Ajy5oDyKO24GeNHiKCsEyjTSb5
 fxSGQAbwBY018rZhonecJbTFcSZTpMjryZvSky8PSlxZfvZN5LtW80Heumvq0w+Nc6le
 27+R67lIlzE3Hl6OperCTUXz2yhmccr6oTnTPXNjZ31ZWFLOCdBih6YV5YfUMqdrW8gt
 N9eWK6PjtoB/qulcJwI2/pfPeX8vEY9azw1H1sMSax+DUOhodfh8il4AqOFtjp0PWeTe
 xEBWO6UxSVd+n9XzocKruGqZQIrCVSugP91EOtj2sRr/mXT5jA/rp5phLMGLERTJemUU
 79Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365863; x=1740970663;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ozjelzQsJJoPTKxV2xpdh1WowibHwhpYwqjQER97V8=;
 b=jzG2wCF+x9GUw2nCX5FlIeaNhyY9WBJeya336Z6YoIwwHaxhPuw9r9CVHpy4wreMK0
 mV5wDeRzp5PNRbuYBqArMWN17ykRQre8OQiKR7/L/K0Tx7PZIv4rD1dx9H+hgtJsWIuf
 5OYovRDMUbm3fe7TL/OPCnjXRKOT586COUT1J8j7zKkfmUPfpVaEWNidm84vT64b9IUo
 9XgNujPfZwDHtgLiSIfnm/CO5E/jus1YLWyN5vO7eeTfigGP+MKGGemWUWfIe7Zp3qvn
 8nvHUkQKqGiVej6XfS99csBly3u3jMMsAdMqSLgHBj+Q4QaxU34OUTq+fSwTGbtlpM+c
 fnqA==
X-Gm-Message-State: AOJu0YxsMHS2vuFVGDQyr8M9F0ZB1AACrS3RLFU8qKw0yrHirxNEIbqj
 IlapzBscg7leN1E6AEkBkpy+DsubeDgR28u7qL6kLVPsOa9V59G9vqv/xujTCXjsR3ISVd9oV3O
 Li14azDy5Z8YV8tEedmdICHxX+/flfl9kJBvK9sB9b/OobrD4N6aY8Y1/EzD8cTmVQKE7xN807R
 OyI8V86BZlTyPLMmiI2PlydImbfRSViYZ21vHzrJ19KQ==
X-Gm-Gg: ASbGncvDDoExuf7GbCjyvnYvVYUZrcTSDIzNIkvNGxOvK2BU7LeGDuJuRETlWWDbv1/
 nSMFbzILAE07XxR6b4q+r/wUBthM+OjQlr/7gbcvuRA7uzDd9ZrFJepDn6cCR+F1doKPfq3jnT8
 ns59+Uskrw9jiewkkW0QxesfaKGCjMtFM7wjLzqHIiOev62et0toGf3Qg9k3thsTzwEc0xzUpy2
 2l16YWxlolESwGKSgGVew1XuyiSFR76XhwLIw7blMW/uyOKv00Pcs1wSK+okUx3VvezFu8xjOLr
 sEDP7wwRgRa44+PfodGxt46+QwG2dzQzeJAUerc92CV9mhjPeFXUFixA
X-Google-Smtp-Source: AGHT+IG1sE1O1axsf4WHHrDP2PIvS+LX+8j7VRxcvSYxIptRHRI4x/YcIgHHmou0rKyC6O4gSnBvAw==
X-Received: by 2002:a17:902:d50b:b0:220:fe24:7910 with SMTP id
 d9443c01a7336-2219ff4e74emr198206675ad.15.1740365859425; 
 Sun, 23 Feb 2025 18:57:39 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490c2sm171660665ad.47.2025.02.23.18.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 18:57:38 -0800 (PST)
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
Subject: [PATCH v2 1/3] hw/intc/imsic: refine the IMSIC realize
Date: Mon, 24 Feb 2025 10:57:18 +0800
Message-Id: <20250224025722.3999-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224025722.3999-1-yongxuan.wang@sifive.com>
References: <20250224025722.3999-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x634.google.com
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

When the IMSIC is emulated in the kernel, the GPIO output lines to CPUs
and aia_ireg_rmw_fn setting can be remove. In this case the IMSIC
trigger CPU interrupts by KVM APIs, and the RMW of IREG is handled in
kernel.

This patch also move the code that claim the CPU interrupts to the
beginning of IMSIC realization. This can avoid the unnecessary resource
allocation before checking failed.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/intc/riscv_imsic.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index dc8162c0a7c9..241b12fef09f 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -349,7 +349,19 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
     CPUState *cpu = cpu_by_arch_id(imsic->hartid);
     CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
 
+    /* Claim the CPU interrupt to be triggered by this IMSIC */
+    if (riscv_cpu_claim_interrupts(rcpu,
+            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
+        error_setg(errp, "%s already claimed",
+                   (imsic->mmode) ? "MEIP" : "SEIP");
+        return;
+    }
+
     if (!kvm_irqchip_in_kernel()) {
+        /* Create output IRQ lines */
+        imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
+        qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
+
         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
         imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
         imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
@@ -361,18 +373,6 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
                           IMSIC_MMIO_SIZE(imsic->num_pages));
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
 
-    /* Claim the CPU interrupt to be triggered by this IMSIC */
-    if (riscv_cpu_claim_interrupts(rcpu,
-            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
-        error_setg(errp, "%s already claimed",
-                   (imsic->mmode) ? "MEIP" : "SEIP");
-        return;
-    }
-
-    /* Create output IRQ lines */
-    imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
-    qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
-
     /* Force select AIA feature and setup CSR read-modify-write callback */
     if (env) {
         if (!imsic->mmode) {
@@ -381,8 +381,11 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         } else {
             rcpu->cfg.ext_smaia = true;
         }
-        riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
-                                      riscv_imsic_rmw, imsic);
+
+        if (!kvm_irqchip_in_kernel()) {
+            riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
+                                          riscv_imsic_rmw, imsic);
+        }
     }
 
     msi_nonbroken = true;
@@ -464,15 +467,17 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
-    for (i = 0; i < num_pages; i++) {
-        if (!i) {
-            qdev_connect_gpio_out_named(dev, NULL, i,
-                                        qdev_get_gpio_in(DEVICE(cpu),
+    if (!kvm_irqchip_in_kernel()) {
+        for (i = 0; i < num_pages; i++) {
+            if (!i) {
+                qdev_connect_gpio_out_named(dev, NULL, i,
+                                            qdev_get_gpio_in(DEVICE(cpu),
                                             (mmode) ? IRQ_M_EXT : IRQ_S_EXT));
-        } else {
-            qdev_connect_gpio_out_named(dev, NULL, i,
-                                        qdev_get_gpio_in(DEVICE(cpu),
+            } else {
+                qdev_connect_gpio_out_named(dev, NULL, i,
+                                            qdev_get_gpio_in(DEVICE(cpu),
                                             IRQ_LOCAL_MAX + i - 1));
+            }
         }
     }
 
-- 
2.17.1


