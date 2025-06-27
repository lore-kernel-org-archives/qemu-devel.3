Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5936DC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 06:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV2iW-00041h-F7; Fri, 27 Jun 2025 02:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2iU-00040P-IK; Fri, 27 Jun 2025 02:37:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2iK-0004FY-Vh; Fri, 27 Jun 2025 02:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751006253; x=1782542253;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=02n+ln4ZAVekoLispeAc9CR+frqW6AI6cRuTmz8wIP4=;
 b=S7c5M+ix2TekSEE05ePwblfazav+vgOo/gyMBLmRmMSSfcMPlMNfkw5C
 6C8/ZSF+pTCISx+/6RbyeoykkN0M8O0+WVEwnwuJDihW0Fnq8YgAhNZnW
 n5qqU7oAnM7uSwLpsp6uNS+z6VoFSKlgpdBHsv9jw32UADs5175h/lVFR
 FuvkXdOMQf4kqn1ayDJjS9jUOTE24cHAMlHD3nTB6dvRUYuXUt2KcCvrs
 vyTP44/qXo88L6FxFar85UlYLTBOUeIXuGXh0LM+6g4E9DFRz7W7B7zEX
 0DBbBngSe2LKKfpd9mM77KXyBKmTwZW1CYHxVqQizgb6yaLdRDiQ0cmkJ Q==;
X-CSE-ConnectionGUID: j390e9InQRCdMA7I81i7VA==
X-CSE-MsgGUID: NTefJXMYR1G67cdTzXqQJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="40931458"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="40931458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:26 -0700
X-CSE-ConnectionGUID: Tg55MPK/RPKrSfrbmv0yhQ==
X-CSE-MsgGUID: l1fvF24hS86WUKQL/bwYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="153438091"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org (open list:Trivial patches)
Subject: [PATCH v2 0/2] Some trivial live update fixes
Date: Fri, 27 Jun 2025 14:33:30 +0800
Message-Id: <20250627063332.5173-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Hi

These are trivial VFIO live update fixes in corner cases.

1) potential SIGSEGV when unmap-all-vaddr failed
2) potential vfio_container_post_load failure

Thanks
Zhenzhong

Changelog:
v2:
- drop patch1,2 in v1 as they are merged
- squashed "local save" parts of patch3 into patch4 (Steve)
- s/DMA_MAP_FUNC/dma_map_fn (Steve)

Zhenzhong Duan (2):
  vfio/container: Fix potential SIGSEGV when recover from
    unmap-all-vaddr failure
  vfio/container: Fix vfio_container_post_load()

 include/hw/vfio/vfio-cpr.h |  7 ++++---
 hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
 2 files changed, 13 insertions(+), 17 deletions(-)

-- 
2.34.1


