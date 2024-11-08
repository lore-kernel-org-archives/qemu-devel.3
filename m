Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1457FD64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ6-0001uv-1e; Fri, 08 Nov 2024 13:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ2-0001pQ-U0
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ1-0001w3-5G
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxhgCHPLQNWjm3q9UX6Y4fEbkNDm7Az8YB8FU2F2Ov0=;
 b=OPPPGpKYUQfl1ym0alDSuzt856nO9c0xqslhieiiJPXX64EaM2Jr9EvU0HXqxGDQHKcpvW
 m0lWVlV5t3cPqVtxKK6z5YeDfhAaTzrFHCAI4XuMWjBo4a0ih2kXS1FN5zCN8B0M9Wb1iD
 As1hKxs0EV4E4+nbAsf7V6Dbpsntjn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZGifC13FNsulRPECXw_6pw-1; Fri, 08 Nov 2024 13:01:57 -0500
X-MC-Unique: ZGifC13FNsulRPECXw_6pw-1
X-Mimecast-MFC-AGG-ID: ZGifC13FNsulRPECXw_6pw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43164f21063so15475645e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088916; x=1731693716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxhgCHPLQNWjm3q9UX6Y4fEbkNDm7Az8YB8FU2F2Ov0=;
 b=e0IPELXU+tV2meOe81aABTk6+EqCZhqRNwdEEAWJYWuZTyLOTTsBdz/ejiczxfMoZo
 l+xSxBNopwc4LGzsYpZofDeWB9tb32S01CzrRg+LdS9U9ovV648Fz+6QlcL4P45Ra2It
 vvTzQV6+tngOgnhZLu0U5ucE8rhHkte8ndIpxuesfcOeU/BXDOpMPrNULH4VuQTeWEly
 3x9tQDskkO/4X/OMUXBrAhtfCCaF3k0qlFyYz77P0UgDsjKwvs6t+ZX116K9S+o+QcqC
 bsBxCnMzdoJxVpQQnIQAsnA/o3xmwRV7na7nl5ve+O7rsyrc+05ywOavxLNxvAMQBoyP
 Vvpw==
X-Gm-Message-State: AOJu0Ywp1bWml5inhFT/oO3/JHXZIaNufdLzJxUJnggFmYoJksOfF81A
 kghcy9edTuntMDKirWLOJvPmbz3H6u0eBxFZzNgPCA+1laddus7j1peNNnSycFf1aC10G9y1j+r
 NMeTrMzFTCbjnzu5B5e8MsgJNfjirv2s7zVk8AwZWKIM/6vru9yyjdHhJvSvpGjV7cvO34vgmta
 j9gWg7pysH6IeP7JHIIxlnsJjAOiQaceUjPympjFo=
X-Received: by 2002:a05:600c:5251:b0:431:5f1c:8352 with SMTP id
 5b1f17b1804b1-432b74fc842mr30874945e9.5.1731088915642; 
 Fri, 08 Nov 2024 10:01:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoWfFl7m81wcIo5aOMoYnPF8LluVD0b+f9XkvT+VYIrAT4pTuM0QmDN0pWZqo2PgN5FjXJqw==
X-Received: by 2002:a05:600c:5251:b0:431:5f1c:8352 with SMTP id
 5b1f17b1804b1-432b74fc842mr30874485e9.5.1731088915106; 
 Fri, 08 Nov 2024 10:01:55 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432bbf436ffsm12527375e9.44.2024.11.08.10.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 05/11] rust: cargo: store desired warning levels in
 workspace Cargo.toml
Date: Fri,  8 Nov 2024 19:01:33 +0100
Message-ID: <20241108180139.117112-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

An extra benefit of workspaces is that they allow to place lint level
settings in a single Cargo.toml; the settings are then inherited by
packages in the workspace.

Correspondingly, teach rustc_build_args.py to get the unexpected_cfgs
configuration from the workspace Cargo.toml.

Note that it is still possible to allow or deny warnings per crate or
module, via the #![] attribute syntax.  The rust/qemu-api/src/bindings.rs
file is an example.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                     |  8 +++++---
 rust/Cargo.toml                 |  8 ++++++++
 rust/hw/char/pl011/Cargo.toml   |  3 +++
 rust/qemu-api-macros/Cargo.toml |  3 +++
 rust/qemu-api/Cargo.toml        |  5 ++---
 rust/qemu-api/meson.build       |  2 +-
 scripts/rust/rustc_args.py      | 31 +++++++++++++++++++++++++++----
 7 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 7a9a523467b..5726135b324 100644
--- a/meson.build
+++ b/meson.build
@@ -120,11 +120,13 @@ if have_rust
 endif
 
 if have_rust
