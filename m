Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E15CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh4h-0005jf-JB; Wed, 20 May 2026 09:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh4B-0005cg-RD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:34 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh4A-0004Yq-7w
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E89EB43C13;
 Wed, 20 May 2026 13:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EC91F000E9;
 Wed, 20 May 2026 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284067;
 bh=7jY1Xl/nE2K7yyLSCwbE80xENs5KSlFwmUcqOsfvTg4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mFtTMnOjYyaay6gszFoYjihMCbOhuXGjQnvIcPeLOAsfqEBAUUG8/Lv1Nh5GOdqR3
 NISXR/GiisGG2QJq41G3jH/X1GS6sDP6tYcuS9P3akHsDwA1A7v0UNAV/b+0dTNXga
 t228VGdW5LSm4jMiSJOmSDyTrsvkZwCnE4sfiCTtYF6jo1YzM8ToTeH4fYuVVcDSAO
 n5X6FWVIasyxGD6m6OnJLhbz+1M0I8TtPXn+pvqNlKcdcJjchsEsvB1GiQsJ/6Vxnm
 BaHROTs1CQxGmwXrKjoLK8KUQxlHR1EQEzWiq36K/ujm292wIyvi2e8Dd4QbsDJM2H
 lo6HNRVn43wfg==
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
Subject: [PATCH v4 7/9] target/i386: SEV: Add support for enabling Secure TSC
 SEV feature
Date: Wed, 20 May 2026 18:58:00 +0530
Message-ID: <9f58b92a173f319b3ef725f5ed8a2a173eed55b1.1779281646.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779281646.git.naveen@kernel.org>
References: <cover.1779281646.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
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

Add support for enabling Secure TSC VMSA SEV feature in SEV-SNP guests
through a new "secure-tsc" boolean property on SEV-SNP guest objects. By
default, KVM uses the host TSC frequency for Secure TSC.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  1 +
 target/i386/sev.c | 13 +++++++++++++
 qapi/qom.json     |  6 +++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index d19a39669747..7725f92e1959 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -48,6 +48,7 @@ bool sev_snp_enabled(void);
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
+#define SVM_SEV_FEAT_SECURE_TSC     BIT(9)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4532b1b6a484..518f0eb91aa1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3193,6 +3193,16 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     memcpy(finish->host_data, blob, len);
 }
 
+static bool sev_snp_guest_get_secure_tsc(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC);
+}
+
+static void sev_snp_guest_set_secure_tsc(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC, value);
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3228,6 +3238,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_bool(oc, "secure-tsc",
+                                  sev_snp_guest_get_secure_tsc,
+                                  sev_snp_guest_set_secure_tsc);
 }
 
 static void
diff --git a/qapi/qom.json b/qapi/qom.json
index e2bb716b603e..9c2966b68e8f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1113,6 +1113,9 @@
 #     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
+# @secure-tsc: enable Secure TSC
+#     (default: false) (since 11.1)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1124,7 +1127,8 @@
             '*id-auth': 'str',
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
-            '*vcek-disabled': 'bool' } }
+            '*vcek-disabled': 'bool',
+            '*secure-tsc': 'bool' } }
 
 ##
 # @TdxGuestProperties:
-- 
2.54.0


