Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C110DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWJa-0001Ae-M6; Thu, 30 Oct 2025 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJR-00017m-SH
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:51 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJ4-0008Lb-Es
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CA4F7C00CA;
 Thu, 30 Oct 2025 20:19:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-cS7N7Fez; Thu, 30 Oct 2025 20:19:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844757;
 bh=kwYoJYdfNlAO/txk85zz/DaSoh27bZDeaf0Itq645DU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=d8fxs2d6WQruElDfm2aCrkPr9QhJCPiUcV5rcuipvy9gexSrBL1x+pUB4gTXXSOiV
 DcoqMinflAIjR3VqfKBFwu0i2aUct/M7pV6ebEYxZ6iduUACe3ylk3VXNem1T9KqkY
 pcgXVFdcuoNvQ97OLD2Lqtty7/nLVR8BYKwBw8d8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 0/9] net/tap: postpone connect
Date: Thu, 30 Oct 2025 20:19:05 +0300
Message-ID: <20251030171915.726441-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

That the second part of virtio-net backend transfer feature,
following previous
 "[PATCH v9 0/7] net/tap: simple refactoring".

Here we realize postponing TAP opening to some future
point, when we know, are we going to do backend-transfer
incoming migration (and get open fd from migration stream),
or we should do open().

v9:
most of patches just picked from
 "[PATCH v9 0/7] net/tap: simple refactoring".
but, 01 is new, and 09 is significantly changed:
instead of hacking with .check_peer_type and detecting
virtio-net by name, use the approach like in parallel
series for chardev:
 "[PATCH v4 0/7] chardev: postpone connect":
introduce specific PROPERTY macro, and avoid connecting
in setter of "netdev" property.

Final part of virtio-net backend transfer is coming
soon and will be based on this series.

Based-on: <20251030164023.710048-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (9):
  net: introduce backend-connect concept
  net/tap: rework net_tap_init()
  net/tap: split net_tap_fd_init()
  net/tap: rework sndbuf handling
  net/tap: introduce net_tap_setup()
  net/tap: move vhost fd initialization to net_tap_new()
  net/tap: finalize net_tap_set_fd() logic
  net/tap: introduce TAP_IFNAME_SZ
  net/tap: postpone tap setup to net_backend_connect() call

 hw/core/qdev-properties-system.c    |  29 ++-
 include/hw/qdev-properties-system.h |   2 +
 include/net/net.h                   |   6 +
 net/net.c                           |  15 ++
 net/tap.c                           | 283 +++++++++++++++++++++-------
 5 files changed, 264 insertions(+), 71 deletions(-)

-- 
2.48.1


