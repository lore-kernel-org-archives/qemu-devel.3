Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBBFC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMi-0007cT-4m; Fri, 04 Sep 2026 01:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMT-0007Lj-I7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:16 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMR-0001R7-S2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:13 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so923439a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499270; x=1789104070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aYdh5AAh9b2ZcKDg/4QSlZ9dOyvIBIFOWbrged0LF6w=;
 b=QT6gxLnGd5RabLwK22fjNZyYYd0UxQNtQT0gZUPMEVRQfyPdGF6h72TNWy6T7cPT/C
 cwcePCGJeEgeqYDItssIepVLvSLJOhenVGyPi8wHRW4mruGggQQLl9kedzHTGFNY7IMT
 VtnG6UQY9Sb2iHFFW4t5El/1poZy7fqvmoLhGYpmJBwYWd2WoQ/8Exk8to+HkzLLKpAs
 TL9f+1qLv7n+9O2FYjlNZn6z3cZ4Nj+Gf3urK1mUA42XtfTtlj1U3G2o9eb9FOm6tWqM
 WX041/DSuC/NDYsNxFl+cjJLdNJH0dJnnamBWegOg01ZBERvz62d+28SR40ORZwbmU3t
 8DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499270; x=1789104070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aYdh5AAh9b2ZcKDg/4QSlZ9dOyvIBIFOWbrged0LF6w=;
 b=ZR3otabYU29lP43zb6ZpW5SUGr0EoKvAAWLAkMk0cCUI58ctVQ+w9Vzm1FaoG1qbbT
 42U3MyHF7b3IhfGAIqdScGFiV0t7BqtS7861l9fINb21J+m2ow2Dvvkkqnzc5bAkZ5bn
 EN6aPsre8tHUYnBQ39ncC0bPPiNQwdanYHYqhcbWLjGxndX55dLkItUKXGFoQNl7xLfj
 5aBWmfN11GJSwoji51u54Fnt/RjfvMI2dKmwHgaZe5v0SNaoJx636ccEcc0PaS4EmJ+3
 eaQegamoveyqr7deLdAQOXgOj4ErhfTqGy1uHcymewpNhTabCeky/BUHQGN0mZzYAwYK
 iqeg==
X-Gm-Message-State: AFuF++ncEHLeMNQciPAtNoUwY3ZAtnaA79ze0cihGuPdMBiVph0ZY4Oe
 Giaz6vmVztqGpGRfIJVemsz/o5Q6fj6PMe6dFi3Glzo6qPP7lChtoDulrxNurA==
X-Gm-Gg: AYBFou1gmkfeBibdUCgN1d8l2D12oVi1csLidH66bG6rANKjCcWuPgiTXFXdQPyrp0q
 PzbXCTPYF++MSEhGbTcRctl9Ov599bqRdRXOOK640nZTEJyKgs7SC/tRtQvkk/Buk31sBe4yhga
 AiE/q2nDP/fk57DYKDHYEZtXgoNX05A2qvKlf5GHRxhfmNkbbOD3AUeW3AGlcO7M5WAD4IND0aN
 pkC81423IB3HSsLiqjblxrOXyu0L/JrsndelhUHIggc4n9vB8lv1ETSVl8twqKIZ+B+6JCMrNiB
 bY2DLIvDr/m+BVoMht6oE3AymgAO5iNfRFXp7jPGQpWIg0R0YCfuhreuiCNmNu+qbgbR1w6apqr
 xSADxqmfl2EKccdVskDM3HQB/sw2ixwXhsUkCeyHjYPGlRuimQy/L2pqh0NTUg2NJSWBrX30iLJ
 XpLbnqO7dkeJA9xNZ2IBXI2sKTzny6ZWN5BR8U4zVJ6U61Y0q+/0EkrzQgG+dG02Kn1Xt4yU0Py
 hWxog==
X-Received: by 2002:a05:6a21:3382:b0:3d0:a555:c823 with SMTP id
 adf61e73a8af0-3da39feab06mr5292647637.14.1788499269640; 
 Thu, 03 Sep 2026 22:21:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 24/47] hw/riscv/fdt-common, virt.c: add riscv_create_fdt_rtc()
Date: Fri,  4 Sep 2026 15:19:20 +1000
Message-ID: <20260904051943.799041-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The soon to be added 'riscv-server-ref' board will add a rtc FDT subnode
that is similar to what the 'virt' board users.  Put it into a helper to
avoid copy/pasting code.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  3 +++
 hw/riscv/fdt-common.c         | 21 +++++++++++++++++++++
 hw/riscv/virt.c               | 26 ++------------------------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index c8b25348bd..eb9db8278d 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -133,4 +133,7 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
                            uint32_t irq_phandle);
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_phandle);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 0107aadaad..ce2dcb43b4 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -828,3 +828,24 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
         qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
     }
 }
+
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_phandle)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
+                           rtc_mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "google,goldfish-rtc");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, rtc_mem->base,
+                                 2, rtc_mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", rtc_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ae809ecb5f..3a9d1e0a13 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -435,29 +435,6 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
     qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
-static void create_fdt_rtc(RISCVVirtState *s,
-                           uint32_t irq_mmio_phandle)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
-                           s->memmap[VIRT_RTC].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-        "google,goldfish-rtc");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_RTC].base,
-                                 2, s->memmap[VIRT_RTC].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
-        irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", RTC_IRQ);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
-    }
-}
-
 static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -565,7 +542,8 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
-    create_fdt_rtc(s, irq_mmio_phandle);
+    riscv_create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
+                         s->aia_type, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s)
-- 
2.55.0


