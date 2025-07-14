Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EB1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLW-00067a-Fp; Mon, 14 Jul 2025 07:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH07-0001FJ-1t
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH04-0001vK-RY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uS8ovijzu/++v9gkFCTWnhU+isxUyJNb+e5pEgTtM48=;
 b=Kcs6BTtaroutoIZsuQKnJp8LskoX6MUy3mAG3aUqvB3GC66hwE9kp9mfX/U1tTx3eHZWLj
 cfCesF80TUEPkJ3J874eBm0fZ/rwmsm0cqCUNPopQBEXWCTsrc6QTCToGLfUNR8MCW3c1E
 +/QlerzOXepDEhGWkrmpVa1pY/kcSzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-aJmgu4DTN3iPK-Az2UqXaA-1; Mon, 14 Jul 2025 07:05:34 -0400
X-MC-Unique: aJmgu4DTN3iPK-Az2UqXaA-1
X-Mimecast-MFC-AGG-ID: aJmgu4DTN3iPK-Az2UqXaA_1752491133
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so22964835e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491132; x=1753095932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uS8ovijzu/++v9gkFCTWnhU+isxUyJNb+e5pEgTtM48=;
 b=MSHJsH/mNSbfNksXPM8c73hc5acIyaoPGk/Cga+kF3A62ft1W7wF1rF1kGvydDZbXH
 y0Ydqth261nT2kJEDfKT6fWmomzS0GlFSWAis72WhMr8Xnyn3klJWczwPDVbQ+k//Y+/
 jpFfmYw+WAcbEJkmGohA7PxvuRKJ+8n/klYd1lNSMa/xGAdNDUVJ0Eg7EuQtiXKsrqhG
 436gOAsMmNzeZK27Lv3NVFh9F4yFjxzAWPHbxWuxdET9gZi6wPEbyC/vR+HmHADN7QON
 xv/KXU3TYn67QUcTEG4Nn5CCLp/r7iSlFEXpwDf6NLYk4fv91WyR40MzMlirYxEMSJs/
 47rA==
X-Gm-Message-State: AOJu0Yz8l6fr+GMj2m4NrYhlLWIb4IkxrnzKDL71JkB8RlXa2Eqmn9vm
 rvsjQy+fV2NVkz4mgKiSfkNdTZZpDjfsz5udi/VdbikhGZFa3T7H1Sf2oZg0uM712Ko1ViodUj+
 5bJOKqYME8X9yaUGRAWe75TCz7bDTyuJZQZV+n9zdhH8IDnnxs9wcvVw0uSwv63GqvY3PYEbAUO
 jR32Yrd8CQQJO/OrfuEemfG908BU+eb/L5PfcNGCWh
X-Gm-Gg: ASbGnctp+zwGLm41sVKCJeUruhjZ/O+LKTKDghbaBH8XuJn14I09ur6SCFvaNN6jRjM
 ifhFz3/3f0Xd4RoDsDjJLdh9HH+z/hrA14sFxnWr2a28sD2mX/sxFTRr+DHs+1TtT2DDwibdaH8
 0PZ3b9GfM4ZSnQ/7v9MFAe1bRUfB00lP2xnc05XL5pgOxlPYgZQ+gXUF8I+sGfS2/r9tyRG+8Xz
 7eleesE6Y3UpMAAD0ZjYZbnmL1Ucs1IQ68aiuyVuY2WE7mxvZpcsAWwk5Lg9woK97+yYoeeHD3y
 BpCSzRBorlbHqIY6Jv+sXfsZwbXc/IZKPwMvyrnaajo=
X-Received: by 2002:a05:600c:190b:b0:456:2020:165d with SMTP id
 5b1f17b1804b1-45620201844mr15127605e9.31.1752491131889; 
 Mon, 14 Jul 2025 04:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUnNoiXUV4oqzj25YhC7f5sPbYBd33GBSnilDaJTKPeddJhQOKPtyyx7uaKG/dwuMK+XL27Q==
X-Received: by 2002:a05:600c:190b:b0:456:2020:165d with SMTP id
 5b1f17b1804b1-45620201844mr15127285e9.31.1752491131383; 
 Mon, 14 Jul 2025 04:05:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd29sm58737245e9.34.2025.07.14.04.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 31/77] i386/sev: Add implementation of CGS set_guest_policy()
Date: Mon, 14 Jul 2025 13:03:20 +0200
Message-ID: <20250714110406.117772-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

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
Link: https://lore.kernel.org/r/99e82ddec4ad2970c790db8bea16ea3f57eb0e53.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.h | 12 +++++++
 target/i386/sev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index d2eb06db321..9db1a802f6b 100644
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
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1296f4feb62..3e5722ba657 100644
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
-- 
2.50.0


