Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B1FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 12:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGGEV-0000em-OM; Sat, 17 May 2025 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uGGE2-0008U7-Nl
 for qemu-devel@nongnu.org; Sat, 17 May 2025 08:01:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uGGDy-0002i6-7S
 for qemu-devel@nongnu.org; Sat, 17 May 2025 08:01:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D82DE61127;
 Sat, 17 May 2025 12:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504ACC4CEE3;
 Sat, 17 May 2025 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747483256;
 bh=oQJzqjRDH4RAx/FaY+Jll8MvdUs5+lnRN1+SXC1BRmA=;
 h=From:To:Cc:Subject:Date:From;
 b=nIM97X690ifWvbXuQFuBrL2ZBhKGKExNfwimalyd3WNJ/SD1oclz9GZ0TVdoiim8U
 Y1tHmx2dVozx/SDM1kTw5WIVdlEleVPmz3o1CrEP8k7hAAoYz+JRElTmEPr8+S0ln/
 ZP6fl1thtwA7lpL3FlOphV15t/uFTcE62ngdkvrik0Aeqhy1d33/4cpWRo/Mta91uB
 gBhjlQd8qhjUwVAMpGxou89GZDq1J+iTE+vtAP619/IGPO9UgR8E3EnY+337WHPwmq
 /i0EYUTPYsOxmgBEtRvCHHKSReb4I732EYewemS2eZmxwXlzovN55gKWNGo+bCNV5O
 gr3Y7RFj0aMrg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/3] target/hppa: Fix FP exception handling
Date: Sat, 17 May 2025 14:00:50 +0200
Message-ID: <20250517120053.18231-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
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

This series fixes and improves the floating point exception
handling in the hppa system and user emulation.
A testcase is included in patch #3.

Please review.

Thanks!
Helge

Helge Deller (3):
  target/hppa: Copy instruction code into fr1 on FPU assist fault
  linux-user/hppa: Send proper si_code on SIGFPE exception
  target/hppa: Fix FPE exceptions

 linux-user/hppa/cpu_loop.c | 12 ++++++++++--
 target/hppa/fpu_helper.c   | 20 +++++++++++++++++---
 target/hppa/int_helper.c   |  4 ++++
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.47.0


