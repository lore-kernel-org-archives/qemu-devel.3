Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E0CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBuq-0007Cf-2L; Thu, 18 Sep 2025 06:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBun-0007CF-8P
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:31:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuk-0001Ow-MN
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:31:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7662360209;
 Thu, 18 Sep 2025 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDF1C4CEF7;
 Thu, 18 Sep 2025 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758191455;
 bh=voC3RuuXy69NPBRMGb0xMv9euf2H4XXFvE+T4oED/WE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gG+PfqBGv1j+jb6yRHWZoN+/mWb3whrz8kOQhHomYHkQRjhNdA6XdplcZtrmgzz7H
 I3+gKLwLGAFhedLUHgwtEYsv6t4ucrUFWkBUnNUelWJPGdzB6+dKhndAEvxj27zSx/
 Q4kZumUi1TibWJFKApMlYxMVzojd4RDk0ZIpEQoiVfJZOJH2dePB+lNHkAztLvVqx8
 wKuUwQzP+wp2PTFXIpAZS6uygfRzJzz5BwyA++/LGQUiBi20jpKqs1kXEbNOwEvKwv
 Ln6d0rT2jJquixFKCDdN9yB7OzA09n3ZdzwcRCONouJCI3IkiXK5pyNMLyGa9s6wD+
 iRCho0JkFUmKg==
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
Subject: [PATCH 1/8] target/i386: SEV: Generalize handling of
 SVM_SEV_FEAT_SNP_ACTIVE
Date: Thu, 18 Sep 2025 15:56:59 +0530
Message-ID: <d7473c88d4f2cfefd9249eb414a28806494c4e5e.1758189463.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758189463.git.naveen@kernel.org>
References: <cover.1758189463.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
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

Align with IGVM files providing sev features with
SVM_SEV_FEAT_SNP_ACTIVE set by setting the same when creating a
sev-snp-guest object.

Since KVM sets this feature itself, SVM_SEV_FEAT_SNP_ACTIVE is unset
before KVM_SEV_INIT2 ioctl is invoked. Move that out of IGVM-specific
section to common code.

While at it, convert the existing SVM_SEV_FEAT_SNP_ACTIVE definition to
use the BIT() macro for consistency with upcoming feature flags.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.h |  2 +-
 target/i386/sev.c | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6bb..102546b112d6 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -44,7 +44,7 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
-#define SVM_SEV_FEAT_SNP_ACTIVE 1
+#define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1057b8ab2c60..2fb1268ed788 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -319,6 +319,15 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
     sev_common->state = new_state;
 }
 
+static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool set)
+{
+    if (set) {
+        sev_common->sev_features |= feature;
+    } else {
+        sev_common->sev_features &= ~feature;
+    }
+}
+
 static void
 sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
                     size_t max_size)
@@ -1897,15 +1906,15 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                 -1) {
                 return -1;
             }
-            /*
-             * KVM maintains a bitmask of allowed sev_features. This does not
-             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
-             * itself. Therefore we need to clear this flag.
-             */
-            args.vmsa_features = sev_common->sev_features &
-                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
         }
 
+        /*
+         * KVM maintains a bitmask of allowed sev_features. This does not
+         * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
+         * itself. Therefore we need to clear this flag.
+         */
+        args.vmsa_features = sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE;
+
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
     }
@@ -3127,6 +3136,7 @@ sev_snp_guest_instance_init(Object *obj)
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
+    sev_set_feature(SEV_COMMON(sev_snp_guest), SVM_SEV_FEAT_SNP_ACTIVE, true);
 }
 
 /* guest info specific to sev-snp */
-- 
2.51.0


