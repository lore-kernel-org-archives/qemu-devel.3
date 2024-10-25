Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E22D116FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MnG-0003Y5-S1; Fri, 25 Oct 2024 12:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnD-0003Og-LT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MnB-0004tl-Si
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkFMNQ5Htp0kKrDfk6aFD0NUD+y1hI6PGKaCy6DDY4c=;
 b=MwrMlsupbrIi4u/4f+FohsmMtPGbEQxepfbH9feBBgnI6bVPdilBXoS+6+zed9XsN23Xgv
 u9Cfc5TPON6DAsr6dbkZStvDGANlmLP2mv+ZTAoqHjB90rrhpXmUaEaAfTIx0pdGngmR/P
 W6PoA3p/rb91iThxbTL8HnLGhaxQU0U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-9kq-ZvKpNU-f-2Ksc9hqEQ-1; Fri, 25 Oct 2024 12:03:59 -0400
X-MC-Unique: 9kq-ZvKpNU-f-2Ksc9hqEQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1828916fso280312466b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872237; x=1730477037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkFMNQ5Htp0kKrDfk6aFD0NUD+y1hI6PGKaCy6DDY4c=;
 b=Q9AqTOXdvgu+evX7EVNBrSK6thNYd+Rzn5PRogBBYrnmzqv1AoSyI5kjeViMuQciGh
 jY63bg+Kaw89qsOetZr276YVQpPYZm0ZOyuvtsmSfVFozCQ4FFlAQSYPP2ASBHmgfFWx
 k9QG5R7IgxiSMNP6sROai6ZAArCTrvW+GDOtHPoby1yJRHrUoXIWj7m8i2ClvvguWLv1
 EWKgNYYJEJ7SHHesGG2awdqfwDDX7jHFH98cJhu+NYcJVDzXVMxMjzq3Zb7D3HOJQXjb
 aqZJR1iqpLCylUycjIWFcAJ7Dy92C/ULdKFumZPRx/6Z1yTszmS5eUBVN+/KzpCpxtIZ
 qlIg==
X-Gm-Message-State: AOJu0YxZCGIUOCSbkGCxFeTS3IqRWZOFMwc4Fy3iRPy2UYdvgOfKdj9q
 3ZG0jAqPksogEAvTBjZvNmnte1LQOqGHD3La0y3UA/X45WJESNDyyHBBE/PUA9SQRiY3ZvwOVnG
 0wC7z8M9UcAIRNJ2rQy72ya149cRoxlm4B6A/R5eayt1sxZqPjqKIPDdSXlK6BcQ2KBFAM4tQKA
 8FW6OCzJrO+cGG09BVjMU2Gu8XYFDJViVvXagfC5E=
X-Received: by 2002:a17:906:794b:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9de38e3034mr2948566b.22.1729872235094; 
 Fri, 25 Oct 2024 09:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX+5M21UcmYQt+zFxFYDnXhKyrG0csm0H1HWvSp66jGGSxFUavnAchg9Wt46ZpndRAHIqkPQ==
X-Received: by 2002:a17:906:794b:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9de38e3034mr2943366b.22.1729872234499; 
 Fri, 25 Oct 2024 09:03:54 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1e75fff3sm85531566b.29.2024.10.25.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 14/23] rust: create a cargo workspace
Date: Fri, 25 Oct 2024 18:01:59 +0200
Message-ID: <20241025160209.194307-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Workspaces allows tracking dependencies for multiple crates at once,
by having a single Cargo.lock file at the top of the rust/ tree.
Because QEMU's Cargo.lock files have to be synchronized with the versions
of crates in subprojects/, using a workspace avoids the need to copy
over the Cargo.lock file when adding a new device (and thus a new crate)
under rust/hw/.

