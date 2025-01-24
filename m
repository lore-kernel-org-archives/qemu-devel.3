Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14215C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHm-0002hs-He; Fri, 24 Jan 2025 04:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGX-0007t1-JY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGV-00040T-Rx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGlACdH/EqIXZ5fV9dpl3biokpD3XWX5J53CWbCvliw=;
 b=NCkE00l3R2WITQykv2GI6cpC4Pgq4JMHibAx1JpEwgNTEyupLjnwseD4kn0hvU3ihdTNed
 6xspbYhA73Nxz7v2yxdItq/eCwQRgI8ev32dRRjeL7+ijByofpeNsCJR9386u6Cx78aanD
 CULudY+qHkyGZQSDCRy5CuoLUp3xk64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-MbdS2my0On6j8WlUXLUTcQ-1; Fri, 24 Jan 2025 04:46:13 -0500
X-MC-Unique: MbdS2my0On6j8WlUXLUTcQ-1
X-Mimecast-MFC-AGG-ID: MbdS2my0On6j8WlUXLUTcQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-386333ea577so722964f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711971; x=1738316771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGlACdH/EqIXZ5fV9dpl3biokpD3XWX5J53CWbCvliw=;
 b=nkdfLgPU/P6VY0MEW2XvFbmmtluBjyvaPj50xXiW1kYdzC57S/3u5rmPeyKn6fT5Md
 9JRvfTmEKAu4i/eJIgP4zDaX2VcG+jwE3bySKmsWG933JypOrRlrkY3FvfzDV9SlGyu8
 CfOpRW8uQRWwWKSee3QaFE2+qskOr1deQgWGeAndXUeyJiON7AEwHXYQnZo9D2ICav5+
 io2exoa0LAUjAEXhQZcQd2fDSBdEuhI3rxXLLTaiWw0DE5yeztM0AErEXKHYCQzOo3oT
 nlBurrUlvnayfvih/i6SI2Eb/fTSDIswQXfMl7M1ad7V/vrvpUguTLkCSBC4O+9h0pSt
 OW9w==
X-Gm-Message-State: AOJu0YxB9uyx1jiZvYkp7Tx1dkXBdsMHig4/pGQhrGSkTf8AYKKsoWgm
 dhWSq6GyMO1YC7zaB2B7hB2pqezd+jAf2jNMlbywoKEoTh3zEzLHAbL04N0iUX9F50KIG/+eQuc
 KV4oWUduExE4VylVKKSOV8zCRk0HE/3kFFJRdrLNbe3i6RoBP7niT7yBV9ulwk+ar6PANtkJ99v
 VK/oDnd3E47T3qXHJREM1G752hDjHX2wEhysMTxgg=
X-Gm-Gg: ASbGncuVQFy1sFJkRXx+Ht4R9iz3+bwEVg/NSJDCQKtzBNIwBc1o0+JM6UQvbJj4s1u
 Wr5GChAEcRVh6uW/7wchogl/h0BGfID5i6Nt6KE5bmwKN5F+iA6452H/bRWZx+fNF3ToxEggrji
 zP1RZG1bM4bVENmxHLdaxbwhBo55Vjb9kKWE9fLG9uuFv9M6tlltSO9KXwRaVWYPmgGRKNvArsx
 BzeC18DNnYmVVF55/UxeiORhXotM5gDqNY83nXBhR2+9cN46x24zTjYGs9gX/jRAdKMfoSI2w==
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr35368799f8f.38.1737711971514; 
 Fri, 24 Jan 2025 01:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESvIu5c2mJcLqK4Exh1VbSoR5Anib++QtMt0Ybw2FTzn3FrrYZlE4rGqbGbQujEvrzcRlJkQ==
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr35368768f8f.38.1737711971051; 
 Fri, 24 Jan 2025 01:46:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb062sm2151664f8f.71.2025.01.24.01.46.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/48] rust: pl011: drop use of ControlFlow
Date: Fri, 24 Jan 2025 10:44:39 +0100
Message-ID: <20250124094442.13207-46-pbonzini@redhat.com>
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

It is a poor match for what the code is doing, anyway.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 39 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 9a0ba87aa5b..e916ea11884 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,7 +5,6 @@
 use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
-    ops::ControlFlow,
     os::raw::{c_int, c_void},
 };
 
@@ -177,10 +176,11 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 }
 
 impl PL011Registers {
-    pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
+    pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
         use RegisterOffset::*;
 
-        ControlFlow::Break(match offset {
+        let mut update = false;
+        let result = match offset {
             DR => {
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
@@ -196,8 +196,9 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                 }
                 // Update error bits.
                 self.receive_status_error_clear.set_from_data(c);
-                // Must call qemu_chr_fe_accept_input, so return Continue:
-                return ControlFlow::Continue(u32::from(c));
+                // Must call qemu_chr_fe_accept_input
+                update = true;
+                u32::from(c)
             }
             RSR => u32::from(self.receive_status_error_clear),
             FR => u32::from(self.flags),
@@ -216,7 +217,8 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
                 0
             }
             DMACR => self.dmacr,
-        })
+        };
+        (update, result)
     }
 
     pub(self) fn write(
@@ -540,31 +542,26 @@ fn post_init(&self) {
     }
 
     pub fn read(&mut self, offset: hwaddr, _size: u32) -> u64 {
-        let mut update_irq = false;
-        let result = match RegisterOffset::try_from(offset) {
+        match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
-                u32::from(device_id[(offset - 0xfe0) >> 2])
+                u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 0
             }
-            Ok(field) => match self.regs.borrow_mut().read(field) {
-                ControlFlow::Break(value) => value,
-                ControlFlow::Continue(value) => {
-                    update_irq = true;
-                    value
+            Ok(field) => {
+                let (update_irq, result) = self.regs.borrow_mut().read(field);
+                if update_irq {
+                    self.update();
+                    unsafe {
+                        qemu_chr_fe_accept_input(&mut self.char_backend);
+                    }
                 }
-            },
-        };
-        if update_irq {
-            self.update();
-            unsafe {
-                qemu_chr_fe_accept_input(&mut self.char_backend);
+                result.into()
             }
         }
-        result.into()
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
-- 
2.48.1


