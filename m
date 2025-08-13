Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBB3CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg0-00033i-It; Wed, 13 Aug 2025 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfa-0002jU-65; Wed, 13 Aug 2025 12:49:47 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfG-0007qv-8T; Wed, 13 Aug 2025 12:49:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D9AC481259;
 Wed, 13 Aug 2025 19:49:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-QFZ44R64; Wed, 13 Aug 2025 19:49:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103755;
 bh=VPbxO6D/t+j8eJzppYHqMzsC4Sbs99/uhBFVd/OZPjI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ea3AL6gxiUKcNUZcyF4yqL+3hSjogHa5fphT1N7Hr04DWaN3lwVZsJWGMOl7QifTt
 JefYJ7/GD6WxtgUqKH3zp5JZuw+V/XzpObwzm4d7PQOuD6HGkF/7JQw04OqIix4HCw
 rn5d+ERhsFPqvIHVqbDmVDiTBdLAlA9hAQ4xcLX0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 16/33] vhost: simplify vhost_dev_init() error-path
Date: Wed, 13 Aug 2025 19:48:37 +0300
Message-ID: <20250813164856.950363-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

No reason to rollback setting up busyloop timeout on failure.
We don't do such rollback for other things we setup in backend.
Also, look at vhost_net_init() in hw/net/vhost_net.c: we may fail
after successfully called vhost_dev_init(), and in this case we'll
just call vhost_dev_cleanup(), which doesn't rollback busyloop
timeout.

So, let's keep it simple.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f6ee59425f..a3620c82d8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1602,7 +1602,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                                                      busyloop_timeout);
             if (r < 0) {
                 error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail_busyloop;
+                goto fail;
             }
         }
     }
@@ -1642,7 +1642,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (hdev->migration_blocker != NULL) {
         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
-            goto fail_busyloop;
+            goto fail;
         }
     }
 
@@ -1674,17 +1674,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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


