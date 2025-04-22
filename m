Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5DC369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7CzO-0003ke-2F; Tue, 22 Apr 2025 08:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7CzM-0003kQ-44
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:44:36 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7CzJ-0006VO-4M
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745325873; x=1776861873;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OGdk2wixwiHcld1ewNhCa/Zt4jRPS3cog4lVI4dKSbw=;
 b=PIIx5uX2Uvk7slBei+Co96GG5csUKI3LtTlKVryrVnR9ihiRpZiuQcTz
 cSo56RPU0guyCDS8cNL9IIrYUspIEulLjXMmG4ZQM6RVrOpxeQCALfhAq
 AO40Nen/nbkBLUgrnz1OTpi2K/GVSudm8yAlLqvsDBbBjPUFuWNsnGBG8
 fo9u8ebor/p5+SD6rhsrkzv0R6pYhtjAvx6mehUxDtyo8nIuU1r+btGXX
 BUi3YY6Cdw3uoe2SYb/PZN2ymuK59VuzZDao58bEAFyaFXIZgvNNTyg9A
 mZapgUjV84opvyuJmjaHZuMRNyLXyc6fCXLjR0Qk/tUssjIk+ITTeWRCX w==;
X-CSE-ConnectionGUID: YwIOPTCaSj2ELZIj7NWuAw==
X-CSE-MsgGUID: REYMVawFQq6bHmQwcOCrkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46587933"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46587933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 05:44:29 -0700
X-CSE-ConnectionGUID: U8i0i8WLT8W91239iDn/zQ==
X-CSE-MsgGUID: jhZxjgTZSxuD4dptvUEqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131916229"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 22 Apr 2025 05:44:28 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] tests/qtest: Pass down do_connect param in
 qtest_init_with_env()
Date: Tue, 22 Apr 2025 08:04:20 -0400
Message-Id: <20250422120420.3068159-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

The @do_connect parameter of qtest_init_with_env() is not used. Fix it
by passing it down to qtest_init_with_env_and_capabilities() instead of
hard coding a true.

Fixes: 5357ef823a1f ("tests/qtest: defer connection")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tests/qtest/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index fad307d125aa..518710909c3e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -597,7 +597,7 @@ QTestState *qtest_init_with_env_and_capabilities(const char *var,
 QTestState *qtest_init_with_env(const char *var, const char *extra_args,
                                 bool do_connect)
 {
-    return qtest_init_with_env_and_capabilities(var, extra_args, NULL, true);
+    return qtest_init_with_env_and_capabilities(var, extra_args, NULL, do_connect);
 }
 
 QTestState *qtest_init(const char *extra_args)
-- 
2.34.1


