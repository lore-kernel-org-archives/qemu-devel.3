Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6CCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xg-0007m1-Lz; Wed, 15 Oct 2025 10:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xf-0007ls-Hd
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:43 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xU-0000e9-Kr
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 54EF6C069F;
 Wed, 15 Oct 2025 17:58:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-NdIXGGyK; Wed, 15 Oct 2025 17:58:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540304;
 bh=IKbrDYzfqGZ1MP25DmkK99IEgBtrTVOgXHAsSgntcCY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=p4UHwpQiBzHthkp8As3f47iPRzRXTycXMfOLAty8z3rLck7D7yOAy9PxHaVNJ0fEz
 qMo+37CjJ2O4QPwCUfTfN6h/TxPZFEFWe10LgQZ2tajsELtIpRdgU67ZoZtJBWSVBL
 kYNRzeNTpHZevX9LmxWEJjcD3nc9AwUYGBCPxKpM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 16/23] vhost: simplify vhost_dev_init() error-path
Date: Wed, 15 Oct 2025 17:58:00 +0300
Message-ID: <20251015145808.1112843-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

No reason to rollback setting up busyloop timeout on failure.
We don't do such rollback for other things we setup in backend.
Also, look at vhost_net_init() in hw/net/vhost_net.c: we may fail
after successfully called vhost_dev_init(), and in this case we'll
just call vhost_dev_cleanup(), which doesn't rollback busyloop
timeout.

So, let's keep it simple.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8c5e434b89..2dba7d53c9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1621,7 +1621,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                                                      busyloop_timeout);
             if (r < 0) {
                 error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail_busyloop;
+                goto fail;
             }
         }
     }
@@ -1661,7 +1661,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (hdev->migration_blocker != NULL) {
         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
-            goto fail_busyloop;
+            goto fail;
         }
     }
 
@@ -1693,17 +1693,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    " than current number of used (%d) and reserved (%d)"
                    " memory slots for memory devices.", limit, used, reserved);
         r = -EINVAL;
-        goto fail_busyloop;
+        goto fail;
     }
 
     return 0;
 
-fail_busyloop:
-    if (busyloop_timeout) {
-        while (--i >= 0) {
-            vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i, 0);
-        }
-    }
 fail:
     hdev->nvqs = n_initialized_vqs;
     vhost_dev_cleanup(hdev);
-- 
2.48.1


