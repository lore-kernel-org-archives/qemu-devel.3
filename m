Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08E2CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIrV-0002J1-8Z; Tue, 04 Nov 2025 10:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vGIrT-0002II-Ih
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:22:19 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vGIrR-0003vj-Pv
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:22:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2864F40A0A;
 Tue,  4 Nov 2025 15:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B0C4CEF7;
 Tue,  4 Nov 2025 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762269728;
 bh=qpAE7aEwyOXjwujHIMgxpbGtuCMrDNVg/+LUl9cBs7o=;
 h=From:To:Cc:Subject:Date:From;
 b=mwaK9RZrJBwdqjnnPBhWehb1zkUPStgbS5egYj8+Y/1t1r9lDo6p9zuxzvc8ziwsD
 RSql2PXY7gsx0YcqRKuQi9iGT2ktK+dsBrrf6KldXvWaCP/Z1gph59Eq6u9eIJ7HzF
 5dBcQEVGdbOx6a4z0m4LGbBYa8hkEpf5sJU14NNQviP4MPiwQVRDtTLcXSPtTyfj+F
 ZHHVdm93prW4djCH8tN+N4IZPNgpUJd8kh8mDSsf+gqSml0WTRuVpXCLor2HfnbMFn
 6H0NktumnjpT4/lgLZdcCWtR1gbecxWKtGfUJvn/xU96tTy4kI+LPo0/vK7hai+ELz
 c4NDayxLeSZlw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PULL v2 0/3] I82596 fixes patches
Date: Tue,  4 Nov 2025 16:22:01 +0100
Message-ID: <20251104152204.6261-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/i82596-fixes-pull-request

for you to fetch changes up to fec69f17be25db71f9cd4001b920da21cc71b283:

  i82596: Implement enhanced TX/RX with packet queuing and filtering (2025-11-04 16:14:51 +0100)

----------------------------------------------------------------
LASI i82596 network driver fixes

As part of the Google Summer of Code 2025 program "Implementing LASI Network
Card and NCR 710 SCSI Controller Device Models" Soumyajyotii Ssarkar fixed
various bugs and enhanced the existing Qemu i82596 network card implementation.

Specifically he added or fixed the following functionality:
- Monitor Mode
- Promiscuous Mode
- Support for linear mode, segmented mode, and flexible memory models
- RX Timer
- Bus Throttle Timers
- Support for Little Endian mode
- Accurate CU and RU transition State
- HP-UX Specific Behavior Support
    - Support for Loopback mode
    - Self test
- Statistical counters
- VMstate descriptors
- Polling mechanism
- Transmit and Receive functions

----------------------------------------------------------------

Helge Deller (1):
  hw/hppa: Enable LASI i82596 network on 715 machine

Soumyajyotii Ssarkar (2):
  i82596: Added core infrastructure and helper functions
  i82596: Implement enhanced TX/RX with packet queuing and filtering

 hw/hppa/hppa_hardware.h     |   10 +-
 hw/hppa/machine.c           |   31 +-
 hw/net/i82596.c             | 2405 ++++++++++++++++++++++++++++-------
 hw/net/i82596.h             |   74 +-
 hw/net/lasi_i82596.c        |   36 +-
 hw/net/trace-events         |   21 +-
 include/hw/net/lasi_82596.h |    3 -
 7 files changed, 2032 insertions(+), 548 deletions(-)

-- 
2.51.0


