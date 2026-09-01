Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251FCC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LRA-0002c0-Nv; Tue, 01 Sep 2026 06:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LR9-0002Y4-3F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LR6-00010g-VK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
 b=ZbYLHzJm+buoh5FfVPqhKYFWTsT64qt9lQ7fUFtZT3yWEfz6cdxu6PYFfidxx9KQX67ilV
 647HongB6DOS8O/SjFUPZwsmVTtmZbZ/UuM4IWb0nvC+CVf3ifbbxmWM5KhpGU/pONvcC4
 k2Ip2GG28gXh5cZTRxny/QZoJQjBUSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-H1CbWuIgN_qbqQM9Tm8Tkg-1; Tue, 01 Sept 2026 06:09:32 -0400
X-MC-Unique: H1CbWuIgN_qbqQM9Tm8Tkg-1
X-Mimecast-MFC-AGG-ID: H1CbWuIgN_qbqQM9Tm8Tkg_1788257371
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso5684205e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257371; x=1788862171; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
 b=BJraqNIK4jPiOWCVpetbU0HejfplFhqpTe2+zgJNEolXTrv909a9u5ocVv+P1iwcpo
 O5xiBN0NaF7t1Db6B65NgtzKsUNFi1MkfaswfRLKz3XacluRN0l8e3mk+i87+JILD43r
 Fm6PAfbK47mzMkFxcC2813WgR9NDlBHzG2WabYkEJCjX4M4xtBY99RZE58Wo06U0yAeB
 1cXlfF4248qBQaiY2VYq6gsJt1grCtzevQmoV1HEEh2r63bIHLKjjOk3gpHvfXcVA1jk
 r7rVnRqnHLKiQfXUTpYXOHwDSENxu3AoIHzYDPLl6B8Z4KA6RnYXx/Tm6UrYfKh0m3Vd
 vTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257371; x=1788862171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kl+pYHx82Tu2z011P+lU27GwkRv+poRAFFh5UTR7T8c=;
 b=dJMWtqyhw+65HHbSh07vbS3XqaMl4mWveysjhwYZd/prwc3P5FSdP5UTip4Ft2vdUQ
 V6aYiiq3w+HWl0bwcA01QYSZQA68tG9wyJ9Kh4j6wPdCtpwOAM1nOsdP3Q0ljPcLO3Xm
 rJ84jLIpv5Z76EL7LE9orukclafMUIxXNVfGqZYtLF6HJ6hzo6cpZgDox6/GDOd8C7Iq
 lQ1HVDFHtsWMbUyoxt7aBuZmFYshbdEw49CjuQukoMUnV+V7RDBJNDPQ7t/ka9861b02
 LjApbhu71/F9KUzuNzux7VQJ//q/JT9RCH65a0PjY9x/jGZ3aRhb1xm8sNyHo3NCuC9u
 b90g==
X-Gm-Message-State: AFuF++m6uE/DbcnYLfGiuUXJ2likxKC58T9TRNSbmpY9bPLneS4Fn89J
 QNT8UXU1f9qXxwr0V5f4ZXYcelMBKRpBtyiV0VzqELkJpd+MrWvss/IiZFYpoq19Ft/p/+lHOLq
 0ZlSmLxBBliAT2rNsMGE8a8FArDgxnBhGoJ31Ks6bclZPjX67FkUzb4eG
X-Gm-Gg: AR+sD12LYqSZW1Kgd/XaJEYyxMqAuIw9J8hrYtUUMPF0xzgatUqnDFyismZOqp3SmXQ
 mD1N1/75ngGZ9MQahl/c0xpUgNonR3lYFKiqsrTgNt7B4zDycWGM0MkUhM0CyQPRT+VF9SyusMS
 oA+9Kiz9JwbHxdoky5rylke88ZLiNCldC9KYze1kRSkA/aX9NBiYBtWi600oZXW1Q2Ibh2fnCJN
 vj8cYtN1DEYR8y0bRCvlamPHGRVsozbls4b7iC2VgztjDywhSFxPDRZOh4+c13kqjY9OsPoVTCJ
 myOpbwbfHAy/nUVBtVGqjPK4K3aU5uQzJIVDjdQMfOemwfji46gwCTTqRUrJLCyIsyRCQTPI4R7
 a4W1g2IKw66OGLnhLwCZhbAS9pOMf8v96MjJJ/zq0pgMLXvtpmx7hBq8VDHGDOl85TvGs
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cdf2b179amr72531125e9.8.1788257370777; 
 Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c13:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cdf2b179amr72529995e9.8.1788257370267; 
 Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:18 +0200
