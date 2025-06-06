Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE4FC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWHr-0002QX-2d; Fri, 06 Jun 2025 08:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHn-0002PY-4W
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHh-0005ad-Tw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skipcjFIPuLMLVtpY+MCj5F4aq8+dyy6e0I/e9eepUk=;
 b=CiPa685uvAAd/+HR5ObVRcMHDEYVleRtvUrird3nz/oOK82QvDSM0r0Uvjw9v6aSboOvfA
 q+yFBRxI9Xjq5adMYOD68Swc8PY+rh43nM49OgCrzgK2gtj6g5lI+fBKxjQvzihbNCRsal
 RHhXl8+DxYUq303Io7CLfUSKjyQN/jg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-vqXu8dbGMQKCQiE7f1j8Og-1; Fri, 06 Jun 2025 08:34:54 -0400
X-MC-Unique: vqXu8dbGMQKCQiE7f1j8Og-1
X-Mimecast-MFC-AGG-ID: vqXu8dbGMQKCQiE7f1j8Og_1749213294
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so1425347f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213293; x=1749818093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skipcjFIPuLMLVtpY+MCj5F4aq8+dyy6e0I/e9eepUk=;
 b=dau1VWaycK//5L+2H5vou6ZT0AwRilU3DShOYozWVU+Zsr11s4qw1V5BuFTmfQreSW
 nhXXq+8Mq+enNPqVBA6U5nSxiUt0ty+NPyo1QJsg7isypt3uAi7cqB6eb0H1YVhmq0ho
 jeuaM806NrLdiSTuyAq+rZF/VhSR9/Q6AGaBD4YqF23twJwo7HblHf0ovCAWO7F6O/Et
 DJBSCCmmqsx36Mcl1YEQ29M2BiM8XkDTzAzsVFar4/lUYV0bM5bvpPXmNjWwawFIyF/1
 +4IZ4kxNs/UXV8gp8vXesWDBPG+pArs6v8NxMf7kVcGhe95yOiSDXn2l27YtdkiRIatX
 QEmg==
X-Gm-Message-State: AOJu0YzZEoG86KtNzhG3IK7itbEUzgRhxsV9VX5M+7p9iZYdjOwGBuOH
 BYFGmK5UuBXUU2TZ8eqFrJHe/cgF4jU+uKE6siA0CrgGl1V6a6S+gb9tcEBErbMye4kQmxy7Fo0
 agva9gyb46WZr+IOVLBYOo3eKyf4W9ropJrNdsWxA68EypYC4V98mpVSZ3X0eoDRc8MQ8T56gxI
 EiMFNOMczuyX19ytNwpfyItRqSftqQ2OAh4n0yFVi/
X-Gm-Gg: ASbGncuwilgrCADTkle4dU50qyLqFWRqz76oA/1102xhYT+Jv/NBbQzp9qPT25K5olo
 AvIJwoRxrVgxSVJgCap0gV/0HzaAAAGbLyiS3a5VCE6IcBSmXpv/lK0uYtJ9uzk0AmaAB3lUJbp
 QVlI7SMZj5sUomWA7NYQp8pjHOGya/4yeBafYVqYd/N9S2VdWg9DUVcuFjAKpSHGLNGjgoB1nop
 ul7DHgYUKeZi8ftGIT/F5ifr42JigSrsuOo72PvIh0oq1oBJJkaTowYkZ2H+eOpuFz+eknfTjmL
 /JC2tp8eEBXoh+P3QbIM/3lC
X-Received: by 2002:a05:6000:2504:b0:3a4:e629:6504 with SMTP id
 ffacd0b85a97d-3a531ce732fmr2583507f8f.49.1749213292887; 
 Fri, 06 Jun 2025 05:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGjPQOaXQdQMF8t7LvTAnly2gRlDnQMcDOsWhXHbO6oBWR3OXqMkUwGtDYev/dwJgPyOFU6w==
X-Received: by 2002:a05:6000:2504:b0:3a4:e629:6504 with SMTP id
 ffacd0b85a97d-3a531ce732fmr2583484f8f.49.1749213292369; 
 Fri, 06 Jun 2025 05:34:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e158a19sm20145155e9.12.2025.06.06.05.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:34:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/31] subprojects: add the anyhow crate
Date: Fri,  6 Jun 2025 14:34:15 +0200
Message-ID: <20250606123447.538131-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This is a standard replacement for Box<dyn Error> which is more efficient (it only
occcupies one word) and provides a backtrace of the error.  This could be plumbed
into &error_abort in the future.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 rust/qemu-api/meson.build                     |  2 +-
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/anyhow-1-rs.wrap                  |  7 ++++
 .../packagefiles/anyhow-1-rs/meson.build      | 33 +++++++++++++++++++
 7 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/anyhow-1-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index b1b3315be97..f752a064649 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,7 +1,9 @@
+subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
+anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 libc_rs = dependency('libc-0.2-rs')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index b532281e8c0..da70720e4c1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -35,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, libc_rs, qemu_api_macros, qemuutil_rs,
                  qom, hwcore, chardev, migration],
 )
 
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index e461c1531ed..816062fee94 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -27,7 +27,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # in their checkout, because the build environment is completely
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
diff --git a/scripts/make-release b/scripts/make-release
index 8c3594a1a47..ea65bdcc0cf 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -40,7 +40,7 @@ fi
 
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
+  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index d12d34618cc..b9ae507b85a 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,6 +6,7 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/anyhow-1.0.98
 /arbitrary-int-1.2.7
 /bilge-0.2.0
 /bilge-impl-0.2.0
diff --git a/subprojects/anyhow-1-rs.wrap b/subprojects/anyhow-1-rs.wrap
new file mode 100644
index 00000000000..a69a3645b49
--- /dev/null
+++ b/subprojects/anyhow-1-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = anyhow-1.0.98
+source_url = https://crates.io/api/v1/crates/anyhow/1.0.98/download
+source_filename = anyhow-1.0.98.tar.gz
+source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
+#method = cargo
+patch_directory = anyhow-1-rs
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson.build
new file mode 100644
index 00000000000..348bab98b9f
--- /dev/null
+++ b/subprojects/packagefiles/anyhow-1-rs/meson.build
@@ -0,0 +1,33 @@
+project('anyhow-1-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.98',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+rustc = meson.get_compiler('rust')
+
+rust_args = ['--cap-lints', 'allow']
+rust_args += ['--cfg', 'feature="std"']
+if rustc.version().version_compare('<1.65.0')
+  error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.65.0')
+endif
+rust_args += [ '--cfg', 'std_backtrace' ] # >= 1.65.0
+if rustc.version().version_compare('<1.81.0')
+  rust_args += [ '--cfg', 'anyhow_no_core_error' ]
+endif
+
+_anyhow_rs = static_library(
+  'anyhow',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
+  rust_abi: 'rust',
+  rust_args: rust_args,
+  dependencies: [],
+)
+
+anyhow_dep = declare_dependency(
+  link_with: _anyhow_rs,
+)
+
+meson.override_dependency('anyhow-1-rs', anyhow_dep)
-- 
2.49.0


