Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED7CED245
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCHp-0002BF-E4; Mon, 17 Nov 2025 22:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHe-00021G-Uy
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:35 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHM-0004Cz-KG
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436077; x=1794972077;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EiFQ+knKkDk9BKUUUsyAcXreteNsFUSkKVPkud90lxo=;
 b=UtcjFdgqkFQYTDoMlaAM+t/nUT2zUSbWs5WpkrhOKWXcRfzKNi2JLgCt
 KxMgN2hThcq4zmkVelCtPqFODqEZz2Ak81bip16Szq9BZpN2xCclACGV9
 +YfcLNRjdP1zBMSTsLJwj2ZHalJ/Z/9nnm3cSaLhbwQmHy47JLaBanDMp
 PkbyHjIwTCYq61tFkaiJ4FLb3q+zCJVGXNWzd8c6G66gqhMZ3224QqljK
 vb3RwbhjYBSrKnRJ3wwH+1gPqabRkVjNG81cJLH/AJtHJ0ekDCoQErg7T
 L16zLpFkhD5iH6vWFxgdvMM6rZk+n/S0SPrzdrvUuiqRhx+45DbqtyUUU w==;
X-CSE-ConnectionGUID: +LGeZI7lT8ePneWJcCXpFQ==
X-CSE-MsgGUID: Nn3CKpX1SeamBX98dKo8XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053871"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053871"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:06 -0800
X-CSE-ConnectionGUID: 56zVilAaRvSGRUFQ32iv+Q==
X-CSE-MsgGUID: 8QnPUr7LRKGCdFHene0yNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537272"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:02 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 14/23] i386/cpu: Save/restore SSP0 MSR for FRED
Date: Tue, 18 Nov 2025 11:42:22 +0800
Message-Id: <20251118034231.704240-15-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: "Xin Li (Intel)" <xin@zytor.com>

Both FRED and CET shadow stack define the MSR MSR_IA32_PL0_SSP (aka
MSR_IA32_FRED_SSP0 in FRED spec).

MSR_IA32_PL0_SSP is a FRED SSP MSR, so that if a processor doesn't
support CET shadow stack, FRED transitions won't use MSR_IA32_PL0_SSP,
but this MSR would still be accessible using MSR-access instructions
(e.g., RDMSR, WRMSR).

Therefore, save/restore SSP0 MSR for FRED.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - New commit.
---
 target/i386/cpu.h     |  6 ++++++
 target/i386/kvm/kvm.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f4cb1dc49b71..0432af1769d2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -554,6 +554,9 @@ typedef enum X86Seg {
 #define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
 #define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
 
+/* FRED and CET MSR */
+#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer (aka MSR_IA32_FRED_SSP0 for FRED) */
+
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -1973,6 +1976,9 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
+    /* MSR used for both FRED and CET (SHSTK) */
+    uint64_t pl0_ssp;
+
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
     uint64_t tsc_aux;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c798113823..00fead0827ed 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4008,6 +4008,11 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
+            /*
+             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+             * CET shadow stack is not supported.
+             */
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
         }
     }
 #endif
@@ -4495,6 +4500,11 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
+            /*
+             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+             * CET shadow stack is not supported.
+             */
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
         }
     }
 #endif
@@ -4746,6 +4756,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_FRED_CONFIG:
             env->fred_config = msrs[i].data;
             break;
+        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
+            env->pl0_ssp = msrs[i].data;
+            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
-- 
2.34.1


