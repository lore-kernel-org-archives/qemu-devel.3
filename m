Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB00DC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Jf-00081R-Vh; Wed, 26 Aug 2026 04:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wz9Je-00080o-HX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1wz9Jc-0001ZO-0n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ6cVHzcYn0Y;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGP4DjLzbQJxB;
 Wed, 26 Aug 2026 16:48:45 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTP2ef6ef4893586330462470398f1a50d3
 Wed, 26 Aug 2026 16:48:45 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v4 1/4] target/i386: Add cache model for Zhaoxin Shijidadao
 vCPUs
Date: Wed, 26 Aug 2026 16:48:35 +0800
Message-Id: <20260826084838.2107629-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhaoxin "Shijidadao" vCPUs require built-in cache enumeration in QEMU
to properly report CPUID leaf 0x4 and 0x80000005/0x80000006 when
'host-cache-info' is disabled.

This patch defines the L1/L2/L3 cache parameters for the Shijidadao
architecture, preparing for use in both client and server models.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d15..5408d851d1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3512,6 +3512,105 @@ static const CPUCaches yongfeng_cache_info = {
     },
 };
 
+static const CPUCaches shijidadao_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000005.ECX */
+        .lines_per_tag = 1,
+        .size = 32 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x1.EAX */
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x1.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000005.EDX */
+        .lines_per_tag = 1,
+        .size = 64 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x2.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .self_init = true,
+
+        /* CPUID 0x4.0x2.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 1024,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        /* CPUID 0x80000006.ECX */
+        .size = 512 * KiB,
+
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x3.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .self_init = true,
+
+        /* CPUID 0x4.0x3.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 32768,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = true,
+        .complex_indexing = false,
+
+        .size = 32 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
-- 
2.34.1



