Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC2CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhEL-0008Pa-44; Tue, 28 Oct 2025 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhDM-0007dh-64
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:46:10 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhDI-0005ik-Ic
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:46:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B0B341513;
 Tue, 28 Oct 2025 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2534C4CEE7;
 Tue, 28 Oct 2025 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761648362;
 bh=D7GV5YIK68KaGFIMf54ClZrWmjlH6jCoh70v8kXC7y4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VYEHinBMuNAEqyu4VNJ9U0kDI3rfkJwqKkNvLUWzhvaFnFLyj1NlX5NqOFuDArxw6
 ULBmuOh1lRRK38agQcTJbtya6scu9CuZnv4o6icC1NgNOURJtO+eeKAeYpv1esiSca
 EYWP47hadwWrYRjYQOOyWdaURJWqCtrYZDNmxdbeFYBmrw4Pjebonpd5h6Nwje39z1
 kQ3iyTPYSyDToz26+cjSrmGNE1eP/E0GjZOqk5KjmYCdyTy7SaIdeJOMx7CXL2vgtC
 3STl0iZpx0M+jxwgotCpaDe2ao+3rp1enSNrc0nL1v2BJo0ZTWZR6tkJSejwyQLaHG
 Uwj9LbHJaSyTQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>
Subject: [PATCH v3 9/9] target/i386: SEV: Refactor check_sev_features()
Date: Tue, 28 Oct 2025 16:13:34 +0530
Message-ID: <0f998f5761f180829240f84172698f9315655572.1761648149.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761648149.git.naveen@kernel.org>
References: <cover.1761648149.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/sev.c | 55 ++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 56d7cc9e6901..50d9e5714408 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -502,34 +502,22 @@ static void sev_apply_cpu_context(CPUState *cpu)
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
@@ -537,13 +525,30 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
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
2.51.0


