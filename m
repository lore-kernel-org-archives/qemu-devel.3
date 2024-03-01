Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1932EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Qd-0007AS-2d; Fri, 01 Mar 2024 12:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QY-000767-8D; Fri, 01 Mar 2024 12:12:07 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QT-0003L1-97; Fri, 01 Mar 2024 12:12:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2333060EB1;
 Fri,  1 Mar 2024 20:11:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jBfRBH2IW0U0-y5TXMWbc; Fri, 01 Mar 2024 20:11:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709313114;
 bh=eKu8cMClFmBmywhX7+QlAwEER7vTqPYmfdu+qDl0sJs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=G7qQjcmgGHaELYc+u1HnOM+xsVStkTJzQ/FkNYbd9fAPW4+YGRR00ci/nCXgfjjhZ
 AWuuz25LZxwft+RButq56b8cg/AYB4linbvxSZMXEDzCrXQmFDlXgo6/LSgQdbBxjS
 qfcuoI+VOlt15MIvAhrYhp7jWLbgg1G40ppghsww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 0/6] vhost-user-blk: live resize additional APIs
Date: Fri,  1 Mar 2024 20:11:37 +0300
Message-Id: <20240301171143.809835-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2:
- now based on master
- drop x- prefixes, still keep new APIs "unstable"

Also:

01: add a-b by Raphael
    add note about removed comment "valid for resize only"
02-03: new patches, following review of old "02", which is now 04
04: use GenericError
    wording
    keep short name device-sync-config still
06: rename event to VIRTIO_CONFIG_READ

===

In vhost-user protocol we have VHOST_USER_BACKEND_CONFIG_CHANGE_MSG,
which backend may send to notify Qemu, that we should re-read the
config, and notify the guest.

Still that's not always convenient: backend may not support this
message. Also, having QMP command to force config sync is more reliable
than waiting for notification from external program. It also may be
helpful for debug/restore: if we have changed disk size, but guest
doesn't see that, it's good to have a separate QMP command to trigger
resync of the config.

So, the series proposes two experimental APIs:

1. device-sync-config command, to trigger config synchronization

2. CONFIG_READ event, which notify management tool that guest read the
updated config. Of course, that can't guarantee that the guest correctly
handled the updated config, but it's still better than nothing: for sure
guest will not show new disk size until it read the updated config. So,
management tool may wait for this event to report success to the user.

Vladimir Sementsov-Ogievskiy (6):
  vhost-user-blk: simplify and fix vhost_user_blk_handle_config_change
  qdev-monitor: fix error message in find_device_state()
  qdev-monitor: add option to report GenericError from find_device_state
  qapi: introduce device-sync-config
  qapi: device-sync-config: check runstate
  qapi: introduce CONFIG_READ event

 hw/block/vhost-user-blk.c | 32 +++++++++++-------
 hw/virtio/virtio-pci.c    | 18 ++++++++++
 include/hw/qdev-core.h    |  3 ++
 include/monitor/qdev.h    |  2 ++
 include/sysemu/runstate.h |  1 +
 monitor/monitor.c         |  1 +
 qapi/qdev.json            | 43 ++++++++++++++++++++++++
 stubs/qdev.c              |  6 ++++
 system/qdev-monitor.c     | 71 ++++++++++++++++++++++++++++++++++++---
 system/runstate.c         |  5 +++
 10 files changed, 165 insertions(+), 17 deletions(-)

-- 
2.34.1


