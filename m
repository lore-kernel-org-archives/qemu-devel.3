Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BCCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPVx-0001CU-3H; Mon, 12 May 2025 05:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPVu-0000yD-P8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPVs-0007RL-5d
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747042314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i5LcjoH04d4shGslkdrZr+UWdaESid0I/FrN+BpLW/g=;
 b=WbmA7Li2hXrsOOclWFoFSiE9ubGZL9YcYILG+/qHsRIiqbHTJdUVyb0ZZUathXlE1wjWPp
 JPVnkbizqXaZDtBL3Tv7QsHru87ns0EUbWjf4wvKzZEVcndfJ131IjSdiUHVFYC/8jY0/C
 EJYgbb/+3vDMRXEtSB6R4v6ElHzoEa4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-5XjDEzw0MT-rlGT8nzygYA-1; Mon, 12 May 2025 05:31:52 -0400
X-MC-Unique: 5XjDEzw0MT-rlGT8nzygYA-1
X-Mimecast-MFC-AGG-ID: 5XjDEzw0MT-rlGT8nzygYA_1747042311
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad22d68aa6fso209649666b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747042311; x=1747647111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5LcjoH04d4shGslkdrZr+UWdaESid0I/FrN+BpLW/g=;
 b=U0TUG3h0eoKLqoR6brsR2P+CyqwvesDvybX+ir/jOhoQhTVfMwyzhzs3mSMGPQagyA
 dlk46lCZXqXoEEh6ATFjpDu1DgmA+swgeXYpBDUydGtew/xmsGkxmMEm9Frwd0Xlzpxd
 kKESBo3WPe8DVNUV+EnnHjAuDBitVszX08u7iKA1jJWD9NTDedzDY1klUjO1f26H/yj/
 907oaKZ1PKHe653n9U/C8eazi5YGRavgtlNU/G/Y6IpOOxzFmsON3lJHln4aEvwDJqbQ
 5zcmZF8FBzJiuCZYDZ2br1R7waIiTNoou2xzY3PahMxuO3sq8aicII39AgwCrKBmWxy1
 fCBg==
X-Gm-Message-State: AOJu0YwM1h2mK47YO+IhGr9AeS5tMXF85R9IQ2JzFem5ToL3l+nRA2iO
 iBf5NSG7MZphqj96XYkEjYeFKnJOgUcy04d2Qt5fv/5Y2rMyMo2kGd01tajDm6Zul3aOlMqRWc9
 Y+dzKts20EeU4KqDxIAkw4Oc+Q5B+sQ0ZOSriX92yG9qD15S23isj5Q4lK5L95jYNDhl3WHXepv
 bAxPrbyzHp8ZRpFisTcL1ZzJ01cr5GnksSNkLH
X-Gm-Gg: ASbGncsmV9M/2OxPhQj7+CnN0O57hSKkmZyxVDUMgrvVVw2xvRLZJWCtiqPH3eylKQR
 ETW2BHCVyRXlD5gE8V3IM6jEtv7IfLePq7VfmMGtz/xXg5npA2zuI1kbvCWT42MOlCdMlpVfYUe
 gB84IKwWIgGm6YvlBTTkrF0sSICKUoskYgrFePIl3MQNGtqX55omVvRWXzenvyxs+3usUrHDIY+
 qkeK1Hf8frGR5etrP39eAJIht0S0zU7fRJp9+XcdYm0QpgJLhlmdEAoMPzYHQ8dzzIDn53enHLe
 kxoQbfs8vRIArImkGxr25JRgT1C1hAoEBWKaddyWF+54Ah8=
X-Received: by 2002:a17:907:6a13:b0:ad2:112e:a8aa with SMTP id
 a640c23a62f3a-ad218f7d383mr1208972766b.28.1747042310717; 
 Mon, 12 May 2025 02:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5xVtbTV17Khn8c+byLgRaUWzoh0NkV7aVQCc+opfU9xeMozUfFk40DB9mjCfLOfFyoYRveg==
