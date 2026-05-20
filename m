Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5C0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh4z-0006Yj-Cw; Wed, 20 May 2026 09:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh4L-0005hQ-Nf
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:43 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh4I-0004Zx-9t
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB6D860129;
 Wed, 20 May 2026 13:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62E61F000E9;
 Wed, 20 May 2026 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284077;
 bh=UmjysPT0Ys97F2nZix4DsrsLKeKdeAt3nq7oHxKcr8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MGIMsMqkkWPPXVANaMZ4VcbGiIUiOIwzMkiIHDqvLpeZTIILS7lbwZtGMYteA4AqT
 LDdf9QI7D4hLfSsW8A2Qw5Wb11nGwv/2otADzJEyZZyXpqWMDpUjK2g83GtnLKHTmU
 26crBN0X5jBBN9UiTMm4/vXbXwm/IBRt22v9uR1GlHMF/FLNDZoQ0r9AqDiVrVlpdS
 wR1g6UEovGEMXEa5m5cpnrQIkV4MGtz6+vmVWJhKjnthnTgMG7Yx9tNkTkXfKBxVgd
 AM9zcA7tKjd9C8vUh4/6jw0yxcf6QNZZbdQD6DgG5N1yDDJvV9DkdEuJvy6c7TgOYx
 286fKTpCFmMdg==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>,
 Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 9/9] target/i386: SEV: Refactor check_sev_features()
Date: Wed, 20 May 2026 18:58:02 +0530
Message-ID: <cae04d88adfbcdc2997e518475f3b89091adf8a9.1779281646.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779281646.git.naveen@kernel.org>
References: <cover.1779281646.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=naveen@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor check_sev_features() to consolidate SEV-SNP checks to a single
if block. This is also helpful when adding checks for future SEV
features.  While at it, move the comment about the checks being done
outside of the function body and expand it to describe what this
function does. Update error_setg() invocations to use a consistent
format.

No functional change intended.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0009b03bdf7d..f04ae4e91f3e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -511,40 +511,22 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
+/*
+ * Ensure SEV_FEATURES is configured for correct SEV hardware and that
+ * the requested features are supported. In addition, ensure feature
+ * dependencies are satisfied (allow tsc-frequency only if secure-tsc
+ * is also enabled, as an example).
+ */
 static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                               Error **errp)
 {
-    /*
-     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
-     * the requested features are supported. If SEV-SNP is enabled then
-     * that feature must be enabled, otherwise it must be cleared.
-     */
-    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
-        error_setg(
-            errp,
-            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
-            __func__);
-        return -1;
-    } else if (!sev_snp_enabled() &&
-               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
-        error_setg(
-            errp,
-            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
-            __func__);
-        return -1;
-    }
-    if (sev_features && sev_es_enabled() && !sev_snp_enabled()) {
-        error_setg(errp,
-                   "%s: SEV features are not supported with SEV-ES at this time",
-                   __func__);
-        return -1;
-    }
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
                    "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
                    __func__);
         return -1;
     }
+
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
                    "%s: VMSA contains unsupported sev_features: %lX, "
@@ -552,13 +534,36 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                    __func__, sev_features, sev_common->supported_sev_features);
         return -1;
     }
-    if (sev_snp_enabled() && SEV_SNP_GUEST(sev_common)->tsc_khz &&
-        !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
-        error_setg(errp,
-                   "%s: TSC frequency can only be set if Secure TSC is enabled",
-                   __func__);
-        return -1;
+
+    if (sev_snp_enabled()) {
+        if (!(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+            error_setg(errp,
+                       "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
+                       __func__);
+            return -1;
+        }
+        if (SEV_SNP_GUEST(sev_common)->tsc_khz &&
+            !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
+            error_setg(errp,
+                       "%s: TSC frequency can only be set if Secure TSC is enabled",
+                       __func__);
+            return -1;
+        }
+    } else {
+        if (sev_features && sev_es_enabled()) {
+            error_setg(errp,
+                       "%s: SEV features are not supported with SEV-ES at this time",
+                       __func__);
+            return -1;
+        }
+        if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
+            error_setg(errp,
+                       "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
+                       __func__);
+            return -1;
+        }
     }
+
     return 0;
 }
 
-- 
2.54.0


