Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9F7E77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3I-0003SJ-JW; Mon, 30 Dec 2024 19:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3G-0003Rf-MC
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3F-000200-8c
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uVl+dn480T+3VzLrS0d1h50fyBb5C28oZegz0tUkU0=;
 b=etWASUxGxPJ0RYkbzgcP8cc9f6r12QQ3CVhyDWbMXmNsoFAaniU8z43SXbfvXL5ihpalnv
 36Hki5KvppLG3WOSI+tkztu5vSW7hzehhlaO8rrS5HO+Q3obkuqOzYOIBydg/ak1rk9U/z
 jjKToO/7A22PLqjzgPys5aZ6qu28S0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Q3iMuuafMrOcx52ztwB1Vw-1; Mon, 30 Dec 2024 19:23:59 -0500
X-MC-Unique: Q3iMuuafMrOcx52ztwB1Vw-1
X-Mimecast-MFC-AGG-ID: Q3iMuuafMrOcx52ztwB1Vw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso4815427f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604637; x=1736209437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uVl+dn480T+3VzLrS0d1h50fyBb5C28oZegz0tUkU0=;
 b=to74WkefGnrAhzk+4faAcY5lH6grhriUisTIb2sZjA905bez0nG0Kgwhe6cKHanOko
 k6ZZ3SgjdUAVp4ixwXbz3xOBXJx9OQ+TYKBnrPjUFtZybo8jFlNwR4/YNs6rtPxAzTNb
 6iAdhmAf+iSQLYly4CL1+QKYSr9V5lm3xJlx8RgcNI4gKnO1+EOq4ebZ4GfMXkszX69L
 En2vruQ6wm69r0BkR/B5IFSJUD5vS+DuBNs4mb7Yz5Uj72KOvE7DyUfDmVB3C8u4CrHx
 zav2BJDAJp7HXdR4CfenPJA3zU7JqEgX5Vq7pAyU+NEj3mCAjGzs3OMAdaYD6oWFBXdO
 gOdw==
X-Gm-Message-State: AOJu0YwfYvA20atV+XKciqkl1F2IUPz7PVPIkIb5Pha+217rYhZEhymR
 XWO2eF7qQzQ1DWwtAESNIt2vri7pdX00f6mJyo7ELfGLdxfm6y2khn8adLvDHnyzf0BGIu6+Qbg
 gCXSkwbJcbhJinoS9YWf88qpRlmcC2GKk/dRvFe34azgvjveEo0kNNhT1882e5grDd5oa/xcOYS
 SYghtUZssmA7oumU4MqfBRYAyncA0OJoV9QKISwzo=
X-Gm-Gg: ASbGncuZOKFgbVT5Dwi7Ukn0GmT5tRF8kTOD4BfdlsoQ7dFp5MRVx+u1mwL0D8qquNC
 CJGnz6IaZ86zZ0+zcq4ryG+lnYk7FXwn4PY25pq9x9wt06ZGg5ouNaSt9pGzJMj594gjxGI7jKt
 ukmZxE5cL12EgfNUczRAhfUa0QmwbZG0BYMROh4prfoRMsPXDep+pQVkXooJ7sSNacO5XJ/G/rV
 rXVqAY/UDMoSyU4tM0zYpukAhMxW6UifJWHA0UiXPck/xSGo/j4iJnKVZo=
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-38a221f1716mr36518152f8f.21.1735604637082; 
 Mon, 30 Dec 2024 16:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvXzYyJWX8Fb3jJHzeylhs2LlThMR/Quu3QQyaP/zVm3en/VGZA1Gz5ARRS6Xt7WnVXVZZuA==
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-38a221f1716mr36518138f8f.21.1735604636667; 
 Mon, 30 Dec 2024 16:23:56 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a08sm373893925e9.25.2024.12.30.16.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 7/9] rust: qemu_api: add vmstate_struct and vmstate_cell
Date: Tue, 31 Dec 2024 01:23:34 +0100
Message-ID: <20241231002336.25931-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These are not type safe, but they're the best that can be done without
const_refs_static.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b59a4b66339..e45c93587b2 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -610,6 +610,40 @@ macro_rules! vmstate_array_of_pointer_to_struct {
     }};
 }
 
+// FIXME: including the `vmsd` field in a `const` is not possible without
+// the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
+// it is not possible to use VMS_STRUCT in a transparent manner using
+// `vmstate_of!`.  While VMSTATE_CLOCK can at least try to be type-safe,
+// VMSTATE_STRUCT includes $type only for documentation purposes; it
+// is checked against $field_name and $struct_name, but not against $vmsd
+// which is what really would matter.
+#[doc(alias = "VMSTATE_STRUCT")]
+#[macro_export]
+macro_rules! vmstate_struct {
+    ($field_name:ident, $struct_name:ty, $vmsd:expr, $type:ty) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            offset: {
+                $crate::assert_field_type!($struct_name, $field_name, $type);
+                $crate::offset_of!($struct_name, $field_name)
+            }
+            size: ::core::mem::size_of::<$type>(),
+            flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+            vmsd: unsafe { $vmsd },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    }};
+}
+
+#[macro_export]
+macro_rules! vmstate_cell {
+    ($field_name:ident, $struct_name:ty, $vmsd:expr, $type:ty) => {
+        $crate::vmstate_struct!($field_name, $struct_name, $vmsd, $type)
+    };
+}
+
 #[doc(alias = "VMSTATE_CLOCK_V")]
 #[macro_export]
 macro_rules! vmstate_clock_v {
-- 
2.47.1


