Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A6CC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOYg-0008Lq-W4; Tue, 20 May 2025 11:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYN-0007bu-8g; Tue, 20 May 2025 11:06:53 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYK-0002xp-L3; Tue, 20 May 2025 11:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747753609; x=1779289609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0ygDYRrNY2HTzsV3hH48eg05kLKptWcyuK6d/wsN2rc=;
 b=GYqawVCZ6Anotm+emF2dTQHCXnh4Ue/ycAUqxU71LiNaqwN2q3eqFXZo
 51Z9TIpNqjtZYgnQ4zhGSA56AHXcQnZ7TnRFdRKK65mUgsiZq9hAmHq8P
 HcGbYCEUjkJqcLcoSIXezYMwSk6Hwdk4ORlRcRAKN1bhQavaVVul4vses
 zOPj3o5GUSCqAbHt+9JT1Nq3Iwxbn5MNCUtKE1GWVZljjcsLmBpi/NzKa
 fqhmmFKH4Jf9o7f30gdiCsRmF2pDc32Ks5NRVRa1ejXy9iLuPmvjSYdqo
 IjgSAR48QwGGxWQiXOVDlck6/6Cr/1WoA/xDPyj2RD0BJynVp0xLSYQX/ Q==;
X-CSE-ConnectionGUID: Tf1amuHURgu+A7wndF3OFg==
X-CSE-MsgGUID: bPIE3tyKT1GgbRdIADIRRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59922467"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="59922467"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 08:06:47 -0700
X-CSE-ConnectionGUID: 3CK8Nq3HQF20N7CwnX8wZw==
X-CSE-MsgGUID: IdaZGzECQ9OAlh3wTGe30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144461846"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 May 2025 08:06:45 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/5] hw/timer/hpet: Reorganize register decoding
Date: Tue, 20 May 2025 23:27:46 +0800
Message-Id: <20250520152750.2542612-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520152750.2542612-1-zhao1.liu@intel.com>
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For Rust HPET, since the commit 519088b7cf6d ("rust: hpet: decode HPET
registers into enums"), it decodes register address by checking if the
register belongs to global register space. And for C HPET, it checks
timer register space first.

While both approaches are fine, it's best to be as consistent as
possible.

Synchronize changes from the rust side to C side.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Picked from <20250218073702.3299300-1-zhao1.liu@intel.com>. But because
of Rust code base change, it's enough to just sync the changes.
---
 hw/timer/hpet.c | 166 ++++++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 82 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index d1b7bc52b7be..0fd1337a1564 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -426,30 +426,11 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     uint64_t cur_tick;
 
     trace_hpet_ram_read(addr);
+    addr &= ~4;
 
-    /*address range of all TN regs*/
-    if (addr >= 0x100 && addr <= 0x3ff) {
-        uint8_t timer_id = (addr - 0x100) / 0x20;
-        HPETTimer *timer = &s->timer[timer_id];
-
-        if (timer_id > s->num_timers) {
-            trace_hpet_timer_id_out_of_range(timer_id);
-            return 0;
-        }
-
-        switch (addr & 0x18) {
-        case HPET_TN_CFG: // including interrupt capabilities
-            return timer->config >> shift;
-        case HPET_TN_CMP: // comparator register
-            return timer->cmp >> shift;
-        case HPET_TN_ROUTE:
-            return timer->fsb >> shift;
-        default:
-            trace_hpet_ram_read_invalid();
-            break;
-        }
-    } else {
-        switch (addr & ~4) {
+    /*address range of all global regs*/
+    if (addr <= 0xff) {
+        switch (addr) {
         case HPET_ID: // including HPET_PERIOD
             return s->capability >> shift;
         case HPET_CFG:
@@ -468,6 +449,26 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             trace_hpet_ram_read_invalid();
             break;
         }
+    } else {
+        uint8_t timer_id = (addr - 0x100) / 0x20;
+        HPETTimer *timer = &s->timer[timer_id];
+
+        if (timer_id > s->num_timers) {
+            trace_hpet_timer_id_out_of_range(timer_id);
+            return 0;
+        }
+
+        switch (addr & 0x1f) {
+        case HPET_TN_CFG: // including interrupt capabilities
+            return timer->config >> shift;
+        case HPET_TN_CMP: // comparator register
+            return timer->cmp >> shift;
+        case HPET_TN_ROUTE:
+            return timer->fsb >> shift;
+        default:
+            trace_hpet_ram_read_invalid();
+            break;
+        }
     }
     return 0;
 }
@@ -482,9 +483,67 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     uint64_t old_val, new_val, cleared;
 
     trace_hpet_ram_write(addr, value);
+    addr &= ~4;
 
-    /*address range of all TN regs*/
-    if (addr >= 0x100 && addr <= 0x3ff) {
+    /*address range of all global regs*/
+    if (addr <= 0xff) {
+        switch (addr) {
+        case HPET_ID:
+            return;
+        case HPET_CFG:
+            old_val = s->config;
+            new_val = deposit64(old_val, shift, len, value);
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            s->config = new_val;
+            if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
+                /* Enable main counter and interrupt generation. */
+                s->hpet_offset =
+                    ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                for (i = 0; i < s->num_timers; i++) {
+                    if (timer_enabled(&s->timer[i]) && (s->isr & (1 << i))) {
+                        update_irq(&s->timer[i], 1);
+                    }
+                    hpet_set_timer(&s->timer[i]);
+                }
+            } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
+                /* Halt main counter and disable interrupt generation. */
+                s->hpet_counter = hpet_get_ticks(s);
+                for (i = 0; i < s->num_timers; i++) {
+                    hpet_del_timer(&s->timer[i]);
+                }
+            }
+            /* i8254 and RTC output pins are disabled
+             * when HPET is in legacy mode */
+            if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                qemu_set_irq(s->pit_enabled, 0);
+                qemu_irq_lower(s->irqs[0]);
+                qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
+            } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                qemu_irq_lower(s->irqs[0]);
+                qemu_set_irq(s->pit_enabled, 1);
+                qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
+            }
+            break;
+        case HPET_STATUS:
+            new_val = value << shift;
+            cleared = new_val & s->isr;
+            for (i = 0; i < s->num_timers; i++) {
+                if (cleared & (1 << i)) {
+                    update_irq(&s->timer[i], 0);
+                }
+            }
+            break;
+        case HPET_COUNTER:
+            if (hpet_enabled(s)) {
+                trace_hpet_ram_write_counter_write_while_enabled();
+            }
+            s->hpet_counter = deposit64(s->hpet_counter, shift, len, value);
+            break;
+        default:
+            trace_hpet_ram_write_invalid();
+            break;
+        }
+    } else {
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
@@ -550,63 +609,6 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             break;
         }
         return;
