Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84614D116F5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwC-0006c4-2U; Thu, 27 Nov 2025 08:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvj-0005dM-UU
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvg-000284-JC
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35cW+AZMPXzQdRbMH+IdIxqC+JST8jSEuSl2qWTOWks=;
 b=T+uO4cp98xD1lWMC5n54Aha/DksMS1EP4PGSBGkAJwH0TCMGxISDjrEbS21C7MqZc+1zYp
 Th/CPALv6dcq5lABIV3TDwMg8PDvqG9b4RuW5vFIxf57n2gCpoMCo0B/JRc5zEeLy+WvJ/
 vrObl7s6wmOJDVHlAYXHILsu0rN0YiI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-c-OhUnlWNxaBrz9DRHw4HQ-1; Thu, 27 Nov 2025 08:20:57 -0500
X-MC-Unique: c-OhUnlWNxaBrz9DRHw4HQ-1
X-Mimecast-MFC-AGG-ID: c-OhUnlWNxaBrz9DRHw4HQ_1764249656
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b70b1778687so66651466b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249656; x=1764854456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35cW+AZMPXzQdRbMH+IdIxqC+JST8jSEuSl2qWTOWks=;
 b=AbUhf2c6BFCvURO3nxuIzJFb1EIp1Fk/WEYhEmYgJCHda9rgBYvxRiUoyrX0vJG4qy
 T7FE7Mxdzfk2ZTm5HRaLV4HEq5W7pe8gpb9l422t2xvCGWq2/9yONd0moLCyU0fqFyRL
 Iwampp12nxmD8ndZDR6DugAITrpUykGeNG8H812z8hf5aeSvcuPYNWZey/dIxZZaPxjH
 aMxcuB9j+Xa8gzVo6riM8vl7NdxrwyWN+WY/uOYS5L8sa0wKsL9oNXnmC8B1m0N36mJX
 nc4k73Mmim2QUHFpL0piui/r2Gkh83aa67gE6cH32GwdQDKQeTGt9HaVZxCUn7Na2dKZ
 5Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249656; x=1764854456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=35cW+AZMPXzQdRbMH+IdIxqC+JST8jSEuSl2qWTOWks=;
 b=BdCyrHslDKRZAqM2zotX3q7dxEHtDQV25dEEd5fjdQhvv3gXefo9HKLd54kJyXcf7F
 hj+SP8W50pNqjMjYVGR6Cdx9zv0bR3p7crIr7rqE7wxeteUs+3E/GAgKKOnlkIAjnMgQ
 HGKbvjRjZ9Ddj0AheK9fkQgqWf6zHMWwvE9lWfXH6JjJa9V6hZ52WP1qrHWYriXGDrij
 aAUZDih/fDTskCxH2erHRNub8sII/rZFocnouxfXnlEwTxNRLI5qkWHNJEEUNz2S2ekF
 rSoADOwbI4BsgT6RMhOTyKwIjEjeOKyOToBgvPyGcYLWJW8th1pldi0duH3owBzNGsly
 9Zmw==
X-Gm-Message-State: AOJu0Yx1Q/ohg9Uj8okzwNvu9Yu40Pc2HQKE+QQClCNAcw1APRP+dAUa
 ykRsobz2RDMQC7Hqk+dgZcQ9Xni35TfWYg7sgRdB9Yx1kWOY82Z/khjMeR6/lNDPB1gixESgS2i
 FijwtLjtXP5NUZ06ZxdXqtH36t0yuRnVuL1Jpf3eU9Y1iaJ4A5VPrjQg2/8em/bR7g8bfpMazhT
 2IQj5DwIumGv5lwCT4V7yJvjSh6OJVyVDjjiywodUU
