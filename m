Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CA0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOQ-0003VH-9K; Fri, 24 Oct 2025 02:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBON-0003Uk-RP
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:16 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOM-0003kG-1w
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287714; x=1792823714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J1ZCUKwfTEEbJGJiWsUOSMTCasUamsf1kDC1iuV9N+A=;
 b=noVzHKXW61QqyDG98KPjWet6GuRDKvqFRJ7HiJEJCllLegSsjSDBzxsn
 DDiWcBEt0SQUFiXqN2xfR99V2mEBw57GVHZyarABfcTe8lsTevTY7WMw6
 8vr5b8ZHoXHc/BRcRds+m/WDKzjqASymRBeN14fBU2URFCbpm9N6jT/xf
 fQ8eWlOkueWq28Ya2Ru5JMrcOpRSOm82ejt0fLnxbpL4qf+NWKZEymQLi
 2CnhCJ+zsVW7Fkw4CvZgl67WAHTpaSTCWAc0iPHPtgl6BV+t/Z4idzLBO
 PRV+bPm8w/PhYMdWlP9RhiEBGqmPFdfid8C0tlm2k+FzmPdpxB/CtDUEX A==;
X-CSE-ConnectionGUID: aA0kSKw1REeIAqG8ZrYb2A==
X-CSE-MsgGUID: yMlAYASBRw+jZfJ0VacySw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137888"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137888"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:13 -0700
X-CSE-ConnectionGUID: nKAAY43bRoCSRywEKzFVvA==
X-CSE-MsgGUID: nVLkiWPbQ++CaQKbs7y7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276057"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:10 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 09/20] i386/cpu: Fix supervisor xstate initialization
Date: Fri, 24 Oct 2025 14:56:21 +0800
Message-Id: <20251024065632.1448606-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

From: Chao Gao <chao.gao@intel.com>

Arch lbr is a supervisor xstate, but its area is not covered in
x86_cpu_init_xsave().

Fix it by checking supported xss bitmap.

In addition, drop the (uint64_t) type casts for supported_xcr0 since
x86_cpu_get_supported_feature_word() returns uint64_t so that the cast
is not needed. Then ensure line length is within 90 characters.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5cd335bb5574..1917376dbea9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9707,20 +9707,23 @@ static void x86_cpu_post_initfn(Object *obj)
 static void x86_cpu_init_xsave(void)
 {
     static bool first = true;
-    uint64_t supported_xcr0;
+    uint64_t supported_xcr0, supported_xss;
     int i;
 
     if (first) {
         first = false;
 
         supported_xcr0 =
-            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) |
             x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
+        supported_xss =
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_HI) << 32 |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_LO);
 
         for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
             ExtSaveArea *esa = &x86_ext_save_areas[i];
 
-            if (!(supported_xcr0 & (1 << i))) {
+            if (!((supported_xcr0 | supported_xss) & (1 << i))) {
                 esa->size = 0;
             }
         }
-- 
2.34.1


