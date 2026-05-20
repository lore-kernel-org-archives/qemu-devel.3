Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59666CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh4P-0005hP-9c; Wed, 20 May 2026 09:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh48-0005cR-Ov
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:31 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh46-0004Yc-9s
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E6C940D78;
 Wed, 20 May 2026 13:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F411F000E9;
 Wed, 20 May 2026 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284064;
 bh=+k2jL4kdAXoAJqmY8Ukt1559hjuhb6dWxPx7lNS/EI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R1HuYS9/IvqImSOxoFGj9owcn/uIINPdJfg5qt7fmIMVuOwK+mwI41VJ6jY4dvDZF
 /kd8IvNN7/o2vohaxvs7AgksaCofTPOuVcMlwFgtMOw9c0r48D+6zigL5Ugkz+Bss4
 RoSTYce90YN35+rQCcO9zT/ODSuWSRjC+IjybMfLhjOQys91kl6KinzDWevxLjLEbB
 8PT0RHhOD+u36yeAOGc0h6YSQedgfmLt2Fq2hkYguM1BnZWiGzHsSPyn+3b7QjqcY/
 mgWd3fN7qXGfGl6T8kds/26yMaZRdbrrDBXUN4v4Ok1H/2L+Mpc2JFuiSRW5NSqipZ
 NuoYkPFXlmQ+A==
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
Subject: [PATCH v4 6/9] target/i386: SEV: Add support for enabling debug-swap
 SEV feature
Date: Wed, 20 May 2026 18:57:59 +0530
Message-ID: <416e7b156e49f95958f8c5c8549b48a88c1995fc.1779281646.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779281646.git.naveen@kernel.org>
References: <cover.1779281646.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
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

Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
objects. Though the boolean property is available for plain SEV guests,
check_sev_features() has a check that rejects attempts to enable any SEV
feature for a plain SEV guest.

Though this SEV feature is called "Debug virtualization" in the APM, KVM
calls this "debug swap" so use the same name for consistency.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on

Restrict debug-swap to SEV-SNP guests at this time due to a
compatibility issue with SEV-ES pflash devices.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  1 +
 target/i386/sev.c | 26 ++++++++++++++++++++++++++
 qapi/qom.json     |  7 ++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index b84ca3ce0b67..d19a39669747 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -47,6 +47,7 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_DBG      0x80000
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
+#define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4553fe4d6e4a..4532b1b6a484 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -328,6 +328,11 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
     sev_common->state = new_state;
 }
 
+static bool is_sev_feature_set(SevCommonState *sev_common, uint64_t feature)
+{
+    return !!(sev_common->sev_features & feature);
+}
+
 static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool set)
 {
     if (set) {
@@ -527,6 +532,12 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
             __func__);
         return -1;
     }
+    if (sev_features && sev_es_enabled() && !sev_snp_enabled()) {
+        error_setg(errp,
+                   "%s: SEV features are not supported with SEV-ES at this time",
+                   __func__);
+        return -1;
+    }
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
                    "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
@@ -2800,6 +2811,16 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static bool sev_common_get_debug_swap(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP);
+}
+
+static void sev_common_set_debug_swap(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP, value);
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
@@ -2825,6 +2846,11 @@ sev_common_class_init(ObjectClass *oc, const void *data)
                                    sev_common_set_kernel_hashes);
     object_class_property_set_description(oc, "kernel-hashes",
             "add kernel hashes to guest firmware for measured Linux boot");
+    object_class_property_add_bool(oc, "debug-swap",
+                                   sev_common_get_debug_swap,
+                                   sev_common_set_debug_swap);
+    object_class_property_set_description(oc, "debug-swap",
+            "enable virtualization of debug registers");
 }
 
 static void
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087c3..e2bb716b603e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1017,6 +1017,10 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @debug-swap: enable virtualization of debug registers,
+#     only supported on SEV-ES and SEV-SNP guests
+#     (default: false) (since 11.1)
+#
 # Features:
 #
 # @confidential-guest-reset: If present, the hypervisor supports
@@ -1028,7 +1032,8 @@
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' },
+            '*kernel-hashes': 'bool',
+            '*debug-swap': 'bool' },
   'features': ['confidential-guest-reset']}
 
 ##
-- 
2.54.0


