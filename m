Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB92C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CK-0002vp-A0; Thu, 03 Sep 2026 08:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CI-0002ua-7J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:38 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CF-0005JF-MV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=UraalP3
 BuET368LJ+o/Ghs+5KCmoIzl6E8S2UEhpBdbdO8rddwZs2WLKqwlHHIqldtTY0CkFg9Y0Y
 VsTLKOkK/jtnEZUt4jmOEvJ9PFAGdeaK7S18EGjEwD/RYfiBXcjV2vyIyYhxdWFuB1rH5L
 QhwF8PuDWep8DiE8tSnlaKb+fri+MtO1uVaSUN78DHl2S35ZcqAu2kzXCUUc2rcZlguhLR
 7F0ZqWtXmbsqCH4WthzS7l2QFnDaSl6OahiIk2DHxOqrIuYD/6KmqqNZjWjp+8hODywIGE
 N+Xno3EoDYEtdvFSGJqZxG2QDv7V22TapSxcJfKPI+2Xh1fq93r6UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=+
 g6cefjhdRUctd5g+HiBEWs0l+/VE1gDPtxIHqa5foI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=My1KLrF5btLnTAfxPSVGHqQHWICAHWSPaGQCjmk97eTalNmO2NiciHuYTNRBw+mRFoTg
 WnyiMTny/qU740GfAIdcgTd83hcelFxoGZjhpSFxPd95ADuklh4oo304gFb0zOWSIY4fa4
 UpIlx2UUCxoz+usX2KonwlC4wzknbgm/421HAX3hhP1r2xvD7YSoy+E8+OtCIY6fmnRqIX
 tJyM7etviztYqsgkYsiIkvm8utJLoblcxyf11NaLtFCF7HLwfVYWSbdtIetH+OZ1wojto6
 cd9w3NdesMcu4XPYDXoNVwJgfGMMOtC/mohnZTOw06qq7746pMRdYkg38Pc4Z66Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=HgYyOulL; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=4Ht1w6U8;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=+g6cefjh
 dRUctd5g+HiBEWs0l+/VE1gDPtxIHqa5foI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=HgYyOulLVdMwqrC5CAPbxss0+OFFsoFD8ay
 b74c8yZ7mO7oUKLomVAKWRMJfTO94X+kzu4aFaUx67TSoIMZ4zdo9OSPLWg1wDavkdm/+T
 Dejvkv93emVaFVyFh+ISq04tGade9PATICRAkWHyKH/SMHB6NEht5kr38dC211lxl2hKgY
 MGf3J/UB8ADmMMBZcYJ6ENh8T5GFW6lzVcSMRvaURfYt+GDsKTrGZhJqwqrPm2Gb7Yl4Lv
 /iBEnN06UP/B7sj1OUpP75LvdYROVBIoKMUvi1fBs9o0vN5PCRRrTwIthtG0D+IX5cjJP2
 yhwhpdM1glZZYg4lnoV3dz2t79A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=+g6cefjhdRUctd5g+HiBEWs0l+/VE1gDPtxIHqa5foI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=4Ht1w6U8hJ9PxgxGjG
 AInkjH2z+8EoFa1t7YSufsHVeSlw1dItyaVwAccnnni2jjkuXdXzFExhKoe5EX0ju+AQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 8478a0f5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:28 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ac7e1cfb;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 15/25] hw/mips: expose Octeon reset CSRs
Date: Thu,  3 Sep 2026 14:02:03 +0200
Message-ID: <20260903120510.34876-16-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Expose reset clock, soft reset and processor power registers through the
shared CSR window. Keep mutable register state and reset handling in the
reset controller.
---
 hw/mips/octeon.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 0caf088adf..007fc4b537 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -24,6 +24,8 @@
 #include "system/cpus.h"
 #include "system/memory.h"
 #include "system/reset.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/error-report.h"
 #include "qemu/atomic.h"
@@ -124,6 +126,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
 #define OCTEON_CSR_BASE             0x1180000000000ULL
 #define OCTEON_CSR_SIZE             0x100000000ULL
+#define OCTEON_RST_BOOT             0x6001600
+#define OCTEON_RST_SOFT_RST         0x6001680
+/* U-Boot uses the reset controller to park and release secondary cores. */
+#define OCTEON_RST_PP_POWER         0x6001700
+#define OCTEON_RST_BOOT_C_MUL_SHIFT 30
+#define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -168,6 +176,7 @@ struct OcteonPeripheralClass {
 
 struct OcteonRstState {
     OcteonPeripheralState parent_obj;
+    GHashTable *regs;
     uint64_t rst_pp_power;
 };
 
