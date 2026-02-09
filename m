Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD60E7C708
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrs-0000qg-TH; Mon, 09 Feb 2026 02:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrg-0000n6-WF
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:27 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fO-CH
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2264380725;
 Mon, 09 Feb 2026 10:39:13 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-Y08qaPb1; Mon, 09 Feb 2026 10:39:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622752;
 bh=l2bD30qo++SwO7wfrvvRCSWbFjmshqujsUXyg0YAAJg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=UrQ+XfspFzKMMFOMSPKgiMmeqkaMBdsET1sn3EItb4L98ZUl2VJqdVsrsWJJBK8kE
 aFumqugAYGW9iShfkTPbYjZ471LbJxX5P/I1MSbgyWsTyL15LJ2cI2miih44Zlg0nu
 pDJ+D2q7EQCd1vrynH6gDpwOc+DM1LADnzXDJ+/0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 00/10] vhost-user: VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
Date: Mon,  9 Feb 2026 10:38:57 +0300
Message-ID: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Here is a new feature to pass GPA addresses instead of UVA
to vhost-user server from QEMU. The details are in last patch
10/10 the others are preparation and refactoring.

The series replaces my first attempt
   "[PATCH] vhost-user: pass GPA instead of UVA"
Supersedes: <20260204092339.211650-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (10):
  vhost: move IOTLB functions from vhost-backend.c to vhost.c
  vhost: use consistent naming for backend handlers
  vhost: rename vhost-backend.c to vhost-kernel.c
  vhost: replace .vhost_vq_get_addr() with .vhost_phys_vring_addr()
  vhost: simplify vhost_memory_map() and vhost_memory_unmap()
  qapi: remove user addresses from x-query-virtio-vhost-queue-status
  vhost: stop reusing vq->desc (and friends) to store physical address
  vhost: rename vring pointer fields to reflect user addresses
  vhost: add .vhost_phys_iotlb_msg() handler
  vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES

 docs/interop/vhost-user.rst                   |  21 +-
 hw/virtio/meson.build                         |   2 +-
 hw/virtio/{vhost-backend.c => vhost-kernel.c} |  90 +-------
 hw/virtio/vhost-user.c                        |  32 ++-
 hw/virtio/vhost-vdpa.c                        |  19 +-
 hw/virtio/vhost.c                             | 193 +++++++++++++-----
 hw/virtio/virtio-hmp-cmds.c                   |   3 -
 hw/virtio/virtio-qmp.c                        |   3 -
 include/hw/virtio/vhost-backend.h             |  37 ++--
 include/hw/virtio/vhost-user.h                |   1 +
 include/hw/virtio/vhost.h                     |   8 +-
 qapi/virtio.json                              |  15 --
 12 files changed, 210 insertions(+), 214 deletions(-)
 rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (83%)

-- 
2.52.0


