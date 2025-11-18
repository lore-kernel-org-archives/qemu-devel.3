Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27451CEBF9A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCH7-0001OL-1Y; Mon, 17 Nov 2025 22:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGz-0001NR-EY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:53 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGx-0004Cz-Qv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436052; x=1794972052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FovsNeUNQb3Mbfo6UFh8WpHvsMB68L7Ws+8KaJE9y0g=;
 b=Pxrr1iw0b1+/xeE/YDHWf1KFkxXzobbVSDrX8Oqr9IR/LM3HDHvCwfA5
 MObrDBOMUqUJAL4JqvcQpUnljq5c7AslXAPWFiM3W1nxfQM53Vuax1xOl
 jvApm4+mip5NkWGYqxufW+Q0Fm5EmQFJ3AL/LIJCGm7QoLcHSk2viCfMn
 /2jKpxGfYT5UCt17WhqFA/HdoN+IKWCKAFETWcGwWt2CTox+zuZwm4PrQ
 5BK+vicL2Hfg8p0ZJ+Gjfzvzl4DkqUj513X/On88eBMVzpRwDu1jS4t6N
 yfQMfoRi0WOod7uyxWKcm8DXPEdFSj9rHQyL8cKAcNuqw1Q9l4gFRzDpn g==;
X-CSE-ConnectionGUID: pAysUjvcRPCNBQezdLNG3Q==
X-CSE-MsgGUID: ZGcS6X8WRY6PJy7TJn47jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053822"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053822"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:51 -0800
X-CSE-ConnectionGUID: jt3zLP1qQDOpCq+K7ZLdlg==
X-CSE-MsgGUID: xkS3xGu6QFSU7K/EdFT2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537198"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:48 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 10/23] i386/cpu: Fix supervisor xstate initialization
Date: Tue, 18 Nov 2025 11:42:18 +0800
Message-Id: <20251118034231.704240-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Fix shift for CXRO high 32 bits.
---
 target/i386/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 62769db3ebb7..859cb889a37c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9711,20 +9711,23 @@ static void x86_cpu_post_initfn(Object *obj)
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
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32 |
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


