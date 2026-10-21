Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF7606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OkMG+ZMC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFg-0007bT-4g; Wed, 21 Oct 2026 12:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFG-0007Tb-KV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFB-0006UW-C9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mx3NJOt7EtEZ3D64HV5SqRuwJTZwQpbp8v/NGhoKJls=;
 b=OkMG+ZMCtPTWke65OZNleUUmaHfKg+LfPAVVXyS1cjVG45UUnpPxgCYBPDKodWp4dY+FZt
 QIN0MB3mUZswZVFaaGj+65lFZr3MxKNlBTShPHtVq5z2auxVHMHuijWZBfH1uubCOkN+MG
 KaTbd4NYMrSMkMeAxeRE1dDutVwZOnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-paQ6od0dMEOAiay9-J2iVQ-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: paQ6od0dMEOAiay9-J2iVQ-1
X-Mimecast-MFC-AGG-ID: paQ6od0dMEOAiay9-J2iVQ_1792600364
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0318F19560BC; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1BC618004D2; Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DF9C31827593; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
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
Subject: [PULL 05/10] igvm/sev: forward the IGVM guest policy to the platform
 before launch
Date: Wed, 21 Oct 2026 18:32:33 +0200
Message-ID: <20261021163239.1131460-6-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Leonardi <leonardi@redhat.com>

set_guest_policy was called from qigvm_handle_policy at the end of
qigvm_process_file, after LAUNCH_START had already been issued for both
SEV/SEV-ES and SEV-SNP. The guest was therefore launched with whatever
policy was already configured (the command-line value, or the platform
default if none was given) instead of the one requested by the IGVM
file, quietly breaking attestation since the policy is part of the
attestation report.

Move the call into qigvm_initialization_guest_policy, which runs while
the initialization section is processed. Because that section is now
handled during the pre-launch pass (see previous patch), the call
happens before LAUNCH_START, so the policy is in effect for launch. Drop
qigvm_handle_policy, whose only remaining job was that misplaced call.
cgs_set_guest_policy no longer special-cases SEV_STATE_UNINIT: that
guard used to skip the pre-processing pass so the policy was applied
later, but forwarding it during pre-processing, before LAUNCH_START, is
now precisely the point. The 'policy == 0 means unset' guard is dropped
too, since the call site now only fires when the IGVM file actually
provides a GUEST_POLICY header.

The command line can also set a policy. It now takes precedence: if it
differs from the IGVM one, print a warning and keep the command-line
value instead of silently overriding it. Also reject a policy that
doesn't fit in the 32-bit SEV/SEV-ES policy field instead of truncating
it.

Finally, use the get_guest_policy callback added by the previous patch
to populate the SNP ID block's policy field. The command line sets its
policy directly into the SEV/SNP guest's own struct, bypassing IGVM
entirely, so ctx->sev_policy only ever reflects a GUEST_POLICY header
and is 0 otherwise, causing SNP_LAUNCH_FINISH to reject the ID block
whenever the file relies on a command-line policy. Reading the policy
back from the platform instead always gets the value actually in
effect, regardless of its source. ctx->sev_policy is now unused and
removed.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-5-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  3 ---
 backends/igvm.c                | 27 ++++++++++---------------
 target/i386/sev.c              | 37 +++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b3b64cb58444..d88268bf602c 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -64,9 +64,6 @@ struct QIgvm {
     struct sev_id_block *id_block;
     struct sev_id_authentication *id_auth;
 
-    /* Define the guest policy for SEV guests */
-    uint64_t sev_policy;
-
     /* These variables keep track of contiguous page regions */
     IGVM_VHS_PAGE_DATA region_prev_page_data;
     uint64_t region_start;
diff --git a/backends/igvm.c b/backends/igvm.c
index 2ee60ada94b9..ef45794744bc 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -821,8 +821,6 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
-    ctx->id_block->policy = ctx->sev_policy;
-
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -851,6 +849,13 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
             72);
 
     if (ctx->cgsc) {
+        uint64_t policy;
+
+        if (ctx->cgsc->get_guest_policy(GUEST_POLICY_SEV, &policy, errp) < 0) {
+            return -1;
+        }
+        ctx->id_block->policy = policy;
+
         return ctx->cgsc->set_id_block(ctx->id_block,
                                        sizeof(struct sev_id_block),
                                        ctx->id_auth,
@@ -910,7 +915,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
         (const IGVM_VHS_GUEST_POLICY *)header_data;
 
     if (guest->compatibility_mask & ctx->compatibility_mask) {
-        ctx->sev_policy = guest->policy;
+        if (ctx->cgsc) {
+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
+                                               guest->policy, errp);
+        }
     }
     return 0;
 }
@@ -1011,15 +1019,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
-{
-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                           errp);
-    }
-    return 0;
-}
-
 IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -1145,10 +1144,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f11fdb6590ef..11072b00dce7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -128,6 +128,8 @@ struct SevCommonState {
     bool kernel_hashes;
     uint64_t sev_features;
     uint64_t supported_sev_features;
+    /* whether the guest policy was explicitly set on the command line */
+    bool policy_set;
 
     /* runtime state */
     uint8_t api_major;
@@ -2729,10 +2731,6 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                                 uint64_t policy, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    if (sev_common->state == SEV_STATE_UNINIT) {
-        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
-        return 0;
-    }
 
     if (policy_type != GUEST_POLICY_SEV) {
         error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
@@ -2740,18 +2738,31 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         return -1;
     }
 
-    /* do not reset existing policy if policy was not set in IGVM  */
-    if (policy == 0) {
-        return 0;
-    }
-
     if (sev_snp_enabled()) {
-        SevSnpGuestState *sev_snp_guest =
-            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        if (sev_common->policy_set &&
+            sev_snp_guest->kvm_start_conf.policy != policy) {
+            warn_report_once("SNP: policy mismatch between IGVM and CLI, "
+                             "keeping the command-line policy");
+            return 0;
+        }
 
         sev_snp_guest->kvm_start_conf.policy = policy;
     } else {
-        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        if (sev_common->policy_set && sev_guest->policy != policy) {
+            warn_report_once("SEV: policy mismatch between IGVM and CLI, "
+                             "keeping the command-line policy");
+            return 0;
+        }
+
+        if (policy > UINT32_MAX) {
+            error_setg(errp, "SEV: policy 0x%" PRIx64 " does not fit in the "
+                       "32-bit SEV/SEV-ES guest policy field", policy);
+            return -1;
+        }
 
         sev_guest->policy = policy;
     }
@@ -3034,6 +3045,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static void
@@ -3091,6 +3103,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                            errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static char *
-- 
2.56.0


