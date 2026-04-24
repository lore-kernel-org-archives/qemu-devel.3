Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416CAFE521D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGFSI-0002Zo-LR; Fri, 24 Apr 2026 08:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFS0-0002WA-5d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:09 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFRx-0002Ba-KC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777032961; x=1808568961;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0bAUA6abi1M7sQpo2yAtJklfJJMcJmkICMcIRGpxe18=;
 b=hlL/Ypw2fFCyQ2AnogcMmYKItYQC4WRVn25jvLf/+yOYJwWXsM0Anofo
 COcz77NLgMpTdTtJ+VpK8mPKFxVAevwsgxn34gHE5DSbn2RYwVR203cqg
 +gd+V2ZsJuuLrhawpQXG9l4oz/b0Ed4LfN31KKstNB8RmAkCTsa72FzzO
 wqkecsfcSocJElaf7ENhJoh6pVvTUGiilO2ynRtDGsBwz1Y0oZZtYVqTi
 jwAppai/N9JrwORLjIWe7JT5x6xR/DIX8hk1QZ+4AvSsxXX77lpVGygJZ
 DqQthGF6W5ti2fixT15Xko1pq/ToKJskjyRIOltRpwKB+Hljclu+XA+3T A==;
X-CSE-ConnectionGUID: MaCwuLRLQqiye/6xxjkDdQ==
X-CSE-MsgGUID: XdePhQmmTAu0iPCkMkmlsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78029972"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="78029972"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 05:15:57 -0700
X-CSE-ConnectionGUID: 007NdqGXQwCI7ZUMndmVkg==
X-CSE-MsgGUID: iHuhxzKFRneswVZowg3nhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="237935749"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:15:55 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 zhenzhong.duan@intel.com
Subject: [PATCH v2 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
Date: Sat, 25 Apr 2026 04:18:40 +0800
Message-ID: <20260424201842.176953-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

An 8-byte guest access to any 32-bit-only VT-d register hits
assert(size == 4) and aborts QEMU.  Found by fuzzing with
generic-fuzz; 24 distinct crash inputs all share the same root cause.

v1: https://lore.kernel.org/all/20260420170523.17908-1-junjie.cao@intel.com/
v2: Per Philippe's suggestion, widen .impl.min_access_size to 8
instead of replacing asserts with guest-error checks.  This lets the
memory subsystem always pass size == 8 to the handler, eliminating
all 25 asserts and every size-based branch.

Junjie Cao (2):
  intel_iommu: widen impl.min_access_size to 8 to fix MMIO abort
  tests/qtest: add 8-byte MMIO access sweep for intel-iommu

 hw/i386/intel_iommu.c          | 121 +++++++--------------------------
 tests/qtest/intel-iommu-test.c |  30 ++++++++
 2 files changed, 53 insertions(+), 98 deletions(-)

-- 
2.43.0


