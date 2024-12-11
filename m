Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C761E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaI-0003Lv-Ng; Wed, 11 Dec 2024 11:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaA-0002Pw-HP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPa8-0000d2-4A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/CuNDAf/h1lPd4tHb600O5eISjRNvbweuEs0GGCzf8=;
 b=GFFiBk8X+/LhvVXtXQCqyIa6EpQ5ixk6ts1GaX4oAmFQra/8BdRr7BBqyz4LXPeeE3JIFA
 x1PoLyq16GfxXe3Py2BIGoHERNBmEW8eyssaDItfUOQY5k8T+OoaSjSUGMJcyYtA+JI+kK
 0O0iiBcOhEER9Nw/oD2PokD2JKsqjZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-roxdE5G0MUK3Ht4iIgmSAw-1; Wed, 11 Dec 2024 11:28:58 -0500
X-MC-Unique: roxdE5G0MUK3Ht4iIgmSAw-1
X-Mimecast-MFC-AGG-ID: roxdE5G0MUK3Ht4iIgmSAw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so7622915e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934536; x=1734539336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/CuNDAf/h1lPd4tHb600O5eISjRNvbweuEs0GGCzf8=;
 b=uWDTuey0sTwWZp8Ozwf0x+CAtSA1/ms5SxvMnkzqikW6wP1cRP3ODY8DXE+ocgAP28
 VNw7o0efjYWq1VXRWuuMjbCJXTQXIfZbBu5TQGQBmRiHorO/MvqSiiOUGEEByZWfv+wA
 wx3yMYQs9VT+TN/eu1u+RElRq3KdgLdf5nMQLFBeqvNFM50gmQ7xgnxGG18z2U/nVoCc
 mQF3kIKi5VdHPRavl6DNs4A3kuZEebi4I5PxxREhAbwCDaTfgAimQx0dcoIVmuXTw7ah
 32Sxi2uNdeQylG+HxC10Pj8Fxf3tkbyNZJDEpkoQOv3YhUrMjDBXu0bFhSEnljNnsesU
 4+5w==
X-Gm-Message-State: AOJu0YwvCQOEZpKunh2pqdnchI42CFIoPdU/1q64zUQn0GRPpZUle/57
 UN0K6/9jtIuGE6HdD1My1kROaD3x6MUNpzbwqHu8XSpCgW9tGYDwCgiYtrbUt8zoUZOEn2vB0W8
 p8qJp4QQ9DKUqRm5cFpibRDv04xZhylVrQRTJn6qHNUtNcLjsLw4uc6ckzXg1FdGFskJXzIDEY+
 Mw72X24NoCTcCmI8F5yyRoU1KVb8wbQ4MndaDd
X-Gm-Gg: ASbGncvEsHzGjEU/eT8+tLgbDP+y84z4ajf08EvBJRqJAZc8PFVMWI6fcfh1vRAVHaq
 7v/+bFmsB+apKcD4xqeIgiDmO8VRU+1dQyEjRelghMTqnLm9iZsbkS1bWMbBrMA4HUCAwcShwxD
 pzb0auTUxjili8S2BAc2aI6xHJ8a6Nz39Zr3WJvQuqez87qBbJfO3hQBc9Rr4U9Rvj3KdF/u5iA
 fC4bm8One/iMza/Qk9Ix3zz9w1alG74H8Kvnxn6UdxyvJ1eGA+zUH9i
X-Received: by 2002:a05:600c:4ed1:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-4361c3e33a6mr26455675e9.24.1733934536579; 
 Wed, 11 Dec 2024 08:28:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIKxRQz5jLMOwrWnoDAIrwU/8F57LVsCGyig1WpJsfNdP0I/pxvObIbEhGJTwXSkXmCkA/7g==
X-Received: by 2002:a05:600c:4ed1:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-4361c3e33a6mr26455465e9.24.1733934536156; 
 Wed, 11 Dec 2024 08:28:56 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0dd4sm264001935e9.34.2024.12.11.08.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/49] rust: qom: add default definitions for ObjectImpl
Date: Wed, 11 Dec 2024 17:27:11 +0100
Message-ID: <20241211162720.320070-42-pbonzini@redhat.com>
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

Remove a bunch of duplicate const definitions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ------
 rust/qemu-api/src/definitions.rs | 8 ++++----
 rust/qemu-api/tests/tests.rs     | 4 ----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c5c8c463d37..3d173ae816d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -109,10 +109,7 @@ impl ObjectImpl for PL011State {
     const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
-    const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 }
 
 #[repr(C)]
@@ -666,8 +663,5 @@ impl ObjectImpl for PL011Luminary {
     const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
-    const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 }
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 26597934bbd..92b3c6f9118 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -14,10 +14,10 @@ pub trait ObjectImpl {
     const TYPE_INFO: TypeInfo;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
-    const ABSTRACT: bool;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)>;
+    const ABSTRACT: bool = false;
+    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 }
 
 pub trait Class {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 925f5a3c77b..f793ff26e5d 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -58,10 +58,6 @@ impl ObjectImpl for DummyState {
         const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
         const TYPE_NAME: &'static CStr = c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
-        const ABSTRACT: bool = false;
-        const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-        const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-        const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     }
 
     impl Class for DummyClass {
-- 
2.47.1


