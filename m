Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E84CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM5-00087O-Tz; Sat, 13 Sep 2025 04:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLz-0007jP-FM
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLu-00055Q-Gj
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iluv+QIb78kWuCIudcMWz/g7umwpNBxkwVQHtsNc6TQ=;
 b=A4D6Xz2twWXbM47GB5h+9ksXoAz4dUF7me3aryGk8FW0IXUW2R8akzUUxnUZemfHimsAHW
 ywROlhqm1yy4ZoC/LvBiUq0fJnBjY1uv/2xZaf2D3YHXCzZBtRZ5zhC8L19QOk/sFADKo5
 5pe424ev81Y2+yrqhHr0IW9hTNFlSy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-BDYhZ4fENGCXR-vLqkJkYg-1; Sat, 13 Sep 2025 04:11:18 -0400
X-MC-Unique: BDYhZ4fENGCXR-vLqkJkYg-1
X-Mimecast-MFC-AGG-ID: BDYhZ4fENGCXR-vLqkJkYg_1757751077
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3dbf3054ac4so1336446f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751076; x=1758355876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iluv+QIb78kWuCIudcMWz/g7umwpNBxkwVQHtsNc6TQ=;
 b=EeoY6KDeWbTJsur12yjUl40990bejJOgqOWtcZ+2HwIZ41LwGAk3sC8eFN4/Ye1Wc2
 eq/4zX3dsQhiNX4slpLz0QzwSJZCKBP33LdI6EzmJ2uUECY787500ZQmR6nGR4F1C4YJ
 ZAa3xYkxxCTljE/7gv9ILXbghen+bub3pkewaVFb4FW+SSdx3mxgHlPXlQMN43kJZpM7
 gzG9HQvJkLF1XfWQU2H3o3Mogbul6XjdaoQjQutl1z7gvNjO4LepR+y72Z4nzSzpJA/p
 8RhqaC8qP49wfrdk9V6+JFjPOH5IRPZndReWfaz3B1n1rBEb+YBZSzuIoyGy0aRxvuib
 g/Cw==
X-Gm-Message-State: AOJu0YwWix0V8fj2EEOD2j2k9hbUBiYEjIp2Idk0G0LSFdgIW7M0lczl
 rG7Xb7hT/zo+Jt7Gaw89eWvf/4FKEqcWhTrrBK8BcPUB7unr8ywAkszW3OxUpS6QdZ6MtIvFOWG
 6FY58xO5DrXwQWvGrdrVArST8/jvKTS71Iv1IzesumGZiCWefpMHUWjqoKGU1WAOZm2ZlwiQWS2
 DSW81wfT/Qzhabq3VY/69VLCwTYzjDfBosNJSJASD3
X-Gm-Gg: ASbGncvhxFOnZ8uY6O5qnJUsrknY8ffKifGlqyyVewQjoKC1PFTpHVx4JkVrBz1qtic
 BvWlf5zhR4ADic+0P/cqWPjhGwFbLctCkt5p/8FzAaodfyoTIQi6IF3S0lIqr0496x6LPEI96Yf
 NaiYpqzgBUCGX/L4guGaaw9kzmiTLF/sQqAlCsDWSp4Scfka2rLGR3EgjjIpJvXEzS+26hOkGUF
 Rft5zvkrSM7I38cTofjXkuPh9ZnNIMwWvrhbc3WT8z/Fc/BftsrpKXNAw+twHpISfakEGCCNcXt
 yLI14DwJbGvrhnNDGc4lcjg01uktHGJh9nK4jx6Q/yk6VY2IMSmjXsC6Do22ayqcvx6nYM6QLQJ
 4v6Ch+Xe9ibycJCGXIhUCadAP9b5o5TI7coeH/PWaa9Y=
X-Received: by 2002:a05:6000:270e:b0:3e7:9d76:beb5 with SMTP id
 ffacd0b85a97d-3e79d76c25emr2423555f8f.14.1757751075916; 
 Sat, 13 Sep 2025 01:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK/YG3JEqhn9sJQCjq+gGScehDmcQVqIaQjnDKY17LGki0kDxLyZ1OZFOFrRdspYtkNIDPKQ==
X-Received: by 2002:a05:6000:270e:b0:3e7:9d76:beb5 with SMTP id
 ffacd0b85a97d-3e79d76c25emr2423532f8f.14.1757751075445; 
 Sat, 13 Sep 2025 01:11:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e85610cc17sm2113807f8f.54.2025.09.13.01.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/61] rust: move vmstate_clock!() to qdev module
Date: Sat, 13 Sep 2025 10:09:13 +0200
Message-ID: <20250913080943.11710-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-8-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs    |  3 +++
 rust/qemu-api/src/vmstate.rs | 14 ++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 436142d8aef..e2b4121cac5 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -17,6 +17,7 @@
     cell::{bql_locked, Opaque},
     chardev::Chardev,
     error::{Error, Result},
+    impl_vmstate_c_struct,
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
@@ -455,3 +456,5 @@ unsafe impl ObjectType for Clock {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
 }
 qom_isa!(Clock: Object);
+
+impl_vmstate_c_struct!(Clock, bindings::vmstate_clock);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b5c6b764fbb..59c7950a5aa 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -41,7 +41,6 @@
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
     prelude::*,
-    qdev,
     qom::Owned,
     zeroable::Zeroable,
 };
@@ -318,21 +317,20 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
+#[macro_export]
 macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
         unsafe impl VMState for $type {
-            const BASE: VMStateField = $crate::bindings::VMStateField {
-                vmsd: addr_of!($vmsd),
-                size: mem::size_of::<$type>(),
-                flags: VMStateFlags::VMS_STRUCT,
-                ..Zeroable::ZERO
+            const BASE: $crate::bindings::VMStateField = $crate::bindings::VMStateField {
+                vmsd: ::std::ptr::addr_of!($vmsd),
+                size: ::std::mem::size_of::<$type>(),
+                flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+                ..$crate::zeroable::Zeroable::ZERO
             };
         }
     };
 }
 
-impl_vmstate_c_struct!(qdev::Clock, bindings::vmstate_clock);
-
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
 // could be allowed.
-- 
2.51.0