@@ -294,11 +303,18 @@ void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value)
 
 bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
 {
+    if (reg == OCTEON_RST_SOFT_RST) {
+        return octeon_reg_lookup(s->rst->regs, reg, value);
+    }
     return octeon_reg_lookup(s->csr_bank->values, reg, value);
 }
 
 static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
 {
+    if (reg == OCTEON_RST_SOFT_RST) {
+        octeon_reg_store(s->rst->regs, reg, value);
+        return;
+    }
     octeon_reg_store(s->csr_bank->values, reg, value);
 }
 
@@ -869,6 +885,33 @@ static void octeon_ciu3_nmi(OcteonState *s, uint64_t mask)
     }
 }
 
+static void octeon_rst_pp_power_write(OcteonState *s, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    uint64_t old = s->rst->rst_pp_power;
+    uint64_t changed;
+    unsigned int cpu;
+
+    value = octeon_write64(old, addr, value, size) &
+            octeon_present_cpu_mask(s);
+    s->rst->rst_pp_power = value;
+    changed = old ^ value;
+
+    for (cpu = 1; cpu < s->cpu_count; cpu++) {
+        uint64_t mask = 1ULL << cpu;
+
+        if (!(changed & mask)) {
+            continue;
+        }
+        if (value & mask) {
+            async_run_on_cpu(CPU(s->cpu[cpu].cpu), octeon_cpu_park_work,
+                             RUN_ON_CPU_NULL);
+        } else {
+            octeon_start_cpu(s, cpu);
+        }
+    }
+}
+
 static const MemoryRegionOps octeon_ciu_ops = {
     .read = octeon_ciu_read,
     .write = octeon_ciu_write,
@@ -1082,6 +1125,19 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
     hwaddr reg = addr & ~7ULL;
     uint64_t value;
 
+    switch (reg) {
+    case OCTEON_RST_BOOT:
+        value = ((uint64_t)(s->cpu_hz / s->ref_hz) <<
+                 OCTEON_RST_BOOT_C_MUL_SHIFT) |
+                ((uint64_t)(s->io_hz / s->ref_hz) <<
+                 OCTEON_RST_BOOT_PNR_MUL_SHIFT);
+        return octeon_read64(value, addr, size);
+    case OCTEON_RST_PP_POWER:
+        return octeon_read64(s->rst->rst_pp_power, addr, size);
+    default:
+        break;
+    }
+
     if (!octeon_csr_lookup(s, reg, &value)) {
         value = 0;
     }
@@ -1095,6 +1151,16 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
     hwaddr reg = addr & ~7ULL;
     uint64_t old;
 
+    if (reg == OCTEON_RST_SOFT_RST && value) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    }
+
+    if (reg == OCTEON_RST_PP_POWER) {
+        octeon_rst_pp_power_write(s, addr, value, size);
+        return;
+    }
+
     if (!octeon_csr_lookup(s, reg, &old)) {
         old = 0;
     }
@@ -1354,6 +1420,7 @@ static void octeon_rst_reset_hold(Object *obj, ResetType type)
         opc->parent_phases.hold(obj, type);
     }
 
+    g_hash_table_remove_all(rst->regs);
     rst->rst_pp_power = octeon_secondary_cpu_mask(rst->parent_obj.board);
 }
 
@@ -1411,6 +1478,16 @@ static GHashTable *octeon_reg_table_new(void)
                                  g_free, g_free);
 }
 
+static void octeon_rst_init(Object *obj)
+{
+    OCTEON_RST(obj)->regs = octeon_reg_table_new();
+}
+
+static void octeon_rst_finalize(Object *obj)
+{
+    g_hash_table_destroy(OCTEON_RST(obj)->regs);
+}
+
 static void octeon_csr_bank_init(Object *obj)
 {
     OCTEON_CSR_BANK(obj)->values = octeon_reg_table_new();
@@ -1594,6 +1671,8 @@ static const TypeInfo octeon_machine_types[] = {
         .name = TYPE_OCTEON_RST,
         .parent = TYPE_OCTEON_PERIPHERAL,
         .instance_size = sizeof(OcteonRstState),
+        .instance_init = octeon_rst_init,
+        .instance_finalize = octeon_rst_finalize,
         .class_init = octeon_rst_class_init,
     },
     {
-- 
2.55.0


