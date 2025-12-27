Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6E4E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRD-0006X1-7O; Sat, 27 Dec 2025 04:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR9-0006DB-PH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR7-0003bv-Uz
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sg+vJcpOM9SDnQu5i+ms6oyFRoJtaCHlqpcmC/jWSQA=;
 b=h9vUGC2Ji26mBbf6jT7FXDFdcQHX+4YHf0ybRtZmJxkbJVKP8JpxURTU9dMZgyiJsRV3AV
 HMfzsebmRaMjcFeCBNH6ksIS8pBQfTar+IxywqurZBBpY0UCXGV9lMWjZK3+rWhS1jLO2A
 KXNcL3Tz0F8out/0NU3xg9f3TLQ2GQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-wLiLrZ4pOLKs6-l8BY-gOg-1; Sat, 27 Dec 2025 04:18:07 -0500
X-MC-Unique: wLiLrZ4pOLKs6-l8BY-gOg-1
X-Mimecast-MFC-AGG-ID: wLiLrZ4pOLKs6-l8BY-gOg_1766827086
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477b8a667bcso106201465e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827085; x=1767431885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sg+vJcpOM9SDnQu5i+ms6oyFRoJtaCHlqpcmC/jWSQA=;
 b=W+slPMaqdxkuyhcmoKZapYVnZr3r5m1IOpbLx5mWQBLTVPWp+rqd1K19/NoKPay0NO
 t+ILxlFfschEiPQj0wAfIPABw+fTBb0T/T1KZK/owRQ2i2bMEiZhxihMYE3GrmoxGwUL
 u2h7fHGhPh5PBns9dT3ozkoQsDQbyaWT4h0IapjdY160Pdy+UE60ySR647oLV5Ij1nd+
 mOdrcG4OtJSMG8x5FjrB9u6c8m3tbmYS2+Ztn5BIu8l6BV8AP+Q5SVfErG5qL2npXwsG
 Crz62vXxg0GUYVckvX6zrd1Jc9h57vnLFnWovUwf3nw7XXnsa6G1cyXYRwVNeaeQAHLm
 fj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827085; x=1767431885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sg+vJcpOM9SDnQu5i+ms6oyFRoJtaCHlqpcmC/jWSQA=;
 b=cxSy3pOYrsj3MVHUs+YAPs+7tnm7gFoNY8hfncnHecLa2sLMXXNrd3gr+GWjyrv+eO
 /bKybYYKbEtAGuGlp98dTakuSAi2Dlk0GyrlZDnwueqWWRJpWg5vdqNemY0dP79omcCN
 ambjG96GyEt5eIuyntQ1MzT4hOCOpQUzSmSSP7FlSmovYWl9NciBkccOaKIaqPWOqDZH
 wQnyxqvK7TR1J4iNAjYyLnyoANERSZ5THSxgbP2oA+xIunFQ1vhzJBJ8XMwv8o8jFk5k
 +K6go+keWddbsPzEOeuFRNnv3SsOFDFaDRayRtvoa0AWcj1pY84sztOfTlO2UiSZfhA/
 g/Rg==
X-Gm-Message-State: AOJu0YwZpe52KYRJxffLdRR8Do6L+IatoBlDeJw1bIgaw2Tm0kYqLMXY
 Z2Wp8WN+tQ6A016GVrUUNAHGOi1bfGX96ifdBMflqrCvlzSRv1aHYAIjWqb+JL+0QdZsw+yeZ8o
 KTx3B88FK6PgCrV4oUJ2PAMSQ+zt21k12k1VuCUhJjXvtCpZL54P2V1bgel+lvSjXOg5x1t31pF
 1Ww5fwPgwmLx0czRol1x24LUd6lfEMH0NbiygDlkO0
X-Gm-Gg: AY/fxX7HO+RlEePIwLoLvH+y2RdClpE1GSLBNyRy6XUA+u+SeRxqrdSfh4nAQO2htBK
 rbHtjv3ji4o4CvaEFEwsBDeqmF0Xucr8395Ek42Qhwt0MklgFJQ37OSr3zUjqGZ9etTdG/er7m5
 E8slfaJ2a7ogqR+39XpDUMM/Lw96lmFGhvwWEsTlEUN+ZxJcGOUPTilqYfM1bt+jboD5AhBv9QZ
 kKy99xpzXrcYO9HZbib4Z+K5c1S5V8uQp5DO50491EFSZeTKDjh67029Sk96n7LhFVwN+gRnQp1
 OGxnVzud8xoOuHz5ZdAYBln1PDwOM6fByheywFjnhYKcIOSqVihNfWd+HRUzwtPnwjG5jHo5++c
 RkStK8HiVeikxmyZ++l0cZE4tn+bBTuvKoI7wyWW1VFPQSGnXzgp1aonynMVXPxvnEgi2stDvsB
 PLQ+DR/gJ+GGwPfoU=
