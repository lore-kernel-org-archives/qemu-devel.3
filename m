Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4FAC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarW-0002dp-7O; Thu, 27 Aug 2026 10:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarS-0002d2-Dw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarM-0005h5-DJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2i19n0p9YgArVOv8vKeFeUdAlRf+ZdvKQUP5HpsMcQ=;
 b=S0mxHqnbZ/7YaChqWmbDuxcNxukc096070EzfDMbetbsJhsCaa5OCoauvJ77J5XLg4CpUi
 t3f+D9nsDhaGLNgzu6/jetEpjwPqAtneQg1IO4EthpLHbGeKhtuHP0T4XIJCmhopF38rQ8
 wQulc60njVl6zcol8i1x5n8GP2qzIAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-1WgA5uQRNTuMI7iSWZZv-A-1; Thu, 27 Aug 2026 10:13:37 -0400
X-MC-Unique: 1WgA5uQRNTuMI7iSWZZv-A-1
X-Mimecast-MFC-AGG-ID: 1WgA5uQRNTuMI7iSWZZv-A_1787840017
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so510332f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840016; x=1788444816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M2i19n0p9YgArVOv8vKeFeUdAlRf+ZdvKQUP5HpsMcQ=;
 b=QnEN0fG8fhdvRrL2QGCtk1RH/nuxv3RQOO/a9Mc+qp34/IZgQro9hiDWBnnyhy/J3p
 YZKOGPUe3uvmbkFhHsRXBTkT2lv7zdceo1cbAfe07qA0M68Yxw7elZehVs1gdD4z6WK9
 +Ae9ZToz7Pfn7m36+bSks/zgcvRjfU8I+hEU/AbUaintFqHCqpnmlCiun1/QaWgbdrWN
 JyoWfqCM+6MwPwQXPMu9HxDU/pqf86UVmD3W8voiGAPw4/BlTNtWmxYwuQkA2wtSSPQ/
 ACozSsUrcM/JtmuiYey569iFba3agb9Kn9R1ncvNNEWmyRXbftr2Cv6qb5Ql+Jy9cxYg
 slsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840016; x=1788444816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M2i19n0p9YgArVOv8vKeFeUdAlRf+ZdvKQUP5HpsMcQ=;
 b=oLxqxsve57/yGamlH3243xRE53JxGDj9qXthvtfrImcpXNc99lEBWT8Q7ypecBQ4mY
 c4pQFGWzi6dN8aVLXzHpyNElAPn7oWpesWuCidpIC/KZ0C3ml7O6vKcOMjsfTAporYwz
 I0jkLxCFeZf6/RtXESaY7r0cDiG0N6F2qnwWJeD0PgQbCIAH1hok7J5jHBHIgNmLAVr6
 TUtMeb5VFdEOG51Z9v3/5zsq+svJqhc7ZlRkgWk1q1Qg5GGLWlsHTXPZw0H2zFhtfeF2
 ukS2bNU4niBQa+iMx4Lgkz3ZKNsZMIzLLisUT6ESQOFChJkmert1jXTsHw/8qjV9zkqx
 Gzzw==
X-Gm-Message-State: AFuF++mF9MwRxpzQBXnXyk317/ZczBsBQ27zTQTKfROamsbduz54vah1
 hqZJNHxsOScnq/d39QRKldYmWaP/1qzFcnkbz1dAmC3V3QjoGXXSb7o9IlXXO4dPssooXiNd0fj
 RiPHIifEIf1cB8YPKwnpXY0ZpbSXRzrmaNI6AVCYQdsA9bZRPq1AHA6OTMWC7UdgLgplEFwqq1x
 w9Nmlu9aU81TPXEVBN49o+HzQVpwOySo08RNOy3v8M
