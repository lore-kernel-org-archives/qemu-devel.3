Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A5FC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bii-0006qt-SO; Mon, 07 Sep 2026 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bid-0006qE-GV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bib-0000v6-Dy
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
 b=Hq7OvWiqusThkDC+G1yOuDZOXWPx5kMio3YDiFctc3LZUpIMxaxBcVv3BrFo7cZzahcOk/
 c3bxK2qvPiYUxUbw0f9vXyKtEfAY5O5IUUlK9g6wJ+oPnUBRjFsR2fg8NjO5ZxLVQKk9HJ
 BzjpLizgi8ZtdsBe575WtBB6WE4rbIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-aTis1ks3OAC2Jf-ni7VoiQ-1; Mon, 07 Sep 2026 11:57:11 -0400
X-MC-Unique: aTis1ks3OAC2Jf-ni7VoiQ-1
X-Mimecast-MFC-AGG-ID: aTis1ks3OAC2Jf-ni7VoiQ_1788796630
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso27378245e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796630; x=1789401430; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
 b=iY7YFGyiecXgoU1eFfx4gtZQLTc7FjPA60/YBk1jy9w6AERUOm97Rq/eNVKITuPAtY
 yMPA+3KBsCgUF5VWgfUPI/4QMkPUW7f33suxTreYFwhNWPHSMwWTuxIpsb6CcEJi5NZf
 heVF45tza89pHG9jb/0EZwPPvkPpWN8KpM0HkOBij6invoqsMlx1Cu/n0KYMJTmav+lF
 CKiVD28oTEV4FOcRM5RnQPxfi3rPkuJoNcM3INW2f9cknI4lCBj724fivo/YxqiFuv3N
 SrsxLO7xM/V9ji5qIQYb7uYqLekaPpuUfF4330qy190X5beCi7FUyfyVO4aveDWYNVFI
 W9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796630; x=1789401430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fQaiA+qhLoVzKtGnL0lSxJUvzGHQNtKK5icFkRaD4Dg=;
 b=GDnr/KB964e5ndDrZPJ15NO1r/vxixp/6Q50HIO79Kn7st6xt25RovkK3D1/mGDJSm
 Zqb67CX46cZ9cFTBN40pUNOgZdG9Vwti03UTTXmGZieciEp0/2XzEpyf0x64kqW8VnJG
 r++OLTcFAZsuTWFDbePHrTasg6CehK2n8YWMhxAu1NoJH4fuRLtrdOZs0z1H0xhGAWa/
 tRtsLr9ePU87/sAIQgmVeHyEX1a/OMsR1Z27a78eE1z4SJRgPnayZKnmdD+eg5cZQL4f
 6m1qB39/utAR1bAu5uKRmWQKepwesvAgnP3K36wIyvD0QMQZB08isVS9WzAZQ5P6tZzD
 fkNA==
X-Gm-Message-State: AFuF++nEtsqRXmHpGIKD5D8yr3XjNoYRvfvNoc6nDwLMdfUFVn/ru4KY
 c76+GS9lITN10Z3pWNHPy/oegB4Goc0Eljhs0Alhq3+teYHWy6JAFwu19DXFXLdMQ1w6nDmUFFr
 CDas52f7ExYWBO9JjUOpbjsGH3FNLckvSabL6IKbWsRnIns93rjVJo81X6oT8ZOFsQbYfzjy1Tj
 4naB3xYh78UxyD/VzKsQHOrhgz1wb7mIXwTPQ8ZZJG3Dw=
X-Gm-Gg: AYBFou3tJiV4uG0s/f3dQBfJT6CPYFApLjR26EQxx+21nJNChfu0Bm/cpoa4uYi2WvF
 mBtmifedrX+sg8NFrSDS/7gP44364JNdkxIzfXFFaCjc/p1Fe61+XNnThyTjV7EiXUsz5bryjd7
 K5tLQjV7nP6XqVNUqNaW4R/CL0WYyGa6V2WMRNnOsFZ0JeFvozosfExC1tccYpxAkaEugAnq1O/
 1j3ML5YaSyR+2gfvpfD4hvbt4yokRg7h84SwnsD9dSgywajGpfiwBhjUeYGxFbF2Kgi5+xdLKTp
 vQ2TVayeeADAcSYljN9e3Rs1Axv5Pe7Qwv2DhJwAf0jwiUB5a1b6mHv+Dme8u66JdYDDM8jl1ig
 iVbITO5IAbJ2CrNw5YRmocabzHxynYSnhU4qpfnMnG1Zyg4Fc6husB+IYMPP+uzUXu21z
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be04 with SMTP id
 5b1f17b1804b1-49cfc6cc091mr196552065e9.27.1788796630337; 
 Mon, 07 Sep 2026 08:57:10 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be04 with SMTP id
 5b1f17b1804b1-49cfc6cc091mr196551635e9.27.1788796629803; 
 Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:57:01 +0200
Subject: [PATCH v2 5/5] igvm/sev: forward the IGVM guest policy to the
 platform before launch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-5-c8c50f1dbfda@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 backends/igvm.c                | 27 +++++++++++----------------
 include/system/igvm-internal.h |  3 ---
 target/i386/sev.c              | 37 +++++++++++++++++++++++++------------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 521560822a..5360a2575b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -778,8 +778,6 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
-    ctx->id_block->policy = ctx->sev_policy;
-
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -808,6 +806,13 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
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
@@ -867,7 +872,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
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
@@ -968,15 +976,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
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
@@ -1102,10 +1101,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..041f77586a 100644
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
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f11fdb6590..11072b00dc 100644
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
2.55.0


