Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE39C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEp-0003fR-7K; Tue, 06 May 2025 11:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEn-0003eI-CL
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEl-0001wE-0X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJkJL+2iQH6j0YxyFlCO0wihd/nFC5q/GbHkjAOouko=;
 b=aNk1kZWUI9s1US5TTTPuPcfNgThLN6zPCKeNvROe1rK3UiW9mwL2HLsOi9IBe0qHn8+jnx
 4mwFKPeIZWQm76KoXd8KEFx6ENny/WkZJpWwEERPI4LT6l/n89c1m/leXkM0p/1nOAKzU4
 8BiWEOUIbWVHQzvpkIFxP6hWhz76Pcc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-FOO3xrswOOahQ7jNX9W29A-1; Tue, 06 May 2025 11:29:36 -0400
X-MC-Unique: FOO3xrswOOahQ7jNX9W29A-1
X-Mimecast-MFC-AGG-ID: FOO3xrswOOahQ7jNX9W29A_1746545375
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so2960565f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545375; x=1747150175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJkJL+2iQH6j0YxyFlCO0wihd/nFC5q/GbHkjAOouko=;
 b=tf98luYD2tew5BQsV7JgRs5cGCnfWxbRJyqXqeoyP7az7fp/zqmnlYi2C1vXoP36Wp
 QNQ2HwemmEkwUlHDpFu87PHoVXaCDm790SwpRQhsABtxXcJymBNUJD/YLiyNS5crczNV
 VCnDATeyBEr3We1yAHpHZGnlp/1Xkd/SiCsDLFB/sF0+VvS5JU4/Ok0LtBxHGvUecqEJ
 mRoXFqfBAHobgqH9fMmXDf1mnFfBh1fvNhpl8eiVS53ozxpgRD6W3TiXyf+lAzubKn46
 E820oNrkk8pF4zPYd6x+MuxpI0Ec/lUw26ZADhn+YK9Mr2GzgGPEyLi0nVnGRAM+Zaex
 FLtA==
X-Gm-Message-State: AOJu0YxQ9WaCIN+RPd3Cu93pQHXuw5Wjioyrq9/8ViPDItWyvEHTRuZ0
 +aEU7iADoFj+th2LVaHYdHQXcCgwh6NvEsBu6NbUlkEzNXQAHSP1PU6D1QW6mR70sxxGRi2LHZS
 DQvWFe3/pyskje75h1MgseouFyapCYiOeMln36ItkFDeeYhppThs0OhDwHXwOxhQhgAKc2JyQgA
 TNt90AHeWuyngHz+yEY0NkZAHGJyvl7lifmS6z
X-Gm-Gg: ASbGncusauWl3CUPoOSy2n+6NhsGpA5jNoo9s8QhntVv3UsHcP8ug9cafgNspqqrrSA
 jB/6kCk67sue+aZ4JEIZp3gBC+yL7AEwUseA2QExDF/NIrmUoQiKWx/opEuiB2sAnyEm8M7zCf3
 YR7Qe2/4+pCiOdn7v1pwSMIGaFyvOSI3cWOPTOST5NcdL5lD0tNzb+tNZ6ds4sVJQCdzVRvlPZY
 sEhrLBnlJ86QFBoUP4ITjLtsXpJdGJ+ssieMm0mxAUcmrehljhSUII2mAHL0i9HOJeMsR01ZXXh
 ZaIhHwgjdAk8s9E=
X-Received: by 2002:a05:6000:4006:b0:39c:268b:8b66 with SMTP id
 ffacd0b85a97d-3a0ac1ff66fmr2847452f8f.43.1746545374651; 
 Tue, 06 May 2025 08:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTJzEa/w4GNmEL0Qa3jr5OmMdfA4BUDyhc6fh34Zv8Ht1LyLb+EU0sfeNaHLXMrH8NSFBuxA==
X-Received: by 2002:a05:6000:4006:b0:39c:268b:8b66 with SMTP id
 ffacd0b85a97d-3a0ac1ff66fmr2847430f8f.43.1746545374264; 
 Tue, 06 May 2025 08:29:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b25159c9sm1466480f8f.50.2025.05.06.08.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/30] rust: use std::ffi instead of std::os::raw
