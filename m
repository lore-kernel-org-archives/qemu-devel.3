Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E02C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 01:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPtcf-0006Cv-D8; Thu, 12 Jun 2025 21:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1uPtcd-0006Cc-Ig
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 21:54:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1uPtcb-0007C5-KE
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 21:54:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxGHHJhEto12oVAQ--.53910S3;
 Fri, 13 Jun 2025 09:54:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8evhEtoiJIYAQ--.6626S3;
 Fri, 13 Jun 2025 09:54:16 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH V1 1/2] hw/rtc: Fixed loongson rtc emulation errors
Date: Fri, 13 Jun 2025 09:31:15 +0800
Message-Id: <b83fa4c3319e372b2a7b3b7b994821441ff9ca7c.1749777563.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1749777563.git.lixianglai@loongson.cn>
References: <cover.1749777563.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8evhEtoiJIYAQ--.6626S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The expire time is sent to the timer only
when the expire Time is greater than 0 or
greater than now. Otherwise, the timer
will trigger interruption continuously.

Timer interrupts are sent using pulse functions.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>

 hw/loongarch/virt-fdt-build.c | 11 +++++++++--
 hw/rtc/ls7a_rtc.c             | 26 +++++++++++++++++---------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 728ce46699..c613131a07 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -17,6 +17,11 @@
 #include "system/reset.h"
 #include "target/loongarch/cpu.h"
 
+#define FDT_IRQ_FLAGS_EDGE_LO_HI 1
+#define FDT_IRQ_FLAGS_EDGE_HI_LO 2
+#define FDT_IRQ_FLAGS_LEVEL_HI 4
+#define FDT_IRQ_FLAGS_LEVEL_LO 8
+
 static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
@@ -416,7 +421,8 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
+                           FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
@@ -436,7 +442,8 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
                             "loongson,ls7a-rtc");
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
+                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
+                           FDT_IRQ_FLAGS_EDGE_LO_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 10097b2db7..7eca75a42a 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -145,20 +145,24 @@ static void toymatch_write(LS7ARtcState *s, uint64_t val, int num)
         now = qemu_clock_get_ms(rtc_clock);
         toymatch_val_to_time(s, val, &tm);
         expire_time = now + (qemu_timedate_diff(&tm) - s->offset_toy) * 1000;
-        timer_mod(s->toy_timer[num], expire_time);
+        if (expire_time > now) {
+            timer_mod(s->toy_timer[num], expire_time);
+        }
     }
 }
 
 static void rtcmatch_write(LS7ARtcState *s, uint64_t val, int num)
 {
-    uint64_t expire_ns;
+    int64_t expire_ns;
 
     /* it do not support write when toy disabled */
     if (rtc_enabled(s)) {
         s->rtcmatch[num] = val;
         /* calculate expire time */
         expire_ns = ticks_to_ns(val) - ticks_to_ns(s->offset_rtc);
-        timer_mod_ns(s->rtc_timer[num], expire_ns);
+        if (expire_ns > 0) {
+            timer_mod_ns(s->rtc_timer[num], expire_ns);
+        }
     }
 }
 
@@ -185,7 +189,7 @@ static void ls7a_rtc_stop(LS7ARtcState *s)
 static void ls7a_toy_start(LS7ARtcState *s)
 {
     int i;
-    uint64_t expire_time, now;
+    int64_t expire_time, now;
     struct tm tm = {};
 
     now = qemu_clock_get_ms(rtc_clock);
@@ -194,19 +198,23 @@ static void ls7a_toy_start(LS7ARtcState *s)
     for (i = 0; i < TIMER_NUMS; i++) {
         toymatch_val_to_time(s, s->toymatch[i], &tm);
         expire_time = now + (qemu_timedate_diff(&tm) - s->offset_toy) * 1000;
-        timer_mod(s->toy_timer[i], expire_time);
+        if (expire_time > now) {
+            timer_mod(s->toy_timer[i], expire_time);
+        }
     }
 }
 
 static void ls7a_rtc_start(LS7ARtcState *s)
 {
     int i;
-    uint64_t expire_time;
+    int64_t expire_time;
 
     /* recalculate expire time and enable timer */
     for (i = 0; i < TIMER_NUMS; i++) {
         expire_time = ticks_to_ns(s->rtcmatch[i]) - ticks_to_ns(s->offset_rtc);
-        timer_mod_ns(s->rtc_timer[i], expire_time);
+        if (expire_time > 0) {
+            timer_mod_ns(s->rtc_timer[i], expire_time);
+        }
     }
 }
 
@@ -370,7 +378,7 @@ static void toy_timer_cb(void *opaque)
     LS7ARtcState *s = opaque;
 
     if (toy_enabled(s)) {
-        qemu_irq_raise(s->irq);
+        qemu_irq_pulse(s->irq);
     }
 }
 
@@ -379,7 +387,7 @@ static void rtc_timer_cb(void *opaque)
     LS7ARtcState *s = opaque;
 
     if (rtc_enabled(s)) {
-        qemu_irq_raise(s->irq);
+        qemu_irq_pulse(s->irq);
     }
 }
 
-- 
2.39.1


