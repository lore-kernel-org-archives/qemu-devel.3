Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA1CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvj-0008Oo-FX; Fri, 30 May 2025 03:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvi-0008Ld-CL
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtve-0006pU-Lo
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIm4zByOF5S6L9LJ/pZcViAbpqMTge38cNVlo2XDp78=;
 b=Cz8BJRVon6I5Bbdgm4lZF/UFeClAT4tMnrQJhU8qH4bRYYmAAw8ZFQPXBQLU2c14wa4jnu
 5oWvkyzkgOBni1Qzpar8Wf/YBWwdEs+ten62Tyk5by+wngWEcf2j/kNKGvptQjYviLwH3S
 9TESfArxzHwzd5ZTUGuBmGtAhqLswUI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-i-Se55d5MRez3UjE0Lrs-Q-1; Fri, 30 May 2025 03:13:19 -0400
X-MC-Unique: i-Se55d5MRez3UjE0Lrs-Q-1
X-Mimecast-MFC-AGG-ID: i-Se55d5MRez3UjE0Lrs-Q_1748589198
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb61452b27so134522366b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589198; x=1749193998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIm4zByOF5S6L9LJ/pZcViAbpqMTge38cNVlo2XDp78=;
 b=G6VXBwrAxAm4xFk6oA7s7Cc5AaNqNq2DEoSp60DjzoorJ1WW2l5HlZTDAO8YBf1D6z
 DmY0gJ5pqVWBaWn3iGT4VsCfxWsVQPTzre+iKE6I8CT1/wTEfDWguUj2sodHXy1whg0t
 Ai2he0fEWKye2tlbDEQQH7BF8z8KJs3C5sYg8IyseMECUM4zv/yVXg8dScpb+tEwS5EY
 Eut0/wmghzIREqSvva33kjuA3QCmLCqbE9/+uHn2/YRtxcoGfgL/R9+MAcTV6vyQVf2I
 OIsXEMKSMlTM11E7QIsyl6SIV5wo2t8ecS2ca1cYb8u0Gu/n1ZNM6Bm99dtcwmZArxdA
 4dxA==
X-Gm-Message-State: AOJu0YznBPrSQXI1mo9Fbqzb/M2/EdBex1tfAJY2Kk1WfTEiByS1RbM9
 44CLzGT3q5KNVcaWv4uSTq7egeqAuK1APlOqvll2dSGf/ms3fuffS5PqHyAyYpCrozjjhW5X7Lg
 eMYeGF7WSSP1jugmZ0FwYlhOWjowLZxGg16L02vfuxgUrzgQT+KD2wA66WPJ+GDDo6K3w6kjU4Z
 OKK9iR/TqgDpSQ1EMGFO2nPqdJYqxOUXnGe3CtXOiF
X-Gm-Gg: ASbGnct7dTh4Kez6otjVr37zG2rkvnaC4jXyA8BMrgm+fp7uIgtSjFsIdRKCKUc0ZCD
 lJl2qjv9m0SxgYscdBE1EzgHr2Teqm/d5TQmysYMAfB64nV/WkPOjcVZ63pHghIjJHFqpxwLSYk
 WFj2CMZ0sk5nUiI8yYwy5JOph8iJPiY/DUtQHStZCLvjvBCwlH+nbGtxaVjp++Ow2oUO1NERnj7
 6u2icceboefDA/K1RnEZ0QGeMhcxIiQZuTjnqEsEr8e2tacJCWYVrjuAF5igsXuPGZ49XcwLkhU
 qOvl35bjrRlhdg==
X-Received: by 2002:a17:907:9282:b0:aca:d4f6:440d with SMTP id
 a640c23a62f3a-adb322860ecmr213004766b.17.1748589197643; 
 Fri, 30 May 2025 00:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz64ITCYW6TVW9zQt46ZW48RZFPXh9v8mY7nH6dWfwITUYYvcmyHIxZc4HHEMgUgii7cRuaw==
X-Received: by 2002:a17:907:9282:b0:aca:d4f6:440d with SMTP id
 a640c23a62f3a-adb322860ecmr213002366b.17.1748589197052; 
 Fri, 30 May 2025 00:13:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6aa17sm278798066b.175.2025.05.30.00.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/77] rust: Fix the typos in doc
Date: Fri, 30 May 2025 09:11:40 +0200
Message-ID: <20250530071250.2050910-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Zhao Liu <zhao1.liu@intel.com>

These typos are found by "cargo spellcheck". Though it outputs a lot of
noise and false positives, there still are some real typos.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250520152750.2542612-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qom.rs         | 4 ++--
 rust/qemu-api/src/vmstate.rs     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bde3be65c5b..bd5cee04647 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -480,13 +480,13 @@ pub fn post_load(&mut self) -> Result<(), ()> {
 }
 
 impl PL011State {
-    /// Initializes a pre-allocated, unitialized instance of `PL011State`.
+    /// Initializes a pre-allocated, uninitialized instance of `PL011State`.
     ///
     /// # Safety
     ///
     /// `self` must point to a correctly sized and aligned location for the
     /// `PL011State` type. It must not be called more than once on the same
-    /// location/instance. All its fields are expected to hold unitialized
+    /// location/instance. All its fields are expected to hold uninitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
         static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 41e5a5e29a8..14f98fee60a 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -291,7 +291,7 @@ fn as_object(&self) -> &Object {
     }
 
     /// Return the receiver as a const raw pointer to Object.
-    /// This is preferrable to `as_object_mut_ptr()` if a C
+    /// This is preferable to `as_object_mut_ptr()` if a C
     /// function only needs a `const Object *`.
     fn as_object_ptr(&self) -> *const bindings::Object {
         self.as_object().as_ptr()
@@ -485,7 +485,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// `INSTANCE_INIT` functions have been called.
     const INSTANCE_POST_INIT: Option<fn(&Self)> = None;
 
-    /// Called on descendent classes after all parent class initialization
+    /// Called on descendant classes after all parent class initialization
     /// has occurred, but before the class itself is initialized.  This
     /// is only useful if a class is not a leaf, and can be used to undo
     /// the effects of copying the contents of the parent's class struct
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9c8b2398e9d..812f390d780 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -9,7 +9,7 @@
 //! * [`vmstate_unused!`](crate::vmstate_unused) and
 //!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
-//!   which is defined by all migrateable types.
+//!   which is defined by all migratable types.
 //!
 //! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
 //!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), which help with
-- 
2.49.0


