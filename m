Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DDDD185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnB-0007Zm-4S; Thu, 08 Jan 2026 08:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn8-0007Z4-TO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpn7-0007zc-20
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUVnHGR4WXXh17z+7zB0yfXoO4945f0W6/gfPFC9GIg=;
 b=EyeHLM6EhiUJQeJmOc0eXKW8nHYa/zK6EOpese3V2+oqggeK6FBw3MYt7Lp8kAoXcszXky
 yKEUd19RHQqWYw/haA74DBVsDDiDTuN8WrVnzWXal+Lzepv/Ulwyd5sIBAf1uDkXP2WKYk
 ze6s4Anb0CpygGltPEuHrY2qn55+27g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Nr89NWDLP4WbF_o-uDewLA-1; Thu, 08 Jan 2026 08:11:02 -0500
X-MC-Unique: Nr89NWDLP4WbF_o-uDewLA-1
X-Mimecast-MFC-AGG-ID: Nr89NWDLP4WbF_o-uDewLA_1767877861
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477b8a667bcso35632185e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877860; x=1768482660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUVnHGR4WXXh17z+7zB0yfXoO4945f0W6/gfPFC9GIg=;
 b=G7IR4AzEb1a7DHVWhCKBjOTQOa8o4UN++u9y4C4EK9GDng/cL3zHfq7+VBukrKBfm5
 hNhONEM/8Bl0IM5cDuylDJMhzDM+WAJTGgLEZHFaYCoEMhJbIENU26z8jvGk3olqBFOg
 zHA+RSoDE/64pWhgyEa3nrQUmQoksRaY73QW4ibEcTFJfuDg2Zgifb5jkf1xktgKNm0e
 +lxNggd2mO+FxRuxNyaRdHfWuG48OiKhKjCaY34ay9c2h+qy5UujyzbXQqcyvttJVEHa
 ssxI3I7Zozrwa90oMgbq9/kBGJvjTSdeNhn7qVglVa6JVvaMrM515JWqMGCqRK1NHoWN
 hwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877860; x=1768482660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JUVnHGR4WXXh17z+7zB0yfXoO4945f0W6/gfPFC9GIg=;
 b=h/bGPB/cv5fYPHDxhv4qro2aFHbqC6t4EPU6huw/YIe0xIVrY0wJ+EuSYaucp8PfaX
 gZhh6gAGfjMqUOLZq3wRin/3KSfAWjL58AGWnTxil/Cq1SmKnJ+rQyRrxBSrV7j29tYg
 NZTMMBIJVMkTXSTrRRbMQygcDKcHlHS2DC3Lm2U1uFRICWW+X6LLWkJTbERVTCG+RU9c
 33VMqHGJ457mmNIsmZU7sQ6yAoZIGHsYvRtfuxbeGhdRr+sb89N8r+bh8l/uRLRRK4Za
 xggaD+RkrrRmI2JBbCEtsL0fEPIjzoHmS1Zl6PuEYfO0Saul/XFomd9+W8gXzQmIi2wE
 SHsw==
X-Gm-Message-State: AOJu0YyCgDmnDLLs/HwfyS9NKogzJBovyLEpBEuMhOX5tTY1uFzKV1HI
 5N/j1+4CGnyBQrRgopjdsBLzyv4E7Fg2KXVb1qELyygXITp4IApNfVzgMrmgtKBueZvph5uNq0H
 +gAFX5ZpipEmAToyuqV0vuXVjxk7Ga0VeWJ+ZK1hzc1YgXBhAb8/WLlxcbzCtwmGltqiLte6uKl
 8fHjOCjBlN5It+g10HYMGIODRAwuQex17sOG4/X7cH
X-Gm-Gg: AY/fxX7OQFf/PFghyDlr55216x8K1ynATXIFSm+O4WH0nfN5n4Ci9J8ZaCAB9gAUvS5
 QNPypCdGYUTGsQY98Uy/sspqGlntW58yg/2XEFqJ2MX6ZRLvjmfdOw53jdhSZIJPxlc78ZbuYpQ
 56yWrFogtaXetFVqdmPi66Xpe3VKV2ywR6rqRogI0aLvAaXA1bYUBJhGLgJ3Utk0eYSw2K24js/
 JWRSqSFYDM7z5Il4ZLPGVzU6UVre8yl7k8IdGsWReLBEL8nUiirW4QKyv2pTTAl6Gv2xelA9WUz
 Rled5V/2vjkU4rR2Ii/qk+ZVipDLnl/mX7AgeTbSV3NpGycD5DfV+t8HeHiM/rnL0t4B6ddxPzo
 YDVw9uP9hf3+C8iJnyIHpK5LIjfgzVbbRuGOm/AjQuYA8u3oE4/vGjIxW3KwA0eSCFs620ab+iU
 25XbX48stvUGgr2A==
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-432c37c878bmr8054237f8f.33.1767877860440; 
 Thu, 08 Jan 2026 05:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuepepjI/T31qaZs/s9jAakQ0H5Cxp4VxpWUG1QPLKG0DFtNRa1vnCXidolxpt29rZB0GTeQ==
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-432c37c878bmr8054210f8f.33.1767877859960; 
 Thu, 08 Jan 2026 05:10:59 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm16274775f8f.25.2026.01.08.05.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:10:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/16] rust/qobject: add Deserialize implementation
