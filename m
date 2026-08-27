Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F69C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarZ-0002eZ-9r; Thu, 27 Aug 2026 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarW-0002dq-9U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarN-0005hX-CD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fw4f0kzvVqy0S6njX9tdZ399Ssuq2ixYN/WFdO9R4bo=;
 b=cvuY0/wC0Fl79VWHoyBDdbHXA/f8phV/M+6bx5YbCgVNRSPzSeT3Fcju4/vBs7HY6oJh2c
 qEu3gn0kTnDLu8ez6kmh0IrqnCvaAYBdjCgyJpVJhW3VcJtcJbJaZdAnjhoDRIFvt4lH8R
 reW4S1JTSeuclIMiTwqZpZEa1XL2LVA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-NMTz3KY1NK65hJiqu_G0JA-1; Thu, 27 Aug 2026 10:13:25 -0400
X-MC-Unique: NMTz3KY1NK65hJiqu_G0JA-1
X-Mimecast-MFC-AGG-ID: NMTz3KY1NK65hJiqu_G0JA_1787840004
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49b64e98e94so5255825e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840004; x=1788444804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fw4f0kzvVqy0S6njX9tdZ399Ssuq2ixYN/WFdO9R4bo=;
 b=qvmmb7FzKpTR5YQxMiCdgNKeUmyWIKsfELCDnPtl9zwIBs4nvbw2CC+Xhdy4q251vH
 1NVRHpp9TCwfUvmgt+ky98rEusuOBEC7M1ByxlPRZoN8vyd7+igkyLMi6DbuuGbfIxDD
 hL+M6N1NHlGgWmn/PE4CrrsAVStJxWnti/cYI2OW8VqrDENnf7asg3U6nZMq7VgyvhCX
 1N564O7Du683n5kotkq/NC04ebJ/+xl4dKU2/KNUlfuUgN+A9gh6Mn6XXictZ8qVacIF
 U0NViFOvfAYe8UPRTol2AhWd2tjpRk4RrLoHVQo+0SeYTeVhDnsrkcnFiDnMzoPqdpTy
 Nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840004; x=1788444804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fw4f0kzvVqy0S6njX9tdZ399Ssuq2ixYN/WFdO9R4bo=;
 b=PFdQjIR7aqZHplXBSwFU6qodlKDZ18QUHZZgFiQDYNsKyvypT939QI24yR1E+lltJt
 nWkvR8SMV+GOcAiWUVJaa4HrJOxL0EAwSWAoDeEBb20JzPLeoFWUo0Z6lH6SXupaJyrh
 AkXn5n2/4IiMaWtstithPLK9LnA6K1vHcKJbzcniJNAzvaMo4l/aX8mJHPTzFjjbZtoW
 vSwHykOILIWcqcSLDeTXpzoUyBspYqzTE5GiZNljNYPUVE1R4LuJY8VGRNtxIAdyC83y
 cgEue+qSv55tq6nLEvmVAudaAOt1A4/cTlGiptsORhmOusvpKunxRDZjNUzbVUEO8Nca
 PRbw==
X-Gm-Message-State: AFuF++lHv5gbbJ60y2Q0CNOjzCTsFCCtPPEPH3xzuhYv5zNM3gDlHx0u
 wn4ZJHUYIk6OPcrzxV03X+ERJDR7DDkRjoIHAob8p6HizqrNq5FvGNKsuVI9cqkE6TsmrK8tJvb
 ePiuoqkYQUhmz2YRcFPa6mvqTyQOxuHClw5eiP/6D0IIxgsK3tDEGwx1Nodel23SGNR7OfOT68S
 UNm3iudZjkKjczDim5wJ9mJ7xQlMtG2E4yWQmPvXOO
X-Gm-Gg: AR+sD11KF2xo4rV0l1YAYZUjOEDw8cLmckvmoCc/GhcFrb2phkimwakTSL27z+ho4z+
 oomF76+t3wTjGOpWwDgEmwmxSgz4plM5YFM8Kz8oFbDLb6VYOZAN+V9YtyVrkt0hp6zQLqKlRny
 9hcYb45FTDzFYlxraUnF/IV3/+6GE+cFBABvtd1ePzCYQYZjvnQFmbnO9pgvbSmcVuSnni+5+fh
 /mFfkCClmXmUdtAmBjNLMDUnz4pqt3JgrK+Zqq4WNGS2u8qlPzsDkCsGTT0c1uhxoYC9uqfKgfo
 OvRyQWWCevvXD9vqAxOTn1xXFRYA6YUwIH8KqWAo7R1wFcRTrC5bZuc4Je7kuIKDGoGZTynu1qv
 k4RoyckcZKqhUA/RjM+wDIZmvY4ce91y3zb4QPDMx6O6ivH0FgSZuN1+bdP/HwQQEoSzusarzqg
 XGXPs=
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr95427445e9.7.1787840004140; 
 Thu, 27 Aug 2026 07:13:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr95426525e9.7.1787840003602; 
 Thu, 27 Aug 2026 07:13:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4961004bsm67496225e9.4.2026.08.27.07.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] scripts: rename variable in
 scripts/get-wraps-from-cargo-registry.py