Date: Tue,  6 May 2025 17:28:58 +0200
Message-ID: <20250506152927.222671-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is allowed since Rust 1.64.0.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                    | 2 --
 rust/hw/char/pl011/src/device_class.rs | 2 +-
 rust/hw/timer/hpet/src/hpet.rs         | 3 +--
 rust/qemu-api/src/chardev.rs           | 3 +--
 rust/qemu-api/src/irq.rs               | 6 +++++-
 rust/qemu-api/src/lib.rs               | 2 +-
 rust/qemu-api/src/memory.rs            | 3 +--
 rust/qemu-api/src/qdev.rs              | 3 +--
 rust/qemu-api/src/qom.rs               | 3 +--
 rust/qemu-api/src/timer.rs             | 2 +-
 rust/qemu-api/src/vmstate.rs           | 2 +-
 rust/qemu-api/tests/vmstate_tests.rs   | 7 ++++++-
 12 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 3cc2841d4d1..c7dfba98de1 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -74,8 +74,6 @@ Supported tools
 QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
 are missing:
 
-* ``core::ffi`` (1.64.0).  Use ``std::os::raw`` and ``std::ffi`` instead.
-
 * ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
 
 * "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b4d4a7eb432..cd2dc33c207 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void},
     ptr::NonNull,
 };
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 12de2ba59a1..d4364f2f2f7 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -3,8 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    ffi::CStr,
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void, CStr},
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 11e6c45afaf..146a4852da3 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -10,11 +10,10 @@
 //! called.
 
 use std::{
-    ffi::CStr,
+    ffi::{c_int, c_void, CStr},
     fmt::{self, Debug},
     io::{self, ErrorKind, Write},
     marker::PhantomPinned,
-    os::raw::{c_int, c_void},
     ptr::addr_of_mut,
     slice,
 };
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 1222d4fde30..1526e6f63a1 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -4,7 +4,11 @@
 
 //! Bindings for interrupt sources
 
-use std::{ffi::CStr, marker::PhantomData, os::raw::c_int, ptr};
+use std::{
+    ffi::{c_int, CStr},
+    marker::PhantomData,
+    ptr,
+};
 
 use crate::{
     bindings::{self, qemu_set_irq},
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d30..c3641e893b7 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -33,7 +33,7 @@
 
 use std::{
     alloc::{GlobalAlloc, Layout},
-    os::raw::c_void,
+    ffi::c_void,
 };
 
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index fdb1ea11fcf..9ef2694bd62 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -5,9 +5,8 @@
 //! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
 
 use std::{
-    ffi::{CStr, CString},
+    ffi::{c_uint, c_void, CStr, CString},
     marker::PhantomData,
-    os::raw::{c_uint, c_void},
 };
 
 pub use bindings::{hwaddr, MemTxAttrs};
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 18b4a9ba687..17c7fecabeb 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -5,8 +5,7 @@
 //! Bindings to create devices and access device functionality from Rust.
 
 use std::{
-    ffi::{CStr, CString},
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void, CStr, CString},
     ptr::NonNull,
 };
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f1b4022157b..6929e4d33ae 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -93,11 +93,10 @@
 //! without incurring into violations of orphan rules for traits.
 
 use std::{
-    ffi::CStr,
+    ffi::{c_void, CStr},
     fmt,
     mem::ManuallyDrop,
     ops::{Deref, DerefMut},
-    os::raw::c_void,
     ptr::NonNull,
 };
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index e769f8bc910..d697fd742bc 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    os::raw::{c_int, c_void},
+    ffi::{c_int, c_void},
     pin::Pin,
 };
 
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9ae97c389c1..c0f29f74188 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -25,7 +25,7 @@
 //!   functionality that is missing from `vmstate_of!`.
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
-use std::os::raw::{c_int, c_void};
+use std::ffi::{c_int, c_void};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::{
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index f7a93117e1a..9a56ffd2385 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,7 +2,12 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, os::raw::c_void, ptr::NonNull, slice};
+use std::{
+    ffi::{c_void, CStr},
+    mem::size_of,
+    ptr::NonNull,
+    slice,
+};
 
 use qemu_api::{
     bindings::{
-- 
2.49.0


