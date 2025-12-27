Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98CDE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRC-0006UO-Rh; Sat, 27 Dec 2025 04:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR8-00066N-7c
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR6-0003bo-GM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWG6/VJifV9TnZXwGu1QSP0yR2HgFAZn9IEMSAaLbOg=;
 b=JUqGpeqJesdqmU7LbxFJsSCDe32FtgoIWAKH3ML2Po3YAJ3HpGwKdLOC+BglmUPlWrbFr5
 uoE0AX1Ccz/LVpfkuUiJPKJSl4956Ctzd/2UdeleCSu1it/sLbKeUD4zDWg0g2GSPH89Ce
 5jutZUHGTcYX4VJQmsNVDPCjYLqTlWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-CK-qF-28PpeJRLFlGiTCNg-1; Sat, 27 Dec 2025 04:18:05 -0500
X-MC-Unique: CK-qF-28PpeJRLFlGiTCNg-1
X-Mimecast-MFC-AGG-ID: CK-qF-28PpeJRLFlGiTCNg_1766827085
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d28e7960fso20576035e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827083; x=1767431883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWG6/VJifV9TnZXwGu1QSP0yR2HgFAZn9IEMSAaLbOg=;
 b=XOeKFi28dKAmEiWtFd7S7gFe5mAJ+QURveHx91eLPM0n53kAnqQHWHUuqSw1Ad/wR/
 gFiH/Ds7Vpm/+Y+HrSYcONtZ2q/BpcIqrBx7RsBEkHOxT0D80NCjRZcsRTbUXZSVq8D3
 QBmZQ3btHJKDiDZ/ya/D5gz1SDWHrQj672Yw6XURceSmxKszU0G5Uh/BucemO+0Yv5K0
 DcyxoAjBfJxHhlp2ULjp5QufI11hzdfwKWrTN2YoU7IxVIw7PrbnNfYiDcZmATvw+NMw
 Cwi3pigRyhAzth70Kc9MQf0Z1BN8qBgek+8F5Vy8mqVKjKax0868+p9oGiZ1pyDPKggp
 DpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827083; x=1767431883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BWG6/VJifV9TnZXwGu1QSP0yR2HgFAZn9IEMSAaLbOg=;
 b=clyBrALDpkxrv+DISgGvgubHiji6yVxr4fE3bRh1TEGDm/vaVyLvHjBR55zmwnme5v
 z0vcRWRUlKwJj61C26rfEdca4Nptuge6K2QsjdOB1YMs1A0U+qM2KzFglA8dIII30GWd
 VJs1EBEOKJtzgZ2xTTTZNrwIw5PAxVkc4BUFyb4WkNXk0HYMzG+B9BxbC3U4sCnqm8Uj
 We/+gsA14C1344stjX8+tpPvirL7Ot4hw0m5rBytabDtKewZ0ZcGeb2dDbvXfOtBNHGP
 U2/TmHmRWE0bgFD6jyJ7v8Ng6AUjCnhEN7rOQ+IvoRe4ujUd07E4C0sCKQQLhOc5PoKR
 +MwA==
X-Gm-Message-State: AOJu0Yy7WKVzlW4lqK62AiK80h8Omh4qN1HTZKsy3GZaB5U3gmrEUgbx
 IHIT+cutkpyyc47gnLyme2hhpQ3txuRPDRIPb/hHmzDIElNm2JGPo1LTSze0gbsIADRC0TElmw4
 5AdiIZtA9SC5PIdfBtJ8zD7NPFLD2yGx1kceFSVwks3k714SsA2L8poVFe6aNzfjjO3V1WmF8d6
 Ad7yp7U/xSiRZY3+6M5YxPflQR9v1FvcJ/ordb5tuN
