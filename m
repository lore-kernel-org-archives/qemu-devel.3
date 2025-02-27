Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA4EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnh1k-0000K5-Bz; Thu, 27 Feb 2025 11:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1L-0008Rd-RH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnh1H-0007qO-Pu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zefJ7UnWXlqmaoCwRCJyexCJHwxXHhIzI1N/mzD03TE=;
 b=WPfs8Q8J2s4bv2xBPz6e1SgNiv5vEnxoh08T1IYuH/eEPR+8WdCEzHnkTdvvdEpH0NzZOq
 W3794g+WAdFrAc+G73+GSH3XP6XZeyEiaMwDByJscFQIIBpv/jGeHQik7D2rpguVjTxQZQ
 Qe1Sixe/t/a7U4P1w9PKFMpUMKhxyes=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341--D6adOANOfuZzZM2WAH4lw-1; Thu, 27 Feb 2025 11:45:50 -0500
X-MC-Unique: -D6adOANOfuZzZM2WAH4lw-1
X-Mimecast-MFC-AGG-ID: -D6adOANOfuZzZM2WAH4lw_1740674749
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abf16f47749so133605266b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674748; x=1741279548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zefJ7UnWXlqmaoCwRCJyexCJHwxXHhIzI1N/mzD03TE=;
 b=k35Gg/iVACf6/jKJ9X3cn1sLgmmNaEj7Df++0aZ1hK8WbFRhNNPnSYixz2f9jHwZs+
 Vz8I4au+ut5Po2ibwykMErjzLDtdMHfoFPBW/pRerz9FqyttnFZuLJItlRSRcmFReszw
 LO4mkhDEE2ns7RacN2RrubHbhLZNqZUJsDK0JE8PbRLkyeC5tgp7c6LyKvgKCerS1CUx
 Xrkgb9alE6aqV7VQXVf+uDdvYHHWg2qsIFRDQj1a8tOI0R1pzgMyqIh8taDrAZ3XalDJ
 b7MI4iCK3WUEDN1HiPf98uew90zxjwEfA74sNfPgPDU+8xGXvFiWi4sc7VbyFpsMB2nx
 /TYQ==
X-Gm-Message-State: AOJu0YxKzImYQepBbIA940PXcQzxLI9YP65NsIBA2u7dDG5zotdD+NNA
 +EhEQvf5bvIQk1LC8eKSqUbb6FENhGAK4Pv8+qq9eDtMZHc6w34pm4zhX40B41RUOd5S4BkNQt2
 JPwSp8051nrUjOgdsY0pED2dJFsDeDU3B6iKz0vAwz3omqv2XmAv64szpzbTOOPHBjn7IooUc75
 X988v8yVXoRyWbpIwTtbk/0elDXpXx2JfPwDo4v7E=
X-Gm-Gg: ASbGncvOiSgzLXckIX80T3mHB0KuhTeyJKShqEKDAQ0Kjqs8Q/HbV1QkvAgFlU3NnzQ
 7/VhEwf89XeKt61abZrcC77gS7vMzcSZRqt2i4fo/adOgHeMPQzP90i1F/CLdaA1giG1o2nBfU2
 Lx5e4wa0cFI7x9YEtdogWoFCBShdmoQuxKQ1EThpugZfBSPjd7CCw0q+0/mGGjKqEplH6skcK4/
 hdefnrD1/zQf8fRexBPI1XvcT1PjqsVj/m5I+mtjC6o9oA2WnNA6hwZBsFjhJyh5NieLNFcn/tZ
 C3I2373cWVxrjXrYxw==
X-Received: by 2002:a17:907:1c8d:b0:abf:23a7:fc6 with SMTP id
 a640c23a62f3a-abf2656e759mr13191266b.16.1740674747853; 
 Thu, 27 Feb 2025 08:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH9GAfGadHniLMOuyUNqZYDLLBNZvtPGF6ijMlgfnGohE0KjCB8TPO7n4+TCpPGm8mbx0hXg==
X-Received: by 2002:a17:907:1c8d:b0:abf:23a7:fc6 with SMTP id
 a640c23a62f3a-abf2656e759mr13187966b.16.1740674747351; 
 Thu, 27 Feb 2025 08:45:47 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0ba3dbsm148426166b.22.2025.02.27.08.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:45:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/5] rust: pl011: switch to safe chardev operation
