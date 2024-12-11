Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E46FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaX-00045U-8Q; Wed, 11 Dec 2024 11:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaS-0003tS-06
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaP-0000ja-H5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIfu49MPuojczIFu4d92ofEWS3l26By9bJ1+rMMpb2o=;
 b=O5AVtBGgzVREWQjWxFrY45tnpc2dT+oAndxICIGDR/02ug6cV8xT7dbV1sQAwn8EaKWUnL
 FrSLk2J6NvckTkiZ4k2gb8xsGTo/AHfSA34W4EqYqYDfYtdIxC3vGuTn2i0DoZq7VHKY21
 GB8QtQdPNJXQlXioeWa499dKb2wENgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64--x7Rf_KcPFe9dnmh9cr6ew-1; Wed, 11 Dec 2024 11:29:15 -0500
X-MC-Unique: -x7Rf_KcPFe9dnmh9cr6ew-1
X-Mimecast-MFC-AGG-ID: -x7Rf_KcPFe9dnmh9cr6ew
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9d23so9704985e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934554; x=1734539354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIfu49MPuojczIFu4d92ofEWS3l26By9bJ1+rMMpb2o=;
 b=tp0Rt9weM/MnKlecp2md66n73dEdcG/jOZ0Kd14F2j6Oa6bBTH//beuHjsPeEi+DEv
 tpKmpZvf0jFos7PpGjngMJeLF9xeMhQrPA8ll+TbGeZ57kFNV5i1/IOE+ZbrOekEyzBS
 atvqISWVZbl3HcDjt8GJxuH0d7WHAaW/c+M1cR77Y1iPYV/F40dATabgJ93osX0ZSxkz
 UKN1txDNFLvksZFT0pigKEEL50NeFSzaB06Nam4yRQfMZl5fbftf/sBhmBem9SyArcad
 GAVPl19Qh1A7Pgjs4ywWRevWSufrQD7RE3nJdJkUl6XYFIiljC2gQRD7qseh4JJa5zI+
 9s7A==
X-Gm-Message-State: AOJu0YwjDLMQe4+MgYlvroFkb8h1o4YMeIwBEfeIvv4pVMXdGcHe5yXV
 Q5JLVNJZjqonOQ9aRxAJfuQf/jhwg9d1gLMhhINY01e5UaWe0iZbmtCsjtqrEneN1pkWRJVF8Ly
 lIB7F1FQu9fc1a0Gh7EgYTm9khjWWQgEZBoZ1G1NaiVlR7dG5CodUL3VtzmOOiyr4n5f6R6Pal+
 RU5tJqpXfFjH2JClFHrXnbXpvQLFuffv9pmZqH
X-Gm-Gg: ASbGncvKUlB9xq3F0yBPvUPxPTJ+6zRfV4MOSe7OntQY69k7Hh7PfROlyy4d5ws0MIe
 pcslNifnkzpC8oRaz7Jl34HcmNO9MzJ8lnMx+cClHpLalYaWGY8knn4XcMYtP977fggBosK4y2p
 w+L5egpHvKs4AFivXE65YysZcUlQ6ypMYRRhRxmqH3hhlKJMK8vAl5/tqNXmUH7p+4K9hkzVjct
 jxcTe9SLBz1/o72OYwUtxqv06RVkuFw8YXI+S49FQQucMKjlIN3slIU
X-Received: by 2002:a05:600c:2319:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-436223897fcmr6273345e9.1.1733934553704; 
 Wed, 11 Dec 2024 08:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNbvpuYBMio39ieukd9leaknbfKPEdcMKwzMEi92XgaDVHG87b3v/ao3VetX6ok6YmdlcqgA==
X-Received: by 2002:a05:600c:2319:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-436223897fcmr6273085e9.1.1733934553269; 
 Wed, 11 Dec 2024 08:29:13 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436222ad969sm3767995e9.44.2024.12.11.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 49/49] rust: qom: change the parent type to an associated type
Date: Wed, 11 Dec 2024 17:27:19 +0100
Message-ID: <20241211162720.320070-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Avoid duplicated code to retrieve the QOM type strings from the
Rust type.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 ++++--
 rust/qemu-api/src/definitions.rs | 12 ++++--------
 rust/qemu-api/tests/tests.rs     |  3 +--
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0ab825b1ca4..3e29442a625 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -113,7 +113,8 @@ unsafe impl ObjectType for PL011State {
 }
 
 impl ObjectImpl for PL011State {
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<SysBusDevice as ObjectType>::TYPE_NAME);
+    type ParentType = SysBusDevice;
+
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
@@ -650,7 +651,8 @@ unsafe impl ObjectType for PL011Luminary {
 }
 
 impl ObjectImpl for PL011Luminary {
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<PL011State as ObjectType>::TYPE_NAME);
+    type ParentType = PL011State;
+
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index b98a6926785..df91a2e31a9 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -45,10 +45,10 @@
 /// - the struct must be `#[repr(C)]`;
 ///
 /// - the first field of the struct must be of the instance struct corresponding
-///   to the superclass, as declared in `ObjectImpl::PARENT_TYPE_NAME`
+///   to the superclass, which is `ObjectImpl::ParentType`
 ///
 /// - likewise, the first field of the `Class` must be of the class struct
-///   corresponding to the superclass
+///   corresponding to the superclass, which is `ObjectImpl::ParentType::Class`.
 pub unsafe trait ObjectType: Sized {
     /// The QOM class object corresponding to this struct.  Not used yet.
     type Class;
@@ -62,7 +62,7 @@ pub unsafe trait ObjectType: Sized {
 pub trait ObjectImpl: ObjectType + ClassInitImpl {
     /// The parent of the type.  This should match the first field of
     /// the struct that implements `ObjectImpl`:
-    const PARENT_TYPE_NAME: Option<&'static CStr>;
+    type ParentType: ObjectType;
 
     /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
@@ -82,11 +82,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl {
 
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
-        parent: if let Some(pname) = Self::PARENT_TYPE_NAME {
-            pname.as_ptr()
-        } else {
-            core::ptr::null_mut()
-        },
+        parent: Self::ParentType::TYPE_NAME.as_ptr(),
         instance_size: core::mem::size_of::<Self>(),
         instance_align: core::mem::align_of::<Self>(),
         instance_init: match Self::INSTANCE_INIT {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 1d027dd6527..278efe967fe 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -48,8 +48,7 @@ unsafe impl ObjectType for DummyState {
     }
 
     impl ObjectImpl for DummyState {
-        const PARENT_TYPE_NAME: Option<&'static CStr> =
-            Some(<DeviceState as ObjectType>::TYPE_NAME);
+        type ParentType = DeviceState;
         const ABSTRACT: bool = false;
     }
 
-- 
2.47.1


