Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0332C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHa-0001dh-NS; Fri, 24 Jan 2025 04:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGU-0007rU-Vi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGT-0003zv-8L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIbFHI36QG2C9ttEM2sSjSaRWtytsQRJX6tP+6nmQnM=;
 b=OrtzcITV2c+XtBMBo2AcdhbTOPEaxN4Mgn1zbW8eCbJeznh3YFzIFY6lNEjoo2lltRj02s
 /1mn/ybyANx+GP7UOJ3yxdwaSp4M8CPKczEYaySdR3muS8h+9+YHvr9csKgB4xp1Ux+CgC
 pHQHknO/LQWV6uYpL/ZaVjZizjMdgEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-XUrUIViRNma4rOu4XttNDQ-1; Fri, 24 Jan 2025 04:46:10 -0500
X-MC-Unique: XUrUIViRNma4rOu4XttNDQ-1
X-Mimecast-MFC-AGG-ID: XUrUIViRNma4rOu4XttNDQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so808608f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711968; x=1738316768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIbFHI36QG2C9ttEM2sSjSaRWtytsQRJX6tP+6nmQnM=;
 b=GmjHVNRzzAES5OT6mUHdHrBhUhODQFhP2IXuPQrbCFDeZED26ctdqJjaBrTappJU+X
 nqnSknaXyzYnGr6RpdRomI6vEORA8dpQhy2+x67RbnuGWc2qwxtsqI6ZFFkcjoLJHnf9
 y7OGvA9qyEi1A8nm55Q0sYkYBHTPLikyKt0aoBaYTM+81HXrt9HkVRh3V85of2FowF4l
 hTJkt6tEyOD3/6lz3bQtZgCOD3pHzqi+A4lvtroisWohJsshTj/Kb3QT+pkFOU+axYdX
 7E3K8H0vVUoGLocwiCfXaHftlPXK/vVOxWNqxvXRTQzKbp64WyNfysEBO/pCVg39ZEu0
 gnxg==
X-Gm-Message-State: AOJu0YwOC9zfGUb6w8WR5t+jCaOhzSGUk7URTz+jLi97PIJp6qTjkGpq
 32fBbEnV9pR2uUq/Ml8vSqArnGenJQNeXxbhFEegjjO13NNgHXfdO1hJAFekCYliYGb495oxIgq
 PGg3t5trp4lL69O8taU923me2uo9rw+9UYHJY6ZTOZUSQvJP5hZ7sIBhmb8lPIHTTLFjzxhVcbH
 UgTX53kmwSa4F74q2ElKLm19Qaou+Nlh3uz9/ey/Q=
X-Gm-Gg: ASbGncuHDO36S3Zt3b+YGZYt2OmeGUL+FGjUkUcY5GJuO1DfZzg/lFkMCxuVZ8rfXZm
 8ud5cjlMhD6rSFAsnBsjxbbPHhTshU54kL4SyPzL2S0FJHXynSXxDm1EbHID+iXd3CZ8/ihu0OJ
 0XwDXA4RUjgneomjctzns1m6ePBP8+/NYgIUkvqqnr7eRGkkYix9RT8HNwst9vVTTpFlPYzKn0j
 K+CLBj2O9Q8PO9wpKqSK6mE36Wx0fHhlFCcK60cEUfLCJdYWWTERK+iTjb2pMYrmymuOnUVKA==
X-Received: by 2002:a5d:6c6f:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38bf566e691mr27462728f8f.3.1737711968358; 
 Fri, 24 Jan 2025 01:46:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPNxy+OyRzyAB3/p4Oq+OobI7lrZ1tlL1bYR8U0nTmz3643KHcYb0uKaQk3zX7iwXm2puZ2Q==
X-Received: by 2002:a5d:6c6f:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38bf566e691mr27462692f8f.3.1737711967869; 
 Fri, 24 Jan 2025 01:46:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17662bsm2173007f8f.4.2025.01.24.01.46.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/48] rust: pl011: remove duplicate definitions
Date: Fri, 24 Jan 2025 10:44:37 +0100
Message-ID: <20250124094442.13207-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Unify the "Interrupt" enum and the "INT_*" constants with a struct
that contains the bits.  The "int_level" and "int_enabled" fields
could use a crate such as "bitflags".

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 32 ++++++++++------------
 rust/hw/char/pl011/src/lib.rs    | 46 +++++++++++---------------------
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4fd9bdc8584..eab3cf96f4c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -191,7 +191,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                     self.flags.set_receive_fifo_empty(true);
                 }
                 if self.read_count + 1 == self.read_trigger {
-                    self.int_level &= !registers::INT_RX;
+                    self.int_level &= !Interrupt::RX.0;
                 }
                 // Update error bits.
                 self.receive_status_error_clear.set_from_data(c);
