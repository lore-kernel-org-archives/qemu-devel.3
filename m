Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD9C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPD-0005i5-Ga; Mon, 20 Jan 2025 16:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPA-0005he-MQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:56 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzP9-0000uc-1W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A80C35C5E15;
 Mon, 20 Jan 2025 21:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE98C4CEDD;
 Mon, 20 Jan 2025 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408823;
 bh=YHCSlkY5uMLyiOUtY9zSq6Ifv8J+oAsOkxlCltkzlHo=;
 h=From:To:Cc:Subject:Date:From;
 b=NQkX/yZGdbuo3BCkM/u1ax1FBtG27DVlb5V3VBQO3x5PdP3XA5XhFqXPT0JwZCDUO
 5uNCaKtGlnKbA1TDD3VqW6e8vv/TL6hbfRrIvyQWMuvgsuxKvSbQ7Pkuxgf8STylo0
 2GpeSWsIo/+MDYurQpGY2xrSGdtK/pI6OMC5fY6QKMEfat86v6Blf5rX2jKJDs9XAT
 0SteGUPOJSeyZ1rWDt4C1GwJThdbVOnE7jWL7e96ucjaMumzygm6UKA+Y2Zsv+CGpP
 OLm/F8ldGK4Z7XjGIHU+w0x1N1nl76AqbspoNstb/40LbIZgF2Hjm6Gtw4NG3m8kmR
 YgI0s78ZsmvVw==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 0/7] linux-user: Add support for various missing netlink
 sockopt entries
Date: Mon, 20 Jan 2025 22:33:33 +0100
Message-ID: <20250120213340.359195-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

This patchset adds various missing sockopt calls, so that qemu linux-user
is able to successfully build the debian gupnp package in a chroot.

Tested with a 32-bit big-endian hppa linux-user chroot running on a phyiscal
x86-64 little-endian host.

This fixes debian's bug report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1044651

Signed-off-by: Helge Deller <deller@gmx.de>

Please review patches #1 and #7.

Changes in v4:
- rewrote patch #1 to fix build on ubuntu 22.04 and add
  cleanup-patch #7
- added S-o-b from Laurent to patches #3 and #4

Changes in v3:
- Updated patches #3, #4 and #5 based on suggestions from
  Laurent Vivier

Changes in v2:
- Moved IFA_PROTO in patch 1 as suggested by Laurent Vivier
- Added Reviewed-by from Philippe Mathieu-Daudé and Laurent Vivier
  in patch 2

Helge Deller (7):
  linux-user: netlink: Add missing IFA_PROTO to
    host_to_target_data_addr_rtattr()
  linux-user: Use unique error messages for cmsg parsing
  linux-user: netlink: Add IP_PKTINFO cmsg parsing
  linux-user: netlink: Add emulation of IP_MULTICAST_IF
  linux-user: netlink: add netlink neighbour emulation
  linux-user: netlink: Add missing QEMU_IFLA entries
  linux-user: netlink: Use QEMU_IFA_XXX values instead of IFA_XXX

 linux-user/fd-trans.c     | 169 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall.c      |  34 ++++++--
 linux-user/syscall_defs.h |   6 ++
 3 files changed, 192 insertions(+), 17 deletions(-)

-- 
2.47.0


