Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FE1E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd2W-0004g5-V6; Mon, 09 Dec 2024 07:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1Z-000422-JF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1W-0007Ut-Dn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQQh40wwBPdVycCz9xzGGWLkoYV4qfuAlbHWnwDiqjM=;
 b=CbT70MR8yMK5ok4IVwmrq0nDrUXcgq/9DAJQKbd3Q8Ee0v+6N8KsHAmFiYj2TvFxBrGKXT
 kpsVu691UHSuQhy93bLtMFx1UvEQ3CtRboCw3+k21iXlpBMxz8Aqn9l0PIYnk69h25vZ1S
 kpTgSFMdCnjPmSUPntyBlUuDypKjyXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-os4guXI0Mb6mx-a0s64ilw-1; Mon, 09 Dec 2024 07:38:00 -0500
X-MC-Unique: os4guXI0Mb6mx-a0s64ilw-1
X-Mimecast-MFC-AGG-ID: os4guXI0Mb6mx-a0s64ilw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso1815896f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747879; x=1734352679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQQh40wwBPdVycCz9xzGGWLkoYV4qfuAlbHWnwDiqjM=;
 b=EZfpRPDL2Wqdw4+Xae5Dx+CMnn8In7fIkSpQRdSSrySUSg3LLhrAO7N3rVhb9cgZ3Q
 5vSN7H3sf46h34AoKZdgHQYfFUPW5PWL8glXT1NImT/MtbmpzeqOCG8OigSkxPBONQPg
 0VV6MUyII/PYtaoArNyHTAUFuWrU/ED9sbKCOiEQYOjszMfR5sqiUsDizLoquvMO4O4d
 05u/zQyn5/tfJ748QHruWsuqfDsmzNY41r/W2mpqYKKMGBSxdXlh/OXYpCetD/bZBBfr
 agyuJ+D+M24oU/JHjr2a0/ZlCbG6JLuNWZcYItSp7zWSEkGciB0/xOiatnOl/1nED1iD
 gG6w==
X-Gm-Message-State: AOJu0YxSh7NcKJMoXY3d104TFqd54PqLde05Y/1QcoS7y0Jpb81xczVu
 hiPIKxlVmf8ZcyA4+UDYVpN9etmNvyDBwrFr05xGTwGfVzQJcsZQLnP1wWOhzI9aRY2fDP8Woas
 9MPHOhfjj1vryGVa+bWMb2+rYHMNAQyHUVg/6hOBHUjP25+85S9QNty7fuZ6D906yUGuH7j3UXl
 5RZz8fBudvhQh7Hm450ZFY0MRGcjrkyXGvE2HV
X-Gm-Gg: ASbGncvX9HWCgCLz9uELQxeZ/LepDjdtPmEMG1rJBqAuHHAQRBvhuI7mNqFHxAWGFE+
 04Ve+wjzwnJtbnQP4xtFfW2Uu3vx7njdIgNw4a5r7HCWBALhqAs4wL7VPHniJNpf7DW/ylN0zoU
 fYDW5JF+B8+GJSCvnGM9vkZX0GFuZNQJqGCuTbrnhWFzQrVIodL+OwH+E1mtVaudW95LB/ghrFY
 56ARU3pea4982N9OHtyHWfIcwHJQZEWw9REWzaaRGmzMqPrlbKYlA==
X-Received: by 2002:a05:6000:144a:b0:385:f8bd:6e80 with SMTP id
 ffacd0b85a97d-3862b3e4458mr10190703f8f.56.1733747878846; 
 Mon, 09 Dec 2024 04:37:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzFTifBSYSzW3fJ6voGMUSVISIXLUfyNsk7svSndINudfaxbHG86MfKOEGzZf1d1Bacsuo1w==
X-Received: by 2002:a05:6000:144a:b0:385:f8bd:6e80 with SMTP id
 ffacd0b85a97d-3862b3e4458mr10190680f8f.56.1733747878378; 
 Mon, 09 Dec 2024 04:37:58 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4119sm12925315f8f.14.2024.12.09.04.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 16/26] rust: qom: change the parent type to an associated type
Date: Mon,  9 Dec 2024 13:37:07 +0100
Message-ID: <20241209123717.99077-17-pbonzini@redhat.com>
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

Avoid duplicated code to retrieve the QOM type strings from the
Rust type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++++--
 rust/qemu-api/src/definitions.rs | 8 ++------
 rust/qemu-api/tests/tests.rs     | 3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

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
index 1c412dbc876..1975ad91867 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -57,7 +57,7 @@ pub unsafe trait ObjectType: Sized {
 pub trait ObjectImpl: ObjectType + ClassInitImpl {
     /// The parent of the type.  This should match the first field of
     /// the struct that implements `ObjectImpl`:
-    const PARENT_TYPE_NAME: Option<&'static CStr>;
+    type ParentType: ObjectType;
 
     /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
@@ -76,11 +76,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl {
 
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
index 1be03eb685c..2a72b0f9276 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -53,8 +53,7 @@ unsafe impl ObjectType for DummyState {
     }
 
     impl ObjectImpl for DummyState {
-        const PARENT_TYPE_NAME: Option<&'static CStr> =
-            Some(<DeviceState as ObjectType>::TYPE_NAME);
+        type ParentType = DeviceState;
         const ABSTRACT: bool = false;
     }
 
-- 
2.47.1


