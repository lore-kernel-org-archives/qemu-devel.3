Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DABEC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKmv-0004xf-Bi; Fri, 21 Aug 2026 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmt-0004vW-Ei
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmr-0008Jb-NT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=FjR8/VV5feAA8sMsYXNwWQKPFpEBcyhX8qqdducB691p4NHxAfQtQu0LzHYQTmt4C2fHIX
 QMR/rx+1vmlPM5DUnO6mnX8E/FElLL8PangiZltTyhLhPYD1Y3FceOKZkfgyLTSSSxx4Bj
 IhOWNqUqo8Mm8vYKhir/54fj37FZh8c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-f0P-fy2ZP0qXbfPLZgLKrA-1; Fri, 21 Aug 2026 04:39:39 -0400
X-MC-Unique: f0P-fy2ZP0qXbfPLZgLKrA-1
X-Mimecast-MFC-AGG-ID: f0P-fy2ZP0qXbfPLZgLKrA_1787301578
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-69c20d1d150so677194a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301578; x=1787906378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=e+oq6Mj9ORzN64X9Ss0t6FV5eo0ukLpBvbauR7j920erbNTTfa5lAE4RUFfyNV5Vtq
 W8B8IeshO60GJ69lcVyPHOCM06GlKjznDMOub2f2Kgskv8+kYhEZR/Y2DrX40BwyIWfo
 GGxkvI2bjyo+wG2qrDmkjTVLZ2LzfCZb4UcBCerZdMoSmbu8Xm1e/B4g4mk2zMiAYXNw
 1kva8RNYbqISpemq8Z39HfZtJNCLnAqzSNFndxmSoArKYRztD+8ITWruEP0ya+fSn5PT
 F3Xq7WcYjBwrizdZ22rhBE4pPIHvDPWKkuSIZTChuFulXySlo3I3xFUy97Yn/glQb0v9
 DJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301578; x=1787906378;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=Qe4zFBBqf7Z32uzlSCwElipe+II21yoGGTpcpgXF7GJVr9LsoJlZpbzVdiMM2pKr5I
 bI33uV7U0c3CLUshO/7f8LAI/7xdxyiVCU+MIol0tDEFUS9BbJsjR/bl3kCa0NA8lqEB
 ONz28Xy5PhAQdZ+rYKhk9YIbXbJtPFfao1z8kWlHpoEsjhnReA28We0uAX6YhZxJGHbB
 g2xK1lnRcCeFPLVmvPBAxzWC50q5jsoTSo+J3g6ehBxK4AfsSb3Sc54UE9qvnkef4hRb
 P30nbn7YVN1koLnyPL2/cnVo9+j1sa/TRDfWFb8t8g+veGbia2IVhdJxFqTVsPphKSYo
 hunA==
X-Gm-Message-State: AFuF++mIOjlFQexc+cWod4e2CbymXYhPtLA4zeK09KskTjqAWZGBXAV5
 T3U98Nk/mbKvcGEMC+OSZU5ji316YVYsTj7vDyM09Ra3FtKugCPU5Ip/T8yuZw0oKoYdyUz1Y2s
 GjtoZrezNveRFLoj550T4bUwQS/OL9UoRL7vQtmNBFU++eODCOMMLl30mWhJXJRrW8OSPzJ7c/M
 KLhrEWYn/8CRBe704wX1Oz5XBgKayxEEbNh7Q01C8d
X-Gm-Gg: AR+sD12czAhbYDqE7CV4GqSXw2GSYrY7o9keUKkTCTghdlE0fEpiqzSmtoT2cNihlfT
 o+SyYl548Ypm9thC3OK2rBOzrZFVhtzIChH+VfKo4pPxwiADwmRnNsS9w6cgz0gB4IC6a4y40kL
 eANuJygisCcjiiFWBc2bR6MMkzTwj4ZIQEuhc6QLvVcAFz1BSKuDToHvmeGWBNgyW4ktkLv7fhX
 kulafbMjdotJKhcHScUh1m9Wd4W40+y7MWRM5HyMRyNCg6voHpTMw2xHTZByLS47Hw4HKWHifPC
 omqUU22C33Zj9FcBT0FOWBpffdhaUwUdF1jXp/cPGDMn28P7Fh4dauytkUmT743IRKEJjVjbHwM
 Y0wcHYft+cwXjcHC4smvCxXQUj//139PtoHdah0v3cme/OsHECRB377hvHDlrVWM9F3/M8y4Fhy
 yfSbo=
