Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34274CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw15-0001vy-QM; Tue, 26 May 2026 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw14-0001v2-Hx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw12-0007tC-FZ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5gaXZibmaGnGSJRfn9tMHw3pmY7HTP0M2qgx9cB7eU=;
 b=BS+JKKoRu2FkvMs25IRSqdzjb9Y+VWvMZ4gEVTe7lH7FYPv1Q71Ttx5D+mlRwyFzeL6h6h
 yLEjWWAKmIvQx4UAazjoNJ0FVSn/ZJh6ZgCNn3iFp2boWCZOpXCnOEqlNv/iWmF5lczi5o
 A7kN8pZTK1yNmNi5dPumm56isylmbIM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-GGl1wmx4M5mIxTHJWY2fgw-1; Tue, 26 May 2026 13:56:30 -0400
X-MC-Unique: GGl1wmx4M5mIxTHJWY2fgw-1
X-Mimecast-MFC-AGG-ID: GGl1wmx4M5mIxTHJWY2fgw_1779818189
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44d79da8cf7so8146666f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818189; x=1780422989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5gaXZibmaGnGSJRfn9tMHw3pmY7HTP0M2qgx9cB7eU=;
 b=VD8AM1ic86cskyZGngBqwcfuZPc3ahghxD/hVuPL+UyBiKug7szESCyjs9+kNNy3Mq
 3+jDIPtt36v48w6O7vTeeSkM+fL6ERrvfrg3pyL88KN7gvx84cWbJqjjZgNRpfmnAKiY
 MVS6HGnrD3V7pJ1EB/93HLoregnmoRvHfAIZ+Og5WbVjyLrD0XG77YN8D3J3fujeU3Ap
 lSREFyhIBbYie+9TphVa/+jUb9XuMp4QJLBBaujYb0Uq+nuj7eYo74tvjWLAaJWeFxps
 NWieUpiNFPDJBizacaqf51LqxmqD67tUQY/q6gXCgxPFlLWHDCHIBqF13hQaLPO6wBUM
 pNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818189; x=1780422989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5gaXZibmaGnGSJRfn9tMHw3pmY7HTP0M2qgx9cB7eU=;
 b=nOsrx6jvyJtxQEgvgtIwIGPz31WiFeyhYOJAvt3OJ73DynsGQGz7BPOibG2euIwdxa
 zcDF8Xm8iYwZ5wcUHljsP+J7fbv+H60QQKIIx/r7r2mO870/fwklpX6emP0xQJQjHKU3
 oVAlkVYf+tBakwA6+ZGZbAl3FOmmTsAQQPxJCmalbfrIJoVSSyqAlYqhkpsQaCUjb4S2
 GOomUMnmIZ5R+DaZiVKkPOl+DBKfjo6WIQA3J+VYW2K4Aq8UTfwwwqobHP+PFrsoDFx0
 7o/VKgvB1VkZFOmFBKoyvxwn2Q3ubWg7o3ag3fWi/ncI+spHAEpqtMmJ6XnunKvNz0YS
 nbrA==
X-Gm-Message-State: AOJu0YzCg9snVSyK2SjuXH/vw2VP86UFV0QqZKRJFZzwHKL3XMaau9yQ
 I9ZGOw36/27AFMtAsimAG1zYTe18lcnIX406i0o4YeTx3bSPzzbvuUxk08Xt5RbI/YoEeulJiBy
 qBgSBhTNjZ4j6Fm6UMAQh0OyNwWT04Hl2/JcMeFBEMzJ4FpkpuUpTOq4Co8a1ZOKUmgLj4Ms5Zu
 jpcokd2OWcB2gVkdLthFqASla/JnRG+JyAaBI443My
X-Gm-Gg: Acq92OGeVLrNjM8tY26p698bSQJkUPSGHy7d/yD3vILK9NTLk4VYBjT+VzlN5rKqpvp
 MlfAFZy5huGHF+tNc0AkAqki31XP/gC56Lf9gS9GuQ/0TLstXQKCRHS5ySXIilTmExkEDfS7a2F
 xZ68FPexUGdmfVVHB6JeG/mcq+tBn2WrbkF6LzrKzgq8K+6bPkcWbbuiI6HCWrhSt49+quM1oCx
 du+bsKPDCUqIMf8w50XBbkvyU/c8KsHOs4OIX6cD24Zyh+78+OkygWByvI+zK7uOJObD/ZOfpHT
 ICX2BB9ukBJ5aXmGT1NdPxmbYh+U5UWhS9nWIHiy7vZcpILazCPfruSu1ZfJSiFbYlClg1KfaLo
 ZDlJzuTYTxd7MA27fdzABxPtX5ssykF2i/rr81y2WDbRV50AiBaLVCdZz9aLauFFNeTFOLd2Quf
 +sgUwq4BqxcNvirUuYjnFiq/7DZA4=
