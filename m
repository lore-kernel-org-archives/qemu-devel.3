Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E457CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM1-0007pP-27; Sat, 13 Sep 2025 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLy-0007cX-KT
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLu-00055Z-VI
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPKlaqghrOHsPLYrmGUDyXPckj2KbtMRtLHKQbrgvNc=;
 b=fzrkZPmVW1DNP48E+FVz4YZRJT3eHzB2rr/E9t441bub3GcabgsJEpJhYVtr6okJYqLxpr
 PTElidaAsfe7PACf/WQKf85XRGnADno1I0Yz5XotL4ifSdG9yc0lvgQCF3IcoVT1DzargZ
 ta59k61/UMQw7KSXZzacIczLnNo03zQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-XqQpuwbuOw2Cs67mNXHM2w-1; Sat, 13 Sep 2025 04:11:20 -0400
X-MC-Unique: XqQpuwbuOw2Cs67mNXHM2w-1
X-Mimecast-MFC-AGG-ID: XqQpuwbuOw2Cs67mNXHM2w_1757751079
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de5fdda1aso13460165e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751078; x=1758355878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPKlaqghrOHsPLYrmGUDyXPckj2KbtMRtLHKQbrgvNc=;
 b=pMo+Ekvkn7u2rEJkGhrpB5HJxwny71IgaVIBORn99Hqnbo70cQu5LWOw6MIwJ0n6Uk
 FGA6xBK0MVVOF3w7aM5QId3omMq+6zMcQwdMGV6RdndFqXARpCTl1FPEq9zmtVmwd7pT
 YoJsbbVsGdbVplkdoObY2fLdjsQonia5nvv1E3lxzi6JT1t4xCiSpZUbXdti4TrxHGIY
 CKkD1Teev49y4fZuVqJ2PKx21wBvFRpjeKgaN2UyUdsq8cSNh/11ypcAc+kjF3BH2jJL
 ZOUOdLFSVpNkSlVEgdB+izmb/l2p4ndd6vqVsY3fyGw/77B9t3NwqGuKVMBGNHo87H5/
 FJ6A==
X-Gm-Message-State: AOJu0YyLda0aYgVEMjT8BvyyMaDczHaLNhQsOENI2Zg7DXI0+go3BOGT
 TeAeWxPKIeZlRKyITdkrFzyOH17hx75LW9j/x48YlKzMmCBp2mp+nfjar2l/TwQdtgL5a5RIqet
 JrAZ8LxE8hkyqATzBWsF08s5DFpWGMNKPv4WF4FdSmpkPcGZxMFcYvSzALTrwcN/W7YetQhlpTN
 uv3slv1tLrZM0ucIVbjMqCIzAtQ+tNcamWpQmkef5x
X-Gm-Gg: ASbGncs3JG7w9VndEVw3jp5uu7dmXcd66NNsthB46K7ITLOWvxhUw41qlr1tt96yDER
 ukQfWefhn2ucWoJCzpEuDbgjG3m0ewjUSExsKPG6H0DuJTNexwNzb3TTNbMz4GUW/ORsK3SplyM
 4Au/jdkmhcnl/8heAW29uropqYCeDD1Nsh3uD5DXLT5HgbIlKG8CizEt1A0o1K695DHuifmSRqV
 SkoUc9A3etofDCsoNPxsZpPmd4UyrsbMOjnSXwPtu1EYqEEf8l4R9SGFy1leWe/8uKRLR1gk/uv
 r3vVqhdXoy8RmpVo7SnUlEbmDvcecvdaIy3USim69esVZtCGutPS24gCilcNNmkyI21BIr0pQv6
 bTPzV2L/WNLYD5D/OavEa4+Mg3hfZ1tlhKgamTiZonUM=
X-Received: by 2002:a05:600c:3b1f:b0:45c:b6fa:352e with SMTP id
 5b1f17b1804b1-45f2130999emr56672945e9.18.1757751078292; 
 Sat, 13 Sep 2025 01:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLZxsqZmn/6f5dxt+hQlSele7k9N5HhNQN605HifFw4Gky3/BmrqGML91LF8u9ztXpTLWjDw==
X-Received: by 2002:a05:600c:3b1f:b0:45c:b6fa:352e with SMTP id
 5b1f17b1804b1-45f2130999emr56672555e9.18.1757751077821; 
 Sat, 13 Sep 2025 01:11:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c3cbdsm96129125e9.17.2025.09.13.01.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/61] rust: move VMState handling to QOM module
Date: Sat, 13 Sep 2025 10:09:14 +0200
Message-ID: <20250913080943.11710-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Link: https://lore.kernel.org/r/20250827104147.717203-9-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs     |  3 +++
 rust/qemu-api/src/vmstate.rs | 11 +++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 014ffb1fd88..12c6fc6752c 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -109,6 +109,7 @@
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::{bql_locked, Opaque},
+    impl_vmstate_pointer,
 };
 
 /// A safe wrapper around [`bindings::Object`].
@@ -948,3 +949,5 @@ fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
 
 impl<T> ObjectClassMethods for T where T: IsA<Object> {}
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
+
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 59c7950a5aa..4e1086779ac 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -40,8 +40,6 @@
     bindings::{self, VMStateFlags},
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
-    prelude::*,
-    qom::Owned,
     zeroable::Zeroable,
 };
 
@@ -128,7 +126,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
 ///   [`BqlCell`], [`BqlRefCell`]
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer, a `Box` or an [`Owned`] for any of the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
+///   the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
@@ -335,10 +334,11 @@ unsafe impl VMState for $type {
 // Note that references are not supported, though references to cells
 // could be allowed.
 
+#[macro_export]
 macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const BASE: $crate::vmstate::VMStateField = <$base as $crate::vmstate::VMState>::BASE.with_pointer_flag();
         }
     };
 }
@@ -350,7 +350,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
-impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
-- 
2.51.0


