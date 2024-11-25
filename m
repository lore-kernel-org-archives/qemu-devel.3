Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A12D3B7EB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU69-0004pM-Li; Mon, 25 Nov 2024 03:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU5x-0004mo-6v
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU5v-0007HA-FZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YzRwPCPqfMJAUUv5E85p/jUSPh5N41oWjEesEjecPY=;
 b=h21wbRZ6XiwiTFVjS6jqgHlJP/j62hl0zUPjeXO3qeaqq6fM/+hUO9AjdlpoPR4Qja9Gdx
 RH/6/rBhcNugeGwQIzyTvLX9d8LJmilBWAXmTigpDp0U/zOoxDK2INwuMLS+M+102guixJ
 4EU/lDSMkEutilcUqSTJXbXjM8HtDBM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-0tujKWceNdO8Cu5PvKr3Jw-1; Mon, 25 Nov 2024 03:05:14 -0500
X-MC-Unique: 0tujKWceNdO8Cu5PvKr3Jw-1
X-Mimecast-MFC-AGG-ID: 0tujKWceNdO8Cu5PvKr3Jw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349eeeb841so5411775e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521913; x=1733126713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YzRwPCPqfMJAUUv5E85p/jUSPh5N41oWjEesEjecPY=;
 b=vFy6l0/YhS07VAmIi8fMVN18srK6Hz+/Er4m7XQdYDevF9anFSzQ+h07HGV+0rukle
 9oowtjoSOW2BrOPbgylodIMFnPW3jVT4IbWsxnJIXB9ce4zMAlmNibjEaKPi2T9uKV89
 je7CS9vvEkly1bV709SFaeIi/9fOMWeLakG6ZKzrhDlNY9l8PuyeRR+Q9qG1UB/TU8G5
 eBZKzg9zj3xUu9EhT9iB2381vLTjubcUM4eaezuvicOzfouWQ/Rf9dtYX6JkM6iadksB
 s56TRHahCuNfmfl/SqtKJh3msLube0LkwrRRuTEmWQT7U6gV4zmduxfq0oUuJC2C4sMr
 yhSA==
X-Gm-Message-State: AOJu0Yz7HieAyLvfhBdzXzWv9LQPF/RFhimG9ENggL+mGFo2lZp6wzb6
 /4/1xOHNbnQXfw15NLMuNm6Y9lwLpTOZDxvP+jNCeVV6rcJIQhx11rsY60uXskXXQAdPVDXhGpL
 7SO4bciLB1168Ua6YQQLuBvpbSzlY5UgzqT7ez+SSlCC9XjLQTSId2xxXKUEZZvCzvvNNAtme39
 XFtBO+CN0acqnrT6a1FeHKJh4++9r8QVo0unw8
X-Gm-Gg: ASbGncuSuhEh+sMUyZAPVRZzVjC4d4G6In32+GGTsDTCMpawc3Oizxcueq4KEWNNl29
 4opfaemhEYfC7Vb5QtOwuWNYZpVdl7racV7lLiKP3n0x9Bu7tJV3tU+MZXKQRkNGPvwZECxjBDm
 nR3bLMALZaY8pAgxdiqMCPghf7r4knc3cZOz5dCc8G3hAVauKJTzLinEa2ZijeNDPZs+kY/CmDO
 HG2N4D85fzn9dsAb6YPf3mGhTJWPTBaHMfNvR7oyIiltDfSY6GFo/w=
X-Received: by 2002:a05:600c:1e8c:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-434a10f016amr8175135e9.9.1732521912928; 
 Mon, 25 Nov 2024 00:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdwNws0+xZD9wCQ46zmqUvjw5T12MCZnWPB0Xl++eDA+C4gGqWo1XQ71HT6mBe8ZblRHa2rQ==
X-Received: by 2002:a05:600c:1e8c:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-434a10f016amr8174835e9.9.1732521912458; 
 Mon, 25 Nov 2024 00:05:12 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434932dbc7esm68029535e9.37.2024.11.25.00.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/8] rust: qom: add default definitions for ObjectImpl
Date: Mon, 25 Nov 2024 09:05:00 +0100
Message-ID: <20241125080507.115450-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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
index 7e57634bba0..f47e0f48d8a 100644
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
2.47.0


