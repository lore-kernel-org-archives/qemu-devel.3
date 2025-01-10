Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5534AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2W-0000MP-Dt; Fri, 10 Jan 2025 13:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2D-0000Fy-4E
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK28-00017h-NT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUb46DKoHBmGAkluDAsTMlpBG23EsSqfrfrjdnr3nng=;
 b=Q0Q3N5I9z9OuhsEd9QXAaROzXVdFShw391ZDoh60ECH1Z+Itqs/pvGHhesBEHeuRFZozSG
 9HulCmrmKvHw4bSDrsiGQaTgfHCCjtatCne3m0lugc4Dmn8+gJ5EOnmbtJNXLQZfVCHqMi
 nwDU8fIvoJW5KZiFPTcihg5ZcG643IA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-aJ7ayszdO5mmNLzzI4LZ6A-1; Fri, 10 Jan 2025 13:46:58 -0500
X-MC-Unique: aJ7ayszdO5mmNLzzI4LZ6A-1
X-Mimecast-MFC-AGG-ID: aJ7ayszdO5mmNLzzI4LZ6A
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso200696666b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534816; x=1737139616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUb46DKoHBmGAkluDAsTMlpBG23EsSqfrfrjdnr3nng=;
 b=sSZPPbjfkwdRupuDi/FdKxy5Rq64C4b8QeeBJLbEHqzMB8iJ2ly4XHc1eYYM8ykRKR
 /LIZYEs1n1pv97mr/cmowQpBMUXqrBBkdd+h2wJlYOp0a/XivKxuXz/vc8AXruO5Gbvl
 +W1CM7sUWLGezus4xIIYFlu6WJoDDwGxWj45P59v9B4dyEArub3BxK7pk6hgERGC5vm4
 5Dm0aHi+ImJhkE1ge+s9wavhB6QVG3RzlFlZkvPapRJdq8u322/OAJZZ5LOkixsw2B97
 hAwp5FJrkcL8IiAis2NlOVuXwpqGIDFTuKFcLNosqaAN1rhstKjTXY4u04DEg1Fm4zCw
 dxnQ==
X-Gm-Message-State: AOJu0YxmBlSYfeoT3u6NyvFWYTMfUUWySHEIiUlp6kGb+jeQ1Szb2QIE
 HxKYFvY631iKascR85LuIt9RZ9aoxIlutLOe8fpZ5lRng3H377C2/9bmUWfY8y9KfjjaJBg8GG8
 OmPv3mpJPz72pfVWviDcMAwV43pLECp+Y/KMHpCP7J/AwE/r769WxTer6FbvijJSQkl/wyjODkF
 zoozoGFwHpGtpYR00+E1S/pCJPnysk8ZK/xf6R1B4=
X-Gm-Gg: ASbGncvrzOfLNLeG7tUWJVNU0WF+64R8tVCdu0LioxQa4YZFWovrGZIOWFxZAvENn8r
 LeDykQRNw5Gus6zYr9uzTk5HsgS+zcudMONkZGsgxqPeZlaTs5v2NuN0Uyu4CzwRMRwn8pZ3yUt
 78ROm0qoDT2rpGK/KvmCHeqDIYjERrhNp3Yxo0cAaGbgp8JHXzY7HblCouRYZ8/9XlfywJuPaJV
 hJJ3PHA6OYoJlmQo50xzYjue0FwHEpZBU6+qNTyBKkMRuXJiK1sK07EB3Q=
X-Received: by 2002:a17:907:1a4f:b0:aaf:c27e:12e8 with SMTP id
 a640c23a62f3a-ab2abc78ab3mr786867266b.37.1736534815705; 
 Fri, 10 Jan 2025 10:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl8WNxoQIigC26olgCKQG4D3dx+ko3Ug3aFqe/B7ue5pu9kI0MxOysyqQu/bMNDKKEPdh2Ig==
X-Received: by 2002:a17:907:1a4f:b0:aaf:c27e:12e8 with SMTP id
 a640c23a62f3a-ab2abc78ab3mr786865166b.37.1736534815028; 
 Fri, 10 Jan 2025 10:46:55 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060bccsm192107166b.22.2025.01.10.10.46.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] rust: hide warnings for subprojects
