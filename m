Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D760BCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLo-0006Mp-AT; Sat, 13 Sep 2025 04:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLW-00063V-HE
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLS-00052b-1y
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXfUGOoHfc1J6QjpUbcTQniNnAlcPz2igefiWjM4Eds=;
 b=JgC2k3d0+ekM/knu/FsW6NmNbSZQxkXJAyXLLHpefAnCzeh2gVUb+eVlallGpMrDGngy1G
 JTlDBzubG7W3+W+UShTlFveGTmx5u6kyHuSt61du1TY/VEiQUdmPJfH9MtUlb3KRQjHRK1
 aqyY60oTD7rLqusm0jGYwbehp2r8+Aw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-kBJIGsw_O8yknNKyjJOJlQ-1; Sat, 13 Sep 2025 04:10:51 -0400
X-MC-Unique: kBJIGsw_O8yknNKyjJOJlQ-1
X-Mimecast-MFC-AGG-ID: kBJIGsw_O8yknNKyjJOJlQ_1757751050
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e2055ce8b7so1431453f8f.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751049; x=1758355849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXfUGOoHfc1J6QjpUbcTQniNnAlcPz2igefiWjM4Eds=;
 b=DYB+gh1T5CUDJtxBCNWFPAEpargmdn5LhPlxJlRfjpJPGWMemYmmMPbKxcQSv5Uxf7
 ecHWFQmcoYTTytDnxib7A/MLXgS58rZXfjZixY+7bCntJvAsqHWdBp5iGokwEiEhqzc0
 VMzFFiekUHmVAId8gdEOQ0Vow3Tg6IOzINeLGumYHOtPOIf9gmmxMAXub/tzWZs+miIH
 jX8MwGiKbrvEvjHscZOX4EKn27yl4vyscqGw1Vxt5V8l68zsDDAs6emOfPpwTmfaPS4u
 F7GtemRT6m63Ynp4BQhfb/mHK0UjYbt5rCAw/LP70M9QHjVg/oLoJ9LCsKY6b/1lQJmu
 jZkg==
X-Gm-Message-State: AOJu0Yy/ZCj+mT3euHFSu+HWGIxNw+wehonEbg/wqM/qWaXb3f5ylMKQ
 ZBzzJJeXidgbfhXHvpHlzjykqaD9ENoCwYWEjlH4slBG0HdGKPItSr+RdMLeThkPM2J9plnZ/4T
 il83r8gttyCacQLLAo+XM5RYisCEqJWqc7f/95PlXQwb++GApoQY8HNotfk5+dlYZP4Gbtzrj7D
 /+O8jCk8oo6fH3Qb4lyhWJ3h5PbMoISVeu5/pLZOiX
X-Gm-Gg: ASbGncuDqLHSATKEfwOPT/+yLHEaUEQwx09J8fmpBH9uV6mgzBe3spIJGUiYemsbxE3
 HCiuJmgQ0GRcZjeKmDaiwImplBTVC474s2wwHvOiwCB7Q8zHDI9h2VKRl+Q8V9wPOLox4wLv2XJ
 GgHAzsuRT1a6lOGsRipmK1eUOrwBBxKEjcjhXE4Ka0p71AjqdWuEw+FcLhHHF28u08MbPm1NVXm
 eLDfyK3qUOLQHLyJDu3QGZtiBrGM5I7/mPhn+t8lQtL8SaCgNt/JtvFWedvo1osyJ76n6fcLqzA
 Q4wvkRPWY4PP2c9vrOKz8YoHKRl8LeHp72frpCTRw3/lqtIkSRVeEKA492hMF8de7lWYazLdNpo
 g3ZOki+FWcGDedpul4n/w8suCKHZ2699sHhdfsHqqEms=
X-Received: by 2002:a5d:40ca:0:b0:3e8:94d3:764c with SMTP id
 ffacd0b85a97d-3e894d37bacmr732707f8f.61.1757751049356; 
 Sat, 13 Sep 2025 01:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv+pKxSz3wnrl0DsZvX5uU38yP3Gl/cL7ZpGhBfaKBXvqE4sZ8P4wkBI8U1xUa87fr9/+uFw==
