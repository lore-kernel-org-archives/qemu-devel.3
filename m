Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD59EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidI-0002ZF-9K; Fri, 17 Jan 2025 04:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidG-0002YO-3B
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidE-0003Px-Jc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ+sUuwc6C6WWkzJforxNjfkV4dPtivna2iSl2/kOD4=;
 b=fHmQsLqdhuOqKEAMTdC5g+3PtgKB+qdnndMoRWZ6n8bgwY4S1iKuubPoogMJ/lAQ9CDKNV
 U975eK+vmovwH+EA6ycwwy3ZCk1+XYpA6hxedN3XJaSNV0GxjLef5ee2TVyZFjdbn0JOh9
 lF6/GhKzYm2YMYvTMerCCPOIjtnUGcQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rXBIGrUcMWWtmO5d2d66iw-1; Fri, 17 Jan 2025 04:27:10 -0500
X-MC-Unique: rXBIGrUcMWWtmO5d2d66iw-1
X-Mimecast-MFC-AGG-ID: rXBIGrUcMWWtmO5d2d66iw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aaf8396f65fso202721966b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106028; x=1737710828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ+sUuwc6C6WWkzJforxNjfkV4dPtivna2iSl2/kOD4=;
 b=DvHNCzCJHZTlJEr8ByVXYXkpWD0r0LJ4Pd42kYLqege4BAW43Gg8NgxC2HP4hyhXEn
 KP4wYSr3hXerXfBAm75gWbl1zLc4rH6/lfcVS7ClNGKoHFXogx9Drq1isVP+gkekCCtQ
 PYeXx4a4x7AexlRbzY3BPGIgSANuzzrM7ywhVGEJeXq/9Ftad32Fo5jghPQVx/B1jrUJ
 ondkPzH6arrexKQXXGaiUhkyL0/psq964SXgwLcmnwRepGOqOap2kYdtcoARK0ofM9WT
 hDfOzkBYF6LmeOvOvcuLzHHYhgWBd+UzjNB0+gEnZ/AKZnOVzgNnGKedJ358SOcsubhw
 +xMw==
X-Gm-Message-State: AOJu0YzFWCFvR1cZtbpuYwH7vIt/Ku2/Qog+7GrLMDzrOIefE+Z1vkQ/
 p+t+xSPgfsxwGsOv1mg/+udshq56XAQn+35GqZeF2Ab0vubqG0107axC0qWuZSh0QC1NcqvbEmR
 xbF1wwOcZ+vSyXqW+h5iJLRUioJftzR21iCKN/9JJ9ewV5HEVUnrEFxTMMx/Lq/FkY3CwDvSEgU
 QtJ++12YjET1DwiwINcrMtCWzRkH2xz+qqH8ZFjjg=
X-Gm-Gg: ASbGnct/J0UMbxxQTP5qwMd9181GV4DLGACH/WOS3tUDyRbX5/hMB9zpqvILejikV9g
 gfvdfNbXFOt7wB6XZS4umV8cApnW5Y1OI++kBFxThTmE6mCPOKeV+BimHtj9jBTuXyxrySltuss
 n3MXuhiy9BiCo8aEMZbIhHi2Ms+nvmUsGCHQVQtBSbt8SK3ZstzXHYu6AsidEz7QsdweqdOy08T
 rFFgzoXUr/DNZivSvXf6hZUx+tA2kB0MOqAXS03WlUbp7HTxGnUbvTp0++6
X-Received: by 2002:a17:907:2cc7:b0:aa6:9ee3:e51f with SMTP id
 a640c23a62f3a-ab38b377762mr207322666b.41.1737106028345; 
 Fri, 17 Jan 2025 01:27:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgFxSLGX9Q61z3o5ZA4AS2wJlP8GSEz8jJmPmXVBKvBnkZo5ZLjwrAObdov9L/LckRkqw2Gw==
X-Received: by 2002:a17:907:2cc7:b0:aa6:9ee3:e51f with SMTP id
 a640c23a62f3a-ab38b377762mr207319966b.41.1737106027825; 
 Fri, 17 Jan 2025 01:27:07 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcec76sm136223366b.184.2025.01.17.01.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 04/10] rust: pl011: extract CharBackend receive logic into a
 separate function
Date: Fri, 17 Jan 2025 10:26:51 +0100
Message-ID: <20250117092657.1051233-5-pbonzini@redhat.com>
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

Prepare for moving all references to the registers and the FIFO into a
separate struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 6d662865182..2e8707aef97 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -6,7 +6,7 @@
 use std::{
     ffi::CStr,
     ops::ControlFlow,
-    os::raw::{c_int, c_uint, c_void},
+    os::raw::{c_int, c_void},
 };
 
 use qemu_api::{
@@ -480,6 +480,12 @@ pub fn can_receive(&self) -> bool {
         self.read_count < self.fifo_depth()
     }
 
+    pub fn receive(&mut self, ch: u32) {
+        if !self.loopback_enabled() {
+            self.put_fifo(ch)
+        }
+    }
+
     pub fn event(&mut self, event: QEMUChrEvent) {
         if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(registers::Data::BREAK.into());
@@ -505,7 +511,7 @@ pub fn fifo_depth(&self) -> u32 {
         1
     }
 
-    pub fn put_fifo(&mut self, value: c_uint) {
+    pub fn put_fifo(&mut self, value: u32) {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -615,12 +621,9 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        if state.as_ref().loopback_enabled() {
-            return;
-        }
         if size > 0 {
             debug_assert!(!buf.is_null());
-            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
+            state.as_mut().receive(u32::from(buf.read_volatile()));
         }
     }
 }
-- 
2.47.1


