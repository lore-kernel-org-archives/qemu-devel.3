Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611B606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ca0okcYd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFJ-0007Ux-1W; Wed, 21 Oct 2026 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFC-0007TD-Ro
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZF9-0006UE-Lz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbURt7v9JUeQGhBp2lGuz+nQCWNIMP9K6cbbgKupvA4=;
 b=Ca0okcYdrq82Auk3jPo/GbMk2HBfVgTkHOAz0nr+apnLVKfY8esZmM3OZuX3b4F0P23EJv
 3YRFsQKSX0YJZjqVNTEd9ngbdwuy/+dF446pj76xHCci5AH20IaBXf3nLA8f3VnJtPWLT3
 1EYHYxfNcnRYi5wDDOAPBjou0LUdkAI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-iVK0IVqhNwmpeBzbgj2NFA-1; Wed,
 21 Oct 2026 16:32:42 +0000
X-MC-Unique: iVK0IVqhNwmpeBzbgj2NFA-1
X-Mimecast-MFC-AGG-ID: iVK0IVqhNwmpeBzbgj2NFA_1792600361
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 845BF195607F; Wed, 21 Oct 2026 16:32:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94E021956087; Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5808A182758E; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
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
Subject: [PULL 01/10] sev: split set_guest_policy into set_guest_policy and
 set_id_block
Date: Wed, 21 Oct 2026 18:32:29 +0200
Message-ID: <20261021163239.1131460-2-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The set_guest_policy callback on ConfidentialGuestSupportClass mixed
two unrelated jobs: writing the guest policy bits and providing the
SEV-SNP ID block/ID auth for LAUNCH_FINISH. The two are only related
because both come from the same 'policy' section of the SEV/SEV-SNP
launch flow, but they need to be set at different times: the policy
must be in effect before LAUNCH_START, while the ID block is only
needed before LAUNCH_FINISH.

