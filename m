Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86669C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMl6-0002kg-57; Thu, 03 Jul 2025 12:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMl0-0002jt-DC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:25:54 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMkx-0007NF-Sq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:25:53 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.83])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 393FC40138;
 Thu,  3 Jul 2025 17:25:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751559950;
 bh=sLoH0T4KgHwZbt7JHOe5nAy9pou4vfAc5mz/sm1XWms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XZ1D6q/nBs6ev9Mu29yC1HVHIvs+EoNbzhwFhRi9nAz0p6kvPEVCwm3NEZc5jufLB
 RtjapHFyO7CTHE+L+73zcHhol6B8eTBPHBqB2p/3m+Ya1KzO3klibzL3+9auOYC4Xr
 lRG91vNAjctBMMwyiyXdLTH684cp8r8O63NL4PgA=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id ADA304024E;
 Thu,  3 Jul 2025 17:25:45 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 15/16] i386/sev: Add implementation of CGS
 set_guest_policy()
Date: Thu,  3 Jul 2025 17:21:58 +0100
Message-ID: <99e82ddec4ad2970c790db8bea16ea3f57eb0e53.1751554099.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The new cgs_set_guest_policy() function is provided to receive the guest
policy flags, SNP ID block and SNP ID authentication from guest
configuration such as an IGVM file and apply it to the platform prior to
launching the guest.

The policy is used to populate values for the existing 'policy',
'id_block' and 'id_auth' parameters. When provided, the guest policy is
applied and the ID block configuration is used to verify the launch
measurement and signatures. The guest is only successfully started if
the expected launch measurements match the actual measurements and the
signatures are valid.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev.h | 12 +++++++
 2 files changed, 95 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1296f4feb6..3e5722ba65 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2518,6 +2518,88 @@ static int cgs_get_mem_map_entry(int index,
     return 0;
 }
 
+static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t policy, void *policy_data1,
+                                uint32_t policy_data1_size, void *policy_data2,
+                                uint32_t policy_data2_size, Error **errp)
+{
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
+        __func__, policy_type);
+        return -1;
+    }
+    /*
+     * SEV-SNP handles policy differently. The policy flags are defined in
+     * kvm_start_conf.policy and an ID block and ID auth can be provided.
+     */
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest =
+            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+        struct kvm_sev_snp_launch_finish *finish =
+            &sev_snp_guest->kvm_finish_conf;
+
+        /*
+         * The policy consists of flags in 'policy' and optionally an ID block
+         * and ID auth in policy_data1 and policy_data2 respectively. The ID
+         * block and auth are optional so clear any previous ID block and auth
+         * and set them if provided, but always set the policy flags.
+         */
+        g_free(sev_snp_guest->id_block);
+        g_free((guchar *)finish->id_block_uaddr);
+        g_free(sev_snp_guest->id_auth);
+        g_free((guchar *)finish->id_auth_uaddr);
+        sev_snp_guest->id_block = NULL;
+        finish->id_block_uaddr = 0;
+        sev_snp_guest->id_auth = NULL;
+        finish->id_auth_uaddr = 0;
+
+        if (policy_data1_size > 0) {
+            struct sev_snp_id_authentication *id_auth =
+                (struct sev_snp_id_authentication *)policy_data2;
+
+            if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
+                error_setg(errp, "%s: Invalid SEV-SNP ID block: incorrect size",
+                           __func__);
+                return -1;
+            }
+            if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
+                error_setg(errp,
+                           "%s: Invalid SEV-SNP ID auth block: incorrect size",
+                           __func__);
+                return -1;
+            }
+            assert(policy_data1 != NULL);
+            assert(policy_data2 != NULL);
+
+            finish->id_block_uaddr =
+                (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
+            finish->id_auth_uaddr =
+                (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);
+
+            /*
+             * Check if an author key has been provided and use that to flag
+             * whether the author key is enabled. The first of the author key
+             * must be non-zero to indicate the key type, which will currently
+             * always be 2.
+             */
+            sev_snp_guest->kvm_finish_conf.auth_key_en =
+                id_auth->author_key[0] ? 1 : 0;
+            finish->id_block_en = 1;
+        }
+        sev_snp_guest->kvm_start_conf.policy = policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+        /* Only the policy flags are supported for SEV and SEV-ES */
+        if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
+            error_setg(errp, "%s: An ID block/ID auth block has been provided "
+                             "but SEV-SNP is not enabled", __func__);
+            return -1;
+        }
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
@@ -2556,6 +2638,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+    cgs->set_guest_policy = cgs_set_guest_policy;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
diff --git a/target/i386/sev.h b/target/i386/sev.h
index d2eb06db32..9db1a802f6 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -167,6 +167,18 @@ struct QEMU_PACKED sev_es_save_area {
     uint8_t fpreg_ymm[256];
 };
 
+struct QEMU_PACKED sev_snp_id_authentication {
+    uint32_t id_key_alg;
+    uint32_t auth_key_algo;
+    uint8_t reserved[56];
+    uint8_t id_block_sig[512];
+    uint8_t id_key[1028];
+    uint8_t reserved2[60];
+    uint8_t id_key_sig[512];
+    uint8_t author_key[1028];
+    uint8_t reserved3[892];
+};
+
 bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
 
 int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);
-- 
2.43.0