X-Received: by 2002:a5d:40ca:0:b0:3e8:94d3:764c with SMTP id
 ffacd0b85a97d-3e894d37bacmr732681f8f.61.1757751048696; 
 Sat, 13 Sep 2025 01:10:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156d40esm95655185e9.1.2025.09.13.01.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/61] meson, cargo: require Rust 1.83.0
Date: Sat, 13 Sep 2025 10:09:03 +0200
Message-ID: <20250913080943.11710-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-4-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst | 15 ++++++++-------
 docs/devel/rust.rst            | 14 +++++---------
 meson.build                    |  6 +++---
 clippy.toml                    |  2 +-
 rust/Cargo.toml                |  2 +-
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8671c3be9cd..0160d3adb83 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -118,14 +118,15 @@ Rust build dependencies
   include bindgen or have an older version, it is recommended to install
   a newer version using ``cargo install bindgen-cli``.
 
-  QEMU requires Rust 1.77.0.  This is available on all supported platforms
-  with one exception, namely the ``mips64el`` architecture on Debian bookworm.
-  For all other architectures, Debian bookworm provides a new-enough Rust
-  compiler in the ``rustc-web`` package.
+  QEMU requires Rust 1.83.0.  This is available on all supported platforms
+  with two exception: Ubuntu LTS releases 22.04 and 24.04, and the
+  ``mips64el`` architecture on Debian bookworm.  For all other
+  architectures, Debian bookworm provides a new-enough Rust compiler
+  in the ``rustc-web`` package.
 
-  Also, on Ubuntu 22.04 or 24.04 this requires the ``rustc-1.77``
-  (or newer) package.  The path to ``rustc`` and ``rustdoc`` must be
-  provided manually to the configure script.
+  It is expected that in the future Ubuntu will provide updated packages
+  like the existing ``rustc-1.82`` package.  The path to ``rustc`` and
+  ``rustdoc`` will have to be provided manually to the configure script.
 
   Some distros prefer to avoid vendored crate sources, and instead use
   local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes a
diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index b6737536c69..e0ee4a9837d 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -75,21 +75,17 @@ Note that doctests require all ``.o`` files from the build to be available.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
-are missing:
+QEMU supports rustc version 1.83.0 and newer.  The following features
+from relatively new versions of Rust are not used for historical reasons;
+patches are welcome:
 
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
-* associated constants have to be explicitly marked ``'static`` (`changed in
+* associated constants are still explicitly marked ``'static`` (`changed in
   1.81.0`__)
 
-* ``&raw`` (stable in 1.82.0).  Use ``addr_of!`` and ``addr_of_mut!`` instead,
-  though hopefully the need for raw pointers will go down over time.
-
-* ``new_uninit`` (stable in 1.82.0).  This is used internally by the ``pinned_init``
-  crate, which is planned for inclusion in QEMU, but it can be easily patched
-  out.
+* ``&raw`` (stable in 1.82.0).
 
 * referencing statics in constants (stable in 1.83.0).  For now use a const
   function; this is an important limitation for QEMU's migration stream
diff --git a/meson.build b/meson.build
index 3d738733566..a238df3f5e3 100644
--- a/meson.build
+++ b/meson.build
@@ -94,12 +94,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.77.0')
+  if rustc.version().version_compare('<1.83.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.77.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.83.0')
     else
       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
-      message('Please upgrade to at least 1.77.0 to use Rust.')
+      message('Please upgrade to at least 1.83.0 to use Rust.')
       have_rust = false
     endif
   endif
diff --git a/clippy.toml b/clippy.toml
index 90161729838..204f5713c00 100644
--- a/clippy.toml
+++ b/clippy.toml
@@ -1,3 +1,3 @@
 doc-valid-idents = ["IrDA", "PrimeCell", ".."]
 allow-mixed-uninlined-format-args = false
-msrv = "1.77.0"
+msrv = "1.83.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 6f8884eb30b..99c275f2d9f 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -13,7 +13,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
-rust-version = "1.77.0"
+rust-version = "1.83.0"
 
 [workspace.dependencies]
 anyhow = "~1.0"
-- 
2.51.0


