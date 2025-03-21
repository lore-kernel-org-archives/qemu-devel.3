Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E0C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEC-0001Sp-Ah; Fri, 21 Mar 2025 14:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE9-0001Hr-Nh
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE8-00070x-53
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIoCzGEOqHsM41xIt3EuiCgJLmJ6D9tPJwGLj7vy+Rg=;
 b=ivY4V0b+xaZn//QzcNzqelEPlkaxgFWMpFA71zlUSMMWVLXTGBkxhACjYkdLRYQReGQJqG
 WDj7NAZOBqgqmfVYDVsDdYwzTlh2usD82CUW6obQNYAbWSQxFoVOtJQ5a/Af85JAbOfDKx
 VBAfm1KNIXnwbasqYoDPF6uDVRocHuA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-iM4EgZevOOmWYwNLcjehKw-1; Fri, 21 Mar 2025 14:36:14 -0400
X-MC-Unique: iM4EgZevOOmWYwNLcjehKw-1
X-Mimecast-MFC-AGG-ID: iM4EgZevOOmWYwNLcjehKw_1742582173
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e5edf8a509so1862762a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582172; x=1743186972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIoCzGEOqHsM41xIt3EuiCgJLmJ6D9tPJwGLj7vy+Rg=;
 b=g4WhWdcNd1PEc37BqHw0eCjcZCIxg0JloAthyCT8WcLuDFt/SBcOsZLsgohQxq5mkd
 cnq+FPGNAd6dT/ZcFJLfEPH2TahTfyq8vWQRVCdET47JRIUJWWFV4LmOKWlfJXezdWh2
 cZ7OnFCwmOlbhmWucxr50b+v6nCXF50Ma6vKd5dhg1+VfVa7saH97b8ktKIC+8aS/vkB
 a7SBn6lJ7oAtDk+ZPTszOG/rfRmNegvvZxvZW+8Ft2nsrsjUNPJCqG5sIuWDRN7zluHm
 u6MjKpa1sMfxeRteq/AmOZC9/cTfOAuhvG7xMNfRIJgHpjeXHwJCB4GyNWxauxB+6WKd
 5opg==
X-Gm-Message-State: AOJu0YzjvkKHZydPHD28qzrPe/yw92dkmHcT5FM7mczND/GAHLeh+/tv
 dx6WdnRZQg1oa1bSpaTLPv/90E1Jo5MmVWQQFjASbE+hMfwelCs6U8Io+GOFeur+/oxZQBHowsT
 Nul2LFFjv5r+1XMyp/MoRKPstakFkanSxmTpI1tprsMi5PyVOL+vQxwVWQTTfpH5/xNVKwdScmV
 YrbIwH3z9Ml+UQFbBXs7j6HUxZUdU9XqfaoLjO
X-Gm-Gg: ASbGncvlmoFl+dhek/l7yUd64CNjULjK+8LV9PSFaGNJWTEI/JnVBF4UGjBgZlWS8a8
 ZNzT9AQMliOc5rUPxF7LCNFTWQ4McSyoJtUApkGLOXjclnIJsu0cglEcdPuvllZpyonfdhxag0f
 gv9Z0xMABKxr+rhFfKQYXlR4zk25dA16FwNOjyNlD7CEMqr++5fO7ReiGAdnxF30FAm1SVG9deA
 aLIWpBLtgN+3XvikYlWRz+PIvqLQQ38hyTncJbmOz9Q/3qB5wMtYXLJ4Ts8DX+vuzByqj6MTMOf
 qyevzhNv3ZrHkCVhG5Mv
X-Received: by 2002:a05:6402:50c7:b0:5e6:1602:bfbb with SMTP id
 4fb4d7f45d1cf-5ebcd51c8damr3312649a12.27.1742582171990; 
 Fri, 21 Mar 2025 11:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/hWbjx27klsPWgHPxqvdRvwa1hcilhI71INluwbhCQQeIc5hQqPwb8iPNosPolzZGKdzUDA==
X-Received: by 2002:a05:6402:50c7:b0:5e6:1602:bfbb with SMTP id
 4fb4d7f45d1cf-5ebcd51c8damr3312639a12.27.1742582171408; 
 Fri, 21 Mar 2025 11:36:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebcd0dfb33sm1748586a12.68.2025.03.21.11.36.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] qdev, rust/hpet: fix type of HPET "timers" property
Date: Fri, 21 Mar 2025 19:35:35 +0100
Message-ID: <20250321183556.155097-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h   |  1 +
 hw/core/qdev-properties.c      | 37 ++++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/hpet.rs |  6 +++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 15fcec5260c..2c99856caac 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -52,6 +52,7 @@ extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
+extern const PropertyInfo qdev_prop_usize;
 extern const PropertyInfo qdev_prop_int32;
 extern const PropertyInfo qdev_prop_uint64;
 extern const PropertyInfo qdev_prop_uint64_checkmask;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c04df3b337a..147b3ffd16e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -442,6 +442,43 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
     .set   = set_uint64_checkmask,
 };
 
+/* --- pointer-size integer --- */
+
+static void get_usize(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    const Property *prop = opaque;
+
+#if HOST_LONG_BITS == 32
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    visit_type_uint32(v, name, ptr, errp);
+#else
+    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    visit_type_uint64(v, name, ptr, errp);
+#endif
+}
+
+static void set_usize(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    const Property *prop = opaque;
+
+#if HOST_LONG_BITS == 32
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    visit_type_uint32(v, name, ptr, errp);
+#else
+    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    visit_type_uint64(v, name, ptr, errp);
+#endif
+}
+
+const PropertyInfo qdev_prop_usize = {
+    .type  = "usize",
+    .get   = get_usize,
+    .set   = set_usize,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
 /* --- string --- */
 
 static void release_string(Object *obj, const char *name, void *opaque)
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 20e0afdfca8..63c1971f0b5 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_uint8,
+        qdev_prop_uint32, qdev_prop_usize,
     },
     c_str,
     cell::{BqlCell, BqlRefCell},
@@ -859,8 +859,8 @@ impl ObjectImpl for HPETState {
         c_str!("timers"),
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_uint8 },
-        u8,
+        unsafe { &qdev_prop_usize },
+        usize,
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-- 
2.49.0


