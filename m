Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1874FC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeem-0002V5-3n; Tue, 30 Jul 2024 00:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeek-0002PO-G4
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:14 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeei-0006BM-V3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722314413; x=1753850413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9eRZFeah8dznjRAUrRvArWMs0YEBaH6rJfloDBnonuU=;
 b=V0sjimOod7w6TwK6FJlv11ZAovxMo4LXuz+ctpqjHwgAXBaX7nCKwoYb
 gBMo6PSAttwT3fRza+zlo7xvsNGDq47g35u77iqOWFZotLqPFyPFvQKwo
 d+plqKvWP3xJhSgAxxad96W8KVzjmqAgYvVW1z3hF3y7+ElCHrhBTFSs6
 +/Dc1lkDVWBX+XgMLRQLv9kH6lJBnCzQjg5znXMEUiZN47MOeyxOJviI7
 8w1/RNmEHOfRjs/W/QQj/iOvhQuOQmY4k+cs0NO6bsZG6mbk3uBc82CaW
 5zHXj0SVVUS9OoHu/ch5F/xCH/zD88WgOzMDhY98yZ/me5CimwosDPsg/ g==;
X-CSE-ConnectionGUID: i0SpAIGSS9KG6OpKjc9PWg==
X-CSE-MsgGUID: BYVtEqEKR3yyIAAGSSOWgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20288547"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="20288547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 21:40:11 -0700
X-CSE-ConnectionGUID: VHosnQHPTHi03+9n6dEgCg==
X-CSE-MsgGUID: wRZYjRe0QAed3qN+9PQKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="77429923"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 21:40:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/4] target/i386/cpu: Explicitly express SGX_LC and SGX
 feature words dependency
Date: Tue, 30 Jul 2024 12:55:42 +0800
Message-Id: <20240730045544.2516284-3-zhao1.liu@intel.com>
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

At present, cpu_x86_cpuid() silently masks off SGX_LC if SGX is absent.

This is not proper because the user is not told about the dependency
between the two.

So explicitly define the dependency between SGX_LC and SGX feature
words, so that user could get a warning when SGX_LC is enabled but
SGX is absent.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2b3642c9b13c..7a6d0b05ce27 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1730,6 +1730,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
         .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
     },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -6545,11 +6549,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 *ecx |= CPUID_7_0_ECX_OSPKE;
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
-
-            if ((*ecx & CPUID_7_0_ECX_SGX_LC)
-                    && (!(*ebx & CPUID_7_0_EBX_SGX))) {
-                *ecx &= ~CPUID_7_0_ECX_SGX_LC;
-            }
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
             *edx = env->features[FEAT_7_1_EDX];
-- 
2.34.1


