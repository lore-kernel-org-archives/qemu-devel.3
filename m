Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A1E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRp-0000hk-LI; Sat, 27 Dec 2025 04:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRn-0000Rf-EY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRk-0004MK-Ae
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObGR5P7eTjQgNjfbpSHVJGhDzxLZp1RWBcBtzTbVYA0=;
 b=dWYKaApuBsWpMPZhYBqNXZPme/Jgcqzu0HFbClpjt0UEVHz9t0jSYnJDGobsCOzR9UlwS/
 Jjgbls7HIVG9+VujEwg1iwlf5kBXQHHMScG5+7y+6JxfiuRV3c6OLumkR8gsqm4RmPUL9F
 ZLxOta8buy0gFLWy07NWm0l4TSYZ2m0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-BTREEH9pOPmExVTcGAh8QQ-1; Sat, 27 Dec 2025 04:18:41 -0500
X-MC-Unique: BTREEH9pOPmExVTcGAh8QQ-1
X-Mimecast-MFC-AGG-ID: BTREEH9pOPmExVTcGAh8QQ_1766827120
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso6146228f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827119; x=1767431919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ObGR5P7eTjQgNjfbpSHVJGhDzxLZp1RWBcBtzTbVYA0=;
 b=nH9vqNbGjEGwvVZntOx2UF+7w0xwYI5aGb5gn8WFbQSHWBgsjG7egsUA9Se7dypeMb
 s6epwAKl4R+5UqenH/23HuOtZ2NNbO0cyFxrjMxoq/QsOgKSofMOZ/3uTqxUfbWXrgwQ
 0r0gjPKw4T5/ybWIKzZLut55aJo6mvivLcZ+yKVhLCMtyw2m/MWdfYCUVYlIoDz0BBIB
 bPbPJ8PKoQrmoAT8XWYnOwOowrQ0AWarur36/NifeAYREXMS6aaw0/hoVt3BX0XFdVGz
 NhmwmDDxdzG24viBGIoJgIEak1WB3avB1U5j3snOl/7Ze27589HZYsris4jXxGSaRU7R
 tloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827119; x=1767431919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ObGR5P7eTjQgNjfbpSHVJGhDzxLZp1RWBcBtzTbVYA0=;
 b=soi0/5r9BmHONZKINFcnL2ip5eJfWn9z8HlXTNg2+ai+/J0BrlDGLRhaUPiRKX8Rwn
 AfMcGhZFJgS7J0rLZAjOtA+aHkjBj47P61Uud5hA/1zMn/buuHVxPnVfKQTL0jTOZK0C
 WEs6WK2tVbv4kxIBMVk4CRMro9ZbtmJcedZBmz5okpzWr/SGa9DWYApqfeEwCz85t93j
 lIGPWe7l+5n4haavnAor5kz8ix5fBaRyo1Az11847mVebQe5gTdQaJmeiSuNU4w7dOd0
 YtVqgn9TiXPtwZd3nUu7v7pYjs+puh3XfbJgfijgoqn00+fgGJlhLDpZUkcogAqpBKco
 DmIQ==
X-Gm-Message-State: AOJu0YxSceijn8NZv3c28uLr+LLfogynRXp2UkhmaEv+uZQAAeh0MbN2
 0RUi2hf/IR96/WOD3i1Wqn0UjFz81FGzUkEwFUtqKDJdmDbnT5p0SaYqQmXxattjF2Ilf0CB7Zx
 JmmsOM1LJ0q5spE7Gr4EGuPm5GqN6+JUg9JsJiMxIR/rlDI/7XZUArT9FSjTOyUTwxK4qIsAP5n
 1Us0ljjn2+qkbRySqZZgxgfkbgosnsIyPiPeqkABo2
X-Gm-Gg: AY/fxX6oK+0YHz57sRDTQ86+BDphM3uOLLa5arDRDco/NTY/FMwaTU2OIRF07iKL1Xa
 Z8RpMBYAtAzWuu8kAsRlwigb8EfvtwQZ0qt90AsRrNNiPLUW28w874ZWJvik8ofq+/kkN4BQtBW
 Shb8stKl6Jf0q1zQJ8o8aZ5RcPJQPs7oeVLIioIZQsr585K10ag64xGCH6Xn6OGCuSDMjWumfGJ
 FQ/ftijOsB4TLHLFy7Tt28iYI86AM2bQLP25h8nuCILz4PqYINrUd5LMWCQOUMcOCmdhjbhvfLT
 Fybq1rbnXToeDn3db5VKBALN84o7WPS1/us++QcqoUt882yanMpvMMX83KHMZT10Ah+8QbSuwqJ
 5+g61/5SzSOFGariM7kmPgE9GF9cIkYajAhn8VYlKm1akKzzjK6dFijrSjjXqskwupgCopo69H3
 /DVlHWe0djP8p/OUo=
