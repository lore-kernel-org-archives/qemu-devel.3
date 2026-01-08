Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E621FD185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnF-0007bL-2k; Thu, 08 Jan 2026 08:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnC-0007aI-LU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn9-0007zz-1T
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXUBvQcaMsRwI/b+BszJt6nG9jA/4L5XWgG62HdNUNU=;
 b=bFFVQf6afoshEiar3hyvTrhGmGoCb333hrFrpYOuiHdkqh2capLzyRdqdOIjDJ4f3fHKYx
 jCTPUuZhJ4ID9l3T4aUEzOtUTHdr2HLIIMVu2gP4/rwqwz+1TjYCPEKaxZ6Kvhplszga0n
 L4Lsa41lQxgW5YCCnbS3QUiLA95+V4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-54cSPiGTMjmCCos_NXjlbg-1; Thu, 08 Jan 2026 08:11:05 -0500
X-MC-Unique: 54cSPiGTMjmCCos_NXjlbg-1
X-Mimecast-MFC-AGG-ID: 54cSPiGTMjmCCos_NXjlbg_1767877864
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so1698356f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877863; x=1768482663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXUBvQcaMsRwI/b+BszJt6nG9jA/4L5XWgG62HdNUNU=;
 b=l3VKIsKPQmbLUcXFuvrYvnVM9e66gZcyT9irp7geYxTgKayjiJN/M8ILiyCW3zz3et
 sfGu/7jdfgbpbF/ID4htaTzm5YLugeg72AqW3z2NJnzFQ693wlyrkkx0Ggc9+zPFWtSE
 59yUc6vmDoPIQKwgjoE0OG6GN1ra8NyJ+fF43D4elLlM8Pru3sDwX6PFSFZhJIMjzuQX
 ehMHdg3NNPb5XgjaN018ZywmDRRLwpy4hhjGKXwEs3nYHinxqnBETcDUILxBS3yL2b4L
 xv57xUgEjcRvBKlxo5N+9smvyDQ+NZ5/FEdaEf3MhlUccR3d+hPRXUs5Ccaw7X4IAkAw
 CjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877863; x=1768482663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IXUBvQcaMsRwI/b+BszJt6nG9jA/4L5XWgG62HdNUNU=;
 b=jeUxM7s93pOfPO1Id1Bnr07dqO+xMZe6XTze5KVhpR9Uo8gbsMTNe8Iw/enk5Xpyos
 CBXN9vr/UeNmkXfeyKqU1f4pjHdJ/BnnT+9fiIyh2KuhIWwNzHieXr4/aM7omnlT6Myd
 iTJlZ/yW/yv3Vskcu5CHC47ERK0e5S9p2YWA8UmjLQHYReifMCw4mW8xW8hLWtasctHA
 HVwHqo/Fj3J2VF1e6f9T1JiPlmPbSZvRXkhgZi80+PszPsiUnEjqF2PrR22Er8+vLX02
 xDC2CLgGk4+F3x51sH/F7B4C9JKxEm4lCfVoMZawjGPHjqb8zp1FQiy+S7S9iJCJmT9s
 B1uw==
X-Gm-Message-State: AOJu0YypZzSrCm8cW9jvHYkR4aLsNnEwexvk4ZJ2fZu55GhcqZFTGgoO
 seg8e0bpNwbgpV/oInsA9hqwkM+jllB8lvxpCSUun2My445PlkOyyCVW2F2SQawcXg9f81xbz3c
 GuqjD9R0R9OW17of50DZ4kd3icpY+p8RvYlnnDd7NdhdvW3cJynQerxlhKZmaDH86OSyY7ZX1LM
 ofolOxSW+acrWCgA5VBIsrQi90Y0Ipskz3XOiS0sbK
X-Gm-Gg: AY/fxX7/qaJqItoWERJ7FEzQ1lhnpWSMkYj6ZWhP2Gp7mowOWO5hQesFbd8XGSHrn9a
 eiGx8CBySddCA2eG/PDfT1NW3LfN5NnpdznChvQcGXQglUXfyuVsbd/yhFkmZjLzgfbrAzY57VI
 675yVWl7o1nmuZQoJUXH0a1/UwY12dflFxTTVrTHmtvMJ7G+Ip2P/I/sngaFncuRI4+HZwSKsaN
 IvXpl4bT7GWIaDVi9ufpV0ssg4qBPgOvoflZqDEgV2BrJ465/rz+XI1y8O6Cu/8orWu6eEHYDHt
 yYGhOc4OwfCQ8KjU9QRsjO/WPn/M6ycvEEdrP3O+js3zSwtbwB2wqbSvsPITsiNva7A1guWD0Sx
 E7UmbV+m1NtfrXpZSDS3sYjCdaXS/p6kC0k5H3dsTo7+yoGEKcR5GJJS3o3AzxwUp8aaxXTphJ2
 vAFkFr15HXHgo6AA==
