Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BCCC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1O42-0000Mc-K2; Mon, 29 Apr 2024 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1O40-0000M3-Fn; Mon, 29 Apr 2024 06:16:48 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1O3x-0006wg-SP; Mon, 29 Apr 2024 06:16:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:379a:0:640:b005:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id E849A60C50;
 Mon, 29 Apr 2024 13:16:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PGNBPH1IcW20-LYWI1Lvx; Mon, 29 Apr 2024 13:16:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714385798;
 bh=7K4NXuHOFh4XBpWjhx11g//rcvfEb8Lsp3WOoXvsGPE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=vDUiGyhPoRZMdEseFN+1dS+wZtDNapW7STtBBm27J7trj9M5OuuWLeVnUB6FXnU+v
 0x8d969UFJe9uEST9s3vnN7VhY7fWvSjCSAZuXV4pH3J5pbgjk0JDBNgS4+R8r1Y6n
 nilOHl6w9IJsYV49eeaWLYHezk0siDO9PiMznH3Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH v4 0/3] vhost-user-blk: live resize additional APIs
Date: Mon, 29 Apr 2024 13:16:20 +0300
Message-Id: <20240429101623.1992943-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

v4:
Fixes 01-02 from v3 are already merged.
02: new, split out from 03
03: refacting vhost_user_blk_handle_config_change() split out to 02
    drop current_run_state_str() helper
    some rewordings (Markus)

Vladimir Sementsov-Ogievskiy (3):
  qdev-monitor: add option to report GenericError from find_device_state
  vhost-user-blk: split vhost_user_blk_sync_config()
  qapi: introduce device-sync-config

 hw/block/vhost-user-blk.c | 27 ++++++++++++-----
 hw/virtio/virtio-pci.c    |  9 ++++++
 include/hw/qdev-core.h    |  3 ++
 qapi/qdev.json            | 23 ++++++++++++++
 system/qdev-monitor.c     | 63 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.34.1


