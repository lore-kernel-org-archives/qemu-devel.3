Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 06:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpLMr-00061w-1V; Tue, 04 Mar 2025 01:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMa-00060x-GC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:45 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMX-0001L0-UU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741068162; x=1772604162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Royr0YQHx4K+3ITmwcIeH6IdEhVwMH0jLDn8bMuDm0A=;
 b=f5N8RZhetFlKph0LrygIcMmB8P/IluUSmwIbQ+/iDx+BOqTBchCIQTmR
 NnuKMOZc0Sn7gv1n0+DAhiaraG7sdnzSNDjXM7fAo6BkDpi+C/tAZpHQR
 29mZUyOd7+aSphMvObH4i2Ojm1dLwjF9H2KPtDQMqRdB/7kOiLBBQRTUT
 9vAsDbyUFcOdbR+rg7LMljT0D0vFR77big9gbqQrbfEw4j7NN3YrSfzpS
 G9OQ5pwQTHO8mf4xcAe3Z5NwtgZOOwpbMrEy0G5FxU8XgbtXPAaI8WXn7
 7DQ+CxvtGYUWJSsPV7qySj/K7kwZbYujfPfOFLQ2/OenFvS9OlUsoxfQW A==;
X-CSE-ConnectionGUID: RVT3XW/9QxKmmN2KfJyQHQ==
X-CSE-MsgGUID: nc1zBR6eSMeqz3arN1O/dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59519171"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="59519171"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 22:02:33 -0800
X-CSE-ConnectionGUID: AkjU4NFsRV2s1v8gWNZ/yg==
X-CSE-MsgGUID: hg9QiAEEQemHlsUm+m74jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118132372"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 22:02:30 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH 2/2] i386/cpu: Warn about why CPUID_EXT_PDCM is not available
Date: Tue,  4 Mar 2025 00:24:50 -0500
Message-Id: <20250304052450.465445-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304052450.465445-1-xiaoyao.li@intel.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
a warning to inform the user.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2bf6495140a0..2aa2bab12100 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7682,6 +7682,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     }
 
     if (!cpu->enable_pmu) {
+        mark_unavailable_features(cpu, FEAT_1_ECX,
+                                  env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
+                                  "This feature is not available due to PMU disabled");
         env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
     }
 
-- 
2.34.1


