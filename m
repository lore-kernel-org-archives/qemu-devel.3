Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeeo-0002h3-T5; Tue, 30 Jul 2024 00:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeen-0002Zl-23
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:17 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeel-0006BM-CZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722314415; x=1753850415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cL92rD81kzK7ojUvhsDE3dVX2dFVVXty9ZJ/bZd7F3s=;
 b=j2T34JyMW3T0q/9fvF/WLIeXlY5oaEl95w8gGYgp8bAMGJm2hDENrUjn
 jq98uIc8GS4tIU2JzZAxVUL+FBaoP2dSghC9PsYHYbwMYG+T+ydrgg9da
 iv9K9OnoakD2E+w/C4qfpRSDHDCuTviwUfxCmDTC0XLkibkg6ayz3t0t5
 oGzLaQufR/CdIcUllFkh9uPcg38NuPjluhZbdMD5fuxprFz+yYBIgOj8b
 pVEXqHKkAczLmDKXP/h1ChKwOVZWyIszU2sh7CGEsvPrZkqJZCJimxtJP
 FxhYi9EpOuxrBgt/mbdo4PsONB8eQUg7PL7Vvhg8PBcrv702MHeuYIT4l Q==;
X-CSE-ConnectionGUID: 4kGdcnA/Sja505uYmSosyA==
X-CSE-MsgGUID: M+dpMc1dTIWgS2KGCAcvVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20288560"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="20288560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 21:40:15 -0700
X-CSE-ConnectionGUID: yfA2DkXRS/GBoAw38B1vsw==
X-CSE-MsgGUID: jdQwO3WnT5O5S+UthJ6s9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="77429935"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 21:40:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/4] target/i386/cpu: Mask off SGX/SGX_LC feature words for
 non-PC machine
Date: Tue, 30 Jul 2024 12:55:44 +0800
Message-Id: <20240730045544.2516284-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730045544.2516284-1-zhao1.liu@intel.com>
References: <20240730045544.2516284-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only PC machine supports SGX, so mask off SGX related feature words for
non-PC machine (microvm).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/sgx-stub.c        |  5 +++++
 hw/i386/sgx.c             |  8 ++++++++
 include/hw/i386/sgx-epc.h |  1 +
 target/i386/cpu.c         | 15 +++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 16b1dfd90bb5..38ff75e9f377 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -32,6 +32,11 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
 }
 
+bool check_sgx_support(void)
+{
+    return false;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     return true;
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 849472a12865..4900dd414a1f 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -266,6 +266,14 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
                    size);
 }
 
+bool check_sgx_support(void)
+{
+    if (!object_dynamic_cast(qdev_get_machine(), TYPE_PC_MACHINE)) {
+        return false;
+    }
+    return true;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     PCMachineState *pcms =
diff --git a/include/hw/i386/sgx-epc.h b/include/hw/i386/sgx-epc.h
index 3e00efd870c9..41d55da47999 100644
--- a/include/hw/i386/sgx-epc.h
+++ b/include/hw/i386/sgx-epc.h
@@ -58,6 +58,7 @@ typedef struct SGXEPCState {
     int nr_sections;
 } SGXEPCState;
 
+bool check_sgx_support(void);
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size);
 void sgx_epc_build_srat(GArray *table_data);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f55e9ba3ed8..66f9737a117c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6103,6 +6103,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         }
         break;
 
+    case FEAT_7_0_EBX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_EBX_SGX;
+        }
+#endif
+        break;
+    case FEAT_7_0_ECX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_ECX_SGX_LC;
+        }
+#endif
+        break;
+
     default:
         break;
     }
-- 
2.34.1


