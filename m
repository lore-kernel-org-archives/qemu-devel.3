Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BCC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKU5-0003ix-Hz; Thu, 04 Jul 2024 07:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPKTz-0003iZ-UJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:18:37 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPKTx-0006RX-Jv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720091913; x=1751627913;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0xy6FaN1makrO+eqNj7Tn9kcQEZ/h1Qa/hmjtlFd3hQ=;
 b=hq91ttwo3IJKFqEh/MVWIywckJfv8S4Fa03D5QjxF4aupd6iKnstxPI2
 WnBb9pjvPKbiZWzICISC8mDhJCQgFCKwooEXyFALrHIq1kzicQ8qfJ7mC
 layVlN++/+m1hg6JTQGT1yLx+3dWk8iSHeEkVYh3TmvmQ1HHXjgIojtqn
 Ozv7WBpRDB+QoXtBDJGuvT+vMOo933rtDHhs09bhlV3waPkF/wf11G68p
 BSr4y5kktUW8opEUhY8Bi7OJYofmzx1aNyelyb9dob/8H3Hc9h+rlq8o3
 Sd4AayXRGRi3K62Y6w0ujXha8cj3z5jCpqNATJUmxoLRg2hgGAVTC3zZW w==;
X-CSE-ConnectionGUID: kVh1YVTfTVebHmkA8LWEWg==
X-CSE-MsgGUID: TxUEd8WKTQCP9LwNNcOfJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21176231"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="21176231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 04:18:30 -0700
X-CSE-ConnectionGUID: OfFVhxFgRO2cqXPljkZXCg==
X-CSE-MsgGUID: +GgAVA13RWCEb8GBSqmqRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46535003"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2024 04:18:29 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] i386/cpu: Drop the check of phys_bits in host_cpu_realizefn()
Date: Thu,  4 Jul 2024 07:12:31 -0400
Message-Id: <20240704111231.2881016-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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
teh x86 case. Remove the one in host_cpu_realizefn().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/host-cpu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 8b8bf5afeccf..b109c1a2221f 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
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
+        cpu->phys_bits = host_cpu_adjust_phys_bits(cpu);
     }
     return true;
 }
-- 
2.34.1


