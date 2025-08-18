Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C1CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vm-0001Kh-QU; Mon, 18 Aug 2025 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vj-0001JX-Nf
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:55 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002B5-BN
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 857A6807B1;
 Mon, 18 Aug 2025 17:06:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-69eZFfBK; Mon, 18 Aug 2025 17:06:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526007;
 bh=KA33589QmHph33pd7g5bbngUdZzm4Gu2kQ67TDP+FEU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=rLH2rsrHob2weQOJOh7PByKONqNFwcEfzzFpQ5QOK0fa8EbXeJnRrmQv/0hq/r8Uq
 WKFGqXzLVtjbteoOIXcoPYayS6Jdl8w+7pOAXH6zdBiqo8BlXqh6YTEgMvis/WuXhl
 oF1mQAkET/M8+fgHvwKswOgQHJRwqw9BBs3p51CI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 00/19] TAP initialization refactoring
Date: Mon, 18 Aug 2025 17:06:26 +0300
Message-ID: <20250818140645.27904-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
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

As preparation for further development of TAP live local migration
(passing open fds through unix socket), here is a refactoring
of initialization code, to improve its readability and get rid
of duplication.

Below are the initialization flow diagrams showing the changes.

BEFORE REFACTORING:
==================

```
net_init_tap()
    |
    +-- if (tap->fd)
    |   +-- duplicated logic*
    |   +-- net_init_tap_one()
    |
    +-- else if (tap->fds)
    |   +-- for each fd:
    |       +-- duplicated logic*
    |       +-- net_init_tap_one()
    |
    +-- else if (tap->helper)
    |   +-- duplicated logic*
    |   +-- net_init_bridge()
    |
    +-- else (normal case)
        +-- for each queue:
            +-- net_tap_init()
            +-- net_init_tap_one()

net_init_bridge()
    |
    +-- duplicated logic*
    +-- net_tap_fd_init()

net_init_tap_one()
    |
    +-- net_tap_fd_init()

net_tap_init()
    |
    +-- tap_open()

net_tap_fd_init()
    |
    +-- qemu_new_net_client()
    +-- Initialize TAPState

* duplicated logic: set fd nonblocking + probe vnet_hdr
```

AFTER REFACTORING:
=================

```
net_init_tap()
    |
    +-- if (tap->fd)
    |   +-- net_tap_from_monitor_fd()
    |
    +-- else if (tap->fds)
    |   +-- for each fd:
    |       +-- net_tap_from_monitor_fd()
    |
    +-- else if (tap->helper)
    |   +-- net_init_bridge()
    |
    +-- else (normal case)
        +-- net_tap_open()

net_tap_open()
    |
    +-- for each queue:
        +-- net_tap_open_one()

net_tap_open_one()
    |
    +-- tap_open()
    +-- net_tap_fd_init_common()

net_tap_from_monitor_fd()
    |
    +-- net_tap_fd_init_external()

net_tap_fd_init_external()
    |
    +-- net_tap_fd_init_common()

net_init_bridge()
    |
    +-- net_tap_fd_init_external()

net_tap_fd_init_common()
    |
    +-- qemu_new_net_client()
    +-- Initialize TAPState
```

Solved problems:

- duplicated logic to handle external
  file descriptors (set nonblocking, probe vnet_hdr)

- duplication between tap/helper case in
  net_init_tap() and net_init_bridge()

- confusing naming and functionality spread between functions (we had
  net_init_tap(), together with net_tap_init(); also main central
  function was net_init_tap_one(), and part of its logic (not clear
  why) moved to separate net_tap_fd_init()),


Vladimir Sementsov-Ogievskiy (19):
  net/tap: net_init_tap_one(): add return value
  net/tap: add set_fd_nonblocking() helper
  net/tap: tap_set_sndbuf(): add return value
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: net_init_tap(): refactor parameter checking
  net/tap: net_init_tap(): drop extra variable vhostfdname
  net/tap: move local variables related to the latter case to else
    branch
  net/tap: use glib strings vector and g_strsplit for fds case
  net/tap: drop extra tap_fd_get_ifname() call
  net/tap: net_init_tap_one(): refactor to use netdev as first arg
  net/tap: net_init_tap_one(): support bridge
  net/tap: net_init_bridge(): support tap
  net/tap: refactor net_tap_init() into net_tap_open_one()
  net/tap: introduce net_tap_open()
  net/tap: introduce net_tap_fd_init_external()
  net/tap: introduce net_tap_from_monitor_fd() helper
  net/tap: split net_tap_setup_vhost() separate function
  net/tap: drop net_tap_fd_init()

 net/tap-linux.c |   5 +-
 net/tap.c       | 548 ++++++++++++++++++++++--------------------------
 net/tap_int.h   |   2 +-
 3 files changed, 256 insertions(+), 299 deletions(-)

-- 
2.48.1


