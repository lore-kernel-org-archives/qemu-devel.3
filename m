Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A8ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErXl-0007Ic-Ja; Fri, 31 Oct 2025 12:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXV-00078p-Ik
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXG-0005zb-5w
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:44 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7EB448080A;
 Fri, 31 Oct 2025 18:59:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fxip9o0FqiE0-jy97ED8E; Fri, 31 Oct 2025 18:59:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761926357;
 bh=3q9kFWEYWsLg4wzIUhqS+93xEaFBxdd6tamVmDzK8PM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=RfjjrEzwOvmIAZt9HcvJQUzDY6qQzHX/5CtaiJPjpUEsTzVbx+KEn9Dy4SMmHTsX9
 zJnH5ZAGNnDLO17sJR3YSqQa4dkDNlWyNt1pTuxV4aCgXfdq5wqweCGB7hs3WRWxUb
 tw1KBq3TExXU+AzawJm+U/YRB3Y7jLaqx6+pRJOc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v5 0/7] chardev: postpone connect
Date: Fri, 31 Oct 2025 18:59:07 +0300
Message-ID: <20251031155914.189112-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

changes in v5:
- rebase on master (conflicts due to be->fe renamings)
- tiny wording improvements in 05

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
 include/chardev/char-fe.h           |   8 +-
 include/chardev/char-socket.h       |   1 +
 include/chardev/char.h              |  30 ++++++-
 include/hw/qdev-properties-system.h |   3 +
 tests/unit/test-char.c              |  14 ++--
 ui/dbus-chardev.c                   |  12 ++-
 10 files changed, 228 insertions(+), 76 deletions(-)

-- 
2.48.1


