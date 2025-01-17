Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960EFC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidG-0002YW-OF; Fri, 17 Jan 2025 04:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidE-0002Xr-VD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidD-0003Pl-7k
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yg9E2XuUSyGQRjCtC8wEmW8Wp8rdiIMGDc9ZVcc615o=;
 b=gCugkKQErxGiZAZu+UEnEUKPxr6GQhlEatYJDE7Yvnc3iLJehyEQXwj4LvMin9cXPjcaeG
 SpRDhhunvksZLif1JswPs9wYYerFaWxxv5y54bU9oYrb6EsRONnygIDSS6wcMKTf8nX1qG
 b6hfGbgKYJkAoPhOI93Z6pfEz9noylk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-769Py5syN2KXodCZEe6mDA-1; Fri, 17 Jan 2025 04:27:07 -0500
X-MC-Unique: 769Py5syN2KXodCZEe6mDA-1
X-Mimecast-MFC-AGG-ID: 769Py5syN2KXodCZEe6mDA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aaf901a0ef9so166379466b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106026; x=1737710826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yg9E2XuUSyGQRjCtC8wEmW8Wp8rdiIMGDc9ZVcc615o=;
 b=GWepBezQl/bhqqSdpu8awSpBxBZ1/6q16WdQQf3OsW4nyntctUJvVVip+7lgeX8XYO
 bhA1hwjXEPT2C1jorrOujQs1CtPE0XKfbCH6ZRibmpQEs6LHE2Na9DxYZdFVRqhIAT4i
 h/y0brUscdWemC+QWYqoUMMZ5Wkw5JjcTix33oNFueZMt0UA+muSDf4Lr2LTa5wbpyxT
 5ILqvBTSL4FayXj9y7+jXS/vqp0QGRrJc6yH/rK7xZXnx70G8ISAgysTc4ytfF/Z5/OT
 A+skird4hy/cri6wL5UQ6/UA07d6jzPO8BEvGemf+dLeI6JX/XgMMQQ94XQbC1uUDAZo
 duJQ==
X-Gm-Message-State: AOJu0Yzlo2lffzhQeWrCuaOXGzTvn5eGh3zzb6/moF+kBikAjjZO+YKo
 6AELkGi5X9VsbhDrlbJDdWfEFPIejDCO0PDDcJzGpaw0+wPMWfGjOcbE1ljO0CAOJc82Lnpokf8
 Fp4C6YAHZtfB9V8Fz5D47cQqzag7FWLMkO2sPef7lZQmV+K7S0nvJGZdhuJGBjPwvob9yFosEco
 w3dOY71hps/wX6YkOJwHJOZZ3DGHMnlAisZQqzHEk=
X-Gm-Gg: ASbGncunjR8u/BnyPWZK+kEeyiYCBlkv+2IgtUXpaW40f6TTaUdfFotI9NPxTdZhD2A
 twx8xBcYUMvzl1Ac5oxCNcRconPivi9whh59HrwT9Ay8ViKh586fwE0Z8DHvacXtfE9OpokS1vz
 zd9+zoIZrkmF0JsT9Lb91mcU9THUjrCKaLoXhJOnFkFQOfc9UClQlpiNJJmnjqar28Ch19Q8lL0
 HaEAlK88BsIaXKfofXtT+5vrI1wcZIr40e/yZ+EkoDFg0FwFsyiqcPlOVWp
X-Received: by 2002:a17:907:3206:b0:aac:622:8f6 with SMTP id
 a640c23a62f3a-ab38b1ff09emr197267666b.17.1737106025785; 
 Fri, 17 Jan 2025 01:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU5XNZEKrYV9IyAuzfTQf6xXnxWnsSY9NzqVGivP0fD/0XYrPu9v560RW9MBSNGAlHZevAig==
X-Received: by 2002:a17:907:3206:b0:aac:622:8f6 with SMTP id
 a640c23a62f3a-ab38b1ff09emr197265966b.17.1737106025264; 
 Fri, 17 Jan 2025 01:27:05 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8d88fsm139383966b.140.2025.01.17.01.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
Date: Fri, 17 Jan 2025 10:26:50 +0100
Message-ID: <20250117092657.1051233-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As an added bonus, this also makes the new function return u32 instead
of u64, thus factoring some casts into a single place.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 114 +++++++++++++++++--------------
 1 file changed, 63 insertions(+), 51 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index e85e46ba0bb..6d662865182 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,6 +5,7 @@
 use core::ptr::{addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
+    ops::ControlFlow,
     os::raw::{c_int, c_uint, c_void},
 };
 
@@ -214,19 +215,11 @@ fn post_init(&self) {
         }
     }
 
-    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
+    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         use RegisterOffset::*;
 
