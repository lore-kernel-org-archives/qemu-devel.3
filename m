Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE628C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIE-0005YV-0J; Fri, 24 Jan 2025 04:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG6-0007TO-0L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG4-0003wl-FB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeUloYUS4GjmUT75E0JIueWDFUGBROQ8X7lta1NSKvg=;
 b=H6mx6LYIz2PWbXxl6qtrXOZj7nOHwN++2WqY4v2CaQwuDzT2m4W/UxmYm9ZKPTd7DGLB5U
 M/EEOVh0dUIqUIa+bF66bHtFCnOKuzj2+SK0DhDJhO3yUFFPEFH29khq9AJJ3nNPpslw3d
 +NnYf2lee5CWdL0f5NTMWJ+MGEAlCS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-O-r8OH37ONSzzYnYzWEs5w-1; Fri, 24 Jan 2025 04:45:42 -0500
X-MC-Unique: O-r8OH37ONSzzYnYzWEs5w-1
X-Mimecast-MFC-AGG-ID: O-r8OH37ONSzzYnYzWEs5w
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so1231514f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711941; x=1738316741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AeUloYUS4GjmUT75E0JIueWDFUGBROQ8X7lta1NSKvg=;
 b=FY1vzXjJM8PjcziIa1H3ttyEwXQlQ/+Y4uC2N+CijYMYn6LeIxb5BHMWvuGI0BP15u
 jf8utCS/mWvzWr2b406YmM7PJDTajgDu9pmG5oPvsFE2js9RmDMXRVIp4p/43+RR5rVI
 MWfxlS8JS9dlMEh15VEbCRSFnyJKm0Hr8aQY1OV2ZnIvG3tonph/MefYcueLzz/ZXsXW
 obqkgRkxPrm/bXEH4QGjYaDt/yaGbvMmkbns1PBPxcfhYfJhJgVZayzvwUqGHqXnX92S
 3UVuXpvuLBmjxoCcaHLPjOeldzTkiS9yZBQzUcRMmEhqz9C0BBCkGRdLoOPwJNxmZYg4
 F+KA==
X-Gm-Message-State: AOJu0Yy67XqU50Cw+9pT3q8Xcni/Xq8bNWOhB+/5trkYIPyp83LzHVkD
 rsBBej/Ri4Ks/7RB3ahqtYkK7Bm4x70/w+6d2/JxtBCzMJNHs/bPWz3nlYSETuFZS2647egbnxB
 I95nb8acAf11xwk544O5NpWMoIguHurSbMjJuFNZzJzx/08BvT4yI1I+eUmgpwMOz9hWHtLwkqt
 LcQmafO6DBhkOxXR4pqr1rkRpVoYHK0ssFD0sABKw=
X-Gm-Gg: ASbGncsPfrfqnVXHnzfF9TeXXBLX/Ixxc/vKOnrIC2Ng88Zs8Q7FnFN3VDhVxoemWFX
 q3fmdt72E5+90vrLQUbl0mlK+n73jdkA484OqM7XD+zYHZ3YBI+oFcdASqqgidyhZE/j/d+ErxQ
 ofg4YtOOT7BR6WXWO69uN/oqk/uvlXMW2CzEUIZ2nGa3Zym3NBeevogFdJ8pBVoiK23JcR59FFe
 hRHHn+aoXOKwYHzhi/2d+WpAIz3G+Hi7fbYdNP4Ez2ZTKnVfj74FjzXcW90Qox90oMyQk/gKQ==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id
 ffacd0b85a97d-38bf57a9932mr32061193f8f.41.1737711940747; 
 Fri, 24 Jan 2025 01:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM/78mz3VExiNnYWsnIIdxajIW+OeoDI4UWKlixbxasFGOS+obUI6TGoIT2uOGTwVIzVecIQ==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id
 ffacd0b85a97d-38bf57a9932mr32061145f8f.41.1737711940331; 
 Fri, 24 Jan 2025 01:45:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad92sm2161951f8f.61.2025.01.24.01.45.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/48] rust: vmstate: implement Zeroable for VMStateField
Date: Fri, 24 Jan 2025 10:44:22 +0100
Message-ID: <20250124094442.13207-29-pbonzini@redhat.com>
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

This shortens a bit the constants.  Do not bother using it
in the vmstate macros since most of them will go away soon.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs  | 18 +++---------------
 rust/qemu-api/src/zeroable.rs | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 2b14d4839df..7652930affc 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -21,8 +21,8 @@
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
-use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
+use crate::bindings::VMStateFlags;
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -503,20 +503,8 @@ macro_rules! vmstate_fields {
         static _FIELDS: &[$crate::bindings::VMStateField] = &[
             $($field),*,
             $crate::bindings::VMStateField {
-                name: ::core::ptr::null(),
-                err_hint: ::core::ptr::null(),
-                offset: 0,
-                size: 0,
-                start: 0,
-                num: 0,
-                num_offset: 0,
-                size_offset: 0,
-                info: ::core::ptr::null(),
-                flags: VMStateFlags::VMS_END,
-                vmsd: ::core::ptr::null(),
-                version_id: 0,
-                struct_version_id: 0,
-                field_exists: None,
+                flags: $crate::bindings::VMStateFlags::VMS_END,
+                ..$crate::zeroable::Zeroable::ZERO
             }
         ];
         _FIELDS.as_ptr()
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 6125aeed8b4..57cac96de06 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -49,6 +49,37 @@ unsafe impl Zeroable for crate::bindings::Property {
     };
 }
 
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for crate::bindings::VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateFlags {
+    const ZERO: Self = Self(0);
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateField {
+    const ZERO: Self = Self {
+        name: ptr::null(),
+        err_hint: ptr::null(),
+        offset: 0,
+        size: 0,
+        start: 0,
+        num: 0,
+        num_offset: 0,
+        size_offset: 0,
+        info: ptr::null(),
+        flags: Zeroable::ZERO,
+        vmsd: ptr::null(),
+        version_id: 0,
+        struct_version_id: 0,
+        field_exists: None,
+    };
+}
+
 unsafe impl Zeroable for crate::bindings::VMStateDescription {
     const ZERO: Self = Self {
         name: ptr::null(),
-- 
2.48.1