X-Received: by 2002:a05:6000:1848:b0:432:851d:217e with SMTP id
 ffacd0b85a97d-432851d21e9mr4731432f8f.44.1766827119456; 
 Sat, 27 Dec 2025 01:18:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp4G70cRqOwUzzRouwH/RfFU8lZ/fsjLcVDuwwhPTZe4VcF8kRCmyODWIqhtAArf6LjuRVFA==
X-Received: by 2002:a05:6000:1848:b0:432:851d:217e with SMTP id
 ffacd0b85a97d-432851d21e9mr4731403f8f.44.1766827118898; 
 Sat, 27 Dec 2025 01:18:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm48905304f8f.33.2025.12.27.01.18.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 069/153] rust/hpet: change wrap_flag to a bool
Date: Sat, 27 Dec 2025 10:14:56 +0100
Message-ID: <20251227091622.20725-70-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is more precise, and makes it possible to use bool::then_some().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index a0c122d42bb..3166688e4e3 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -193,7 +193,7 @@ pub struct HPETTimerRegisters {
     period: u64,
     /// timer pop will indicate wrap for one-shot 32-bit
     /// mode. Next pop will be actual timer expiration.
-    wrap_flag: u8,
+    wrap_flag: bool,
     /// last value armed, to avoid timer storms
     last: u64,
 }
@@ -377,7 +377,7 @@ fn set_timer(&self, regs: &mut HPETRegisters) {
         let cur_tick: u64 = regs.get_ticks();
         let tn_regs = &mut regs.tn_regs[self.index as usize];
 
-        tn_regs.wrap_flag = 0;
+        tn_regs.wrap_flag = false;
         tn_regs.update_cmp64(cur_tick);
 
         let mut next_tick: u64 = tn_regs.cmp64;
@@ -385,7 +385,7 @@ fn set_timer(&self, regs: &mut HPETRegisters) {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
             if !tn_regs.is_periodic() && tn_regs.cmp64 > hpet_next_wrap(cur_tick) {
-                tn_regs.wrap_flag = 1;
+                tn_regs.wrap_flag = true;
                 next_tick = hpet_next_wrap(cur_tick);
             }
         }
@@ -501,7 +501,7 @@ fn reset(&self, regs: &mut HPETRegisters) {
         tn_regs.config |=
             (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
         tn_regs.period = 0;
-        tn_regs.wrap_flag = 0;
+        tn_regs.wrap_flag = false;
     }
 
     /// timer expiration callback
@@ -519,13 +519,11 @@ fn callback(&self, regs: &mut HPETRegisters) {
                 tn_regs.cmp = tn_regs.cmp64;
             }
             Some(tn_regs.cmp64)
-        } else if tn_regs.wrap_flag != 0 {
-            tn_regs.wrap_flag = 0;
-            Some(tn_regs.cmp64)
         } else {
-            None
+            tn_regs.wrap_flag.then_some(tn_regs.cmp64)
         };
 
+        tn_regs.wrap_flag = false;
         if let Some(tick) = next_tick {
             self.arm_timer(regs, tick);
         }
@@ -1038,7 +1036,7 @@ fn snapshot_migration_state(
         target.cmp = tn_regs.cmp;
         target.fsb = tn_regs.fsb;
         target.period = tn_regs.period;
-        target.wrap_flag = tn_regs.wrap_flag;
+        target.wrap_flag = u8::from(tn_regs.wrap_flag);
         self.qemu_timer
             .snapshot_migration_state(&mut target.qemu_timer)?;
 
@@ -1068,7 +1066,7 @@ fn restore_migrated_state(
         tn_regs.cmp = source.cmp;
         tn_regs.fsb = source.fsb;
         tn_regs.period = source.period;
-        tn_regs.wrap_flag = source.wrap_flag;
+        tn_regs.wrap_flag = source.wrap_flag != 0;
         self.qemu_timer
             .restore_migrated_state(source.qemu_timer, version_id)?;
 
-- 
2.52.0


