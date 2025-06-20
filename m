Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9333C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeo2-0006YW-2R; Fri, 20 Jun 2025 12:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenx-0006YD-HW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenv-0000GP-UG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+h+zQtFRndjbbjZBH2HYw4tep2/IDavOmESW5qHH/2Y=;
 b=hqNQU4fBm8H16aP/cQRNCC6sKo9yQhTAzKpxEEyHPtfe8+y8u+ZPZGclfKm0hEd9Mw5hED
 zJ5tygsmOF8RGpVO1+evfRLClodkhGPEie8/Yw17o5SOTWtyz20wj4b4f83F0enlS2SCtR
 uwfshuFEJHshKOdZlTeXmJWw/UIeIQI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Er2TqbB0PVif3rkLlJ_N0g-1; Fri, 20 Jun 2025 12:41:24 -0400
X-MC-Unique: Er2TqbB0PVif3rkLlJ_N0g-1
X-Mimecast-MFC-AGG-ID: Er2TqbB0PVif3rkLlJ_N0g_1750437683
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-60785397a37so1970158a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437682; x=1751042482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+h+zQtFRndjbbjZBH2HYw4tep2/IDavOmESW5qHH/2Y=;
 b=Z2H9uecvfdCzFyOHsX9kjfk/+efy8WtynQgzCtUlVPLNhew1THLKMN5mRGXdDdugB7
 3vMBwg11kLcC3/SZbSyp/qmlrb4Fcex+bAQ86QxriupUP4ttU5lC3qNabHDLo7t3ga5R
 OnQrZkg/j6PBsUx4dPNAjKoBJs2govQ985/j4l+lENgIuUpiyFsFdtweqdI4KWaD8Ckv
 3XiGaCt0w7BK7ElfvNH7SaTJRnBR04YRhVc7+tJ+VLSPX/eWgCoDuGr2+d3WV/MtW7Cf
 Q3e2rhWFHrCeJu1aLGEGbjw9bkQM1ZH4qhq2P9fBXKMt7vuc7Acm9nwCcNeu4Y4AenCG
 iO+Q==
X-Gm-Message-State: AOJu0YzxkcDqz5baNxg7pZbDlmY1bGZimOY6Z7zBr1Xg03dRvO9Bp74u
 FSNezghMv7hViBiCW7jSJRyOVJ/AykFDKPu8KNDO9WvCG5tCfbRfSbj/feRDtcm+9wv/kSj0Z8K
 bmzDNJ/qDwKqrqbqQmgxfbaZ1xYpKsHM7Rh/0o7Kkaj8Imtl6fEsWkYAruu6o4KGAyk2mfHUhuu
 1kB38C9+6NdCx95+SHgT6rRwlHN3AxrFFhhTXs3Ic3
X-Gm-Gg: ASbGnctDXHUGbXRMYGgvcfYlqGIOvAQfnonkMAl+BnpkcyK1q5cYndOW7BKbO72c5jI
 Oap+0eIn3vlOA49faRh2uewp/YcIi3E8Qzc3r6EMBKEKVkjjKMIQLIKQuWVncDAjCJggK3kNihw
 /BSUUtyZq0DG4jaE68IhEOEIk3acUjga264pzSoyEOxBh4Hhd/QtfC1+kJPPXsChffpqEazrUwz
 e2I3iQTieRyZq39RVoumvMdTBWGvgZmdaf/2bFVpL7CpJH3aHRc38vw3AWm30eqUatSG3Hi8unc
 qGZleG9RH/wMJjpFLgoK/Vao+A==
X-Received: by 2002:a17:907:3e0f:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-ae057c33162mr343999366b.56.1750437682448; 
 Fri, 20 Jun 2025 09:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBt4goxrg26HjvrVHxQPAjVNFXay54U8lqmxWd+CFsofokxBMtYNKRhc8YRhMx84rlbMFvVA==
X-Received: by 2002:a17:907:3e0f:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-ae057c33162mr343997066b.56.1750437681967; 
 Fri, 20 Jun 2025 09:41:21 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053ecbe7dsm184578866b.49.2025.06.20.09.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/24] rust: prepare variable definitions for multiple bindgen
 invocations
Date: Fri, 20 Jun 2025 18:40:38 +0200
Message-ID: <20250620164053.579416-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When splitting the QEMU Rust bindings into multiple crates, the
bindgen-generated structs also have to be split so that it's
possible to add "impl" blocks (e.g. for Sync/Send or Default,
or even for utility methods in cases such as VMStateFlags).

Tweak various variable definitions in meson.build, to avoid naming
conflicts once there will be multiple bindgen invocations.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 21 ++++++++++++---------
 rust/meson.build          |  2 +-
 rust/qemu-api/meson.build |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index ed60be2a2d0..19ffa9cb34c 100644
--- a/meson.build
+++ b/meson.build
@@ -4200,10 +4200,11 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
 endforeach
 
 if have_rust
+  bindings_incdir = include_directories('.', 'include')
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
   # is 0.60.x (Debian 12 has 0.60.1) which introduces --allowlist-file.
-  bindgen_args = [
+  bindgen_args_common = [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
@@ -4219,20 +4220,22 @@ if have_rust
     ]
   if not rustfmt.found()
     if bindgen.version().version_compare('<0.65.0')
-      bindgen_args += ['--no-rustfmt-bindings']
+      bindgen_args_common += ['--no-rustfmt-bindings']
     else
-      bindgen_args += ['--formatter', 'none']
+      bindgen_args_common += ['--formatter', 'none']
     endif
   endif
   if bindgen.version().version_compare('>=0.66.0')
-    bindgen_args += ['--rust-target', '1.59']
+    bindgen_args_common += ['--rust-target', '1.59']
   endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
-    bindgen_args += ['--size_t-is-usize']
+    bindgen_args_common += ['--size_t-is-usize']
   else
-    bindgen_args += ['--merge-extern-blocks']
+    bindgen_args_common += ['--merge-extern-blocks']
   endif
+
+  bindgen_args = []
   c_enums = [
     'DeviceCategory',
     'GpioPolarity',
@@ -4264,13 +4267,13 @@ if have_rust
   # this case you must pass the path to `clang` and `libclang` to your build
   # command invocation using the environment variables CLANG_PATH and
   # LIBCLANG_PATH
-  bindings_rs = rust.bindgen(
+  _qemu_api_bindings_inc_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.inc.rs',
-    include_directories: include_directories('.', 'include'),
+    include_directories: bindings_incdir,
     bindgen_version: ['>=0.60.0'],
-    args: bindgen_args,
+    args: bindgen_args_common + bindgen_args,
     )
   subdir('rust')
 endif
diff --git a/rust/meson.build b/rust/meson.build
index 99ae7956cd0..e9f0879e296 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -33,5 +33,5 @@ if cargo.found()
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
-    depends: bindings_rs)
+    depends: _qemu_api_bindings_inc_rs)
 endif
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 33653b4a28e..64c04dfd74b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -32,7 +32,7 @@ _qemu_api_rs = static_library(
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
-    {'.' : bindings_rs},
+    {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-- 
2.49.0


