Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB62CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGr-0001Lt-IL; Mon, 17 Nov 2025 22:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGp-0001LH-U3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:43 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGn-0004Cz-Nx
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436042; x=1794972042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sPgQ6HV3cQvKboeym46NGXGdw3g89C4CiandiaMUJkA=;
 b=P8+39O4Ay6JNSCijwWHTAm42jS3ic4VwuUWAHmVBrWJbmTtX13WOaymt
 J3H23HX30+goA3i5kbFdlluLAMurkImE6/A1WKE87NFCod43PNAXFAnSI
 qltTPFht8EqTUjRGGFXel8LI/v+QRN58V5ZHMkvnF+wMYunscAIpLWscD
 bHOrXXH0LcZCHQlTroiDjEVKih5XRe4wmSYkmyeGbbgLliLl+gdWG2RPz
 JbvO9QoVLuT4CgPX1qXoiASrh/6ISToVj6w91W4XokXmRPr7DYJo6HeoU
 m6MYEjGztriYsYq0nSpEXusv7zz6vcM9nyyfkioQSgTjPp67dRaBHzzZT A==;
X-CSE-ConnectionGUID: Rs5vC99oRSO6wpKaJlbB2Q==
X-CSE-MsgGUID: pKYyFWH8T+KzqTht2sp9JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053788"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:41 -0800
X-CSE-ConnectionGUID: hPrQoh4mR9CkxfFu66VihQ==
X-CSE-MsgGUID: kMHQ5/8FR7iaD6GvwOPUqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537178"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:38 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 07/23] i386/cpu: Use x86_ext_save_areas[] for CPUID.0XD
 subleaves
Date: Tue, 18 Nov 2025 11:42:15 +0800
Message-Id: <20251118034231.704240-8-zhao1.liu@intel.com>
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

The x86_ext_save_areas[] is expected to be well initialized by
accelerators and its xstate detail information cannot be changed by
user. So use x86_ext_save_areas[] to encode CPUID.0XD subleaves directly
without other hardcoding & masking.

And for arch LBR case, since its entry in x86_ext_save_areas[] has been
initialized based KVM support in kvm_cpu_xsave_init(), so use
x86_ext_save_areas[] for encoding.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - New commit.
---
 target/i386/cpu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70a282668f72..f3bf7f892214 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8188,20 +8188,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         } else if (count == 0xf && cpu->enable_pmu
                    && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
+            const ExtSaveArea *esa = &x86_ext_save_areas[count];
+
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
-            if (x86_cpu_xsave_xcr0_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = esa->offset;
-                *ecx = esa->ecx &
-                       (ESA_FEATURE_ALIGN64_MASK | ESA_FEATURE_XFD_MASK);
-            } else if (x86_cpu_xsave_xss_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = 0;
-                *ecx = 1;
-            }
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         }
         break;
     }
-- 
2.34.1


