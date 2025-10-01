Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5A8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmL-0005im-KZ; Wed, 01 Oct 2025 04:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmC-0005f7-BP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rlt-000624-FW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzJAcFRpGiLlMc807Y1MyWk7EnWDDDqSo1UjiURzpiA=;
 b=auu7ESBHIMQJ6HaDZ1PIeGsCGyIQsk5htajRklSBW+1TQLo0djxNy6J5XgvTDBiOK4NBX3
 njFFpoCEsUlLE1E8PW4glf0B3DaiTDC8/w+dcThGr/ICAZqw7xivHTU+u88zIOxHlCmw6b
 CEAwtZhIgXVfirA0nkvFdakyBPAobd4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-1J-aLBi6NCKt2EdOWyMK2w-1; Wed, 01 Oct 2025 04:01:06 -0400
X-MC-Unique: 1J-aLBi6NCKt2EdOWyMK2w-1
X-Mimecast-MFC-AGG-ID: 1J-aLBi6NCKt2EdOWyMK2w_1759305665
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so642317466b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305664; x=1759910464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzJAcFRpGiLlMc807Y1MyWk7EnWDDDqSo1UjiURzpiA=;
 b=u3vjR+k6YEf5omknog2DBZ02j/X1nvbfhFd14Jt0DFBzTJ7QDwACfQvujVZIjPjXIy
 tN08IOt4GPdSDkB5q2q3E5h/AIt6dJcpKbM50Co45uZHaFtlPoELNUJaxUC0/I9y/xpv
 /hqSXmZ4WKosGmMZ30gtIeiApNJENMeSMjgX4OP0R+9h2p5hkqZkbLmMJWI9lpwCjWx0
 M8D6l7KfpzHayC1IuHaGXPG70WG0gBiCpPPlcj4qyYCl6yWOl4ieeBj1jQv9sOxp0hRT
 yni2kKjOb57ZsXrYxMV7GCfBbcH+dcT+EWQ001yGAeA1jGKY4YkhTg+RJ2GZIP7juy0k
 Rbog==
X-Gm-Message-State: AOJu0YyPdSeq5B6c5D85uL/WbxZpEnBmh0jIXZthxq3654Uf/i2cCZHv
 uwggSUj6gKRt7jQcctCekL2Xvy9652LFtaoRQo42ZKQA2Ib+f+JPO+GBJjUIgs5HpykbdC9dTw4
 4xwkO0swuK9ZEk1S/8q5UiKEKKhbbfmILMgT4Zgh+4vbS75RG+ABib1nSQoU5x6QPFT1AyVIJLW
 HGmNEdXz8TbNbJvxNvsXLF6q6VrNs7ZnMUbfhn2m0k
X-Gm-Gg: ASbGncu5RDOlpXM/T4IVxgZgACkmkn0qEpL9hvinPd4x6AWyr9g/Y1r46oGSAeQjnYm
 Ulacj93UI9BAKeEvNP182dNcOJJsApAS6ZXGaHiwfTMan6T38Al1cpeL07oL4Hzw18Ct1YrbjKd
 9/+dhOERLvsjdBXQ3f2l3Qpp+iokO/22oifIUetlH6oyrZAZ8RsZig9/C5dklnEIHWrDTXf8uNL
 bCsEhBreGbRoHyuFNrvp9H3+Nh2uPC1kriFHgp9TmRx+YFhpn3Yj3tEJhgha/0g5/7hOQNssZQX
 jlY59oZPjrE1aQ1YmKH3BpETZUaQ/vOvYrwcbHb1SlwBb25Q4g/O3Zau4X+14rGj5xbzALsnSdW
 33cUmQJjGblcsvTKsDFEcIO6RH2izndDzP3Pb+Z47EuEgW+Bz/18=
X-Received: by 2002:a17:907:1c84:b0:b3e:dbbc:4e16 with SMTP id
 a640c23a62f3a-b46e88953abmr314595766b.41.1759305664296; 
 Wed, 01 Oct 2025 01:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8orUP3DP0Hak+nIAujjxei7/5sDwZ32T+UC9TQA7V24VtGbDrHyflXKD7tJExNGmEWsmhnQ==
X-Received: by 2002:a17:907:1c84:b0:b3e:dbbc:4e16 with SMTP id
 a640c23a62f3a-b46e88953abmr314590066b.41.1759305663717; 
 Wed, 01 Oct 2025 01:01:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4762495317sm85068066b.8.2025.10.01.01.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 05/14] rust: add Serializer (to_qobject) implementation for
 QObject
