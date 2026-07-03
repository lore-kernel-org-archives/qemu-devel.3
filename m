Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2643C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcRN-0006JB-3n; Fri, 03 Jul 2026 07:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyanarayana.k.v.p@intel.com>)
 id 1wfbqi-0006gr-5O
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:14:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyanarayana.k.v.p@intel.com>)
 id 1wfbqg-0002t6-1T
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783077262; x=1814613262;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZKfIxYQti1WS/IDqULSbkg2O2brPXjxef2q2l8htSRA=;
 b=HogG21ozX6gnQFULASdGQNg9ckPbh4uUdgBpPMF63Q1r7KX9C8PuFnCr
 I8wt15N5oADc/krxJfquUkIYpcL0NkJ+in2aaKS0tn6eRkby4dOkNIix6
 It/Zwn4DzZoekKfuUv9xSV3feQyh4/iy8wwU1lGIBzhe7XjuBtMGFhv2E
 Mmxa0R8POr5UYCTqUzV4YqkRxONVZ6NkgwzLbx6+dBHUCHNs0Fkq3YnDT
 SNYiLn7H/Aha/H4Vf/ZWJcmviikFyUh/LlofjhMW64omq+NulL+323JWl
 mJVsfLqXjrjkpYZAEJjGmo3A2H5Ms5QEMAvYFGkwzq76qK5leqUGSikCo g==;
X-CSE-ConnectionGUID: B2o/niUASyeSK6Kzl+YmdA==
X-CSE-MsgGUID: fvSnNNxuT4+2OAqzlmKafA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101251106"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101251106"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:14:17 -0700
X-CSE-ConnectionGUID: ObvxjxJRR3yXuoGASiCoVw==
X-CSE-MsgGUID: DAyF4tLCRfyOtJA5Z2B0iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="283181177"
Received: from gsd-build.iind.intel.com ([10.190.229.141])
 by orviesa002.jf.intel.com with ESMTP; 03 Jul 2026 04:14:15 -0700
From: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
To: qemu-devel@nongnu.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC 0/1] Forward AER errors to guest
Date: Fri,  3 Jul 2026 11:13:58 +0000
Message-ID: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=satyanarayana.k.v.p@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:52:13 -0400
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

Today, vfio-pci unconditionally stops the VM when any error event is
reported by device. This prevents guest-driven error handling and recovery
for platforms that support PCIe AER.

This series adds an optional vfio-pci extension parameter,
"x-forward-aer=on", to forward AER errors to the guest instead of
forcing an immediate VM stop. If the endpoint supports AER, the error is
forwarded directly; otherwise, checks the upstream PCIe bridge and
forwards the error there when supported.If neither device nor PCIe bridge
supports AER, the VM is immediately stopped when the error is reported.

Requesting for comments from vfio maintainers and AER experts for this
patch series.

Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>

Satyanarayana K V P (1):
  vfio/pci: Forward AER errors to guest optionally

 hw/vfio/pci.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.h |  1 +
 2 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.43.0


