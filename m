Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12590E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1Z-0004Un-Hb; Fri, 20 Dec 2024 09:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1A-0004Pl-Ux
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe19-0006W7-EB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFM1GOCm15L/cPIdOg468IxeTeTqWnTkcNuwrJVlvEk=;
 b=UQ3+CzInOQLoxl8M2HvigDBDG345iE4E4Hq4JGU1f+PKDVcxuJst26ljDMZXfpItGtMa0g
 mjm4Gg5sW5VIBlqYp+WLHd5ssqG9W6u3ScjZXkX7I5S8UNvrakoUO55xXSrdVKNLeF2+vl
 oI4BcjSm/RkNX5HkVR5w/T7yRs6SlKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-9CXvubYPO06Rwm7NMJyO7A-1; Fri, 20 Dec 2024 09:30:12 -0500
X-MC-Unique: 9CXvubYPO06Rwm7NMJyO7A-1
X-Mimecast-MFC-AGG-ID: 9CXvubYPO06Rwm7NMJyO7A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so11560415e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705011; x=1735309811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFM1GOCm15L/cPIdOg468IxeTeTqWnTkcNuwrJVlvEk=;
 b=QSLLRPC/kQHvv8jZU3ZxJH/53zdgg42C6qVAjtC6Ugxkms2FM4ZM/gNjjfvC924ABz
 WYcThML2cBT5Gk92yjYwAkFK4UjyH7w8I7WFphA6PvXF1kONH62/tXh95De9/hWEknCZ
 pHClaQeitfNSQADBR8ngNVta8UxoE7cHF9BQJxUo56q1GgaBXr2sF909VYGip4GWtHsB
 LC7cnN11YxY3zzwCtMfxRudmkzB4idPEq4LsOjzHjZ5iOOef92zNwy4paKoQvHSx9Ho/
 DGcdL2UBOVYPg3nCwmSEIGC86rcRtozK0oB/kJYIUFiOaNgGvl6UDc69i9W9GWaBtfqa
 6zbA==
X-Gm-Message-State: AOJu0YyqQ/q21iodLQtSmsas791zz4Ne7Opz0mOx3ek+vdmbmYrGFHCx
 rSiAYh+C9M6DcQ2mFFIxDyBzbwG3441qbc+lbPojuqu67qiahLaQ+Nt93Rky3obr9IPl4WJvVKw
 qtK1r9E2tcaYK1p6Vo47eVIrTFijKzr4dMu0yV6rl4Jrti9QF+bNlaG55VhWXEc/olKgUmuWNYI
 Wa9QK9nuEAqmpn6iR6MfaUsmwekfamXMHjbRVv
X-Gm-Gg: ASbGncumuYXBKsYm8j3a7i3Uo19zCTsk2ZyLcbMopUNAczvDEvpdJWTzIK13gNATMrI
 kqWzXMhJllpyflWTvr3bYaXpJHqK5hL0WaY8BW8iLh9VWtQIJSKRErRuPmXApo0ttYdfbCjF0iY
 C0Jm1mZMVzuYta+JwXQ6smnw6rTVScojH/yP0a1kdG6qwu1aga0fVWsOqWwckviOgcVPsppd1jj
 1TiIlRD4MLGY3NdL/cTZg5TwZHkX6tTs/ZXW4CqWcAhgwUfZxLcF930fyZY
X-Received: by 2002:a5d:47a8:0:b0:385:eb17:cd3d with SMTP id
 ffacd0b85a97d-38a221f2ff4mr2920449f8f.8.1734705010845; 
 Fri, 20 Dec 2024 06:30:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsBlOLZUrNwaMzIzkMoAZdbg7ZYA+lJtaTNcbzaEE8SW0FAHEdFEOqVd9ww/3VkaZ2sjX6fA==
X-Received: by 2002:a5d:47a8:0:b0:385:eb17:cd3d with SMTP id
 ffacd0b85a97d-38a221f2ff4mr2920422f8f.8.1734705010492; 
 Fri, 20 Dec 2024 06:30:10 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847214sm4169434f8f.46.2024.12.20.06.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 05/12] rust: qom: automatically use Drop trait to implement
 instance_finalize
Date: Fri, 20 Dec 2024 15:29:47 +0100
Message-ID: <20241220142955.652636-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