Date: Wed,  1 Oct 2025 10:00:42 +0200
Message-ID: <20251001080051.1043944-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
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

This allows creating QObject from any serializable data structure.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/meson.build               |   2 +
 rust/util/src/qobject/error.rs      |  52 +++
 rust/util/src/qobject/mod.rs        |   4 +
 rust/util/src/qobject/serializer.rs | 585 ++++++++++++++++++++++++++++
 4 files changed, 643 insertions(+)
 create mode 100644 rust/util/src/qobject/error.rs
 create mode 100644 rust/util/src/qobject/serializer.rs

diff --git a/rust/util/meson.build b/rust/util/meson.build
index 5b99d38c903..fb152766003 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,6 +39,8 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/error.rs',
+      'src/qobject/serializer.rs',
       'src/qobject/serialize.rs',
     ]}),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
diff --git a/rust/util/src/qobject/error.rs b/rust/util/src/qobject/error.rs
new file mode 100644
index 00000000000..5212e65c4f7
--- /dev/null
+++ b/rust/util/src/qobject/error.rs
@@ -0,0 +1,52 @@
+//! Error data type for `QObject`'s `serde` integration
+
+use std::{
+    ffi::NulError,
+    fmt::{self, Display},
+    str::Utf8Error,
+};
+
+use serde::ser;
+
+#[derive(Debug)]
+pub enum Error {
+    Custom(String),
+    KeyMustBeAString,
+    InvalidUtf8,
+    NulEncountered,
+    NumberOutOfRange,
+}
+
+impl ser::Error for Error {
+    fn custom<T: Display>(msg: T) -> Self {
+        Error::Custom(msg.to_string())
+    }
+}
+
+impl From<NulError> for Error {
+    fn from(_: NulError) -> Self {
+        Error::NulEncountered
+    }
+}
+
+impl From<Utf8Error> for Error {
+    fn from(_: Utf8Error) -> Self {
+        Error::InvalidUtf8
+    }
+}
+
+impl Display for Error {
+    fn fmt(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
+        match self {
+            Error::Custom(msg) => formatter.write_str(msg),
+            Error::KeyMustBeAString => formatter.write_str("key must be a string"),
+            Error::InvalidUtf8 => formatter.write_str("invalid UTF-8 in string"),
+            Error::NulEncountered => formatter.write_str("NUL character in string"),
+            Error::NumberOutOfRange => formatter.write_str("number out of range"),
+        }
+    }
+}
+
+impl std::error::Error for Error {}
+
+pub type Result<T> = std::result::Result<T, Error>;
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 2e3cb247b27..cd034185748 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,7 +6,9 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod error;
 mod serialize;
+mod serializer;
 
 use std::{
     cell::UnsafeCell,
@@ -17,6 +19,8 @@
 };
 
 use common::assert_field_type;
+pub use error::{Error, Result};
+pub use serializer::to_qobject;
 
 use crate::bindings;
 