X-Received: by 2002:a17:907:6a13:b0:ad2:112e:a8aa with SMTP id
 a640c23a62f3a-ad218f7d383mr1208969866b.28.1747042309981; 
 Mon, 12 May 2025 02:31:49 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2368735f4sm421288366b.146.2025.05.12.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:31:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com
Subject: [PATCH] linux-headers: update from 6.15 + kvm/next
Date: Mon, 12 May 2025 11:31:46 +0200
Message-ID: <20250512093146.91254-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This brings in the userspace TDX API.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-x86/kvm.h | 71 +++++++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h   |  1 +
 2 files changed, 72 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index dc591fb17e5..7fb57ccb2a7 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -439,6 +439,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
+#define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
@@ -928,4 +929,74 @@ struct kvm_hyperv_eventfd {
 #define KVM_X86_SNP_VM		4
 #define KVM_X86_TDX_VM		5
 
+/* Trust Domain eXtension sub-ioctl() commands. */
+enum kvm_tdx_cmd_id {
+	KVM_TDX_CAPABILITIES = 0,
+	KVM_TDX_INIT_VM,
+	KVM_TDX_INIT_VCPU,
+	KVM_TDX_INIT_MEM_REGION,
+	KVM_TDX_FINALIZE_VM,
+	KVM_TDX_GET_CPUID,
+
+	KVM_TDX_CMD_NR_MAX,
+};
+
+struct kvm_tdx_cmd {
+	/* enum kvm_tdx_cmd_id */
+	__u32 id;
+	/* flags for sub-commend. If sub-command doesn't use this, set zero. */
+	__u32 flags;
+	/*
+	 * data for each sub-command. An immediate or a pointer to the actual
+	 * data in process virtual address.  If sub-command doesn't use it,
+	 * set zero.
+	 */
+	__u64 data;
+	/*
+	 * Auxiliary error code.  The sub-command may return TDX SEAMCALL
+	 * status code in addition to -Exxx.
+	 */
+	__u64 hw_error;
+};
+
+struct kvm_tdx_capabilities {
+	__u64 supported_attrs;
+	__u64 supported_xfam;
+	__u64 reserved[254];
+
+	/* Configurable CPUID bits for userspace */
+	struct kvm_cpuid2 cpuid;
+};
+
+struct kvm_tdx_init_vm {
+	__u64 attributes;
+	__u64 xfam;
+	__u64 mrconfigid[6];	/* sha384 digest */
+	__u64 mrowner[6];	/* sha384 digest */
+	__u64 mrownerconfig[6];	/* sha384 digest */
+
+	/* The total space for TD_PARAMS before the CPUIDs is 256 bytes */
+	__u64 reserved[12];
+
+	/*
+	 * Call KVM_TDX_INIT_VM before vcpu creation, thus before
+	 * KVM_SET_CPUID2.
+	 * This configuration supersedes KVM_SET_CPUID2s for VCPUs because the
+	 * TDX module directly virtualizes those CPUIDs without VMM.  The user
+	 * space VMM, e.g. qemu, should make KVM_SET_CPUID2 consistent with
+	 * those values.  If it doesn't, KVM may have wrong idea of vCPUIDs of
+	 * the guest, and KVM may wrongly emulate CPUIDs or MSRs that the TDX
+	 * module doesn't virtualize.
+	 */
+	struct kvm_cpuid2 cpuid;
+};
+
+#define KVM_TDX_MEASURE_MEMORY_REGION   _BITULL(0)
+
+struct kvm_tdx_init_mem_region {
+	__u64 source_addr;
+	__u64 gpa;
+	__u64 nr_pages;
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index e5f3e8b5a02..99cc82a275c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -369,6 +369,7 @@ struct kvm_run {
 #define KVM_SYSTEM_EVENT_WAKEUP         4
 #define KVM_SYSTEM_EVENT_SUSPEND        5
 #define KVM_SYSTEM_EVENT_SEV_TERM       6
+#define KVM_SYSTEM_EVENT_TDX_FATAL      7
 			__u32 type;
 			__u32 ndata;
 			union {
-- 
2.49.0


