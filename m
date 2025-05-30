Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3806C5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKui3-0002OL-34; Fri, 30 May 2025 04:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui0-0002NE-OS
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuhw-0004XZ-Br
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6QoYP5WCSbSMFCMhfRa9ReIhHpAzUDchEI+NzMVEms=;
 b=P23FgdZ3cKqZ+sKBZx7bgpJhQ1Z0TV0Kgqjeeknmzn2DQ+erObr7npr+gVfYVphKD16Y8V
 rEpv95CfPZmcY7nklmE/mI4R7fjRc5IxE+0SaS+id3BFzsynH4Eni0q+Rt7lt4bXi7aZPD
 naZMCHWOsGsOM0Zg95RlH7K5SV0Tqls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-IIEwYzgzNeCLZU2VUzy92Q-1; Fri, 30 May 2025 04:03:13 -0400
X-MC-Unique: IIEwYzgzNeCLZU2VUzy92Q-1
X-Mimecast-MFC-AGG-ID: IIEwYzgzNeCLZU2VUzy92Q_1748592192
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601f3f35b88so1710070a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592192; x=1749196992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6QoYP5WCSbSMFCMhfRa9ReIhHpAzUDchEI+NzMVEms=;
 b=NSQiFXZr8N6ZoREUeg0hPFEKXZUDZ59wuiN1GYfNCES5EuRnAdZ6+y9QLAFwxWyuqg
 dx8s21JoTqSp3w73WXqDgNnQl3nLQ8upjZZVMBk7Vx6hFSjCdjTJ3sgMlT910HbYJWA6
 ivz4V2NEHqfEb7J5xsmipMY6qNzl/4MriZzswLIWbCO68drj5e5nAV1bXTLH+r9xm8oh
 t3riZu+MyIEmQS6bnqJEMj7ystssRYxhliBFoAZ4HT3P0GYIb+t8jGcLzqhaqUa6d+uL
 Yc/Q8AN94OvCBQs6M2MSoP8eiEe/+6T0ezSckZvnT0gL/R1NUPeJbXG1GdVAAShQVcXQ
 Prqw==
X-Gm-Message-State: AOJu0Yx+mRA5JZFw4mkfUI+fcmXB+rGOYpEM67JBjy7rGxiJvkc+ODy7
 8r1Tdtub71B4xXv1aLwEFoUD/OABexsC+hu8lVpH1CKqigMLMxJDOdg75vw3mPohIPNWT7/5Gjz
 sS7XuIvX0fwEPFV4HD7CkRfdToJdcVnTSFRc04W6YuJXGoW795E2/YRKDTYAkKC/BTnfuKhDx3R
 vIlgJzh14X13xtER1ulQ67upjpOvEHBfVOh+EFsTgo
X-Gm-Gg: ASbGncsrPbhA91KqtxJyXbTMHASxCAMonLUwWfemTOQiaORPV2gQYFpgEHqc1zvUXWs
 1ncQXWFO7o0XGF0GeJSwy7GogAE+iZVCRDlo8N6VQR3q4jZ9FjY7SqA8lLwoJ4wx6KYw7w5fvRa
 21S0/rbwBxK1KKoNLvBsqGfH1W4YaV9HPJiQ51xsEjbpySoYr7FipAekhCSf61H8hhq4PkfJztt
 f9iAXbg6tPAkWx20RMCUUnfLlMymZPV1W/jdIJCYGPxKDhFeMgggDtJ8UA77v3dCk19dthU46B9
 12Raa62NYjkdfQ==
X-Received: by 2002:a05:6402:34d0:b0:602:3e4:54de with SMTP id
 4fb4d7f45d1cf-6056db31fdfmr2252486a12.10.1748592191648; 
 Fri, 30 May 2025 01:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTV+NBOEZUNPTidm/yHYmvPTkjQLR5Zjaf7PHW0R7WQSmI2kZJjbN4co+1imMPkaADl0Nnew==
X-Received: by 2002:a05:6402:34d0:b0:602:3e4:54de with SMTP id
 4fb4d7f45d1cf-6056db31fdfmr2252451a12.10.1748592191179; 
 Fri, 30 May 2025 01:03:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c59f81sm1252212a12.18.2025.05.30.01.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/14] subprojects: add the anyhow crate
Date: Fri, 30 May 2025 10:02:53 +0200
Message-ID: <20250530080307.2055502-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 .../packagefiles/anyhow-1.0-rs/meson.build    | 33 +++++++++++++++++++
 7 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/anyhow-1-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index afce62f4772..6227e01f32a 100644
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
index d19f52af4da..181ceca9536 100644
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
diff --git a/subprojects/packagefiles/anyhow-1.0-rs/meson.build b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
new file mode 100644
index 00000000000..348bab98b9f
--- /dev/null
+++ b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
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


