Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6407BC4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPUt-0003VU-QE; Fri, 09 Feb 2024 06:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPUs-0003UF-GR
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPUq-0002On-Ry
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE85D6153B;
 Fri,  9 Feb 2024 11:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E9C433C7;
 Fri,  9 Feb 2024 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479796;
 bh=CRAhizHXgmBxKYA1z7YB/8lE3siLM2aru+2FUkC4VaY=;
 h=From:To:Cc:Subject:Date:From;
 b=tkMGhFzfd31kGWUOr3N/CqstNv0k1zMRLjllTHfRRtJEsS/pP+algmZP9KMJg/NNv
 h8wR9xNmAjAn4idJYTJFeButIcOhDsKx1CSxpOM9FEJo38qt/qS7130MjG3yaag2zx
 o4aX2pNY+EuDUQfnf9FyVLyeAmOdmWIPVN+JBfjzqALpmdH2pCUcuokGL5zfTDm+SC
 dPRZa2ommb4trLVVQO0fSTaMQr/LiEl5F6hiTXBLuS+U/Ck1o0WG1OO6DvpGYE26/D
 yCc476WxfmA/tb7DACsrAwkV1+oE2xVqYWE0Gl6SgpMxiMrKG2125w97rR532CeVnw
 3yMaxr1Xg2yTA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 00/12] target/hppa: Enhancements and fixes
Date: Fri,  9 Feb 2024 12:56:21 +0100
Message-ID: <20240209115633.55823-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some enhancements and fixes for the hppa target.

The major change is, that this patchset adds a new SeaBIOS-hppa firmware
which is built as 32- and 64-bit firmware.
The new 64-bit firmware is necessary to fully support 64-bit operating systems
(HP-UX, Linux, NetBSD,...).

v2:
- included all suggested changes from Richard
- dropped mtsm/rsm/ssm patch
- include tulip patch from Sven Schnelle
- dropped SeaBIOS binary files in v2 review series, will be included in final pull request

Patches 2,3,5,6,7 still miss a review.

Helge

Helge Deller (11):
  disas/hppa: Add disassembly for qemu specific instructions
  target/hppa: Add "diag 0x101" for console output support
  hw/pci-host/astro: Avoid aborting on access failure
  hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
  lasi: allow access to LAN MAC address registers
  target/hppa: Implement do_transaction_failed handler for I/O errors
  lasi: Add reset I/O ports for LASI audio and FDC
  target/hppa: Allow read-access to PSW with rsm 0,reg instruction
  target/hppa: PDC_BTLB_INFO uses 32-bit ints
  target/hppa: Update SeaBIOS-hppa to version 16
  hw/hppa/machine: Load 64-bit firmware on 64-bit machines

Sven Schnelle (1):
  hw/net/tulip: add chip status register values

 disas/hppa.c                |  4 ++++
 hw/hppa/machine.c           | 11 ++++++++---
 hw/misc/lasi.c              | 13 +++++++++++++
 hw/net/tulip.c              |  4 ++--
 hw/pci-host/astro.c         | 36 ++++++++++++++++++++----------------
 include/hw/misc/lasi.h      |  2 ++
 include/hw/pci-host/astro.h |  2 ++
 roms/seabios-hppa           |  2 +-
 target/hppa/cpu.c           |  1 +
 target/hppa/cpu.h           |  5 +++++
 target/hppa/helper.h        |  1 +
 target/hppa/mem_helper.c    | 21 ++++++++++++++++++++-
 target/hppa/sys_helper.c    | 36 ++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c     | 14 +++++++++++++-
 14 files changed, 128 insertions(+), 24 deletions(-)

-- 
2.43.0


