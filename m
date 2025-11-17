Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12976CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttl-0003Zl-Cb; Mon, 17 Nov 2025 02:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt8-0003Ss-Jz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt6-0005wk-Qz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GygTWM71YJQuelKl4+w4JM0b7Dy3UCtb9HIa+5b46AQ=;
 b=F31tPjeqhZbjHS96yrL8pQrvm5sfjK2ww4PI4/QIag2+tSjfmCS7K92pSjpFJ3KEV0fJih
 6yAJoS20B0CR94R/rSNDWZbUwaesDFxkeA3zktU5HtccpuDZXQbUVr2r9jtWdqVr77HtuB
 ItS/0bmsPhq9o8VICKyIWaJEMZdf/bI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-BdC8qNT6NQaXRAxETlcRxA-1; Mon, 17 Nov 2025 02:42:57 -0500
X-MC-Unique: BdC8qNT6NQaXRAxETlcRxA-1
X-Mimecast-MFC-AGG-ID: BdC8qNT6NQaXRAxETlcRxA_1763365376
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477212937eeso22063645e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365376; x=1763970176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GygTWM71YJQuelKl4+w4JM0b7Dy3UCtb9HIa+5b46AQ=;
 b=dm07HyOKBJS55gIDJp9k2VtE8QsBvhR6wKsl2YZjllFURJYtJ78tsNjcofLnUV1vDM
 v7rzTqGMWOmcCGAVi5Z/RIMjGZrB44uglYmWYcVWzNe5vYVMEQYGLiTq+CXAOJgtac35
 Dwu5ouEzMG/Jl1UizHBYihtoGgV8ge7qR8nLQhlzfzF4bF+nk45otsLUmtjjlLusW8Pc
 dFo8td3NjtVDqEGl5S1lPZv501PcLI58GstWrOi8U5G+ngWp/mp4zxw1oReveguhiluT
 eaK/wRXtGl7JOxh1O8cXNjb6EHyuY9+Dm16P4UDp9qVgeZaCL1E3IZnOoKQW2DR4wcg9
 eJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365376; x=1763970176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GygTWM71YJQuelKl4+w4JM0b7Dy3UCtb9HIa+5b46AQ=;
 b=fZHJsQkbuZ/gPASPQD1sAQ+xSsOS8JNhAkY1VbHzjhRNIx2C/I/GgvwkgH92p/644i
 GwfKiS8cHos20lqR0HyiS4FpX/vnjTUikMiuxZJCfi2zde+X/yPdBntaMjPwfhEzr3S1
 nxUq/SMepSE5m4ffZHH8WE2US7Wlj7+wGyzVtTxEOnEaCUr/L/NEwjnHg5DYr2165gvw
 fDO+ONxIUqECVF67OWZOBdMaNXOD7kEqzfUTUNJ+lwwV8HvbWsFwRbc1YkxJ6JTh5gTr
 tAk9SEQOu+qLIXb7NZ5IVxmB3v2E9dWxmp87HoW9R4l3AQVq1l2MjeOvFpu/U61sPvnd
 JgUg==
X-Gm-Message-State: AOJu0Yxylyiu8c6faDNocTkm4fKDLIaqnYct37TFb+XpZprqzbNwc9rm
 wUBX85KaVEYGW/Zj+c+waDV3btU3K4+7q5QBa+4UHMs4wAk4rehaR879h48/u7Uh+NIp6xVx2JW
 Vmx3LJaWluJOnIo9MI2JKND86RNB1toiBJFWQ4GZIPn1PdGSwt4i7wgOJthwjBMmSuwNSuKtn0i
 /LLMXW/HSdnGuWxxYkfloo6c9fGovLAcPAFV6gLR6Y
X-Gm-Gg: ASbGncu9VWFBHyDwZrOwnBu0glAPbOAVwWnSBcnI7F+gl8viHRllDk2JzQw1Ivf2oaS
 fgNSiFu6xbrVETJSYvMmR68h5Va/7hEo67I1LD3IywOWJcEXPDwD9Ce0RjAdmHBWooVwcuk8E2T
 VQqEOIqPevIH03QvykSpw3WQeqL72d4Q+XbgDT/+wq5/7ml6hgW5xhqm3yL0jn2Uum7bNR6eSi+
 WMAOvEnHaTUZwC2crpVpzBfBxoOv//WZRkKGUgJtjufHu4m7ec8qu3obyLMsWuHV1tFLd//R8h8
 EelWVL9yoXfaFgDF9qkF1XLZXSAU1/UP+SoFjYY3lnrE4kMWFjWhqaBNaZ+EproOU0C/pl8evo1
 HlSMmk0Qs3UF/HnGbvA5lgVGhOaA9wlGF7aWZsTHg2qN1jb84Q/xCo82PFFTwjmRJj6oGWo2Qde
 JNVoSK
