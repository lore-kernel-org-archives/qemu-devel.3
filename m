Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC7E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNX5K-0000A1-5T; Tue, 17 Dec 2024 07:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5H-00009b-GS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:55 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5F-0005DQ-6g
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734440033; x=1765976033;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9k/m0mTKdFDTyLClgbunE6OdVwthgmh4AeguZdPXB1g=;
 b=gnCPwjx04zqqqRMhMGAWGN0C8fTViMjeCc/EFddfKBiObfVKa16hKfRU
 hhZK8kAe9IvHvtJkOVxwlZ/s41eiqykW4cHwEgBqnUuARwGl0U7AnrWoJ
 pKp+w91eLdiVzVm1FkoX1vietvjTgM1cEyEWwenlmMFmsh701AzqqyTWS
 nsf7eg5zaKqaf/v2WiGVaSJfzm+qtFOYP35MhN6cnC8I/C2Jh3B5mAKuO
 QsEQ3cdv3kRZSrg5P4pFeBDqfNZqrtSHOmBe2Zd7M6qhQ0CsaEXX6czu5
 sZODMT6q1+6i7fF8+wMTb72kS2fAi0xYjeaQBWVEWtyD3jZmOJ/Ux0Xlp w==;
X-CSE-ConnectionGUID: 3ewEgwXmRmSpGS1DKO+a9Q==
X-CSE-MsgGUID: WRNgHXYNScGZ3JI4mlHNuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34993234"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="34993234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 04:53:50 -0800
X-CSE-ConnectionGUID: TjtosO/ZRNWpqNDA9tw3aQ==
X-CSE-MsgGUID: 3X7IEfaTTHKHiMP3zrVnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="97760173"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 17 Dec 2024 04:53:49 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Clean up and enhance of feature_word_description()
Date: Tue, 17 Dec 2024 07:39:30 -0500
Message-Id: <20241217123932.948789-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This series grabs two patches related to feature_word_description() from
two different old threads, they are simple and straightforward. 

Patch 1 is grabbed from [1] while patch 2 is grabbed from [2].

[1]: https://lore.kernel.org/qemu-devel/20230106083826.5384-3-lei4.wang@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20220808085834.3227541-2-xiaoyao.li@intel.com/

Lei Wang (1):
  i386: Remove unused parameter "uint32_t bit" in
    feature_word_description()

Xiaoyao Li (1):
  target/i386: Print CPUID subleaf info for unsupported feature

 target/i386/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1


