Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE95C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucM7I-0005Ts-Oz; Thu, 17 Jul 2025 06:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucM7F-0005QS-Sg
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:45:30 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucM7C-0002KQ-GC
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752749126; x=1784285126;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VuOHG4yfjhFfu2k1h5Oo2cZyNPDLb7qJELcmd/eZFmo=;
 b=Enln1eT+Ggnl+mn8FWN7+pjGGgjdq0hALC67UfnQB9ny92RGHC4ls3BO
 5MQCH5hVj04Hu4g/FH49MwNylv72zdonQNWkaVeUcVRN3yRE0o7oXy49q
 hl2jMvJb1CjwR1GeD71L8s7ztb5US9A+BZyLB+mppguplEno/LUxrqmN8
 4oOsvbNtlkyawd8aYnKyTf+cursXHQVpucAUtu1vHD1cW96Zm32Fm4+Jp
 TqoWg0DyFgLZCcfxXrvTIUmIWsLU0Lx0veQgORFQrSCmM4Ia2ESCHrMdn
 U6nlHb4SWkrmm873qvVe/9q1pHP+WWsc5d2iM3kAv3QUwDFpxxXJaXFet w==;
X-CSE-ConnectionGUID: 0F7AWRrRRCuoufobyspCHg==
X-CSE-MsgGUID: L+zJTtUCSvanl4I0+PI6CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65588832"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="65588832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:45:23 -0700
X-CSE-ConnectionGUID: 271oVsK9Qf++Cd+/5MAf3Q==
X-CSE-MsgGUID: DDOP5Q0rQgmSH7/6mzcSHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="194896788"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa001.jf.intel.com with ESMTP; 17 Jul 2025 03:45:21 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)
Date: Thu, 17 Jul 2025 18:37:07 +0800
Message-ID: <20250717103707.688929-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>") added
redundant qemu_mutex_init(&tdx->lock) in tdx_guest_init by mistake.

Fix it by removing the redundant one.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7d69d6d7b066..107058ed794c 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1523,8 +1523,6 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_set_qgs,
                             NULL, NULL);
 
-    qemu_mutex_init(&tdx->lock);
-
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
 }
-- 
2.43.0


