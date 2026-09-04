Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E6CC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az6-00039V-Rc; Fri, 04 Sep 2026 16:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az4-00038b-Lv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007w6-7o
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id ECE7E807AF;
 Fri, 04 Sep 2026 23:57:53 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-SvX2MZuo; Fri, 04 Sep 2026 23:57:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555473;
 bh=+5+A6406j+Bz42PIBkejajm8VKUilGcddlVcpYjxmsg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=tJCNyyA4ujxotJQ8z1cbQMCQwgyay9UbCMIS8XCNpu0jWXVRpWE9lT0RETWvuIUBM
 gBMkuKKu/bC7Yn+qh05j303sFBSkC1InFjRRLI6TQxGR87X6IJd1qIcnEccmNszdak
 23V4rcvAt5JNVgyVF1wUVCnAK8IDk6mMcaZKgyBk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 0/6] runstate: fix race between guest shutdown and SIGTERM
Date: Fri,  4 Sep 2026 23:57:43 +0300
Message-ID: <20260904205749.510493-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all.

This series fixes a race between guest shutdown and SIGTERM handling.
With -no-shutdown, a SIGTERM arriving while QEMU is processing a guest
shutdown request can make QEMU exit after sending SHUTDOWN with guest=true,
without sending a host SHUTDOWN event. This is unexpected for management
software relying on -no-shutdown.

Patch 5 contains the fix and a detailed description of the race. The
preceding patches prepare for it, and patch 6 makes the runstate action
variables private.

Vladimir Sementsov-Ogievskiy (6):
  runstate: introduce qemu_system_shutdown_request_safe() helper
  runstate: treat SHUTDOWN_CAUSE_HOST_UI as force_shutdown
  runstate: inline qemu_shutdown_requested()
  runstate: simplify qemu_shutdown_requested_get()
  runstate: separate forced and regular shutdown requests
  runstate: make runstate actions private

 MAINTAINERS                      |   1 -
 hw/xen/xen-hvm-common.c          |   2 +-
 include/system/runstate-action.h |  19 ------
 include/system/runstate.h        |   2 +-
 monitor/qmp-cmds.c               |   2 -
 system/meson.build               |   1 -
 system/runstate-action.c         |  46 --------------
 system/runstate.c                | 103 +++++++++++++++++++++----------
 system/vl.c                      |   2 +-
 ui/cocoa.m                       |   2 -
 ui/sdl2.c                        |   3 -
 11 files changed, 75 insertions(+), 108 deletions(-)
 delete mode 100644 include/system/runstate-action.h
 delete mode 100644 system/runstate-action.c

-- 
2.43.0

