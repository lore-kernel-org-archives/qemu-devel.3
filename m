Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246FBD185F2
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpn8-0007Yx-4N; Thu, 08 Jan 2026 08:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn6-0007Y6-3i
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn3-0007zB-Js
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpHKlKmUC0n2lAzUf3AvxLx4w3ae82IHyL9uR8odyos=;
 b=V5R3Z45otGNWKXw+N58NLoXoBmlLbZY+yHi2fkrGMDFWFehLjLyD3i9GFUbjQy4Ux6F18V
 LVk71rhDZ3GzRGG1OkcR/ihpmV769ArSE51zr+R77NiWquNQnqjqTeypqFwXBtkm2QVAUm
 n74SwMYqMzgiJn4Ym+m1T3O0Vm65PeY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-YePMl8PCO7yQ6pEIvv_PhQ-1; Thu, 08 Jan 2026 08:10:59 -0500
X-MC-Unique: YePMl8PCO7yQ6pEIvv_PhQ-1
X-Mimecast-MFC-AGG-ID: YePMl8PCO7yQ6pEIvv_PhQ_1767877858
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so29183885e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877857; x=1768482657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpHKlKmUC0n2lAzUf3AvxLx4w3ae82IHyL9uR8odyos=;
 b=YRhDWZmfK1oniJSqctnjw7oDLQQlFxCYe6+4/V5EuebKq+M2cUuOdZM0R9KtSgYSF/
 9rfzLtMundHx4yIyIvV54BOj92gpWx4QNA3Qg1QU43xsn8IdhnTG+1D/CYhJD51ZRv+O
 SnmLH0GpPrh7T/7BbjSAj426NT1htmynyN8R06arIxkFg2qDixdcPJfBTyisvKR9Q7om
 zQXFKM3dHvrVwiX2c+Ie7S6AlLKJnoSUQd9T0+fqw2MQx80kJ/bSkDJG75MggsX6obYS
 6pSpP3yuOt+gsfZkFYFcGBFryTkBiMfZJlC/MBQhWcR/CE1YkvAphEJq8iigSWgDiTeP
 2r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877857; x=1768482657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YpHKlKmUC0n2lAzUf3AvxLx4w3ae82IHyL9uR8odyos=;
 b=mRE8R9/D1RDfgIywS/9OFMBK+baLrmz9VOxr2OKgqEyLJh3FV8WaUs37RQcgLVgLAd
 5YhzbYSC//b/X8G8H++vI6ktZjI9xdvBZHBgxQZ0HT/m0+veZy7J/1JN9U9kjNBilXWW
 Q5EdUkHZlSEMxiag+6QU/pXQU41N6ybknVnk4XDgKZnyg1lFXFH1fGwQdbQntdX5lOSa
 BpXN1OJng10F7JU78P7pEzViW6m2EjfBtwUGRhFB1sSDAuV1azizZ3VRPUZNZNXayVnh
 I49VoUCnVAAIyGkxIhJnTlIrRc1PfCDwexJ6Wh9984mgFqfm3DMSagj6nFTNCPyMWJRq
 Zf9Q==
X-Gm-Message-State: AOJu0Ywqd1HGibTOuNMyyG3dsMNJzt6+kMm3GCiqDPDN+5Niq6zdT1K+
 3f6SjVPhH6EJFUg43zFy/VBNmKdmEuP8bv+w5DTaRV8bSx31sDS2Jv21GJp+LxhdAVvRMXe03If
 00k2DYlJcDpd4nx3clhtLk96GStGlWb/PfKj+Jccr92MOMqsoNkK540U+n1SlUnNOtrakKvU5Wr
 +SXSVCikDpk6Spxm5+frqkTklhUrrROkckqJ0xiG+z
X-Gm-Gg: AY/fxX4HUjgPPJyfZuCvBQ0WlqSoT/D65WLOM2sjlpF4/Laj6KYDCtMidNDC5fG9rMm
 7s+adcJqb1ZNY2P7C5J9ofNjVKhGJMyUF2sQ9Au7X0enbVR/SLh/S1hf2kvYV4kbdYrYDVBjgcw
 h1QLr1ywIfaKseO9igFMnAJKddr3tZiTVxy3fWHxU8/E3Peizk2rXh6oKeq4Lm6bkGsdFkU/0Wu
 AippfnJSBA+X30sD3afSgF4uxv7qzAvywOmi4rDboIibJirtmswOABvpcsfTpFfzVWIy7O1zgf1
 i/IioJYJFTk84I8AQM6eokzj7cfX+pOrquufCSXqipmNDOuk+X6TyNyileyGOlWQ081ciXnbygD
 kWolIvzV4DcNn1t6jQ+F3GOhXu9eTfm5wDLiKOJxvLpxnHY7IMYYxOL9UQCBB/jjWPbrzXUQw36
 ATapOK9ZAT8ADZrQ==
X-Received: by 2002:a05:600c:4f87:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-47d84b0a9a4mr71528835e9.1.1767877856858; 
 Thu, 08 Jan 2026 05:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB7RVwDZiZiXLewpJi/QauvNkDnOFhGX2dW8lPTZWh6hjZ4I9zouh5VsD6nUrJziLeiTvDjQ==
X-Received: by 2002:a05:600c:4f87:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-47d84b0a9a4mr71528295e9.1.1767877856268; 
 Thu, 08 Jan 2026 05:10:56 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm163464275e9.1.2026.01.08.05.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:10:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 04/16] rust/qobject: add Serializer (to_qobject)
 implementation
Date: Thu,  8 Jan 2026 14:10:31 +0100
Message-ID: <20260108131043.490084-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows creating QObject from any serializable data structure.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
index 166a792bce7..7829364c09a 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -40,6 +40,8 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/error.rs',
+      'src/qobject/serializer.rs',
       'src/qobject/serialize.rs',
     ]}),
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, serde_rs],
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
index 7b9f0516fe1..bfa3e9e34bb 100644
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
index 00000000000..08730855731
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
+        Ok(value.into())
+    }
+
+    #[inline]
+    fn serialize_i16(self, value: i16) -> Result<QObject> {
+        Ok(value.into())
+    }
+
+    #[inline]
+    fn serialize_i32(self, value: i32) -> Result<QObject> {
+        Ok(value.into())
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
+        Ok(value.into())
+    }
+
+    #[inline]
+    fn serialize_u16(self, value: u16) -> Result<QObject> {
+        Ok(value.into())
+    }
+
+    #[inline]
+    fn serialize_u32(self, value: u32) -> Result<QObject> {
+        Ok(value.into())
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
+        Ok(float.into())
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
+        let it = value.iter().copied();
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
2.52.0


