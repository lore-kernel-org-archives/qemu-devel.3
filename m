Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C391CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTF-0006pD-1F; Mon, 08 Sep 2025 06:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT8-0006mf-9z
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSu-000696-PW
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLjXlV6tskZf67489NweOESfqI9ttMPzYvJpnf+9hQI=;
 b=N/O25o8nu3e5WziWub6hWHIXZmEwwu1YBBj47TFr1yDvFO7jSLyAFqnwlfH4UDNNQ7g1bf
 LdUUcoPur/4fIBXm0+4RqQBS7ffZY3wAJuLGCtQsxsVDwiGlhjdGqH9zHZ+aIA/ZbYKS3c
 4LAlCvqu89D2kLP7Nr9QXPtxmg6QN/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-9FMuQBxTNfuwvuW0WEKkWA-1; Mon, 08 Sep 2025 06:50:57 -0400
X-MC-Unique: 9FMuQBxTNfuwvuW0WEKkWA-1
X-Mimecast-MFC-AGG-ID: 9FMuQBxTNfuwvuW0WEKkWA_1757328647
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45dde353979so10019075e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328643; x=1757933443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLjXlV6tskZf67489NweOESfqI9ttMPzYvJpnf+9hQI=;
 b=FFdJCaK0z7liYTF/gpCHxWcPztHGW+spa3Zgtnc7c2IV4XdpOqgu0/iKJmewsqBOVb
 pKPPEPABoGZ/YK8PhbrxOuJVAtzh2rVOMUy2ltOodsFp2xmfn32seUGt8wUpHScQE6D/
 lwXGbSzX5JJ29EcCrNQOrOcsUJ3CI9g1RhPA6R70Wss03a2SdXBsk6l07AVQHDj3L0+L
 ugrgBpcO1TC/KNP2zLobiaYqOnFrP9JiClfuzYejV5Kb2zOGRgUItdjTsF9KP9h+heDP
 z/rMgOUrfybjVtQn8vzzZhDJbhUbb9ptUJcW67exdLwwpoL22TAss+yet+5nsmRXwg+3
 IO1g==
X-Gm-Message-State: AOJu0YwcZGK9IQ+jRuSXm0tID9jQkVvsyPtKmMhmulauQmiWf9c6uaBt
 QY09mhy2NysOupmq/KF9O+Z4qYsISnxJeTQhNJzV1S9zeoxTe2qbL2agyBwcsvjWOLA+JOksGbL
 oWLFfhAYc0NK3SCjbizfAZUglPNiEcVUHDNfXPhBr+nhxP0n2JjRAZ7/6bKX0ZohU8TNAtwlNlf
 qMvVVLytkdqtROsxp+LnvGue7WbgFZ2T/BekIrxpK9
X-Gm-Gg: ASbGncup0Ih1/XrWqinOFHXt69Hl7U35phUwOXo+fR2aUxw04bFH2DgjqhXEgob/9L6
 ibBVqicbWzSan6N6D++Vo+6Q5RjZW0789WUHUpdzFuhkxw7rYoIEE2K5Jw5bkuf8M3rzssjr6i3
 SCMQ63AfjmSTq59Z+r0cspaitZUhpXpMRHV+YyAkJepoBGjjZGua0OZcD4ytkwNCSAoFpBaeovs
 prrh7zoh7NPZyVfZMoY8xwCx6Z2y2EctuxBr6/EF59jK1MA2xe8GBpr9cye60nNpDKqvnS7CqxT
 OIPwjJZ4pzmFPRIAq8x8b9eIC1N5V3DmuQrxFjiq7eY0tipmECJVs6jn/Fo98G54y3VUBFKIYP9
 Crflqd/ZEF5zIc+IHkKsDsyxZM/zGeb5tUob/k62H1Bs=
X-Received: by 2002:a05:600c:c4ab:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-45dddef8c61mr55627155e9.37.1757328643403; 
 Mon, 08 Sep 2025 03:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHtC0EbIvVN2Uo8L6f4KVM08w8s72nTGU/pUN86AbAuUxX4Q5/9/c2WUGqQGe/6t4Ac8h0nA==
X-Received: by 2002:a05:600c:c4ab:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-45dddef8c61mr55626855e9.37.1757328642826; 
 Mon, 08 Sep 2025 03:50:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm40295573f8f.59.2025.09.08.03.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 15/33] rust: move Cell vmstate impl
Date: Mon,  8 Sep 2025 12:49:47 +0200
Message-ID: <20250908105005.2119297-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-10-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs    |  6 +++++-
 rust/qemu-api/src/vmstate.rs | 14 +++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 148a13e3f56..9943d7286b6 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -221,7 +221,7 @@
     ptr::NonNull,
 };
 
-use crate::bindings;
+use crate::{bindings, impl_vmstate_transparent};
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
@@ -456,6 +456,8 @@ pub fn take(&self) -> T {
     }
 }
 
+impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
+
 /// A mutable memory location with dynamically checked borrow rules,
 /// protected by the Big QEMU Lock.
 ///
@@ -764,6 +766,8 @@ fn from(t: T) -> BqlRefCell<T> {
     }
 }
 
+impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+
 struct BorrowRef<'b> {
     borrow: &'b Cell<BorrowFlag>,
 }
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 4e1086779ac..ce42b031bc1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -124,7 +124,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * scalar types (integer and `bool`)
 /// * the C struct `QEMUTimer`
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
-///   [`BqlCell`], [`BqlRefCell`]
+///   [`BqlCell`](crate::cell::BqlCell),
+///   [`BqlRefCell`](crate::cell::BqlRefCell)),
 /// * a raw pointer to any of the above
 /// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
 ///   the above
@@ -254,14 +255,15 @@ unsafe impl $crate::vmstate::VMState for $tuple {
 
 // Transparent wrappers: just use the internal type
 
+#[macro_export]
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const BASE: VMStateField = VMStateField {
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
                 size: mem::size_of::<$type>(),
-                ..<$base as VMState>::BASE
+                ..<$base as $crate::vmstate::VMState>::BASE
             };
-            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
+            const VARRAY_FLAG: $crate::bindings::VMStateFlags = <$base as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
     };
 }
@@ -269,8 +271,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
 #[macro_export]
-- 
2.51.0


