Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC58DE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGy-0004oL-EA; Thu, 19 Dec 2024 11:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOP-00066L-3A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOM-000899-DY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFM1GOCm15L/cPIdOg468IxeTeTqWnTkcNuwrJVlvEk=;
 b=eJ76o8+IAa1ACvFyaYt7Fy4koZidTho5lhScALrt1YwMyBM4qBfd4q6THgDNkID4FFjV+q
 vMXSm7U7OL91TM/cSbS6wEGf3fCKi5PiMDgH4d8kdqzDuiEuNEXOL8wfiPMTD8APlKjVls
 2mUY+9gLc+VgD0mdWHNHxiX+3TpUaIo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-eFX-leFHO8GeYyZkCN4oJQ-1; Thu, 19 Dec 2024 07:12:31 -0500
X-MC-Unique: eFX-leFHO8GeYyZkCN4oJQ-1
X-Mimecast-MFC-AGG-ID: eFX-leFHO8GeYyZkCN4oJQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso4300335e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610349; x=1735215149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFM1GOCm15L/cPIdOg468IxeTeTqWnTkcNuwrJVlvEk=;
 b=UJhnTsUeW5Ax5p4KeW5TY5P/iG7Z6WAsC3K4bmDiD23YNLyBKfL+t2fgf3/OGuEMMT
 sf3WL9KhAlQEYrw2MHT9/n27hvhnzGegCP4NtBS05WWzggGK4PI+0JLODuAsaUMskQ9N
 kPH2dcv9+K8yI9+Vcet0mxPzeomMh2SWO3DhTotw8IOrkBMUfZmEeuvEqkeZF64GIfUq
 ybdJ9MHoXae8DTsEU4Nenrz+pQMHv06lKW7m1EwiMawL47Jk8IRV3tvH8CRJjCSUA2ia
 CobqZrokowE2WynzciNCcPFf3otrtrEo0lhG0FYrFdui/0S8jvu5nqwilN07nJUoj8us
 FoqA==
X-Gm-Message-State: AOJu0YzIEVg/RLKpzwl6C9kwgeyG1xsDT1Tum2s6miXpsEoephFtQlZn
 n8MPYF1limpb+sqcCneyG8QtuPRU2Gns2e903lbWy0vbG2/fsXiZN7psBJnay5I/Hvcds0ZY3D4
 KmIA4vPaaWK29STQI3efGQjtKoLHAdKgyc1+cYfzXKAlg3Ddf8pcw8sWv0HHRZmc+q7SLWoJd6H
 U1boMc3oBGtLEi5ZNptCmMYYGo/c6aU1TjPxqd
X-Gm-Gg: ASbGnct+Xoex8MKIPi8tfXua3TNIcX1Cmj89kjVscmZ+EriN+/d472j9t0YfVfxHaFr
 wv5aeqbX84VXSmObvOGl+lUH8mKirk0PITL9Lb7gcfpZx8P+aAyUzCb56/CXXHMzE/v/cOelWHx
 F0XSRHSHcCM5mrkLniI6d2Cn8vRZhnBqCDf2wFYqsbjYDLxs0hNPGJCeowBFKeIB5CS2U53fHPB
 Vqgz+bIrFAQwwEB9xJB7WHQKMk+zJwLcqmMkRi2KBwwkxNc3yZNHNTIKGkX
X-Received: by 2002:a05:600c:4e8d:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-436553fe252mr49982355e9.26.1734610349669; 
 Thu, 19 Dec 2024 04:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqqjoeSmDmnBsO3Xk+9gkFZGZo+5L/bZKpFkIrRTdwIgTgSfw5+ohJf2luSFozGEh4bD2WAw==
X-Received: by 2002:a05:600c:4e8d:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-436553fe252mr49982175e9.26.1734610349230; 
 Thu, 19 Dec 2024 04:12:29 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea387sm16221995e9.6.2024.12.19.04.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 05/10] rust: qom: automatically use Drop trait to implement
 instance_finalize
Date: Thu, 19 Dec 2024 13:12:11 +0100
Message-ID: <20241219121216.416905-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Replace the customizable INSTANCE_FINALIZE with a generic function
that drops the Rust object.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 1341a173893..861f1e50ac4 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -180,6 +180,16 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     T::class_init(unsafe { &mut *klass.cast::<T::Class>() })
 }
 
+unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since drop_object<T> is called
+    // from the QOM core function object_deinit() as the instance_finalize
+    // function for class T.  Note that while object_deinit() will drop the
+    // superclass field separately after this function returns, `T` must
+    // implement the unsafe trait ObjectType; the safety rules for the
+    // trait mandate that the parent field is manually dropped.
+    unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
+}
+
 /// Trait exposed by all structs corresponding to QOM objects.
 ///
 /// # Safety
@@ -438,7 +448,6 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 
     /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 
     /// Function that is called to initialize an object.  The parent class will
     /// have already been initialized so the type is only responsible for
@@ -474,7 +483,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
             None => None,
             Some(_) => Some(rust_instance_post_init::<Self>),
         },
-        instance_finalize: Self::INSTANCE_FINALIZE,
+        instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: Some(rust_class_init::<Self>),
-- 
2.47.1


