Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B497CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 09:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1supua-0002Ig-At; Sun, 29 Sep 2024 05:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1supuY-0002IC-Uf
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 05:08:15 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1supuW-0001bp-RK
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 05:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727600893; x=1759136893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=btMm3h7haR/kH4uf+Fo7KWuvXPTV+Bhi5whJgwA9hKU=;
 b=EkOG0xaKL7HRNWAGgeBl2bU65Ou3SBq1YOOlVnGZGpWNGYa41vq3ajKn
 Zt414jKfAuisxGPcCwidt6BTYxaj2kRB4RiIHXRRB+Gd1A0zdOgHE9B62
 ChiRLVZtD++HYimolxtx2LtvsKuIsLkuwPcuzJtZGIO5e8HlGaxuhYFzG
 4snSjxL3llXKidIy5tBl7Ur/zNEvRH0PDmekJKLridYM95JMdyZOHUnC2
 sGewYQYQ4o1q+W0XFz78zVS9W0D3dJFK3+Ku43vUl11ZpLtwB382mtCn/
 CJaOJHnQyUF8tJTQRrNwbCDFrs5N+kgiIEMUc3gHHpkWrrvavpt44AUAl A==;
X-CSE-ConnectionGUID: wX3XCMN4QSy7ZdjpZusJnA==
X-CSE-MsgGUID: eSTOJuL5Q/6KkVVz+CVhow==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26876755"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="26876755"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 02:08:08 -0700
X-CSE-ConnectionGUID: 6ySUs4oKSIq249WDdTW9ng==
X-CSE-MsgGUID: XFsS0/BzToSPOcQKTlj28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="77798932"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa003.jf.intel.com with ESMTP; 29 Sep 2024 02:08:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org
Subject: [PATCH v2] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
Date: Sun, 29 Sep 2024 04:57:47 -0400
Message-Id: <20240929085747.2023198-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

The check of cpu->phys_bits to be in range between
[32, TARGET_PHYS_ADDR_SPACE_BITS] in host_cpu_realizefn()
is duplicated with check in x86_cpu_realizefn().

Since the ckeck in x86_cpu_realizefn() is called later and can cover all
the x86 cases. Remove the one in host_cpu_realizefn().

Opportunistically adjust cpu->phys_bits directly in
host_cpu_adjust_phys_bits(), which matches more with the function name.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v2:
 - make host_cpu_adjust_phys_bits() return void and adjust
   cpu->phys_bits inside it.
---
 target/i386/host-cpu.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 8b8bf5afeccf..03b9d1b169a5 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -42,7 +42,7 @@ static uint32_t host_cpu_phys_bits(void)
     return host_phys_bits;
 }
 
-static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
+static void host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
     uint32_t phys_bits = cpu->phys_bits;
@@ -66,7 +66,7 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
         }
     }
 
-    return phys_bits;
+    cpu->phys_bits = phys_bits;
 }
 
 bool host_cpu_realizefn(CPUState *cs, Error **errp)
@@ -75,17 +75,7 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
     CPUX86State *env = &cpu->env;
 
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
-
-        if (phys_bits &&
-            (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
-             phys_bits < 32)) {
-            error_setg(errp, "phys-bits should be between 32 and %u "
-                       " (but is %u)",
-                       TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
-            return false;
-        }
-        cpu->phys_bits = phys_bits;
+        host_cpu_adjust_phys_bits(cpu);
     }
     return true;
 }
-- 
2.34.1