X-Received: by 2002:a05:600c:3b12:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-4778fe5c87amr102519055e9.9.1763365375640; 
 Sun, 16 Nov 2025 23:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3TSxkFmvzdmZyZt4ZbpVfA8/q3zkvsVFvxypOHoR9O1h1OuytUVhgHmoptLSTCc11/kbDGw==
X-Received: by 2002:a05:600c:3b12:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-4778fe5c87amr102518885e9.9.1763365375158; 
 Sun, 16 Nov 2025 23:42:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e45677sm297822465e9.8.2025.11.16.23.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 6/8] bql: add prelude
Date: Mon, 17 Nov 2025 08:42:36 +0100
Message-ID: <20251117074239.190424-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117074239.190424-1-pbonzini@redhat.com>
References: <20251117074239.190424-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 rust/bql/meson.build              | 1 +
 rust/bql/src/lib.rs               | 5 +++++
 rust/bql/src/prelude.rs           | 4 ++++
 rust/chardev/src/chardev.rs       | 2 +-
 rust/hw/char/pl011/src/device.rs  | 2 +-
 rust/hw/core/tests/tests.rs       | 2 +-
 rust/hw/timer/hpet/src/device.rs  | 2 +-
 rust/migration/src/migratable.rs  | 2 +-
 rust/tests/tests/vmstate_tests.rs | 2 +-
 9 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 rust/bql/src/prelude.rs

diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 091372dd7b6..90aaadaa6d6 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -31,6 +31,7 @@ _bql_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/cell.rs',
+      'src/prelude.rs',
     ],
     {'.': _bql_bindings_inc_rs}
   ),
diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
index ef08221e9c1..d2fea5db1ac 100644
--- a/rust/bql/src/lib.rs
+++ b/rust/bql/src/lib.rs
@@ -6,6 +6,11 @@
 mod cell;
 pub use cell::*;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 /// An internal function that is used by doctests.
 pub fn start_test() {
     // SAFETY: integration tests are run with --test-threads=1, while
diff --git a/rust/bql/src/prelude.rs b/rust/bql/src/prelude.rs
new file mode 100644
index 00000000000..42031ec18ab
--- /dev/null
+++ b/rust/bql/src/prelude.rs
@@ -0,0 +1,4 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::cell::BqlCell;
+pub use crate::cell::BqlRefCell;
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index f0b7975dbf7..fb9674b3fb4 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -18,7 +18,7 @@
     slice,
 };
 
-use bql::{BqlRefCell, BqlRefMut};
+use bql::{prelude::*, BqlRefMut};
 use common::{callbacks::FnCall, errno, Opaque};
 use qom::prelude::*;
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ff929e60993..be1bdf5ab12 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -4,7 +4,7 @@
 
 use std::{ffi::CStr, mem::size_of};
 
-use bql::BqlRefCell;
+use bql::prelude::*;
 use chardev::prelude::*;
 use common::prelude::*;
 use hwcore::{prelude::*, ClockEvent, IRQState};
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index f38376d0016..e60c9d018f5 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -4,7 +4,7 @@
 
 use std::{ffi::CStr, ptr::addr_of};
 
-use bql::BqlCell;
+use bql::prelude::*;
 use hwcore::prelude::*;
 use migration::prelude::*;
 use qom::{prelude::*, ObjectImpl, ParentField};
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 4ff1779a3d2..b7153a46e31 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -10,7 +10,7 @@
     slice::from_ref,
 };
 
-use bql::{BqlCell, BqlRefCell};
+use bql::prelude::*;
 use common::prelude::*;
 use hwcore::prelude::*;
 use migration::{self, prelude::*};
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index ded6fe8f4a6..ce603867502 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -9,7 +9,7 @@
     sync::{Arc, Mutex},
 };
 
-use bql::{BqlCell, BqlRefCell};
+use bql::prelude::*;
 use common::Zeroable;
 
 use crate::{
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index c3f9e1c7436..87176a80990 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -9,7 +9,7 @@
     slice,
 };
 
-use bql::BqlCell;
+use bql::prelude::*;
 use common::Opaque;
 use migration::{
     bindings::{
-- 
2.51.1


