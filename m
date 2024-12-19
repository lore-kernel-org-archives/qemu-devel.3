Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9905E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByq-0006wI-Ji; Thu, 19 Dec 2024 03:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByp-0006vN-Lg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByn-0005Hf-Vf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXPLw6Fjx2MSrvo34JfpWPClVUh4XC4K5EVI43tzIqo=;
 b=SatD91oIzzrQ5AA5LSMHH0Y+4pwnfnI15s82n6H6++BmUM/HmSn6KVjB8nWhMlPYuTEPuS
 VeoWBmD5hBVfUZACg6ft2lOa+TEkjVDhjfx1eaEd3JWBbNbh7eiFavHfzOROMgEp9tVSuN
 He3l0ZhVMRIVe5SZymPkW3cWeD7pumA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-M3KqLv1ANSmHADDiUq9uMQ-1; Thu, 19 Dec 2024 03:33:54 -0500
X-MC-Unique: M3KqLv1ANSmHADDiUq9uMQ-1
X-Mimecast-MFC-AGG-ID: M3KqLv1ANSmHADDiUq9uMQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so307664f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597232; x=1735202032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXPLw6Fjx2MSrvo34JfpWPClVUh4XC4K5EVI43tzIqo=;
 b=dqFfYwQcvFyBhwEHFNXgpOhQJ95w11ePmRRjFtkgwpz9a0P/zj7MozB+GQSf6MtZWQ
 NiyygbLLXu0JoVOnvwrgNZvwSUdn8TzHNlaoVfYmkB7oFwg6t7G/wIkPdtH7T60gEpCQ
 Q47rfDcOl5pX9oJNmgY4ptlWfrMOpSlxar9TnqKGil/azmwWF40ZsEsQNm4hTIRCADkz
 2wJkQJnSENbMdCeHBKvkXCadd1ba+OFaiVagly/yy4MxOnC/gl+/NsSSQR8+dqtTJpzt
 TC5FTNjgSZpV9NTB4sw7i8C7qBj/35o+OlTQD+ltSwq7q3TnhELdBcSTQ1HWi7iueIqk
 iIoQ==
X-Gm-Message-State: AOJu0Yxlr3iLd1waOFsWbY9njJNXHR8KAYA9H03dH5DSfhgjYqHBjbQF
 dfFVIgWSnQTmK38q/MEBtmwEJctVe4t3LysczwNWo7VciaUqiC3CT49VQdLy1v2n71ZfWG2Ty7C
 JZ0T1P0AS9s3TWo0cCw8ThTWOoyxoLUit3YHR2Lyx+qlDPF2b/BH2oJilaPPzv5UyDE7DJ/cveP
 XlhYsA43Nam+DX9Z/3avk832VlAQGdBEOY4KLi
X-Gm-Gg: ASbGncuf1wYWpdC/IAJ9g/28jwAXelzMqk1NiQLYaZ9cU9ufklLCaGVaE6/h0omVflx
 DdXfdaRHCn4k31AXlXLzHNQsgTupDJj8ftxVBxIbCl4943LmJc9MLa27Kx0RIXteDKA4KhsI5Wj
 3D0b81GRsttNy5jmXFLEye6TMfTf6P5nlXPmbEkxLV50G/hvYYCLi4/UCZiyL10GlM9qbbdlLdK
 EYDy7MOmZku+3T1m2UHYrAJIMWUHJIzoq6y9AcS/+HOae+HD55oxFQDJSJh
X-Received: by 2002:a05:6000:1f81:b0:385:e94d:b152 with SMTP id
 ffacd0b85a97d-388e4d9af78mr5009201f8f.54.1734597232161; 
 Thu, 19 Dec 2024 00:33:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0JY2FVrauI0OcLzl4tIBneuvgAEnUpMI12cxK4eQqLJNHwH9lDeBxhcXY9hLRYfFqiliSkQ==
X-Received: by 2002:a05:6000:1f81:b0:385:e94d:b152 with SMTP id
 ffacd0b85a97d-388e4d9af78mr5009161f8f.54.1734597231687; 
 Thu, 19 Dec 2024 00:33:51 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e150sm970982f8f.66.2024.12.19.00.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 38/41] rust: pl011: fix break errors and definition of Data
 struct
