Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F27FCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2fz-0002Pz-4U; Wed, 29 Oct 2025 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vE2fk-0002O0-Kv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:40:55 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vE2fe-0008PB-2y
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:40:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CC44B80EB7;
 Wed, 29 Oct 2025 12:40:34 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown [2a02:6bf:8080:d37::1:31])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id Rea6510FtiE0-gpHMGC7E; 
 Wed, 29 Oct 2025 12:40:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761730834;
 bh=DQBesmOkcQe1NMva0FgClReKlCLo1Nov2vXF3dKi+sA=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=MkHiqvI4zH76SbQ9hgOeoBA5RXXUEoiTWWP60gWc4/xMNHqyGppykBqnz8scjRg4w
 8Se/0HTbjDJIL2yR1B3WZWCYY0mkZCP4AzefdnWGM7MrZrlvoY/VoTNhJdcf/TxLgx
 emOj+l4LHrYoAdCs7kH0kqSerHoB/gu5RQ+B5D04=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2 0/3] vhost-user-blk: support inflight migration
Date: Wed, 29 Oct 2025 14:39:37 +0500
Message-Id: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

v2: 
- rewrite migration using VMSD instead of qemufile API
- add vhost-user-blk parameter instead of migration capability

I don't know if VMSD was used cleanly in migration implementation, so
feel free for comments.

v2 is based on Vladimir's work:
[PATCH v2 00/25] vhost-user-blk: live-backend local migration
  which was based on:
    - [PATCH v4 0/7] chardev: postpone connect
      (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
    - [PATCH v3 00/23] vhost refactoring and fixes
    - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler

Based-on: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Based-on: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
Based-on: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
Based-on: <20251015132136.1083972-15-vsementsov@yandex-team.ru>
Based-on: <20251016114104.1384675-1-vsementsov@yandex-team.ru>

--- 

Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk. 
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host. 

At first, I tried to implement migration for all vhost-user devices that support inflight at once, 
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and 
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Therefore, for now I decided to leave this idea for later and 
implement the migration of the inflight region first for vhost-user-blk.

Alexandr Moshkov (3):
  vmstate: introduce VMSTATE_VBUFFER_UINT64
  vhost: add vmstate for inflight region with inner buffer
  vhost-user-blk: support inter-host inflight migration

 hw/block/vhost-user-blk.c          | 30 ++++++++++++++++++++
 hw/virtio/vhost.c                  | 44 ++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/vhost.h          |  6 ++++
 include/migration/vmstate.h        | 10 +++++++
 5 files changed, 91 insertions(+)

-- 
2.34.1