X-Gm-Gg: AY/fxX7XqT1SfOmkWc9inLiUOzBe7ldeqaU1ESf9AqRHzGX49CEZrBpEe7sLxwDUnN4
 4KsULUT3TIyfEQcca7l2z/3L8qw2XnEoKMXNuFZQp4GyOv4hNPN5bVgI1NRAMh+tAKEIvPURzSC
 2Yh516jJH/6e7kqABsqRa3bFq4q6bS1UjpUreKWVCKs2QpHH5KblmRghPu7G0sXQPwNJRxWOOiA
 Fnf8eGU6mcYP8Ak7iCKG0vt4ey7AHfpuQ5kS7ilAml+1iAKyQIcyb7Hey2Q4f375Gj2N7cfuq/r
 NcUbX/2hQcW+rOMgIO1OJmYnKOu9U6ZtgyuCTJ92LDVEFkwsYGtlCPlsUS+G+chHVtlyk7MtMZK
 J9ArlreLgNwLLXPHkUN8ufNTER/xaELqEUgBQwgOypOfufENb08aw3dUfmD/nqICw/bc8kaT4g1
 X59cbV6LTV/BbAQBs=
X-Received: by 2002:a05:600c:8588:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-47d19975bb7mr226603785e9.30.1766827083511; 
 Sat, 27 Dec 2025 01:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZbqsddnCfiMEJEaKgtpOL3l8grZWLcC87/ARqLlB9vsfgcJQYQhi950J5di77SSmGojVfVw==
X-Received: by 2002:a05:600c:8588:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-47d19975bb7mr226603585e9.30.1766827082979; 
 Sat, 27 Dec 2025 01:18:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a20af0sm187586365e9.4.2025.12.27.01.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 052/153] rust/hpet: Rename HPETRegister to DecodedRegister
Date: Sat, 27 Dec 2025 10:14:39 +0100
Message-ID: <20251227091622.20725-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

HPETRegister represents the layout of register spaces of HPET timer
block and timer N, and is used to decode register address into register
enumeration.

To avoid confusion with the subsequently introduced HPETRegisters (that
is used to maintain values of HPET registers), rename HPETRegister to
DecodedRegister.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index ddfdf5185ad..3e8f5397fb2 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -96,7 +96,7 @@
 #[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
-/// Timer registers, masked by 0x18
+/// Timer register enumerations, masked by 0x18
 enum TimerRegister {
     /// Timer N Configuration and Capability Register
     CFG = 0,
@@ -109,7 +109,7 @@ enum TimerRegister {
 #[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
-/// Global registers
+/// Global register enumerations
 enum GlobalRegister {
     /// General Capabilities and ID Register
     CAP = 0,
@@ -121,7 +121,7 @@ enum GlobalRegister {
     COUNTER = 0xF0,
 }
 
-enum HPETRegister<'a> {
+enum DecodedRegister<'a> {
     /// Global register in the range from `0` to `0xff`
     Global(GlobalRegister),
 
@@ -136,7 +136,7 @@ enum HPETRegister<'a> {
 struct HPETAddrDecode<'a> {
     shift: u32,
     len: u32,
-    reg: HPETRegister<'a>,
+    reg: DecodedRegister<'a>,
 }
 
 const fn hpet_next_wrap(cur_tick: u64) -> u64 {
@@ -780,21 +780,21 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
 
         addr &= !4;
         let reg = if (0..=0xff).contains(&addr) {
-            GlobalRegister::try_from(addr).map(HPETRegister::Global)
+            GlobalRegister::try_from(addr).map(DecodedRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id < self.num_timers {
                 TimerRegister::try_from(addr & 0x18)
-                    .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
+                    .map(|reg| DecodedRegister::Timer(&self.timers[timer_id], reg))
             } else {
                 trace::trace_hpet_timer_id_out_of_range(timer_id.try_into().unwrap());
                 Err(addr)
             }
         };
 
-        // reg is now a Result<HPETRegister, hwaddr>
-        // convert the Err case into HPETRegister as well
-        let reg = reg.unwrap_or_else(HPETRegister::Unknown);
+        // reg is now a Result<DecodedRegister, hwaddr>
+        // convert the Err case into DecodedRegister as well
+        let reg = reg.unwrap_or_else(DecodedRegister::Unknown);
         HPETAddrDecode { shift, len, reg }
     }
 
@@ -804,7 +804,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
-        use HPETRegister::*;
+        use DecodedRegister::*;
         (match reg {
             Timer(timer, tn_reg) => timer.borrow_mut().read(tn_reg),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
@@ -834,7 +834,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         trace::trace_hpet_ram_write(addr, value);
 
         use GlobalRegister::*;
-        use HPETRegister::*;
+        use DecodedRegister::*;
         match reg {
             Timer(timer, tn_reg) => timer.borrow_mut().write(tn_reg, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-- 
2.52.0


