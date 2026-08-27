Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D858C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarb-0002fE-Pk; Thu, 27 Aug 2026 10:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarS-0002d3-F3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarM-0005gc-8e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=JBqlsY24ejKiZAL/J3SIMIKDBwAb2N5OQS8llhI2mhELLKNEXEcmqGXtLo5SOmDGhux1Cx
 KaeKEim2nqB1MhRgymvfQ97dMkTpvBqAAk78Uu/Ysiecq5tgQpeFCFf/ibdb9nTj0R+9zG
 RK8Alk0gMEClWwhXX6QIrIQkU3yjJjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-Wx2kppEJMfinuWmfOfahsA-1; Thu, 27 Aug 2026 10:13:34 -0400
X-MC-Unique: Wx2kppEJMfinuWmfOfahsA-1
X-Mimecast-MFC-AGG-ID: Wx2kppEJMfinuWmfOfahsA_1787840014
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so7534575e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840013; x=1788444813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=N9UA8WrabjrBCsQITOuNTzc8oeN2rvHOV4BqK/EEdd0wwJSZfCtg4VV6rEbvjrN6OE
 UUTCBc9utIHtGDpQDWkEVmnmN13NZPEn8Dx1gDiYChbltP3tvbw+mongXq6vbOfBsUWV
 7ckaz5vpD/dIRTOvTDTFH/FDxMVa3n7FYs/kRZ40qK8VfjahEKo0E7K7gDT0ujBAZ9Zr
 ELfzGrVahjPToh+/jsB4ukSfQQG91zsc+M69VfeOoSqvjuPcKt+xv3qjKSld2Lj3e9PW
 qvKC0CQzwwoW7O5Oe/g2NcRFCiJ1eezJkgXevIbiBKKb0huyGIYi5QYfNxs5ECUdzw5F
 vIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840013; x=1788444813;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54WY2o82iGBH8d5H4JTOlD44ATSwqc2GBS3osVVeSxI=;
 b=cs2IFlbBZiDgrJCuPM7NbCRI8m9BoEQlSMYKSEt3eMbqk5XPn+YecYh+5kVLOngW36
 TjMn0fpy9o6jlevfYfue/ty9aVG0XqBK2Sf5hW8wKYSpzV5APCVYZitG/5WQR+8Rvvlb
 07+vQbo2BPMgH6Vbv+q2Cz6Zpx5xCve9vZJIiu83xeJkP8XfzOSlfcIJOu+w3uvtml9T
 cB9cAyMWBgiUXv+4KCIn05n8mipp0op8em/bItNwQkHgpD6YR+LAozUg35qqINSvcwQC
 8nxox7E9IXuAqZYLQMuNdENlyeuIWfOHxKTu/R3rmJx8HwKqbI8TO2qwikMxiUagHiaY
 uruQ==
X-Gm-Message-State: AFuF++nfe5OFjl4E0/xb3iXbnrepipTHJ4KEjEXRGl9oDGKh6Jw+D9xf
 nYTwSOcRJ9ctgpNnPD9iDfJNW9mvDhhQwS/JiaXB03JcLQX5/ZLLj8IU+PUgWs3/SruGWIwA5tO
 nGklnLrhcStngdfyQUiNYdEUvx/Z1GHGdWSJBo7e7oKJpXck/D18+uKsQ+dIv0xVC6NnWXjZa10
 1jiKlh0R+1b4JH5YdGVc9ypEclgzsWw77AUxVdmJif
X-Gm-Gg: AR+sD11oa2PlB/SDJKH+CBhfN6TbTNQo6U2SO1MslkSuy4Ikx43qfoaDm36lbZOwkBW
 FbKJKRS/05GEIIK0tFl0dev2xgQqsUL3r/cNjsAjX469aQdd+0OC8vgU+b0GrQXFmh8KKd4CDIg
 xf12KGcbvaT+RqIUXa0ycrxsqebmgpEhqpgXDtsNmSWXx9IS0DlvsWHgoDGR4qSm5TlkFxJZjbf
 TkH4jDsFunuDLTbpniBvP/WDzT2dlvOqgoYloyg1k1l1Ea6v0a03wjzi3sIKljQsRMrUHn8kCkN
 DcVeRxQKZBgYrhFuVInKyEM1m+U2yXVqqPPGRdascVl/gleXUZB+1H0b96Dv3ePKz2O3SZMW6Lt
 sLiUXw1G/D2E7YcfYWn/jNTPir8FWrVGMXDLab1PrqxQIHMQUNmGkgZ4zxHHR+U7exPrbadUGWH
 0x2Gs=
X-Received: by 2002:a05:600c:4445:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499dc6fd832mr187424705e9.4.1787840013425; 
 Thu, 27 Aug 2026 07:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4445:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499dc6fd832mr187423445e9.4.1787840012900; 
 Thu, 27 Aug 2026 07:13:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4b2d6b30sm53384835e9.14.2026.08.27.07.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] scripts: introduce CrateSource abstract class
Date: Thu, 27 Aug 2026 16:12:54 +0200
Message-ID: <20260827141314.1099352-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


