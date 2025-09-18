Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B52CAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBue-000770-7l; Thu, 18 Sep 2025 06:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuc-000766-50
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:50 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuZ-0001OJ-TW
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B9A94178A;
 Thu, 18 Sep 2025 10:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D072C4CEEB;
 Thu, 18 Sep 2025 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758191446;
 bh=iuqycozjbpUF2qdpbTkjQOSZMXX5AoQ7UjWfDC2opOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VyVBFbVmmbTjyWjoWdPpAQA0t4ZSvJ5gQhvi56Ul8W7dQiaYySzOwEKrtMPfONGSq
 mltpdguC3ZhAA3xizkgvlozYtHaacUniNHbfEtpCJH38e6qyhGxEpuK0XMivubi17I
 uDnsM1f5txvoc+VgQ9z17XHgmQSax804NLg/ZzXGo7FHmz06QJQLF7O0n6RFAescXe
 qnTNNJ0g3G/xOMkpv7aLef4CDc/SdhBInv6NDo1+3iBtgvmzewNzEgGeU4b6huI8M3
 wVkZ+fkMIokWl1oAVDF6xh3McDMZUA73fZmtp89oUPstt2ib3TnL9EcI75ABMIyU2Q
 fvTUCRurSXk4g==
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
Subject: [PATCH 8/8] target/i386: SEV: Add support for setting TSC frequency
 for Secure TSC
Date: Thu, 18 Sep 2025 15:57:06 +0530
Message-ID: <6a9b3e02d1a1eb903bd3e7c9596dfe00029de01e.1758189463.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758189463.git.naveen@kernel.org>
References: <cover.1758189463.git.naveen@kernel.org>
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

Add support for configuring the TSC frequency when Secure TSC is enabled
in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
guest objects, similar to the vCPU-specific property used by regular
guests and TDX. A new property is needed since SEV-SNP guests require
the TSC frequency to be specified during early SNP_LAUNCH_START command
before any vCPUs are created.

The user-provided TSC frequency is set through KVM_SET_TSC_KHZ before
issuing KVM_SEV_SNP_LAUNCH_START.

Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/qom.json     |  6 +++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 679bedb63c3a..ef54265f4e46 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -178,6 +178,7 @@ struct SevSnpGuestState {
     char *id_auth_base64;
     uint8_t *id_auth;
     char *host_data;
+    uint32_t tsc_khz;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -536,6 +537,13 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                    __func__, sev_features, sev_common->supported_sev_features);
         return -1;
     }
+    if (sev_snp_enabled() && SEV_SNP_GUEST(sev_common)->tsc_khz &&
+        !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
+        error_setg(errp,
+                   "%s: TSC frequency can only be set if Secure TSC is enabled",
+                   __func__);
+        return -1;
+    }
     return 0;
 }
 
@@ -1085,6 +1093,18 @@ sev_snp_launch_start(SevCommonState *sev_common)
             return 1;
     }
 
+    if (is_sev_feature_set(sev_common, SVM_SEV_FEAT_SECURE_TSC)) {
+        rc = -EINVAL;
+        if (kvm_check_extension(kvm_state, KVM_CAP_VM_TSC_CONTROL)) {
+            rc = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, sev_snp_guest->tsc_khz);
+        }
+        if (rc < 0) {
+            error_report("%s: Unable to set Secure TSC frequency to %u kHz ret=%d",
+                         __func__, sev_snp_guest->tsc_khz, rc);
+            return 1;
+        }
+    }
+
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
@@ -3127,6 +3147,28 @@ static void sev_snp_guest_set_secure_tsc(Object *obj, bool value, Error **errp)
     sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC, value);
 }
 
+static void
+sev_snp_guest_get_tsc_frequency(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint32_t value = SEV_SNP_GUEST(obj)->tsc_khz * 1000;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3165,6 +3207,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "secure-tsc",
                                   sev_snp_guest_get_secure_tsc,
                                   sev_snp_guest_set_secure_tsc);
+    object_class_property_add(oc, "tsc-frequency", "uint32",
+                              sev_snp_guest_get_tsc_frequency,
+                              sev_snp_guest_set_tsc_frequency, NULL, NULL);
 }
 
 static void
diff --git a/qapi/qom.json b/qapi/qom.json
index 52c23e85e349..c01ae70dd43d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1103,6 +1103,9 @@
 # @secure-tsc: enable Secure TSC
 #     (default: false) (since 10.2)
 #
+# @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
+#     is enabled (default: zero) (since 10.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1115,7 +1118,8 @@
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
-            '*secure-tsc': 'bool' } }
+            '*secure-tsc': 'bool',
+            '*tsc-frequency': 'uint32' } }
 
 ##
 # @TdxGuestProperties:
-- 
2.51.0


