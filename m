Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB9A103E167
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8G-0006hr-S4; Wed, 18 Mar 2026 07:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p83-0006gT-8t
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p7z-0001qk-T6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:31:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 386BF808B6;
 Wed, 18 Mar 2026 14:31:49 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-K6yeiR7A; Wed, 18 Mar 2026 14:31:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833508;
 bh=5yw1+8ODObO+yvfobPL6K7kr+D5gov3hoIGrnHx419o=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=ndOXEhiBvWQ1IefiVf1plDm4qcXv6jPSUHKSwh5HWEq5ptCNtkPpwTpJpM/H/f0Fm
 LRyHr4tb5/T4C5CrcZ/rbLLZdj3scRkVtb3Af/QvtqEplJwUv8NCZf/D0IoSOcpQ8A
 bxI8fyRsyCY0CHit/NtF9QIsvuWxOLMatbwMpZ/A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 00/13] net: refactoring and fixes
Date: Wed, 18 Mar 2026 14:31:30 +0300
Message-ID: <20260318113144.15697-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
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

Hi all!

Here are some refactoring and fixes, mostly in net/tap.c I'm making on
my way to implementing TAP fd migration (through UNIX domain socket).

v4:
01-12: add r-b by Ben
10: fix bug in tap_parse_vhost_fds(), keep r-b

Vladimir Sementsov-Ogievskiy (13):
  net/af-xdp: fix type overflow
  net/tap: net_init_tap_one(): add return value
  net/tap: net_init_tap(): drop extra vhostfdname variable
  net/tap: net_init_tap(): refactor parameter checking
  net/tap: net_init_tap(): common fail label
  net/tap: net_init_tap_one() refactor to get vhostfd param
  net/tap: net_init_tap_one(): drop model parameter
  net: introduce net_parse_fds()
  net/tap: move fds parameters handling to separate functions
  net/tap: fix vhostfds/vhostfd parameters API
  net/tap: net_init_tap(): merge fd=, fds= and helper= cases into one
  net/tap: net_init_tap(): relax QEMU hubs check
  net/tap: check that user tries to define zero queues

 net/af-xdp.c |  44 ++-----
 net/tap.c    | 324 +++++++++++++++++++++------------------------------
 net/util.c   |  55 +++++++++
 net/util.h   |  14 +++
 4 files changed, 211 insertions(+), 226 deletions(-)

-- 
2.52.0


