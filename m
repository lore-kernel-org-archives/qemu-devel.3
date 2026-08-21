Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F1C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKms-0004uN-Il; Fri, 21 Aug 2026 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmq-0004tE-Sp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmp-0008If-6V
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=FH0IX1U9cLapImUoV0QFmZUqrLnhIjLOQDLAMImFHGtBqy9oL6O5aS+7t9ID2R9SzbPoDi
 B1yH1VHTrbcTMywJGndHslSijgLm2/AWJkAxWfMBKQ2EAidQHp5HLtnfUwjcy5jYKAYl6L
 X49b9ufU83D9C/NlDkO9hd+03nkz4rc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-joPPH8eYNr6KFB_dBIWpXA-1; Fri, 21 Aug 2026 04:39:34 -0400
X-MC-Unique: joPPH8eYNr6KFB_dBIWpXA-1
X-Mimecast-MFC-AGG-ID: joPPH8eYNr6KFB_dBIWpXA_1787301573
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-698b899b53cso698895a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301573; x=1787906373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=H97O2gnFrlUUz9VsI+0oEI61Ut2sW2K6LjU+1wwnnyltby8/kdJ/OBXig81VgXxOa4
 QJqKqpVAwOUFce1l8J1QJyu1xL0DKkcZ/NCQ1HrNoyqW2MNuiB0iAg4/04baxuOM0QWf
 tF1MJFlMBcpdZn466PIkUf+FyMVtXzyaepYuL56N2WLKU8GJkaPE6MWUwmnszmPUBI4N
 pB9SUO2kgsRdMX/KjwvTqplp/CpCMrwhaRdH/x3zGuo/zprs8hGPXvzX2GGFS5WtsSGg
 hwbiWKPQtCY+5zoN5lqeaDHK/3Ku5+mB2RKyQL2FxAN5T+F1vyHan5/zUjd01GFO+Vip
 +4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301573; x=1787906373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=WYl+n3WaOTOBZGDXXGW6dNaoPk18XFgxMR42deuqrX08gFyWmGkL18ryMx7nCORpTQ
 s8UjhuY7EA4zPEFfd2GQoCMRbL3vB9gBI/Z8EarikB+VZRwA5S0aVvqebna9C9T3Kzrz
 A67mpyxIxy2V3jvmpj+j8K+jxznfe+DuYrbWeXTp7nV7whQE/+6zGBfdDOuUqgGJTKh1
 JkFO4ulMxu8lauv8me2g4fqeVbBorhyia7Od86tfM70TSRpEdwiZHQ5k2XG4Rgkn8Sbe
 oV6/HQg0+zx1BBNPZTi/8kB+mUnjJtpObzY1kquw4BYP/6CVpZ6k/0vYr2EnjMEXUIsP
 nKYQ==
X-Gm-Message-State: AFuF++nMAPBhSCwqwmUQltXTDnpbcZBlkBrd00dXYjW9jrC+qb4syOLz
 GvzdNeg5ZTrsayvWAsP3ASDtn9/rL1My0/Fx9RocSVZwGdfngN+7mkDQUf5nxutWStnwWo+XgtV
 EFtWPu1fiZcQSmxbkXi7FtRIUFbulbBsHA75MZulaENKi+6lXOQ/f7OqYH2OJOHz0tGXj6jjdXP
 l+ycI4888BZwoj7CxJSQlMc/f7HIy/AEFRSLv+rPw6
X-Gm-Gg: AR+sD11mwL5G9nFwLBEwk6yAREq/tpSNlYa6q65ATTXxKrN7GaGnEjD2+bZdfhCHYx9
 W09W4qIjZ81i1h31mh8aQo7HF0nfLHYpLItjAFQbuXDeh+5N3QOc4EERKcIKWh2mgza3H0up1zD
 SOlSFFtPv89cNFVRg3h161q2CgfOhO0XKUdTNGqDOs1b07dOVjfY1HHbhBQ7DOPfW+t6gP7vFTy
 3Td3lxTY1C+FHY5gBLJfbv/n7XxD8NBNplvoPFxtLCetPMpEKCI6BIEjX3Z5tQRqE7Y3Zq+4Ts0
 AALUqbal7R/refoXWMTWctl3wpbjLxIUBv/zKn1vzU8GQqfa90ukY55Gb7Wl7bPSRCRPoJnaLpS
 2Ebim+2AeLn7dkCzycC1rUyvGNe9Q74sN82I4KPs540hhGWKV0DJn+cDP6qkGCXF3MxvLJR909r
 5FMpo=
X-Received: by 2002:a05:6402:e09:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a42f229682mr5353496a12.16.1787301572773; 
 Fri, 21 Aug 2026 01:39:32 -0700 (PDT)
X-Received: by 2002:a05:6402:e09:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a42f229682mr5353454a12.16.1787301572319; 
 Fri, 21 Aug 2026 01:39:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feec9d52sm5690435a12.2.2026.08.21.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/9] scripts: do not assume the new version of the crate is
 present
Date: Fri, 21 Aug 2026 10:39:18 +0200
Message-ID: <20260821083925.2008135-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Until now, the new version of the crate was always there in
the registry.  This will be different when crates are downloaded
from Cargo.lock, so delay the comparison of build.rs until a
point at which both source directories have been extracted.

Since the .wrap file at this point points to the new directory,
delete the old one "by hand" with shutil.rmtree instead of asking
Meson to do it before the .wrap file is changed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 0095bd937ec..8b45c1551f5 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -15,6 +15,7 @@
 import filecmp
 import glob
 import os
+import shutil
 import subprocess
 import sys
 
@@ -50,7 +51,7 @@ def find_installed_crate(self, namever: str) -> str | None:
     def compare_build_rs(self, orig_dir: str, source_namever: str) -> None:
         """Warn if the build.rs in the original directory differs from the registry version."""
         orig_build_rs = os.path.join(orig_dir, "build.rs")
-        new_build_rs = os.path.join(self.cargo_registry, source_namever, "build.rs")
+        new_build_rs = os.path.join(source_namever, "build.rs")
 
         msg = None
         if os.path.isfile(orig_build_rs) != os.path.isfile(new_build_rs):
@@ -81,10 +82,7 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         if "wrap-file" not in config:
             return
 
-        # do not download the wrap, always use the local copy
         orig_dir = config["wrap-file"]["directory"]
-        if os.path.exists(orig_dir) and orig_dir != source_namever:
-            self.compare_build_rs(orig_dir, source_namever)
 
         if self.dry_run:
             if orig_dir == source_namever:
@@ -99,15 +97,6 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
             if key.startswith("source"):
                 del config["wrap-file"][key]
 
-        # replace existing directory with installed version
-        if os.path.exists(orig_dir):
-            subprocess.run(
-                ["meson", "subprojects", "purge", "--confirm", wrap_name],
-                cwd=self.top_srcdir,
-                env=env,
-                check=True,
-            )
-
         with open(wrap_file, "w") as f:
             config.write(f)
 
@@ -124,6 +113,10 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         )
         self.changes += 1
 
+        if os.path.exists(orig_dir) and orig_dir != source_namever:
+            self.compare_build_rs(orig_dir, source_namever)
+            shutil.rmtree(orig_dir)
+
     @staticmethod
     def parse_cmdline() -> argparse.Namespace:
         parser = argparse.ArgumentParser(
-- 
2.55.0


