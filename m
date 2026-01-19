Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935FBD29C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhptV-0003sk-9p; Mon, 19 Jan 2026 09:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vhptR-0003lc-GT; Mon, 19 Jan 2026 09:06:09 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vhptN-0006Vm-2N; Mon, 19 Jan 2026 09:06:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8693317FD44;
 Mon, 19 Jan 2026 17:05:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50324350E5F;
 Mon, 19 Jan 2026 17:05:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PATCH trivial v2 0/7] assume some linux syscalls are always present:
 epoll, splice, inotify
Date: Mon, 19 Jan 2026 17:05:51 +0300
Message-ID: <20260119140557.2167351-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are numerous checks in the code wrt availability
of linux subsystems.  It makes no sense to check for them
anymore, since they're always present (since linux 2.6 or
earlier).

I'm not resending the whole series, since the only difference
is in patch 7/7 (CONFIG_EPOLL).  Also, the inotify patches
weren't reviewed (inotify is now also present on freebsd, it
is not linux-specific).  So I'm only re-sending patches 3, 4
and 7.

v2: do not check for epoll_create1 too, in the last patch.

Michael Tokarev (7):
  linux-user/syscall.c: assume splice is always present
  meson.build: stop checking for splice()
  linux-user: assume inotify sycalls are always present
  meson.build: stop checking for inotify_init()
  linux-user: assume epoll is always present
  meson.build: do not check for epoll.h (CONFIG_EPOLL)
  rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL, and stop checking for
    epoll in meson.build

 linux-user/fd-trans.c     |  5 -----
 linux-user/fd-trans.h     |  4 ----
 linux-user/syscall.c      | 44 +++++++--------------------------------
 linux-user/syscall_defs.h |  3 ---
 meson.build               | 13 +-----------
 util/aio-posix.h          |  4 ++--
 util/meson.build          |  2 +-
 7 files changed, 11 insertions(+), 64 deletions(-)

-- 
2.47.3


