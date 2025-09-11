Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C66CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfwG-0002Nh-HZ; Thu, 11 Sep 2025 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfwE-0002Mh-UF
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:58:06 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfwA-0006O2-CK
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:58:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D3FD41A00;
 Thu, 11 Sep 2025 11:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B73C4CEF0;
 Thu, 11 Sep 2025 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757591877;
 bh=7HOJXed/grVIwqxVnBC0UOQowTK5L/FCl7Cie6uBUm4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T1ntO9aEo82Qc78/YNeyI6LSQHMMSt10UyA//C2B2KcD0FLcWLj18okAIoyxhZ4LM
 sxbA1oBVssrhDk6VCVyEh/Q75omSlQw04GBqJzB9ZyLsXdeh8u3yLFaGo0ixvV+tW+
 k2uRaFFE0EIcOeGLjf3PT/NY8NyJBaZcFNfqeQjGBziSs217O57pipb+fZpjanrYFL
 MdJKEqA+FvP3sgqZKdnzSDuChWOP3DvsnY8ixHeRohuWXmc1J1M/S+8ccp9H3m738D
 rPNQ6KWdsAEcPSCcWKJRoxdDIPZxQWaICJ/aEFwvjPmy0qZHrB8CSfw1U3TWtTD6nk
 MDpIinpFepTIw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: [RFC PATCH 7/7] target/i386: SEV: Add support for enabling Secure
 AVIC SEV feature
Date: Thu, 11 Sep 2025 17:24:26 +0530
Message-ID: <632eaad0ef28943520a1285c8efb3d8a756e4624.1757589490.git.naveen@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757589490.git.naveen@kernel.org>
References: <cover.1757589490.git.naveen@kernel.org>
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

Add support for enabling Secure AVIC VMSA SEV feature in SEV-SNP guests
through a new "secure-avic" boolean property on SEV-SNP guest objects.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-avic=on

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  1 +
 target/i386/sev.c | 13 +++++++++++++
 qapi/qom.json     |  5 ++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 87e73034ad15..a374c144bccd 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -47,6 +47,7 @@ bool sev_snp_enabled(void);
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC     BIT(9)
+#define SVM_SEV_FEAT_SECURE_AVIC    BIT(16)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index facf51c810d9..f9170e21ca57 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3147,6 +3147,16 @@ static void sev_snp_guest_set_secure_tsc(Object *obj, bool value, Error **errp)
     sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC, value);
 }
 
+static bool sev_snp_guest_get_secure_avic(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_AVIC);
+}
+
+static void sev_snp_guest_set_secure_avic(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_AVIC, value);
+}
+
 static void
 sev_snp_guest_get_tsc_frequency(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
@@ -3210,6 +3220,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "tsc-frequency", "uint32",
                               sev_snp_guest_get_tsc_frequency,
                               sev_snp_guest_set_tsc_frequency, NULL, NULL);
+    object_class_property_add_bool(oc, "secure-avic",
+                                  sev_snp_guest_get_secure_avic,
+                                  sev_snp_guest_set_secure_avic);
 }
 
 static void
diff --git a/qapi/qom.json b/qapi/qom.json
index 5b99148cb790..5dce560a2f54 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1105,6 +1105,8 @@
 # @tsc-frequency: set secure TSC frequency. Only valid if Secure TSC
 #     is enabled (default: zero) (since 10.2)
 #
+# @secure-avic: enable Secure AVIC (default: false) (since 10.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1118,7 +1120,8 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
             '*secure-tsc': 'bool',
-            '*tsc-frequency': 'uint32' } }
+            '*tsc-frequency': 'uint32',
+            '*secure-avic': 'bool' } }
 
 ##
 # @TdxGuestProperties:
-- 
2.50.1


