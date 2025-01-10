Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1657EE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK21-0000El-VQ; Fri, 10 Jan 2025 13:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1w-0000C4-4d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1s-00015k-0J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBR/uFjAg+sgDERa7azkccUfvjafKjeZQfYH4Q0wXiM=;
 b=UIA4Hbl7Sca1ijj2jTHhBlcDMNquO04Y91AryojHqfiz8luDXtXg/3Hy+hrDINNmt1jTzr
 +CU2ZKb/Ne5c3+KVmrYq4y5AxhVerQDUYn5VCrPMSD/UpRTE8QrRTKgV5qBjznmQt2iGQr
 BHS0lFMGXfcghjed3dB2x3AC/VZC+qs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-RxBQcHLxMMqZJvy3iFAsfQ-1; Fri, 10 Jan 2025 13:46:40 -0500
X-MC-Unique: RxBQcHLxMMqZJvy3iFAsfQ-1
X-Mimecast-MFC-AGG-ID: RxBQcHLxMMqZJvy3iFAsfQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa69c41994dso170101366b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534798; x=1737139598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBR/uFjAg+sgDERa7azkccUfvjafKjeZQfYH4Q0wXiM=;
 b=Q8IYDyDgi8Mgi4+J79VbUx269c4Rr1HcG5J8OAi1ecV4Sr8bKaa5f9MerephvqjoW2
 w9KcUt0ckZmGy5KtE3r1BRW+yJege3h+Gqxlxbl/KazfcJx1YylaeFe3ivv+6nNuVdbR
 4Xz2AvNyToaBqu/ZtpuVJ/CWkTs7w+Vj5ZbLjZeDMlJh2hhjKbdv1dxeRn0Lw7BR5IMY
 xZz6gzLb2RepV1UEVXB905f4vPhkNMU7EKKVqyGVwuuVwN97gP8l+JBSnvnQ3q+mY868
 Q5IXhHeX3KwGlJcw3j6RgTg3vcI3UXzFQtPADXHtbsQIehenkRGoPhL3HPXhu9mQuuap
 /Nbg==
X-Gm-Message-State: AOJu0YyyMqGQPzwR9iv/7ThmbkhpK0m4YeI94aGkuXchgbRXqaZ8iyuF
 XRa0zngFVmEaykathysqYzc/i1k9zxBKXgcNxF+1DdIGgaraUMyXHKk83g3RAnZ9OdJydkbsOQ5
 sY7wtjGzRTGoXCfxrBb3AKFy0hYH0s+CqwlYAG67ixcgthGzy6P50xQ/2V2rhTWCgWzT2JQICNt
 RKfvGjSXwqMZn0ONR0eb5rprQo5f1WXxSmFaP4Ud4=
X-Gm-Gg: ASbGncuZZufOTyXC1TJ9r4HvL0/e4N4Ji0Dp8lEc2ORsOAT5MlQE7U4H0e992ZelqTO
 63Zj4eofFujQNA0poMaqmm2d/mwZeDaJCUBvpN6pQLCKLq91XnpQDL4mwIOda9krEZ0WlEq81NU
 SBiPx3A1cIfFx1c4xCQtAcHtYtElr4lLdyISbFPFN9jS5AuacUaaA7hKigqdWiLShVKxE+P8uWg
 eaJbquUVYqQyUpRvajsGYoluK4afTct/cFvoKV6dLx3hAxf90o/a59GGWI=
X-Received: by 2002:a05:6402:4310:b0:5d6:48ef:c19f with SMTP id
 4fb4d7f45d1cf-5d972e708a1mr26256487a12.29.1736534798464; 
 Fri, 10 Jan 2025 10:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmJX3Pubw9RmVY5LHah+mvaqqwDsZjHdPSmVQYMun/126OcezaDJLjyocjjwnGRGRCTFgxFQ==
X-Received: by 2002:a05:6402:4310:b0:5d6:48ef:c19f with SMTP id
 4fb4d7f45d1cf-5d972e708a1mr26256439a12.29.1736534798034; 
 Fri, 10 Jan 2025 10:46:38 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905cd15sm193313866b.5.2025.01.10.10.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/38] rust: qom: automatically use Drop trait to implement
 instance_finalize
Date: Fri, 10 Jan 2025 19:45:48 +0100
Message-ID: <20250110184620.408302-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Replace the customizable INSTANCE_FINALIZE with a generic function
that drops the Rust object.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 40d17a92e1f..b0332ba2477 100644
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
@@ -442,7 +452,6 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 
     /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 
     /// Function that is called to initialize an object.  The parent class will
     /// have already been initialized so the type is only responsible for
@@ -478,7 +487,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
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


