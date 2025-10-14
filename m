Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE09DCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gvn-0006zO-Om; Tue, 14 Oct 2025 11:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvl-0006yn-Ej
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:17 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvh-0007gV-I9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7D016807B3;
 Tue, 14 Oct 2025 18:27:09 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7RRbiX2F1mI0-sK1dSZ2n; Tue, 14 Oct 2025 18:27:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760455629;
 bh=llTLM2QuEj792eKtiT19nsfj+fT4jxC8Z44mroiEp7w=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=nnefxUR3mkjflYdeg+88NZfvlaoNmug5rD3V0s1andUG4Nt918gyfZD4zaODxiTwS
 cVIRCvBHuuTYfz5SMIzMehkzNcP40atGsXZfCvUQarZVV/Tv1y0yuQJfJZiVoiS7O3
 ESlU8ACtEesDgi4y9jn97HAbJ8SgJL4HTDeOjoQQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v3 0/7] chardev: postpone connect
Date: Tue, 14 Oct 2025 18:26:37 +0300
Message-ID: <20251014152644.954762-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

That's only a preparation for backend-transfer migration of
vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
is unused now.

v2 of "vhost-user-blk: live-backend local migration" is coming
soon, and will be based on this series (and will use
DEFINE_PROP_CHR_NO_CONNECT of course).

If the design gets general approval, I'll try to update other
chardev backends, to avoid supporting two different initialization
APIs in future.


Changes in v3:

01: add r-b by Marc-André
02: - rename function and save comment
    - add r-b by Marc-André
03: fix local_err to errp
04-06: add r-b by Marc-André
07: reworked to introduce DEFINE_PROP_CHR_NO_CONNECT


For backend-transfer migration we are going to pass
vhost-user-blk fds, including backend chardev fd to the target
in migration stream (backed by UNIX domain socket).

So, on the target, we want to know, should we call connect(),
or is it a backend-transfer migration, and we should wait for
incoming fd.

But at initialization time we can't know it: user may setup
migration parameters (enabling backend-transfer) later.

So, let's postpone chardev open/connect phase up to attaching
to frontend. At this point we can split the behavior:

If frontend is a device, which define chardev property
using DEFINE_PROP_CHR_NO_CONNECT (at least, vhost-user-blk will
behave this way soon), then do not connect(), let the device decide
when to do connect().

Otherwise (basic DEFINE_PROP_CHR, or other calls to qemu_chr_fe_init()),
do connect() at point of attaching frontend.

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
  chardev: introduce DEFINE_PROP_CHR_NO_CONNECT

 chardev/char-fe.c                   |  12 ++-
 chardev/char-socket.c               |  64 ++++++++-------
 chardev/char.c                      | 118 ++++++++++++++++++++--------
 hw/core/qdev-properties-system.c    |  26 +++++-
 include/chardev/char-fe.h           |   6 +-
 include/chardev/char-socket.h       |   1 +
 include/chardev/char.h              |  22 +++++-
 include/hw/qdev-properties-system.h |   3 +
 tests/unit/test-char.c              |  14 ++--
 ui/dbus-chardev.c                   |  12 ++-
 10 files changed, 203 insertions(+), 75 deletions(-)

-- 
2.48.1


