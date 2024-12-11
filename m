Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523CDE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaM-0003VI-K6; Wed, 11 Dec 2024 11:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaF-00039r-OE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaD-0000eK-SV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnI0niveAFX2WdKfqxklK+1Zt06kPSFJCN7eFa7HF+8=;
 b=dopaszjgPLj38YnhAjXFPMwKZQpDY/PBs0gTLXdcSjczIaVI+70tjsZeM4w0EHWVDcWMLd
 nI08kwFtcSdDw/R3PMpuyG4calxlBpHew2g0+5IzFmas2wAtUzEpucejXB6VdrXEt30cm4
 +AyYUvGscMy929apckodrtezyEKprxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-bpmbVHmZPqipX8q-fNU3dQ-1; Wed, 11 Dec 2024 11:29:04 -0500
X-MC-Unique: bpmbVHmZPqipX8q-fNU3dQ-1
X-Mimecast-MFC-AGG-ID: bpmbVHmZPqipX8q-fNU3dQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e4a759e6so4253327f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934542; x=1734539342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnI0niveAFX2WdKfqxklK+1Zt06kPSFJCN7eFa7HF+8=;
 b=EK03DXpv91pfAwxnD/mbv5VChczfUSt8nc22lT9BuPeKWe6fOHMgXHGAwj9MlNbtfX
 wcUYPUED3vDD+uYIkw8Rc/b2BMa/+Drk+vIpCk2Yd6iPh1Ct0gFMNFb5Ebdg3BZIwW96
 Q/xwv5BisK/5rP53NF+6ZDatyVNpWhOvydlCwXR62JEdahQHewWpVrGaeBNOqwrO0p4Y
 DXe8p/PwOJDgXUN4DNKaEcUGgO8/xcFt8xU1Qt45i+Ak5/orXhE+4v9UMcDPwnAo1lEG
 lMSXFil702iukDd5/fuX2rE6GwGUysGuvmIHbZNCXE91X52rJKd0DG8pwVDD0fdOnvF3
 CN/g==
X-Gm-Message-State: AOJu0YxICc1L0g5lcyUiBOcq6rM00j4yODfVFgVvPCj19wB1XJVA7iA+
 4JGpq6LIyaeFWBjRNtzTpIN2gyt7xHGZjR8xStqXzoHFEokytyb5STqzD/MxNtdZfrH1JqBWh9y
 lWwLkztHo4BPWKekSfgNxBTTDOb5YHzDt222N4l4SiojZrmlKWfKJv/GE7iDzjqpWpTDYNdP8pT
 5eMbfyWupfLpDOL65MQEBIb8Qd7JC3Bwb2Aej9
X-Gm-Gg: ASbGncsh/z5W41TC++ZqwmeRFER60dROH8jsvtHZrJN+lCrIBsj7HlbKdPZp9/DyHdW
 f7anXAoBmpzyLSZ54XXmIFeJCdBelviQdQ3ZETbhOw9XvOqLHC4IMMbfgataHVLwLEjEN0Qo4uJ
 FxTLlp41jzPDA2KFKQpw1dkhCgAuGm2DO1W0O5rhhY+yT3elAUpUJn81685pwlZFlCwcM3xdKEp
 IrDlxqp8gj0Nxwn8uBypm1lY3Tve+qIlSLV/H+mRfdd390gmYnoXWYD
X-Received: by 2002:a05:6000:156e:b0:386:4034:f9a6 with SMTP id
 ffacd0b85a97d-387877dcaa4mr161981f8f.57.1733934542300; 
 Wed, 11 Dec 2024 08:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3XWggqCNpBpk7ACaBG8vZIoSmClZxjI9GWZWxPBdvSFpQnXNUxvQK/9FswNaWLBw/LXqGsg==
X-Received: by 2002:a05:6000:156e:b0:386:4034:f9a6 with SMTP id
 ffacd0b85a97d-387877dcaa4mr161966f8f.57.1733934541807; 
 Wed, 11 Dec 2024 08:29:01 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251bcabsm1665993f8f.87.2024.12.11.08.29.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/49] rust: qom: move ClassInitImpl to the instance side
Date: Wed, 11 Dec 2024 17:27:14 +0100
Message-ID: <20241211162720.320070-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Put all traits on the instance struct, which makes it possible to reuse
class structs if no new virtual methods or class fields are added.
This is almost always the case for devices (because they are leaf
classes), which is the primary use case for Rust.

This is also simpler: soon we will find the implemented methods without
macros, and this removes the need to go from the class struct to the
instance struct to find the implementation of the *Impl traits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/definitions.rs | 8 ++++----
 rust/qemu-api/tests/tests.rs     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bcb146c24d6..2384d4bcb95 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -116,7 +116,7 @@ pub struct PL011Class {
     _inner: [u8; 0],
 }
 
-impl qemu_api::definitions::ClassInitImpl for PL011Class {
+impl qemu_api::definitions::ClassInitImpl for PL011State {
     const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
         Some(crate::device_class::pl011_class_init);
     const CLASS_BASE_INIT: Option<
@@ -649,7 +649,7 @@ pub struct PL011LuminaryClass {
     }
 }
 
-impl qemu_api::definitions::ClassInitImpl for PL011LuminaryClass {
+impl qemu_api::definitions::ClassInitImpl for PL011Luminary {
     const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
         None;
     const CLASS_BASE_INIT: Option<
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 6ecfaf51b09..487712611f6 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -9,8 +9,8 @@
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl: Sized {
-    type Class: ClassInitImpl;
+pub trait ObjectImpl: ClassInitImpl + Sized {
+    type Class;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
     const ABSTRACT: bool = false;
@@ -32,8 +32,8 @@ pub trait ObjectImpl: Sized {
         instance_finalize: Self::INSTANCE_FINALIZE,
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
-        class_init: <Self::Class as ClassInitImpl>::CLASS_INIT,
-        class_base_init: <Self::Class as ClassInitImpl>::CLASS_BASE_INIT,
+        class_init: <Self as ClassInitImpl>::CLASS_INIT,
+        class_base_init: <Self as ClassInitImpl>::CLASS_BASE_INIT,
         class_data: core::ptr::null_mut(),
         interfaces: core::ptr::null_mut(),
     };
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 7f9df348b00..fd0c979121c 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -59,7 +59,7 @@ impl ObjectImpl for DummyState {
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
     }
 
-    impl ClassInitImpl for DummyClass {
+    impl ClassInitImpl for DummyState {
         const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
             Some(dummy_class_init);
         const CLASS_BASE_INIT: Option<
-- 
2.47.1


