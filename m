Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB91C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzara-0002ew-3y; Thu, 27 Aug 2026 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarQ-0002cc-EX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarM-0005g4-6m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=iCrHVKVhY+VKfDL50sBA1SkYT5PU7ns96g+Wv+PJdPr7yoXGQjX2/+IzMMYkEXanBX10uH
 XetWz7UxxXpQF3WYoH89YhBHDEprGFUEw6PLaViUwvz9Ja1wIAJG68XDHGZfB3MmNiuoO3
 tL48sHHNDKeY+8hq+Rd6OqJQwlyRcyk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-aoipw8JUPa6BN2bAW2iuzA-1; Thu, 27 Aug 2026 10:13:30 -0400
X-MC-Unique: aoipw8JUPa6BN2bAW2iuzA-1
X-Mimecast-MFC-AGG-ID: aoipw8JUPa6BN2bAW2iuzA_1787840010
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c24ae1a510cso63916766b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840009; x=1788444809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=VsnhDFEggCpAZhnSIAXNrfSUQZgpmjUx9QtviTP6wjxrXImY8dhcwGvXWdbf5r1X96
 w/5BNINyN5bybiZ1rQNCSgTw9bS8ir/kjQHVEtJfQz5yjwj1MnZYeAubcqIn/eQ4nPJU
 QWg4/jcs1tETYwuGU5xX/NFy/amC80bS14HU9h4WXHVDDJvhZ6TR8h3J1GyMM7jdteIi
 kre+8PcMC9xUdeS4tXsicXl4MPU+ROU4dWkOjVNMbuwzafAfRSq7OncF/V4T74PS3WYq
 0mrRnX+JpZ5OOnaPVpnYno0DuGi8cwYNUsT8MGrpq454um3PPeGcTWTU8tWfo06aVdRa
 7GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840009; x=1788444809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=sYW/6P5X4BXfPitOUQJA3kptME9lA4fBnK25uepaYjLVwBxfJjpvYCI/F9DM1b7Lyb
 ujA0BlMrSxVkag++z2h1UakIWjDw777OruGebN2qEDBooceMKucxtsQBuaKufEGTL6pA
 DKbcIJtLZ1RyzcDKHatitwNuJDAkJ7Mre4meK7jvXYAYZb//KXVqsshOeauVR3FkKgJY
 fZ2hvaMo2UzIeYqRuw4FEe4OwXajQvxVr60FnKFdpzYefsjWrh1FNgGwR6jG/ExPU9hU
 SnEv60jkrjwA00NhylrzUaU/dqNJRG/SLEzVDHRe9dbzO/MR44FxtqL3pVKYVNVG0o43
 HZSQ==
X-Gm-Message-State: AFuF++lRztPswY9rrpNZjPfyDeaR0nFDmlwdF9h7lzDa4sC/y9wFqeIw
 TdrmjMAo6ACxRYjtJnSVDmgCJJ4Lsxll8iaATzrm0MGeTOa8ImiAtxWAbVl6R9PmrigUWru0cAE
 xHz/GfJTc/ef33v/F2jJdb8OX/DNkNCZUEqgDIZJh0CYIfLxbuO22mJdMwxVNPCvoozSpMT6/Af
 Fo07oHvwS1HvXg67x3b3EDB+5iaSBcUmM6/KGT4xbF
X-Gm-Gg: AR+sD13B8vdpI8u33smRnASFEQtsxf9SxHSWmDReL6d0hK7Mbr0L57fJVm6rwG6j2nV
 bf7zBnKL5gOus4uFNiJe+WgtDfo43HBa+mAIljdf5nqbjNbv12+pAboFdIF1FQGYupRSsr877XM
 y7B7ZuQDuy1p8VanxzU7QKY+x2/SJEvgXCKfqE0/FVM1aBOAWlkXotMkCMpA74xGIzV8NnKYTCd
 hW/OoUOsrb8Hb+IRydhCIj/cJZBK6znIfmylBlKtOKxvhS0ayB4Nj8aznZ0xnIRz99jbS2YY0eQ
 xYznmcyx4CqOLL8CBGENYryUOrhDuCtnEVtJ+AXVj07RQP84w5SyYIUaJ0gIaF6bL55oOUuv2Kg
 jVXzOAyO0YjP4YruIq/oCHp+YT70a8h+s//PxWXNBQ6qqhobWgo90+zeaYx5CNMkZ4DwB9/QH82
 pv1tM=
X-Received: by 2002:a17:907:e84a:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c250c33108fmr1751443666b.11.1787840009612; 
 Thu, 27 Aug 2026 07:13:29 -0700 (PDT)
X-Received: by 2002:a17:907:e84a:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c250c33108fmr1751438666b.11.1787840009108; 
 Thu, 27 Aug 2026 07:13:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88a928sm801105466b.33.2026.08.27.07.13.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/23] scripts: prepare for introduction of CrateSource class
Date: Thu, 27 Aug 2026 16:12:53 +0200
Message-ID: <20260827141314.1099352-6-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 8b45c1551f5..8114f0731be 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -48,6 +48,14 @@ def find_installed_crate(self, namever: str) -> str | None:
         matches = sorted(glob.glob(f"{path}.*"))
         return os.path.basename(matches[0]) if matches else None
 
+    def rewrite_source(self, section: configparser.SectionProxy, orig_namever: str, registry_namever: str) -> bool:
+        # the registry already holds the extracted sources, so Meson does not
+        # download anything: drop the source_* keys.
+        for key in list(section.keys()):
+            if key.startswith("source"):
+                del section[key]
+        return True
+
     def compare_build_rs(self, orig_dir: str, source_namever: str) -> None:
         """Warn if the build.rs in the original directory differs from the registry version."""
         orig_build_rs = os.path.join(orig_dir, "build.rs")
@@ -82,7 +90,8 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         if "wrap-file" not in config:
             return
 
-        orig_dir = config["wrap-file"]["directory"]
+        section = config["wrap-file"]
+        orig_dir = section["directory"]
 
         if self.dry_run:
             if orig_dir == source_namever:
@@ -92,10 +101,10 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
             self.changes += 1
             return
 
-        config["wrap-file"]["directory"] = source_namever
-        for key in list(config["wrap-file"].keys()):
-            if key.startswith("source"):
-                del config["wrap-file"][key]
+        section["directory"] = source_namever
+        if self.rewrite_source(section, orig_dir, source_namever):
+            with open(wrap_file, "w") as f:
+                config.write(f)
 
         with open(wrap_file, "w") as f:
             config.write(f)
-- 
2.55.0


