Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBECCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo37-0007Ot-Rk; Tue, 26 May 2026 05:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo35-0007M3-8r
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo30-00074J-BN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Plya1n2YtQ+n/HgAugBpezfsNZoVuzRmB8eN/v9e9Hc=;
 b=ZZdmKfwctZW0Pptdl0bOchUxkzSxq+HgKeEWxaTjib2tfCyzoTKvi6NhWgtLQ/XOdbDK0u
 e98AeafHjUKovd9oCACVU6AFkHKNbL0O7bpyW2HGTf1rcB8Z7eKCq62olZFIOUG0NrY7oJ
 KR5evyK6nAhe/0ZdTb2+oXoduGoIJoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ClmCfUYUPPqwdhiPTU0a2w-1; Tue, 26 May 2026 05:25:55 -0400
X-MC-Unique: ClmCfUYUPPqwdhiPTU0a2w-1
X-Mimecast-MFC-AGG-ID: ClmCfUYUPPqwdhiPTU0a2w_1779787555
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49051422d55so29552205e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787555; x=1780392355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Plya1n2YtQ+n/HgAugBpezfsNZoVuzRmB8eN/v9e9Hc=;
 b=DwARCPhT8oBxCd2U+Zbar5aIKcDOn+lFzhERpE4io57l83bldoFiQwfWK/HjG/Z6TW
 FVwdi9IflZqbqK7FwchiZQG2gJyCdNcV6cxmSYCgk++4VdRIzCiQzsNxiYHsrTV1QAsi
 U2VyLRzojtfYAg/rgrizbqSHclt69teWRq9s2im5LA+JEa8JG60BrJJVgS0D44aFXCbK
 ExZDjEwgPCRIh4shf74RCItq4xbEWBmQLcW0mekiXcKfeZfvxUHPpQfT6+55GrjI1bhM
 EO1umi/AOa3tImQEFNR45mEV/VdGMeZk//5AwGA245WWFEZmB6EXb7L3LgNeYZAOEtZw
 3tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787555; x=1780392355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Plya1n2YtQ+n/HgAugBpezfsNZoVuzRmB8eN/v9e9Hc=;
 b=sQLRse5Z18FRS0ZXgtRwusVuHFl3P9IhjucV0GenJLr7FB4xh06vU64ghgNBJQHNlk
 H7E0aQlBJpTS4f0vsaBaGwdmTxssCWlkMDr5EJhp0gWgNv25R0JeYnqVGjAvPFjghM8z
 hSgHUzCFWMz9xhzqj0s3cl4q3NpxbmtPkO+5glDkha2YS7+j5QM6YTCZG2Z/sE0+KPoD
 Xa3d5Z6GKk2DvkqrZeMMJKCDny+ZUZJot0hRNontGTGCo7wlfhdtH7Cxoz1uk9s2pF7V
 +c+gUCuFtv+CT9B7POEzUWV7JUzE6ADt9092L+L3H/RkxMKKy8uwmFy+Q3fNisXNDZXW
 9L/Q==
X-Gm-Message-State: AOJu0Yz5dbfTcr/6n6EB+IlGNUbGNehNkIO6D4emGFDzb3c8oQvVnnGl
 EgTiDwMmQ6MOs15eimnRHfLAW+mKXNFEKXJxzWWfqBCy31IlZCOxTVLvAKoFavZ/St3XnnaMKr8
 M9A9h2qtFxXep0CZH4BHonPy5IZioOni4ShKtxeyJYmhAwIObo0a64Xd+kqeGUUtLNb34kXD3/v
 kPUcpkFLr6Ctj6t2dr7OgZEwnMpxI1AY7qbp90nztm