@@ -240,7 +240,7 @@ pub(self) fn write(
                 }
                 // interrupts always checked
                 let _ = self.loopback_tx(value);
-                self.int_level |= registers::INT_TX;
+                self.int_level |= Interrupt::TX.0;
                 return true;
             }
             RSR => {
@@ -364,19 +364,19 @@ fn loopback_mdmctrl(&mut self) -> bool {
         // Change interrupts based on updated FR
         let mut il = self.int_level;
 
-        il &= !Interrupt::MS;
+        il &= !Interrupt::MS.0;
 
         if self.flags.data_set_ready() {
-            il |= Interrupt::DSR as u32;
+            il |= Interrupt::DSR.0;
         }
         if self.flags.data_carrier_detect() {
-            il |= Interrupt::DCD as u32;
+            il |= Interrupt::DCD.0;
         }
         if self.flags.clear_to_send() {
-            il |= Interrupt::CTS as u32;
+            il |= Interrupt::CTS.0;
         }
         if self.flags.ring_indicator() {
-            il |= Interrupt::RI as u32;
+            il |= Interrupt::RI.0;
         }
         self.int_level = il;
         true
@@ -454,7 +454,7 @@ pub fn put_fifo(&mut self, value: u32) -> bool {
         }
 
         if self.read_count == self.read_trigger {
-            self.int_level |= registers::INT_RX;
+            self.int_level |= Interrupt::RX.0;
             return true;
         }
         false
@@ -641,16 +641,12 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
 const IRQMASK: [u32; 6] = [
     /* combined IRQ */
-    Interrupt::E
-        | Interrupt::MS
-        | Interrupt::RT as u32
-        | Interrupt::TX as u32
-        | Interrupt::RX as u32,
-    Interrupt::RX as u32,
-    Interrupt::TX as u32,
-    Interrupt::RT as u32,
-    Interrupt::MS,
-    Interrupt::E,
+    Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::TX.0 | Interrupt::RX.0,
+    Interrupt::RX.0,
+    Interrupt::TX.0,
+    Interrupt::RT.0,
+    Interrupt::MS.0,
+    Interrupt::E.0,
 ];
 
 /// # Safety
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2baacba2306..300c732ae1d 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -100,7 +100,6 @@ enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
-#[allow(dead_code)]
 mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
@@ -521,38 +520,23 @@ fn default() -> Self {
     }
 
     /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
-    pub const INT_OE: u32 = 1 << 10;
-    pub const INT_BE: u32 = 1 << 9;
-    pub const INT_PE: u32 = 1 << 8;
-    pub const INT_FE: u32 = 1 << 7;
-    pub const INT_RT: u32 = 1 << 6;
-    pub const INT_TX: u32 = 1 << 5;
-    pub const INT_RX: u32 = 1 << 4;
-    pub const INT_DSR: u32 = 1 << 3;
-    pub const INT_DCD: u32 = 1 << 2;
-    pub const INT_CTS: u32 = 1 << 1;
-    pub const INT_RI: u32 = 1 << 0;
-    pub const INT_E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-    pub const INT_MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
-
-    #[repr(u32)]
-    pub enum Interrupt {
-        OE = 1 << 10,
-        BE = 1 << 9,
-        PE = 1 << 8,
-        FE = 1 << 7,
-        RT = 1 << 6,
-        TX = 1 << 5,
-        RX = 1 << 4,
-        DSR = 1 << 3,
-        DCD = 1 << 2,
-        CTS = 1 << 1,
-        RI = 1 << 0,
-    }
+    pub struct Interrupt(pub u32);
 
     impl Interrupt {
-        pub const E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-        pub const MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+        pub const OE: Self = Self(1 << 10);
+        pub const BE: Self = Self(1 << 9);
+        pub const PE: Self = Self(1 << 8);
+        pub const FE: Self = Self(1 << 7);
+        pub const RT: Self = Self(1 << 6);
+        pub const TX: Self = Self(1 << 5);
+        pub const RX: Self = Self(1 << 4);
+        pub const DSR: Self = Self(1 << 3);
+        pub const DCD: Self = Self(1 << 2);
+        pub const CTS: Self = Self(1 << 1);
+        pub const RI: Self = Self(1 << 0);
+
+        pub const E: Self = Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | Self::FE.0);
+        pub const MS: Self = Self(Self::RI.0 | Self::DSR.0 | Self::DCD.0 | Self::CTS.0);
     }
 }
 
-- 
2.48.1


