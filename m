Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02463CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGE6Z-0001A3-LH; Tue, 04 Nov 2025 05:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGE6X-00018p-FD
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:17:33 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGE6U-0002lK-3y
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:17:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3FAD2C00D4;
 Tue, 04 Nov 2025 13:17:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NHhfHh1FIW20-UXpqpEJz; Tue, 04 Nov 2025 13:17:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762251444;
 bh=SKiXWkrfyerSyuI+MWim96D1B4dxWCuC8JvdpcwRjTg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=V91QLJ/BM7Y7GD8t/XNrCcJuA12yC382HOUB6aSDPF3ngFKEG6uTYnmFx4uNCKZCY
 S11Egx9OpWXvNEiag8mlQIoUE+Zs3yY88ytgg70YY/opxxLaIGxEg8MxcctaW4DKeU
 sB/aS51icpaKtN0kBoJIdNeHHZTgjkI2KlQWLgzo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v6 0/7] chardev: postpone connect
Date: Tue,  4 Nov 2025 13:17:08 +0300
Message-ID: <20251104101715.76691-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

That's a preparation for backend-transfer migration of
vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
is unused now.

v3 of "vhost-user-blk: live-backend local migration" is coming
soon, and will be based on this series (and will use
DEFINE_PROP_CHR_NO_CONNECT of course).

changes in v6:
05: move connect() call into "if (s)"
07: - drop assertion
    - improve doc comment, to cover @s==NULL relations with @connect
    - add r-b by Marc-André

Vladimir Sementsov-Ogievskiy (7):
  chardev/char-socket: simplify reconnect-ms handling
  chardev/char: split chardev_init_common() out of qemu_char_open()
  chardev/char: qemu_char_open(): add return value
  chardev/char: move filename and be_opened handling to qemu_char_open()
  chardev/char: introduce .init() + .connect() initialization interface
  chardev/char-socket: move to .init + .connect api
  chardev: introduce DEFINE_PROP_CHR_NO_CONNECT

 chardev/char-fe.c                   |  22 +++++-
 chardev/char-socket.c               |  64 ++++++++-------
 chardev/char.c                      | 118 ++++++++++++++++++++--------
 hw/core/qdev-properties-system.c    |  26 +++++-
 include/chardev/char-fe.h           |   9 ++-
 include/chardev/char-socket.h       |   1 +
 include/chardev/char.h              |  30 ++++++-
 include/hw/qdev-properties-system.h |   3 +
 tests/unit/test-char.c              |  14 ++--
 ui/dbus-chardev.c                   |  12 ++-
 10 files changed, 223 insertions(+), 76 deletions(-)

-- 
2.48.1


