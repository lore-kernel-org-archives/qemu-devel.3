Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272CDE77184
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZG-000344-PU; Wed, 11 Dec 2024 11:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ7-00023s-JW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ5-0000Ik-MA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yd9TqaYM4lKJdZBLeFrSdM5kPuWm4QjUX5Xc6xf+7Y8=;
 b=eS7ZyBEF8jYBsKIRWSYhpuM40+PkmJLWBzI/NC1FZD3q69YoU4jl1RPdRvPHWmUvz4zf1f
 Tlp4HKvgMcZQy0C9g3qLqN85Tn8f9MAoyPW5VFnvhRYE4hxQFcVDvKoJKY+GV7mlqztFZr
 qoka5/Ay2sL/YKY/JATGmEu37KewlhQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-IhZaCJlLM52sLSQWokl6eA-1; Wed, 11 Dec 2024 11:27:42 -0500
X-MC-Unique: IhZaCJlLM52sLSQWokl6eA-1
X-Mimecast-MFC-AGG-ID: IhZaCJlLM52sLSQWokl6eA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3cdb9d4b1so1164323a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934460; x=1734539260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yd9TqaYM4lKJdZBLeFrSdM5kPuWm4QjUX5Xc6xf+7Y8=;
 b=i//sYQmPeEn7Olh2d3f+qQYYaVYbOpyZqOMzF33tW3SnVRHwXfLdbkkYFKy1bQ7nuT
 Sg8/7fpFiFmYzBVRAH+JSTZjwb+n1x4zasKJo4MdJf3JGof20PExCWZ6XcEhIrT1dvwM
 yWkYmSAqJ6LbDCAqRgrDzsrrAMewhrc7J6co5hox1pPxzFYypcPe3IfPzMXTFxSVLuFE
 LXlhfAhNmIlbdGbsJBbnr6JNJ82ZmWYB8sBQLsXd4Hyase/PWnDWcGseCy+KgMDJrSB+
 brEjSlxkm3LeuKxPMbgy4BImxT+rGHOLXfyK+nvo9gZJWFaG6bfA/5JPAJ+gm3wPI1Y+
 LWPg==
X-Gm-Message-State: AOJu0YwG7g1DXMwCUrwxAhRfjALT7AMV31GbVskeYO2aWEYs23jpWhTn
 YoFXhrBJt+PVTqFVcWmf+4rYMKYE82wqBZtfB9X57I5Kl3W1KJ9BuTxfOsF6DUo2KHpFK8be5LP
 gnxI9LMzvyCMLFgwoWHo6pietd+9LfvBkryCyULrvfs951P5ZgWSOlHeeU13wIi2Wykh5QPJ3fo
 QfEOOMK/IkVV2jZBaa2ZUUliey8nhq9nFJb4q/
X-Gm-Gg: ASbGncvrSkWeUl/L8ofCufLaUDw++rueuEVlTgyL5kTbw66KY/vZRDgC5pIN0UDaqx5
 4aLIzwqZUOwsbY13X3TzNB5DoyAWWCqEG3QcMmWrjSRj65vpzeHzVU+WOJsFwJA2u49/8xrJz6J
 O0z8lRP0VQYshpGvvSGZn4Jnsvxinyr/uuwpei5bUMyUkqRDQZD56xyU4jVU01hCeHQ78fABgwe
 Cwniu2bGyAkZLP8ZXxHhyx4vGxkJA+ag67cWhfElWbVRhOpTGtGqrmS
X-Received: by 2002:a05:6402:5215:b0:5d0:b1c4:7081 with SMTP id
 4fb4d7f45d1cf-5d43317b4eamr3092289a12.4.1733934460027; 
 Wed, 11 Dec 2024 08:27:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB3/zvg9TsUI5Su1pYoD7XrW/AD9beYNGnmv0FbFRt5CdREs7lBQXGhu4S1oCoJcMSbkzTdg==
X-Received: by 2002:a05:6402:5215:b0:5d0:b1c4:7081 with SMTP id
 4fb4d7f45d1cf-5d43317b4eamr3092247a12.4.1733934459504; 
 Wed, 11 Dec 2024 08:27:39 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3eb109bc9sm5930514a12.42.2024.12.11.08.27.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/49] rust: build: move strict lints handling to rustc_args.py
Date: Wed, 11 Dec 2024 17:26:38 +0100
Message-ID: <20241211162720.320070-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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
index 218ae441e38..85f74854735 100644
--- a/meson.build
+++ b/meson.build
@@ -123,19 +123,15 @@ if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
     '--rustc-version', rustc.version(),
     '--workspace', meson.project_source_root() / 'rust']
+  if get_option('strict_rust_lints')
+    rustc_args += ['--strict-lints']
+  endif
+
   rustfmt = find_program('rustfmt', required: false)
 
   rustc_lint_args = run_command(rustc_args, '--lints',
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
index 4bb52bf0bd5..358c517bc56 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -11,5 +11,11 @@ unexpected_cfgs = { level = "deny", check-cfg = [
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
index 9df131a02bd..5525b3886fa 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -35,6 +35,8 @@
 except ImportError:
     import tomli as tomllib
 
+STRICT_LINTS = {"unknown_lints", "warnings"}
+
 
 class CargoTOML:
     tomldata: Mapping[Any, Any]
@@ -80,7 +82,7 @@ class LintFlag:
     priority: int
 
 
-def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
+def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[str]:
     """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
 
     toml_lints = cargo_toml.lints
@@ -105,9 +107,13 @@ def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
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
@@ -184,6 +190,13 @@ def main() -> None:
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
@@ -197,7 +210,7 @@ def main() -> None:
         cargo_toml = CargoTOML(args.cargo_toml, None)
 
     if args.lints:
-        for tok in generate_lint_flags(cargo_toml):
+        for tok in generate_lint_flags(cargo_toml, args.strict_lints):
             print(tok)
 
     if rustc_version >= (1, 80):
-- 
2.47.1