X-Received: by 2002:a05:6000:1884:b0:45e:da62:7a03 with SMTP id
 ffacd0b85a97d-45eda627a5fmr2701545f8f.15.1779818189035; 
 Tue, 26 May 2026 10:56:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1884:b0:45e:da62:7a03 with SMTP id
 ffacd0b85a97d-45eda627a5fmr2701493f8f.15.1779818188523; 
 Tue, 26 May 2026 10:56:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d493dfsm38428882f8f.23.2026.05.26.10.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 03/19] rust/qobject: add Serialize implementation
Date: Tue, 26 May 2026 19:56:02 +0200
Message-ID: <20260526175618.227743-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This allows QObject to be converted to other formats, for example
JSON via serde_json.

This is not too useful, since QObjects are consumed by
C code or deserialized into structs, but it can be used for testing
and it is part of the full implementation of a serde format.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                    |  1 +
 rust/util/Cargo.toml               |  1 +
 rust/util/meson.build              |  2 +-
 rust/util/src/qobject/mod.rs       |  4 +--
 rust/util/src/qobject/serialize.rs | 57 ++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 rust/util/src/qobject/serialize.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index cbb3ca15f77..b9e8636b8bc 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -513,6 +513,7 @@ dependencies = [
  "foreign",
  "glib-sys",
  "libc",
+ "serde",
  "util-sys",
 ]
 
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 2ad5940daca..0a0400278f3 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,6 +17,7 @@ anyhow = { workspace = true }
 foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
+serde = { workspace = true }
 common = { path = "../common" }
 util-sys = { path = "../bindings/util-sys" }
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 6d175ae0b0f..a8d9978e1a9 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -1,7 +1,7 @@
 _util_rs = static_library(
   'util',
   'src/lib.rs',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, util_sys_rs],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, serde_rs, util_sys_rs],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 210078ea23e..c42b75f3199 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,6 +6,8 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod serialize;
+
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -246,7 +248,6 @@ fn drop(&mut self) {
     }
 }
 
-#[allow(unused)]
 macro_rules! match_qobject {
     (@internal ($qobj:expr) =>
         $(() => $unit:expr,)?
@@ -329,5 +330,4 @@ macro_rules! match_qobject {
                 $($type $(($val))? => $code,)+)
     };
 }
-#[allow(unused_imports)]
 use match_qobject;
diff --git a/rust/util/src/qobject/serialize.rs b/rust/util/src/qobject/serialize.rs
new file mode 100644
index 00000000000..97250602cc3
--- /dev/null
+++ b/rust/util/src/qobject/serialize.rs
@@ -0,0 +1,57 @@
+//! `QObject` serialization
+//!
+//! This module implements the [`Serialize`] trait for `QObject`,
+//! allowing it to be converted to other formats, for example
+//! JSON.
+
+use std::{ffi::CStr, mem::ManuallyDrop, ptr::addr_of};
+
+use serde::ser::{self, Serialize, SerializeMap, SerializeSeq};
+
+use super::{match_qobject, QObject};
+use crate::bindings;
+
+impl Serialize for QObject {
+    #[inline]
+    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
+    where
+        S: ::serde::Serializer,
+    {
+        match_qobject! { (self) =>
+            () => serializer.serialize_unit(),
+            bool(b) => serializer.serialize_bool(b),
+            i64(i) => serializer.serialize_i64(i),
+            u64(u) => serializer.serialize_u64(u),
+            f64(f) => serializer.serialize_f64(f),
+            CStr(cstr) => {
+                let s = cstr.to_str().map_err(ser::Error::custom)?;
+                serializer.serialize_str(s)
+            },
+            QList(l) => {
+                let mut node_ptr = unsafe { l.head.tqh_first };
+                let mut state = serializer.serialize_seq(None)?;
+                while !node_ptr.is_null() {
+                    let node = unsafe { &*node_ptr };
+                    let elem = unsafe { ManuallyDrop::new(QObject::from_raw(addr_of!(*node.value))) };
+                    state.serialize_element(&*elem)?;
+                    node_ptr = unsafe { node.next.tqe_next };
+                }
+                state.end()
+            },
+            QDict(d) => {
+                let mut state = serializer.serialize_map(Some(d.size))?;
+                let mut e_ptr = unsafe { bindings::qdict_first(d) };
+                while !e_ptr.is_null() {
+                    let e = unsafe { &*e_ptr };
+                    let key = unsafe { CStr::from_ptr(e.key) };
+                    let key = key.to_str().map_err(ser::Error::custom)?;
+                    state.serialize_key(key)?;
+                    let value = unsafe { ManuallyDrop::new(QObject::from_raw(addr_of!(*e.value))) };
+                    state.serialize_value(&*value)?;
+                    e_ptr = unsafe { bindings::qdict_next(d, e) };
+                }
+                state.end()
+            }
+        }
+    }
+}
-- 
2.54.0