Date: Thu, 27 Aug 2026 16:12:51 +0200
Message-ID: <20260827141314.1099352-4-pbonzini@redhat.com>
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

Do first the change that makes the diff larger than it should be.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 84c652127f9..0095bd937ec 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -47,20 +47,20 @@ def find_installed_crate(self, namever: str) -> str | None:
         matches = sorted(glob.glob(f"{path}.*"))
         return os.path.basename(matches[0]) if matches else None
 
-    def compare_build_rs(self, orig_dir: str, registry_namever: str) -> None:
+    def compare_build_rs(self, orig_dir: str, source_namever: str) -> None:
         """Warn if the build.rs in the original directory differs from the registry version."""
         orig_build_rs = os.path.join(orig_dir, "build.rs")
-        new_build_rs = os.path.join(self.cargo_registry, registry_namever, "build.rs")
+        new_build_rs = os.path.join(self.cargo_registry, source_namever, "build.rs")
 
         msg = None
         if os.path.isfile(orig_build_rs) != os.path.isfile(new_build_rs):
             if os.path.isfile(orig_build_rs):
-                msg = f"build.rs removed in {registry_namever}"
+                msg = f"build.rs removed in {source_namever}"
             if os.path.isfile(new_build_rs):
-                msg = f"build.rs added in {registry_namever}"
+                msg = f"build.rs added in {source_namever}"
 
         elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs, shallow=False):
-            msg = f"build.rs changed from {orig_dir} to {registry_namever}"
+            msg = f"build.rs changed from {orig_dir} to {source_namever}"
             # diff exits non-zero when the files differ, which is expected here
             subprocess.run(["diff", "-u", orig_build_rs, new_build_rs])
 
@@ -68,7 +68,7 @@ def compare_build_rs(self, orig_dir: str, registry_namever: str) -> None:
             print(f"⚠️  Warning: {msg}")
             print("   This may affect the build process - please review the differences.")
 
-    def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
+    def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         """Modify [wrap-file] section to point to self.cargo_registry."""
         assert wrap_file.endswith("-rs.wrap")
         wrap_name = wrap_file[:-5]
@@ -83,18 +83,18 @@ def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
 
         # do not download the wrap, always use the local copy
         orig_dir = config["wrap-file"]["directory"]
-        if os.path.exists(orig_dir) and orig_dir != registry_namever:
-            self.compare_build_rs(orig_dir, registry_namever)
+        if os.path.exists(orig_dir) and orig_dir != source_namever:
+            self.compare_build_rs(orig_dir, source_namever)
 
         if self.dry_run:
-            if orig_dir == registry_namever:
+            if orig_dir == source_namever:
                 print(f"Will install {orig_dir} from registry.")
             else:
-                print(f"Will replace {orig_dir} with {registry_namever}.")
+                print(f"Will replace {orig_dir} with {source_namever}.")
             self.changes += 1
             return
 
-        config["wrap-file"]["directory"] = registry_namever
+        config["wrap-file"]["directory"] = source_namever
         for key in list(config["wrap-file"].keys()):
             if key.startswith("source"):
                 del config["wrap-file"][key]
@@ -111,10 +111,10 @@ def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
         with open(wrap_file, "w") as f:
             config.write(f)
 
-        if orig_dir == registry_namever:
+        if orig_dir == source_namever:
             print(f"Installing {orig_dir} from registry.")
         else:
-            print(f"Replacing {orig_dir} with {registry_namever}.")
+            print(f"Replacing {orig_dir} with {source_namever}.")
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
@@ -162,12 +162,12 @@ def main(self) -> None:
         for wrap_file in sorted(glob.glob("*-rs.wrap")):
             namever = wrap_file[:-8]  # Remove '-rs.wrap'
 
-            registry_namever = self.find_installed_crate(namever)
-            if not registry_namever:
+            source_namever = self.find_installed_crate(namever)
+            if not source_namever:
                 print(f"No installed crate found for {wrap_file}")
                 continue
 
-            self.update_subproject(wrap_file, registry_namever)
+            self.update_subproject(wrap_file, source_namever)
 
         if self.changes:
             if self.dry_run:
-- 
2.55.0


