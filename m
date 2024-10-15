Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E657D216A3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hR0-00023K-Gk; Tue, 15 Oct 2024 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQy-00022w-QM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQx-0001Dc-Aw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAbsj1TUYq+4pfKeL2OaEWTmSq8KVDWcMjyzGlJmWtQ=;
 b=LdtoWY/+9j1/tx7U+NycL3538jENzZPwo0aFkzBoCzO6Lt5qMu4cQfBbnQJi5J2RuzzLUT
 Jz05J2VTlYJtoG6RuaMg1dRMmwl4/o94SyiVEKaK/FbQmWe94iDEtGbanx09vIWIhcHrxj
 y8Ck4yjtW+kLtkKTV+BFVbmLc55fWPc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-L7V3psWsN-iYySyLny8H5g-1; Tue, 15 Oct 2024 09:17:52 -0400
X-MC-Unique: L7V3psWsN-iYySyLny8H5g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso2681377f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998269; x=1729603069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAbsj1TUYq+4pfKeL2OaEWTmSq8KVDWcMjyzGlJmWtQ=;
 b=d2kLrGPk6eNELHaL+KzL0FSe1v7K1hG93PzAWD0Q+j6kDSmv3sQEIU6N8qZi9P9fjo
 hWdubbfNgpNHGc9nI/DpB2jMU1msPgzdlGxMxATEJ8ainBbjbYAQDrXwxwnT9T65k6TR
 q7Cq9BzKbxrXbIxFNMkwOHJgxcnHiBYmGFQultFyY644e4yJeNpOg6KyTKRSYL5JCn3i
 6Eoi3iSXHU7u3oV3qEuhMMK2sy5guQegRWIt35d7OS/Mgo8M5EVdFY8cUI37tZbeaZ6P
 37KTOaoCRiBa5HBq2te15EfSG5iyOV7nqDlpddHGRuLrsLuA1/PhynkUJO+2hpJTkNgP
 S/eg==
X-Gm-Message-State: AOJu0Yy3Nvo1biLryPilN2yAOI85lpidyTIpavI+xPqqvs06PBLn9/VZ
 uOR1rPe2LbcIf3+GQvtZwjkrTWE6ZEJIbmYNNh9Gf6pvDidky7hhBP8b23oi8qMdrdy23wjGDZx
 y6bhKUPN8vFRm3tuW8bcRJ9n99pnPhtwFAHipXNO0XbnW7Wayw2yp5ThhVykxX1meydx0rXmdGf
 0o2UmfX6ssLPxkXv1yDg+SnKvUd6Bn/vRfHSNkDtQ=
X-Received: by 2002:a5d:570e:0:b0:37d:4a16:81d6 with SMTP id
 ffacd0b85a97d-37d86bfcc85mr205280f8f.24.1728998269155; 
 Tue, 15 Oct 2024 06:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBh4qY087oOAqphQj1l23YTgfFYlxk/niS/5xlWx08gth0mFZRgS2oKzPjfeJL/G7uwM0vw==
X-Received: by 2002:a5d:570e:0:b0:37d:4a16:81d6 with SMTP id
 ffacd0b85a97d-37d86bfcc85mr205248f8f.24.1728998268583; 
 Tue, 15 Oct 2024 06:17:48 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569933sm17909365e9.13.2024.10.15.06.17.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] rust: pass rustc_args when building all crates
Date: Tue, 15 Oct 2024 15:17:21 +0200
Message-ID: <20241015131735.518771-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

rustc_args is needed to smooth the difference in warnings between the vario=
us
versions of rustc.  Always include those arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       | 18 +++++++++++-------
 rust/qemu-api/meson.build         |  2 +-
 rust/qemu-api/src/device_class.rs | 10 ++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 37f94ab32aa..2545185014e 100644
--- a/meson.build
+++ b/meson.build
@@ -3317,6 +3317,17 @@ endif
=20
 genh +=3D configure_file(output: 'config-host.h', configuration: config_ho=
st_data)
=20
+if have_rust and have_system
+  rustc_args =3D run_command(
+    find_program('scripts/rust/rustc_args.py'),
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
+  rustc_args +=3D ['-D', 'unsafe_op_in_unsafe_fn']
+  add_project_arguments(rustc_args, native: false, language: 'rust')
+  add_project_arguments(rustc_args, native: true, language: 'rust')
+endif
+
 hxtool =3D find_program('scripts/hxtool')
 shaderinclude =3D find_program('scripts/shaderinclude.py')
 qapi_gen =3D find_program('scripts/qapi-gen.py')
@@ -3909,12 +3920,6 @@ common_all =3D static_library('common',
                             dependencies: common_ss.all_dependencies())
=20
 if have_rust and have_system
-  rustc_args =3D run_command(
-    find_program('scripts/rust/rustc_args.py'),
-    '--config-headers', meson.project_build_root() / 'config-host.h',
-    capture : true,
-    check: true).stdout().strip().split()
-  rustc_args +=3D ['-D', 'unsafe_op_in_unsafe_fn']
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
@@ -4087,7 +4092,6 @@ foreach target : target_dirs
                             rlib_rs,
                             dependencies: target_rust.dependencies(),
                             override_options: ['rust_std=3D2021', 'build.r=
ust_std=3D2021'],
-                            rust_args: rustc_args,
                             rust_abi: 'c')
       arch_deps +=3D declare_dependency(link_whole: [rlib])
     endif
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index c72d34b607d..42ea815fa5a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -10,7 +10,7 @@ _qemu_api_rs =3D static_library(
   ),
   override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
   rust_abi: 'rust',
-  rust_args: rustc_args + [
+  rust_args: [
     '--cfg', 'MESON',
     # '--cfg', 'feature=3D"allocator"',
   ],
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 1ea95beb78d..b6b68cf9ce2 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -16,10 +16,12 @@ macro_rules! device_class_init {
         ) {
             let mut dc =3D
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::D=
eviceClass>()).unwrap();
-            dc.as_mut().realize =3D $realize_fn;
-            dc.as_mut().vmsd =3D &$vmsd;
-            $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $=
legacy_reset_fn);
-            $crate::bindings::device_class_set_props(dc.as_mut(), $props.a=
s_mut_ptr());
+            unsafe {
+                dc.as_mut().realize =3D $realize_fn;
+                dc.as_mut().vmsd =3D &$vmsd;
+                $crate::bindings::device_class_set_legacy_reset(dc.as_mut(=
), $legacy_reset_fn);
+                $crate::bindings::device_class_set_props(dc.as_mut(), $pro=
ps.as_mut_ptr());
+            }
         }
     };
 }
--=20
2.46.2


