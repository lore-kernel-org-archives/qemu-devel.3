Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC42FC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60F-0002BJ-U8; Thu, 20 Aug 2026 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx605-0001V7-E2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx600-0005nc-NQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVioBH5QCJwrJt+MZmLrqmPfuXJxmj4/iSlks8B/NvY=;
 b=PmLBpCFPXZF+e9DdWhsc4IFd5fO/68kt2JVhZaHUXj28Jm+6/Dw2ufUyaqs/IWh+uNCaeb
 icV3j6YYGY13GGVlSS2GP3kS7Ieef4Fdg6JTJ5fkNdlSVHkDgEzI48SFo9lhQpuZUpJN3J
 xwYqNZ3Ui9CoxhsK/DJ2d+Tw7vv6yMQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-zTFjLz4_PeWQ4NnJBS9znQ-1; Thu, 20 Aug 2026 12:52:09 -0400
X-MC-Unique: zTFjLz4_PeWQ4NnJBS9znQ-1
X-Mimecast-MFC-AGG-ID: zTFjLz4_PeWQ4NnJBS9znQ_1787244728
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so167145e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244728; x=1787849528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HVioBH5QCJwrJt+MZmLrqmPfuXJxmj4/iSlks8B/NvY=;
 b=CGy8B68ZHTM9bc6LBdxZTpRoujbOU9ujcSvnr5n443/PyzKpPqKZXbzBYa3G9gac4N
 9dMzOyBwbYkcSPFDn/I/83AX5QqaGjA7exnuPbn8ERsybRJpkCTDo6n4BnFsi0YUFYP+
 7VcnQ+tkN2EfaUwiBQ9SZf4Fr0o1cEz6qhxKzXsJDcIQVuC0KXaq6NBN+Y1qjU9VgwOU
 NIcRLzPYX12A6U3W4qi/iO5lH9MNev0y1oNlgzwT/ELBxnGDeF0Z763QqWi5FYjh/A1R
 mtJB/Sp+RscR6teu+skl6By2my2mCVviX8DQartMKInHo6hhLCabLBVSj40qN2qXUNgq
 XlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244728; x=1787849528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HVioBH5QCJwrJt+MZmLrqmPfuXJxmj4/iSlks8B/NvY=;
 b=DgXtCcg2uN243nbyQBmYTUhSj2yRV5qUTjhF4kIvL1UrdbsaLgGU/r4qKbaz/usnHK
 WMVcTGnB3wUA0xjNx6WF+dC/UwCnxcVLQGft7vOoVb/znxLtiEGokACFMZphxhyU56hh
 jjun8GcxfMGNcut6CMSub8qcGmJ3LttM0YGdiaES7xuA0ckaoV9T60NIHYkx7LB7bEz+
 uXv+c9r/L1xs8Emwl5NIzQNzYpwUykeI6bWsN8aT87ge9z6CH2gIEmSzuor99nWXzw3z
 I+1RNoVrzpahARtiiKGcgJehgjOPOe7MJMkCprlarH29bZdZGsTfyOLuO4JWHdZfqJNR
 Ed8g==
X-Gm-Message-State: AOJu0YxZoYQ2ivw6mndFCx/Nsh170q1xAZl1ALbhNYQVfCLFFceoIT5O
 wU6OtKGzmegh4NldvlctiFwmY6YgFOzBKVcKiezrH+gUoyYCHfhDHQf1MWt1oCf2XSkAXPzuWOM
 eiB1wWf/ovWy+KBJaND6qqOO8km2QgIWNzC9XUjyTWJQsNsdZR3zgv93AKs1sy3zXl3Fs2K4+LP
 WGbQ4RF5LH/BfyUFXSEMctCYWt73mpIYVX4ePv5VO7
X-Gm-Gg: AR+sD13Jv5SaL6k5x0cJiM6QPzkZdtcgUwQ6QD338sZ/w1KwlKgZeYWb2KzWxNn9jo2
 g8lPoKzSJAmHLwrKKDoedf4RUXkKoN/L4BxTsY2hEwdFxLlNcz+34d1LJ1dR/eoCgY1rcLPs+G3
 dNXNxlDo1GHOks9JFQ0xeBF86YryzH77XXCFQnuRfg3bc+JDS741DUc1pOwuTLYl+iqWETiSea/
 GVuRBvkFml4Tv8lN/F9CPEknpMvHNxTZr/NTNV3uxVu3KaG5SBrxUnLGN3pB0chS7AS+hTS1uW3
 lAnmeQVg5meX1/5YsIo4Z79BRpPud2loDKvZNpvOxmxnIZEcVxERuNzEXZZV/hAgsN5vp/JGq5O
 SJT27J4h6Y4VnrdH3xNxDKl6+sxvZFcXekrv+kzpeUm5K+DHzJehTBKeLWpJJ+/nd9DULTzLuUV
 LAVM8=
