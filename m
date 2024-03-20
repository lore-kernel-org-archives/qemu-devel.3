Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0708C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmoPM-0006ev-2y; Wed, 20 Mar 2024 01:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmoPE-0006eE-UI
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:22:29 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmoPA-0005XC-RJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710912145; x=1742448145;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sb6S0gu6bX+g4zYn5KsVQ5JSrF4XLUwqnq7hFTHlxx8=;
 b=H8ofP9ZVi290SnG7Gt25IWs0laJVnqKlzKoyva5bneFG2CVx+NPrfUbK
 IaZBDDFcNm8wTDZImIwzDT6DcZeeObtmXUyVJnB1XgIcTV66o1KCHlOdm
 lQqifJwXmtpXUNl9OE3emfDzI10OTqG4M72vmIZWZUdY5YUHpsmm4pnrO
 iiGmnZRmRjDpcfNKI1cWyh6rkBtf3ou3vqeajTDsAPWbmdsBf1h5FBnWi
 Lnjn37ostWAeHxHl62q5eOlfnezF3/eNMbbtAWW00p0S3oK9RnDV9YYVU
 LEwezzYbft4BWHpxYocLQdYQoEnt2kSAX0RDSUxAsbweoEvAi+kKFwBAh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23319328"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="23319328"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 22:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="45011898"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa002.jf.intel.com with ESMTP; 19 Mar 2024 22:22:18 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, alex.bennee@linaro.org,
 tao1.su@linux.intel.com
Subject: [PATCH] target/i386: Check NULL monitor pointer when injecting MCE
Date: Wed, 20 Mar 2024 13:21:18 +0800
Message-Id: <20240320052118.520378-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.8;
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
may have a parameter with NULL monitor pointer. Check the monitor pointer
before calling monitor_puts().

Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda..a9ff830a17 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -430,7 +430,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_puts(params->mon, msg);
+            if (params->mon)
+                monitor_puts(params->mon, msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
-- 
2.34.1