diff --git a/rust/util/src/qobject/serializer.rs b/rust/util/src/qobject/serializer.rs
new file mode 100644
index 00000000000..59200683f5d
--- /dev/null
+++ b/rust/util/src/qobject/serializer.rs
@@ -0,0 +1,585 @@
+//! `QObject` serializer
+//!
+//! This module implements a [`Serializer`](serde::ser::Serializer) that
+//! produces `QObject`s, allowing them to be created from serializable data
+//! structures (such as primitive data types, or structs that implement
+//! `Serialize`).
+
+use std::ffi::CString;
+
+use serde::ser::{Impossible, Serialize};
+
+use super::{
+    error::{Error, Result},
+    QObject,
+};
+
+pub struct SerializeTupleVariant {
+    name: CString,
+    vec: Vec<QObject>,
+}
+
+impl serde::ser::SerializeTupleVariant for SerializeTupleVariant {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_field<T>(&mut self, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        self.vec.push(to_qobject(value)?);
+        Ok(())
+    }
+
+    fn end(self) -> Result<QObject> {
+        let SerializeTupleVariant { name, vec, .. } = self;
+
+        // TODO: insert elements one at a time
+        let list = QObject::from_iter(vec);
+
+        // serde by default represents enums as a single-entry object, with
+        // the variant stored in the key ("external tagging").  Internal tagging
+        // is implemented by the struct that requests it, not by the serializer.
+        let map = [(name, list)];
+        Ok(QObject::from_iter(map))
+    }
+}
+
+pub struct SerializeStructVariant {
+    name: CString,
+    vec: Vec<(CString, QObject)>,
+}
+
+impl serde::ser::SerializeStructVariant for SerializeStructVariant {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_field<T>(&mut self, key: &'static str, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        self.vec.push((CString::new(key)?, to_qobject(value)?));
+        Ok(())
+    }
+
+    fn end(self) -> Result<QObject> {
+        // TODO: insert keys one at a time
+        let SerializeStructVariant { name, vec, .. } = self;
+        let list = QObject::from_iter(vec);
+
+        // serde by default represents enums as a single-entry object, with
+        // the variant stored in the key ("external tagging").  Internal tagging
+        // is implemented by the struct that requests it, not by the serializer.
+        let map = [(name, list)];
+        Ok(QObject::from_iter(map))
+    }
+}
+
+pub struct SerializeVec {
+    vec: Vec<QObject>,
+}
+
+impl serde::ser::SerializeSeq for SerializeVec {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_element<T>(&mut self, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        self.vec.push(to_qobject(value)?);
+        Ok(())
+    }
+
+    fn end(self) -> Result<QObject> {
+        // TODO: insert elements one at a time
+        let SerializeVec { vec, .. } = self;
+        let list = QObject::from_iter(vec);
+        Ok(list)
+    }
+}
+
+impl serde::ser::SerializeTuple for SerializeVec {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_element<T>(&mut self, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        serde::ser::SerializeSeq::serialize_element(self, value)
+    }
+
+    fn end(self) -> Result<QObject> {
+        serde::ser::SerializeSeq::end(self)
+    }
+}
+
+impl serde::ser::SerializeTupleStruct for SerializeVec {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_field<T>(&mut self, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        serde::ser::SerializeSeq::serialize_element(self, value)
+    }
+
+    fn end(self) -> Result<QObject> {
+        serde::ser::SerializeSeq::end(self)
+    }
+}
+
+struct MapKeySerializer;
+
+impl serde::Serializer for MapKeySerializer {
+    type Ok = CString;
+    type Error = Error;
+
+    type SerializeSeq = Impossible<CString, Error>;
+    type SerializeTuple = Impossible<CString, Error>;
+    type SerializeTupleStruct = Impossible<CString, Error>;
+    type SerializeTupleVariant = Impossible<CString, Error>;
+    type SerializeMap = Impossible<CString, Error>;
+    type SerializeStruct = Impossible<CString, Error>;
+    type SerializeStructVariant = Impossible<CString, Error>;
+
+    #[inline]
+    fn serialize_unit_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        variant: &'static str,
+    ) -> Result<CString> {
+        Ok(CString::new(variant)?)
+    }
+
+    #[inline]
+    fn serialize_newtype_struct<T>(self, _name: &'static str, value: &T) -> Result<CString>
+    where
+        T: ?Sized + Serialize,
+    {
+        value.serialize(self)
+    }
+
+    fn serialize_bool(self, _value: bool) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_i8(self, _value: i8) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_i16(self, _value: i16) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_i32(self, _value: i32) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_i64(self, _value: i64) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_i128(self, _value: i128) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_u8(self, _value: u8) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_u16(self, _value: u16) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_u32(self, _value: u32) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_u64(self, _value: u64) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_u128(self, _value: u128) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_f32(self, _value: f32) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_f64(self, _value: f64) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    #[inline]
+    fn serialize_char(self, _value: char) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    #[inline]
+    fn serialize_str(self, value: &str) -> Result<CString> {
+        Ok(CString::new(value)?)
+    }
+
+    fn serialize_bytes(self, value: &[u8]) -> Result<CString> {
+        Ok(CString::new(value)?)
+    }
+
+    fn serialize_unit(self) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_unit_struct(self, _name: &'static str) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_newtype_variant<T>(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        _variant: &'static str,
+        _value: &T,
+    ) -> Result<CString>
+    where
+        T: ?Sized + Serialize,
+    {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_none(self) -> Result<CString> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_some<T>(self, _value: &T) -> Result<CString>
+    where
+        T: ?Sized + Serialize,
+    {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_seq(self, _len: Option<usize>) -> Result<Self::SerializeSeq> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_tuple(self, _len: usize) -> Result<Self::SerializeTuple> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_tuple_struct(
+        self,
+        _name: &'static str,
+        _len: usize,
+    ) -> Result<Self::SerializeTupleStruct> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_tuple_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        _variant: &'static str,
+        _len: usize,
+    ) -> Result<Self::SerializeTupleVariant> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_map(self, _len: Option<usize>) -> Result<Self::SerializeMap> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_struct(self, _name: &'static str, _len: usize) -> Result<Self::SerializeStruct> {
+        Err(Error::KeyMustBeAString)
+    }
+
+    fn serialize_struct_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        _variant: &'static str,
+        _len: usize,
+    ) -> Result<Self::SerializeStructVariant> {
+        Err(Error::KeyMustBeAString)
+    }
+}
+
+pub struct SerializeMap {
+    vec: Vec<(CString, QObject)>,
+    next_key: Option<CString>,
+}
+
+impl serde::ser::SerializeMap for SerializeMap {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_key<T>(&mut self, key: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        self.next_key = Some(key.serialize(MapKeySerializer)?);
+        Ok(())
+    }
+
+    fn serialize_value<T>(&mut self, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        let key = self.next_key.take();
+        // Panic because this indicates a bug in the program rather than an
+        // expected failure.
+        let key = key.expect("serialize_value called before serialize_key");
+        self.vec.push((key, to_qobject(value)?));
+        Ok(())
+    }
+
+    fn end(self) -> Result<QObject> {
+        // TODO: insert keys one at a time
+        let SerializeMap { vec, .. } = self;
+        Ok(QObject::from_iter(vec))
+    }
+}
+
+impl serde::ser::SerializeStruct for SerializeMap {
+    type Ok = QObject;
+    type Error = Error;
+
+    fn serialize_field<T>(&mut self, key: &'static str, value: &T) -> Result<()>
+    where
+        T: ?Sized + Serialize,
+    {
+        serde::ser::SerializeMap::serialize_entry(self, key, value)
+    }
+
+    fn end(self) -> Result<QObject> {
+        serde::ser::SerializeMap::end(self)
+    }
+}
+
+/// Serializer whose output is a `QObject`.
+///
+/// This is the serializer that backs [`to_qobject`].
+pub struct Serializer;
+
+impl serde::Serializer for Serializer {
+    type Ok = QObject;
+    type Error = Error;
+    type SerializeSeq = SerializeVec;
+    type SerializeTuple = SerializeVec;
+    type SerializeTupleStruct = SerializeVec;
+    type SerializeTupleVariant = SerializeTupleVariant;
+    type SerializeMap = SerializeMap;
+    type SerializeStruct = SerializeMap;
+    type SerializeStructVariant = SerializeStructVariant;
+
+    #[inline]
+    fn serialize_bool(self, value: bool) -> Result<QObject> {
+        Ok(value.into())
+    }
+
+    #[inline]
+    fn serialize_i8(self, value: i8) -> Result<QObject> {
+        self.serialize_i64(i64::from(value))
+    }
+
+    #[inline]
+    fn serialize_i16(self, value: i16) -> Result<QObject> {
+        self.serialize_i64(i64::from(value))
+    }
+
+    #[inline]
+    fn serialize_i32(self, value: i32) -> Result<QObject> {
+        self.serialize_i64(i64::from(value))
+    }
+
+    fn serialize_i64(self, value: i64) -> Result<QObject> {
+        Ok(value.into())
+    }
+
+    fn serialize_i128(self, value: i128) -> Result<QObject> {
+        if let Ok(value) = u64::try_from(value) {
+            Ok(value.into())
+        } else if let Ok(value) = i64::try_from(value) {
+            Ok(value.into())
+        } else {
+            Err(Error::NumberOutOfRange)
+        }
+    }
+
+    #[inline]
+    fn serialize_u8(self, value: u8) -> Result<QObject> {
+        self.serialize_u64(u64::from(value))
+    }
+
+    #[inline]
+    fn serialize_u16(self, value: u16) -> Result<QObject> {
+        self.serialize_u64(u64::from(value))
+    }
+
+    #[inline]
+    fn serialize_u32(self, value: u32) -> Result<QObject> {
+        self.serialize_u64(u64::from(value))
+    }
+
+    #[inline]
+    fn serialize_u64(self, value: u64) -> Result<QObject> {
+        Ok(value.into())
+    }
+
+    fn serialize_u128(self, value: u128) -> Result<QObject> {
+        if let Ok(value) = u64::try_from(value) {
+            Ok(value.into())
+        } else {
+            Err(Error::NumberOutOfRange)
+        }
+    }
+
+    #[inline]
+    fn serialize_f32(self, float: f32) -> Result<QObject> {
+        self.serialize_f64(f64::from(float))
+    }
+
+    #[inline]
+    fn serialize_f64(self, float: f64) -> Result<QObject> {
+        Ok(float.into())
+    }
+
+    #[inline]
+    fn serialize_char(self, value: char) -> Result<QObject> {
+        let mut s = String::new();
+        s.push(value);
+        Ok(CString::new(s)?.into())
+    }
+
+    #[inline]
+    fn serialize_str(self, value: &str) -> Result<QObject> {
+        Ok(CString::new(value)?.into())
+    }
+
+    fn serialize_bytes(self, value: &[u8]) -> Result<QObject> {
+        // Serialize into a vector of numeric QObjects
+        let it = value.iter().map(|&b| u64::from(b));
+        Ok(QObject::from_iter(it))
+    }
+
+    #[inline]
+    fn serialize_unit(self) -> Result<QObject> {
+        Ok(().into())
+    }
+
+    #[inline]
+    fn serialize_unit_struct(self, _name: &'static str) -> Result<QObject> {
+        self.serialize_unit()
+    }
+
+    #[inline]
+    fn serialize_unit_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        variant: &'static str,
+    ) -> Result<QObject> {
+        self.serialize_str(variant)
+    }
+
+    #[inline]
+    fn serialize_newtype_struct<T>(self, _name: &'static str, value: &T) -> Result<QObject>
+    where
+        T: ?Sized + Serialize,
+    {
+        value.serialize(self)
+    }
+
+    fn serialize_newtype_variant<T>(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        variant: &'static str,
+        value: &T,
+    ) -> Result<QObject>
+    where
+        T: ?Sized + Serialize,
+    {
+        // serde by default represents enums as a single-entry object, with
+        // the variant stored in the key ("external tagging").  Internal tagging
+        // is implemented by the struct that requests it, not by the serializer.
+        let map = [(CString::new(variant)?, to_qobject(value)?)];
+        Ok(QObject::from_iter(map))
+    }
+
+    #[inline]
+    fn serialize_none(self) -> Result<QObject> {
+        self.serialize_unit()
+    }
+
+    #[inline]
+    fn serialize_some<T>(self, value: &T) -> Result<QObject>
+    where
+        T: ?Sized + Serialize,
+    {
+        value.serialize(self)
+    }
+
+    fn serialize_seq(self, len: Option<usize>) -> Result<Self::SerializeSeq> {
+        Ok(SerializeVec {
+            vec: Vec::with_capacity(len.unwrap_or(0)),
+        })
+    }
+
+    fn serialize_tuple(self, len: usize) -> Result<Self::SerializeTuple> {
+        self.serialize_seq(Some(len))
+    }
+
+    fn serialize_tuple_struct(
+        self,
+        _name: &'static str,
+        len: usize,
+    ) -> Result<Self::SerializeTupleStruct> {
+        self.serialize_seq(Some(len))
+    }
+
+    fn serialize_tuple_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        variant: &'static str,
+        len: usize,
+    ) -> Result<Self::SerializeTupleVariant> {
+        Ok(SerializeTupleVariant {
+            name: CString::new(variant)?,
+            vec: Vec::with_capacity(len),
+        })
+    }
+
+    fn serialize_map(self, _len: Option<usize>) -> Result<Self::SerializeMap> {
+        Ok(SerializeMap {
+            vec: Vec::new(),
+            next_key: None,
+        })
+    }
+    fn serialize_struct(self, _name: &'static str, len: usize) -> Result<Self::SerializeStruct> {
+        self.serialize_map(Some(len))
+    }
+
+    fn serialize_struct_variant(
+        self,
+        _name: &'static str,
+        _variant_index: u32,
+        variant: &'static str,
+        _len: usize,
+    ) -> Result<Self::SerializeStructVariant> {
+        Ok(SerializeStructVariant {
+            name: CString::new(variant)?,
+            vec: Vec::new(),
+        })
+    }
+}
+
+pub fn to_qobject<T>(input: T) -> Result<QObject>
+where
+    T: Serialize,
+{
+    input.serialize(Serializer)
+}
-- 
2.51.0


