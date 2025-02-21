Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478FBC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRm-0007ay-4v; Fri, 21 Feb 2025 12:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRe-0006yy-W7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRc-0001SA-3q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KajmiXkvjrUlRNrAa7EleOjJePFNbnltU4TduUDEJc=;
 b=ASitGiMwpc3yKzvZMiJT1ESqf1DMpvblYvsYwJwOQO2CJV80YA8UqM6pyNw6LodXyXQOct
 jD1C8edppgGPyCqk8amUDewuZUPDzALFSPrPV+epLfwbAAySSj3cNg0cQnaJcCJpMDB5bz
 Wxavfs94EhjKU8kn5egl3j6ayZXzKDQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-PR21IyH8OtOYt0mb-iSWdg-1; Fri, 21 Feb 2025 12:04:03 -0500
X-MC-Unique: PR21IyH8OtOYt0mb-iSWdg-1
X-Mimecast-MFC-AGG-ID: PR21IyH8OtOYt0mb-iSWdg_1740157442
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2f438fb6so2734315f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157441; x=1740762241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KajmiXkvjrUlRNrAa7EleOjJePFNbnltU4TduUDEJc=;
 b=Jf1jkG8TJIbWAozsqW3ZB4VFtruQujbsNmukbQyCPg2Hhv8CCpAQzk/b6+Zm2fnBtn
 CqO+KZaMlN+2OgBWa3S8aQX+CfLUGnAxLZYp1IQZwTwwSPjARNGuxmTVFSBrg9YKbT1v
 YxJ8scaiOr/YgjbS4DFvbBqQrU4S5p+ECcgfrAMcym/Y9v86y7qFiOpahJqaQ//qTND9
 ziT0STpskczVzVK/tWXafNWyvI7ml1RIH47EPYcrVuDyJxW+vJRw4/XZc49eKBlzKrbT
 L0uACcj7hceCdTWFDN1y6mdFaAB8P9dNRznk29o+0VolK0QlnZjkiJI35jQcUW9Rar4R
 2JEg==
X-Gm-Message-State: AOJu0YzZpc31/NL+c/Y2jOj3gf/fDh1zQRsnKcPc9jF/CoO8QmN8N2HI
 acC0HyyVjEMHRqpFQaAJUerMoeA+fe9R1nIa/X6aE6fmhTEMGZ3EKQbLCLhd5n4tiAsudpi+8P4
 WjQW1vthLQnIaZMhDP7SQVFmkmCm2VmrxzsLpJX6b9RamHwfVGh9Bxy7+K67tjzrm2AMWQhoS34
 gf/I5Hcz4BbVosqXfwhGAKTN4HeNBte5J1xvGFgGQ=
X-Gm-Gg: ASbGncsmdkTHzJptPsmgt5Ph6Nikc9qHFsxVgnNBdLxWVxilWO8bqJR2QEVJsah84rj
 YbSPxucBvXvmPCOckI49W4xUYNx5fES6IaW0+2RiN0wcsl+7Hma+jOOLnaM4F5BhktCyTRIKt03
 N3k9Yul3dkQNnWD7ylBOf7E/4PPi4+NsRmWqtBdIORZFCojm1QyyCVP1Hd/5GAcD9uP/3G6Zp6Z
 LqCxB1jQSLlZ0nr5lnWwdRhmbPFJvAVpTn50CE4Rb3itNIuUuYp7QHHU7w5Buumg4msdmTfwVFx
 z6cffV4diKWwr58vmQs=
X-Received: by 2002:a5d:59ad:0:b0:38f:30c7:eae4 with SMTP id
 ffacd0b85a97d-38f6f0c289emr3369804f8f.52.1740157441240; 
 Fri, 21 Feb 2025 09:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Rqw5HLoCQNAcp/eBta75SgW0yjnziketJS8tDJpcLwitcrgIL/4Kh4z5OBz53O2IsmHRWw==
X-Received: by 2002:a5d:59ad:0:b0:38f:30c7:eae4 with SMTP id
 ffacd0b85a97d-38f6f0c289emr3369718f8f.52.1740157440502; 
 Fri, 21 Feb 2025 09:04:00 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f252dsm22580065e9.22.2025.02.21.09.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 08/15] rust: timer: wrap QEMUTimer with Opaque<>
Date: Fri, 21 Feb 2025 18:03:35 +0100
Message-ID: <20250221170342.63591-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  7 -------
 rust/qemu-api/src/timer.rs | 24 +++++++++++++++++-------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index 8ed10b6624e..16c76c493f3 100644
--- a/meson.build
+++ b/meson.build
@@ -4087,13 +4087,6 @@ if have_rust
   foreach enum : c_bitfields
     bindgen_args += ['--bitfield-enum', enum]
   endforeach
-  c_nocopy = [
-    'QEMUTimer',
-  ]
-  # Used to customize Drop trait
-  foreach struct : c_nocopy
-    bindgen_args += ['--no-copy', struct]
-  endforeach
 
   # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
   #
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index a593538917a..0305a0385ad 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -7,10 +7,23 @@
 use crate::{
     bindings::{self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType},
     callbacks::FnCall,
+    cell::Opaque,
 };
 
-pub type Timer = bindings::QEMUTimer;
-pub type TimerListGroup = bindings::QEMUTimerListGroup;
+/// A safe wrapper around [`bindings::QEMUTimer`].
+#[repr(transparent)]
+#[derive(Debug, Default, qemu_api_macros::Wrapper)]
+pub struct Timer(Opaque<bindings::QEMUTimer>);
+
+unsafe impl Send for Timer {}
+unsafe impl Sync for Timer {}
+
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
+
+unsafe impl Send for TimerListGroup {}
+unsafe impl Sync for TimerListGroup {}
 
 impl Timer {
     pub const MS: u32 = bindings::SCALE_MS;
@@ -21,10 +34,6 @@ pub fn new() -> Self {
         Default::default()
     }
 
-    const fn as_mut_ptr(&self) -> *mut Self {
-        self as *const Timer as *mut _
-    }
-
     pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         &'timer mut self,
         timer_list_group: Option<&TimerListGroup>,
@@ -51,7 +60,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         // SAFETY: the opaque outlives the timer
         unsafe {
             timer_init_full(
-                self,
+                self.as_mut_ptr(),
                 if let Some(g) = timer_list_group {
                     g as *const TimerListGroup as *mut _
                 } else {
@@ -75,6 +84,7 @@ pub fn delete(&self) {
     }
 }
 
+// FIXME: use something like PinnedDrop from the pinned_init crate
 impl Drop for Timer {
     fn drop(&mut self) {
         self.delete()
-- 
2.48.1


