Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C43ACA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWrG-00043x-0o; Tue, 29 Sep 2026 08:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBWqz-00043O-CB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:22:37 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBWqx-0003gs-56
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:22:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id DD5F0C08EA;
 Tue, 29 Sep 2026 15:22:31 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown [2a02:6bf:8080:d49::1:34])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id NMh0rl1ZOuQ0-pmrbwd9L; Tue, 29 Sep 2026 15:22:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790684551;
 bh=IgjUAYnwy/SQXjg39yLKtps7TVOC7P63qfYaX1pSwGU=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=UwIsPCOWHaFPzBNsWa/dr3dkPWeM/nrCS1U9mWR1wnYEMGJwEjr8QdNVSE1Z6fvNI
 rxihlC0PYSc/H+dBzl7hHY9G9PwdzvyTnOS+Kh8h8o7jQL44/pKhyzdojbMpbNK5YO
 LnlorSvBP6xA4hK95JBl2MhxOmDEJUTTB2H+WLWk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2] vhost: move skip-drain feature check to vhost-user
Date: Tue, 29 Sep 2026 17:22:23 +0500
Message-Id: <20260929122223.2164612-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Currently, do_vhost_virtqueue_stop() calls
vhost_user_has_protocol_feature(), causing a link failure with
--disable-vhost-user when other vhost backends are enabled.

Move the assertion to vhost_user_get_vring_base_skip_drain(), keeping
the protocol feature check in the vhost-user backend and removing
the dependency from the common vhost code.

Reported-by: Clément Chigot <chigot@adacore.com>
Fixes: 5eb2347867 ("vhost-user: add skip_drain param to do_vhost_virtqueue_stop")
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---

v1 -> v2:
 - Move the protocol feature assertion from do_vhost_virtqueue_stop()
   to vhost_user_get_vring_base_skip_drain().
 - Drop the stub added in v1 and remove the unused vhost-user.h
   include.

 hw/virtio/vhost-user.c | 4 +---
 hw/virtio/vhost.c      | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65889b0776..84918c7265 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1463,9 +1463,7 @@ static int vhost_user_get_vring_base_skip_drain(struct vhost_dev *dev,
     bool skip_drain_supported = vhost_user_has_protocol_feature(dev,
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
 
-    if (!skip_drain_supported) {
-        return 0;
-    }
+    assert(skip_drain_supported);
 
     return get_vring_base(dev, ring, true);
 }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e40481..db8f246137 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
@@ -1503,10 +1502,6 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                    unsigned idx, bool force,
                                    bool skip_drain)
 {
-    if (skip_drain) {
-        assert(vhost_user_has_protocol_feature(dev,
-               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN));
-    }
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
-- 
2.34.1


