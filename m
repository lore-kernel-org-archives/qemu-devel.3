Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE3CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1D-0001zo-JR; Tue, 26 May 2026 13:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1B-0001yo-7S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw19-0007w3-B3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhpMW+defQp1Zy/D4N51kFlexsTA9gX8PHAGBhgbGMA=;
 b=I7uhXJfLw2ML/Su1AZ6q6j+3I/tSf/skvHF/dv50UEJ/+r3F09TAQtZFm6R+x5WLCZnHm4
 RsBCsYKXzNSZOhWMAedmm47javCzvR6FNJpiN1w3vEkRJdO+hyrhSAjzTsht3SdEhCWr9z
 Sstw//dNN0+MiZDh4QF5ltN822hiiYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-CX7vTfOFMbqyB5q4N4SaYA-1; Tue, 26 May 2026 13:56:36 -0400
X-MC-Unique: CX7vTfOFMbqyB5q4N4SaYA-1
X-Mimecast-MFC-AGG-ID: CX7vTfOFMbqyB5q4N4SaYA_1779818195
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49043386b3fso40638445e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818195; x=1780422995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhpMW+defQp1Zy/D4N51kFlexsTA9gX8PHAGBhgbGMA=;
 b=FSBc8v75IESz4FrSuvT0NTkolPBh4HS2eYQ8hlORrAnzkyh7r4glyZ3mUfYTKNh2M3
 Nxvsd7AW8Nqv5ZRu2CvcyeSkBPd4awqqbXvmolTgSplWqnjtrzw5NIt89JSp6qnWyEWR
 XmmAEIx1EqKIiDvBlRj+gcadHIVUtspy80YH7GhJtNV6EfWjzRCuAjqVhJ0J9O+XKYFl
 rPUOc+gc4zTSID7XrU81IzaybTUP+ENe2bRz4/AiTzUGvJv+nOlenVw881bAxTsUzdSb
 lQ7f+KusL/OLO/K2hx7hF1k4HBTovjbJLkJ9WOdCXht1JNrQgvG6TxtumZ+ZWkLhI6+o
 6nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818195; x=1780422995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhpMW+defQp1Zy/D4N51kFlexsTA9gX8PHAGBhgbGMA=;
 b=sLNwN374ltoM/UWF2937khKbP9F08v5GHQo7cn+Cq1mwJnnW1T7MFg6UGQdaW8s7mE
 rC/4fWzcMoZY64rEdtQoNDB0fF8b7Rrd2Lksw1o/3AsmBovdTW2iiFqKFpoVeDbu8ZIb
 qb8oS/S7vqlDjy5m9uGMDGE6ITgLIOeSzIl/bQ5SXuSkeyVzPpS3HgxkhmXAZIgAkryH
 UqeLmXqm6h+vxIK2LxJLywdj4biQzyh/JL4sS9pPbz0jbIx3TQBRDQiq6hQpfKz6xcjs
 SO+BzPPlkbYoIB1edKFnnJnCBrVKPoDNn7f8bra7f5V7fJQmpozPdhKI4+Dc0ycv6Lw+
 Z62w==
X-Gm-Message-State: AOJu0Yy0Kn8cqLPHK/UVEgrYItQauBMkPK70EfEjal0eULdkLS0EFu6i
 BaouOpStompiPHa7GuG3HRZlj3Km3hDWE6W/wcn5a3AYvHanKEuhSFcZWR9rdQkHXfkrcZWu4q/
 PUMUWGtv0ujyk7SnOSTNjcob/V5KlM/Laf/3v8lkpXMMZE+0pXatlcl7Qn84uJcUNTVAz/0kFTG
 ZLfELrQkaRX7Yo4zPKCRGVabVRxZA5MPDYzKZeNV28
X-Gm-Gg: Acq92OFe+yvwgbKj/YQphSWo3+QCn5gM/yPVVU6UaI7djT0qsRNh9JR7J9ei57DQcdD
 TR2quHUl0epqF1NJnV31W9uyD7xkzysW6FhPz95NYTA5wI1GC29n3Nz3cIek5hsNZCO8EC3lckL
 levvUrl4YrJZeacvqXlRviXMFfDh1e53mFx32xT0jK/5zLrPMMwgK9OhjQLNhrdciUHIcYQQIlr
 9jLRIJ7YTy4Psl7jBTjAN3JXN/0R15K5z19UqIrjtKrPNKelgCol80xvKE2bMbpt8JIHPRezeVS
 Ljwc+2dzUqoTquNkpEgn9JutIPlAmPWtjxYJf2WlID7nw7EuuaNa1j99Poa9o8seipKtrhzeMjq
 xmbiVJO7vsEsgbBRTMlw0uBnkVNNVSRbj4Awy7UrFHtq7l0LU6+Gvhz4EMFeZq7EmcTC6ZFPH3K
 /hn0j+l/zANplZAtEbg1vkRpZ4ldn3g5qDzg2MSg==
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr192571835e9.2.1779818195173; 
 Tue, 26 May 2026 10:56:35 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr192571345e9.2.1779818194564; 
 Tue, 26 May 2026 10:56:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac676sm373142235e9.13.2026.05.26.10.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 05/19] rust/qobject: add Deserialize implementation
Date: Tue, 26 May 2026 19:56:04 +0200
Message-ID: <20260526175618.227743-6-pbonzini@redhat.com>
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
 rust/util/src/qobject/deserialize.rs | 134 +++++++++++++++++++++++++++
 rust/util/src/qobject/mod.rs         |   1 +
 2 files changed, 135 insertions(+)
 create mode 100644 rust/util/src/qobject/deserialize.rs

diff --git a/rust/util/src/qobject/deserialize.rs b/rust/util/src/qobject/deserialize.rs
new file mode 100644
index 00000000000..3ac1cabbae6
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
+                    .map_err(de::Error::custom)
+                    .map(QObject::from)
+            }
+
+            #[inline]
+            fn visit_string<E>(self, value: String) -> Result<QObject, E>
+            where
+                E: serde::de::Error,
+            {
+                CString::new(value)
+                    .map_err(de::Error::custom)
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
index c94b2028c1d..6920b9d2777 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,6 +6,7 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod deserialize;
 mod error;
 mod serialize;
 mod serializer;
-- 
2.54.0


