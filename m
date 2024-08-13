Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC6C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdt20-00047s-4i; Tue, 13 Aug 2024 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdt1z-00043r-2h
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:01:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdt1w-0002FP-5h
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:01:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1B3203D3;
 Tue, 13 Aug 2024 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1723561306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIt1U3mU0VQ7fVHLc48n3UibOBpE+4tYD6vXQtEJGCE=;
 b=n+Y1Oq0cntcMxflzPrje8BA4pY/MuyGHLTKuBgfcKbzhkRh/LaexAqVrkqFGGefof8ijTN
 mpBIdHG3Q+aQRzbEO3E0dO7hlv+FrFAQqDLNd/anN/tN/glP+R6ILHuyHQnR5kk3As4l3c
 peLbx2nPJvPS5xnc5BWhJ7C+nJ9sLAs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1723561306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIt1U3mU0VQ7fVHLc48n3UibOBpE+4tYD6vXQtEJGCE=;
 b=n+Y1Oq0cntcMxflzPrje8BA4pY/MuyGHLTKuBgfcKbzhkRh/LaexAqVrkqFGGefof8ijTN
 mpBIdHG3Q+aQRzbEO3E0dO7hlv+FrFAQqDLNd/anN/tN/glP+R6ILHuyHQnR5kk3As4l3c
 peLbx2nPJvPS5xnc5BWhJ7C+nJ9sLAs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8038813983;
 Tue, 13 Aug 2024 15:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHESHVl1u2Z/NAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Tue, 13 Aug 2024 15:01:45 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v5 15/16] i386/sev: Add implementation of CGS
 set_guest_policy()
Date: Tue, 13 Aug 2024 16:01:17 +0100
Message-ID: <6d244d246ec1492454c2d86f25d21b63b6da20f4.1723560001.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723560001.git.roy.hopkins@suse.com>
References: <cover.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[19]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/i386/sev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev.h | 12 +++++++
 2 files changed, 95 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6db76b0c94..8af3c785d3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2526,6 +2526,88 @@ static int cgs_get_mem_map_entry(int index,
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
 sev_common_class_init(ObjectClass *oc, void *data)
 {
@@ -2564,6 +2646,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+    cgs->set_guest_policy = cgs_set_guest_policy;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 2ccd6fe1e8..7b92102bd0 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -157,6 +157,18 @@ struct QEMU_PACKED sev_es_save_area {
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
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
-- 
2.43.0


