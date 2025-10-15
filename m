Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF01CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98vl-0004Wl-3o; Wed, 15 Oct 2025 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98vi-0004VZ-Q4
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:21:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98vd-0001z4-Da
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:21:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2830380B51;
 Thu, 16 Oct 2025 00:20:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rKYpxt3F20U0-G4EkUAAg; Thu, 16 Oct 2025 00:20:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760563254;
 bh=pGkfOALOvSnsZ2LzToM97JtMAGRswEmnACG50vFTKtE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=MxJ+efvotyeckxFiPgmjaKGnxzrkjYICBrVPg5dmvNAzrCvCqFZICwAmb0v0b4TdP
 Vjc1fbc4dz0Zn7xxSL4ReTYPScBV2gK8sC9UuAjzsXme3fgFUe83CHNBww8CHCacwd
 kQ1mozhLur6QdQ9Njz3Q3JnxjEovvgnWxDrlZfw4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v4 0/7] chardev: postpone connect
Date: Thu, 16 Oct 2025 00:20:44 +0300
Message-ID: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Changes in v4:

02: fix commit subject
03: add r-b by Markus
05: improve comments
07: - simplify commit message
    - more safe logic in qemu_chr_fe_init_ex()


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
  chardev/char: split chardev_init_common() out of qemu_char_open()
  chardev/char: qemu_char_open(): add return value
  chardev/char: move filename and be_opened handling to qemu_char_open()
  chardev/char: introduce .init() + .connect() initialization interface
  chardev/char-socket: move to .init + .connect api
  chardev: introduce DEFINE_PROP_CHR_NO_CONNECT

 chardev/char-fe.c                   |  28 ++++++-
 chardev/char-socket.c               |  64 ++++++++-------
 chardev/char.c                      | 118 ++++++++++++++++++++--------
 hw/core/qdev-properties-system.c    |  26 +++++-
 include/chardev/char-fe.h           |   6 +-
 include/chardev/char-socket.h       |   1 +
 include/chardev/char.h              |  28 ++++++-
 include/hw/qdev-properties-system.h |   3 +
 tests/unit/test-char.c              |  14 ++--
 ui/dbus-chardev.c                   |  12 ++-
 10 files changed, 225 insertions(+), 75 deletions(-)

-- 
2.48.1


