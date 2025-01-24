Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DCAC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJsG-0003jV-7n; Fri, 24 Jan 2025 08:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJry-0003hb-Fi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:11 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJrv-0003ou-G4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725828; x=1769261828;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k4KI7JqdKXwSaj6F8A12dq8VgP78I35tk6J67g1GTA8=;
 b=KXTaS4OVAq9i0oIsyDPsP2AGbFbHOE2BwCSkO/P72EvOK9Wk8XoQwIO7
 kSq5lT8mcgz6Yd3tcnCnwGo0ywM3X3zd9gg53fMJ/OQKXeIQuyJqT8nfq
 ntRkQBSUPTcMdCWBkAa1eId33P9zgp0y/gjHkCKsNbJnvfyVM717wm5ot
 x60t7JSPwxpBRjy1iPtbXYOFJ+m/o8nVEfq+483EZ6q58A7MgVhEWEFvr
 lGnUvOjQ6hmGwrllWi3zTiCpjCvRW+raq5T1wPdQmPrwORTwg+L1yduIF
 rI82SK6mO345Yhm9yfJ5YJOnLczJKPb7UUTIton1iTcHwKFYH4V5L7goU Q==;
X-CSE-ConnectionGUID: 1V7ycX80R029MMyGygoFNA==
X-CSE-MsgGUID: BF9eNpzpTia43igSDWAP8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246177"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246177"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:37:06 -0800
X-CSE-ConnectionGUID: nT6XmjO6Th61FL7urozFDw==
X-CSE-MsgGUID: lcLbrOt9SHyKhDI8nyXAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804098"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:37:01 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 01/52] *** HACK *** linux-headers: Update headers to pull
 in TDX API changes
Date: Fri, 24 Jan 2025 08:19:57 -0500
Message-Id: <20250124132048.3229049-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pull in recent TDX updates, which are not backwards compatible.

It's just to make this series runnable. It will be updated by script

	scripts/update-linux-headers.sh

once TDX support is upstreamed in linux kernel

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 linux-headers/asm-x86/kvm.h | 70 +++++++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h   |  1 +
 2 files changed, 71 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 96589490c426..baca2d479365 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -923,5 +923,75 @@ struct kvm_hyperv_eventfd {
 #define KVM_X86_SEV_VM		2
 #define KVM_X86_SEV_ES_VM	3
 #define KVM_X86_SNP_VM		4
+#define KVM_X86_TDX_VM		5
+
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
+	 * Defined for consistency with struct kvm_sev_cmd.
+	 */
+	__u64 hw_error;
+};
+
+struct kvm_tdx_capabilities {
+	__u64 supported_attrs;
+	__u64 supported_xfam;
+	__u64 reserved[254];
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
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3bcd4eabe324..b325122505b5 100644
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
2.34.1


