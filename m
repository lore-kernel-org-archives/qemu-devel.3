Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F921D3B7EB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6V-0004vi-B5; Mon, 25 Nov 2024 03:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU66-0004oC-07
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU63-0007Iz-Ec
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gv7CRYSGxzo9Mp91cBsW0yHPaWpXNZXh+VQtxbDWVCM=;
 b=SLR1AF07ZVLbnmZUzJ+yKr246cb35jBMj4hFHgzAwelTYZOeCz9b/6xngwIrTqJwfHd9PS
 Hcu+YicsicW3dr15KerFnOniL2Xqj03bfnsc3dGTD2eMZ5rVbBZRBKxbuT5JltOXsbqxKH
 nRz0iOBUIOGQNAjxNA5sFK8yklqs2MM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-uUPPR_fkObG5dT-xtRiT9Q-1; Mon, 25 Nov 2024 03:05:23 -0500
X-MC-Unique: uUPPR_fkObG5dT-xtRiT9Q-1
X-Mimecast-MFC-AGG-ID: uUPPR_fkObG5dT-xtRiT9Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382440c1f83so2701515f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521921; x=1733126721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gv7CRYSGxzo9Mp91cBsW0yHPaWpXNZXh+VQtxbDWVCM=;
 b=fNPaqSOj64bMiX/465QR2TFexQWndHjamqy7q9cwGDbSOrP6p33ThAiRG+xBnwiJSZ
 Px+Xx+e7uCa7FZvj8rjMaSSwvQxHEUbXbFfgwm5UT3/VmGfYhXRwQfC17YEXfrEnS4q6
 ttoVAcjsnoRze7C4LGG567kBNv44WFROQg9i+cxoNiRUPvqaWcp7BfzKdao8me2SLWFl
 HUypaKOB5LAI6/9oSKKs4IjacP37PhD3K1/FmS2jNRHi8Jsng0zcpQ1ejE3L9NwcQ+9V
 cNG/aQgTYM0Bjsp0Oyv/F6O2vavG9v24s4KpZToZQTp7uaTIvsQp5sQcFuUpHNL50O/6
 zpSw==
X-Gm-Message-State: AOJu0YzwVTmYOnKmsrQ/uBUEj4aMKfuUK3DDT6W17i9MS9gzFwGTenh3
 uCzEeYCJcx9BxJmXhN9GdMDcf3xYFMOziBidxPvskKlU62PUr2UKmXIfACeuutkSQrJc0iMUr4A
 BELrR9rleTQR5L+4srozb5sg9N0asofq10wdm9DNusKTf23S+CysuKKhDQNpC0e/T5mSfCFCbck
 OqAOLb9jWvIujHPm99co1Kga5kaBWa+YzctTVj
X-Gm-Gg: ASbGncuqJgYqSss3Y5XhUPVX/r8WwaZ/YAF3/AMJ8TEuZD751UXLIHyvu5YV5H8AVL6
 W/9L/IUjbvzPfYk43jfr0SG/lTvn9zbiaQNqLdkptB9MqE9CyJtTSQM+mCpQKIZ6+Pb5j3+cxdT
 +7bBeDl5LOc9k7GCqjfXDarmiza5Dv6WQ2E2OcYpjlfRzrBEe5jnp6zRe4xsDhAZgPMXSjAKTcs
 v3INfHKJD566S88nxfqAlXAa5vCRrV4qXo0142sgIDosApUrIDKj88=
X-Received: by 2002:a5d:6f1d:0:b0:382:49c0:131a with SMTP id
 ffacd0b85a97d-38259cb7f74mr13493988f8f.1.1732521921090; 
 Mon, 25 Nov 2024 00:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFzwMDdJB5NpLdWmINSf45Vin7xxIQ1Xjnp7zSPv2wYUryZH/iv6GkRrLAlG2kHOqWFLaKzA==
X-Received: by 2002:a5d:6f1d:0:b0:382:49c0:131a with SMTP id
 ffacd0b85a97d-38259cb7f74mr13493954f8f.1.1732521920752; 
 Mon, 25 Nov 2024 00:05:20 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbed9a8sm9574835f8f.92.2024.11.25.00.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/8] rust: qom: move ClassInitImpl to the instance side
Date: Mon, 25 Nov 2024 09:05:03 +0100
Message-ID: <20241125080507.115450-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
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
index f050a332170..21d86b41f2e 100644
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
2.47.0


