Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E20C678DC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sraI0-0007RA-3o; Fri, 20 Sep 2024 05:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraHv-0007MV-Kl; Fri, 20 Sep 2024 05:50:55 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sraHr-0000w1-CK; Fri, 20 Sep 2024 05:50:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a13:0:640:f32:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4C82D60C70;
 Fri, 20 Sep 2024 12:50:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b599::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LoLjH00IlKo0-u0ndMZ5U; Fri, 20 Sep 2024 12:50:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726825844;
 bh=eOwQm5ZmixkOT1Q4uAW+GaFrdyOjmWDpuAQLUhvggfo=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=YtBN70hgstD2m9d3eRd0yp64g3bwRmrZuxRHOBbCm3eXV1MP4E6XELt09QUffdnEd
 ILU1y8TFJTsD1vyI0KPFrBxzFHah9nfm3tZHSsdkfGYP16Z7l+HYgXUZbLn0xrZhCV
 ++SmCZ1xbfWrfUXjoxQlapfsDNxS/S2OWOfS8Fb4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 0/3] vhost-user-blk: live resize additional APIs
Date: Fri, 20 Sep 2024 12:49:33 +0300
Message-Id: <20240920094936.450987-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v6: tiny fix: add document comment for sync_config field to fix qdoc
generation. Also, add r-b and a-b marks.

Vladimir Sementsov-Ogievskiy (3):
  qdev-monitor: add option to report GenericError from find_device_state
  vhost-user-blk: split vhost_user_blk_sync_config()
  qapi: introduce device-sync-config

 hw/block/vhost-user-blk.c | 27 ++++++++++++++------
 hw/virtio/virtio-pci.c    |  9 +++++++
 include/hw/qdev-core.h    |  6 +++++
 qapi/qdev.json            | 24 ++++++++++++++++++
 system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 108 insertions(+), 11 deletions(-)

-- 
2.34.1


