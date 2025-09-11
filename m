Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BACAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfw4-0002Ij-3K; Thu, 11 Sep 2025 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfvy-0002IL-Os
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:57:50 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfvq-0006Jl-Vx
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:57:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B2F5A40A3A;
 Thu, 11 Sep 2025 11:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866E3C4CEF0;
 Thu, 11 Sep 2025 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757591858;
 bh=I3D/RCo9dBe/+uHLQzw9ngK0cT2br+oK6Tf6IcL4Lms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NFpBqLtgJlxOnPhGzDOUqGCLkqjzdF6Ato/12zvO+VzqgyIrbSdMidqC7cmDLXviO
 lxq7c0wPB/zqeVTgZWwGdidDtDIlHZt37KzgBOSwt67Dh6y/EWD5NfYpowosOxU3vL
 B2rVGJ5iCG+G7jZ1WITzuqe5gnWcJ7d7e1eMcjMYXM1wi9aiy5bWPc0hf8/gbQfELm
 PO6FFRprnLiUFJ+W3LlkhxuhzDTIE8z7LLLyYSL1FjMFxdTXMcC1zayY1WR7e1FnLW
 uyppU8UfpVsZRu7SynRp5cnwmMr9NUmzJTXxBHDAP1fyNHDF0x1zjzxzrbBBuFUtZt
 stDkUWXgevvlQ==
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
Subject: [RFC PATCH 3/7] target/i386: SEV: Add support for enabling debug-swap
 SEV feature
Date: Thu, 11 Sep 2025 17:24:22 +0530
Message-ID: <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757589490.git.naveen@kernel.org>
References: <cover.1757589490.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
objects. Though the boolean property is available for plain SEV guests,
check_sev_features() will reject setting this for plain SEV guests.

Add helpers for setting and querying the VMSA SEV features so that they
can be re-used for subsequent VMSA SEV features, and convert the
existing SVM_SEV_FEAT_SNP_ACTIVE definition to use the BIT() macro for
consistency with the new feature flag.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  3 ++-
 target/i386/sev.c | 29 +++++++++++++++++++++++++++++
 qapi/qom.json     |  6 +++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6bb..8e09b2ce1976 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -44,7 +44,8 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
-#define SVM_SEV_FEAT_SNP_ACTIVE 1
+#define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
+#define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fa23b5c38e9b..b3e4d0f2c1d5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -319,6 +319,20 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
     sev_common->state = new_state;
 }
 
+static bool is_sev_feature_set(SevCommonState *sev_common, uint64_t feature)
+{
+    return !!(sev_common->sev_features & feature);
+}
+
+static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool value)
+{
+    if (value) {
+        sev_common->sev_features |= feature;
+    } else {
+        sev_common->sev_features &= ~feature;
+    }
+}
+
 static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
                     size_t max_size)
@@ -2732,6 +2746,16 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
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
@@ -2749,6 +2773,11 @@ sev_common_class_init(ObjectClass *oc, const void *data)
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
index 830cb2ffe781..71cd8ad588b5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1010,13 +1010,17 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @debug-swap: enable virtualization of debug registers (default: false)
+#              (since 10.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' } }
+            '*kernel-hashes': 'bool',
+            '*debug-swap': 'bool' } }
 
 ##
 # @SevGuestProperties:
-- 
2.50.1


