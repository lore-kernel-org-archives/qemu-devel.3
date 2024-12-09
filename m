Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD0E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1S-0003y9-Bw; Mon, 09 Dec 2024 07:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1P-0003wd-R5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1M-0007Ra-Br
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnI0niveAFX2WdKfqxklK+1Zt06kPSFJCN7eFa7HF+8=;
 b=JKKeKJDr/MFU5pmOM9Yhn5rhxjOrLv/dTkwB0fp3e8KSqtYbXgClDWxibz4q20Ak9Nksg9
 9pKGqY2CiTNB56i47inSReccjtPy9PumrkQPVX+feXejOaTU7aG3lm9NdeZa8wnpklTLCW
 6/i1KIuLpISKzbNqcX70HiGB8ZyeMb8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-gHA1aVjTO12IlGRPdoVo3w-1; Mon, 09 Dec 2024 07:37:46 -0500
X-MC-Unique: gHA1aVjTO12IlGRPdoVo3w-1
X-Mimecast-MFC-AGG-ID: gHA1aVjTO12IlGRPdoVo3w
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d51ba2f5so1655300f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747864; x=1734352664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnI0niveAFX2WdKfqxklK+1Zt06kPSFJCN7eFa7HF+8=;
 b=W/OEzT58pqLF7jDFiZb3jPUgCCtw+H4n84dn3hG0aSs6D239Jjx6K/Kxj8ffHpcvrp
 y9tPHTEMB+Z2IwYj7mzHlDtNUOFVQdedwPVOF9S4Lg7keNvRHUs9Uh3BFPWTAjgSJj2o
 nM63/ehtpfasiPnLd7vhBX8PgquFZ9VpTALmR+uW8v9IhPRq/j/A94642k0BZTYfriR2
 /TFlnHPICRF20F9fwXb/+z3cW0gwsJ2RGjc9snfpAgfaxOg7fAAauWkV2zWXdz710qco
 PQDvCFQc6z1mGfeNDCE3+LHlVCbA42S9JEc0rL6Rv3vrXhrzJs0n+JqV90LNq5VcUj+s
 LqoA==
X-Gm-Message-State: AOJu0YxI815ZAFO8RsCiW7fJ0/z+toetuTDwDXoZwyQsP/6+ml8IJiUl
 AMF7H1AUtnIbKokolJ+sDOPVaNW72514S9TVI0fWzD5j8aY2B5ZNedcCTvPeZe2WTe345ve6P2s
 Ns1gZednnKHCzuOxwmjfPZXk3lTQT5bphrSoIOe2S7hBvb4GKxMb6WGt6hLpaYd4h3CNtCrHVAd
 UEc3T47kT0pKNYqBqh6ZSbIqfCsaZtpmvydu98
X-Gm-Gg: ASbGncsXZJRsWJm2J6tnf4T8yWQrL7Otq4ZI5u9ofe7iyE6yEPu6hLbjDFfCBZSogoN
 L88xWe/CCiMRFdzmR+huoCCTRshHEiiQJGgTzbIbeZ2tv/tINV3XFqpSqw/nJ7rzHSJ2wnDcpQO
 D9MJmsrZFpbG++sk7bHkJDKkRN1KLjmck1j/D5IBTDgZJdKcC/nBPG8ra5W2zxXOkiEDUK+SdO5
 w/xuHj7qgIgyambsS7jQqPPYsN7manXBH5KT2hyNMB1r+fbVKcDyQ==
X-Received: by 2002:a5d:6c69:0:b0:385:e013:39ec with SMTP id
 ffacd0b85a97d-3862b33f0d1mr9303165f8f.8.1733747864322; 
 Mon, 09 Dec 2024 04:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaI5mpcGtPfQA/5tjvnqn4QZw2Pce8+RV3HgH+A6JNVqnFNEEY9kcB0+Ainpq7S21I/hgG8A==
X-Received: by 2002:a5d:6c69:0:b0:385:e013:39ec with SMTP id
 ffacd0b85a97d-3862b33f0d1mr9303141f8f.8.1733747863883; 
 Mon, 09 Dec 2024 04:37:43 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf40a0sm12875064f8f.13.2024.12.09.04.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 10/26] rust: qom: move ClassInitImpl to the instance side
Date: Mon,  9 Dec 2024 13:37:01 +0100
Message-ID: <20241209123717.99077-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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