-  rustc_args = find_program('scripts/rust/rustc_args.py')
+  rustc_args = [find_program('scripts/rust/rustc_args.py'),
+    '--workspace', meson.project_source_root() / 'rust']
   rustfmt = find_program('rustfmt', required: false)
 
-  # Prohibit code that is forbidden in Rust 2024
-  rustc_lint_args = ['-D', 'unsafe_op_in_unsafe_fn']
+  rustc_lint_args = run_command(rustc_args,
+     '--lints', files('rust/Cargo.toml'),
+     capture: true, check: true).stdout().strip().splitlines()
 
   # Occasionally, we may need to silence warnings and clippy lints that
   # were only introduced in newer Rust compiler versions.  Do not croak
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0c94d5037da..0230b92a9fa 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -5,3 +5,11 @@ members = [
     "qemu-api",
     "hw/char/pl011",
 ]
+
+[workspace.lints.rust]
+unexpected_cfgs = { level = "warn", check-cfg = [
+    'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+    'cfg(has_offset_of)'] }
+
+# Prohibit code that is forbidden in Rust 2024
+unsafe_op_in_unsafe_fn = "deny"
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index a373906b9fb..58f3e859f7e 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -21,3 +21,6 @@ bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index a8f7377106b..5a27b52ee6e 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -20,3 +20,6 @@ proc-macro = true
 proc-macro2 = "1"
 quote = "1"
 syn = { version = "2", features = ["extra-traits"] }
+
+[lints]
+workspace = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index cc716d75d46..669f288d1cb 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -23,6 +23,5 @@ version_check = "~0.9"
 default = []
 allocator = []
 
-[lints.rust]
-unexpected_cfgs = { level = "warn", check-cfg = ['cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
-                                                 'cfg(has_offset_of)'] }
+[lints]
+workspace = true
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 4ba5607d66b..8013911a348 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,7 +5,7 @@ if rustc.version().version_compare('>=1.77.0')
 endif
 
 _qemu_api_cfg += run_command(rustc_args,
-  '--config-headers', config_host_h, '--features', '--lints', files('Cargo.toml'),
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
 _qemu_api_rs = static_library(
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 9b9778a1cac..26733439ed4 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -38,12 +38,19 @@
 
 class CargoTOML:
     tomldata: Mapping[Any, Any]
+    workspace_data: Mapping[Any, Any]
     check_cfg: Set[str]
 
-    def __init__(self, path: str):
+    def __init__(self, path: str, workspace: Optional[str]):
         with open(path, 'rb') as f:
             self.tomldata = tomllib.load(f)
 
+        if workspace is not None:
+            with open(workspace, 'rb') as f:
+                self.workspace_data = tomllib.load(f)
+            if "workspace" not in self.workspace_data:
+                self.workspace_data["workspace"] = {}
+
         self.check_cfg = set(self.find_check_cfg())
 
     def find_check_cfg(self) -> Iterable[str]:
@@ -54,10 +61,12 @@ def find_check_cfg(self) -> Iterable[str]:
 
     @property
     def lints(self) -> Mapping[Any, Any]:
-        return self.get_table("lints")
+        return self.get_table("lints", True)
 
-    def get_table(self, key: str) -> Mapping[Any, Any]:
+    def get_table(self, key: str, can_be_workspace: bool = False) -> Mapping[Any, Any]:
         table = self.tomldata.get(key, {})
+        if can_be_workspace and table.get("workspace", False) is True:
+            table = self.workspace_data["workspace"].get(key, {})
 
         return table
 
@@ -136,6 +145,16 @@ def main() -> None:
         action="store",
         dest="cargo_toml",
         help="path to Cargo.toml file",
+        nargs='?',
+    )
+    parser.add_argument(
+        "--workspace",
+        metavar="DIR",
+        action="store",
+        dest="workspace",
+        help="path to root of the workspace",
+        required=False,
+        default=None,
     )
     parser.add_argument(
         "--features",
@@ -168,7 +187,11 @@ def main() -> None:
     logging.debug("args: %s", args)
 
     rustc_version = tuple((int(x) for x in args.rustc_version.split('.')[0:2]))
-    cargo_toml = CargoTOML(args.cargo_toml)
+    if args.workspace:
+        workspace_cargo_toml = Path(args.workspace, "Cargo.toml").resolve()
+        cargo_toml = CargoTOML(args.cargo_toml, str(workspace_cargo_toml))
+    else:
+        cargo_toml = CargoTOML(args.cargo_toml, None)
 
     if args.lints:
         for tok in generate_lint_flags(cargo_toml):
-- 
2.47.0