Date: Thu,  8 Jan 2026 14:10:32 +0100
Message-ID: <20260108131043.490084-6-pbonzini@redhat.com>
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

This allows QObject to be created from any serializable format, for
example JSON via serde_json.

This is not too useful, since QObjects are produced by
C code or by serializing structs, but it can be used for testing
and it is part of the full implementation of a serde format.

It is relatively simple and similar to the Serializer, just with
the extra indirection of a Visitor.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/meson.build                |   1 +
 rust/util/src/qobject/deserialize.rs | 134 +++++++++++++++++++++++++++
 rust/util/src/qobject/mod.rs         |   1 +
 3 files changed, 136 insertions(+)
 create mode 100644 rust/util/src/qobject/deserialize.rs

diff --git a/rust/util/meson.build b/rust/util/meson.build
index 7829364c09a..4621932fdcb 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -40,6 +40,7 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/deserialize.rs',
       'src/qobject/error.rs',
       'src/qobject/serializer.rs',
       'src/qobject/serialize.rs',
diff --git a/rust/util/src/qobject/deserialize.rs b/rust/util/src/qobject/deserialize.rs
new file mode 100644
index 00000000000..280a577b6be
--- /dev/null
+++ b/rust/util/src/qobject/deserialize.rs
@@ -0,0 +1,134 @@
+//! `QObject` deserialization
+//!
+//! This module implements the [`Deserialize`] trait for `QObject`,
+//! allowing it to be created from any serializable format, for
+//! example JSON.
+
+use core::fmt;
+use std::ffi::CString;
+
+use serde::de::{self, Deserialize, MapAccess, SeqAccess, Visitor};
+
+use super::{to_qobject, QObject};
+
+impl<'de> Deserialize<'de> for QObject {
+    #[inline]
+    fn deserialize<D>(deserializer: D) -> Result<QObject, D::Error>
+    where
+        D: serde::Deserializer<'de>,
+    {
+        struct ValueVisitor;
+
+        impl<'de> Visitor<'de> for ValueVisitor {
+            type Value = QObject;
+
+            fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
+                formatter.write_str("any valid JSON value")
+            }
+
+            #[inline]
+            fn visit_bool<E>(self, value: bool) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            #[inline]
+            fn visit_i64<E>(self, value: i64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            fn visit_i128<E>(self, value: i128) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                to_qobject(value).map_err(|_| de::Error::custom("number out of range"))
+            }
+
+            #[inline]
+            fn visit_u64<E>(self, value: u64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            fn visit_u128<E>(self, value: u128) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                to_qobject(value).map_err(|_| de::Error::custom("number out of range"))
+            }
+
+            #[inline]
+            fn visit_f64<E>(self, value: f64) -> Result<QObject, E> {
+                Ok(value.into())
+            }
+
+            #[inline]
+            fn visit_str<E>(self, value: &str) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                CString::new(value)
+                    .map_err(|_| de::Error::custom("NUL character in string"))
+                    .map(QObject::from)
+            }
+
+            #[inline]
+            fn visit_string<E>(self, value: String) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                CString::new(value)
+                    .map_err(|_| de::Error::custom("NUL character in string"))
+                    .map(QObject::from)
+            }
+
+            #[inline]
+            fn visit_none<E>(self) -> Result<QObject, E> {
+                Ok(().into())
+            }
+
+            #[inline]
+            fn visit_some<D>(self, deserializer: D) -> Result<QObject, D::Error>
+            where
+                D: serde::Deserializer<'de>,
+            {
+                Deserialize::deserialize(deserializer)
+            }
+
+            #[inline]
+            fn visit_unit<E>(self) -> Result<QObject, E> {
+                Ok(().into())
+            }
+
+            #[inline]
+            fn visit_seq<V>(self, mut visitor: V) -> Result<QObject, V::Error>
+            where
+                V: SeqAccess<'de>,
+            {
+                // TODO: insert elements one at a time
+                let mut vec = Vec::<QObject>::new();
+
+                while let Some(elem) = visitor.next_element()? {
+                    vec.push(elem);
+                }
+                Ok(QObject::from_iter(vec))
+            }
+
+            fn visit_map<V>(self, mut visitor: V) -> Result<QObject, V::Error>
+            where
+                V: MapAccess<'de>,
+            {
+                // TODO: insert elements one at a time
+                let mut vec = Vec::<(CString, QObject)>::new();
+
+                if let Some(first_key) = visitor.next_key()? {
+                    vec.push((first_key, visitor.next_value()?));
+                    while let Some((key, value)) = visitor.next_entry()? {
+                        vec.push((key, value));
+                    }
+                }
+                Ok(QObject::from_iter(vec))
+            }
+        }
+
+        deserializer.deserialize_any(ValueVisitor)
+    }
+}
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index bfa3e9e34bb..c0c16f28049 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,6 +6,7 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod deserialize;
 mod error;
 mod serialize;
 mod serializer;
-- 
2.52.0


