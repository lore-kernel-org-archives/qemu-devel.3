Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665FC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvd-0008Hd-UM; Fri, 30 May 2025 03:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvc-0008H9-M2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvZ-0006p3-39
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8R2NDNeKdof1XYmLpuB33fJuNAIe3X76vJDwEfHawrU=;
 b=GzmSu+jAxuk90xkPtBqngM2j+vazT3siCvhrJqtnMzGcKzE1nIlzDQUgBIHivkYFHPC8CH
 TjV1QHc9Lxty+HQmaPzMSSK3KrLVQnt1xahXAuYtKFppmQrW4xMxjVulobVlwmR3PYgtOp
 VIJB+8wXI9QdgrvMMDTc0K9vzwzvrbY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-WZ3JeAUSMD2DO-HqWILQgg-1; Fri, 30 May 2025 03:13:14 -0400
X-MC-Unique: WZ3JeAUSMD2DO-HqWILQgg-1
X-Mimecast-MFC-AGG-ID: WZ3JeAUSMD2DO-HqWILQgg_1748589193
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad88ac202c0so142382966b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589193; x=1749193993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8R2NDNeKdof1XYmLpuB33fJuNAIe3X76vJDwEfHawrU=;
 b=AU04XzyCcMg+O0loBxttkhf94PbkkEeh6eJ1HxqF9HJIvt4zyR1V9Nvu9jDvzlYaSd
 iF+c5Bpr2z15xds7uw0QdqguL91r3VbBLaKZzKRkN15wEg3qsOvSX6DTdLuoTqKs8wLd
 GJpRb8gbmnzW/tk2Gsn+hgeAgVK3f0F/b7JNK8s7i4Cf6snI3kMMT1UltGTKRXmNve5N
 sXWVyaKmaH7M8JSptnkuX+sbU16stTZ0lRT6RVzOdf6SbhJ0X5fn4EcDnfUJgQJD2t7m
 /xQIRTFc747GD8g1QzdWIuoyBhZBMtmray1MpuJi7CWTER/84mpizbyVk+ueei5icMqQ
 wBYQ==
X-Gm-Message-State: AOJu0YzMgdMIu4YPNBi8Kwvag6yHPlkKksUmEVxnCj1eqyOLogU6qyAK
 Ms9cG95nBfEmampx6I7MFD0txdMLl8ApUFNs4rvyUOfK2ODBHYH4HiI7o0QU8RDuxoRzsMvK5ly
 6HzpGk34m/h9QoScYyPH6yd1M7/j7N8annsdeF4jrr5NywH47qnensD1lNuzoEurZ0uaKmOuwR0
 gA19qu+56LIha9BzmJWdi81btsTY4+J1l4x76wYtRo
X-Gm-Gg: ASbGncv292GOTbop7IMNbto97CRC1PumAdxEKzv8e8v0apUhNwLJDNavF0YPlW6NtaQ
 7Q+Jt/yy0YiYCtOuXdabi6vErP+914XfoVNJfY/AaMkxCLvsR47UZq7M5u4DfID7V6YmExcFMEH
 x2u/0Y7GzfqyKcF5EDfhgGqEhPPNcZ341/snzo7NGvhFQ+jCjJHhTcqWrm+9VeUyDxC7U7zJOKS
 RTwsVi61DkXhePc7eyPOKyBjLo3Z3I35L0Xy/vihTm2BonSKQh5HgVutBidmd8mUbCD1E2TTACr
 scH4ZZh/cV4riA==
X-Received: by 2002:a17:907:7f04:b0:ad8:adf3:7d6d with SMTP id
 a640c23a62f3a-adb32c9fd0amr181181966b.21.1748589192847; 
 Fri, 30 May 2025 00:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwT5A/COwu5Lb1/RKPZsYfB4c1A7e5TIhfZ3yjF1E0NGfxt1HzWCF9/muaE+lX0k210Q91pQ==
X-Received: by 2002:a17:907:7f04:b0:ad8:adf3:7d6d with SMTP id
 a640c23a62f3a-adb32c9fd0amr181179966b.21.1748589192357; 
 Fri, 30 May 2025 00:13:12 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb2efaacfasm142171166b.116.2025.05.30.00.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/77] hw/timer/hpet: Reorganize register decoding
Date: Fri, 30 May 2025 09:11:38 +0200
Message-ID: <20250530071250.2050910-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

For Rust HPET, since the commit 519088b7cf6d ("rust: hpet: decode HPET
registers into enums"), it decodes register address by checking if the
register belongs to global register space. And for C HPET, it checks
timer register space first.

While both approaches are fine, it's best to be as consistent as
possible.

Synchronize changes from the rust side to C side.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250520152750.2542612-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 166 ++++++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 82 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index d1b7bc52b7b..0fd1337a156 100644
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
2.49.0


