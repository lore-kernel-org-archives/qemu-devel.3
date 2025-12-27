Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C84E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQZ-0004Ma-Fg; Sat, 27 Dec 2025 04:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQX-0003qZ-1b
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQU-0002lS-1Z
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7YclRVtO4qoFigCNOFrbbMZmcmDW1b22zXAtv4jyAY=;
 b=ZeT3SmBDFsFWUOCH4GbBZs7zgNWdzF7ifSJ5ixHkKzNpFXsektdUqMF8fvklPnOitla9NV
 r5z96MzFYkvJHEf+D02pygR7cj6TxLAW/fuyhBrB4igKnZnSTLimBYqYWwHc2iOQSG4pmo
 cdPv/YFObC3U7MFf7hKgrEcS90TE17c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bl1MYdBAPEWIdOprNAxo3g-1; Sat, 27 Dec 2025 04:17:26 -0500
X-MC-Unique: bl1MYdBAPEWIdOprNAxo3g-1
X-Mimecast-MFC-AGG-ID: bl1MYdBAPEWIdOprNAxo3g_1766827045
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so77990305e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827045; x=1767431845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7YclRVtO4qoFigCNOFrbbMZmcmDW1b22zXAtv4jyAY=;
 b=Urix5876PMrPQslxHq3fD4c9dtnr1g0Mu751DrEyUdkCJdqnn7pSqkjUOL5zE+b6QG
 o/AXXd4+m4Tewtk8nMwRwSCjAK/19KOM7eh9EwN208IXLOQ45eQ7hMUHdSnSS5970ZVh
 1MrfyRQDGEuEZHJ4+5FgxGIEvv6DvVCaM2PuUBnPtGSd+pSPjK5WKCabkSfao5JHWPpf
 9SQo4XEruNv8UizN43uZi6G6fideEkP7dQwZbmClIUZ+nOkS/JNRQl+X4v5pVOrhJxK7
 vmIC3DDNHqFkDD9P9d9RQValbZdnqhfS9Wb7gsMSHeZ4Ev/245GxeX1mIhVrLAS95IR2
 2mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827045; x=1767431845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7YclRVtO4qoFigCNOFrbbMZmcmDW1b22zXAtv4jyAY=;
 b=mr6/pN58CKk8Iwjwh51MB+HKYpue4Ndp5bmiJNYq0yWplfQ7KIorhWuRGplfyYOExP
 9gcqXJOMtXWJR4yqeFvwKX88FmF7Mx6GBVzzf/TDScIVS2CRxOqG31dPn+PJzSHAKe7Z
 C+AO/12GuZ0kyqxiRdEBJLv5uywWy/JATQAtYScb6ewSu/0ugkY3rxE8dOcBaL8xqZVV
 xhHjXpE1+mFJI20GX/PVz1Yp0La9I6whw1RCAjpcAb9WJmTOKisrfuLxk2ktoHeKbt6l
 xVHZ/wUNmuYwChRVHxxlb96jkB1Bbef2MnHCh95agSIlxJ19GnUqeIm8fHRD6vmmmbEj
 cQiA==
X-Gm-Message-State: AOJu0YzaBDQSmnC2aCd5M4iTDUxPIJuKbsf/IZ8LOtweU4uuUN8N10tq
 2328tdWD3M6M0eSAUQIvHy6Bz0pmLZWsA2OvwEX435E/lUw0vTezzWZSdX5BKfqP+cz6x4AC6Dn
 KjLxlTqsS4V4ZltnYzYOr/P0dUIDmwHwsEBpvtHNfbxNHPX0M/nUJTeAiB8WA0k2+Pm+9bT0U7j
 EMnlv5nvkUJ+6hJ/F42JMYUIwIxjOVuEN3aSr9iv2/
X-Gm-Gg: AY/fxX51rmsrLzvW4ENhr5J/0EE6heIz/LobMbH4+zJ/IMA46p8Sh5GXlgt7QubuSy0
 W4vHyD3R68pyjHVaj2b3JSVwfXv6oilG2IDhD4OvapLah9HUDXat+7t6hdQM4GmcOCW2SwzcO4R
 rrkEU7rSWOdyJlu4y42A0zAU+zRCvPe7zXpWdraDKi5PPxdGPEUkb24I9lsSEWEPVuDlnWhB6tP
 Of0Ts9u960aO4Bucvd1idNj0jjwXHaF/NK8Jb0iXi1bf50IQzknieeiF4TOFF2X7Jgw3hwRUcq2
 6b9H2gdXlVTbFEAaaiboKDYdwybY1Id44wMctJjBEtW8TYp8YkY6nc5XsZ0Anvm0BFOnFnq56jo
 90B+xP8PR6nhTEYxzJ07VJ+IEDFi3kyYfWIIiJaISjj+b9zjrqQpJrag87vyi3cn3M7/QAoVeeL
 MFe2/6FfrASCIn660=
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr283354195e9.28.1766827044626; 
 Sat, 27 Dec 2025 01:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlzsELfVLkTvLG9B+wbrBIn96UviLFWBwCGpOweK9mfeurgJfPufyDQMp/LMFgkL0hQYS/Hw==
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr283354005e9.28.1766827044190; 
 Sat, 27 Dec 2025 01:17:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm442644615e9.12.2025.12.27.01.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 032/153] rust: remove unnecessary repetitive options
Date: Sat, 27 Dec 2025 10:14:19 +0100
Message-ID: <20251227091622.20725-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
2.52.0


