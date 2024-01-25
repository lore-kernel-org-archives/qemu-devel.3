Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4AFC48285
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 22:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT8EK-0007WE-VY; Thu, 25 Jan 2024 17:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rT8EI-0007Vp-I6; Thu, 25 Jan 2024 17:29:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rT8EG-0001x1-OG; Thu, 25 Jan 2024 17:29:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4BDC447562;
 Fri, 26 Jan 2024 01:30:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A85B26BA52;
 Fri, 26 Jan 2024 01:29:42 +0300 (MSK)
Received: (nullmailer pid 147065 invoked by uid 1000);
 Thu, 25 Jan 2024 22:29:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial 0/2] split out os_close_all_open_fd and use it in
 net/tap.c too
Date: Fri, 26 Jan 2024 01:29:34 +0300
Message-Id: <cover.1706221377.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We have at least two places in qemu where we're closing all possible file
descriptors, - in async-teardown.c and in net/tap.c.  While async-teardown
one uses either close_range() or readdir(/proc/self/fd), the two calls in
net/tap.c loops from 3 to RLIMIT_NOFILE, which might be quite slow, and
it actually *is* slow on some systems (eg, just qemu-system-x86_64 startup
with a tap device is very slow on alpine linux).

While for net/tap.c, maybe the better fix is to get rid of this closing
entirely and use O_CLOEXEC instead, this needs to be prepared at first,
while we alredy have almost ready-to-be-used implementation which only
needs to be moved into a common place.

Michael Tokarev (2):
  close_all_open_fd(): move to oslib-posix.c
  net/tap: use os_close_all_open_fd() instead of open-coding it

 include/sysemu/os-posix.h |  1 +
 net/tap.c                 | 15 ++-------------
 system/async-teardown.c   | 37 +------------------------------------
 util/oslib-posix.c        | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 49 deletions(-)

-- 
2.39.2


