Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41651D116F5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwA-0006SV-92; Thu, 27 Nov 2025 08:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvW-0005PK-OO
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvV-00025V-1z
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaYCRt73TI4IZiG0ulxDoPHXWEJqElWgR2PIBolMkYo=;
 b=M48N8RoutlfeDCJKpVPgiERyJmAKUmb6ccF+RVqh29OpFPA3kPmb+rD9yXL3r9+vFQRafn
 knCgd7UQZs6ipYfuqdFROnHdZZDG4NTXkHLySDPqVSmo67Cgu1bWvIvj8XaI8wP7pajyNE
 i3MHZ7AnflhlTQUZKic+97JuEG3iaos=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-TKFTVYLLN4K3n-xAr0w5-w-1; Thu, 27 Nov 2025 08:20:46 -0500
X-MC-Unique: TKFTVYLLN4K3n-xAr0w5-w-1
X-Mimecast-MFC-AGG-ID: TKFTVYLLN4K3n-xAr0w5-w_1764249646
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b7689ad588fso84306966b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249644; x=1764854444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaYCRt73TI4IZiG0ulxDoPHXWEJqElWgR2PIBolMkYo=;
 b=NHl2URTd6DyRw2vJaGoscf5M7j5QfRwCKFxK1o9yRcODEbttr/u+sc/eALSquyz/6p
 myx6kFpeMBZBiMwNb+hu5xyT8461jgmZbKeJEz0V7NnDLL0AdBu1tq3+KkQidrfUjfNR
 OPInFa4qaNj93cLTvluymMHHFS4R2LMm+vswZJLm+NpbTo5P685TYTWgycWY6nXuy1BP
 TY2B5lxNiLZ50TdJUy1Q/mYkS5TWCyF4vI6Yr5e7XuHI9fKY0i58psv7uI6dD2PSLX3i
 LRaRn1UsnRBTD7igS2rzSDfce2SK877OtlAy3flMvsnaqtni4mYsnqtRwf8hZSVvuvXZ
 68xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249644; x=1764854444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NaYCRt73TI4IZiG0ulxDoPHXWEJqElWgR2PIBolMkYo=;
 b=XpZhkZKO+mGV3j/lbRbvZXLMtllNnvYplcN791R/lYPWD1rxYHWOEOfEBbPzt0+KKQ
 dEcdP8iv23u9r+GLBMGUIdzYbGWh1sYHPhgcOJjlK3r86rEFWgvo4Y2nZI9+M2Ka2oiq
 1zDsE/8HqALYi7clu5vn5Mux+Hbm3hhXai1ysesu8YQtVs6KYhPY7leiSaM5R/JIIeE5
 QwIH0VIHGocpTSJmhw0d1dY58CnOnPceQAEQPi7K5qLr8zVCT4aw6VykhRJIw28inGWh
 qcP6MjwHxOuTaIiUXoyxrYYDRPJmYC30di6If+ckOH5nIug/8+SNrEtG2zQSQPaLkE7M
 5bQQ==
X-Gm-Message-State: AOJu0Yyxshid6xoM07Ct72FWxo0mHJ4fVdtuVQSdDDFk1HRJdFZWsAV7
 HB01x1JvWIAlXtT/GjLXEgmuUql8247vygVAah5XKJ4MeyF8O4WQ9XJK98cm3zY6RG3en2GgtOI
 rqooewrHhbWIwhrQ2x1c0da2HlrwhQBOa7dHDjEo/IMMxR+mp7Ammet2uIyOW8KK5woAsn/4K8w
 nMYsfauHUd2sZp2Orat/NhvNly02DS1tw5lD7IjXk9
X-Gm-Gg: ASbGncuzNkueKAwO5IxJPEDyKDbUazgxtzsucyqIi0o364OVJCES3W2FeFI7jDnwkWR
 uIQaI0fTWfpGBQjwr1E/KV9PBfCrHrSxbBPYOI+BkNlEKAwklX6NlraHclEKaA/8SfuXaitEpWy
 0oXBzMxW7rGIWO7sQMtTJLiGZvMfoIipnrIgu/KMhidN7ab6Ml8v3v7A7NeU3w3FJXJ0SRewjej
 Wzs5JaX8NGZZ7h3KLENLsvct6uXkKLe95bfFivut0g2o9pWHcye99BTItc10as4GrFubK/Nm45G
 em8EA/glhdr3N5pNP+iP2RC1OEJWaKe+7MlxTB5M+ABYe16gA/art8aI5Lc4El11MKNmfpB2ooT
 4psFYzmeI2wDr6wO7Pf5aMpfq2LSs+m8lyhoH7Pbhie82cokHwk8M//UN7ucANZ56+u2VIv/mr0
 63HtFN9JVr/cmA17s=