Date: Thu, 27 Feb 2025 17:45:33 +0100
Message-ID: <20250227164538.814576-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227164538.814576-1-pbonzini@redhat.com>
References: <20250227164538.814576-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Switch bindings::CharBackend with chardev::CharBackend.  This removes
occurrences of "unsafe" due to FFI and switches the wrappers for receive,
can_receive and event callbacks to the common ones implemented by
chardev::CharBackend.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 116 +++++++------------------------
 1 file changed, 25 insertions(+), 91 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4cdbbf4b73d..2283bae71eb 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -4,16 +4,11 @@
 
 use std::{
     ffi::CStr,
-    os::raw::{c_int, c_void},
-    ptr::{addr_of, addr_of_mut, NonNull},
+    ptr::addr_of_mut,
 };
 
 use qemu_api::{
-    bindings::{
-        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
-        qemu_chr_fe_write_all, CharBackend, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
-    },
-    chardev::Chardev,
+    chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
@@ -235,7 +230,7 @@ pub(self) fn write(
         &mut self,
         offset: RegisterOffset,
         value: u32,
-        char_backend: *mut CharBackend,
+        char_backend: &CharBackend,
     ) -> bool {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
@@ -269,17 +264,9 @@ pub(self) fn write(
                     self.reset_tx_fifo();
                 }
                 let update = (self.line_control.send_break() != new_val.send_break()) && {
-                    let mut break_enable: c_int = new_val.send_break().into();
-                    // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                    // initialized in realize().
-                    unsafe {
-                        qemu_chr_fe_ioctl(
-                            char_backend,
-                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
-                            addr_of_mut!(break_enable).cast::<c_void>(),
-                        );
-                    }
-                    self.loopback_break(break_enable > 0)
+                    let break_enable = new_val.send_break();
+                    let _ = char_backend.send_break(break_enable);
+                    self.loopback_break(break_enable)
                 };
                 self.line_control = new_val;
                 self.set_read_trigger();
@@ -551,9 +538,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
                 if update_irq {
                     self.update();
-                    unsafe {
-                        qemu_chr_fe_accept_input(addr_of!(self.char_backend) as *mut _);
-                    }
+                    self.char_backend.accept_input();
                 }
                 result.into()
             }
@@ -567,21 +552,16 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
             // callback, so handle writes before entering PL011Registers.
             if field == RegisterOffset::DR {
                 // ??? Check if transmitter is enabled.
-                let ch: u8 = value as u8;
-                // SAFETY: char_backend is a valid CharBackend instance after it's been
-                // initialized in realize().
+                let ch: [u8; 1] = [value as u8];
                 // XXX this blocks entire thread. Rewrite to use
                 // qemu_chr_fe_write and background I/O callbacks
-                unsafe {
-                    qemu_chr_fe_write_all(addr_of!(self.char_backend) as *mut _, &ch, 1);
-                }
+                let _ = self.char_backend.write_all(&ch);
             }
 
-            update_irq = self.regs.borrow_mut().write(
-                field,
-                value as u32,
-                addr_of!(self.char_backend) as *mut _,
-            );
+            update_irq = self
+                .regs
+                .borrow_mut()
+                .write(field, value as u32, &self.char_backend);
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
@@ -590,15 +570,18 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         }
     }
 
-    pub fn can_receive(&self) -> bool {
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+    fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        regs.read_count < regs.fifo_depth()
+        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+        u32::from(regs.read_count < regs.fifo_depth())
     }
 
-    pub fn receive(&self, ch: u32) {
+    fn receive(&self, buf: &[u8]) {
+        if buf.is_empty() {
+            return;
+        }
         let mut regs = self.regs.borrow_mut();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(ch);
+        let update_irq = !regs.loopback_enabled() && regs.put_fifo(buf[0].into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -607,10 +590,10 @@ pub fn receive(&self, ch: u32) {
         }
     }
 
-    pub fn event(&self, event: QEMUChrEvent) {
+    fn event(&self, event: Event) {
         let mut update_irq = false;
         let mut regs = self.regs.borrow_mut();
-        if event == QEMUChrEvent::CHR_EVENT_BREAK && !regs.loopback_enabled() {
+        if event == Event::CHR_EVENT_BREAK && !regs.loopback_enabled() {
             update_irq = regs.put_fifo(registers::Data::BREAK.into());
         }
         // Release the BqlRefCell before calling self.update()
@@ -622,20 +605,8 @@ pub fn event(&self, event: QEMUChrEvent) {
     }
 
     fn realize(&self) {
-        // SAFETY: self.char_backend has the correct size and alignment for a
-        // CharBackend object, and its callbacks are of the correct types.
-        unsafe {
-            qemu_chr_fe_set_handlers(
-                addr_of!(self.char_backend) as *mut CharBackend,
-                Some(pl011_can_receive),
-                Some(pl011_receive),
-                Some(pl011_event),
-                None,
-                addr_of!(*self).cast::<c_void>() as *mut c_void,
-                core::ptr::null_mut(),
-                true,
-            );
-        }
+        self.char_backend
+            .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
     }
 
     fn reset_hold(&self, _type: ResetType) {
@@ -666,43 +637,6 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
     Interrupt::E.0,
 ];
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().can_receive().into() }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-///
-/// The buffer and size arguments must also be valid.
-pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe {
-        if size > 0 {
-            debug_assert!(!buf.is_null());
-            state.as_ref().receive(u32::from(buf.read_volatile()));
-        }
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().event(event) }
-}
-
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer for `chr`
-- 
2.48.1