Date: Thu, 19 Dec 2024 09:32:25 +0100
Message-ID: <20241219083228.363430-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

The Data struct is wrong, and does not show how bits 8-15 of DR
are the receive status.  Fix it, and use it to fix break
errors ("c >> 8" in the C code does not translate to
"c.to_be_bytes()[3]").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 15 ++++++------
 rust/hw/char/pl011/src/lib.rs    | 41 ++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f2ee8763d8f..5e3a9c6f581 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -30,8 +30,6 @@
 /// Fractional Baud Rate Divider, `UARTFBRD`
 const FBRD_MASK: u32 = 0x3f;
 
-const DATA_BREAK: u32 = 1 << 10;
-
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
@@ -75,7 +73,7 @@ pub struct PL011State {
     pub dmacr: u32,
     pub int_enabled: u32,
     pub int_level: u32,
-    pub read_fifo: [u32; PL011_FIFO_DEPTH],
+    pub read_fifo: [registers::Data; PL011_FIFO_DEPTH],
     pub ilpr: u32,
     pub ibrd: u32,
     pub fbrd: u32,
@@ -210,10 +208,11 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                     self.int_level &= !registers::INT_RX;
                 }
                 // Update error bits.
-                self.receive_status_error_clear = c.to_be_bytes()[3].into();
+                self.receive_status_error_clear.set_from_data(c);
                 self.update();
                 // Must call qemu_chr_fe_accept_input, so return Continue:
-                return std::ops::ControlFlow::Continue(c.into());
+                let c = u32::from(c);
+                return std::ops::ControlFlow::Continue(u64::from(c));
             }
             Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
             Ok(FR) => u16::from(self.flags).into(),
@@ -406,7 +405,7 @@ fn loopback_mdmctrl(&mut self) {
 
     fn loopback_break(&mut self, enable: bool) {
         if enable {
-            self.loopback_tx(DATA_BREAK);
+            self.loopback_tx(registers::Data::BREAK.into());
         }
     }
 
@@ -470,7 +469,7 @@ pub fn can_receive(&self) -> bool {
 
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
-            self.put_fifo(DATA_BREAK);
+            self.put_fifo(registers::Data::BREAK.into());
         }
     }
 
@@ -497,7 +496,7 @@ pub fn put_fifo(&mut self, value: c_uint) {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
-        self.read_fifo[slot] = value;
+        self.read_fifo[slot] = registers::Data::from(value);
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count == depth {
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index e3eacb0e6b9..463ae60543b 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -139,6 +139,21 @@ pub mod registers {
     //! unused thus treated as zero when read or written.
     use bilge::prelude::*;
 
+    /// Receive Status Register / Data Register common error bits
+    ///
+    /// The `UARTRSR` register is updated only when a read occurs
+    /// from the `UARTDR` register with the same status information
+    /// that can also be obtained by reading the `UARTDR` register
+    #[bitsize(8)]
+    #[derive(Clone, Copy, Default, DebugBits, FromBits)]
+    pub struct Errors {
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+        _reserved_unpredictable: u4,
+    }
+
     // TODO: FIFO Mode has different semantics
     /// Data Register, `UARTDR`
     ///
@@ -181,16 +196,18 @@ pub mod registers {
     ///
     /// # Source
     /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
-    #[bitsize(16)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
+    #[bitsize(32)]
+    #[derive(Clone, Copy, Default, DebugBits, FromBits)]
     #[doc(alias = "UARTDR")]
     pub struct Data {
-        _reserved: u4,
         pub data: u8,
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
+        pub errors: Errors,
+        _reserved: u16,
+    }
+
+    impl Data {
+        // bilge is not very const-friendly, unfortunately
+        pub const BREAK: Self = Self { value: 1 << 10 };
     }
 
     // TODO: FIFO Mode has different semantics
@@ -220,14 +237,14 @@ pub struct Data {
     #[bitsize(8)]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     pub struct ReceiveStatusErrorClear {
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
-        _reserved_unpredictable: u4,
+        pub errors: Errors,
     }
 
     impl ReceiveStatusErrorClear {
+        pub fn set_from_data(&mut self, data: Data) {
+            self.set_errors(data.errors());
+        }
+
         pub fn reset(&mut self) {
             // All the bits are cleared to 0 on reset.
             *self = Self::default();
-- 
2.47.1


