Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BD8CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IlO-0006fZ-WA; Mon, 13 Oct 2025 09:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlI-0006d9-Ka
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlB-0006a5-Ld
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D4B6B8085A;
 Mon, 13 Oct 2025 16:38:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ccOm1D2F0Cg0-Jeq7U9ag; Mon, 13 Oct 2025 16:38:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760362719;
 bh=IdChmQ+ua8ehnUg0PB8/Qlvy/St8WKX60w/oBE5B8fs=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=GBhLzDMOjvG0yqEvtHUQnbuNTiTEHfGmLDXeI6QiOw4yM/Cn9LAFXkS8U4GAvLdC6
 fKqjmilU2aB+JddjO5aT4xRGnf+yYkwuyIrjybkZRgEImlyNUPyCkAGTQC+iiVoiz2
 Mbdyn+rmXjrPefkACQOpydFk5FCdEIJGc7HmY+6Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 0/7] chardev: postpone connect
Date: Mon, 13 Oct 2025 16:38:29 +0300
Message-ID: <20251013133836.852018-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

That's a preparation for backend-transfer migration of
vhost-user-blk. For such migration we are going to transfer
vhost-user-blk fds, including backend chardev fd to the target
in migration stream (backed by UNIX domain socket).

So, on the target, we want to know, should we call connect(),
or is it a backend-transfer migration, and we should wait for
incoming fd.

But at initialization time we can't know it: user may setup
migration parameters (enabling backend-transfer) later.

So, let's postpone chardev open/connect phase up to attaching
to frontend. At this point we can check:

- if it's vhost-user-blk, do nothing, let vhost-user-blk decide
  when to do connect()
- otherwise, do connect() at this point

These are new patches, but called v2, as that's a rework of
previous try to handle vhost-user-blk chardev in

  [PATCH 00/33] vhost-user-blk: live-backend local migration

That previous try required additional option for chardevs,
so users should mark chardevs on target by a new option to
enable backend-transfer (and addition option on source was
needed, and addition migration capability).
The new upcoming design will require only one migration
parameter to enable the whole feature. But it requires more
complex logic, to postpone opens/connects, realized for
chardevs in these series.

The series is based on
  [PATCH 0/2] remove deprecated 'reconnect' options
Based-on: <20250924133309.334631-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (7):
  chardev/char-socket: simplify reconnect-ms handling
  chardev/char: split chardev_init_logfd() out of qemu_char_open()
  chardev/char: qemu_char_open(): add return value
  chardev/char: move filename and be_opened handling to qemu_char_open()
  chardev/char: introduce .init() + .connect() initialization interface
  chardev/char-socket: move to .init + .connect api
  char: vhost-user-blk call connect by hand

 chardev/char-fe.c                |  19 ++++-
 chardev/char-socket.c            |  64 +++++++++--------
 chardev/char.c                   | 117 +++++++++++++++++++++++--------
 hw/core/qdev-properties-system.c |   2 +-
 include/chardev/char-fe.h        |   2 +
 include/chardev/char-socket.h    |   1 +
 include/chardev/char.h           |  22 +++++-
 tests/unit/test-char.c           |  14 ++--
 ui/dbus-chardev.c                |  12 +++-
 9 files changed, 181 insertions(+), 72 deletions(-)

-- 
2.48.1


