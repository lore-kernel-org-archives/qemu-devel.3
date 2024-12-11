Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D94E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZ5-0001fR-Nn; Wed, 11 Dec 2024 11:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYu-0000VH-Ce
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYq-0000F2-Qt
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+KSm+Bbgkjh6xkJkmH8LuJ1hbwlcHQrSiZuvza+mjs=;
 b=Zd1W/44us+q9lBFz2LDiSdQItJK3R+vNJ3znRk5s8xo2aBsm5G3O+SgiO3zObo4MUhSvQS
 X0b0asYlfR7F+rvFZgaBMbd5Rb5oMZIW1TbvWYGlPKM6iKrvmWobQFTc5dlC+634EHiS/4
 2r57PP75G3C7C7vrr1ExM4hy0Ka8FBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Ew-Mg1QTMTKX1TSoKTGDmw-1; Wed, 11 Dec 2024 11:27:37 -0500
X-MC-Unique: Ew-Mg1QTMTKX1TSoKTGDmw-1
X-Mimecast-MFC-AGG-ID: Ew-Mg1QTMTKX1TSoKTGDmw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so374150f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934456; x=1734539256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+KSm+Bbgkjh6xkJkmH8LuJ1hbwlcHQrSiZuvza+mjs=;
 b=gApdWBFdy+c/4goy8oTbQRjCvVMGgEmZ9uUhF98MbDDeiXjeqySp5uy3WpwaAFlwDt
 L6Y7dQOdIGGyU2X/NNdps9gcWXLf4mhrLfQUsW3zuOYytGiUvGTmC72JOUTgqp9GgWFz
 kBRlodHu5OYvO9rCDvmvOpAyDOfTHs4VtWUrWiz563V66cA8dSC3pCLzAGFY+xqMpPCo
 rtElz3siQiNdjxpISzCNh/Q6s+jRcy35yK6FilQlk7a6nIvkOghN+WutEr2+NuGOQf9T
 KmkMBu//Ls1Pumked3imHuVidJEsYI+Fxo5+8zMCaqU+IHPN/o62CBNfq3+BxifHci1g
 Wq3A==
X-Gm-Message-State: AOJu0Ywj5DWAJIevE7FeHNXQ+8fZAR5J090kU1GZPXaru0eOYyJUkJdO
 qHizudpV7UpI4gIR3tis3I9Xvkyu7CgPxRynRgrO5dJ+DsZEFnTrb9sE/5oUveaqHrgVsD/2nQ5
 6cRU+0/cuFabgO508pwRs1nLwmE/ev4svOczYBN41z58KsAacqCNOd0q+D8mnNlxyaH3bHjGwzm
 X06NS0UE5Qt7OItgnjxTCoEwevHvCa5UGD2PUH
X-Gm-Gg: ASbGnct+2SF0qv+a4aTTQirg8/B8QKRo+H//4HyVBX6uXD3d4zcP4z5cDkrZ3e9n7fN
 /2okY7nkr6Q/8M9rBx2bO0Ia73IrEahTUpxMZy1cRK2vQsihPZaNFWHJYA6b2NJFmyiu5zpiBGN
 oipCyx3faNHg0qNQW8vdUtgvI3ic///yNeLSU5Fmhilwg8mX/gqEojh9bB81RHp4xkM6bRmEKfY
 01ndIxlrJTGZ/Hy74d2WsqwCJPgGwdo3OlwrDMeZ01hGLFzoXcZhBbD
X-Received: by 2002:a05:6000:2a7:b0:385:e17a:ce61 with SMTP id
 ffacd0b85a97d-3864ced37d6mr3463213f8f.53.1733934456099; 
 Wed, 11 Dec 2024 08:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE28wpQAp7PzxHpAIfTHwYeSW9kVTW2HCZP4xPiqLGxMUDODANToF2Tb6m70R59/f/ii9r0uQ==
X-Received: by 2002:a05:6000:2a7:b0:385:e17a:ce61 with SMTP id
 ffacd0b85a97d-3864ced37d6mr3463194f8f.53.1733934455592; 
 Wed, 11 Dec 2024 08:27:35 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4ea3sm1618415f8f.28.2024.12.11.08.27.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/49] rust: build: generate lint flags from Cargo.toml
