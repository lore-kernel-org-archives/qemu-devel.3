Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCACC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bif-0006qO-P6; Mon, 07 Sep 2026 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bib-0006pV-Aw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3biY-0000uV-Vv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
 b=dq/xFhbmg1PRW2BAJyNnlRX41zpdq+PaNPj0lcwWAG/u9WL0gLk568nlApyheNHVbNodck
 4l58U+f9ppT+OOB8b3yMYHjO10A9LpYjnJRVIPLJLHUDEVuMA+u6Mg0rXsJfH6zr3kvkBO
 5hoGfhHdVyL5sUnIUAoNj2EYp3mQVe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-VvzushzmN8WP_sn-38KPsg-1; Mon, 07 Sep 2026 11:57:06 -0400
X-MC-Unique: VvzushzmN8WP_sn-38KPsg-1
X-Mimecast-MFC-AGG-ID: VvzushzmN8WP_sn-38KPsg_1788796626
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so54170885e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796626; x=1789401426; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
 b=WGw9RT0blK75kDYyd76X3UoSaRT1Zf0xvcQURGIedCBrH/6rpJGTUf+OWa8i0NJ665
 0Pq8lIvWKKIy4xPKJhUSjZwcgLR7R/Hx6ONurAJ5JQtPMPQjniYpfVyrNrtbvBFofxf7
 nqCrk4ne9Btb8KoyVQVwQJwJfBJcUIygrUPpb9P6gL4wUwavagRAnEUxaCh8SpxFJkBz
 dIERUd3nBK+gmrzW4qYMcCTh6Umi+tTa3Xd3aA2FEuDAegm2IJNouD54bJg1uHuuaNn+
 PEaisYCRJO9rp3//j4M2FvkR7T286tmWvxF/TybX71TU1cxq3jVOKZjWnvvvob0yXB9m
 BKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796626; x=1789401426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UtTVcX+HkxAOGfacRObZuM9p/FF3OrW8RisRppHIXLs=;
 b=sPq+jEWgMWFXLf55d45r64mrBrKqbgyEWQzpqxzLWswkjeZtslIcPn56R/BbxX2emO
 RsZjqYCO4nF9zY1qEllUKOMxd6m+HsumU2owh+JLweaaTegHGOxcWIpTthLkCGW6eptu
 rir+CMOi5IbchubtFsWf9UxLEMsNa5oDXQMpAmIgpUjQzO7xmdn3oZMnxB1p9aRsTd0x
 8HSZFklwkRg/Yy1draj/8Szl7VK35r3BUg9m5qegmcEbC0qSd0GOR7GzLFr/hWDy1b3E
 uHOxbcoyteJM/2rq171bLY6ouG2UuCblfT/gG5ydC10pfQCvAqL3eIhH/71uoFbFtg/0
 NuOA==
X-Gm-Message-State: AFuF++l+LLQsnkwMZtjts4JWRjy3XL7Mr0T3WkTfUhc3zP6Uv4eNBmZM
 tlWU2mwEZqRVMRWEZRlaJJ4fUkVJTJXXe4WacI0anouXsiGBsxVNaEsDIi/pInsQ9xaR09I6t3z
 lOHjcB+i4H9bLVnuIr+7VyFGOrdV4Tmb0rEd9KEDy9foIx9e0Y4QTDgPGTVGPiGr7kprVa4nP0W
 gZ5Sm9bCVaFkwXvIT/GWusyR3PIn8N079qwb033aUyl8o=
X-Gm-Gg: AYBFou1Y+I9/tv83u896eD8WbooXObsEDp0e7FAkjFJ8O8bVfuPez9AHly1X+FsOwGY
 0YDs1KdZSSwBFvW5U/UtocOAV5H4z6X8mZpM4LmJUHVg/61MknvW3RO4KgQiQcynom9GDgul0IO
 L1ZojpCAiCdoillbJaB4PZe8M3QLz4lLEwEXBtoop1YKnvs61AeO02gtvFjdY2n6tbtyI+Qn8O9
 nipl8LZQmi4kUTHCZCX4JB3o4duJp6TEcn7ryOHhoPU99Cr3QPiue58rkYymhdCWX/GRvizY9H7
 01CVsbUpRCzZJEdrOnfMlfdg4St4v/sljTbxwJsWIfDTyQmhfZ7klWKcEkeSsd3HIzImfAXRNNL
 TG1aRKk7g3YSt8RoO1nTgMiqJ6BOQ7FAui8goWlanLyOa1opvAjlXSUx3ye+nXYXuq6s5
X-Received: by 2002:a05:600c:4fc9:b0:49c:fc6e:8cb9 with SMTP id
 5b1f17b1804b1-49cfc6e8e1emr206321785e9.29.1788796625666; 
 Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:49c:fc6e:8cb9 with SMTP id
 5b1f17b1804b1-49cfc6e8e1emr206321185e9.29.1788796625161; 
 Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:57 +0200
Subject: [PATCH v2 1/5] sev: split set_guest_policy into set_guest_policy
 and set_id_block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-1-c8c50f1dbfda@redhat.com>
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
---
 backends/confidential-guest-support.c       |  15 ++-
 backends/igvm.c                             |  14 ++-
 include/system/confidential-guest-support.h |  28 +++---
 target/i386/sev.c                           | 140 +++++++++++++++-------------
 4 files changed, 111 insertions(+), 86 deletions(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..d60d1f6eaa 100644
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
index 7b7bdc72b7..99304d6467 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -963,14 +963,22 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
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
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 5dca717308..6d35ddb97a 100644
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
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b071..b53d13e2fa 100644
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
+        sev_snp_guest->kvm_start_conf.policy = policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
 
-            finish->id_block_uaddr =
-                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
-            finish->id_auth_uaddr =
-                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
 
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
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_snp_guest->kvm_start_conf.policy = policy;
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
+            return -1;
         }
-    } else {
-        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
-        /* Only the policy flags are supported for SEV and SEV-ES */
-        if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
-            error_setg(errp, "SEV: An ID block/ID auth block has been provided "
-                             "but SEV-SNP is not enabled");
+        if (id_auth_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
+            error_setg(errp,
+                       "SEV: Invalid SEV-SNP ID auth block: incorrect size");
             return -1;
         }
+        assert(id_block != NULL);
+        assert(id_auth != NULL);
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_guest->policy = policy;
-        }
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
2.55.0


