Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4646DCD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1E-000208-3u; Tue, 26 May 2026 13:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1D-0001zU-3j
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1A-0007wP-Ov
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK4ewdpRbWjBOdfd9WIfkWHhs6P79cHSH2ERgJE6mCs=;
 b=XS6GNStRUAZYIelJGQAI2tZQiw9mMTLz+7toEuGH6Sh1YPjWuX1mcVq9NS/aHRAeTt+7Ge
 X/Ts01YbxSx5dusCiE+b+z4VV8NmkSU5GT0uV02eK018BR+PmvgCM+8uEGifvmtbU04PEH
 6Vj8elb5QkUCbCz41XMbXuDhYRwTNz0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-m4Cq-_1dNNSPt6qtjgMskw-1; Tue, 26 May 2026 13:56:38 -0400
X-MC-Unique: m4Cq-_1dNNSPt6qtjgMskw-1
X-Mimecast-MFC-AGG-ID: m4Cq-_1dNNSPt6qtjgMskw_1779818197
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4518f777225so7723030f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818197; x=1780422997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK4ewdpRbWjBOdfd9WIfkWHhs6P79cHSH2ERgJE6mCs=;
 b=B50xsXAjR43ivxvM45nBQ3mPLZGcivw1ZPq29+/FuA86MWysIevnzxYnLSjuuIBeLY
 jMomj8xUI3g45sXANYSuoTJ1po+hcc/5r+pvFrane/WURniQP+2Odz6h8gTUy/LawMyX
 JcwXQ1B+GAx0wQMS2SbiE9lq6lFiJ9z1l7XEMuxlpRLZUfwdcsEErrpKEuSgzQOjUycj
 50SbGxaJIa2KFASUiqwiU/BFzqQM6EMEjo2QKmG22kL9qqCrGGcDkPPDVimGJpDkXfYH
 2XvLmXWoNI9F9f1JjLdBuoig1TTnGrW/BRTvrtUj13y3ljr2BbLtjs0DH4ucNr+H9kCo
 kt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818197; x=1780422997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mK4ewdpRbWjBOdfd9WIfkWHhs6P79cHSH2ERgJE6mCs=;
 b=IYMp6Ezq8d8gTMts0Omy+AaMKf/iyrg/sxbd5ZLEs8OVL35Pn57vLSk7GpayrzubhV
 RQc0FCgDk8ZNOKtNkieoYQhsP1JXUtCz2+2wtVHpYHPEaOn/K1L3hsRYgdyA5YEnz9AP
 nSTKBA6MtgQ0XveX0GqB8cMRawpc/h7G9+Yn6g+DcSlGQz2At+5yES7KB8fti5K815Ms
 lH22OoxxtjP8jXD58KFTLgELZ5A4+C9lDWb57M/+xFNZvYOrB62pMr4tOQgPnYkos75p
 hlSA6lW+lp019YeHNCElXo+QVqRcMBu/2+d7m6lxaAPU/V09s3ZNhhjyBJbUBopb7Ioq
 U1Aw==
X-Gm-Message-State: AOJu0YxFqfIYzpF07wucPB4hX2H6fKmzskqoJfmQmf3LM3tWfhPTnNjq
 BLN6RAd51m+SQyL+uSR740AJZyGuOjyN1aN/Df76Z68Te2PUEb06SAd4ezn5c+58QC4WnYHHjrk
 tRu/Mh1gtH2FUfxipQHERrwY0zWmjcCKbmzVHOwereTzqdXiaxh7bjiVxD3ymSwfvufghW14Gm0
 Rq5m6COG/DF2o/+e3e8+p6W8IFRA7txpy7hNK+99gb
X-Gm-Gg: Acq92OGirBBYmCQkc2JGEuANNRlBT3edFkwp1hLgNJPwaRGgrQg7CkoubzDHqYXTmxs
 XflVmmZF92XJ1noPh5CCkN/Yb3FWxft//bV1QtuR3lC3qwKH9eXTjMo/yu6ZuVsjY8qbhY86alt
 9Rr31nLbP9EINvazlmvmFDalUnAiGhxwbBHWc0gk4rPL3gSmT2BOwRvnGmyxIFYL4e7SozxmmSx
 tv5BUWm9MzLgTjjKhRp9LrGqK2q70ZvVlPwE3N+C52Oa+ZNN6Y2GRLPC1cvpqMBle7fiR+JnFhh
 taYPQ787kLF3L2+NhOY5lWrYxcb2FKMDgDParERKXn2Laye8krHvyQWgf7NJogQzw7bOG1ICI7s
 bGetmAt9VhmNYrJfYSYNBKDeHPjxn+k3MlaPFSG1G/uhPXLO9vOievTwOQBQzWkziy6V07WAB98
 ntR1ESXSIpBQ7Z9a+WSd/fHJR+M3Y=
X-Received: by 2002:a05:600c:4ecc:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-490426cbba2mr328828665e9.22.1779818196875; 
 Tue, 26 May 2026 10:56:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-490426cbba2mr328828265e9.22.1779818196276; 
 Tue, 26 May 2026 10:56:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049973b71sm100496595e9.29.2026.05.26.10.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 06/19] rust/qobject: add Deserializer (from_qobject)
 implementation
Date: Tue, 26 May 2026 19:56:05 +0200
Message-ID: <20260526175618.227743-7-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rust/util/src/qobject/deserializer.rs | 371 ++++++++++++++++++++++++++
 rust/util/src/qobject/error.rs        |   8 +-
 rust/util/src/qobject/mod.rs          |   2 +
 4 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 rust/util/src/qobject/deserializer.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 67ea84539a2..ebfa6c21883 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -162,6 +162,7 @@ module                     status
 ``util::error``            stable
 ``util::log``              proof of concept
 ``util::module``           complete
+``util::qobject``          stable
 ``util::timer``            stable
 ========================== ======================
 
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
index 6920b9d2777..76b167104d1 100644
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
2.54.0


