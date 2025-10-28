Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91945CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhCW-0007AA-7g; Tue, 28 Oct 2025 06:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCV-00079t-6t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:15 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCS-0005UL-Q8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DA4F61F04;
 Tue, 28 Oct 2025 10:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C70C4CEE7;
 Tue, 28 Oct 2025 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761648309;
 bh=PlncIndr7i+Vu3ghe2WzLIyZcXUvCuWC5Vg8QrGPzAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ks7YblDqXF3wB86qL0V7gIeTgC/CXwoj5GlZ0wxiisqHvys+14QgNAsHT7q+y7eR9
 ycbmjQJ9urcAwqiv5RykAUVGHUlGpfO0Gt843Og1GUqByuhKQo8VYmIx6dLI/J+uMC
 2Ogs7vOwaO7kmMiYYiE5Lu9UWu/WKJEjN0RnGMFP7iqE47YA7dnvcmCjgPQ4r2/eQV
 dtNUpu+ChVKL4Z9C992En4lSKgl/algn/dCJD9gfACt+fAUAMn7QKneVVjM7K4tqp2
 nJ/FEghdHfOMNv4XrVSapPRtHnvsD0GVrWKf+qI1DqFFfh8ZlPamMXoS/qPLnSgnUN
 9zt29BoR+gEwg==
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
Subject: [PATCH v3 3/9] target/i386: SEV: Consolidate SEV feature validation
 to common init path
Date: Tue, 28 Oct 2025 16:13:28 +0530
Message-ID: <4bd665e05d26b441f04dabca9c8145d1cdefbc4a.1761648149.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761648149.git.naveen@kernel.org>
References: <cover.1761648149.git.naveen@kernel.org>
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

Currently, check_sev_features() is called in multiple places when
processing IGVM files: both when processing the initial VMSA SEV
features from IGVM, as well as when validating the full contents of the
VMSA. Move this to a single point in sev_common_kvm_init() to simplify
the flow, as well as to re-use this function when VMSA SEV features are
being set without using IGVM files.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7cfd15238703..89cde2c6464a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -595,9 +595,6 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
     vmsa_check.x87_fcw = 0;
     vmsa_check.mxcsr = 0;
 
-    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
-        return -1;
-    }
     vmsa_check.sev_features = 0;
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
@@ -1918,6 +1915,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
             }
         }
 
+        if (check_sev_features(sev_common, sev_common->sev_features, errp) < 0) {
+            return -1;
+        }
+
         /*
          * KVM maintains a bitmask of allowed sev_features. This does not
          * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
@@ -2537,9 +2538,6 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                            __func__);
                 return -1;
             }
-            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
-                return -1;
-            }
             sev_common->sev_features = sa->sev_features;
         }
         return 0;
-- 
2.51.0


