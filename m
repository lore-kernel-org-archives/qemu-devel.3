Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2EECAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBuW-0006zP-LC; Thu, 18 Sep 2025 06:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuH-0006vs-Pu
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:40 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuE-0001LS-Do
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 495FE60207;
 Thu, 18 Sep 2025 10:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F2FC4CEF7;
 Thu, 18 Sep 2025 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758191423;
 bh=iInPTCFj8UCEpOkf584ztFBgNmedO/q1q8XQk2av7F0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=imMxmRMOFucVmbbnIljCOoD604kUGRxR+4MK5CZy9169s2vPHOhaFxj6UcmLNuhk0
 kj2BDLbHIUMoEkXMWPTRXj3D0kSpSWoKI0bj7e1cltPjUSdK2HLNAElEOka/iTzbEL
 bTM+fpCgOZZ1TtghcV8L/VQOKYTxm6aP4QOvzVti3Go4Ow8lDJl9E+lVw1Axq26pdE
 N7IFCNQVgdCpz9p2nB39W4qasnNKYDAgyvn6hgxjtOH5mFj70Z2vPlPwKxFEc8HRTd
 pRr3vFzWo8f9Nrb64QB25A8NccjnjoSDmQlurtZ6qcqe15VFlzdU1RFqiDKQCN4Hbe
 5SWgV/6JVI+rg==
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
Subject: [PATCH 3/8] target/i386: SEV: Consolidate SEV feature validation to
 common init path
Date: Thu, 18 Sep 2025 15:57:01 +0530
Message-ID: <eba12d94afd504ff87d25b9426a4a4e74c3a0c70.1758189463.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758189463.git.naveen@kernel.org>
References: <cover.1758189463.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=naveen@kernel.org;
 helo=tor.source.kernel.org
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

Currently, check_sev_features() is called in multiple places when
processing IGVM files: both when processing the initial VMSA SEV
features from IGVM, as well as when validating the full contents of the
VMSA. Move this to a single point in sev_common_kvm_init() to simplify
the flow, as well as to re-use this function when VMSA SEV features are
being set without using IGVM files.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c4011a6f2ef7..7c4cd1146b9a 100644
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
@@ -1913,6 +1910,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
             }
         }
 
+        if (check_sev_features(sev_common, sev_common->sev_features, errp) < 0) {
+            return -1;
+        }
+
         /*
          * KVM maintains a bitmask of allowed sev_features. This does not
          * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
@@ -2532,9 +2533,6 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
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


