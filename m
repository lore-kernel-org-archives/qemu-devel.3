Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF502CAC5B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jDX-00023z-Kt; Thu, 25 Sep 2025 06:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jDS-00023K-On
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jDK-0002jN-Ac
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C3A5C604B8;
 Thu, 25 Sep 2025 10:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D2C4CEF0;
 Thu, 25 Sep 2025 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758796113;
 bh=66MPz/kZ5VYubvKvzrX3KPVZW96GhE0LtThIizkq+7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V+PoQa9vxi1puotgt9Xp4O7Y6Wf0qteXCbIlufLMLuvVp2RaqbvwVn/FQe327mToe
 wJKG5hTs0tqfBV4kzSWT3lKbD3yImpUSBE5XkQM/vGVZ9DXU+0YVF8CLXbfQmFK36R
 0KX7jMLTNhmQeaZ5eiPSsbVsSdBImT6hlaQAUIa9Ya/OIxIfZHYKDqjqVsxpXkW9zV
 LB968jyhKTdzGKb7XBI1MmCOdzoQUGenzwRM2gytiXeD93YKBiLQGZKO0pMmbPYTfZ
 ziJUMfSsMEuliDHBxJt4WSWSMo8wHco1gcuwlUA7BhUNIbxmYBPl0n89t9xUAsIcfa
 5COY1FaoXXepQ==
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
Subject: [PATCH v2 6/9] target/i386: SEV: Add support for enabling debug-swap
 SEV feature
Date: Thu, 25 Sep 2025 15:47:35 +0530
Message-ID: <4f0f28154342d562e76107dfd60ed3a02665fbfe.1758794556.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758794556.git.naveen@kernel.org>
References: <cover.1758794556.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
objects. Though the boolean property is available for plain SEV guests,
check_sev_features() will reject setting this for plain SEV guests.

Though this SEV feature is called "Debug virtualization" in the APM, KVM
calls this "debug swap" so use the same name for consistency.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  1 +
 target/i386/sev.c | 20 ++++++++++++++++++++
 qapi/qom.json     |  6 +++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 102546b112d6..8e09b2ce1976 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -45,6 +45,7 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_DBG      0x80000
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
+#define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 88dd0750d481..e9d84ea25571 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -319,6 +319,11 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
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
@@ -2744,6 +2749,16 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
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
@@ -2761,6 +2776,11 @@ sev_common_class_init(ObjectClass *oc, const void *data)
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
index 830cb2ffe781..df962d4a5215 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1010,13 +1010,17 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @debug-swap: enable virtualization of debug registers
+#     (default: false) (since 10.2)
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
2.51.0


