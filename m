Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7277FC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufI0P-0002P1-K9; Fri, 25 Jul 2025 08:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwZ-0006Xe-CG
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwS-0007xi-R1
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnLgfod2RcfwvaSBs3sSVuBsFw0Zk9c9E3+FLy9lX7I=;
 b=SNS42DXV+VNO542klNGKAr4OGeu2MasH1xfBMbr9UES5ZZzKEDu+KoIhuzIgouujbekkDM
 YkYqXgngHCjBr92OiEwG3mukM0c5MglyqWVcRoVjlEi3SPu19V8oOlzRb8pbzp8cNexPFP
 lgJ59Xx+goWA7sVXDdLx4nu12Cf12mQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-YY9bCL0uPWy1x5uZdAOxoQ-1; Fri, 25 Jul 2025 08:54:23 -0400
X-MC-Unique: YY9bCL0uPWy1x5uZdAOxoQ-1
X-Mimecast-MFC-AGG-ID: YY9bCL0uPWy1x5uZdAOxoQ_1753448062
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so11516405e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448061; x=1754052861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnLgfod2RcfwvaSBs3sSVuBsFw0Zk9c9E3+FLy9lX7I=;
 b=ctM0ggLtJBlVj2y4m3UQCB09UDVsAFnhZisQn9SJMFr8jowEiGMB69MForLPHCL8+s
 3uA031wBsrN4eg78PW4SaivUkOkZ9rZs9UncitHInn4KL7Z13Nnpv1bm7HFUIrTRryHG
 LhEFwnQM1xDJTYlYU/nOUGbcK/8xhmKxEdOckO759abrMyc76rTrkAGcS17Sek6QqErS
 rpJOYH7ENuAVxROXpe1Vp+tAKO+KEGzWoARILPiYpB/lfogGoJl9VWI4IrBfWSGdj5di
 7h/MHIHCEbrJFImMHh1PNy5GTpdTbnR6QMj2uYOgCUijdBDShscClrjrIMqEJ9MN+AHs
 HCyQ==
X-Gm-Message-State: AOJu0YwpyAXB5XuOlaf1n4QOFZu0zvTGkkuGRc0sPWKkndQ5KL45+IXQ
 1iX+pviL4nNbaKWv/BpoOzAuGwAUJy1mFFcZwDR25QjwEg5KrPF4hGkXC75EPZrXXdGIqpHgeZT
 aGyr7yn8KDTZ+EZGv8UEUm5ojAjgXT2VuwrTcgiLOvrOMTs3X6ETBx/ZfJRoMDFd4Vg54rETsL5
 +zP40GWNUjLXbDKNbQT5lb+ZMa/8uFGjcM0j7skLjn
X-Gm-Gg: ASbGncvsWQrF7YWMDBfzL5PSv6vIXimbrtfkksbwf+eE+W2hHLG2eAWYkgDrOfbsPig
 O7WOoU5lOBFhg0C4cotDdGSURPYlwNIkMQxx5AMJQDC1R4ZNmfzw/lMToY/jrelk17op1CyDzhy
 ZyWmgzr++AJk4EJezsyY+lIvlR/05zBRHo+qiZ8mcP1nWRM1mXb1TxgmA7qqn13Dwsip/z39C0y
 Ep2l6Owk1xOVAODk4XIrXRZE3UvNNVJlQbRI/MWffh1qHfa+C0UN63GJITHu8Z6I7ykY9ixY8ll
 8oTtJD4Sk+YwAy5QAXuBqdX0atF36pqF5Ykd5IrD3toH
X-Received: by 2002:a05:6000:2083:b0:3b7:662a:b835 with SMTP id
 ffacd0b85a97d-3b77671d144mr1603008f8f.6.1753448060871; 
 Fri, 25 Jul 2025 05:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu1tEYGgIJvte3P8x/Ilps16IgoP6s93rQaBSQI+7qtcyU8zNvRPFh0Qmjc0MrXrE7SGuyBQ==
X-Received: by 2002:a05:6000:2083:b0:3b7:662a:b835 with SMTP id
 ffacd0b85a97d-3b77671d144mr1602978f8f.6.1753448060144; 
 Fri, 25 Jul 2025 05:54:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad301sm5037758f8f.51.2025.07.25.05.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:54:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Neal Gompa <ngompa@fedoraproject.org>
