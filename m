Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2043CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhDC-0007UE-Kd; Tue, 28 Oct 2025 06:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhD6-0007QG-Fs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:54 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhD2-0005cm-W3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:52 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F14A740195;
 Tue, 28 Oct 2025 10:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63D2C4CEE7;
 Tue, 28 Oct 2025 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761648346;
 bh=yuefX2bV8TgwobVJcRSeFhEprglnx9h+ky2Mj086e38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cCkhiyGz0MoyRDhWl+MLLVT6QY98/zwC5nDtvFVT49TJRugsGdco8vY9zFSl5L3qn
 qYWn5sl6+9suoieSiBLUj9QJIoT9MVDNRXYJ8CB71aXsYuKlKYYHNC4s2teiuo+ORZ
 GemR04/Jbw08yXsPacBrbrPk5mxzBiohypTO9LtkTrotusUWbCmoFd70PS7oEyjZw7
 5JDP/d6fgjjO7lWulNaqi09RhqgFnKpfafSenW7Dn6fwf1h8xH1RouuL8BIOg1iXYi
 8KhCIfxuuG1/TDR1aIqWtJHLaohLOgNuOSWdJXaETwrJ6yCuo6sr0g2U2phnWDwwbV
 /AyGid/25RYoQ==
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
Subject: [PATCH v3 7/9] target/i386: SEV: Add support for enabling Secure TSC
 SEV feature
Date: Tue, 28 Oct 2025 16:13:32 +0530
Message-ID: <d4ca5df3474b2c6a7969c0547fcbfe4d8a88b027.1761648149.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761648149.git.naveen@kernel.org>
References: <cover.1761648149.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 8e09b2ce1976..87e73034ad15 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -46,6 +46,7 @@ bool sev_snp_enabled(void);
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
+#define SVM_SEV_FEAT_SECURE_TSC     BIT(9)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2cea2661cc03..af8222b8ceb3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3122,6 +3122,16 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
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
@@ -3157,6 +3167,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_bool(oc, "secure-tsc",
+                                  sev_snp_guest_get_secure_tsc,
+                                  sev_snp_guest_set_secure_tsc);
 }
 
 static void
diff --git a/qapi/qom.json b/qapi/qom.json
index e89d11ce45ad..c7dd2dd1b095 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1101,6 +1101,9 @@
 #     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
+# @secure-tsc: enable Secure TSC
+#     (default: false) (since 10.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1112,7 +1115,8 @@
             '*id-auth': 'str',
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
-            '*vcek-disabled': 'bool' } }
+            '*vcek-disabled': 'bool',
+            '*secure-tsc': 'bool' } }
 
 ##
 # @TdxGuestProperties:
-- 
2.51.0


