Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CBE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1O-0003ul-4R; Mon, 09 Dec 2024 07:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1M-0003s0-Kj
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1E-0007Q8-PQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/CuNDAf/h1lPd4tHb600O5eISjRNvbweuEs0GGCzf8=;
 b=JXpmucRdOBFy6WweyI04LSvQW/FoWA283cYKpzp90t7sKRtrFoiww2fXZaGZNDrxDefpp7
 f/6l82jlX68mbJpK+Id9zFnhwPkRJc3ydKOofdeYiepFs7QIaSLJ6cUJgOjbIvBAnXWDK6
 c5moH9PJPnykApOzOqlz9vYZmKrh/Ls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-LppsLzdCPvewx-pvpsPnqQ-1; Mon, 09 Dec 2024 07:37:39 -0500
X-MC-Unique: LppsLzdCPvewx-pvpsPnqQ-1
X-Mimecast-MFC-AGG-ID: LppsLzdCPvewx-pvpsPnqQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434e8beee61so9513785e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747858; x=1734352658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/CuNDAf/h1lPd4tHb600O5eISjRNvbweuEs0GGCzf8=;
 b=NVlMQlW6L1xPuMf9eYjEgTmTp8HKMhIKOFcyLBU8+NhO7alWQuxgPK9pKib5EQj+gd
 F+DI5VbTlUNcV8cf8c7ALF6ooE6G4HQMP82HpsYX9JmS1zz8Rc//D7KZ9ksWBdleXhcw
 CqyeyZ3jJrU688XUB70JD/ew34PnL4c1zwM9RTpONVIOzUJ7ZwpbqP68K6Onb+fH3+IQ
 whXDtMrdTUH8NNh2mMx1E0ToWzOSUctcClzDIpPcQGDTP7+D3Qi0Abrb0wKGiCz8/ZJp
 Qf58pYuakW8dL7RoBMeRZhkR5/TBvw+Z7AK444maF+1aPLPSLrZmLME9e7ihTxeENY2k
 +H4A==
X-Gm-Message-State: AOJu0YygkeMPeAXt9Mvf9TC9rEUfrubTENMyp7dtezBbvAVpkeYDdNEq
 K2cBBMuBNp6L2ZrDvUZ2jAk4f73f7BiOJIqisjucjqxTwi036dE9OeqSrtsF2BrwqKHmx0tytpT
 npkbs4hjIvFXI7+uF8LVIRsv7E/YeyL3W/larWHA2ZXqjGPWalSen5F6OrxHIFeZLBCbFJ7klFS
 x71qEY3u8PWTJifeMsQ1DhODXI/lIWag43JKF9
X-Gm-Gg: ASbGncurqKHg7d5VD8zrOANZxDI1hD1dfdfWDQSe9lSQEE5FgBmnvxPXRx2ljHUINsi
 BapLz7ETZVzh1YHIh1fHc8xC5YYIIVBdEqwGoBGk4ZH/9ADBQff5NrHwdxb9K/0LGT2XkvyhT6J
 CTpg9I7CXqikZMJhuIaBj8nniAvsj/vDbeFSymlh+ask5rFJlnkspYdyCniA2A3XrQFhHih4/Uc
 D3q0mIW0nW8C36vvDMqq1+zxR7YWl93iRIXLxEGJo9nWmnSddlPoQ==
X-Received: by 2002:a05:600c:3b1e:b0:434:9d3c:31ec with SMTP id
 5b1f17b1804b1-434d92bf66amr121068015e9.10.1733747857763; 
 Mon, 09 Dec 2024 04:37:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKosmxVjsdlGtzG1n53ELAg0Tz6RFW8udLUmBqIrFlJPlfcQ6F4Dy5UXlW6uhM4cO07tODkg==
X-Received: by 2002:a05:600c:3b1e:b0:434:9d3c:31ec with SMTP id
 5b1f17b1804b1-434d92bf66amr121067765e9.10.1733747857319; 
 Mon, 09 Dec 2024 04:37:37 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0be4sm191423765e9.28.2024.12.09.04.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 07/26] rust: qom: add default definitions for ObjectImpl
Date: Mon,  9 Dec 2024 13:36:58 +0100
Message-ID: <20241209123717.99077-8-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


