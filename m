Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74119C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u12Z3-00037t-Ef; Sat, 05 Apr 2025 08:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u12Yz-00037h-DD
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 08:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u12Yx-0006A3-Fw
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 08:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743855829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9Egx7ciCkAn3Id3UgmQxvHL/Kh+qnwFknbviknhEAA=;
 b=RbMMJrAUS4/Oyn5P72w553nLj6M7r2aG+Z2mfekvq/6iu1T0orichHoz2dZPiZrISoc3mz
 +9DElpUTvPvPsN92gvLjvpUZhefJALEpmKSgQkHsJ3/90nadyiRmoqPYwmEbLYI3pcRiFQ
 yiOrSK3XDHUgwc8SdyYselTjouMwG0E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-s3fWEwd6McaXgCGNxFozzA-1; Sat, 05 Apr 2025 08:23:46 -0400
X-MC-Unique: s3fWEwd6McaXgCGNxFozzA-1
X-Mimecast-MFC-AGG-ID: s3fWEwd6McaXgCGNxFozzA_1743855826
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac3db5469fbso233712566b.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743855825; x=1744460625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9Egx7ciCkAn3Id3UgmQxvHL/Kh+qnwFknbviknhEAA=;
 b=VwCzIBb/fnCdN12uzQwxWM/R098+5+Z1jN6qfIyJ1FIeL39LbVnLMypPaNtri0vJbJ
 f+FLfpn54GlSl8vA4ad+f25ySSyE+6VmQZCaKCztoTcBmawzlIrs2JPmSu5WVJbrvpi9
 hcpea5HcBS/LrRhgulcxWaztgqRS7y8i7xVjmfM/4yzHhZiK5dC+mmQ32qfZxQBogKb6
 kAD/e7NQdnebie9QH5iPeYhPq23LZXi63JzgLQ6W7FiZXZG34lTTfBaY+Jz4I7zLRxer
 e90q9kjNX9f241/OD666vzA1WH/jH/pkhdZL7Lw3eObJkxdS0G0I3zk67TxchQJQANU7
 4D5g==
X-Gm-Message-State: AOJu0Yx3MftIorQBbeaB/Fdej3GqrRYiKuCSI7xl9stji/p8YsbBelJB
 4mLxPyIrn9UKUMIpmrzGYvA1zkgzQnMkXVlUQrU+QXfnLgVGdPT5BwNwTX9QQWSsPMmkdKxel6P
 ALUlMemMTUvTKBXaZ1o0ubUmYiPNy5DGFjP12cA3742HmWNTIFk8M+Ptggjuf7VPEBfL5N1ydyI
 zChvSuPEziAcgZtAc6K6Bc+eGA7AI/PDlmwaPV
X-Gm-Gg: ASbGncvWt/1EHBHatF6nUVml8o2M1qrYMLAgKBbe83zhYktwK8ye2o2u+mGivpy5P6L
 c/wH4mH/04poNiu4gaOjcKMggycDSB2sro4no4El/YgrH494yUgKE4QAjZ2Ml13FHL1vDE+kjEf
 xvIoG/ovKB+LUL3W4GvPmTB9x1ykr3XQLLovtTTUIAL3H9hWCGsVMpS9lV1rYujX6AN0Iyja9Hc
 BjnqMY5Z3r7JgaS1OBASeuJ96uhWvYXn17bLr2LY/9TKYVg3hOg7+08OgeZ48v2ie36woCH3otq
 HfGvVehRvw8uO7D0MfQ7qyFPVLMr9Tct54wo2DqN7flUowVlQy0=
X-Received: by 2002:a17:907:8688:b0:ac3:c59a:413e with SMTP id
 a640c23a62f3a-ac7d6ec546dmr530512066b.55.1743855824667; 
 Sat, 05 Apr 2025 05:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG238YhdF/UV5hOQdHkzrxYD85XDUYSNjQMuMFavLIJOSLMC+mrEXdRu7HAv6Tlxd8uH3RD8w==
X-Received: by 2002:a17:907:8688:b0:ac3:c59a:413e with SMTP id
 a640c23a62f3a-ac7d6ec546dmr530510166b.55.1743855824110; 
 Sat, 05 Apr 2025 05:23:44 -0700 (PDT)
Received: from [192.168.122.1] (93-40-94-249.ip38.fastwebnet.it.
 [93.40.94.249]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0185ba0sm410430966b.151.2025.04.05.05.23.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 05:23:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/3] rust: use native Meson support for clippy and rustdoc
Date: Sat,  5 Apr 2025 14:23:41 +0200
Message-ID: <20250405122341.264763-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Meson has support for invoking clippy and rustdoc on all crates
(1.7.0 for clippy, 1.8.0 for rustdoc).  Use it instead of the
homegrown version.

rustfmt is still not supported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                     |  2 +-
 rust/clippy.toml => clippy.toml |  0
 rust/Cargo.toml                 |  1 -
 rust/meson.build                | 12 ------------
 scripts/rust/rustc_args.py      |  5 +----
 5 files changed, 2 insertions(+), 18 deletions(-)
 rename rust/clippy.toml => clippy.toml (100%)

diff --git a/meson.build b/meson.build
index ce4c947e956..d4a868c5188 100644
--- a/meson.build
+++ b/meson.build
@@ -4241,7 +4241,7 @@ foreach target : target_dirs
                               build_by_default: true,
                               build_always_stale: true)
       rlib = static_library('rust_' + target.underscorify(),
-                            rlib_rs,
+                            structured_sources([], {'.': rlib_rs}),
                             dependencies: target_rust.dependencies(),
                             override_options: ['rust_std=2021', 'build.rust_std=2021'],
                             rust_abi: 'c')
diff --git a/rust/clippy.toml b/clippy.toml
similarity index 100%
rename from rust/clippy.toml
rename to clippy.toml
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ab1185a8143..38870f06c11 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -56,7 +56,6 @@ ignored_unit_patterns = "deny"
 implicit_clone = "deny"
 macro_use_imports = "deny"
 missing_safety_doc = "deny"
-multiple_crate_versions = "deny"
 mut_mut = "deny"
 needless_bitwise_bool = "deny"
 needless_pass_by_ref_mut = "deny"
diff --git a/rust/meson.build b/rust/meson.build
index 91e52b8fb8e..9736ad300bb 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -6,21 +6,9 @@ subdir('hw')
 cargo = find_program('cargo', required: false)
 
 if cargo.found()
-  run_target('clippy',
-    command: [config_host['MESON'], 'devenv',
-              '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'clippy', '--tests'],
-    depends: bindings_rs)
-
   run_target('rustfmt',
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
     depends: bindings_rs)
-
-  run_target('rustdoc',
-    command: [config_host['MESON'], 'devenv',
-              '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'doc', '--no-deps', '--document-private-items'],
-    depends: bindings_rs)
 endif
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 2633157df2a..63b0748e0d3 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -104,10 +104,7 @@ def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[s
             else:
                 raise Exception(f"invalid level {level} for {prefix}{lint}")
 
-            # This may change if QEMU ever invokes clippy-driver or rustdoc by
-            # hand.  For now, check the syntax but do not add non-rustc lints to
-            # the command line.
-            if k == "rust" and not (strict_lints and lint in STRICT_LINTS):
+            if not (strict_lints and lint in STRICT_LINTS):
                 lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
 
     if strict_lints:
-- 
2.49.0


