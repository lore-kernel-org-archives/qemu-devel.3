Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74DCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSvu-0007oH-Oz; Thu, 14 May 2026 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNSvs-0007nw-Mn
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:04:44 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNSvq-0004R6-SU
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778753083; x=1810289083;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=spfbICq9F1iwsyTEYXK/avZaHtL5lUyZ8ZC4bbOiwMI=;
 b=jDLOCxXfa0rXZHZLmgMLZaiZ+MusNK1gPcgjUZ9VB7eO1HXw4UqDDzLq
 M5v6/Cxr94Aj7wwzsL5jA5EaE5wqaBH5bjxUqd3HKMB3997dK7xT8DZMK
 zxK3kTIwHdsMUMFUmJVo3zTEY38Ut82JV9rSbf1mr9AakBmQH2sBTro0m
 6rsJEZ29N5XCKxtEcm2vAwJT78sJvKT7iQsL7MaMRXqQ4BbZpb1H7fj7+
 Q9a5lFiDWvu6YJBRuPb3vZ478kMu4SUdIepIvuBRlf96gspp7Jic0VVC9
 /I2U5kJjTm+0A/NdjAjX7YDUS98iMPXFKJrnt16L7BZaFL0ImBLaLvrYC w==;
X-CSE-ConnectionGUID: ag8BoZIRTg2NE4Sd+ndNwA==
X-CSE-MsgGUID: UyT35Jn0RJ6ECG3cw4h23g==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90796042"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90796042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 03:04:40 -0700
X-CSE-ConnectionGUID: 2ObFpi2DStCkaFBG23Y9Gw==
X-CSE-MsgGUID: Sp5D6MGsT6m2wOMnQzBJdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="243324913"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 03:04:35 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: zhenzhong.duan@intel.com, yi.l.liu@intel.com, philmd@linaro.org,
 mst@redhat.com, jasowang@redhat.com, clement.mathieu--drif@bull.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, farosas@suse.de, lvivier@redhat.com,
 Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH v4 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
Date: Fri, 15 May 2026 02:07:01 +0800
Message-ID: <20260514180703.85686-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

An 8-byte guest access to a 32-bit-only VT-d register hits
assert(size == 4) and aborts QEMU.  Found by generic-fuzz.

v1: https://lore.kernel.org/all/20260420170523.17908-1-junjie.cao@intel.com/
v2: https://lore.kernel.org/all/20260424201842.176953-1-junjie.cao@intel.com/
v3: https://lore.kernel.org/all/20260506031942.251335-1-junjie.cao@intel.com/

Changes in v4:
  - Switch the guest-error log from error_report_once() to
    qemu_log_mask(LOG_GUEST_ERROR, ...) so it is surfaced only
    under -d guest_errors (Zhenzhong).
  - Add a block comment at each of the 4 reachable sites
    (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0)
    explaining why the check must stay, so future readers do
    not delete it as "harmless" (Yi).
  - No functional change beyond the logging-API swap.

Changes in v3:
  - Drop v2's min_access_size=8 approach: per Zhenzhong, it
    silently zero-extends 4-byte guest writes, wiping upper
    wmask bits of 64-bit registers and firing triggers gated
    on size==8.
  - Keep min_access_size=4.  Remove the 25 assert(size == 4)
    sites: 21 are unreachable (non-8-aligned), the 4 reachable
    (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0) fall
    through to vtd_set_long() and log a guest error.

Junjie Cao (2):
  intel_iommu: fix guest-triggerable abort on oversized MMIO access
  tests/qtest: add 8-byte MMIO access sweep for intel-iommu

 hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++------------
 tests/qtest/intel-iommu-test.c | 30 ++++++++++++++
 2 files changed, 79 insertions(+), 25 deletions(-)


base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b
-- 
2.43.0


