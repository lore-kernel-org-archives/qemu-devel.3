Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF702CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Elr-00009n-1Z; Fri, 10 Oct 2025 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Ell-00007q-Ci
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElR-00047p-CW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXiTTUbNHDbzCZW92MIQx4Ti2Mz3wQylh/TTI5lqmoM=;
 b=HspXSoKizhwcpUbbOxBh/dHvSBRdGzbGK2BkhFSH24tRzg33dl0Y+kmdLFiV7G3rl2M9jf
 n8c0T8b+cVnnbnuyKXfBeiwi2/LNI2rz79lfkRi4V0ndDqB49iIJYHCpkRhq31QQdHw57Q
 kW57rgIuy7eoCjC/p07VArBDCSKU6lY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ChmhUmekM5qdlUFwRh93eg-1; Fri, 10 Oct 2025 11:10:32 -0400
X-MC-Unique: ChmhUmekM5qdlUFwRh93eg-1
X-Mimecast-MFC-AGG-ID: ChmhUmekM5qdlUFwRh93eg_1760109032
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so179533066b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109031; x=1760713831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXiTTUbNHDbzCZW92MIQx4Ti2Mz3wQylh/TTI5lqmoM=;
 b=NlIjhJM5qvUqa53A5ahaEgQsBkGqS8Unv49Vs6pJvEF6W/aqJWwrQLF8gjvCrRml4o
 8hatMCbmJBGjgdGHffuqYzETfUx/nguftKcac82Sd4Gf1DYv1oYsPvks9Qx6t5zyf8c8
 NkFeVc1XcVe/l+gNlB38ynULMw5rZKugfGGsRvsulDsZBeFnEzT0OHiXJgERw2tpsA2R
 aWu9OekGrkReC56BicWtsKRkLZPYOUBviS5+t9BnBjqoLj0gzkRpAe71j/yoFQRVr3uj
 iKM8ZUZHFlGWfzZ5orLHcZPt0a6IWBB/xxKvTI7A5xg8bInhp1mqu/1nQ4KQS7xYhqBV
 7t2A==
X-Gm-Message-State: AOJu0YxEZohtHSvbwLb73Onvfy0niamovbBdFgUvuV/Qscrv4ZqqB6Li
 QGOedpjnB+av9bKxPFAmKUzzMdDetLnfaDpA19JAt/SAONlbR5QEvfeLFMzIeT4AooRzaMOKy6X
 glj6QPaH4JYay9zKyoMGYfApgjsyKWndKo7xeJXRT6BQ/0XtkrK4dvT+80u+pYLM+UhsvwiKV4s
 3UbQdR7WefBddfrZOdGMOPh0NRV0pRSu4RQTEQD648
X-Gm-Gg: ASbGncuYg/0JgtzWYVa/XzTEVXXM0KZusX5nMzFa9/CsvII3qBuuO5d7hqM13cR/lDf
 8AWjxFb6k5iGxIIh2V5aXCUKFvC8AsAdYaNWZvZEhwJbbbzqXF/vmGNzE4Omc4CpNaF//ybo0EZ
 5Sou1kc90B7RdxRQ2y8GCN6FK3xiuZJ/rYXmoMY0tPWcorr0whMo0hEY90g8kqQS4J0Xb07YbZL
 O7AWkZHmP5LrR2Q7li6JNZ0U71DFYdDYHAr0jMRi/nVHXEA8uSRmGMpLHSaRcKV19tDbZ9zTonT
 2OniWwI/46aAbciUN3Doi3N1mMA+01L1PGecJINQBzaQkA0kTp+b6fKO19AhMq5Obu3xRhuuiVk
 sllCjQke6RyXjo0Z3NcbXZESryDiEGBYcGbsm1WxqrtFV
X-Received: by 2002:a17:906:c10f:b0:b3c:f0a4:b324 with SMTP id
 a640c23a62f3a-b50aaa9fe39mr1191002066b.21.1760109030626; 
 Fri, 10 Oct 2025 08:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaT6YihrPLKX768RhgQzNMhDp+ObmC/dt7GsizT9K8qPSVfMTMpLjiAuWRXiQePn/74olbCA==
X-Received: by 2002:a17:906:c10f:b0:b3c:f0a4:b324 with SMTP id
 a640c23a62f3a-b50aaa9fe39mr1190998766b.21.1760109030103; 
 Fri, 10 Oct 2025 08:10:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12a62sm257055966b.58.2025.10.10.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 09/19] rust/qobject: add Deserializer (from_qobject)
 implementation
Date: Fri, 10 Oct 2025 17:09:54 +0200
Message-ID: <20251010151006.791038-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This allows creating any serializable data structure from QObject.
The purpose of all the code is to typecheck each variant in the
serde data model and check that it's one of the corresponding
QObject data types.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 2f0ab2e2821..3aadfb78dfd 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -161,6 +161,7 @@ module                     status
 ``util::error``            stable
 ``util::log``              proof of concept
 ``util::module``           complete
+``util::qobject``          stable
 ``util::timer``            stable
 ========================== ======================
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 9f8fbd49f00..aff14a41589 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,6 +39,7 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/deserializer.rs',
       'src/qobject/deserialize.rs',
       'src/qobject/error.rs',
       'src/qobject/serializer.rs',
diff --git a/rust/util/src/qobject/deserializer.rs b/rust/util/src/qobject/deserializer.rs
new file mode 100644
index 00000000000..84a03bd9f1b
--- /dev/null
+++ b/rust/util/src/qobject/deserializer.rs
@@ -0,0 +1,371 @@
+//! `QObject` deserializer
+//!
+//! This module implements a [`Deserializer`](serde::de::Deserializer) that
+//! produces `QObject`s, allowing them to be turned into deserializable data
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
index 80c496b8a63..e896aba5f3a 100644
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
2.51.0