In addition, workspaces let cargo download and build dependencies just
once.  While right now we have one leaf crate (hw/char/pl011), this
will not be the case once more devices are added.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/{hw/char/pl011 =3D> }/Cargo.lock |  0
 rust/Cargo.toml                     |  7 ++++
 rust/hw/char/pl011/Cargo.toml       |  3 --
 rust/qemu-api-macros/Cargo.lock     | 48 -------------------------
 rust/qemu-api-macros/Cargo.toml     |  3 --
 rust/qemu-api/Cargo.lock            | 54 -----------------------------
 rust/qemu-api/Cargo.toml            |  3 --
 7 files changed, 7 insertions(+), 111 deletions(-)
 rename rust/{hw/char/pl011 =3D> }/Cargo.lock (100%)
 create mode 100644 rust/Cargo.toml
 delete mode 100644 rust/qemu-api-macros/Cargo.lock
 delete mode 100644 rust/qemu-api/Cargo.lock

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/Cargo.lock
similarity index 100%
rename from rust/hw/char/pl011/Cargo.lock
rename to rust/Cargo.lock
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
new file mode 100644
index 00000000000..0c94d5037da
--- /dev/null
+++ b/rust/Cargo.toml
@@ -0,0 +1,7 @@
+[workspace]
+resolver =3D "2"
+members =3D [
+    "qemu-api-macros",
+    "qemu-api",
+    "hw/char/pl011",
+]
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index b089e3dded6..a373906b9fb 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -21,6 +21,3 @@ bilge =3D { version =3D "0.2.0" }
 bilge-impl =3D { version =3D "0.2.0" }
 qemu_api =3D { path =3D "../../../qemu-api" }
 qemu_api_macros =3D { path =3D "../../../qemu-api-macros" }
-
-# Do not include in any global workspace
-[workspace]
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.l=
ock
deleted file mode 100644
index f989e25829f..00000000000
--- a/rust/qemu-api-macros/Cargo.lock
+++ /dev/null
@@ -1,48 +0,0 @@
-# This file is automatically @generated by Cargo.
-# It is not intended for manual editing.
-version =3D 3
-
-[[package]]
-name =3D "proc-macro2"
-version =3D "1.0.84"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a=
49d6"
-dependencies =3D [
- "unicode-ident",
-]
-
-[[package]]
-name =3D "qemu_api_macros"
-version =3D "0.1.0"
-dependencies =3D [
- "proc-macro2",
- "quote",
- "syn",
- "unicode-ident",
-]
-
-[[package]]
-name =3D "quote"
-version =3D "1.0.36"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208ac=
aca7"
-dependencies =3D [
- "proc-macro2",
-]
-
-[[package]]
-name =3D "syn"
-version =3D "2.0.66"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cd=
cff5"
-dependencies =3D [
- "proc-macro2",
- "quote",
- "unicode-ident",
-]
-
-[[package]]
-name =3D "unicode-ident"
-version =3D "1.0.12"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0f=
ee4b"
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.t=
oml
index 144cc3650fa..f8d6d03609f 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -20,6 +20,3 @@ proc-macro =3D true
 proc-macro2 =3D "1"
 quote =3D "1"
 syn =3D "2"
-
-# Do not include in any global workspace
-[workspace]
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
deleted file mode 100644
index e407911cdd1..00000000000
--- a/rust/qemu-api/Cargo.lock
+++ /dev/null
@@ -1,54 +0,0 @@
-# This file is automatically @generated by Cargo.
-# It is not intended for manual editing.
-version =3D 3
-
-[[package]]
-name =3D "proc-macro2"
-version =3D "1.0.84"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a=
49d6"
-dependencies =3D [
- "unicode-ident",
-]
-
-[[package]]
-name =3D "qemu_api"
-version =3D "0.1.0"
-dependencies =3D [
- "qemu_api_macros",
-]
-
-[[package]]
-name =3D "qemu_api_macros"
-version =3D "0.1.0"
-dependencies =3D [
- "proc-macro2",
- "quote",
- "syn",
-]
-
-[[package]]
-name =3D "quote"
-version =3D "1.0.36"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208ac=
aca7"
-dependencies =3D [
- "proc-macro2",
-]
-
-[[package]]
-name =3D "syn"
-version =3D "2.0.66"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cd=
cff5"
-dependencies =3D [
- "proc-macro2",
- "quote",
- "unicode-ident",
-]
-
-[[package]]
-name =3D "unicode-ident"
-version =3D "1.0.12"
-source =3D "registry+https://github.com/rust-lang/crates.io-index"
-checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0f=
ee4b"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db594c64083..e092f61e8f3 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,8 +20,5 @@ qemu_api_macros =3D { path =3D "../qemu-api-macros" }
 default =3D []
 allocator =3D []
=20
-# Do not include in any global workspace
-[workspace]
-
 [lints.rust]
 unexpected_cfgs =3D { level =3D "warn", check-cfg =3D ['cfg(MESON)', 'cfg(=
HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
--=20
2.47.0


