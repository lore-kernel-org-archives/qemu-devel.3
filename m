Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4237C021B8
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRx-0008Bc-4B; Fri, 21 Feb 2025 12:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRu-00080s-95
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRs-0001Wz-DY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tF++Gjxl8qlA5pYY+tAt3HrugPJ8B0H6ljBKbOe9dP8=;
 b=N82HjQemBZDpKvcdUViHpsw1iJ8B9Dz+GrUvsc+rTAeEFiVAoJ/NHCJT7uMYmnQiW6I477
 xxTZmAV9d2g0TZh8h0CYu8WuYPNccUvS3zDC8f9TiuaSnfeU8RSWpDmeQMb5VVcgckA4MH
 afjEcOrj8FRfHzltviYnTnyu1PY99BQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-zKVvDBAzOOuf5Ai86YFTzA-1; Fri, 21 Feb 2025 12:04:21 -0500
X-MC-Unique: zKVvDBAzOOuf5Ai86YFTzA-1
X-Mimecast-MFC-AGG-ID: zKVvDBAzOOuf5Ai86YFTzA_1740157460
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abba4c6d9ddso265312966b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157457; x=1740762257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF++Gjxl8qlA5pYY+tAt3HrugPJ8B0H6ljBKbOe9dP8=;
 b=IAkV8TVUXb0LA8dQb1Gc9MdokxS+HmGT4f8f+RKTucaB5PptxuImU3dp0eb5bBzrys
 95bTGbinxluM9PH1V7cezlPeePm0mJtFgsV338QmAFxUNhEuGvSimfLnUrgCBUz0dd2H
 AAvcfSHOCG5iWf/c1gjBpjAsDYvcCC9ffZlTikMkd50nkGczt0HIqM+bB4/9rVQ7a+72
 stoGbC+wxPyOlsQRp0nnY5w8cJaq/THaSuT1jzyuD7e4l1cOXGY4axFaB2PQ5QPjbgDs
 //wP6mjprZN5ISGOuRQyo/eekg/kILqoNYM9Miw+ZHmFWBGTvpl6dNt3g9oYizWIooq5
 A7mA==
X-Gm-Message-State: AOJu0YwT3ONaIAYyRci7FujyGjanoeJoWrjUZf2sRi+2nxlhvLvmDQ31
 pwEweZ+E17McEoHzcyd1CIBbeqE7QU2ZloGjrmJC8o29Y7VzDwZocDLzRrF5x6am1LU1P+eIgTg
 qAcmjgGbLvLbotxtD7S5lTD7zHSnlyLzjAHzNoj3qB6ZDkKXcP3H+l4MsPL5LqbRQ+GsrgIhYiV
 ep08NcoMALLN8HXlMHFYpywWI2U/NSaCJeTsRK1TY=
X-Gm-Gg: ASbGncvIbcOgmTLthBgBJiB5koNdcqT94nx//Licy26pxjhRU4cG1e5AbW6VZ3ZesgF
 i+zotrygJ7CgkX4dEqKu2Q/RHCyP+GhroszSx9UejPcGGs0qwJlHe+fCMEBNANTPITFL7/aIrIz
 OcjmGb9LW7WqnaDJDjmMjikAAP+zSOn6XhFe0LY840/9m1cSQ6v/HaQy3f+eODwSEU3oZgsCgRl
 E4624aPqPNWN7RK/MYlWSWNGtYDplyzuM3UpgOJIx3luZzGf9P/UIYRa5yZUJbIlIC9gjscgVms
 WNLz0cxoBx1pu2yNBrw=
X-Received: by 2002:a17:907:d16:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-abc0d9dd9ecmr343454566b.15.1740157457287; 
 Fri, 21 Feb 2025 09:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlGheNS8hhPmT17THOlcjVYtIbDYCcx1/8bOp+Nm/X18M30oIRTJKprBJsZsTUU4Ax0giO3Q==
X-Received: by 2002:a17:907:d16:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-abc0d9dd9ecmr343447666b.15.1740157456472; 
 Fri, 21 Feb 2025 09:04:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba9cf8a262sm1389156466b.22.2025.02.21.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 13/15] rust: memory: wrap MemoryRegion with Opaque<>
Date: Fri, 21 Feb 2025 18:03:40 +0100
Message-ID: <20250221170342.63591-14-pbonzini@redhat.com>
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
 rust/qemu-api/src/bindings.rs |  3 ---
 rust/qemu-api/src/memory.rs   | 30 ++++++++++++++++--------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index b791ca6d87f..26cc8de0cf2 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -34,9 +34,6 @@ unsafe impl Sync for CharBackend {}
 unsafe impl Send for Chardev {}
 unsafe impl Sync for Chardev {}
 
-unsafe impl Send for MemoryRegion {}
-unsafe impl Sync for MemoryRegion {}
-
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 713c494ca2e..fdb1ea11fcf 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -6,9 +6,8 @@
 
 use std::{
     ffi::{CStr, CString},
-    marker::{PhantomData, PhantomPinned},
+    marker::PhantomData,
     os::raw::{c_uint, c_void},
-    ptr::addr_of,
 };
 
 pub use bindings::{hwaddr, MemTxAttrs};
@@ -16,6 +15,7 @@
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
     callbacks::FnCall,
+    cell::Opaque,
     prelude::*,
     zeroable::Zeroable,
 };
@@ -132,13 +132,13 @@ fn default() -> Self {
     }
 }
 
-/// A safe wrapper around [`bindings::MemoryRegion`].  Compared to the
-/// underlying C struct it is marked as pinned because the QOM tree
-/// contains a pointer to it.
-pub struct MemoryRegion {
-    inner: bindings::MemoryRegion,
-    _pin: PhantomPinned,
-}
+/// A safe wrapper around [`bindings::MemoryRegion`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
+
+unsafe impl Send for MemoryRegion {}
+unsafe impl Sync for MemoryRegion {}
 
 impl MemoryRegion {
     // inline to ensure that it is not included in tests, which only
@@ -174,13 +174,15 @@ pub fn init_io<T: IsA<Object>>(
         size: u64,
     ) {
         unsafe {
-            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
+            Self::do_init_io(
+                self.0.as_mut_ptr(),
+                owner.cast::<Object>(),
+                &ops.0,
+                name,
+                size,
+            );
         }
     }
-
-    pub(crate) const fn as_mut_ptr(&self) -> *mut bindings::MemoryRegion {
-        addr_of!(self.inner) as *mut _
-    }
 }
 
 unsafe impl ObjectType for MemoryRegion {
-- 
2.48.1


