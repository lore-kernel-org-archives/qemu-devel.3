Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06A3C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrSG-0001bG-QM; Wed, 20 Mar 2024 04:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmrSF-0001b4-Jp
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:37:47 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmrSD-0006Xw-MH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923866; x=1742459866;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/WOtNChErkTECWXLaSZye7ujURhkRbblG95vN+VMjEs=;
 b=HjdUG/SZUWPiG/LwGValbbcuvjWBCMKitGOaCk8AfozU/e54hH8En2jd
 Y8PhZoz59NvYgvx7MyIRG7+95gKchArYlSflGQS2wDVVUMhzlDt2MjL+H
 GDowRSohDp2kzssd1TexNix9VltnNfKc/6SR60N0izXDFtPAQ9VskIiWx
 KZcITFEX6NAlbnrO+BRaaNj8ICnGEaZbnsef7XS6T+rqaNIRAgHiSa4GD
 PzQ57YhOa+w2y8XJDbEQuYG6vc8lClMdquA7fEGcqQqVFDqnHFDsBJ/tW
 Ghv6XCIdlch8BuIKwFfF4D0xZE9u3SWv2eOmciTKBFwwalnAfqj/iI611 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9603567"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="9603567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="14059640"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmviesa007.fm.intel.com with ESMTP; 20 Mar 2024 01:37:41 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, alex.bennee@linaro.org,
 armbru@redhat.com, philmd@linaro.org, tao1.su@linux.intel.com
Subject: [PATCH v2] target/i386: Revert monitor_puts() in do_inject_x86_mce()
Date: Wed, 20 Mar 2024 16:36:40 +0800
Message-Id: <20240320083640.523287-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
may have a parameter with NULL monitor pointer. Revert monitor_puts() in
do_inject_x86_mce() to fix, then the fact that we send the same message to
monitor and log is again more obvious.

Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
v1 -> v2:
- Instead revert the broken part of commit bf0c50d4aa85
- Add Markus's Reviewed-by

v1:
- https://lore.kernel.org/all/20240320052118.520378-1-tao1.su@linux.intel.com/
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda..23ccb23a5b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -430,7 +430,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_puts(params->mon, msg);
+            monitor_printf(params->mon, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;

base-commit: c62d54d0a8067ffb3d5b909276f7296d7df33fa7
-- 
2.34.1