X-Received: by 2002:a05:6000:240f:b0:431:864:d4a9 with SMTP id
 ffacd0b85a97d-432c3772035mr6376945f8f.8.1767877862939; 
 Thu, 08 Jan 2026 05:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMG9a3naAy2kMCjipFCfNO9dOnznFl+BkKm3U0MQO1tS54K1Cs53sXUMyf9MSr/updpapoLA==
X-Received: by 2002:a05:6000:240f:b0:431:864:d4a9 with SMTP id
 ffacd0b85a97d-432c3772035mr6376911f8f.8.1767877862360; 
 Thu, 08 Jan 2026 05:11:02 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm16250175f8f.36.2026.01.08.05.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 06/16] rust/qobject: add Deserializer (from_qobject)
 implementation
Date: Thu,  8 Jan 2026 14:10:33 +0100
Message-ID: <20260108131043.490084-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows creating any serializable data structure from QObject.
The purpose of all the code is to typecheck each variant in the
serde data model and check that it's one of the corresponding
QObject data types.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                   |   1 +
 rust/util/meson.build                 |   1 +
 rust/util/src/qobject/deserializer.rs | 371 ++++++++++++++++++++++++++
 rust/util/src/qobject/error.rs        |   8 +-
 rust/util/src/qobject/mod.rs          |   2 +
 5 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 rust/util/src/qobject/deserializer.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 79c26d9d165..c7f3a496a25 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -162,6 +162,7 @@ module                     status
 ``util::error``            stable
 ``util::log``              proof of concept
 ``util::module``           complete
+``util::qobject``          stable
 ``util::timer``            stable
 ========================== ======================
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 4621932fdcb..92d27957eda 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -40,6 +40,7 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/deserializer.rs',
       'src/qobject/deserialize.rs',
       'src/qobject/error.rs',
       'src/qobject/serializer.rs',
