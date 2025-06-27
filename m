Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4DC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUznF-0002hf-3G; Thu, 26 Jun 2025 23:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUznD-0002hB-1L
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:23 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUznB-0007SZ-7o
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750995021; x=1782531021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HFjv+JYT/dQV1XqLt+l9iUih2+5JEcR33IkcBKX4acQ=;
 b=BF7lq/qZXzyU8GmK9dI/FLLAEXcim/R1S6Pex9as6O0ZL/3yZdiZ+0rJ
 9DC04lGTDxjNOhgT0jxD25i+Ts+1PqZy4gJbgBjF6OgXQpLIUEYNgNa1B
 FUviBYUGtMk2HTbCKXt7TMRrKBZizOfreM7RFayJR8USYKcXatY/0PPZ3
 W6HkMu9OXSXdPLYX1iihg5cuU4r+H2lK/RGW44XRL4FFiA3fyXzp3p5z4
 UE4CP17rZ83IB+jYywdbagdzGPsbHL+4UdUJlJ7Iq2qedpsZYrtUZWYeV
 NZTWgUSgDmj8bJ1qkoUsBThxSH32d89oq24Z7DCtS219YSjeXZ6KPjhSz g==;
X-CSE-ConnectionGUID: gH0QzRaGT2yrFBAq5+2HVA==
X-CSE-MsgGUID: 8L5b7MmMTOqUHbMQ6y+hhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53247143"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="53247143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 20:30:21 -0700
X-CSE-ConnectionGUID: xvXrYM/tS2iJq06RpI25mQ==
X-CSE-MsgGUID: RwRoOmpVT8SdbUuU6eQtYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="157084653"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 20:30:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as
 reserved for Intel
Date: Fri, 27 Jun 2025 11:51:28 +0800
Message-Id: <20250627035129.2755537-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per SDM,

80000008H EAX Linear/Physical Address size.
              Bits 07-00: #Physical Address Bits*.
              Bits 15-08: #Linear Address Bits.
              Bits 31-16: Reserved = 0.
          EBX Bits 08-00: Reserved = 0.
              Bit 09: WBNOINVD is available if 1.
              Bits 31-10: Reserved = 0.
          ECX Reserved = 0.
          EDX Reserved = 0.

ECX/EDX in CPUID 0x80000008 leaf are reserved. Encode these 2 registers
as 0 for Intel.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d590a9af389..5d5a227d4c8a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8391,6 +8391,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
+
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *ecx = *edx = 0;
+            break;
+        }
+
         if (threads_per_pkg > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
-- 
2.34.1