X-Gm-Gg: AR+sD108dAjG7aFrTIjw2x6QXhNrFUgYOhIJmtkVCxX8D5WZNDZxYldiCCYNuHr3L2l
 DY2lpSeuelE19lch04Zg29lxXiBZfHi/k5VE/ViQNjf4nuGkyHjSeMuR8+vU3douTxLRtpizEoP
 qQRsXZnORQvcoQLz7njAdvYo0YTRHlrrFErooeaQJaPjOyC32p17Rb3MgCjdpfsoINsvHvLBCD+
 f1u5Aql8JeDkn1P2kRhl4t2xctrWqxVAOyFoBqv+SAnyL9YGRZNVuowkpPL47QQEei5I9CvAmVC
 eCU3aU23wbYTJV3kFTQEEZUD6cNSCi5y5uAHYHQ/ZshuOsXFunKreM1Uk9ZAkDsxLmwJAFM+XzA
 SPujcndsBrPMC2WzUkEuIJWgzjXxRwDlxsYbmmkm7gl3Gq6aKv/YTjNicVjVBDFTaEiPg3B/WgZ
 yewZs=
X-Received: by 2002:a5d:5847:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-482eab6a866mr9268106f8f.4.1787840016474; 
 Thu, 27 Aug 2026 07:13:36 -0700 (PDT)
X-Received: by 2002:a5d:5847:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-482eab6a866mr9268007f8f.4.1787840015887; 
 Thu, 27 Aug 2026 07:13:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28fe2ecsm9325731f8f.37.2026.08.27.07.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] scripts: add functionality to update wrap files from
 Cargo.lock
Date: Thu, 27 Aug 2026 16:12:55 +0200
Message-ID: <20260827141314.1099352-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

.wrap files and Cargo.lock contain pretty much the same information.
QEMU uses the former to make it easier for distros to use a local
registry, and also because Meson <1.13 does not use Cargo.lock for
the "meson subprojects" command.  This however introduces an
inconvenience when running "cargo update", in that the wrap
files have to be updated by hand.

Add the possibility to get new versions from Cargo.lock and not
just from a local registry, thus automating the update.

For now, only existing wrap files are modified.  This means
that semver-breaking updates need to be done (at least partly)
by hand; it is enough to rename the wrap file prior to running
the script.

While the need for this script is a lot smaller with Meson 1.13, it
would still remain useful for packages that have a patch directory.
Perhaps a bit overengineered, but since we have it...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 77 +++++++++++++++++++++---
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 636e4ba3474..b3ae5a2c284 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -3,7 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 """
-get-wraps-from-cargo-registry.py - Update Meson subprojects from a global registry
+get-wraps-from-cargo-registry.py - Update Meson subprojects from a Cargo
+registry or from the versions pinned in Cargo.lock.
 """
 
 # Copyright (C) 2025 Red Hat, Inc.
@@ -18,6 +19,7 @@
 import shutil
 import subprocess
 import sys
+import tomllib
 
 
 def get_name_and_semver(namever: str) -> tuple[str, str]:
