Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F238C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKmv-0004yH-RS; Fri, 21 Aug 2026 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKms-0004u5-15
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmq-0008J2-0h
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=bTb5uxZY0Rvl8J2R4OhXlthg+9sYCa4tXnHmWR/0YiQjC3ffUxdde5GxbM7Weyf6Fh0cOk
 ipaUyMMInJ+SYbzThDFobNcvr0hsiZPPbAsFkmsItXWN0dmuPrFZJ9fBlFdFZaltQX9Md/
 KsYzhA9w93F+cZJHy7+BU9KNUY9b3w4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-tuvuMnmtNMaTuoCIIn73Eg-1; Fri, 21 Aug 2026 04:39:37 -0400
X-MC-Unique: tuvuMnmtNMaTuoCIIn73Eg-1
X-Mimecast-MFC-AGG-ID: tuvuMnmtNMaTuoCIIn73Eg_1787301576
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a368c27a94so926118a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301576; x=1787906376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=lOlH9T6MOUcAUbMPQ2SjRcDwMEE3SdtswBo1yhXKHHHUSnathCrs+fIaSlIuA1P3iE
 xfNiOMa+iItZwGSdfa89IL2phqDnmRzlMnBqm+GP0XSBPe5WwKCIpGUp5iNfr25iYNJY
 xF+C48zkeQXb+H6IzxDvhIZ6gxnviWj1HFiuD0LPGmJi0s8x/fG/ySguM5kBIemauSQ2
 8j48GvvYELNlHzvGceFao+r/jJ095CBvMiaH3iI6Vz4cDkHUVOaF6ebSVxbVN3z2+5Up
 HGO2NU6QL3ewphE2nCe0WO7O6xUQ2rM5A0HsMZfdzZMNxFSjsjidjS0aJrcM4OLpWfno
 JBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301576; x=1787906376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pmhrxutqvfwk8kCCA5LdrLPDB71Ss207mNaYjLClR4E=;
 b=Bvq0AGWi+JehfvlwPEXE8Ru35TzZFqpM9XaWOHmCTLru1cytglUF0SzuITPvInDWMg
 rg912fJ3t2LdINFofhCPavAuTbgoIXH+QI11l6FddktONjeomum63GMMPtVwe9Hx818t
 eXBJJCg0GqmSHuZaiRq6/K+XtKUXLzMeRFIgL/y0rWxKepYk1uTLsKRpc3SKjeitdlvD
 LT7laJxjCBZ2afhmwFmMS/ybuq6tlzZ4OY4xJmr5JyihdC7Dh5iS05WSaV9sV6X+ApEw
 j4etMsgBM5qdaEXkE1qHhpVP3xDhPJr7rAwgW0yVm64rJPXb0yAvWH9d4eclhj4Kn78h
 H4Yg==
X-Gm-Message-State: AFuF++lZRoHxCyPHuiMqA1MA4NQUTVoIWd95SAfMFJnehwa9UFo20f9q
 b8oNbAJcoOZC+BOuhqmZhyrVAQ9mSJqQHVh8wz1LQv2cPqsUVx4yhlxDc6YlTlY8sFUMfICHzdG
 etyNtBeSgV+feQuPRVZk1RVkLI8kSrHE/h6REk8B7MpVDWVWJJgrI4S1gXllsQ1I7rVu8xy2t4d
 bh55uOdWk1QeShSC0Xzrjwxo2+Vh42Ih7Tmi6EW+CN
X-Gm-Gg: AR+sD10jetpWAZ6d4E4LtUNTyX0oxydngw9YBKvMOKveICdOfcF6LQFQQrXWGUOX0QS
 h71v6pz5FfvBye3SI68yPF+9FkHkq0cbOxuQ6APJ4dxpm4/2w0z4LPRKN/CukiAhpiJ7i6FEK1C
 73my4Tij1io4Ta+3ppQo4ylJ7zAxicNBfI25+m0Z9zb71YNNwjGxjzfyLEFNPEeq4z1XkrXlVLv
 NkDDQNYvm/5rZGk2ARe6Ygr3pSqr6IPRK8KP97jqpE9PSBqnDU+pIP7rm/MVEVHcupjsqjAWm9I
 xa9A5sOmLMYpjpJtJLhJgycnpCayMBWubRbMl+IW5wbN32ANbOf4hkDGlFdt1gytfvRqYGN1F+v
 4FiuPgucWG88XdWcnwqu4+NbDlivUm4tDQp8h3xefUmoA+acTv0UO7ZHfKsBXRoJAAs2X2Ss3rR
 mL4oU=
X-Received: by 2002:a05:6402:1f07:b0:6a1:c908:1701 with SMTP id
 4fb4d7f45d1cf-6a42f26dab3mr5425875a12.13.1787301576459; 
 Fri, 21 Aug 2026 01:39:36 -0700 (PDT)
X-Received: by 2002:a05:6402:1f07:b0:6a1:c908:1701 with SMTP id
 4fb4d7f45d1cf-6a42f26dab3mr5425827a12.13.1787301576015; 
 Fri, 21 Aug 2026 01:39:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1567f8sm5559242a12.18.2026.08.21.01.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/9] scripts: prepare for introduction of CrateSource class
Date: Fri, 21 Aug 2026 10:39:19 +0200
Message-ID: <20260821083925.2008135-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