Date: Fri, 10 Jan 2025 19:45:55 +0100
Message-ID: <20250110184620.408302-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This matches cargo's own usage of "--cap-lints allow" when building
dependencies.  The dummy changes to the .wrap files help Meson notice
that the subproject is out of date.

Also remove an unnecessary subprojects/unicode-ident-1-rs/meson.build file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/arbitrary-int-1-rs.wrap           |  3 +++
 subprojects/bilge-0.2-rs.wrap                 |  3 +++
 subprojects/bilge-impl-0.2-rs.wrap            |  3 +++
 subprojects/either-1-rs.wrap                  |  3 +++
 subprojects/itertools-0.11-rs.wrap            |  3 +++
 .../arbitrary-int-1-rs/meson.build            |  1 +
 .../packagefiles/bilge-0.2-rs/meson.build     |  1 +
 .../bilge-impl-0.2-rs/meson.build             |  1 +
 .../packagefiles/either-1-rs/meson.build      |  1 +
 .../itertools-0.11-rs/meson.build             |  1 +
 .../proc-macro-error-1-rs/meson.build         |  1 +
 .../proc-macro-error-attr-1-rs/meson.build    |  1 +
 .../packagefiles/proc-macro2-1-rs/meson.build |  1 +
 .../packagefiles/quote-1-rs/meson.build       |  1 +
 subprojects/packagefiles/syn-2-rs/meson.build |  1 +
 .../unicode-ident-1-rs/meson.build            |  1 +
 subprojects/proc-macro-error-1-rs.wrap        |  3 +++
 subprojects/proc-macro-error-attr-1-rs.wrap   |  3 +++
 subprojects/proc-macro2-1-rs.wrap             |  3 +++
 subprojects/quote-1-rs.wrap                   |  3 +++
 subprojects/syn-2-rs.wrap                     |  3 +++
 subprojects/unicode-ident-1-rs.wrap           |  3 +++
 subprojects/unicode-ident-1-rs/meson.build    | 20 -------------------
 23 files changed, 44 insertions(+), 20 deletions(-)
 delete mode 100644 subprojects/unicode-ident-1-rs/meson.build

diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
index e580538a877..a1838b20b0f 100644
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ b/subprojects/arbitrary-int-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = arbitrary-int-1.2.7.tar.gz
 source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
 #method = cargo
 patch_directory = arbitrary-int-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
index 7a4339d2989..900bb1497b9 100644
--- a/subprojects/bilge-0.2-rs.wrap
+++ b/subprojects/bilge-0.2-rs.wrap
@@ -5,3 +5,6 @@ source_filename = bilge-0.2.0.tar.gz
 source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
 #method = cargo
 patch_directory = bilge-0.2-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index b24c34a9043..d14c3dc769b 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -6,3 +6,6 @@ source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 #method = cargo
 patch_directory = bilge-impl-0.2-rs
 diff_files = bilge-impl-1.63.0.patch
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
index 6046712036c..352e11cfee6 100644
--- a/subprojects/either-1-rs.wrap
+++ b/subprojects/either-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = either-1.12.0.tar.gz
 source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
 #method = cargo
 patch_directory = either-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
