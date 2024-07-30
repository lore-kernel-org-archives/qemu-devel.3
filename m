Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeen-0002cb-Oi; Tue, 30 Jul 2024 00:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeem-0002Wh-9v
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:16 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeek-0006Bm-Jl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722314415; x=1753850415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y0+ZveYI45DAfzdpujWTiwJ4SUqNeCrezwMTY5sy5OM=;
 b=WWhqK24dwIE/nSUR4EXIGhSXzuzTB6Eih0lZwqYDt7Q5NYGj1pYl0pd/
 JBd8mJ9CIdODQYbBgYFtcVnDsHd3b0Zw4fDMizjysb/kVubMJmgRYdNPu
 RaUOv354vMBVxvWCqbNM5P1UZIE9PsDEu5De1Jy1MfyUas/pP8PEvTH6Q
 xHE+TtK3CyXVm9XISKPOrDSwH92fpH0XCINy2L7NVfu6jeRAgnkjPa97J
 O+MjJKMJXoJdgf78879XAl85g33L2+kqPWosGpl8OhAT4bVQAJ0YNNCUC
 kudcwuUBzdkOBgiE2IOufPs5QG9MvLAMmMrv61m5bdQpMfcYOBIrpXOy+ Q==;
X-CSE-ConnectionGUID: h2/8yhazRdGEKfOFWDYyww==
X-CSE-MsgGUID: /G/UY8gGR22IDHM68ufAqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20288553"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="20288553"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 21:40:13 -0700
X-CSE-ConnectionGUID: ihovqMzlTq6WKRIyWjTBXg==
X-CSE-MsgGUID: o2KKnGPPROeRXJ4eG9oDdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="77429930"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 21:40:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/4] target/i386/cpu: Add dependencies of CPUID 0x12 leaves
Date: Tue, 30 Jul 2024 12:55:43 +0800
Message-Id: <20240730045544.2516284-4-zhao1.liu@intel.com>
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

As SDM stated, CPUID 0x12 leaves depend on CPUID_7_0_EBX_SGX (SGX
feature word).

Since FEAT_SGX_12_0_EAX, FEAT_SGX_12_0_EBX and FEAT_SGX_12_1_EAX define
multiple feature words, add the dependencies of those registers to
report the warning to user if SGX is absent.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a6d0b05ce27..7f55e9ba3ed8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1734,6 +1734,18 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
     },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EAX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EBX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_1_EAX,          ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.34.1