diff --git a/rust/util/src/qobject/deserializer.rs b/rust/util/src/qobject/deserializer.rs
new file mode 100644
index 00000000000..b0f8aa23773
--- /dev/null
+++ b/rust/util/src/qobject/deserializer.rs
@@ -0,0 +1,371 @@
+//! `QObject` deserializer
+//!
+//! This module implements a [`Deserializer`](serde::de::Deserializer) that
+//! consumes `QObject`s, allowing them to be turned into deserializable data
+//! structures (such as primitive data types, or structs that implement
+//! `Deserialize`).
+
+use std::ffi::CStr;
+
+use serde::de::{
+    self, value::StrDeserializer, DeserializeSeed, Expected, IntoDeserializer, MapAccess,
+    SeqAccess, Unexpected, Visitor,
+};
+
+use super::{
+    error::{Error, Result},
+    match_qobject, QObject,
+};
+use crate::bindings;
+
+impl QObject {
+    #[cold]
+    fn invalid_type<E>(&self, exp: &dyn Expected) -> E
+    where
+        E: serde::de::Error,
+    {
+        serde::de::Error::invalid_type(self.unexpected(), exp)
+    }
+
+    #[cold]
+    fn unexpected(&self) -> Unexpected<'_> {
+        match_qobject! { (self) =>
+            () => Unexpected::Unit,
+            bool(b) => Unexpected::Bool(b),
+            i64(n) => Unexpected::Signed(n),
+            u64(n) => Unexpected::Unsigned(n),
+            f64(n) => Unexpected::Float(n),
+            CStr(s) => s.to_str().map_or_else(
+                |_| Unexpected::Other("string with invalid UTF-8"),
+                Unexpected::Str),
+            QList(_) => Unexpected::Seq,
+            QDict(_) => Unexpected::Map,
+        }
+    }
+}
+
+fn visit_qlist_ref<'de, V>(qlist: &'de bindings::QList, visitor: V) -> Result<V::Value>
+where
+    V: Visitor<'de>,
+{
+    struct QListDeserializer(*mut bindings::QListEntry, usize);
+
+    impl<'de> SeqAccess<'de> for QListDeserializer {
+        type Error = Error;
+
+        fn next_element_seed<T>(&mut self, seed: T) -> Result<Option<T::Value>>
+        where
+            T: DeserializeSeed<'de>,
+        {
+            if self.0.is_null() {
+                return Ok(None);
+            }
+
+            let e = unsafe { &*self.0 };
+            // increment the reference count because deserialize consumes `value`.
+            let value = unsafe { QObject::cloned_from_raw(e.value.cast_const()) };
+            let result = seed.deserialize(value);
+            self.0 = unsafe { e.next.tqe_next };
+            self.1 += 1;
+            result.map(Some)
+        }
+    }
+
+    let mut deserializer = QListDeserializer(unsafe { qlist.head.tqh_first }, 0);
+    let seq = visitor.visit_seq(&mut deserializer)?;
+    if deserializer.0.is_null() {
+        Ok(seq)
+    } else {
+        Err(serde::de::Error::invalid_length(
+            deserializer.1,
+            &"fewer elements in array",
+        ))
+    }
+}
+
+fn visit_qdict_ref<'de, V>(qdict: &'de bindings::QDict, visitor: V) -> Result<V::Value>
+where
+    V: Visitor<'de>,
+{
+    struct QDictDeserializer(*mut bindings::QDict, *const bindings::QDictEntry);
+
+    impl<'de> MapAccess<'de> for QDictDeserializer {
+        type Error = Error;
+
+        fn next_key_seed<T>(&mut self, seed: T) -> Result<Option<T::Value>>
+        where
+            T: DeserializeSeed<'de>,
+        {
+            if self.1.is_null() {
+                return Ok(None);
+            }
+
+            let e = unsafe { &*self.1 };
+            let key = unsafe { CStr::from_ptr(e.key) };
+            let key_de = StrDeserializer::new(key.to_str()?);
+            seed.deserialize(key_de).map(Some)
+        }
+
+        fn next_value_seed<T>(&mut self, seed: T) -> Result<T::Value>
+        where
+            T: DeserializeSeed<'de>,
+        {
+            if self.1.is_null() {
+                panic!("next_key must have returned None");
+            }
+
+            let e = unsafe { &*self.1 };
+            // increment the reference count because deserialize consumes `value`.
+            let value = unsafe { QObject::cloned_from_raw(e.value) };
+            let result = seed.deserialize(value);
+            self.1 = unsafe { bindings::qdict_next(self.0, self.1) };
+            result
+        }
+    }
+
+    let qdict = (qdict as *const bindings::QDict).cast_mut();
+    let e = unsafe { bindings::qdict_first(qdict) };
+    let mut deserializer = QDictDeserializer(qdict, e);
+    let map = visitor.visit_map(&mut deserializer)?;
+    if deserializer.1.is_null() {
+        Ok(map)
+    } else {
+        Err(serde::de::Error::invalid_length(
+            unsafe { bindings::qdict_size(qdict) },
+            &"fewer elements in map",
+        ))
+    }
+}
+
+fn visit_qnum_ref<'de, V>(qnum: QObject, visitor: V) -> Result<V::Value>
+where
+    V: Visitor<'de>,
+{
+    match_qobject! { (qnum) =>
+        i64(n) => visitor.visit_i64(n),
+        u64(n) => visitor.visit_u64(n),
+        f64(n) => visitor.visit_f64(n),
+        _ => Err(qnum.invalid_type(&"number")),
+    }
+}
+
+macro_rules! deserialize_number {
+    ($method:ident) => {
+        fn $method<V>(self, visitor: V) -> Result<V::Value>
+        where
+            V: Visitor<'de>,
+        {
+            visit_qnum_ref(self, visitor)
+        }
+    };
+}
+
+impl<'de> serde::Deserializer<'de> for QObject {
+    type Error = Error;
+
+    fn deserialize_any<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            () => visitor.visit_unit(),
+            bool(v) => visitor.visit_bool(v),
+            i64(n) => visitor.visit_i64(n),
+            u64(n) => visitor.visit_u64(n),
+            f64(n) => visitor.visit_f64(n),
+            CStr(cstr) => visitor.visit_str(cstr.to_str()?),
+            QList(qlist) => visit_qlist_ref(qlist, visitor),
+            QDict(qdict) => visit_qdict_ref(qdict, visitor),
+        }
+    }
+
+    deserialize_number!(deserialize_i8);
+    deserialize_number!(deserialize_i16);
+    deserialize_number!(deserialize_i32);
+    deserialize_number!(deserialize_i64);
+    deserialize_number!(deserialize_i128);
+    deserialize_number!(deserialize_u8);
+    deserialize_number!(deserialize_u16);
+    deserialize_number!(deserialize_u32);
+    deserialize_number!(deserialize_u64);
+    deserialize_number!(deserialize_u128);
+    deserialize_number!(deserialize_f32);
+    deserialize_number!(deserialize_f64);
+
+    fn deserialize_option<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            () => visitor.visit_none(),
+            _ => visitor.visit_some(self),
+        }
+    }
+
+    fn deserialize_enum<V>(
+        self,
+        _name: &'static str,
+        _variants: &'static [&'static str],
+        visitor: V,
+    ) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            CStr(cstr) => visitor.visit_enum(cstr.to_str()?.into_deserializer()),
+            _ => Err(self.invalid_type(&"string")),
+        }
+    }
+
+    fn deserialize_newtype_struct<V>(self, _name: &'static str, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        visitor.visit_newtype_struct(self)
+    }
+
+    fn deserialize_bool<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            bool(v) => visitor.visit_bool(v),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_char<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_str(visitor)
+    }
+
+    fn deserialize_str<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            CStr(cstr) => visitor.visit_str(cstr.to_str()?),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_string<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_str(visitor)
+    }
+
+    fn deserialize_bytes<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            CStr(cstr) => visitor.visit_str(cstr.to_str()?),
+            QList(qlist) => visit_qlist_ref(qlist, visitor),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_byte_buf<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_bytes(visitor)
+    }
+
+    fn deserialize_unit<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            () => visitor.visit_unit(),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_unit_struct<V>(self, _name: &'static str, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_unit(visitor)
+    }
+
+    fn deserialize_seq<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            QList(qlist) => visit_qlist_ref(qlist, visitor),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_tuple<V>(self, _len: usize, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_seq(visitor)
+    }
+
+    fn deserialize_tuple_struct<V>(
+        self,
+        _name: &'static str,
+        _len: usize,
+        visitor: V,
+    ) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_seq(visitor)
+    }
+
+    fn deserialize_map<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            QDict(qdict) => visit_qdict_ref(qdict, visitor),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_struct<V>(
+        self,
+        _name: &'static str,
+        _fields: &'static [&'static str],
+        visitor: V,
+    ) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        match_qobject! { (self) =>
+            QList(qlist) => visit_qlist_ref(qlist, visitor),
+            QDict(qdict) => visit_qdict_ref(qdict, visitor),
+            _ => Err(self.invalid_type(&visitor)),
+        }
+    }
+
+    fn deserialize_identifier<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        self.deserialize_str(visitor)
+    }
+
+    fn deserialize_ignored_any<V>(self, visitor: V) -> Result<V::Value>
+    where
+        V: Visitor<'de>,
+    {
+        visitor.visit_unit()
+    }
+}
+
+pub fn from_qobject<T>(value: QObject) -> Result<T>
+where
+    T: de::DeserializeOwned,
+{
+    T::deserialize(value)
+}
diff --git a/rust/util/src/qobject/error.rs b/rust/util/src/qobject/error.rs
index 5212e65c4f7..2d7c180187a 100644
--- a/rust/util/src/qobject/error.rs
+++ b/rust/util/src/qobject/error.rs
@@ -6,7 +6,7 @@
     str::Utf8Error,
 };
 
-use serde::ser;
+use serde::{de, ser};
 
 #[derive(Debug)]
 pub enum Error {
@@ -23,6 +23,12 @@ fn custom<T: Display>(msg: T) -> Self {
     }
 }
 
+impl de::Error for Error {
+    fn custom<T: Display>(msg: T) -> Self {
+        Error::Custom(msg.to_string())
+    }
+}
+
 impl From<NulError> for Error {
     fn from(_: NulError) -> Self {
         Error::NulEncountered
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index c0c16f28049..b95dddddedc 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -7,6 +7,7 @@
 #![deny(clippy::unwrap_used)]
 
 mod deserialize;
+mod deserializer;
 mod error;
 mod serialize;
 mod serializer;
@@ -20,6 +21,7 @@
 };
 
 use common::assert_field_type;
+pub use deserializer::from_qobject;
 pub use error::{Error, Result};
 pub use serializer::to_qobject;
 
-- 
2.52.0