@@ -75,6 +77,49 @@ def rewrite_source(self, section: configparser.SectionProxy, orig_namever: str,
         return True
 
 
+class CargoLock(CrateSource):
+    """Locate crates by the versions pinned in a Cargo.lock file."""
+
+    origin = "crates.io"
+
+    def __init__(self, path: str):
+        with open(path, "rb") as f:
+            data = tomllib.load(f)
+
+        self.versions: dict[str, list[str]] = {}
+        self.checksums: dict[str, str] = {}
+        for pkg in data.get("package", []):
+            # workspace members have neither a checksum nor a crates.io tarball
+            if "checksum" not in pkg:
+                continue
+            name, version = pkg["name"], pkg["version"]
+            self.versions.setdefault(name, []).append(version)
+            self.checksums[f"{name}-{version}"] = pkg["checksum"]
+
+    def find(self, namever: str) -> str | None:
+        """Find pinned crate matching name and semver prefix"""
+        name, semver = get_name_and_semver(namever)
+        versions = sorted(self.versions.get(name, []))
+
+        # exact version match
+        if semver in versions:
+            return f"{name}-{semver}"
+
+        # semver match
+        matches = [v for v in versions if v.startswith(f"{semver}.")]
+        return f"{name}-{matches[0]}" if matches else None
+
+    def rewrite_source(self, section: configparser.SectionProxy, orig_namever: str, new_namever: str) -> bool:
+        # rewrite the download keys to fetch the pinned version from crates.io.
+        if orig_namever == new_namever:
+            return False
+        name, version = get_name_and_semver(new_namever)
+        section["source_url"] = f"https://crates.io/api/v1/crates/{name}/{version}/download"
+        section["source_filename"] = f"{new_namever}.tar.gz"
+        section["source_hash"] = self.checksums[new_namever]
+        return True
+
+
 class UpdateSubprojects:
     cargo_registry: str
     source: CrateSource
@@ -104,12 +149,13 @@ def compare_build_rs(self, orig_dir: str, source_namever: str) -> None:
             print("   This may affect the build process - please review the differences.")
 
     def update_subproject(self, wrap_file: str, source_namever: str) -> None:
-        """Modify [wrap-file] section to point to self.cargo_registry."""
+        """Modify [wrap-file] section to use the crate resolved as `source_namever`."""
         assert wrap_file.endswith("-rs.wrap")
         wrap_name = wrap_file[:-5]
 
         env = os.environ.copy()
-        env["MESON_PACKAGE_CACHE_DIR"] = self.cargo_registry
+        if self.cargo_registry:
+            env["MESON_PACKAGE_CACHE_DIR"] = self.cargo_registry
 
         config = configparser.ConfigParser()
         config.read(wrap_file)
@@ -157,9 +203,15 @@ def parse_cmdline() -> argparse.Namespace:
         parser = argparse.ArgumentParser(
             description="Replace Meson subprojects with packages in a Cargo registry"
         )
+        parser.add_argument(
+            "--cargo-lock",
+            action='store_true',
+            default=False,
+            help="Update wraps from Cargo.lock",
+        )
         parser.add_argument(
             "--cargo-registry",
-            default=os.environ.get("CARGO_REGISTRY"),
+            default=None,
             help="Path to Cargo registry (default: CARGO_REGISTRY env var)",
         )
         parser.add_argument(
@@ -170,9 +222,15 @@ def parse_cmdline() -> argparse.Namespace:
         )
 
         args = parser.parse_args()
-        if not args.cargo_registry:
-            print("error: CARGO_REGISTRY environment variable not set and --cargo-registry not provided")
+        if args.cargo_registry and args.cargo_lock:
+            print("error: --cargo-registry and --cargo-lock are incompatible")
             sys.exit(1)
+        if not args.cargo_registry and not args.cargo_lock:
+            args.cargo_registry = os.environ.get("CARGO_REGISTRY")
+            if not args.cargo_registry:
+                print("error: CARGO_REGISTRY environment variable not set and " +
+                      "--cargo-registry or --cargo-lock not provided")
+                sys.exit(1)
 
         return args
 
@@ -180,7 +238,10 @@ def __init__(self, args: argparse.Namespace):
         self.cargo_registry = args.cargo_registry
         self.dry_run = args.dry_run
         self.top_srcdir = os.getcwd()
-        self.source = CargoRegistry(args.cargo_registry)
+        if args.cargo_lock:
+            self.source = CargoLock(os.path.join(self.top_srcdir, "Cargo.lock"))
+        else:
+            self.source = CargoRegistry(args.cargo_registry)
 
     def main(self) -> None:
         if not os.path.exists("subprojects"):
@@ -193,7 +254,7 @@ def main(self) -> None:
 
             source_namever = self.source.find(namever)
             if not source_namever:
-                print(f"No installed crate found for {wrap_file}")
+                print(f"No crate found for {wrap_file}")
                 continue
 
             self.update_subproject(wrap_file, source_namever)
-- 
2.55.0