-        let value = match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
-                let device_id = self.get_class().device_id;
-                u32::from(device_id[(offset - 0xfe0) >> 2])
-            }
-            Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
-                0
-            }
-            Ok(DR) => {
+        std::ops::ControlFlow::Break(match offset {
+            DR => {
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -243,39 +236,33 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                 self.receive_status_error_clear.set_from_data(c);
                 self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
-                let c = u32::from(c);
-                return std::ops::ControlFlow::Continue(u64::from(c));
-            }
-            Ok(RSR) => u32::from(self.receive_status_error_clear),
-            Ok(FR) => u32::from(self.flags),
-            Ok(FBRD) => self.fbrd,
-            Ok(ILPR) => self.ilpr,
-            Ok(IBRD) => self.ibrd,
-            Ok(LCR_H) => u32::from(self.line_control),
-            Ok(CR) => u32::from(self.control),
-            Ok(FLS) => self.ifl,
-            Ok(IMSC) => self.int_enabled,
-            Ok(RIS) => self.int_level,
-            Ok(MIS) => self.int_level & self.int_enabled,
-            Ok(ICR) => {
+                return ControlFlow::Continue(u32::from(c));
+            },
+            RSR => u32::from(self.receive_status_error_clear),
+            FR => u32::from(self.flags),
+            FBRD => self.fbrd,
+            ILPR => self.ilpr,
+            IBRD => self.ibrd,
+            LCR_H => u32::from(self.line_control),
+            CR => u32::from(self.control),
+            FLS => self.ifl,
+            IMSC => self.int_enabled,
+            RIS => self.int_level,
+            MIS => self.int_level & self.int_enabled,
+            ICR => {
                 // "The UARTICR Register is the interrupt clear register and is write-only"
                 // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
                 0
-            }
-            Ok(DMACR) => self.dmacr,
-        };
-        std::ops::ControlFlow::Break(value.into())
+            },
+            DMACR => self.dmacr,
+        })
     }
 
-    pub fn write(&mut self, offset: hwaddr, value: u64) {
+    fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
-        let value: u32 = value as u32;
-        match RegisterOffset::try_from(offset) {
-            Err(_bad_offset) => {
-                eprintln!("write bad offset {offset} value {value}");
-            }
-            Ok(DR) => {
+        match offset {
+            DR => {
                 // ??? Check if transmitter is enabled.
                 let ch: u8 = value as u8;
                 // XXX this blocks entire thread. Rewrite to use
@@ -290,22 +277,22 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.int_level |= registers::INT_TX;
                 self.update();
             }
-            Ok(RSR) => {
-                self.receive_status_error_clear.reset();
+            RSR => {
+                self.receive_status_error_clear = 0.into();
             }
-            Ok(FR) => {
+            FR => {
                 // flag writes are ignored
             }
-            Ok(ILPR) => {
+            ILPR => {
                 self.ilpr = value;
             }
-            Ok(IBRD) => {
+            IBRD => {
                 self.ibrd = value;
             }
-            Ok(FBRD) => {
+            FBRD => {
                 self.fbrd = value;
             }
-            Ok(LCR_H) => {
+            LCR_H => {
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
                 if self.line_control.fifos_enabled() != new_val.fifos_enabled() {
@@ -328,26 +315,26 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.line_control = new_val;
                 self.set_read_trigger();
             }
-            Ok(CR) => {
+            CR => {
                 // ??? Need to implement the enable bit.
                 self.control = value.into();
                 self.loopback_mdmctrl();
             }
-            Ok(FLS) => {
+            FLS => {
                 self.ifl = value;
                 self.set_read_trigger();
             }
-            Ok(IMSC) => {
+            IMSC => {
                 self.int_enabled = value;
                 self.update();
             }
-            Ok(RIS) => {}
-            Ok(MIS) => {}
-            Ok(ICR) => {
+            RIS => {}
+            MIS => {}
+            ICR => {
                 self.int_level &= !value;
                 self.update();
             }
-            Ok(DMACR) => {
+            DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
                     // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
@@ -562,6 +549,31 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 
         Ok(())
     }
+
+    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
+        match RegisterOffset::try_from(offset) {
+            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
+                let device_id = self.get_class().device_id;
+                ControlFlow::Break(u64::from(device_id[(offset - 0xfe0) >> 2]))
+            }
+            Err(_) => {
+                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                ControlFlow::Break(0)
+            }
+            Ok(field) => match self.regs_read(field) {
+                ControlFlow::Break(value) => ControlFlow::Break(value.into()),
+                ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
+            }
+        }
+    }
+
+    pub fn write(&mut self, offset: hwaddr, value: u64) {
+        if let Ok(field) = RegisterOffset::try_from(offset) {
+           self.regs_write(field, value as u32);
+        } else {
+            eprintln!("write bad offset {offset} value {value}");
+        }
+    }
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-- 
2.47.1