X-Gm-Gg: Acq92OFA5SFWXzfn0rwj1pysbc0v+3Np1FGeWG91dLDqWIJHyGqp0/FHNxu7yItEOGB
 xEBdM+iyh81qb5up8LEgtANsAUGU+3SjmoLEmp6nBTKIt/EPRkfoRDTWzELLMGbZy4rt7EwGYcl
 vXIxqOSnML3FXMcsEKIUmFl3vzUWQQp5iRPm2nc38nwTI0Af5FB67wEILvjvSRz848enObhzgtC
 RG0VdVP0sjyTi416CgO0y3Id8diKmjMaQlp2JPK4dmiPqmLMMSCGBq7Knb6q63KevPynoNJ2YNV
 Hw900LBhDU90wIwS6ei9mNpjy4iOud0mDB6NSzEy9kTch+PfyLFBhBqu+HF/TPfH0fKqLewcl4W
 BAdvi94lo50GT3ngtb0G4T7lLlTN/j2ElIR7gUwqWWASfm4e5Vy1/DKxc4OGeuefg53k6FrZ2v9
 ksMylNISjWnced8Ve+fB8Y3LuO8YaHka9aHM0/vg==
X-Received: by 2002:a05:600c:4e43:b0:48f:e230:2a1d with SMTP id
 5b1f17b1804b1-49042ae77b4mr312964255e9.32.1779787554105; 
 Tue, 26 May 2026 02:25:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e43:b0:48f:e230:2a1d with SMTP id
 5b1f17b1804b1-49042ae77b4mr312962725e9.32.1779787552923; 
 Tue, 26 May 2026 02:25:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428e5adcsm117301565e9.21.2026.05.26.02.25.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] rust: switch to autogenerated meson rules
Date: Tue, 26 May 2026 11:25:42 +0200
Message-ID: <20260526092546.149241-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Meson can automatically generate most of the build rules for
subprojects, based on the contents of their Cargo.toml.  Handwritten
snippets can be placed in meson/meson.build to replace build.rs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/rs_types.py                      |  2 +-
 subprojects/arbitrary-int-1-rs.wrap           |  1 -
 subprojects/attrs-0.2-rs.wrap                 |  1 -
 subprojects/bilge-0.2-rs.wrap                 |  1 -
 subprojects/either-1-rs.wrap                  |  1 -
 subprojects/foreign-0.3-rs.wrap               |  1 -
 subprojects/glib-sys-0.21-rs.wrap             |  1 -
 subprojects/itertools-0.11-rs.wrap            |  1 -
 .../packagefiles/anyhow-1-rs/meson.build      | 33 --------------
 .../anyhow-1-rs/meson/meson.build             |  9 ++++
 .../arbitrary-int-1-rs/meson.build            | 21 ---------
 .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------------
 .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------------
 .../bilge-impl-0.2-rs/meson.build             | 44 -------------------
 .../bilge-impl-0.2-rs/meson/meson.build       |  3 ++
 .../packagefiles/either-1-rs/meson.build      | 26 -----------
 .../packagefiles/foreign-0.3-rs/meson.build   | 26 -----------
 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------------
 .../itertools-0.11-rs/meson.build             | 32 --------------
 .../packagefiles/libc-0.2-rs/meson.build      | 37 ----------------
 .../libc-0.2-rs/meson/meson.build             | 16 +++++++
 .../proc-macro-error-1-rs/meson.build         | 41 -----------------
 .../proc-macro-error-1-rs/meson/meson.build   |  3 ++
 .../proc-macro-error-attr-1-rs/meson.build    | 31 -------------
 .../meson/meson.build                         |  3 ++
 .../packagefiles/proc-macro2-1-rs/meson.build | 35 ---------------
 .../proc-macro2-1-rs/meson/meson.build        |  6 +++
 .../packagefiles/quote-1-rs/meson.build       | 31 -------------
 .../packagefiles/serde-1-rs/meson.build       | 36 ---------------
 .../packagefiles/serde_core-1-rs/meson.build  | 25 -----------
 .../serde_core-1-rs/private.rs.in             |  6 +++
 .../serde_derive-1-rs/meson.build             | 35 ---------------
 subprojects/packagefiles/syn-2-rs/meson.build | 43 ------------------
 .../unicode-ident-1-rs/meson.build            | 22 ----------
 subprojects/probe-0.5-rs.wrap                 |  1 -
 subprojects/quote-1-rs.wrap                   |  1 -
 subprojects/serde-1-rs.wrap                   |  1 -
 subprojects/serde_core-1-rs.wrap              |  1 -
 subprojects/serde_derive-1-rs.wrap            |  1 -
 subprojects/syn-2-rs.wrap                     |  1 -
 subprojects/unicode-ident-1-rs.wrap           |  1 -
 41 files changed, 47 insertions(+), 630 deletions(-)
 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_core-1-rs/private.rs.in
 delete mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build

diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
index e24f14af03d..3a8cf0e3e4b 100644
--- a/scripts/qapi/rs_types.py
+++ b/scripts/qapi/rs_types.py
@@ -348,7 +348,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
 // that *could* be Eq too.
 #![allow(clippy::derive_partial_eq_without_eq)]
 
-use serde_derive::{Serialize, Deserialize};
+use serde::{Serialize, Deserialize};
 
 use util::qobject::QObject;
 '''))
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
index f8d7c68da64..5cf4b11e4a3 100644
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ b/subprojects/arbitrary-int-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
 source_filename = arbitrary-int-1.2.7.tar.gz
 source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
 method = cargo
-patch_directory = arbitrary-int-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/attrs-0.2-rs.wrap b/subprojects/attrs-0.2-rs.wrap
index 99d2e43fb3b..dcdddf005f6 100644
--- a/subprojects/attrs-0.2-rs.wrap
+++ b/subprojects/attrs-0.2-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
 source_filename = attrs-0.2.9.tar.gz
 source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
 method = cargo
-patch_directory = attrs-0.2-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
index cb202cfd9fe..cff10f6710d 100644
--- a/subprojects/bilge-0.2-rs.wrap
+++ b/subprojects/bilge-0.2-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
 source_filename = bilge-0.2.0.tar.gz
 source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
 method = cargo
-patch_directory = bilge-0.2-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
index b70787d882e..d2808d3d7fb 100644
--- a/subprojects/either-1-rs.wrap
+++ b/subprojects/either-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/either/1.12.0/download
 source_filename = either-1.12.0.tar.gz
 source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
 method = cargo
-patch_directory = either-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v3
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
index bae22b1f2a3..e4aa7f11fc0 100644
--- a/subprojects/foreign-0.3-rs.wrap
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
 source_filename = foreign-0.3.1.tar.gz
 source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
 method = cargo
-patch_directory = foreign-0.3-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
index af849352a38..4723f7f63be 100644
--- a/subprojects/glib-sys-0.21-rs.wrap
+++ b/subprojects/glib-sys-0.21-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
 source_filename = glib-sys-0.21.2.tar.gz
 source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
 method = cargo
-patch_directory = glib-sys-0.21-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
index b52a2314340..fc63e2f57d9 100644
--- a/subprojects/itertools-0.11-rs.wrap
+++ b/subprojects/itertools-0.11-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
 source_filename = itertools-0.11.0.tar.gz
 source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
 method = cargo
-patch_directory = itertools-0.11-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v3
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson.build
deleted file mode 100644
index 348bab98b9f..00000000000
--- a/subprojects/packagefiles/anyhow-1-rs/meson.build
+++ /dev/null
@@ -1,33 +0,0 @@
-project('anyhow-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.98',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-rustc = meson.get_compiler('rust')
-
-rust_args = ['--cap-lints', 'allow']
-rust_args += ['--cfg', 'feature="std"']
-if rustc.version().version_compare('<1.65.0')
-  error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.65.0')
-endif
-rust_args += [ '--cfg', 'std_backtrace' ] # >= 1.65.0
-if rustc.version().version_compare('<1.81.0')
-  rust_args += [ '--cfg', 'anyhow_no_core_error' ]
-endif
-
-_anyhow_rs = static_library(
-  'anyhow',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: rust_args,
-  dependencies: [],
-)
-
-anyhow_dep = declare_dependency(
-  link_with: _anyhow_rs,
-)
-
-meson.override_dependency('anyhow-1-rs', anyhow_dep)
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson/meson.build
new file mode 100644
index 00000000000..91c46539c31
--- /dev/null
+++ b/subprojects/packagefiles/anyhow-1-rs/meson/meson.build
@@ -0,0 +1,9 @@
+rustc = meson.get_compiler('rust')
+
+if rustc.version().version_compare('<1.65.0')
+  error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.65.0')
+endif
+extra_args += [ '--cfg', 'std_backtrace' ] # >= 1.65.0
+if rustc.version().version_compare('<1.81.0')
+  extra_args += [ '--cfg', 'anyhow_no_core_error' ]
+endif
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
deleted file mode 100644
index 00733d1faab..00000000000
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ /dev/null
@@ -1,21 +0,0 @@
-project('arbitrary-int-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.2.7',
-  license: 'MIT',
-  default_options: [])
-
-_arbitrary_int_rs = static_library(
-  'arbitrary_int',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: ['--cap-lints', 'allow'],
-  rust_abi: 'rust',
-  dependencies: [],
-)
-
-arbitrary_int_dep = declare_dependency(
-  link_with: _arbitrary_int_rs,
-)
-
-meson.override_dependency('arbitrary-int-1-rs', arbitrary_int_dep)
diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subprojects/packagefiles/attrs-0.2-rs/meson.build
deleted file mode 100644
index ee575476cb2..00000000000
--- a/subprojects/packagefiles/attrs-0.2-rs/meson.build
+++ /dev/null
@@ -1,33 +0,0 @@
-project('attrs-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.2.9',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro2-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-
-_attrs_rs = static_library(
-  'attrs',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-  dependencies: [
-    proc_macro2_dep,
-    syn_dep,
-  ],
-  native: true,
-)
-
-attrs_dep = declare_dependency(
-  link_with: _attrs_rs,
-)
-
-meson.override_dependency('attrs-0.2-rs', attrs_dep, native: true)
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
deleted file mode 100644
index ce13d0fe80f..00000000000
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ /dev/null
@@ -1,31 +0,0 @@
-project(
-  'bilge-0.2-rs',
-  'rust',
-  meson_version: '>=1.5.0',
-  version : '0.2.0',
-  license : 'MIT or Apache-2.0',
-)
-
-subproject('arbitrary-int-1-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-
-arbitrary_int_dep = dependency('arbitrary-int-1-rs')
-bilge_impl_dep = dependency('bilge-impl-0.2-rs')
-
-lib = static_library(
-  'bilge',
-  'src/lib.rs',
-  override_options : ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi : 'rust',
-  rust_args: ['--cap-lints', 'allow'],
-  dependencies: [
-    arbitrary_int_dep,
-    bilge_impl_dep,
-  ],
-)
-
-bilge_dep = declare_dependency(
-  link_with : [lib],
-)
-
-meson.override_dependency('bilge-0.2-rs', bilge_dep)
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
deleted file mode 100644
index 04617b875c5..00000000000
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ /dev/null
@@ -1,44 +0,0 @@
-project('bilge-impl-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.2.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('itertools-0.11-rs', required: true)
-subproject('proc-macro-error-attr-1-rs', required: true)
-subproject('proc-macro-error-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('proc-macro2-1-rs', required: true)
-
-itertools_dep = dependency('itertools-0.11-rs', native: true)
-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs', native: true)
-proc_macro_error_dep = dependency('proc-macro-error-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
-rust = import('rust')
-
-_bilge_impl_rs = rust.proc_macro(
-  'bilge_impl',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-  dependencies: [
-    itertools_dep,
-    proc_macro_error_attr_dep,
-    proc_macro_error_dep,
-    quote_dep,
-    syn_dep,
-    proc_macro2_dep,
-  ],
-)
-
-bilge_impl_dep = declare_dependency(
-  link_with: _bilge_impl_rs,
-)
-
-meson.override_dependency('bilge-impl-0.2-rs', bilge_impl_dep)
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build
new file mode 100644
index 00000000000..d8961d602e8
--- /dev/null
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build
@@ -0,0 +1,3 @@
+extra_args += [
+  '--cfg', 'use_fallback',
+]
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
deleted file mode 100644
index 04c96cc5fb3..00000000000
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ /dev/null
@@ -1,26 +0,0 @@
-project('either-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.12.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-_either_rs = static_library(
-  'either',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="use_std"',
-    '--cfg', 'feature="use_alloc"',
-  ],
-  dependencies: [],
-  native: true,
-)
-
-either_dep = declare_dependency(
-  link_with: _either_rs,
-)
-
-meson.override_dependency('either-1-rs', either_dep, native: true)
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
deleted file mode 100644
index 0901c02c527..00000000000
--- a/subprojects/packagefiles/foreign-0.3-rs/meson.build
+++ /dev/null
@@ -1,26 +0,0 @@
-project('foreign-0.3-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.2.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('libc-0.2-rs', required: true)
-libc_rs = dependency('libc-0.2-rs')
-
-_foreign_rs = static_library(
-  'foreign',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-  dependencies: [libc_rs],
-)
-
-foreign_dep = declare_dependency(
-  link_with: _foreign_rs,
-)
-
-meson.override_dependency('foreign-0.3-rs', foreign_dep)
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
deleted file mode 100644
index 8c5483311ed..00000000000
--- a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
+++ /dev/null
@@ -1,33 +0,0 @@
-project('glib-sys-0.21-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.21.2',
-  license: 'MIT',
-  default_options: [])
-
-subproject('libc-0.2-rs', required: true)
-libc_rs = dependency('libc-0.2-rs')
-
-_glib_sys_rs = static_library(
-  'glib_sys',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="v2_66"',
-    '--cfg', 'feature="v2_64"',
-    '--cfg', 'feature="v2_62"',
-    '--cfg', 'feature="v2_60"',
-    '--cfg', 'feature="v2_58"',
-  ],
-  # should also link with glib; don't bother doing it here since all
-  # QEMU targets have it
-  dependencies: [libc_rs],
-)
-
-glib_sys_dep = declare_dependency(
-  link_with: _glib_sys_rs,
-)
-
-meson.override_dependency('glib-sys-0.21-rs', glib_sys_dep)
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
deleted file mode 100644
index 2a3fbe9ee5a..00000000000
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ /dev/null
@@ -1,32 +0,0 @@
-project('itertools-0.11-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.11.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('either-1-rs', required: true)
-
-either_dep = dependency('either-1-rs', native: true)
-
-_itertools_rs = static_library(
-  'itertools',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="use_std"',
-    '--cfg', 'feature="use_alloc"',
-  ],
-  dependencies: [
-    either_dep,
-  ],
-  native: true,
-)
-
-itertools_dep = declare_dependency(
-  link_with: _itertools_rs,
-)
-
-meson.override_dependency('itertools-0.11-rs', itertools_dep, native: true)
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
deleted file mode 100644
index ac4f80dba98..00000000000
--- a/subprojects/packagefiles/libc-0.2-rs/meson.build
+++ /dev/null
@@ -1,37 +0,0 @@
-project('libc-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.2.162',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-_libc_rs = static_library(
-  'libc',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2015', 'build.rust_std=2015'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'freebsd11',
-    '--cfg', 'libc_priv_mod_use',
-    '--cfg', 'libc_union',
-    '--cfg', 'libc_const_size_of',
-    '--cfg', 'libc_align',
-    '--cfg', 'libc_int128',
-    '--cfg', 'libc_core_cvoid',
-    '--cfg', 'libc_packedN',
-    '--cfg', 'libc_cfg_target_vendor',
-    '--cfg', 'libc_non_exhaustive',
-    '--cfg', 'libc_long_array',
-    '--cfg', 'libc_ptr_addr_of',
-    '--cfg', 'libc_underscore_const_names',
-    '--cfg', 'libc_const_extern_fn',
-  ],
-  dependencies: [],
-)
-
-libc_dep = declare_dependency(
-  link_with: _libc_rs,
-)
-
-meson.override_dependency('libc-0.2-rs', libc_dep)
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson/meson.build
new file mode 100644
index 00000000000..db9480ada1c
--- /dev/null
+++ b/subprojects/packagefiles/libc-0.2-rs/meson/meson.build
@@ -0,0 +1,16 @@
+extra_args += [
+    '--cfg', 'freebsd11',
+    '--cfg', 'libc_priv_mod_use',
+    '--cfg', 'libc_union',
+    '--cfg', 'libc_const_size_of',
+    '--cfg', 'libc_align',
+    '--cfg', 'libc_int128',
+    '--cfg', 'libc_core_cvoid',
+    '--cfg', 'libc_packedN',
+    '--cfg', 'libc_cfg_target_vendor',
+    '--cfg', 'libc_non_exhaustive',
+    '--cfg', 'libc_long_array',
+    '--cfg', 'libc_ptr_addr_of',
+    '--cfg', 'libc_underscore_const_names',
+    '--cfg', 'libc_const_extern_fn',
+]
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
deleted file mode 100644
index 8ba558e1330..00000000000
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ /dev/null
@@ -1,41 +0,0 @@
-project('proc-macro-error-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.4',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro-error-attr-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('proc-macro2-1-rs', required: true)
-
-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-
-_proc_macro_error_rs = static_library(
-  'proc_macro_error',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '-A', 'non_fmt_panics'
-  ],
-  dependencies: [
-    proc_macro_error_attr_dep,
-    proc_macro2_dep,
-    quote_dep,
-    syn_dep,
-  ],
-  native: true,
-)
-
-proc_macro_error_dep = declare_dependency(
-  link_with: _proc_macro_error_rs,
-)
-
-meson.override_dependency('proc-macro-error-1-rs', proc_macro_error_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
new file mode 100644
index 00000000000..52a244d2b16
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
@@ -0,0 +1,3 @@
+extra_args = [
+    '--cfg', 'use_fallback',
+]
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
deleted file mode 100644
index a85d7c07143..00000000000
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ /dev/null
@@ -1,31 +0,0 @@
-project('proc-macro-error-attr-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.12.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-
-rust = import('rust')
-_proc_macro_error_attr_rs = rust.proc_macro(
-  'proc_macro_error_attr',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-  dependencies: [
-    proc_macro2_dep,
-    quote_dep,
-  ],
-)
-
-proc_macro_error_attr_dep = declare_dependency(
-  link_with: _proc_macro_error_attr_rs,
-)
-
-meson.override_dependency('proc-macro-error-attr-1-rs', proc_macro_error_attr_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build
new file mode 100644
index 00000000000..a80aee2b382
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build
@@ -0,0 +1,3 @@
+extra_args += [
+    '--cfg', 'use_fallback',
+]
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
deleted file mode 100644
index ba7de070292..00000000000
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ /dev/null
@@ -1,35 +0,0 @@
-project('proc-macro2-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.95',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('unicode-ident-1-rs', required: true)
-
-unicode_ident_dep = dependency('unicode-ident-1-rs', native: true)
-
-_proc_macro2_rs = static_library(
-  'proc_macro2',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="proc-macro"',
-    '--cfg', 'no_literal_byte_character',
-    '--cfg', 'no_literal_c_string',
-    '--cfg', 'no_source_text',
-    '--cfg', 'wrap_proc_macro',
-  ],
-  dependencies: [
-    unicode_ident_dep,
-  ],
-  native: true,
-)
-
-proc_macro2_dep = declare_dependency(
-  link_with: _proc_macro2_rs,
-)
-
-meson.override_dependency('proc-macro2-1-rs', proc_macro2_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
new file mode 100644
index 00000000000..09712bb0b0e
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
@@ -0,0 +1,6 @@
+extra_args = [
+    '--cfg', 'no_literal_byte_character',
+    '--cfg', 'no_literal_c_string',
+    '--cfg', 'no_source_text',
+    '--cfg', 'wrap_proc_macro',
+]
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
deleted file mode 100644
index bf41fad99bb..00000000000
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ /dev/null
@@ -1,31 +0,0 @@
-project('quote-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.12.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro2-1-rs', required: true)
-
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
-_quote_rs = static_library(
-  'quote',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="proc-macro"',
-  ],
-  dependencies: [
-    proc_macro2_dep,
-  ],
-  native: true,
-)
-
-quote_dep = declare_dependency(
-  link_with: _quote_rs,
-)
-
-meson.override_dependency('quote-1-rs', quote_dep, native: true)
diff --git a/subprojects/packagefiles/serde-1-rs/meson.build b/subprojects/packagefiles/serde-1-rs/meson.build
deleted file mode 100644
index 775e0120f24..00000000000
--- a/subprojects/packagefiles/serde-1-rs/meson.build
+++ /dev/null
@@ -1,36 +0,0 @@
-project('serde-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.226',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('serde_core-1-rs', required: true)
-subproject('serde_derive-1-rs', required: true)
-
-serde_core_dep = dependency('serde_core-1-rs')
-serde_derive_dep = dependency('serde_derive-1-rs')
-
-_serde_rs = static_library(
-  'serde',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="alloc"',
-    '--cfg', 'feature="std"',
-    '--cfg', 'feature="derive"',
-  ],
-  dependencies: [
-    serde_core_dep,
-    serde_derive_dep,
-  ]
-)
-
-serde_dep = declare_dependency(
-  link_with: _serde_rs,
-  dependencies: serde_derive_dep,
-)
-
-meson.override_dependency('serde-1-rs', serde_dep)
diff --git a/subprojects/packagefiles/serde_core-1-rs/meson.build b/subprojects/packagefiles/serde_core-1-rs/meson.build
deleted file mode 100644
index 79c36f6b70e..00000000000
--- a/subprojects/packagefiles/serde_core-1-rs/meson.build
+++ /dev/null
@@ -1,25 +0,0 @@
-project('serde_core-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.226',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-_serde_core_rs = static_library(
-  'serde_core',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="alloc"',
-    '--cfg', 'feature="result"',
-    '--cfg', 'feature="std"',
-  ],
-)
-
-serde_core_dep = declare_dependency(
-  link_with: _serde_core_rs,
-)
-
-meson.override_dependency('serde_core-1-rs', serde_core_dep)
diff --git a/subprojects/packagefiles/serde_core-1-rs/private.rs.in b/subprojects/packagefiles/serde_core-1-rs/private.rs.in
new file mode 100644
index 00000000000..2f8155c2a80
--- /dev/null
+++ b/subprojects/packagefiles/serde_core-1-rs/private.rs.in
@@ -0,0 +1,6 @@
+#[doc(hidden)]
+pub mod __private@CARGO_PKG_VERSION_PATCH@ {
+    #[doc(hidden)]
+    pub use crate::private::*;
+}
+
diff --git a/subprojects/packagefiles/serde_derive-1-rs/meson.build b/subprojects/packagefiles/serde_derive-1-rs/meson.build
deleted file mode 100644
index 6c1001a844a..00000000000
--- a/subprojects/packagefiles/serde_derive-1-rs/meson.build
+++ /dev/null
@@ -1,35 +0,0 @@
-project('serde_derive-1-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '1.0.226',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('proc-macro2-1-rs', required: true)
-
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
-rust = import('rust')
-
-_serde_derive_rs = rust.proc_macro(
-  'serde_derive',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-  dependencies: [
-    quote_dep,
-    syn_dep,
-    proc_macro2_dep,
-  ],
-)
-
-serde_derive_dep = declare_dependency(
-  link_with: _serde_derive_rs,
-)
-
-meson.override_dependency('serde_derive-1-rs', serde_derive_dep)
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
deleted file mode 100644
index 3e6dc318a9c..00000000000
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ /dev/null
@@ -1,43 +0,0 @@
-project('syn-2-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '2.0.104',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('unicode-ident-1-rs', required: true)
-
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-unicode_ident_dep = dependency('unicode-ident-1-rs', native: true)
-
-_syn_rs = static_library(
-  'syn',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-    '--cfg', 'feature="full"',
-    '--cfg', 'feature="derive"',
-    '--cfg', 'feature="parsing"',
-    '--cfg', 'feature="printing"',
-    '--cfg', 'feature="clone-impls"',
-    '--cfg', 'feature="proc-macro"',
-    '--cfg', 'feature="extra-traits"',
-  ],
-  dependencies: [
-    quote_dep,
-    proc_macro2_dep,
-    unicode_ident_dep,
-  ],
-  native: true,
-)
-
-syn_dep = declare_dependency(
-  link_with: _syn_rs,
-)
-
-meson.override_dependency('syn-2-rs', syn_dep, native: true)
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
deleted file mode 100644
index 11a5dab97df..00000000000
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ /dev/null
@@ -1,22 +0,0 @@
-project('unicode-ident-1-rs', 'rust',
-  meson_version: '>=1.5.0',
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
-  rust_args: ['--cap-lints', 'allow'],
-  dependencies: [],
-  native: true,
-)
-
-unicode_ident_dep = declare_dependency(
-  link_with: _unicode_ident_rs,
-)
-
-meson.override_dependency('unicode-ident-1-rs', unicode_ident_dep, native: true)
diff --git a/subprojects/probe-0.5-rs.wrap b/subprojects/probe-0.5-rs.wrap
index bd23c0ea789..035da86c46a 100644
--- a/subprojects/probe-0.5-rs.wrap
+++ b/subprojects/probe-0.5-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
 source_filename = probe-0.5.2.tar.gz
 source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
 method = cargo
-patch_directory = probe-0.5-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v1
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
index dab58490a4f..80d5ea84f54 100644
--- a/subprojects/quote-1-rs.wrap
+++ b/subprojects/quote-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
 source_filename = quote-1.0.36.0.tar.gz
 source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
 method = cargo
-patch_directory = quote-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v3
diff --git a/subprojects/serde-1-rs.wrap b/subprojects/serde-1-rs.wrap
index 9792592d480..801f11efd1f 100644
--- a/subprojects/serde-1-rs.wrap
+++ b/subprojects/serde-1-rs.wrap
@@ -5,7 +5,6 @@ source_filename = serde-1.0.226.0.tar.gz
 source_hash = 0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd
 method = cargo
 diff_files = serde-1.0.226-include.patch
-patch_directory = serde-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/serde_core-1-rs.wrap b/subprojects/serde_core-1-rs.wrap
index ff2e59430b1..6c2919871e1 100644
--- a/subprojects/serde_core-1-rs.wrap
+++ b/subprojects/serde_core-1-rs.wrap
@@ -5,7 +5,6 @@ source_filename = serde_core-1.0.226.0.tar.gz
 source_hash = ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4
 method = cargo
 diff_files = serde_core-1.0.226-include.patch
-patch_directory = serde_core-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/serde_derive-1-rs.wrap b/subprojects/serde_derive-1-rs.wrap
index ed345a7f840..9fb96c5e336 100644
--- a/subprojects/serde_derive-1-rs.wrap
+++ b/subprojects/serde_derive-1-rs.wrap
@@ -5,7 +5,6 @@ source_filename = serde_derive-1.0.226.0.tar.gz
 source_hash = 8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33
 method = cargo
 diff_files = serde_derive-1.0.226-include.patch
-patch_directory = serde_derive-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index 4b545c7980c..8ec7fd00528 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
 source_filename = syn-2.0.104.0.tar.gz
 source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
 method = cargo
-patch_directory = syn-2-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v3
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
index 0a5e097953e..0495b3912f1 100644
--- a/subprojects/unicode-ident-1-rs.wrap
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
 source_filename = unicode-ident-1.0.12.tar.gz
 source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
 method = cargo
-patch_directory = unicode-ident-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v3
-- 
2.54.0