X-Received: by 2002:a05:600c:1d1a:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-499b8303b86mr4275275e9.4.1787244727825; 
 Thu, 20 Aug 2026 09:52:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1a:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-499b8303b86mr4273335e9.4.1787244726935; 
 Thu, 20 Aug 2026 09:52:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm142821855e9.13.2026.08.20.09.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 46/53] rust: switch to autogenerated meson rules
Date: Thu, 20 Aug 2026 18:49:49 +0200
Message-ID: <20260820164957.1895963-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Disable Meson's use of the nightly-only option "--env-set".  It is
buggy and anyway it should not be there in future version.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                                   |  3 +-
 scripts/get-wraps-from-cargo-registry.py      |  6 ---
 subprojects/anyhow-1-rs.wrap                  |  3 ++
 subprojects/arbitrary-int-1-rs.wrap           |  1 -
 subprojects/attrs-0.2-rs.wrap                 |  1 -
 subprojects/bilge-0.2-rs.wrap                 |  1 -
 subprojects/bilge-impl-0.2-rs.wrap            |  1 -
 subprojects/either-1-rs.wrap                  |  1 -
 subprojects/foreign-0.3-rs.wrap               |  1 -
 subprojects/glib-sys-0.21-rs.wrap             |  1 -
 subprojects/itertools-0.11-rs.wrap            |  1 -
 subprojects/libc-0.2-rs.wrap                  |  3 ++
 .../packagefiles/anyhow-1-rs/meson.build      | 33 --------------
 .../anyhow-1-rs/meson/meson.build             |  9 ++++
 .../arbitrary-int-1-rs/meson.build            | 21 ---------
 .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------------
 .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------------
 .../bilge-impl-0.2-rs/meson.build             | 44 -------------------
 .../packagefiles/either-1-rs/meson.build      | 26 -----------
 .../packagefiles/foreign-0.3-rs/meson.build   | 26 -----------
 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------------
 .../itertools-0.11-rs/meson.build             | 32 --------------
 .../packagefiles/libc-0.2-rs/meson.build      | 37 ----------------
 .../libc-0.2-rs/meson/meson.build             | 16 +++++++
 .../packagefiles/probe-0.5-rs/meson.build     | 22 ----------
 .../proc-macro-error-1-rs/meson.build         | 41 -----------------
 .../proc-macro-error-1-rs/meson/meson.build   |  3 ++
 .../proc-macro-error-attr-1-rs/meson.build    | 31 -------------
 .../packagefiles/proc-macro2-1-rs/meson.build | 35 ---------------
 .../proc-macro2-1-rs/meson/meson.build        |  6 +++
 .../packagefiles/quote-1-rs/meson.build       | 31 -------------
 subprojects/packagefiles/syn-2-rs/meson.build | 43 ------------------
 .../unicode-ident-1-rs/meson.build            | 22 ----------
 subprojects/probe-0.5-rs.wrap                 |  1 -
 subprojects/proc-macro-error-1-rs.wrap        |  2 +-
 subprojects/proc-macro-error-attr-1-rs.wrap   |  1 -
 subprojects/proc-macro2-1-rs.wrap             |  2 +-
 subprojects/quote-1-rs.wrap                   |  1 -
 subprojects/syn-2-rs.wrap                     |  1 -
 subprojects/unicode-ident-1-rs.wrap           |  1 -
 40 files changed, 44 insertions(+), 563 deletions(-)
 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build

diff --git a/meson.build b/meson.build
index 2a289960ee8..2139dfc7ce8 100644
--- a/meson.build
+++ b/meson.build
@@ -4,7 +4,8 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
 
                           # build.rust_std breaks with older meson, but Rust does not
                           # support old meson anyway
-                          (meson.version().version_compare('>= 1.9') ? ['rust_std=2021', 'build.rust_std=2021'] : []),
+                          (meson.version().version_compare('>= 1.9') ? ['rust_std=2021', 'build.rust_std=2021',
+                                                                        'rust_nightly=disabled'] : []),
 
         version: files('VERSION'))
 
diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 31eed5c2dd4..78b6f1f7ae2 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -116,12 +116,6 @@ def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
             patch_dir = config["wrap-file"]["patch_directory"]
             patch_dir = os.path.join("packagefiles", patch_dir)
             _, ver = registry_namever.rsplit("-", 1)
