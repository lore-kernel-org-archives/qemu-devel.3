Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60663C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mhh-00068V-AS; Thu, 10 Sep 2026 17:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRn-000535-3p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRQ-0002Xe-RL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vKr9lNpyACzOKzz7rZq+Sx8L/PCb2spJh1GK0S9epoU=;
 b=HF/3bRdW2IvbUCmkiiVoryNqfUiMdKAX3ptG8ABVrU70m+JxqMbWvM1rLCjdQdoGRmV2bV
 Y0dryBjDDljrLMbn36RuGLcBed8ncSOkAkO5n0zBoU9jiZ2aNFo6KMOBGwfuoimNhGZAhg
 rG1vKgw717Np1jaZtnlYc8yYY1PezuA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-bA7hPFbkOHS_4pkjjQDYHQ-1; Thu, 10 Sep 2026 16:11:47 -0400
X-MC-Unique: bA7hPFbkOHS_4pkjjQDYHQ-1
X-Mimecast-MFC-AGG-ID: bA7hPFbkOHS_4pkjjQDYHQ_1789071106
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482f763db88so46668f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071106; x=1789675906; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vKr9lNpyACzOKzz7rZq+Sx8L/PCb2spJh1GK0S9epoU=;
 b=J2VfsMArrVvz10/fGbk2c+eck9CxNLpyRm6DF9Pa26k0UqaBl9VnjUau7bOnoemscN
 uYu1Ii5l0S4czuSL9ISyiIeWmtKxpWmbFSWZ0Q+fXZFqtP8hTZ9jBNqd1pACoreR/kcZ
 V7O3iErB2dhfveLrLAi69H8uV9qwYAnM8WvbBaRS0YLzR0xQRUrXl52fkDH73ryuK6VV
 o7TIj3qzZXZblP8IDgTuaxMCRg88bIVEbtwhFiQw6TXdrzNYvnTYZGVWzh8ElAzLahGx
 sdbWdFE3sR0QW3mhP49O+3zeigHANDB8dablx/4LUYDpgeEYeX6Sa2DZNuRlZA9bk3VZ
 xctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071106; x=1789675906;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vKr9lNpyACzOKzz7rZq+Sx8L/PCb2spJh1GK0S9epoU=;
 b=YN/l8cAetOSm2xj2hhaudbbNEtJhQGMLCUyCfDzs2ivTTDye/qvj7rTvTYj9bDW+A/
 y6sYHFp3ClUVzJGFR62rcltKPVFv4rBWm5+N9GtQHBohsyHKFSpd108mBwICJxAuiygu
 E4yheYwUqV4RNm+D5L5Id7NmlO76/G8KbUAYoVki5FEgiBcry/yoXfWASJ5ghcFefA+j
 uVsJfUD1wM4cmliZ8Wg8jPoxUrU4+/pie5ilpView9CM84Y5qg0qMFz3R0ADVeA6QMFe
 PzQvCLuHBcL3E5oXPgbbjIU96mPOBzqAyq6UAhBk6197UVYmjtK9yxmO92sCpJ5J2kiV
 Bniw==
X-Gm-Message-State: AFuF++np4DuYP7hPR26X/pjKW30G/AgaMGWUA8zxGe6GgV3EhT/lNKZS
 1QOXjP9LBYZ1/Q8vrEkaUDlUZC3fIFMcHPFwC1veUsSSGQhCRM7F+3Q47aynmjWzai9nmyEaWii
 rs7+DNTUS/XelV6cXfISnGn/Filqts56ifj+0uP2Wm9/zdFXoqKE1BsVdma98Ds/pCiUXQZe+y/
 5C8kfK1uq+1pClQj02pE+PJWB8u2N5lW+Wsw==
X-Gm-Gg: AYBFou3NpV0Uw5wxjz5Phu6F2smXV8W53CR34Ya83QipFA4lfMhHIG8HsM15mgrUr/Q
 TfavSQ1BZWqGj6B1GskvynbJ0wyvXgKRHI9KcAY7NLGS875VmwgO++J2BGf3Nf8bShlZ/A07nt0
 S9HddpyKIl/6TuAcyILkYTjKSEGjBsoCwGNE44A74AFsgj7uQaaETEC8xS0LrerbgczN2SKiKLV
 maokb7EcUSUMrX7r8RLML/PYPISIfkMS4q61xBkIHQZFc0PJWPPn23VvU9p+aT1JMrZFm7oID19
 yGqt4WEPGXA4W25SEt9agF33jN8Eu2vpNabPGqj/FIwz75c2+JpZiwUHUCOm3uPLrEnPEWK09F6
 f+l+1J9a2DlF7mJzlqlHHvHc=
X-Received: by 2002:a05:6000:2501:b0:486:e5f7:89ca with SMTP id
 ffacd0b85a97d-486eb1d99c5mr729416f8f.8.1789071105758; 
 Thu, 10 Sep 2026 13:11:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2501:b0:486:e5f7:89ca with SMTP id
 ffacd0b85a97d-486eb1d99c5mr729375f8f.8.1789071105219; 
 Thu, 10 Sep 2026 13:11:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35c071sm746452f8f.33.2026.09.10.13.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:44 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 09/90] vhost-vsock: preserve vhost FD during CPR
Message-ID: <d6f2fb920c88663d10e213fe7b765d18d4b12525.1789071042.git.mst@redhat.com>
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Since the key in CPR hash table is device ID, CPR needs a unique ID.
Thus we only preserve the FD with cpr_{save,find} if this ID is present.
In a following patch, when we lift the CPR migration blocker, we're
going to condition it on the presence of ID.

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d8760..cec2c31f0c 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -143,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
     int vhostfd;
     int ret;
 
@@ -170,7 +171,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_is_incoming()) {
+        /* Reuse the fd handed over from the source QEMU. */
+        if (!proxy->id) {
+            error_setg(errp, "vhost-vsock: device ID is required for "
+                       "CPR migration");
+            goto err_blocker;
+        }
+        vhostfd = cpr_find_fd(proxy->id, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -207,6 +220,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (proxy->id) {
+        cpr_save_fd(proxy->id, 0, vhostfd);
+    }
+
     return;
 
 err_vhost_dev:
@@ -223,10 +241,14 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    if (proxy->id) {
+        cpr_delete_fd(proxy->id, 0);
+    }
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
-- 
MST


