Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAA3C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yr-0003wu-HF; Wed, 14 Aug 2024 04:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yK-0002pS-Sl
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xv-0007rt-Qz
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622563; x=1755158563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X3na6+L70Cfx64EUlxwZzmPxVDrsGV+622+OsmsswRI=;
 b=HW4H3ZAB1VCB86q2h+4iU+YAzXgoBS1ExjizY5WpL+5VhkfeZjnkLgyb
 3DquqIM4xbnCOQroa7IL3vDNDNeJrZUOAwIWunNUYI4IDx8XnrM3FZ4kX
 gcoNMN9NBwnzipE58h5a822+jk9doedXZWzxotrUMiiY3+11LL4XaXU4g
 Lm4rIzUnNO/4CMwEXV0c0hzrspUd4MkptvCPT1oN27IWmfp89t4PQILIF
 sdCve7WXRwtlgZ52YUHqItdGrbnxUhPkMECNFRMkuSgJkiUquAXh04HVT
 mHF9s5pwpPT3krIZ20ZQKxl8fcSOEeT+x/zD7kgxI46LILN9er1i+gcwU Q==;
X-CSE-ConnectionGUID: ZIlyPCHkQpmHZF/PSiBTSg==
X-CSE-MsgGUID: rK9YP794S8uAbpYltJXILg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584478"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584478"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:39 -0700
X-CSE-ConnectionGUID: BUEn6TXQQ9G9BU38uK4/2g==
X-CSE-MsgGUID: sSJofb4dTDqskubB5/BOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048952"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:37 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 4/9] i386/cpu: Construct valid CPUID leaf 5 iff
 CPUID_EXT_MONITOR
Date: Wed, 14 Aug 2024 03:54:26 -0400
Message-Id: <20240814075431.339209-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

When CPUID_EXT_MONITOR is not set, it means no support of MONITOR/MWAIT
leaf, i.e., CPUID leaf 5.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03376ccf3e75..5bee84333089 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6553,10 +6553,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 5:
         /* MONITOR/MWAIT Leaf */
-        *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
-        *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
-        *ecx = cpu->mwait.ecx; /* flags */
-        *edx = cpu->mwait.edx; /* mwait substates */
+        if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
+            *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
+            *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
+            *ecx = cpu->mwait.ecx; /* flags */
+            *edx = cpu->mwait.edx; /* mwait substates */
+        } else {
+            *eax = *ebx = *ecx = *edx = 0;
+        }
         break;
     case 6:
         /* Thermal and Power Leaf */
-- 
2.34.1