Date: Wed, 11 Dec 2024 17:26:36 +0100
Message-ID: <20241211162720.320070-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Cargo.toml makes it possible to describe the desired lint level settings
in a nice format.  We can extend this to Meson-built crates, by teaching
rustc_args.py to fetch lint and --check-cfg arguments from Cargo.toml.
--check-cfg arguments come from the unexpected_cfgs lint as well as crate
features

Start with qemu-api, since it already has a [lints.rust] table and
an invocation of rustc_args.py.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  3 +-
 rust/qemu-api/meson.build  |  4 +-
 scripts/rust/rustc_args.py | 83 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 2f1f2aece4d..1e1d8f5cd61 100644
--- a/meson.build
+++ b/meson.build
@@ -120,7 +120,8 @@ if have_rust
 endif
 
 if have_rust
-  rustc_args = find_program('scripts/rust/rustc_args.py')
+  rustc_args = [find_program('scripts/rust/rustc_args.py'),
+    '--rustc-version', rustc.version()]
   rustfmt = find_program('rustfmt', required: false)
 
   # Prohibit code that is forbidden in Rust 2024
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2ff6d2ce3d0..1ed79672cc9 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,6 +1,6 @@
 _qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().split()
+  '--config-headers', config_host_h, '--features', '--lints', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
 
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 942dd2b2bab..9b9778a1cac 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -25,9 +25,10 @@
 """
 
 import argparse
+from dataclasses import dataclass
 import logging
 from pathlib import Path
-from typing import Any, Iterable, Mapping, Optional, Set
+from typing import Any, Iterable, List, Mapping, Optional, Set
 
 try:
     import tomllib
@@ -61,6 +62,45 @@ def get_table(self, key: str) -> Mapping[Any, Any]:
         return table
 
 
+@dataclass
+class LintFlag:
+    flags: List[str]
+    priority: int
+
+
+def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
+    """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
+
+    toml_lints = cargo_toml.lints
+
+    lint_list = []
+    for k, v in toml_lints.items():
+        prefix = "" if k == "rust" else k + "::"
+        for lint, data in v.items():
+            level = data if isinstance(data, str) else data["level"]
+            priority = 0 if isinstance(data, str) else data.get("priority", 0)
+            if level == "deny":
+                flag = "-D"
+            elif level == "allow":
+                flag = "-A"
+            elif level == "warn":
+                flag = "-W"
+            elif level == "forbid":
+                flag = "-F"
+            else:
+                raise Exception(f"invalid level {level} for {prefix}{lint}")
+
+            # This may change if QEMU ever invokes clippy-driver or rustdoc by
+            # hand.  For now, check the syntax but do not add non-rustc lints to
+            # the command line.
+            if k == "rust":
+                lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
+
+    lint_list.sort(key=lambda x: x.priority)
+    for lint in lint_list:
+        yield from lint.flags
+
+
 def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
@@ -97,13 +137,54 @@ def main() -> None:
         dest="cargo_toml",
         help="path to Cargo.toml file",
     )
+    parser.add_argument(
+        "--features",
+        action="store_true",
+        dest="features",
+        help="generate --check-cfg arguments for features",
+        required=False,
+        default=None,
+    )
+    parser.add_argument(
+        "--lints",
+        action="store_true",
+        dest="lints",
+        help="generate arguments from [lints] table",
+        required=False,
+        default=None,
+    )
+    parser.add_argument(
+        "--rustc-version",
+        metavar="VERSION",
+        dest="rustc_version",
+        action="store",
+        help="version of rustc",
+        required=False,
+        default="1.0.0",
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
     logging.debug("args: %s", args)
 
+    rustc_version = tuple((int(x) for x in args.rustc_version.split('.')[0:2]))
     cargo_toml = CargoTOML(args.cargo_toml)
 
+    if args.lints:
+        for tok in generate_lint_flags(cargo_toml):
+            print(tok)
+
+    if rustc_version >= (1, 80):
+        if args.lints:
+            for cfg in sorted(cargo_toml.check_cfg):
+                print("--check-cfg")
+                print(cfg)
+        if args.features:
+            for feature in cargo_toml.get_table("features"):
+                if feature != "default":
+                    print("--check-cfg")
+                    print(f'cfg(feature,values("{feature}"))')
+
     for header in args.config_headers:
         for tok in generate_cfg_flags(header, cargo_toml):
             print(tok)
-- 
2.47.1


