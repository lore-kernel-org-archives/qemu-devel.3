Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20475D64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJG-0001y0-9M; Fri, 08 Nov 2024 13:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ5-0001us-Vi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ4-0001wN-3P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdoMcphvzb4FCO/Yj14yAl+KR/E0sA02B9InmeKS0lc=;
 b=gD6FYhYpmCPVlEv6EYSctpjFRt4m26VQcbIyzOJe0nUjpw4h1jE1L1Y59FNqnTuZA0BVyG
 rHLvcopQMjPgdeCPZxk2FUMCsq9Z/d3L1ZO/fV6keYoKEYuH92It0dRxE1wtiaHmLEPdpc
 LUS2GpRh7Q+F/n9NfOnVmgg7shV7OFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-T429-Gt2PomWSXnhWknRDA-1; Fri, 08 Nov 2024 13:02:00 -0500
X-MC-Unique: T429-Gt2PomWSXnhWknRDA-1
X-Mimecast-MFC-AGG-ID: T429-Gt2PomWSXnhWknRDA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso14197195e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088918; x=1731693718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdoMcphvzb4FCO/Yj14yAl+KR/E0sA02B9InmeKS0lc=;
 b=AmEFwom3yMzZyIn17eIY/1tHD7eZgTJs8wpPH/NxcgsWgp/lK7rstIh51WwIgPrIjD
 34TRD5ig9ckXfQmXjbQ38X3b5AIoDGsdKraBV6DqJySKzVNSqvJs92AeAqYAf3ijl55S
 vzYlF31UPjKZzdem6zYCDX+v7uxqR5b4xD40nEvKHpCTK7Q06ocepl5kuIe9VefLO+Uh
 i25A+Ok3PQZJqw1KoSR+EcTr9t0QRB2wGRIeL11XgaaXglM1DdqCze6bHZzb1CF7e4Im
 2qBYZSbC5O9TlIi05gbI6tOoReMnnSjo+SJEAHooC+m7e89sCQL4SvC6jFMjz7j/Q/Tq
 lwFw==
X-Gm-Message-State: AOJu0YzvIv62XlryS5dcfYtjl4bly2kfMb9zK6OBJ5HT4Z6bUktARE6m
 8RXB30mRQ7YDaQ2aCRbySjZ1XXFDTstErTHEOOJdZgtK48SC7U7JYT7RA0sgFKIYKyBdk0S/YaP
 ZMju56vjbTpwa6OfLyJiJfy4KQG5gVlaaeb+esVy6UVhStgN8/P9t75FjfYAktjjhL0RlP4M2AM
 K2sDJwAsrCw2rznRo5Wy37VB76aOqQ6zL9vLsmRNI=
X-Received: by 2002:a05:600c:1f93:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-432b74c0f85mr31658965e9.10.1731088917893; 
 Fri, 08 Nov 2024 10:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj7aT8Q063crw88yC0aKXCGIzp0hTxGWu1PxRM4J+7kfe0o9SCGejKh0ylEFebChKsFXkwqg==
X-Received: by 2002:a05:600c:1f93:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-432b74c0f85mr31658365e9.10.1731088917317; 
 Fri, 08 Nov 2024 10:01:57 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053069fsm80657835e9.4.2024.11.08.10.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 06/11] rust: build: move strict lints handling to
 rustc_args.py
Date: Fri,  8 Nov 2024 19:01:34 +0100
Message-ID: <20241108180139.117112-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Make Cargo use unknown_lints = "allow" as well.  This is more future
proof as we might add new lints to rust/Cargo.toml that are not supported
by older versions of rustc or clippy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                | 12 ++++--------
 rust/Cargo.toml            |  6 ++++++
 scripts/rust/rustc_args.py | 19 ++++++++++++++++---
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 5726135b324..1239f5c48c1 100644
--- a/meson.build
+++ b/meson.build
@@ -122,20 +122,16 @@ endif
 if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
     '--workspace', meson.project_source_root() / 'rust']
+  if get_option('strict_rust_lints')
+    rustc_args += ['--strict-lints']
+  endif
+
   rustfmt = find_program('rustfmt', required: false)
 
   rustc_lint_args = run_command(rustc_args,
      '--lints', files('rust/Cargo.toml'),
      capture: true, check: true).stdout().strip().splitlines()
 
-  # Occasionally, we may need to silence warnings and clippy lints that
-  # were only introduced in newer Rust compiler versions.  Do not croak
-  # in that case; a CI job with rust_strict_lints == true ensures that
-  # we do not have misspelled allow() attributes.
-  if not get_option('strict_rust_lints')
-    rustc_lint_args += ['-A', 'unknown_lints']
-  endif
-
   # Apart from procedural macros, our Rust executables will often link
   # with C code, so include all the libraries that C code needs.  This
   # is safe; https://github.com/rust-lang/rust/pull/54675 says that
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0230b92a9fa..1ff8f5c2781 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -11,5 +11,11 @@ unexpected_cfgs = { level = "warn", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
     'cfg(has_offset_of)'] }
 
+# Occasionally, we may need to silence warnings and clippy lints that
+# were only introduced in newer Rust compiler versions.  Do not croak
+# in that case; a CI job with rust_strict_lints == true disables this
+# and ensures that we do not have misspelled allow() attributes.
+unknown_lints = "allow"
+
 # Prohibit code that is forbidden in Rust 2024
 unsafe_op_in_unsafe_fn = "deny"
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 26733439ed4..1f8b05b8001 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -35,6 +35,8 @@
 except ImportError:
     import tomli as tomllib
 
+STRICT_LINTS = {"unknown_lints", "warnings"}
+
 
 class CargoTOML:
     tomldata: Mapping[Any, Any]
@@ -77,7 +79,7 @@ class LintFlag:
     priority: int
 
 
-def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
+def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[str]:
     """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
 
     toml_lints = cargo_toml.lints
@@ -102,9 +104,13 @@ def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
             # This may change if QEMU ever invokes clippy-driver or rustdoc by
             # hand.  For now, check the syntax but do not add non-rustc lints to
             # the command line.
-            if k == "rust":
+            if k == "rust" and not (strict_lints and lint in STRICT_LINTS):
                 lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
 
+    if strict_lints:
+        for lint in STRICT_LINTS:
+            lint_list.append(LintFlag(flags=["-D", lint], priority=1000000))
+
     lint_list.sort(key=lambda x: x.priority)
     for lint in lint_list:
         yield from lint.flags
@@ -181,6 +187,13 @@ def main() -> None:
         required=False,
         default="1.0.0",
     )
+    parser.add_argument(
+        "--strict-lints",
+        action="store_true",
+        dest="strict_lints",
+        help="apply stricter checks (for nightly Rust)",
+        default=False,
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
@@ -194,7 +207,7 @@ def main() -> None:
         cargo_toml = CargoTOML(args.cargo_toml, None)
 
     if args.lints:
-        for tok in generate_lint_flags(cargo_toml):
+        for tok in generate_lint_flags(cargo_toml, args.strict_lints):
             print(tok)
 
     if rustc_version >= (1, 80):
-- 
2.47.0


