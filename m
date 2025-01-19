Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08FAC02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 04:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZN7x-0005UK-7e; Sat, 18 Jan 2025 23:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7u-0005TQ-Sj
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:34 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7t-0003X3-6R
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:34 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 439A5A400C1;
 Sun, 19 Jan 2025 04:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CCDC4CED6;
 Sun, 19 Jan 2025 04:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737261686;
 bh=N0gK4W79yptqJDWltVwbPi7SL9+i2mqYTWW2TarXVFM=;
 h=From:To:Cc:Subject:Date:From;
 b=P47Z/EKVx0zermGpCx9lc2Te0W2Ggq4oJAhHirOKz70/1naqsVIOAFZsay/SqI/aL
 6jN1uKLgr8ZkmnBucJqcB48utDVeNndFXmJieINHQ2E8OvLawmKSN7I0hrG2vhkUE7
 qs1MeAdQ5MinhYEyIgDvGavhMNgOiLDkYEb1pQ6dQJtp+8OEBOjQ8xH7bWQGtgY3tl
 +tOY8QRX5gjhfZGk1BkuQoXxvnG5tFKhuStdA9k9XnqujkpjQkIr8rqUEF5ksGDq+N
 43TwCCAymHqAhT8aZwwDr+qMzgmFXuWhMsN0+pZNIEikeryBZ3m6//796bbmu/eP0w
 k7YjZVrLXfo8A==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v3 0/6] linux-user: Add support for various missing netlink
 sockopt entries
Date: Sun, 19 Jan 2025 05:41:16 +0100
Message-ID: <20250119044122.9637-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
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

Please review patches #3, #4 and #5.

Changes in v3:
- Updated patches #3, #4 and #5 based on suggestions from
  Laurent Vivier

Changes in v2:
- Moved IFA_PROTO in patch 1 as suggested by Laurent Vivier
- Added Reviewed-by from Philippe Mathieu-Daudé and Laurent Vivier
  in patch 2

Helge Deller (6):
  linux-user: netlink: Add missing IFA_PROTO to
    host_to_target_data_addr_rtattr()
  linux-user: Use unique error messages for cmsg parsing
  linux-user: netlink: Add IP_PKTINFO cmsg parsing
  linux-user: netlink: Add emulation of IP_MULTICAST_IF
  linux-user: netlink: add netlink neighbour emulation
  linux-user: netlink: Add missing QEMU_IFLA entries

 linux-user/fd-trans.c     | 137 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall.c      |  34 +++++++---
 linux-user/syscall_defs.h |   6 ++
 3 files changed, 168 insertions(+), 9 deletions(-)

-- 
2.47.0


