Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EBCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwK-0000rn-1x; Tue, 12 May 2026 04:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwH-0000qA-QO
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:05 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwE-0007Qz-Qc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576283; x=1810112283;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QloAWZCgGtjUbFDAb9OoG/a5TBb4uqzcnccSxMzJzJM=;
 b=I0qGftvGSUa5GF/w0OwbvYR9AXuSh50ohI6ig3GLVMCAcm8pYAF67EVR
 PSo/qB6r+1i5oPKuBlzp43buVukEwn+aymlz+tdPq8Aj5WviTDStOSkKF
 ab/xRZ2B30fm765PnZ3gfAB2Fez4vhVKnpw1k4Dc7rR1J99qDgG6Y77zx
 phZ5Ae14uT/HuEbjzlp0tUgkdWHarGSAKcTx7miXu433Aqti0Su9rcRXX
 82Axv16eghBP6q8rcp/lx6C92XH9ACP733AXoEepULt42oLF6ZWUQZBJv
 BrntqkmIIDmCOEb8y1xgiFWxuqIhPI7kGKumXdDUfjygzZnj/9LfPqvvR g==;
X-CSE-ConnectionGUID: SULtBIIfTuuGqXFavFLZEQ==
X-CSE-MsgGUID: donFTuQpSHSb1ju8xkazNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510916"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:00 -0700
X-CSE-ConnectionGUID: vpuoiowlSNGfqq+uWG9vAw==
X-CSE-MsgGUID: pOYLaTjzTJCBTbW5uN4E7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065446"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:57:58 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 0/5] qemu-options cleanup and deprecate memory-encryption
Date: Tue, 12 May 2026 16:44:53 +0800
Message-ID: <20260512084458.622465-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the v2 of previous "[PATCH 0/5] qemu-optios: Fix, cleanup and
add description of tdx-guest"[1] (Sorry that long time went)

Patch 1 in previous v1 is dropped because a similar patch has been
merged already.

Patch 5 to deprecate memory-encryption is added in this v2, following
Daniel's suggestion.


- v1 [1]
https://lore.kernel.org/qemu-devel/20250714091953.448226-1-xiaoyao.li@intel.com/

Xiaoyao Li (5):
  i386/sev: Remove the example that references memory-encryption
  qemu-options: Change memory-encryption to confidential-guest-support
    in the example
  qemu-options: Add confidential-guest-support to machine options
  qemu-options: Add description of tdx-guest object
  machine: Deprecate memory-encryption

 docs/about/deprecated.rst |  7 ++++++
 hw/core/machine.c         |  2 ++
 qemu-options.hx           | 52 ++++++++++++++++++++++++++++++++++++---
 target/i386/sev.c         |  4 ---
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.43.0


