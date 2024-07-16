Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2773C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbvq-0006JC-SS; Tue, 16 Jul 2024 02:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTbvn-0006Hz-WF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:45:00 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTbvl-0006MB-NX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721112298; x=1752648298;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zyW61cnkfWfTmVlDKXApgd62xeMGyXleZUcSfIula40=;
 b=RYQaCT+6gQ+78HqHnMCnz7xhubEbeXn6yxTlooEsc2dUpFwqvOqxKqsV
 A+dV1kvESGpw6t5+Zsbnc0KETaYxhzBbpp7FKXcdeap3T4mCgkR9eh3X/
 op105qXAUrRMCUs+YNt1Flr47yOU+KlpFeQ5nKTE82GLTGXjEy3XNAoFe
 6riwcBR56xX9trYH7N2euP85oQC2BWoD1qnBFOTY6nHRRax/ip0e6ukWv
 rS9sivC7bMib1I5K2ACVLoi22YIZp4/gD+tL1+o9iKI67OZBb2Rm57JWl
 pRC/0QBtQxiN+kVYGq+IkhgJ2239+jWnN/3UeLZViApwpibKd8utzqncz g==;
X-CSE-ConnectionGUID: 9Q801fXvTneV6tKnY7u1vQ==
X-CSE-MsgGUID: kMOLznKKTDiGtcWnpIXD4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18642565"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="18642565"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 23:44:53 -0700
X-CSE-ConnectionGUID: ne3RG43aQBa7gvGrAmMGHQ==
X-CSE-MsgGUID: Ig4rPgF9QzqtEAhstUZ1IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49783572"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 23:44:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] RAMBlock: use return value of ram_block_discard_require() as
 errno
Date: Tue, 16 Jul 2024 14:42:12 +0800
Message-Id: <20240716064213.290696-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When ram_block_discard_require() fails, errno is passed to error_setg_errno().
It's a stale value or 0 which is unrelated to ram_block_discard_require().

As ram_block_discard_require() already returns -EBUSY in failure case,
use it as errno for error_setg_errno().

Fixes: 852f0048f3ea ("make guest_memfd require uncoordinated discard")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 system/physmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 2154432cb6..9a3b3a7636 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1845,11 +1845,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     }
 
     if (new_block->flags & RAM_GUEST_MEMFD) {
+        int ret;
+
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
-        if (ram_block_discard_require(true) < 0) {
-            error_setg_errno(errp, errno,
+        ret = ram_block_discard_require(true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
             error_append_hint(errp, "Are you using assigned devices?\n");
             goto out_free;
-- 
2.34.1