index 66b05252cd5..ee12d0053bc 100644
--- a/subprojects/itertools-0.11-rs.wrap
+++ b/subprojects/itertools-0.11-rs.wrap
@@ -5,3 +5,6 @@ source_filename = itertools-0.11.0.tar.gz
 source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
 #method = cargo
 patch_directory = itertools-0.11-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index cff3f62ce74..00733d1faab 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -9,6 +9,7 @@ _arbitrary_int_rs = static_library(
   files('src/lib.rs'),
   gnu_symbol_visibility: 'hidden',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: ['--cap-lints', 'allow'],
   rust_abi: 'rust',
   dependencies: [],
 )
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index e69bac91b40..ce13d0fe80f 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -17,6 +17,7 @@ lib = static_library(
   'src/lib.rs',
   override_options : ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi : 'rust',
+  rust_args: ['--cap-lints', 'allow'],
   dependencies: [
     arbitrary_int_dep,
     bilge_impl_dep,
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index f8f3486fc08..42b03dcd53c 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -25,6 +25,7 @@ _bilge_impl_rs = rust.proc_macro(
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"',
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index 608e64e31fc..04c96cc5fb3 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -11,6 +11,7 @@ _either_rs = static_library(
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'feature="use_std"',
     '--cfg', 'feature="use_alloc"',
   ],
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 30982a4ee76..2a3fbe9ee5a 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -15,6 +15,7 @@ _itertools_rs = static_library(
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'feature="use_std"',
     '--cfg', 'feature="use_alloc"',
   ],
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index ae27a696862..10c2741085c 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -20,6 +20,7 @@ _proc_macro_error_rs = static_library(
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"',
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index 3281b264333..c4c4c5e397c 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -16,6 +16,7 @@ _proc_macro_error_attr_rs = rust.proc_macro(
   files('src/lib.rs'),
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
     '--cfg', 'feature="proc-macro"'
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index f9c8675ebad..5759df3ecc9 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -15,6 +15,7 @@ _proc_macro2_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'feature="proc-macro"',
     '--cfg', 'no_literal_byte_character',
     '--cfg', 'no_literal_c_string',
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index 7f7792569b9..bf41fad99bb 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -15,6 +15,7 @@ _quote_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index 2c62cf7e1b0..a0094174084 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -19,6 +19,7 @@ _syn_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: [
+    '--cap-lints', 'allow',
     '--cfg', 'feature="full"',
     '--cfg', 'feature="derive"',
     '--cfg', 'feature="parsing"',
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 9d76ebbd1ad..11a5dab97df 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -10,6 +10,7 @@ _unicode_ident_rs = static_library(
   gnu_symbol_visibility: 'hidden',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
+  rust_args: ['--cap-lints', 'allow'],
   dependencies: [],
   native: true,
 )
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
index b7db03b06a0..59f892f7825 100644
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ b/subprojects/proc-macro-error-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = proc-macro-error-1.0.4.tar.gz
 source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
 #method = cargo
 patch_directory = proc-macro-error-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
index d13d8a239ac..5aeb224a103 100644
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ b/subprojects/proc-macro-error-attr-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = proc-macro-error-attr-1.0.4.tar.gz
 source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
 #method = cargo
 patch_directory = proc-macro-error-attr-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 7053e2c013c..6c9369f0df3 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = proc-macro2-1.0.84.0.tar.gz
 source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
 #method = cargo
 patch_directory = proc-macro2-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
index 6e7ea69049f..8b721dfa00b 100644
--- a/subprojects/quote-1-rs.wrap
+++ b/subprojects/quote-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = quote-1.0.36.0.tar.gz
 source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
 #method = cargo
 patch_directory = quote-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index 13ffdac3c3b..d79cf750fb4 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -5,3 +5,6 @@ source_filename = syn-2.0.66.0.tar.gz
 source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
 #method = cargo
 patch_directory = syn-2-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
index 4609f96ed97..50988f612e2 100644
--- a/subprojects/unicode-ident-1-rs.wrap
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = unicode-ident-1.0.12.tar.gz
 source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
 #method = cargo
 patch_directory = unicode-ident-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/unicode-ident-1-rs/meson.build b/subprojects/unicode-ident-1-rs/meson.build
deleted file mode 100644
index 54f23768545..00000000000
--- a/subprojects/unicode-ident-1-rs/meson.build
+++ /dev/null
@@ -1,20 +0,0 @@
-project('unicode-ident-1-rs', 'rust',
-  version: '1.0.12',
-  license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
-  default_options: [])
-
-_unicode_ident_rs = static_library(
-  'unicode_ident',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [],
-  native: true,
-)
-
-unicode_ident_dep = declare_dependency(
-  link_with: _unicode_ident_rs,
-)
-
-meson.override_dependency('unicode-ident-1-rs', unicode_ident_dep, native: true)
-- 
2.47.1