X-Received: by 2002:a05:6402:190a:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-6a42f1df94emr4732088a12.11.1787301578261; 
 Fri, 21 Aug 2026 01:39:38 -0700 (PDT)
X-Received: by 2002:a05:6402:190a:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-6a42f1df94emr4732055a12.11.1787301577772; 
 Fri, 21 Aug 2026 01:39:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0d5f70sm5455879a12.13.2026.08.21.01.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/9] scripts: introduce CrateSource abstract class
Date: Fri, 21 Aug 2026 10:39:20 +0200
Message-ID: <20260821083925.2008135-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for making the script able to update .wrap files with
versions from Cargo.lock.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 49 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 8114f0731be..636e4ba3474 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -29,18 +29,36 @@ def get_name_and_semver(namever: str) -> tuple[str, str]:
     return parts[0], parts[1]
 
 
-class UpdateSubprojects:
-    cargo_registry: str
-    top_srcdir: str
-    dry_run: bool
-    changes: int = 0
+class CrateSource:
+    """Class for locating crate versions and pointing wrap files at them.
+       Subclasses know where the source of a crate comes from and how to
+       rewrite the ``[wrap-file]`` to consume it."""
 
-    def find_installed_crate(self, namever: str) -> str | None:
+    origin: str
+
+    def find(self, namever: str) -> str | None:
+        """Resolve a 'name-semver' prefix to a concrete 'name-version'."""
+        raise NotImplementedError
+
+    def rewrite_source(self, section: configparser.SectionProxy, orig_namever: str, source_namever: str) -> bool:
+        """Update the download-related keys of a [wrap-file] section."""
+        raise NotImplementedError
+
+
+class CargoRegistry(CrateSource):
+    """Locate crates already extracted in a local Cargo registry directory."""
+
+    origin = "the Cargo registry"
+
+    def __init__(self, path: str):
+        self.path = path
+
+    def find(self, namever: str) -> str | None:
         """Find installed crate matching name and semver prefix"""
         name, semver = get_name_and_semver(namever)
 
         # exact version match
-        path = os.path.join(self.cargo_registry, f"{name}-{semver}")
+        path = os.path.join(self.path, f"{name}-{semver}")
         if os.path.exists(path):
             return f"{name}-{semver}"
 
@@ -56,6 +74,14 @@ def rewrite_source(self, section: configparser.SectionProxy, orig_namever: str,
                 del section[key]
         return True
 
+
+class UpdateSubprojects:
+    cargo_registry: str
+    source: CrateSource
+    top_srcdir: str
+    dry_run: bool
+    changes: int = 0
+
     def compare_build_rs(self, orig_dir: str, source_namever: str) -> None:
         """Warn if the build.rs in the original directory differs from the registry version."""
         orig_build_rs = os.path.join(orig_dir, "build.rs")
@@ -102,7 +128,7 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
             return
 
         section["directory"] = source_namever
-        if self.rewrite_source(section, orig_dir, source_namever):
+        if self.source.rewrite_source(section, orig_dir, source_namever):
             with open(wrap_file, "w") as f:
                 config.write(f)
 
@@ -110,9 +136,9 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
             config.write(f)
 
         if orig_dir == source_namever:
-            print(f"Installing {orig_dir} from registry.")
+            print(f"👉 Installing {orig_dir} from {self.source.origin}.")
         else:
-            print(f"Replacing {orig_dir} with {source_namever}.")
+            print(f"👉 Replacing {orig_dir} with {source_namever}.")
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
@@ -154,6 +180,7 @@ def __init__(self, args: argparse.Namespace):
         self.cargo_registry = args.cargo_registry
         self.dry_run = args.dry_run
         self.top_srcdir = os.getcwd()
+        self.source = CargoRegistry(args.cargo_registry)
 
     def main(self) -> None:
         if not os.path.exists("subprojects"):
@@ -164,7 +191,7 @@ def main(self) -> None:
         for wrap_file in sorted(glob.glob("*-rs.wrap")):
             namever = wrap_file[:-8]  # Remove '-rs.wrap'
 
-            source_namever = self.find_installed_crate(namever)
+            source_namever = self.source.find(namever)
             if not source_namever:
                 print(f"No installed crate found for {wrap_file}")
                 continue
-- 
2.55.0