-            subprocess.run(
-                ["meson", "rewrite", "kwargs", "set", "project", "/", "version", ver],
-                cwd=patch_dir,
-                env=env,
-                check=True,
-            )
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
diff --git a/subprojects/anyhow-1-rs.wrap b/subprojects/anyhow-1-rs.wrap
index fb4603e74c8..dbb28f4133b 100644
--- a/subprojects/anyhow-1-rs.wrap
+++ b/subprojects/anyhow-1-rs.wrap
@@ -5,3 +5,6 @@ source_filename = anyhow-1.0.98.tar.gz
 source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
 method = cargo
 patch_directory = anyhow-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
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
index 4ff4c424e6b..fef89ea9368 100644
--- a/subprojects/attrs-0.2-rs.wrap
+++ b/subprojects/attrs-0.2-rs.wrap
@@ -4,4 +4,3 @@ source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
 source_filename = attrs-0.2.9.tar.gz
 source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
 method = cargo
-patch_directory = attrs-0.2-rs
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
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index b3dbfafb265..f8963eba73f 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
 source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 method = cargo
-patch_directory = bilge-impl-0.2-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
index 1c74a95645f..51c97df1531 100644
--- a/subprojects/either-1-rs.wrap
+++ b/subprojects/either-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/either/1.12.0/download
 source_filename = either-1.12.0.tar.gz
 source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
 method = cargo
-patch_directory = either-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
index a5fec6c09df..95d450397ee 100644
--- a/subprojects/foreign-0.3-rs.wrap
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -4,4 +4,3 @@ source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
 source_filename = foreign-0.3.1.tar.gz
 source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
 method = cargo
-patch_directory = foreign-0.3-rs
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
index f4e1514af57..ea4d5f66a58 100644
--- a/subprojects/glib-sys-0.21-rs.wrap
+++ b/subprojects/glib-sys-0.21-rs.wrap
@@ -4,4 +4,3 @@ source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
 source_filename = glib-sys-0.21.2.tar.gz
 source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
 method = cargo
-patch_directory = glib-sys-0.21-rs
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
index 6fe89d17caa..e123ab389a2 100644
--- a/subprojects/itertools-0.11-rs.wrap
+++ b/subprojects/itertools-0.11-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
 source_filename = itertools-0.11.0.tar.gz
 source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
 method = cargo
-patch_directory = itertools-0.11-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
index 488330178ed..6e225579795 100644
--- a/subprojects/libc-0.2-rs.wrap
+++ b/subprojects/libc-0.2-rs.wrap
@@ -5,3 +5,6 @@ source_filename = libc-0.2.162.tar.gz
 source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
 method = cargo
 patch_directory = libc-0.2-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
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
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
deleted file mode 100644
index e6ea69533b7..00000000000
--- a/subprojects/packagefiles/probe-0.5-rs/meson.build
+++ /dev/null
@@ -1,22 +0,0 @@
-project('probe-0.5-rs', 'rust',
-  meson_version: '>=1.5.0',
-  version: '0.5.2',
-  license: 'Apache-2.0 OR MIT',
-  default_options: [])
-
-_probe_rs = static_library(
-  'probe',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cap-lints', 'allow',
-  ],
-)
-
-probe_deps = declare_dependency(
-  link_with: _probe_rs,
-)
-
-meson.override_dependency('probe-0.5-rs', probe_deps)
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
index d3c6b187244..72e771ec787 100644
--- a/subprojects/probe-0.5-rs.wrap
+++ b/subprojects/probe-0.5-rs.wrap
@@ -4,4 +4,3 @@ source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
 source_filename = probe-0.5.2.tar.gz
 source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
 method = cargo
-patch_directory = probe-0.5-rs
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
index 4f300c3ac41..e57921bfadc 100644
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ b/subprojects/proc-macro-error-1-rs.wrap
@@ -7,4 +7,4 @@ method = cargo
 patch_directory = proc-macro-error-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
index 739e451c37b..456d2c2b6d4 100644
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ b/subprojects/proc-macro-error-attr-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/downloa
 source_filename = proc-macro-error-attr-1.0.4.tar.gz
 source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
 method = cargo
-patch_directory = proc-macro-error-attr-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 3600f4eb191..676d1a3a8ca 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -7,4 +7,4 @@ method = cargo
 patch_directory = proc-macro2-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
index 10626be6521..5f38f56499e 100644
--- a/subprojects/quote-1-rs.wrap
+++ b/subprojects/quote-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
 source_filename = quote-1.0.36.0.tar.gz
 source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
 method = cargo
-patch_directory = quote-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index db6576f5812..4b97bed258f 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
 source_filename = syn-2.0.104.0.tar.gz
 source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
 method = cargo
-patch_directory = syn-2-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
index b420ebfe1f4..90aae02ba0a 100644
--- a/subprojects/unicode-ident-1-rs.wrap
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -4,7 +4,6 @@ source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
 source_filename = unicode-ident-1.0.12.tar.gz
 source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
 method = cargo
-patch_directory = unicode-ident-1-rs
 
 # bump this version number on every change to meson.build or the patches:
 # v2
-- 
2.55.0


