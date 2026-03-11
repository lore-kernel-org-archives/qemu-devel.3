Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C63103E2E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Qai-0003el-EV; Wed, 11 Mar 2026 16:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0QaQ-0003Zs-LU; Wed, 11 Mar 2026 16:55:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0QaF-0007qW-1z; Wed, 11 Mar 2026 16:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773262468; bh=maegopCUP/tozWfVxHo90LVYVuWpHvg/lE5sloss4Xw=;
 h=From:To:Cc:Subject:Date;
 b=wjpVTeytp3EIneLdCSnC2vLfSs0iVjI7T+osXH85T5ME2t+aWgazH69EFIItA6UF+
 PZa3VdnzDZh7i+bTttpwk9GWsAMXEwoVt6pBfAZN1YnLTwRz6hZBWcopOsvd13w051
 9PkR0iGrWfL7JeKzt/Rz4gCI4EfGNdf6j+lrHguFUtCx8+p/u3VC1AP5qGywJ6iCG+
 e07w6ASrqQww3iXpN/urBNnK/aEn8p0ZTII3eVz7jofZBHFye46x7rESm3yVpmlDAB
 4kNqlMV3D7AWTcF2T4slU4HpObiKLXrtHNHg3LE52kDg58sHPjtnidWxqhjK5BCAuo
 yd3syI3U5CZSA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9BB61921ED;
 Wed, 11 Mar 2026 23:54:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05B7037C4D2;
 Wed, 11 Mar 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH trivial v2 0/7] a few cleanups for linux-user: splice, inotify,
 epoll
Date: Wed, 11 Mar 2026 23:54:48 +0300
Message-ID: <20260311205459.1101023-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Stop checking for linux syscalls which has been introduced long
ago, - on modern system where qemu can run, these syscalls are
always present.

I kept CONFIG_EPOLL separate, not replacing it with CONFIG_LINUX,
since I think it is more understandable this way.  As an option,
the last patch can make s/CONFIG_EPOLL/CONFIG_LINUX_EPOLL/ to make
it explicit, but I'd love to make it EPOLL not LINUX.

v2: rebase on top of native inotify on freebsd changes
 (meson.build: stop checking for inotify_init())

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
 meson.build               | 19 +++--------------
 util/aio-posix.h          |  4 ++--
 util/meson.build          |  2 +-
 7 files changed, 13 insertions(+), 68 deletions(-)

-- 
2.47.3


