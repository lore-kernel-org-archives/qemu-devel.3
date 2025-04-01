Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8475FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsa-0005Uk-32; Tue, 01 Apr 2025 09:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsT-0005L2-5o
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:05 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsR-0006Zf-K0
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514923; x=1775050923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jj65KKNKTnmksAnaDvoY5h2mRN3IOIbJ7P4DuI4Zdgw=;
 b=QBn9bqWuDd7zVfvRqz4o0OnREoNd/BiU2AV25qeaeW46GPgFcElvvbtS
 efPJJ1XWD9hWux9u4FjWkF/s/dJvHKWV+4M2jbRtL/v72dRDak5QB5bs/
 n/nKqMyWsCkaUBDvdTF2yxUpB8f1o/OVjn/K2CfC5rwvoqE20R1ssfU09
 cqSsMF3IfuD7arttTtp79KBYewCnPIHgvIBta/r8eI1gtbYE7MdYckJnE
 Y3szU3L1vrWoz7Iy2iPCBhTADhPx0HT1x+tVz/wmOdnXaTHGOQaTdEUyN
 OTr8203GH3uXZXJnLXwJXI58Y9ZKaWdXixxgCoX3oBJO1Fb+YHNmLV+ua Q==;
X-CSE-ConnectionGUID: 7686ZTpySHawNIOVjqJvEg==
X-CSE-MsgGUID: AsPwLgRIT/++AD+CgJbbtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433253"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:47 -0700
X-CSE-ConnectionGUID: RwrVdtcmRu2CEFta/INxAg==
X-CSE-MsgGUID: a8oJgQWoRd2uKFhbq2NC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639973"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:44 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 14/55] i386/tdx: Set APIC bus rate to match with what TDX
 module enforces
Date: Tue,  1 Apr 2025 09:01:24 -0400
Message-Id: <20250401130205.2198253-15-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

TDX advertises core crystal clock with cpuid[0x15] as 25MHz for TD
guests and it's unchangeable from VMM. As a result, TDX guest reads
the APIC timer as the same frequency, 25MHz.

While KVM's default emulated frequency for APIC bus is 1GHz, set the
APIC bus rate to match with TDX explicitly to ensure KVM provide correct
emulated APIC timer for TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - new patch;
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 target/i386/kvm/tdx.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 77ddb2655c53..1a99b677686e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -253,6 +253,19 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+    if (!kvm_check_extension(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS)) {
+        error_setg(errp, "KVM doesn't support KVM_CAP_X86_APIC_BUS_CYCLES_NS");
+        return -EOPNOTSUPP;
+    }
+
+    r = kvm_vm_enable_cap(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS,
+                          0, TDX_APIC_BUS_CYCLES_NS);
+    if (r < 0) {
+        error_setg_errno(errp, -r,
+                         "Unable to set core crystal clock frequency to 25MHz");
+        return r;
+    }
+
     if (tdx_guest->mrconfigid) {
         g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
                               strlen(tdx_guest->mrconfigid), &data_len, errp);
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index e472b11fb0dd..d39e733d9fcc 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -16,6 +16,9 @@ typedef struct TdxGuestClass {
     X86ConfidentialGuestClass parent_class;
 } TdxGuestClass;
 
+/* TDX requires bus frequency 25MHz */
+#define TDX_APIC_BUS_CYCLES_NS 40
+
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
-- 
2.34.1


