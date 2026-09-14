Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF8BC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6At0-0004zz-R9; Mon, 14 Sep 2026 13:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6Asf-0004vC-12
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6AsX-0000Ib-GC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1d16:0:640:f28c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0B587C0ACC;
 Mon, 14 Sep 2026 20:53:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:a2b::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rrX9s30iEKo0-ghp5Sued; Mon, 14 Sep 2026 20:53:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789408434;
 bh=uIPd3mJ8IR7yWR4BFTF8DxQvPZNF39x4POUlnj+ob2I=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=0Arh3QvvBJjStKl6mx3rWhCd8YR64tbH+7hT9huKeeZH2hDcDtQojEsVUbgubzoDa
 DQeKArMFkMAxrdbyvKgriACIpC2g0i/J7rw/nmHhQLoFtnpklYldmqmMWwFlJ0Y6gY
 XlplXHsC+Y8MGr4BbdX/TQSNS/sAvaUv7pEUmrwY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 0/5] virtio-net: live-TAP local migration follow-up
Date: Mon, 14 Sep 2026 20:53:46 +0300
Message-ID: <20260914175351.393680-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Hi all!

Here is a test (with some fixes and changes, so r-b dropped),
and several small fixes to recently merged live-TAP local migration
series.

Vladimir Sementsov-Ogievskiy (5):
  tests/functional: add test_tap_migration
  net/tap: tap_post_load(): poll only on success
  hw/net: finish backend initialization earler for local migration
  net/tap: move vmstate initialization to new_tap()
  net/tap: net_init_tap_one(): fix failure path

 hw/net/virtio-net.c                           |  40 +-
 net/tap.c                                     |  11 +-
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
 4 files changed, 448 insertions(+), 29 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.43.0


