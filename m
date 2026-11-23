Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B375606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=llhpnvyv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQLx-0003Xu-HN; Mon, 23 Nov 2026 04:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVQLu-0003Xm-NP
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:28:46 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xVQLt-0006pf-6R
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795426125; x=1826962125;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P5sRI9KpQSyoYjtjJj7vRtRjc+64m0A+2sx+dDTj/24=;
 b=llhpnvyvpFffi9X/kRfH9TaslqfOoe9tLpHb6qf5GIFKKYHSwj7FWbHZ
 gSXSaJAHY6qJdB1VtQy2wsT2qX2+TE+N+8NP2eMPUWr4I6u8VBZFzd5j1
 8d51XsCmqVChpBDrtWLcyI9eac1BC8d5RDNQ9YwtZSFBVmP+E+OsgBf18
 DJT0KXqlBn5kMMVM8OE5GvPAAA0CAFPZ2gVNFqevza4ceyJk33kOUA2a8
 hAaKHezRIIY0xbwMmU/D0lAnX55YpqmecQVijBpjSpgtds6Ym8zmemi4F
 v/xo2prbA4w2Ee21cWnNuVq00nb6D8/2xChuBNpqAGNFkQrqZ8bQj/2ee Q==;
X-CSE-ConnectionGUID: 1UnlF9mGQpSHn3wEGsKwGg==
X-CSE-MsgGUID: zzoVba1+TQWbu7fGtWcb+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4127895"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4127895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:28:42 -0800
X-CSE-ConnectionGUID: /GPtUzWwSa+AWmlKLBLCnw==
X-CSE-MsgGUID: pCAHQQ6rQZyyFrqZC5VDzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11125857"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:28:33 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] git: Fix broken relative symlinks for Claude and Gemini skills
Date: Mon, 23 Nov 2026 17:28:17 +0800
Message-ID: <20261123092817.1237214-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the relative symlink targets for both ".claude/skills" and
".gemini/skills" from ".agents/skills/" to "../.agents/skills".

Fixes: 3e9fe057ae0b ("agents: Add a skill for finding your way around QEMU")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 .claude/skills | 2 +-
 .gemini/skills | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.claude/skills b/.claude/skills
index a7540c2442..2b7a412b8f 120000
--- a/.claude/skills
+++ b/.claude/skills
@@ -1 +1 @@
-.agents/skills/
\ No newline at end of file
+../.agents/skills
\ No newline at end of file
diff --git a/.gemini/skills b/.gemini/skills
index a7540c2442..2b7a412b8f 120000
--- a/.gemini/skills
+++ b/.gemini/skills
@@ -1 +1 @@
-.agents/skills/
\ No newline at end of file
+../.agents/skills
\ No newline at end of file
-- 
2.52.0


