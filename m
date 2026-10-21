Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF4606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gg9hVCN0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFM-0007Vl-K2; Wed, 21 Oct 2026 12:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFF-0007TT-Gz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFB-0006UZ-Jm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo9A88zTUtWCxiYeFyiKtbxLLu+CYvfULiG4sQRriTU=;
 b=Gg9hVCN0gXx1coF/uY1M+njtjY6HNsj76hoisGxrlQfzadUOSno+fJkypb+gvw0cuVMaUG
 SKq6vS0QsNSsP+poPYfAUTWUGlL0kN+E6DtznmlWzKoYJZO0jC2nT+mYQNpFIv67/3jFO0
 LGXiWye8YGVecXOMQ3FoBe/48m+et4Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-vDBKqBqAP3i7Vvm3pvuLVg-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: vDBKqBqAP3i7Vvm3pvuLVg-1
X-Mimecast-MFC-AGG-ID: vDBKqBqAP3i7Vvm3pvuLVg_1792600364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01EA31956089; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 821087D5; Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C3FCF1827592; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 04/10] i386/sev: add a get_guest_policy callback
Date: Wed, 21 Oct 2026 18:32:32 +0200
Message-ID: <20261021163239.1131460-5-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Leonardi <leonardi@redhat.com>

The next patch populates the SEV-SNP ID block's policy field.
That value must be whatever policy is currently in effect on the platform
but there is no way to read it back: the policy can come either from an
IGVM GUEST_POLICY header or from the command line, and the command line
sets it directly into the SEV/SNP guest struct without going through IGVM.
Reading it back from the platform is the only source that always reflects
the value in effect, regardless of where it came from.

Add a get_guest_policy callback to ConfidentialGuestSupportClass for
this purpose. It is not yet used; the following patch wires it into the
SNP ID block population.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-4-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/confidential-guest-support.h |  8 +++++++
 backends/confidential-guest-support.c       |  9 ++++++++
 target/i386/sev.c                           | 24 +++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 6d35ddb97a75..27ae0a21b6ad 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -137,6 +137,14 @@ typedef struct ConfidentialGuestSupportClass {
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
                             uint64_t policy, Error **errp);
 
+    /*
+     * Get the guest policy currently configured for the confidential
+     * platform, be it from the command line or from a previous call to
+     * set_guest_policy. Its format is the same as for set_guest_policy.
+     */
+    int (*get_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp);
+
     /*
      * Set the SEV-SNP ID block and ID authentication block. These are
      * passed to SNP_LAUNCH_FINISH to provide signed verification of the
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index d60d1f6eaaea..91701f1a5f5b 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -46,6 +46,14 @@ static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return -1;
 }
 
+static int get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp)
+{
+    error_setg(errp,
+               "Getting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -71,6 +79,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->get_guest_policy = get_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 38f97fd9b2b3..f11fdb6590ef 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2758,6 +2758,29 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static int cgs_get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t *policy, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
+        return -1;
+    }
+
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        *policy = sev_snp_guest->kvm_start_conf.policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        *policy = sev_guest->policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2888,6 +2911,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->get_guest_policy = cgs_get_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
-- 
2.56.0


