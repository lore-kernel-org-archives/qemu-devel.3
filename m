Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC7CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuUQ-0004HF-D3; Mon, 03 Nov 2025 08:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUJ-0004EH-4f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:49 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUD-0001Qq-0a
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 00D50435C0;
 Mon,  3 Nov 2025 13:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923EAC4CEFD;
 Mon,  3 Nov 2025 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762176032;
 bh=CawX4ik8Bhya9t3zpvrSttFPhAgtnhgBkjLTSGZMavk=;
 h=From:To:Cc:Subject:Date:From;
 b=sUY8lk/G7HsPLWRw/G1f6eM9YQTnSh0Tf+XFXJr1V2tkw6yqRczWmDvNkJ/UaXuAs
 GYd9zeraVq5YVyHKH0WWv7dOhRhCP6PfgiPlJZyaTRcLmYqaxygcY3lg+KS6EqRBtc
 3LJJI4sTLLlzVvlO9SeGy1Ch8PmNY/IKmfmzwVufqtmr+Z7KnAkAODwVv7XvBEiJwS
 +wrk32/l7+87HS0VKYgL75PFtsTECbWZT+qLR/yLf/uSglNgoISC2JYmsFEcN4yjRu
 ZRYNTmdedMD8ov4RKU+N91Min0ePQRPJCcxjFMEKd+rwHQKPcn7d86BzdPxYoMcr4p
 7Eefgw2PC3aAQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 0/3] I82596 fixes patches
Date: Mon,  3 Nov 2025 14:20:26 +0100
Message-ID: <20251103132029.6725-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

for you to fetch changes up to 6a82662c85f44a4e5b3b4ae5f337153362b91745:

  i82596: Implement enhanced TX/RX with packet queuing and filtering (2025-11-03 14:11:07 +0100)

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