X-Received: by 2002:a17:907:d1c:b0:b73:75ea:febf with SMTP id
 a640c23a62f3a-b767183d027mr2904039266b.55.1764249644342; 
 Thu, 27 Nov 2025 05:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4C6Tmea+yOuuS43+qu22VGPtOQ+AXd0JAf2gPz+MPi9KhWd/E8+nWkz/tHi8Gu98qawqe+Q==
X-Received: by 2002:a17:907:d1c:b0:b73:75ea:febf with SMTP id
 a640c23a62f3a-b767183d027mr2904034866b.55.1764249643847; 
 Thu, 27 Nov 2025 05:20:43 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51a9819sm173080466b.25.2025.11.27.05.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/9] rust: remove unnecessary repetitive options
Date: Thu, 27 Nov 2025 14:20:30 +0100
Message-ID: <20251127132036.84384-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  | 3 ++-
 rust/bits/meson.build        | 2 --
 rust/bql/meson.build         | 2 --
 rust/chardev/meson.build     | 2 --
 rust/common/meson.build      | 2 --
 rust/migration/meson.build   | 2 --
 rust/qemu-macros/meson.build | 1 -
 rust/qom/meson.build         | 2 --
 rust/system/meson.build      | 2 --
 rust/tests/meson.build       | 1 -
 rust/trace/meson.build       | 2 --
 rust/util/meson.build        | 2 --
 12 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index d9293294d8e..270181038bf 100644
--- a/meson.build
+++ b/meson.build
@@ -1,6 +1,7 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
-                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
+                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
+                          'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
 
 meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
index 359ca86f155..c0094ffcf38 100644
--- a/rust/bits/meson.build
+++ b/rust/bits/meson.build
@@ -1,8 +1,6 @@
 _bits_rs = static_library(
   'bits',
   'src/lib.rs',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   dependencies: [qemu_macros],
 )
 
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 091372dd7b6..e5836e3f566 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -34,8 +34,6 @@ _bql_rs = static_library(
     ],
     {'.': _bql_bindings_inc_rs}
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   rust_args: _bql_cfg,
   dependencies: [glib_sys_rs],
 )
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 36ada7c4546..6b681c609ad 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -33,8 +33,6 @@ _chardev_rs = static_library(
     ],
     {'.': _chardev_bindings_inc_rs}
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
diff --git a/rust/common/meson.build b/rust/common/meson.build
index aff601d1df2..4b1cd35f639 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -16,8 +16,6 @@ _common_rs = static_library(
       'src/zeroable.rs',
     ],
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   rust_args: _common_cfg,
   dependencies: [libc_rs, qemu_macros],
 )
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 444494700ad..94590dc1b87 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -36,8 +36,6 @@ _migration_rs = static_library(
     ],
     {'.' : _migration_bindings_inc_rs},
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   link_with: [_util_rs, _bql_rs],
   dependencies: [common_rs, glib_sys_rs, qemu_macros],
 )
diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index 17b2a4e2e24..cdea5bf439e 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -1,7 +1,6 @@
 _qemu_macros_rs = rust.proc_macro(
   'qemu_macros',
   files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   dependencies: [
     attrs_rs_native,
     proc_macro2_rs_native,
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index e50f41858d6..551c4f0bf5f 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -26,8 +26,6 @@ _qom_rs = static_library(
     ],
     {'.': _qom_bindings_inc_rs}
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs],
   dependencies: [common_rs, glib_sys_rs, qemu_macros],
 )
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 73d61991146..2cd2dd36679 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -33,8 +33,6 @@ _system_rs = static_library(
     ],
     {'.': _system_bindings_inc_rs}
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
diff --git a/rust/tests/meson.build b/rust/tests/meson.build
index 00688c66fb1..3c5020490b0 100644
--- a/rust/tests/meson.build
+++ b/rust/tests/meson.build
@@ -2,7 +2,6 @@ test('rust-integration',
     executable(
         'rust-integration',
         files('tests/vmstate_tests.rs'),
-        override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
         dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
index adca57e5507..1b3498f7fc1 100644
--- a/rust/trace/meson.build
+++ b/rust/trace/meson.build
@@ -11,9 +11,7 @@ _trace_rs = static_library(
   'trace',             # Library name,
   lib_rs,
   trace_rs_targets,         # List of generated `.rs` custom targets
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   dependencies: [libc_rs],
-  rust_abi: 'rust',
 )
 
 trace_rs = declare_dependency(link_with: _trace_rs)
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 8ad344dccbd..18d67a4b374 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -38,8 +38,6 @@ _util_rs = static_library(
     ],
     {'.': _util_bindings_inc_rs}
   ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
 )
 
-- 
2.51.1