X-Received: by 2002:a05:600c:4e90:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-47d19594b70mr313924525e9.21.1766827084584; 
 Sat, 27 Dec 2025 01:18:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE7i6ZEnTNrEmB5MRtEzCMUrtPWXBAcpCLUqqxEId3eDGYajm90HX4xh5Fcslwv8WWVSIRYg==
X-Received: by 2002:a05:600c:4e90:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-47d19594b70mr313924195e9.21.1766827084099; 
 Sat, 27 Dec 2025 01:18:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19352306sm426326215e9.5.2025.12.27.01.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 053/153] rust/hpet: Rename decoded "reg" enumeration to "target"
Date: Sat, 27 Dec 2025 10:14:40 +0100
Message-ID: <20251227091622.20725-54-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

HPETAddrDecode has a `reg` field so that there're many variables named
"reg" in MMIO read/write/decode functions.

In the future, there'll be other HPETRegisters/HPETTimerRegisters
structs containing values of HPET registers, and related variables or
arguments will be named as "regs".

To avoid potential confusion between many "reg" and "regs", rename
HPETAddrDecode::reg to HPETAddrDecode::target, and rename decoding
related variables from "reg" to "target".

"target" is picked as the name since this clearly reflects the field or
variable is the target decoded register.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 33 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3e8f5397fb2..c5b58f8dee7 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -136,7 +136,7 @@ enum DecodedRegister<'a> {
 struct HPETAddrDecode<'a> {
     shift: u32,
     len: u32,
-    reg: DecodedRegister<'a>,
+    target: DecodedRegister<'a>,
 }
 
 const fn hpet_next_wrap(cur_tick: u64) -> u64 {
@@ -497,21 +497,20 @@ fn callback(&mut self) {
         self.update_irq(true);
     }
 
-    const fn read(&self, reg: TimerRegister) -> u64 {
+    const fn read(&self, target: TimerRegister) -> u64 {
         use TimerRegister::*;
-        match reg {
+        match target {
             CFG => self.config, // including interrupt capabilities
             CMP => self.cmp,    // comparator register
             ROUTE => self.fsb,
         }
     }
 
-    fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
+    fn write(&mut self, target: TimerRegister, value: u64, shift: u32, len: u32) {
         use TimerRegister::*;
 
         trace::trace_hpet_ram_write_timer_id(self.index);
-
-        match reg {
+        match target {
             CFG => self.set_tn_cfg_reg(shift, len, value),
             CMP => self.set_tn_cmp_reg(shift, len, value),
             ROUTE => self.set_tn_fsb_route_reg(shift, len, value),
@@ -779,34 +778,34 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
         let len = std::cmp::min(size * 8, 64 - shift);
 
         addr &= !4;
-        let reg = if (0..=0xff).contains(&addr) {
+        let target = if (0..=0xff).contains(&addr) {
             GlobalRegister::try_from(addr).map(DecodedRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id < self.num_timers {
                 TimerRegister::try_from(addr & 0x18)
-                    .map(|reg| DecodedRegister::Timer(&self.timers[timer_id], reg))
+                    .map(|target| DecodedRegister::Timer(&self.timers[timer_id], target))
             } else {
                 trace::trace_hpet_timer_id_out_of_range(timer_id.try_into().unwrap());
                 Err(addr)
             }
         };
 
-        // reg is now a Result<DecodedRegister, hwaddr>
+        // `target` is now a Result<DecodedRegister, hwaddr>
         // convert the Err case into DecodedRegister as well
-        let reg = reg.unwrap_or_else(DecodedRegister::Unknown);
-        HPETAddrDecode { shift, len, reg }
+        let target = target.unwrap_or_else(DecodedRegister::Unknown);
+        HPETAddrDecode { shift, len, target }
     }
 
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
         trace::trace_hpet_ram_read(addr);
 
-        let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
+        let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
         use DecodedRegister::*;
-        (match reg {
-            Timer(timer, tn_reg) => timer.borrow_mut().read(tn_reg),
+        (match target {
+            Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
             Global(CFG) => self.config.get(),
             Global(INT_STATUS) => self.int_status.get(),
@@ -829,14 +828,14 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
     }
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
-        let HPETAddrDecode { shift, len, reg } = self.decode(addr, size);
+        let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
 
         trace::trace_hpet_ram_write(addr, value);
 
         use GlobalRegister::*;
         use DecodedRegister::*;
-        match reg {
-            Timer(timer, tn_reg) => timer.borrow_mut().write(tn_reg, value, shift, len),
+        match target {
+            Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
             Global(CFG) => self.set_cfg_reg(shift, len, value),
             Global(INT_STATUS) => self.set_int_status_reg(shift, len, value),
-- 
2.52.0


