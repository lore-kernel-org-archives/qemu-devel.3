Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0521DC02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjiO-0005nu-Nu; Tue, 28 Jan 2025 06:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcji9-0005n2-6f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcji4-0006eC-GB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738063485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDmJeSVmqIl7bo9t4FXgMCJM+eGvynx39oSnnpzw4Vc=;
 b=HHT7nrNkpUwCAbOqbGtFENc+E3uiomO/FrXjqsaaw6V3mEXvMxNE9qJe6i+yR5WhXqNT0i
 nVYUI10Zg+ZAaCo3HWBNtKdiRkuOChqIkPH7oqMD/GM+glfZ5E3T2kHZ9+YqQx/AATle/b
 PkjpkNc4/lddWtApQr1tigmt5tF6Slk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ViQg625PPTKuqULjej2DMQ-1; Tue, 28 Jan 2025 06:24:44 -0500
X-MC-Unique: ViQg625PPTKuqULjej2DMQ-1
X-Mimecast-MFC-AGG-ID: ViQg625PPTKuqULjej2DMQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436289a570eso42186235e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063483; x=1738668283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDmJeSVmqIl7bo9t4FXgMCJM+eGvynx39oSnnpzw4Vc=;
 b=MuFDSKfOuYIYTLqp5KG1vqhwWjWcoSd4xy+67f4eeZS1UP3F+tBsE6vjPclU0dNrOF
 ZgwxRsNDJr9hFhCogf2s8sh9w1X1uMQ3BS6wazuvvN6UOWX2rIM/bIPOXw7JKCDfJx3Y
 2wovp5hbyrBb2NdptAaojjwjGDNMFdl2Pe7mUn/XZzroyWVI8NWepNs+t2pD3Z9XF6jJ
 gXF4lu7HYKhTNSlR5Nn0A4V0gRUX5qpExb295LZF2YxgcQTsoJLA89z7MWnqqKm4Q/XD
 v40/9jZ/3sZqgvfvClewZszLZemBk0a4oipJeLD/E/Zzb/cWCwsUc5Bhs6rW1p8WlAX6
 3cZw==
X-Gm-Message-State: AOJu0YwiGhfuoU6sS4dT4TgG0xCgWiJSnYyIRvFKlzOO5ylQcip+vbD8
 +Uj4bZhWqeFg/0JoW0zG5d7ovmvkcMdn+LyLZ/T2YsiQ2gdzcX8jg9AtNj0lKWfUexPN/XqxVTu
 X7nFEGuM3GGIFsllvKtzrI9h5RHEnjF79pnI1ndCu7bmcXfpVbor8IPIVDXtFuaVKMlhpfDRpM1
 h7+ZR8ASLYfezYOAN7VzXJIw+nh9KECWVeJ5br5/E=
X-Gm-Gg: ASbGncsdN4tDk7HGIf6tyOBq4xMZb5SYuXkdRgs+F0bKbCz3/hKTw6h3H8Pcgmh83at
 wB7JCDn9C7FrKCTJpia8TQUVi88V/4hLESroJJn8HQoFADU6l88K0sekPcXkjwul+htdJ/cP2zA
 Z4XGNIITEAxpg10mLTteCkURMwedKY938ExBWjtmhNXajd2mYoFFVKVvRqtumE9wtIir8/VL4FP
 Zj762mVqiG+QrMzdgRhn+FS4JlVF7bsnaFP5sc6p7Q51agKmbC+B77FbUO8hAEPMAvr14PHeiMh
 aHAinG/P
X-Received: by 2002:a05:600c:8712:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438913ce0b7mr442513465e9.7.1738063482769; 
 Tue, 28 Jan 2025 03:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQKhoKExLrGRSpOKcEzT5ZPqo+NdAP79dD53KIeoliCQTSt0kY2PRWp1Y2atec5lZbNyWTGA==
X-Received: by 2002:a05:600c:8712:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438913ce0b7mr442513225e9.7.1738063482147; 
 Tue, 28 Jan 2025 03:24:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c066sm163846705e9.29.2025.01.28.03.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 03:24:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/48] rust: pl011: extract conversion to RegisterOffset
Date: Tue, 28 Jan 2025 12:24:39 +0100
Message-ID: <20250128112439.1225171-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128112439.1225171-1-pbonzini@redhat.com>
References: <20250128112439.1225171-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 137 ++++++++++++++++++-------------
 rust/hw/char/pl011/src/lib.rs    |   2 +-
 2 files changed, 79 insertions(+), 60 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c8496eeb1b6..64e7234f627 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,6 +5,7 @@
 use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
+    ops::ControlFlow,
     os::raw::{c_int, c_uint, c_void},
 };
 
@@ -222,19 +223,11 @@ fn post_init(&self) {
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
+        ControlFlow::Break(match offset {
+            DR => {
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -251,69 +244,53 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                 self.receive_status_error_clear.set_from_data(c);
                 self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
-                let c = u32::from(c);
-                return std::ops::ControlFlow::Continue(u64::from(c));
+                return ControlFlow::Continue(u32::from(c));
             }
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
             }
-            Ok(DMACR) => self.dmacr,
-        };
-        std::ops::ControlFlow::Break(value.into())
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
-                // ??? Check if transmitter is enabled.
-                let ch: u8 = value as u8;
-                // XXX this blocks entire thread. Rewrite to use
-                // qemu_chr_fe_write and background I/O callbacks
-
-                // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                // initialized in realize().
-                unsafe {
-                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
-                }
+        match offset {
+            DR => {
                 self.loopback_tx(value);
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
@@ -336,26 +313,26 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
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
@@ -570,6 +547,48 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 
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
+            Ok(field) => {
+                let result = self.regs_read(field);
+                match result {
+                    ControlFlow::Break(value) => ControlFlow::Break(value.into()),
+                    ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
+                }
+            }
+        }
+    }
+
+    pub fn write(&mut self, offset: hwaddr, value: u64) {
+        if let Ok(field) = RegisterOffset::try_from(offset) {
+            // qemu_chr_fe_write_all() calls into the can_receive
+            // callback, so handle writes before entering PL011Registers.
+            if field == RegisterOffset::DR {
+                // ??? Check if transmitter is enabled.
+                let ch: u8 = value as u8;
+                // SAFETY: char_backend is a valid CharBackend instance after it's been
+                // initialized in realize().
+                // XXX this blocks entire thread. Rewrite to use
+                // qemu_chr_fe_write and background I/O callbacks
+                unsafe {
+                    qemu_chr_fe_write_all(&mut self.char_backend, &ch, 1);
+                }
+            }
+
+            self.regs_write(field, value as u32);
+        } else {
+            eprintln!("write bad offset {offset} value {value}");
+        }
+    }
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2baacba2306..a35fff8d44d 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -43,7 +43,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, qemu_api_macros::TryInto)]
+#[derive(Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
 enum RegisterOffset {
     /// Data Register
     ///
-- 
2.48.1


