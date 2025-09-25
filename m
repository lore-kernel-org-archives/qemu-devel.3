Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6045CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jEF-0002Ed-Ar; Thu, 25 Sep 2025 06:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jE2-0002DZ-67
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:29:22 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jDn-0002oh-Vh
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:29:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EF4C604B8;
 Thu, 25 Sep 2025 10:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DFC4CEF0;
 Thu, 25 Sep 2025 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758796145;
 bh=wJSo3WQzSH71VjjXufSwDyaPJVRkcT9QbNW+ZtCSfRU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nmjr/fmrX1SmcYzZFFXfUwm1twPQFmiJs8Dy94G1uTMg26WiE1GHfmg1rIA0ntjAc
 Z+4y1sMn41qq5EJXSFRMn5cPJRUS4//evh2FpAtE02tPOKGlmPnunf/hzCyX/hJCYR
 ULgVVRxn6vsLYXGOA6f2w/l9mxSBUSFLkHIqYUWxBm4AmNR0E74yeut+ahwd942PlO
 tixTKdu/ljo/vzzjzJ7pTkN9HQYDTSHj4moN7s5zPFNVcaXtRvMWw+2bqB/xhBrfkv
 k5Q/qAleWa16a41L65IgyWhHf+NS663fBtxwAtTf3HlQdJW/DRcZx/rm6N4Y995TMG
 25qv7QlicoeVQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: [PATCH v2 9/9] target/i386: SEV: Refactor check_sev_features()
Date: Thu, 25 Sep 2025 15:47:38 +0530
Message-ID: <f60170d4148c4da09e6e0ff4f6f0742106fd9eca.1758794556.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758794556.git.naveen@kernel.org>
References: <cover.1758794556.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=naveen@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8bb9faaa7779..138210e24124 100644
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


