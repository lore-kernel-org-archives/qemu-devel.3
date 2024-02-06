Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79659C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLot-00077J-7z; Tue, 06 Feb 2024 08:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLor-00076T-9M
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLop-0004F1-JJ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707227337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCtZX9pAdFZxRp25eSGR68yFkHsghCKg6ZckRzHhzGU=;
 b=cdxxjN5NxJ14mZ/o3b/eE4KMgISu6i5qQ6PG6Nm54ngbT7E1w8VQ0gTCnMv38aQ16/glwW
 ugHGvPYIYOww5fA9kbvPxvZ+LDEa7EHFuvFXH0iMhb5p4NPrfqX1pmNHBoxvS5Uyv/t5bs
 M2gal8eNCugdssRfQZ4ftsBR/eKOfIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-m_wIQgqtMZGXez1eQCyiZA-1; Tue, 06 Feb 2024 08:47:47 -0500
X-MC-Unique: m_wIQgqtMZGXez1eQCyiZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE50B83FC24;
 Tue,  6 Feb 2024 13:47:47 +0000 (UTC)
Received: from work.fritz.box (unknown [10.39.195.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEAC32026D06;
 Tue,  6 Feb 2024 13:47:46 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v3 5/5] target/i386: Generate feature_word_info.c.inc
Date: Tue,  6 Feb 2024 14:47:39 +0100
Message-ID: <20240206134739.15345-6-twiederh@redhat.com>
In-Reply-To: <20240206134739.15345-1-twiederh@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 30 ++++++++++--
 target/i386/feature_word_info.py    | 71 +++++++++++++++++++++++++++++
 target/i386/feature_word_info.yaml  |  2 +
 3 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100755 target/i386/feature_word_info.py

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index 4beae01918..b4bece08fe 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -1,3 +1,5 @@
+/* This file is generated by feature_word_info.py. */
+
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -587,9 +589,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_VMX_BASIC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            [54] = "vmx-ins-outs",
-            [55] = "vmx-true-ctls",
-            [56] = "vmx-any-errcode",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, "vmx-ins-outs", "vmx-true-ctls",
+            "vmx-any-errcode", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
@@ -599,7 +614,14 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_VMX_VMFUNC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            [0] = "vmx-eptp-switching",
+            "vmx-eptp-switching", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_VMFUNC,
diff --git a/target/i386/feature_word_info.py b/target/i386/feature_word_info.py
new file mode 100755
index 0000000000..c9aa00900c
--- /dev/null
+++ b/target/i386/feature_word_info.py
@@ -0,0 +1,71 @@
+#!/bin/env python3
+
+import os
+import yaml
+
+
+def write_feature_word(f, data):
+    f.write("    [{}] = {{\n".format(data["index"]))
+    f.write("        .type = {},\n".format(data["type"]))
+
+    if "feat_names" in data:
+        keys = data.get("feat_names").keys()
+        if not keys or max(keys) < 32:
+            highest = 32
+        else:
+            highest = 64
+
+        f.write("        .feat_names = {\n")
+        for i in range(0, highest, 4):
+            names = [data.get("feat_names").get(j) for j in range(i, i + 4)]
+            names = ["NULL" if not name else f"\"{name}\"" for name in names]
+            display = ", ".join(names)
+            if len(display) < 90:
+                f.write("            {},\n".format(display))
+            else:
+                f.write("            {}, {},\n".format(names[0], names[1]))
+                f.write("                {}, {},\n".format(names[2], names[3]))
+        f.write("        },\n")
+    if "cpuid" in data:
+        cpuid = data["cpuid"]
+        f.write("        .cpuid = {\n")
+        f.write("            .eax = {},\n".format(cpuid["eax"]))
+        if "ecx" in cpuid:
+            f.write("            .needs_ecx = true,\n")
+            f.write("            .ecx = {},\n".format(cpuid["ecx"]))
+        f.write("            .reg = {},\n".format(cpuid["reg"]))
+        f.write("        },\n")
+    if "msr" in data:
+        f.write("        .msr = {\n")
+        f.write("            .index = {},\n".format(data["msr"]))
+        f.write("        },\n")
+    if "tcg_features" in data:
+        f.write("        .tcg_features = {},\n".format(data["tcg_features"]))
+    if "unmigratable_flags" in data:
+        f.write("        .unmigratable_flags = {},\n".format(
+            data["unmigratable_flags"]))
+    if "migratable_flags" in data:
+        f.write("        .migratable_flags = {},\n".format(
+            data["migratable_flags"]))
+    if "no_autoenable_flags" in data:
+        f.write("        .no_autoenable_flags = {},\n".format(
+            data["no_autoenable_flags"]))
+    f.write("    },\n")
+
+
+def main():
+    dirname = os.path.dirname(__file__)
+
+    with open(os.path.join(dirname, "feature_word_info.yaml"), "tr") as f:
+        feature_words = yaml.safe_load(f)
+
+    with open(os.path.join(dirname, "feature_word_info.c.inc"), "tw") as f:
+        f.write("/* This file is generated by feature_word_info.py. */\n\n")
+        f.write("FeatureWordInfo feature_word_info[FEATURE_WORDS] = {\n")
+        for feature_word in feature_words:
+            write_feature_word(f, feature_word)
+        f.write("};\n")
+
+
+if __name__ == "__main__":
+    main()
diff --git a/target/i386/feature_word_info.yaml b/target/i386/feature_word_info.yaml
index 7a8ca3f051..0e9dbcb613 100644
--- a/target/i386/feature_word_info.yaml
+++ b/target/i386/feature_word_info.yaml
@@ -1,3 +1,5 @@
+# Run feature_word_info.py if you make changes to this file!
+
 - index: FEAT_1_EDX
   cpuid:
     eax: '1'
-- 
2.43.0


