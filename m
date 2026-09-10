Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE89C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nxi-0001MJ-N5; Thu, 10 Sep 2026 19:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lj1-0001Qy-V2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4liq-0006NS-34
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kSbe3EQQwukUniN5j1YO+Sdv0dG67Pln7DjT7x+CNQ=;
 b=IBCPaEw0D1E17zKr4JIMsK5J84F51LkS3yEeEFlGuVytI0uVuizFg9JU3saADzLCHM0Y5y
 9iJQqoFb2gQauQkpN1PjzC/67wv7/uRR4pl2KQRit0l0kt4EkSLpTAFSkQOG2M+EGHPZYD
 rWmrnvQbxd4DuWvoFJMGxigRNjk/Dwo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-aP7WvBgFM1qYbFA-9iT1yg-1; Thu, 10 Sep 2026 16:11:37 -0400
X-MC-Unique: aP7WvBgFM1qYbFA-9iT1yg-1
X-Mimecast-MFC-AGG-ID: aP7WvBgFM1qYbFA-9iT1yg_1789071096
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486e8fb7d75so35323f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071096; x=1789675896; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6kSbe3EQQwukUniN5j1YO+Sdv0dG67Pln7DjT7x+CNQ=;
 b=IGkzX0nxQLJfSUKzVtjOf8tIl9B1B7Rw2il3uyZNrrNICFuYg/vsM4AZOT0p8OZ59F
 ufARGPrkLAZe+qJtpzlLX2RDR4RbplJdxpTr5FjqGvv605z/gSgA87LPmyIqc+yMXfZL
 JAWAwxmhOK2+DfASI1rbQNVhxjWklZkeTnM3SxuuYySZgU5vdIaEL2hNE7gnAvsFb8rM
 hg6dxWKTXJkJr7n6hQi/dK+Gg5OkxxLNIkXqA2sAIUwbj1aR5vDBj2ZC/EnMZkjhYE2M
 pelH3tqQUuFr737LKZa/8KEk9ebkf+A9QZclXbqYwqR86xBotugau8E8LlGme8SiTw2E
 PhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071096; x=1789675896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6kSbe3EQQwukUniN5j1YO+Sdv0dG67Pln7DjT7x+CNQ=;
 b=ZgRTKWrGWX4dAbOJZ1D3TgQSooPojkRx3cotcu3wjB2DDLO78Sv/M28cyl4MfdDKRa
 7TUtTTueTIFeXFELp8/UHP9TYv3nK70MtQphi7mDPURbATJSh8DUH9GmjLRrb4PmN31w
 MJ07DzBlGqsT0RfdHS/ZXUKgs6OFC0inIDunUGgadq+CTB1r7KDWWxwOrZ2yjTD4kYi5
 Kq4ccPgUFKOrlKmRpzm2qhW5gJoeplYTUGATpTj7mWHm7jhV/s1frX/wX5zN1rg7U4X1
 6nRbJwSx5W0OmlwOMlZtNUnkYZ7JLLaoRBwNe2zdyXsbbO81yOcp8LXBlUn/enRdPdwh
 k4Xg==
X-Gm-Message-State: AFuF++mQeAURM57N3lOr3Gzj0KZcn/yjwdtd+EwxSIEeuF/QBn+UA/Wf
 ni/CMUt3iFvuCNknnH+wuFRQiM908bKkp0eNe6mtV030i7FQ2FHQaRhk2epJkT3xR0blxTTUJYs
 VUmu0CvdfN8McJWAmPdFBM8JlmnP8CpnBmFmymvx95y4qAwVkTKnh5MbClxkcdm/Omm3dpzCZoI
 N6/mmkU42Ur3Ehwj2Cvo8fUKVygwVEU7WCGw==
X-Gm-Gg: AYBFou0n6As3MLfCItLS5NxgD4pdYrBoq9CVGws/oqlr3BkqkQgNxWIAPm+LUlDEfwX
 eh6g8ca3a8YGYId7OVqlkm9ZFLx+Z5erWwMkxXZmtFY48ZkLGKS78NL1w8/Ua4mkpoZU0EwOb0q
 WP+rxFKvqf4zUhfA1leGCuQFqRQfVR72h5awWciNkvA34BE0PdGYOLCNr2TfyyhjuO+pZ8SdclS
 R5+RUCiA/zqjX1SNY44oIoCLPIbWWE59ue/W4n6vFWnpaYVpGoeTYTs2M6nFYk0VcmYoMoXsdtn
 B8yfUO1GYgAsp9lM5yqy+QuwU3Ya/qazwDUxlzTi5/c/usH9vQ+4/E6DoNpf/6kX0+BNCjTfZHS
 nQKQZFhJd8Fb9GP9+Gs2STaQ=
X-Received: by 2002:a5d:630b:0:b0:484:3311:3176 with SMTP id
 ffacd0b85a97d-486eb2feb3cmr485934f8f.23.1789071095824; 
 Thu, 10 Sep 2026 13:11:35 -0700 (PDT)
X-Received: by 2002:a5d:630b:0:b0:484:3311:3176 with SMTP id
 ffacd0b85a97d-486eb2feb3cmr485903f8f.23.1789071095246; 
 Thu, 10 Sep 2026 13:11:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7d4sm904984f8f.8.2026.09.10.13.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 05/90] vhost-vsock: block CPR migration modes
Message-ID: <506207fc2f814c2b4aa72d44977d10f4b4ea1285.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-2-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost-vsock.h |  1 +
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c7..a964d57e1b 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb165..503d248a61 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
-- 
MST


