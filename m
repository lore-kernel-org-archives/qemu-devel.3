Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E33C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZS0-0004sA-8t; Tue, 03 Jun 2025 17:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRz-0004rg-DL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRx-00065N-NN
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGbsoQ2733vAS/b3/AL2oD4PQx/clYbZJMGXnG9URjc=;
 b=fJ6IfJSbrx4JTgISqM6fsUPcSHfW/AADZmPs0Wis/i20aLPeT3Q48DPeCE3wsOIFS0WNoN
 TOeSLmta84CeP9llMhbOuzk/x2sSWa/1bekK8CkCfFzRXyDU09j8bZ+ew97G123cZlTYBw
 J7hu2iNl311W2tjCmiOMHn84mWdix6g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-PupRi0elMNu2clUVc7usbw-1; Tue, 03 Jun 2025 17:45:35 -0400
X-MC-Unique: PupRi0elMNu2clUVc7usbw-1
X-Mimecast-MFC-AGG-ID: PupRi0elMNu2clUVc7usbw_1748987134
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso3236911f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987133; x=1749591933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGbsoQ2733vAS/b3/AL2oD4PQx/clYbZJMGXnG9URjc=;
 b=bwUJe5KGnyrU5oSnRO0oK6cz2ENy8EsgLzRERUilUvRu+EVA3Rif+i+mg8s3rWZLMI
 y0yzcnF8ZkqUxMdYo0soxtxVqAToRDQRLrtpuI0DgFCLN/sTHOuUi2hbvQB/fLeI2kw7
 NSEvcOSL9uwxYptHr1orFSEQGIRtEOLQVysFdvQjW+OrG/86t4vI2wmbMy2YmMwiztev
 smpFJ5WARyuABhHiIrkHCjMMwQqTi2QKsN/JiHNQtn3W0t9gQ334PGbkjGtjx9gsBpV/
 xkzgCAAK3dtDEkEH+VsuqEDWkdtzOk5EtgP9a575XUu/YopIZGmUSyBrIZy3XoPn35F8
 gmIA==
X-Gm-Message-State: AOJu0YyP0rh+TDK4RXxa6g1UgoNHQJXtTuC/IHbK46Wv38DpODOnCQr7
 jIQB60l2LPb4JCWzZI+UH5hyHKYHKUTYaYY69Qph9OhWRC7zFsy5uCSmgfJ6Pi6XVC5D47HdRZN
 +pv1uYm9r0pd76OItbkgn+40VOB4EE1Q+7K9ztN+o5SbxbznP0Ql0TNTtm4mopVXKD0+sXPlnO/
 T74/rBD/luC0Yi9D6ChhRLS/khjDY1n5uHa/veMXgg
X-Gm-Gg: ASbGncvwBIbpurxgkCR4cCHeLwjERlnSzp7H1xifW/KtUbPwRNzECxscIEQ5PYHxfS6
 6FXO3fwmdRK2d1LCX17uGS06fA5vsFVxWvSWYyIxHHyeR4atw1KskB6XWjUqSD6augEMq/7QJ/z
 vwN+Li+CswjI1UwC3sitwsW4Vyad7BxX70XQJd04GHaLMxzrWA+PmeOTWB4U9bqEAg45VGwh3xS
 lNzsjSTGZumFMVySG3N/0cau0i3biQNh80O0uAVY9cevT0WB/9HoUPGhhmxl1R0hZQUxHG/L34+
 MWnCYnJip1rXkA==
X-Received: by 2002:a05:6000:22c2:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a51d91c1e4mr254971f8f.15.1748987133004; 
 Tue, 03 Jun 2025 14:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwXvw6zLCleAHI3ZvGYVsikJagv36PEfhEkTdmBvGUhRUceKvd/WjwAZMUEZ9lPnJYiNihug==
X-Received: by 2002:a05:6000:22c2:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a51d91c1e4mr254956f8f.15.1748987132564; 
 Tue, 03 Jun 2025 14:45:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc1adesm181792285e9.33.2025.06.03.14.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 03/16] rust: use "objects" for Rust executables as well
Date: Tue,  3 Jun 2025 23:45:10 +0200
Message-ID: <20250603214523.131185-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

libqemuutil is not meant be linked as a whole; if modules are enabled, doing
so results in undefined symbols (corresponding to QMP commands) in
rust/qemu-api/rust-qemu-api-integration.

Support for "objects" in Rust executables is available in Meson 1.8.0; use it
to switching to the same dependencies that C targets use: link_with for
libqemuutil, and objects for everything else.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst       |  2 --
 rust/meson.build          |  2 ++
 rust/qemu-api/meson.build | 27 +++++----------------------
 3 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 171d908e0b0..11328c05b45 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,8 +66,6 @@ be run via ``meson test`` or ``make``::
 
    make check-rust
 
-Building Rust code with ``--enable-modules`` is not supported yet.
-
 Supported tools
 '''''''''''''''
 
diff --git a/rust/meson.build b/rust/meson.build
index 1f0dcce7d04..801f4374dfa 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -14,6 +14,8 @@ quote_rs_native = dependency('quote-1-rs', native: true)
 syn_rs_native = dependency('syn-2-rs', native: true)
 proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
+qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
+
 subdir('qemu-api-macros')
 subdir('qemu-api')
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1ea86b8bbf1..62068352b0b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -35,32 +35,15 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [libc_rs, qemu_api_macros],
+  dependencies: [libc_rs, qemu_api_macros, qemuutil_rs,
+                 qom, hwcore, chardev, migration],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(link_with: _qemu_api_rs)
-
-# Rust executables do not support objects, so add an intermediate step.
-rust_qemu_api_objs = static_library(
-    'rust_qemu_api_objs',
-    objects: [libqom.extract_all_objects(recursive: false),
-              libhwcore.extract_all_objects(recursive: false),
-              libchardev.extract_all_objects(recursive: false),
-              libcrypto.extract_all_objects(recursive: false),
-              libauthz.extract_all_objects(recursive: false),
-              libio.extract_all_objects(recursive: false),
-              libmigration.extract_all_objects(recursive: false)])
-rust_qemu_api_deps = declare_dependency(
-    dependencies: [
-      qom_ss.dependencies(),
-      chardev_ss.dependencies(),
-      crypto_ss.dependencies(),
-      authz_ss.dependencies(),
-      io_ss.dependencies()],
-    link_whole: [rust_qemu_api_objs, libqemuutil])
+qemu_api = declare_dependency(link_with: [_qemu_api_rs],
+  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
 
 test('rust-qemu-api-integration',
     executable(
@@ -69,7 +52,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros, rust_qemu_api_deps]),
+        dependencies: [qemu_api]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
-- 
2.49.0