-    } else {
-        switch (addr & ~4) {
-        case HPET_ID:
-            return;
-        case HPET_CFG:
-            old_val = s->config;
-            new_val = deposit64(old_val, shift, len, value);
-            new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-            s->config = new_val;
-            if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
-                /* Enable main counter and interrupt generation. */
-                s->hpet_offset =
-                    ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-                for (i = 0; i < s->num_timers; i++) {
-                    if (timer_enabled(&s->timer[i]) && (s->isr & (1 << i))) {
-                        update_irq(&s->timer[i], 1);
-                    }
-                    hpet_set_timer(&s->timer[i]);
-                }
-            } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
-                /* Halt main counter and disable interrupt generation. */
-                s->hpet_counter = hpet_get_ticks(s);
-                for (i = 0; i < s->num_timers; i++) {
-                    hpet_del_timer(&s->timer[i]);
-                }
-            }
-            /* i8254 and RTC output pins are disabled
-             * when HPET is in legacy mode */
-            if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
-                qemu_set_irq(s->pit_enabled, 0);
-                qemu_irq_lower(s->irqs[0]);
-                qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
-            } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
-                qemu_irq_lower(s->irqs[0]);
-                qemu_set_irq(s->pit_enabled, 1);
-                qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
-            }
-            break;
-        case HPET_STATUS:
-            new_val = value << shift;
-            cleared = new_val & s->isr;
-            for (i = 0; i < s->num_timers; i++) {
-                if (cleared & (1 << i)) {
-                    update_irq(&s->timer[i], 0);
-                }
-            }
-            break;
-        case HPET_COUNTER:
-            if (hpet_enabled(s)) {
-                trace_hpet_ram_write_counter_write_while_enabled();
-            }
-            s->hpet_counter = deposit64(s->hpet_counter, shift, len, value);
-            break;
-        default:
-            trace_hpet_ram_write_invalid();
-            break;
-        }
     }
 }
 
-- 
2.34.1


