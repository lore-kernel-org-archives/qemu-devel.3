Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC790C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwM8-0006Od-RK; Mon, 17 Feb 2025 03:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwM2-0005nX-Up
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:51 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwLz-00017f-GK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220e989edb6so75440115ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780385; x=1740385185; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ozjelzQsJJoPTKxV2xpdh1WowibHwhpYwqjQER97V8=;
 b=iYIptDrr0MNcSQezoWXB8h8wrkiBaA0LyxzjSzDB2oXYGyuD/2J8N8Htm+O3kS58/X
 6opYK1qTCzfLQoFBeWyzLghGj10rinMaiMzeWjQ1XrNHP/uo171FVyyRw/woRCx01Jmq
 Wbxphlg+gZio6Enq1XYym7mpMO9L2zbvuCXQHFqPIbxZ6QC8uaL9g6m6hipx7QPSYgVB
 xbPXmJYDJqNPANcyklN6tyw4TJBkBCBASEUKWuLntq6gFUq4ONDaTaRkS5rvuFAzDDN7
 fwRy29TkbIuVoi+LxXLoZRLT/s3u7tLNUiodGXebmhP8roN/zb9qNAOMaEeVvXWdCPSz
 RJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780385; x=1740385185;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ozjelzQsJJoPTKxV2xpdh1WowibHwhpYwqjQER97V8=;
 b=OzsP1fGD1OdJUd3Y+3lo0yDtE60MhCkq96vLd960voSYhlDwvdcb3pnydbd6J/LqBn
 /QdL1RSvgVtIYXpB8eFqize14K+ncOiXB340N6A7AOjmuJjxtpw0cnt0P14KxqGDkrtx
 UMuUmAReZafcsTYWEODG9VnwbCW8Y7rlAbfvfiFd6JgtQz5iIc/zm9VSWR17ez9Gs2Z0
 TbgVFgK3tYCrsAeMHUVZMmGnGc+FXM2Fb384QMHthB9CemhQ0dpPKsRe/oXXRd39iY77
 4qyYEHpEnN8wv8N8FtRbXdIz98Gm36RfxH3sS/w0pNjEog2r5D1ErmZ93ZhkTdfvYiw8
 1hbg==
X-Gm-Message-State: AOJu0Yxjt4IQnQ4vv5lvqwwlou09s0sFi/BQB2T5tBDuxxy072StKHeL
 vo3+bCX4p77SwPbLHR+wdApOamFXjMOZceRj5nAjtArq4MaUSLGG4I/re867hxX+CA3PsPEge/h
 T9JJvYU5oQJK8Ds8JZ8c1c1MBSiqVLOMGVVli9ysppTA+UQInxD9h+6OFkU6K2nrPXrRfxh66q6
 N/e7Jd3Qg4GOiqE3HqPeJ8+3pmAaHbTImKJvYzxDyqJw==
X-Gm-Gg: ASbGncunUBmB+MbpncOhBFwqjAu0GGe5cyQf3ppc5DEDMs92OkVroKvVPIOzcyTSUrg
 zJZkv9OwTNF33Slf0C+czW7Uecq/kr+rBJ2SHW4ql21UjcB+vw/cqZKeh7gSvky1japwu/2bDLP
 2t3JZiR3hb5ILBzrdsMeTM7xSHNyzKtP6F4nTTk5jRlgLS/nrZTuhDY+TM8xxmkzPngVtkY56XY
 Wq6EOdkAGEYDPigAWLY5oEt9gvwD8z4LWPRlA5CX84fdmf2mlfveY+Pt5BuQcLg6d1Ds0OC2t9P
 7/prC1Tgm9sM3Gzq1gPUoBt/zOKJlMGhhagA6hj2xxQqFw==
X-Google-Smtp-Source: AGHT+IHzY+4aOAR9Ut00oi38jDpZU/SDp5EwXRrSPm4IkbWNifFpv6ni+3Ie9+7VGE/thjAfwGq0EA==
X-Received: by 2002:a17:902:f543:b0:21f:542e:dd0a with SMTP id
 d9443c01a7336-221040a99d9mr123103125ad.41.1739780385455; 
 Mon, 17 Feb 2025 00:19:45 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d5e6sm66023445ad.173.2025.02.17.00.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:19:45 -0800 (PST)
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
Subject: [PATCH 2/4] hw/intc/imsic: refine the IMSIC realize
Date: Mon, 17 Feb 2025 16:19:24 +0800
Message-Id: <20250217081927.10613-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081927.10613-1-yongxuan.wang@sifive.com>
References: <20250217081927.10613-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x62e.google.com
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


