Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVho-00089Z-TJ; Thu, 30 Oct 2025 12:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhg-000855-Og
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhS-0003GQ-2N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 286E280B24;
 Thu, 30 Oct 2025 19:40:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OeiSuH0Fn4Y0-rxLRQItu; Thu, 30 Oct 2025 19:40:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761842425;
 bh=C391eBaV6YPPWlC0kiukM+e93+wT0Gx1y4pdWVTbSlY=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=j7UQbqM5K16ONETjwvhF9MQi+KMnLpEy/r7Lv7Yc+bvin7msPEHE9bFFCmxOo8MlG
 Yd91cps+S6u05U8BkbzTAjbwjlvvIX70ycRGA+yPgpw+3uo5+660F/Kx8GpDjup3SE
 UTRxzmnwsKoz/eebzNwtnV1Jzxjm5m5JkD41dJBg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 0/7] net/tap: simple refactoring
Date: Thu, 30 Oct 2025 19:40:16 +0300
Message-ID: <20251030164023.710048-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These are some refactoring patches, extracted from

[PATCH v8 00/19] virtio-net: live-TAP local migration

These patches are good in general, even not considered as
preparation to the feature. I hope, they may be queued
in advance, to simplify further work on the rest of
the series.

The (reworked) rest of the series is coming soon and will
be based on this one.

v9: Mostly unchanged, so keep r-bs. Still, drop t-bs, as there
were still some conflicts due to commits reordering.

Vladimir Sementsov-Ogievskiy (7):
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: pass NULL to net_init_tap_one() in cases when scripts are
    NULL
  net/tap: rework scripts handling
  net/tap: setup exit notifier only when needed
  net/tap: tap_set_sndbuf(): add return value
  net/tap: rework tap_set_sndbuf()

 net/tap-bsd.c     |  3 +-
 net/tap-linux.c   | 19 +++-------
 net/tap-solaris.c |  3 +-
 net/tap-stub.c    |  3 +-
 net/tap.c         | 94 +++++++++++++++++++++++++----------------------
 net/tap_int.h     |  3 +-
 6 files changed, 62 insertions(+), 63 deletions(-)

-- 
2.48.1