X-Gm-Gg: ASbGncvM03wPAdTgkHZ8TfYatRfK2MNSUxHgwchO7ZPYa+3KTCw4Sr90VN/YnsCf4kD
 OdjuxVO6QRn8315f/XeuD9XEzNd31Pi2CAHBz+9TohsW+W5KhNgEJk9ftVNy6Qy39QElU0IwiVC
 gE17C1u38XYl25NBIzLru7w5Dw9nVSI5X33p/Wuf7yvifvKQv/llUHMl7HeJeXHCgCoXscRfdhU
 yTrLCZblAwbYvmPFvWD19vmkW71COVAs2HeC0WSCI0N8Kh4/6Dbk+Q+O/gKlbGIPjgLxU7t2M8B
 Jq01BqYBxVz7R3XJDLS28hEDX26pYrVqwnUQ0cfk+UBCUpUtVf6KFse9BKQfeSlst0M4h+locm+
 4D3YCB7p2QmFiEwwRlHRHyCPfIxf60qcciyG50Ln/LYT1ILYS5PutJW/5bcYAwxhUXEfwgv8sSX
 DymVBnjSKQztKCVjs=
X-Received: by 2002:a17:907:2d11:b0:b73:853d:540e with SMTP id
 a640c23a62f3a-b767170c823mr2707245666b.30.1764249655063; 
 Thu, 27 Nov 2025 05:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLkSAX/ex76yeg+naPEWLopgu3EY8SdxOS3m/Q7KCanmYDR6Wnsq+TcIYxujg2u6gn2qQCRQ==
X-Received: by 2002:a17:907:2d11:b0:b73:853d:540e with SMTP id
 a640c23a62f3a-b767170c823mr2707242666b.30.1764249654592; 
 Thu, 27 Nov 2025 05:20:54 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5162c5csm168898566b.6.2025.11.27.05.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/9] rust: move strict lints handling to meson.build
Date: Thu, 27 Nov 2025 14:20:34 +0100
Message-ID: <20251127132036.84384-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Simplify rustc_args.py, and align its code with what Meson's own Cargo.toml
translator does in v1.10.

Bump unknown_lints to "forbid", so that it will certainly override Cargo.toml's
"allow" level.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  7 +++----
 scripts/rust/rustc_args.py | 20 ++------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/meson.build b/meson.build
index 270181038bf..e6a11cefdb7 100644
--- a/meson.build
+++ b/meson.build
@@ -128,14 +128,13 @@ if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
     '--rustc-version', rustc.version(),
     '--workspace', meson.project_source_root() / 'rust']
-  if get_option('strict_rust_lints')
-    rustc_args += ['--strict-lints']
-  endif
-
   rustfmt = find_program('rustfmt', required: false)
 
   rustc_lint_args = run_command(rustc_args, '--lints',
      capture: true, check: true).stdout().strip().splitlines()
+  if get_option('strict_rust_lints')
+    rustc_lint_args += ['-Dwarnings', '-Funknown_lints']
+  endif
 
   # Apart from procedural macros, our Rust executables will often link
   # with C code, so include all the libraries that C code needs.  This
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 63b0748e0d3..8fb77785350 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -35,8 +35,6 @@
 except ImportError:
     import tomli as tomllib
 
-STRICT_LINTS = {"unknown_lints", "warnings"}
-
 
 class CargoTOML:
     tomldata: Mapping[Any, Any]
@@ -82,7 +80,7 @@ class LintFlag:
     priority: int
 
 
-def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[str]:
+def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
 
     toml_lints = cargo_toml.lints
@@ -104,13 +102,6 @@ def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[s
             else:
                 raise Exception(f"invalid level {level} for {prefix}{lint}")
 
-            if not (strict_lints and lint in STRICT_LINTS):
-                lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
-
-    if strict_lints:
-        for lint in STRICT_LINTS:
-            lint_list.append(LintFlag(flags=["-D", lint], priority=1000000))
-
     lint_list.sort(key=lambda x: x.priority)
     for lint in lint_list:
         yield from lint.flags
@@ -187,13 +178,6 @@ def main() -> None:
         required=False,
         default="1.0.0",
     )
-    parser.add_argument(
-        "--strict-lints",
-        action="store_true",
-        dest="strict_lints",
-        help="apply stricter checks (for nightly Rust)",
-        default=False,
-    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
@@ -207,7 +191,7 @@ def main() -> None:
         cargo_toml = CargoTOML(args.cargo_toml, None)
 
     if args.lints:
-        for tok in generate_lint_flags(cargo_toml, args.strict_lints):
+        for tok in generate_lint_flags(cargo_toml):
             print(tok)
 
     if rustc_version >= (1, 80):
-- 
2.51.1


