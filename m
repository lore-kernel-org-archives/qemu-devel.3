Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E3FC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarU-0002d4-8F; Thu, 27 Aug 2026 10:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarQ-0002cd-Eg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarL-0005fk-Lx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=ZCqZskF//n7W847BqMRP1F8LZMggARyXw4tHDcnAMSRqOtMiUG/ogC9mDzCMc6bv1Z/vMe
 cgBp66qHcqG8g2XjI4UJkAty9ZxIOouYOo1f12G+iXRhpb3WJRMzwlzdLyqcQBk6n/rOsh
 W4zFwUtB/ymIUdGlVEYKpyk6BLYSfBA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-9maZh--JNQ-WfT1sA4-7yg-1; Thu, 27 Aug 2026 10:13:29 -0400
X-MC-Unique: 9maZh--JNQ-WfT1sA4-7yg-1
X-Mimecast-MFC-AGG-ID: 9maZh--JNQ-WfT1sA4-7yg_1787840007
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482e8e1ac69so539828f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840007; x=1788444807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=iVIvtGKA/E7qZuWQeLX9ewe+XOGKOo37LQqI2DrA7hQqFJ8RAg+5sD9ZJ1Sm/Fvnul
 olm4J3U6Vvi7ziOCoRMWDuuQYwgHLW56OiHQpKYcsT9/072tY2ltmct4XZQTFnZdVlxd
 C0NbbG5votqtMB5WguHN/LukAh0sXlDVc6VPfJZXAp+++YhBR/UuTPILerRMUiVWJUCk
 YfcBOLrat1MW7BCKRbXItp2wKw+dJNmFSVEAh4RBGEWqB+voS6mNStPIoMIcyrhY9RTY
 w+8JFCHiBsaj/UsrURZdf2B41YGzckHsK1ktF7bqAEXdY1Y/HqKRtyILAi/1a0aVjZer
 NAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840007; x=1788444807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2FiQTp7Qc/4aZI8CJqj9y3o4hGPPctMwiZp74U/qlY4=;
 b=cknXMnqiw5CMPhrzAwaQK7fixGFhaDT2ac9nvyVlRcMtavCAX0W4l+tTZM20NMXPvE
 DUD++8Da8w/fP+Gky27r1e5brU60ybDqFUHl9kmduvnBRnrJr3+0uIbLVRNvqc2BbujJ
 robaqc6ENbTsV/PnNUUEbmZInIK+I13hmg8HhK25WrMl1DU/seazlR38/rB5krtXydqU
 k5ZsDCrp8nX+c1X2HePCFl8TCPHN1G0Oo7BnVvbf20+ic3PR6vlVJiuOj3wSUixzbaJu
 HKu5pX75gQNmzaiO2/O3gjHfKKSme7lQWkZBHrLJQ/hV3VVA9EpDlnPufBVTpj7/smxM
 wLMw==
X-Gm-Message-State: AFuF++mV6orqoRIVJ4Og7EvvCq+V+M2+JGEOOVt3oLrxlcPShwYwKi15
 DY3XL3VNS3DnrLqawKay349/TciA4VQPzzcEyfCoeKT5jiocEZKJNDFUN9r5RBQYBaE0PJfQwpY
 hmHgGH4pwR38RNro+wWX+GOy2a1+A+vkeT47AGqDERZBNeYcJNXT9siRfEwvX3f9sa61KdK3ZGV
 bBpRc7yJbadXu90RL3uO56LfbT8DcQbdISirfyKWdV
X-Gm-Gg: AR+sD12ay8lpQAZkywjePlKiVMlYgnRa2GoYogXPgdtDhcy1wGpNs36R9EJODmHj+ny
 kVVKlMDCGgqjDHVno1N44gHr2zNeTmQux8VWWHRhBHMvLaFLwdBYrh9IQ1H9vXx4CNSlWmTZnT0
 FM/yYe4epOUtVgHb5V3ge64PUHrHFTzf3If/8bWMoYsioHwAMCOhBkf4KVxpp1gp7kWx5YVuN90
 lYfKFapskIQHbz9EAOeDJ7WR5LQhoxoAC6AwA+UFFQZzy3aUJtOISykN5GFlVv8pBjUCDeFHtk5
 DeneSgXQ7da0FS+2hbtzty/JNcWLweVMsE+CTQ0iyfZXnrhcly8CCq1UPMHKTdXxSayp4VFoqBO
 blIBdQ3ZQriuSnYx0DF6lpZm6NI1qZT2fLkVziIIY0Sd0GXilNOqLX12HWo1rjCeGzz2dJ0ofGK
 eLXn8=
X-Received: by 2002:a05:6000:4026:b0:47f:8cd3:4bed with SMTP id
 ffacd0b85a97d-482eab75e65mr9878619f8f.5.1787840007286; 
 Thu, 27 Aug 2026 07:13:27 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:47f:8cd3:4bed with SMTP id
 ffacd0b85a97d-482eab75e65mr9878537f8f.5.1787840006830; 
 Thu, 27 Aug 2026 07:13:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e8fb5sm9386811f8f.29.2026.08.27.07.13.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] scripts: do not assume the new version of the crate is
 present
Date: Thu, 27 Aug 2026 16:12:52 +0200
Message-ID: <20260827141314.1099352-5-pbonzini@redhat.com>
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


