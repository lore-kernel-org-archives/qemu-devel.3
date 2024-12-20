Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC5DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1e-0004dL-6l; Fri, 20 Dec 2024 09:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1R-0004Tj-UM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1P-0006c2-OP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaco5xotTc07rSOEymQLIbqY1EI1Y0mpghelNUkIUoI=;
 b=ZqvN1yK9AH2ZhsKcfgc05eNSzg70h8mTVjScoMn59WkjYhyLAKnphlKGCE9bb8X76yckaZ
 sAwlKXFelJe05t+e61vUdOY8YaRHlFnh5zf2VCnB6grJOgAWuCeyEYgv9maB7LCliYvftb
 Ezqa4wvrFr0E09RWmFztYqIywlgYIzI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-rPTmgOc9OXK-RsQ4u-_h2w-1; Fri, 20 Dec 2024 09:30:29 -0500
X-MC-Unique: rPTmgOc9OXK-RsQ4u-_h2w-1
X-Mimecast-MFC-AGG-ID: rPTmgOc9OXK-RsQ4u-_h2w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361f371908so15248975e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705027; x=1735309827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaco5xotTc07rSOEymQLIbqY1EI1Y0mpghelNUkIUoI=;
 b=HEIE0d0DAY+v+bahKoh8QyoJ2zv8GnVyERSpGu2EU1v9OHqk/6rb80vzdprm+GCnWA
 9U8eMj/kIssFVWFGW5TTocNFbaDuhqxb+/2Ve9xGPUVgxOp6mZgkgem7GA9vco8Cec5x
 iP+hxnG9i/byffTEHTxavdgH7VLkZr0d8EYahvZJHpgWcT90fuJTtFy4qOEqUFa7eYLP
 6WUkjtUB/C68XxjC0k0mTdXM1GUsNSFZwOHudK6tjUBhuMg1qA3W0HZkdE74Z2EelJhr
 pCax2K4b2YBYMVSUV0njihsvQDigAYhwyQWeVdv2hfHBQNicXa4MMWnqC37xupbUQbj4
 X3JQ==
X-Gm-Message-State: AOJu0YwdPzdzZVsvcmMRM1FftcyzB4sPKjytTwwVGOUNbk9Vn7+jif2Z
 OrWS5UVMV4q6+WgVWjhbWP7Bd+wugiN618s4rNq9FVGhiCV5jyvSOu0ZbYJOHUUSs/TEFYlZF7m
 g3eJ8kzM6e29xjrwpgCpKtyxVhumpNc483GsnQXpaXFYOZ4ogHTPa+l1TRESiorCBXkpcOKKgPa
 oC0+Dv1dxbPiBbPKaVt7eEpY6IrivrqhpCjOpA
X-Gm-Gg: ASbGnctUmbDQiCvqyTB5EqmJOBaKp42K+PKMRta1pgz6lec3J3i5xKezMwP9FJzbT5r
 Vz6zaZtoobX+Nqy00+y6MPl2qpKaXwhmqZ8sghRg+gC2UAzmnVhit0lZ/+m/piwKltLca/xweEU
 4fXFEhH/DjR5PlVc9oHJGcpajUK47yA2W4DKOkfgUDU3Xm4cqoRQvMzMVzBe0I5MpNFXgsd45c/
 vhOA4GOldRzeUxXpX6WZQAym6L9223OqKQmGk+Yvg5wOuZpboknFqlz+7K2
X-Received: by 2002:a05:600c:4588:b0:434:fff1:1ade with SMTP id
 5b1f17b1804b1-4366864413dmr26655185e9.13.1734705026822; 
 Fri, 20 Dec 2024 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjwiZAwWz8CyvCKQsR4HIFv9MB5TCCSARFcJw+39WSfkTpj9Kyj1VStJv6YhhUnORDnMem6w==
X-Received: by 2002:a05:600c:4588:b0:434:fff1:1ade with SMTP id
 5b1f17b1804b1-4366864413dmr26654875e9.13.1734705026323; 
 Fri, 20 Dec 2024 06:30:26 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b1143dsm80478705e9.18.2024.12.20.06.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 12/12] rust: hide warnings for subprojects
Date: Fri, 20 Dec 2024 15:29:54 +0100
Message-ID: <20241220142955.652636-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This matches cargo's own usage of "--cap-lints allow" when building dependencies.

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