Subject: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
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

The guest policy must be provided at guest launch start: LAUNCH_START for
SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
specification, section 4.3 (Guest Policy).

The policy parameter in set_guest_policy was never effective: by the
time this callback runs, LAUNCH_START has already been issued for both
SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
sev_guest->policy has no effect. In practice the only thing this
callback actually does is set the ID block and ID auth for SNP's
LAUNCH_FINISH, so rename it to set_id_block to reflect its real
purpose, remove the unused policy parameter, and drop the non-SNP code
path which was entirely dead.

This is preliminary work: actually forwarding the guest policy to the
platform before LAUNCH_START is added in a later commit.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c       |  12 ++-
 backends/igvm.c                             |   6 +-
 include/system/confidential-guest-support.h |  28 ++++---
 target/i386/sev.c                           | 118 +++++++++++-----------------
 4 files changed, 67 insertions(+), 97 deletions(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..a0b36d2da5 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                            uint64_t policy,
-                            void *policy_data1, uint32_t policy_data1_size,
-                            void *policy_data2, uint32_t policy_data2_size,
-                            Error **errp)
+static int set_id_block(void *id_block, uint32_t id_block_size,
+                        void *id_auth, uint32_t id_auth_size,
+                        Error **errp)
 {
     error_setg(errp,
-               "Setting confidential guest policy is not supported for this platform");
+               "Setting ID block is not supported for this platform");
     return -1;
 }
 
@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
-    cgsc->set_guest_policy = set_guest_policy;
+    cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..85de0d54ec 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
             id_block_len = sizeof(struct sev_id_block);
             id_auth_len = sizeof(struct sev_id_authentication);
         }
-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                          ctx->id_block, id_block_len,
-                                          ctx->id_auth, id_auth_len, errp);
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
index 4d875d10ff..465415c535 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2723,10 +2723,9 @@ static int cgs_get_mem_map_entry(int index,
     return 0;
 }
 
-static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
-                                uint64_t policy, void *policy_data1,
-                                uint32_t policy_data1_size, void *policy_data2,
-                                uint32_t policy_data2_size, Error **errp)
+static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
+                            void *id_auth, uint32_t id_auth_size,
+                            Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (sev_common->state == SEV_STATE_UNINIT) {
@@ -2734,86 +2733,57 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         return 0;
     }
 
-    if (policy_type != GUEST_POLICY_SEV) {
-        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
-                   policy_type);
+    if (!sev_snp_enabled()) {
+        error_setg(errp, "SEV: ID block is only supported for SEV-SNP");
         return -1;
     }
-    /*
-     * SEV-SNP handles policy differently. The policy flags are defined in
-     * kvm_start_conf.policy and an ID block and ID auth can be provided.
-     */
-    if (sev_snp_enabled()) {
-        SevSnpGuestState *sev_snp_guest =
-            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
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
+    SevSnpGuestState *sev_snp_guest =
+        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    struct kvm_sev_snp_launch_finish *finish =
+        &sev_snp_guest->kvm_finish_conf;
 
-            finish->id_block_uaddr =
-                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
-            finish->id_auth_uaddr =
-                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
+    g_free(sev_snp_guest->id_block);
+    g_free((guchar *)finish->id_block_uaddr);
+    g_free(sev_snp_guest->id_auth);
+    g_free((guchar *)finish->id_auth_uaddr);
+    sev_snp_guest->id_block = NULL;
+    finish->id_block_uaddr = 0;
+    sev_snp_guest->id_auth = NULL;
+    finish->id_auth_uaddr = 0;
 
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
+    if (id_block_size > 0) {
+        struct sev_snp_id_authentication *auth =
+            (struct sev_snp_id_authentication *)id_auth;
 
-        /* do not reset existing policy if policy was not set in IGVM  */
-        if (policy != 0) {
-            sev_snp_guest->kvm_start_conf.policy = policy;
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
 
@@ -2878,7 +2848,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
-    cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);

-- 
2.55.0


