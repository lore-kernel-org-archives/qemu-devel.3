Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0881AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWHu-0002Qr-DL; Fri, 06 Jun 2025 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHr-0002QZ-Nw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHl-0005cC-BN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFozPSq0Nxq/m+LlcuCwjfLALKFKRR7FnzLY+vop8P0=;
 b=YLeaaOfzmGdrVIvrmQMrjF5RQFJUjgnYjLzGFr2BDK3ONHLL51OkXW7wSEcU/sWmbDeUym
 Xfm2K8kxznsz03pxZEm0Fy0WPD3EtFg9w6l/37yf1nzsbabFpctyveFci+HfjvSVhmt/ec
 b0D0Ug56sS3B+k5Ay4QLbAmGPF24/yE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-g-wSKDH9PAKaHZNPDgLBsA-1; Fri, 06 Jun 2025 08:34:59 -0400
X-MC-Unique: g-wSKDH9PAKaHZNPDgLBsA-1
X-Mimecast-MFC-AGG-ID: g-wSKDH9PAKaHZNPDgLBsA_1749213298
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso1035860f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213297; x=1749818097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFozPSq0Nxq/m+LlcuCwjfLALKFKRR7FnzLY+vop8P0=;
 b=n5EAPy+1I4PPh4GFdXX+NuWTas0b0LkgU4NdaxOVrBPpXG4EB//c3I8qrsZe877KwX
 Bc0IrQu+ufY56OuCmp1v3ji8/8I57qlTAxh3cupjTAH4Bps3QObLmrAN0gQ0PwfQKQtc
 XNqkvojhKU2MWYkBeGVrctH9FYIMgzcwAzxCANUYfAi6kza6PHdp0k6IpNjhOUmxgsc6
 7tWvuraf/APFlwtXg31NU7dosOZuyCVofrWYgrKhOu+D4uYOWni/Nbmg20nQLx5p5CEg
 /o1KCMA6LVuuIZQhhevG8PRgpHAY6Ka8b7XSwRRnAw3cAjUm288JeEt2K0yO//+clpkA
 5mkg==
X-Gm-Message-State: AOJu0YyX/cjpV0zFzHkU/+N8VjejA2aVAw2IfG5rEyyVhBC0g0AngtlV
 /7gKPwIOpQ3g1KMj8pgfLZtAakBJnuICdLg/snswjlknDBy1kzX+oG8KfROiRYENIysnt0R3R5A
 1PGy6eULOTc78/OgkanXMWfn1oN4OAVg23POwdWORNTUaz9zrtbHM6G1sMcPrckYrkvK+mkt49r
 WgthZ8SnhCGbuMTRhFq4yCi+R58kTDSM/YAauq/1JX
X-Gm-Gg: ASbGncuuIGKihfKtfqn2NH/YEW6etHdFHG/17V2kyIEqwxlut3knhAnSXz55fYmeO12
 C+opGsZf7KtxJx/9mD33hbDYg6qse//weHUVJBpVfRzPXX5tHBBV070SE+sWFgHeTaREosY12Mb
 HfRXV27nwcOwkqpZRqceXE128x91VPhvdpFx8P70dDcEq1uxQ1S/IGN4m0w9AQnIWEyOtCnt8Bt
 NrQZoBmvYPDNKlXbrJRIjnHB92WI1VK5aWJlIR9kHvursqK62v94ebhQpmK45zrEBTcJI6MMPkI
 90UXGVimLC38qtr0Ib5ale3g
X-Received: by 2002:a05:6000:144d:b0:3a4:fc3f:8d5b with SMTP id
 ffacd0b85a97d-3a531cb76c5mr2640149f8f.47.1749213296882; 
 Fri, 06 Jun 2025 05:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMh7adJiaQmyF/iKcuRiJrYdOVV0Fh+95zUOOwdim/tIy+A5OoAptCApWuDVvu6947VIhdqg==
X-Received: by 2002:a05:6000:144d:b0:3a4:fc3f:8d5b with SMTP id
 ffacd0b85a97d-3a531cb76c5mr2640127f8f.47.1749213296366; 
 Fri, 06 Jun 2025 05:34:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de0csm1747307f8f.1.2025.06.06.05.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:34:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/31] subprojects: add the foreign crate
Date: Fri,  6 Jun 2025 14:34:16 +0200
Message-ID: <20250606123447.538131-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

This is a cleaned up and separated version of the patches at
https://lore.kernel.org/all/20240701145853.1394967-4-pbonzini@redhat.com/
https://lore.kernel.org/all/20240701145853.1394967-5-pbonzini@redhat.com/

Its first user will be the Error bindings; for example a QEMU Error ** can be
converted to a Rust Option using

     unsafe { Option::<Error>::from_foreign(c_error) }

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 rust/qemu-api/meson.build                     |  2 +-
 scripts/archive-source.sh                     |  3 ++-
 scripts/make-release                          |  3 ++-
 subprojects/.gitignore                        |  1 +
 subprojects/foreign-0.3-rs.wrap               |  7 +++++
 .../packagefiles/foreign-0.3-rs/meson.build   | 26 +++++++++++++++++++
 7 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index f752a064649..99ae7956cd0 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,11 +1,13 @@
 subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
+subproject('foreign-0.3-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
+foreign_rs = dependency('foreign-0.3-rs')
 libc_rs = dependency('libc-0.2-rs')
 
 subproject('proc-macro2-1-rs', required: true)
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index da70720e4c1..2f0f3b2aae1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -35,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
                  qom, hwcore, chardev, migration],
 )
 
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 816062fee94..035828c532e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -28,7 +28,8 @@ sub_file="${sub_tdir}/submodule.tar"
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
+  libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index ea65bdcc0cf..4509a9fabf5 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -41,7 +41,8 @@ fi
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
+  libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index b9ae507b85a..f4281934ce1 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-0.2.0
 /bilge-impl-0.2.0
 /either-1.12.0
+/foreign-0.3.1
 /itertools-0.11.0
 /libc-0.2.162
 /proc-macro-error-1.0.4
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
new file mode 100644
index 00000000000..0d218ec2c25
--- /dev/null
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = foreign-0.3.1
+source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
+source_filename = foreign-0.3.1.tar.gz
+source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
+#method = cargo
+patch_directory = foreign-0.3-rs
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
new file mode 100644
index 00000000000..0901c02c527
--- /dev/null
+++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
@@ -0,0 +1,26 @@
+project('foreign-0.3-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.0',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('libc-0.2-rs', required: true)
+libc_rs = dependency('libc-0.2-rs')
+
+_foreign_rs = static_library(
+  'foreign',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+  dependencies: [libc_rs],
+)
+
+foreign_dep = declare_dependency(
+  link_with: _foreign_rs,
+)
+
+meson.override_dependency('foreign-0.3-rs', foreign_dep)
-- 
2.49.0