Subject: [PULL 3/4] scripts: add script to help distros use global Rust
 packages
Date: Fri, 25 Jul 2025 14:54:02 +0200
Message-ID: <20250725125412.1128617-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725125412.1128617-1-pbonzini@redhat.com>
References: <20250725125412.1128617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

Some distros prefer to avoid vendored crate sources, and instead use
local sources from e.g. ``/usr/share/cargo/registry``.  Add a
script, inspired by the Mesa spec file(*), that automatically
performs this task.  The script is meant to be invoked after unpacking
the QEMU tarball.

(*) This is the hack that Mesa uses:

    export MESON_PACKAGE_CACHE_DIR="%{cargo_registry}/"
    %define inst_crate_nameversion() %(basename %{cargo_registry}/%{1}-*)
    %define rewrite_wrap_file() sed -e "/source.*/d" -e "s/%{1}-.*/%{inst_crate_nameversion %{1}}/" -i subprojects/%{1}.wrap
    %rewrite_wrap_file proc-macro2
    ... more %rewrite_wrap_file invocations follow ...

Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                              |   1 +
 docs/about/build-platforms.rst           |   8 +
 scripts/get-wraps-from-cargo-registry.py | 190 +++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100755 scripts/get-wraps-from-cargo-registry.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a4623456183..1604f3dfc1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3511,6 +3511,7 @@ S: Maintained
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
+F: scripts/get-wraps-from-cargo-registry.py
 
 Rust-related patches CC here
 L: qemu-rust@nongnu.org
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8ecbd6b26f7..8671c3be9cd 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -127,6 +127,14 @@ Rust build dependencies
   (or newer) package.  The path to ``rustc`` and ``rustdoc`` must be
   provided manually to the configure script.
 
+  Some distros prefer to avoid vendored crate sources, and instead use
+  local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes a
+  script, ``scripts/get-wraps-from-cargo-registry.py``, that automatically
+  performs this task.  The script is meant to be invoked after unpacking
+  the QEMU tarball.  QEMU also includes ``rust/Cargo.toml`` and
+  ``rust/Cargo.lock`` files that can be used to compute QEMU's build
+  dependencies, e.g. using ``cargo2rpm -p rust/Cargo.toml buildrequires``.
+
 Optional build dependencies
   Build components whose absence does not affect the ability to build QEMU
   may not be available in distros, or may be too old for our requirements.
diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
new file mode 100755
index 00000000000..31eed5c2dd4
--- /dev/null
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+get-wraps-from-cargo-registry.py - Update Meson subprojects from a global registry
+"""
+
+# Copyright (C) 2025 Red Hat, Inc.
+#
+# Author: Paolo Bonzini <pbonzini@redhat.com>
+
+import argparse
+import configparser
+import filecmp
+import glob
+import os
+import subprocess
+import sys
+
+
+def get_name_and_semver(namever: str) -> tuple[str, str]:
+    """Split a subproject name into its name and semantic version parts"""
+    parts = namever.rsplit("-", 1)
+    if len(parts) != 2:
+        return namever, ""
+
+    return parts[0], parts[1]
+
+
+class UpdateSubprojects:
+    cargo_registry: str
+    top_srcdir: str
+    dry_run: bool
+    changes: int = 0
+
+    def find_installed_crate(self, namever: str) -> str | None:
+        """Find installed crate matching name and semver prefix"""
+        name, semver = get_name_and_semver(namever)
+
+        # exact version match
+        path = os.path.join(self.cargo_registry, f"{name}-{semver}")
+        if os.path.exists(path):
+            return f"{name}-{semver}"
+
+        # semver match
+        matches = sorted(glob.glob(f"{path}.*"))
+        return os.path.basename(matches[0]) if matches else None
+
+    def compare_build_rs(self, orig_dir: str, registry_namever: str) -> None:
+        """Warn if the build.rs in the original directory differs from the registry version."""
+        orig_build_rs = os.path.join(orig_dir, "build.rs")
+        new_build_rs = os.path.join(self.cargo_registry, registry_namever, "build.rs")
+
+        msg = None
+        if os.path.isfile(orig_build_rs) != os.path.isfile(new_build_rs):
+            if os.path.isfile(orig_build_rs):
+                msg = f"build.rs removed in {registry_namever}"
+            if os.path.isfile(new_build_rs):
+                msg = f"build.rs added in {registry_namever}"
+
+        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs):
+            msg = f"build.rs changed from {orig_dir} to {registry_namever}"
+
+        if msg:
+            print(f"⚠️  Warning: {msg}")
+            print("   This may affect the build process - please review the differences.")
+
+    def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
+        """Modify [wrap-file] section to point to self.cargo_registry."""
+        assert wrap_file.endswith("-rs.wrap")
+        wrap_name = wrap_file[:-5]
+
+        env = os.environ.copy()
+        env["MESON_PACKAGE_CACHE_DIR"] = self.cargo_registry
+
+        config = configparser.ConfigParser()
+        config.read(wrap_file)
+        if "wrap-file" not in config:
+            return
+
+        # do not download the wrap, always use the local copy
+        orig_dir = config["wrap-file"]["directory"]
+        if os.path.exists(orig_dir) and orig_dir != registry_namever:
+            self.compare_build_rs(orig_dir, registry_namever)
+
+        if self.dry_run:
+            if orig_dir == registry_namever:
+                print(f"Will install {orig_dir} from registry.")
+            else:
+                print(f"Will replace {orig_dir} with {registry_namever}.")
+            self.changes += 1
+            return
+
+        config["wrap-file"]["directory"] = registry_namever
+        for key in list(config["wrap-file"].keys()):
+            if key.startswith("source"):
+                del config["wrap-file"][key]
+
+        # replace existing directory with installed version
+        if os.path.exists(orig_dir):
+            subprocess.run(
+                ["meson", "subprojects", "purge", "--confirm", wrap_name],
+                cwd=self.top_srcdir,
+                env=env,
+                check=True,
+            )
+
+        with open(wrap_file, "w") as f:
+            config.write(f)
+
+        if orig_dir == registry_namever:
+            print(f"Installing {orig_dir} from registry.")
+        else:
+            print(f"Replacing {orig_dir} with {registry_namever}.")
+            patch_dir = config["wrap-file"]["patch_directory"]
+            patch_dir = os.path.join("packagefiles", patch_dir)
+            _, ver = registry_namever.rsplit("-", 1)
+            subprocess.run(
+                ["meson", "rewrite", "kwargs", "set", "project", "/", "version", ver],
+                cwd=patch_dir,
+                env=env,
+                check=True,
+            )
+
+        subprocess.run(
+            ["meson", "subprojects", "download", wrap_name],
+            cwd=self.top_srcdir,
+            env=env,
+            check=True,
+        )
+        self.changes += 1
+
+    @staticmethod
+    def parse_cmdline() -> argparse.Namespace:
+        parser = argparse.ArgumentParser(
+            description="Replace Meson subprojects with packages in a Cargo registry"
+        )
+        parser.add_argument(
+            "--cargo-registry",
+            default=os.environ.get("CARGO_REGISTRY"),
+            help="Path to Cargo registry (default: CARGO_REGISTRY env var)",
+        )
+        parser.add_argument(
+            "--dry-run",
+            action="store_true",
+            default=False,
+            help="Do not actually replace anything",
+        )
+
+        args = parser.parse_args()
+        if not args.cargo_registry:
+            print("error: CARGO_REGISTRY environment variable not set and --cargo-registry not provided")
+            sys.exit(1)
+
+        return args
+
+    def __init__(self, args: argparse.Namespace):
+        self.cargo_registry = args.cargo_registry
+        self.dry_run = args.dry_run
+        self.top_srcdir = os.getcwd()
+
+    def main(self) -> None:
+        if not os.path.exists("subprojects"):
+            print("'subprojects' directory not found, nothing to do.")
+            return
+
+        os.chdir("subprojects")
+        for wrap_file in sorted(glob.glob("*-rs.wrap")):
+            namever = wrap_file[:-8]  # Remove '-rs.wrap'
+
+            registry_namever = self.find_installed_crate(namever)
+            if not registry_namever:
+                print(f"No installed crate found for {wrap_file}")
+                continue
+
+            self.update_subproject(wrap_file, registry_namever)
+
+        if self.changes:
+            if self.dry_run:
+                print("Rerun without --dry-run to apply changes.")
+            else:
+                print(f"✨ {self.changes} subproject(s) updated!")
+        else:
+            print("No changes.")
+
+
+if __name__ == "__main__":
+    args = UpdateSubprojects.parse_cmdline()
+    UpdateSubprojects(args).main()
-- 
2.50.1