Split the combined callback into set_guest_policy(policy_type, policy,
errp) and set_id_block(id_block, id_block_size, id_auth, id_auth_size,
errp), keeping both call sites exactly where the combined callback used
to be called from. No functional change.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-1-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/confidential-guest-support.h |  28 ++--
 backends/confidential-guest-support.c       |  15 +-
 backends/igvm.c                             |  14 +-
 target/i386/sev.c                           | 144 +++++++++++---------
 4 files changed, 113 insertions(+), 88 deletions(-)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 5dca71730880..6d35ddb97a75 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
                            uint16_t cpu_index, Error **errp);
 
     /*
-     * Set the guest policy. The policy can be used to configure the
-     * confidential platform, such as if debug is enabled or not and can contain
-     * information about expected launch measurements, signed verification of
-     * guest configuration and other platform data.
-     *
-     * The format of the policy data is specific to each platform. For example,
-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
-     * ID block and ID authentication in the 'policy_data' parameters. The type
-     * of policy data is identified by the 'policy_type' argument.
+     * Set the guest policy for the confidential platform. The policy
+     * configures properties of the guest, such as whether debug is
+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
+     * so the policy is in effect for launch.
      */
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp);
+                            uint64_t policy, Error **errp);
+
+    /*
+     * Set the SEV-SNP ID block and ID authentication block. These are
+     * passed to SNP_LAUNCH_FINISH to provide signed verification of the
+     * guest configuration.
+     */
+    int (*set_id_block)(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp);
 
     /*
      * Iterate the system memory map, getting the entry with the given index
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e6677..d60d1f6eaaea 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -39,16 +39,22 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
 }
 
 static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp)
+                            uint64_t policy, Error **errp)
 {
     error_setg(errp,
                "Setting confidential guest policy is not supported for this platform");
     return -1;
 }
 
+static int set_id_block(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp)
+{
+    error_setg(errp,
+               "Setting ID block is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -65,6 +71,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 58f3097e8518..1aa6803cfa25 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1006,14 +1006,22 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
     if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
         int id_block_len = 0;
         int id_auth_len = 0;
+        int retval;
+
         if (ctx->id_block) {
             ctx->id_block->policy = ctx->sev_policy;
             id_block_len = sizeof(struct sev_id_block);
             id_auth_len = sizeof(struct sev_id_authentication);
         }
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                          ctx->id_block, id_block_len,
-                                          ctx->id_auth, id_auth_len, errp);
+
+        retval = ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                             errp);
+        if (retval < 0) {
+            return retval;
+        }
+
+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
+                                       ctx->id_auth, id_auth_len, errp);
     }
     return 0;
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b07123..b53d13e2fa28 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2726,9 +2726,7 @@ static int cgs_get_mem_map_entry(int index,
 }
 
 static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                                uint64_t policy, void *policy_data1,
-                                uint32_t policy_data1_size, void *policy_data2,
-                                uint32_t policy_data2_size, Error **errp)
+                                uint64_t policy, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (sev_common->state == SEV_STATE_UNINIT) {
@@ -2741,81 +2739,90 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                    policy_type);
         return -1;
     }
-    /*
-     * SEV-SNP handles policy differently. The policy flags are defined in
-     * kvm_start_conf.policy and an ID block and ID auth can be provided.
-     */
+
+    /* do not reset existing policy if policy was not set in IGVM  */
+    if (policy == 0) {
+        return 0;
+    }
+
     if (sev_snp_enabled()) {
         SevSnpGuestState *sev_snp_guest =
             SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
-        struct kvm_sev_snp_launch_finish *finish =
-            &sev_snp_guest->kvm_finish_conf;
 
-        /*
-         * The policy consists of flags in 'policy' and optionally an ID block
-         * and ID auth in policy_data1 and policy_data2 respectively. The ID
-         * block and auth are optional so clear any previous ID block and auth
-         * and set them if provided, but always set the policy flags.
-         */
-        g_free(sev_snp_guest->id_block);
-        g_free((guchar *)finish->id_block_uaddr);
-        g_free(sev_snp_guest->id_auth);
-        g_free((guchar *)finish->id_auth_uaddr);
-        sev_snp_guest->id_block = NULL;
-        finish->id_block_uaddr = 0;
-        sev_snp_guest->id_auth = NULL;
-        finish->id_auth_uaddr = 0;
-
-        if (policy_data1_size > 0) {
-            struct sev_snp_id_authentication *id_auth =
-                (struct sev_snp_id_authentication *)policy_data2;
-
-            if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-                error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
-                return -1;
-            }
-            if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
-                error_setg(errp,
-                           "SEV: Invalid SEV-SNP ID auth block: incorrect size");
-                return -1;
-            }
-            assert(policy_data1 != NULL);
-            assert(policy_data2 != NULL);
-
-            finish->id_block_uaddr =
-                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
-            finish->id_auth_uaddr =
-                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
-
-            /*
-             * Check if an author key has been provided and use that to flag
-             * whether the author key is enabled. The first of the author key
-             * must be non-zero to indicate the key type, which will currently
-             * always be 2.
-             */
-            sev_snp_guest->kvm_finish_conf.auth_key_en =
-                id_auth->author_key[0] ? 1 : 0;
-            finish->id_block_en = 1;
-        }
-
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_snp_guest->kvm_start_conf.policy = policy;
-        }
+        sev_snp_guest->kvm_start_conf.policy = policy;
     } else {
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
-        /* Only the policy flags are supported for SEV and SEV-ES */
-        if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
-            error_setg(errp, "SEV: An ID block/ID auth block has been provided "
-                             "but SEV-SNP is not enabled");
+
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
+
+static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
+                            void *id_auth, uint32_t id_auth_size,
+                            Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 0;
+    }
+
+    if (!sev_snp_enabled()) {
+        error_setg(errp, "SEV: ID block is only supported for SEV-SNP");
+        return -1;
+    }
+
+    SevSnpGuestState *sev_snp_guest =
+        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    struct kvm_sev_snp_launch_finish *finish =
+        &sev_snp_guest->kvm_finish_conf;
+
+    /*
+     * Drop any ID block and ID auth from a previous pass before repopulating
+     * them, then set them only if an ID block was provided.
+     */
+    g_free(sev_snp_guest->id_block);
+    g_free((guchar *)finish->id_block_uaddr);
+    g_free(sev_snp_guest->id_auth);
+    g_free((guchar *)finish->id_auth_uaddr);
+    sev_snp_guest->id_block = NULL;
+    finish->id_block_uaddr = 0;
+    sev_snp_guest->id_auth = NULL;
+    finish->id_auth_uaddr = 0;
+
+    if (id_block_size > 0) {
+        struct sev_snp_id_authentication *auth =
+            (struct sev_snp_id_authentication *)id_auth;
+
+        if (id_block_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
+            error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
             return -1;
         }
-
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_guest->policy = policy;
+        if (id_auth_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
+            error_setg(errp,
+                       "SEV: Invalid SEV-SNP ID auth block: incorrect size");
+            return -1;
         }
+        assert(id_block != NULL);
+        assert(id_auth != NULL);
+
+        finish->id_block_uaddr =
+            (__u64)g_memdup2(id_block, KVM_SEV_SNP_ID_BLOCK_SIZE);
+        finish->id_auth_uaddr =
+            (__u64)g_memdup2(id_auth, KVM_SEV_SNP_ID_AUTH_SIZE);
+
+        /*
+         * Check if an author key has been provided and use that to flag
+         * whether the author key is enabled. The first of the author key
+         * must be non-zero to indicate the key type, which will currently
+         * always be 2.
+         */
+        sev_snp_guest->kvm_finish_conf.auth_key_en =
+            auth->author_key[0] ? 1 : 0;
+        finish->id_block_en = 1;
     }
+
     return 0;
 }
 
@@ -2881,6 +2888,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);
-- 
2.56.0


