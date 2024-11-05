Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC8D1CA3D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DHb-00074z-TH; Tue, 05 Nov 2024 01:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFp-0003v2-U2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:30 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DFF-0001w0-SW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788854; x=1762324854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oRT7vJ7+68FbrD5uefrUrGWOgNBDYndBP8Hc2+4+qeY=;
 b=NjvEAs3z5z2fc8EH6OyXRJXmX16kUQ/95AxdBxzAWzcX3GnK1rGXETvL
 Uv8rd1iLYU8xjntdBBoG+WrmaUZ6jpCShF9PjtxkVMGQt7TRwUpfe/uAp
 fFAHgpCgZUw4/6SQwF+ErFK5I7igXEH0uuIdX1XbN+Ohw4UjRrrP6QPEy
 pnasymMO33gxBPETh2HebwK6jgT1B8b7DvyMJTkWomBt3r2IXY1pm7ps8
 ZjUUR8SrOYPY5teP3B56XiqTyd8zIGtx9GjBc5lsCwJnnahpjmMjJnlLb
 9kbQJdnuz05qevxLspmwh4VsbullYwECrgclMoSNswAJqcLl/fxV5X/VW A==;
X-CSE-ConnectionGUID: DuXghf5NRx29dZRSz3N2Fg==
X-CSE-MsgGUID: C/i+O22ySwKhY7CqBhTzcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689962"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:35 -0800
X-CSE-ConnectionGUID: LzAzyvrmS+yTZ8bmyu8w1Q==
X-CSE-MsgGUID: 2ERfMEY6TBCvNuxBGJjdvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83990148"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:31 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 59/60] i386/cpu: Set up CPUID_HT in x86_cpu_realizefn()
 instead of cpu_x86_cpuid()
Date: Tue,  5 Nov 2024 01:24:07 -0500
Message-Id: <20241105062408.3533704-60-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

Otherwise, it gets warnings like below when number of vcpus > 1:

  warning: TDX enforces set the feature: CPUID.01H:EDX.ht [bit 28]

This is because x86_confidential_guest_check_features() checks
env->features[] instead of the cpuid date set up by cpu_x86_cpuid()

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 472ab206d8fe..214a1b00a815 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6571,7 +6571,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
-            *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
@@ -7784,6 +7783,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     unsigned requested_lbr_fmt;
 
+    qemu_early_init_vcpu(cs);
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
     tcg_cflags_set(cs, CF_PCREL);
@@ -7851,6 +7852,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    /*
+     * It needs to called after feature filter because KVM doesn't report HT
+     * as supported
+     */
+    if (cs->nr_cores * cs->nr_threads > 1) {
+        env->features[FEAT_1_EDX] |= CPUID_HT;
+    }
+
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
      * CPUID[1].EDX.
      */
-- 
2.34.1


