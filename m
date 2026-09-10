Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D427C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4o1z-0002vG-Jp; Thu, 10 Sep 2026 19:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljr-0001gH-PZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljd-0006Qj-Ab
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDN3cLo5Foi5JRgDpkjb/YszGiugJ49+7UhR/BkZU+s=;
 b=BM5PFcHDt6fWBHFYUiVvN/oVdUweCzrET+0c8eAi+HFzxErC6wlw329KdFbd4QTx8m1bX+
 Mfwg9yA+g+ipIXm/rZ/98ATJquxcA6mFTXfSNVw36fz3gVPfls26ctGpWsnm1bswEkWQu8
 kDr+sVlCn0lSD5fNur/ebXSE30nDmoo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-jm-2IrCTP-6nxo4TkFr-sQ-1; Thu, 10 Sep 2026 16:15:56 -0400
X-MC-Unique: jm-2IrCTP-6nxo4TkFr-sQ-1
X-Mimecast-MFC-AGG-ID: jm-2IrCTP-6nxo4TkFr-sQ_1789071355
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccb223bceso1395205e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071355; x=1789676155; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UDN3cLo5Foi5JRgDpkjb/YszGiugJ49+7UhR/BkZU+s=;
 b=Ko0ElNpJyd9VCx19xFx9vtcYbG43+ZhcVOL4cVAkOLk9kFQ5tQQqvuCKnBS58vKAOU
 5E/75ph0Up5uzk1PL1bQNb+yi4naypnIbjdudoFtH+BfsIhuyj0p5IhBtrTWYmWCG09x
 v27i4m2NB/J72/Fb7zoDSBYEWsuaqqu0+1e49z2LN4gGfNkY+nf0xCBY8luPAji/pU2O
 qOjlnUeC2sWLX7xFErlaBeXI38rZZ0+QMhp68NtKURElJ1YgwhzFM4gf7gswcQ3KFcaO
 ANwtShYITSodO84Yi0pFZZsS3dc/a7oijxTzUBb4zTaaLIYK/Ijqc/ywK6UrdvLJVvyg
 x1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071355; x=1789676155;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UDN3cLo5Foi5JRgDpkjb/YszGiugJ49+7UhR/BkZU+s=;
 b=Ng0RzHBjLl2dYBlnzaPyo9ZqlrxHbIFzdjw6o0lk/XVB+IF+Qae0wzM4IhLPuN56I/
 +RPbCI/ePQcRYR4waJUVlNcknnfbVrXTW4//FbZmSCmn1YiClXtAEKyAuB2P/MpRlZGM
 ycvumelqtVLoc+t4kmqW+s3YqMdP3+IB+V5S/Fi6ccBZsEJwn4Ti6su1ulioDMW9qf+i
 jUNI6JOs7QWS07dyfTRCugg5tGHntw0t3fv70l52HMGK3CJoWs+ldCc01gnjlmfWKDtw
 7kEwl/Lg328N+OfvAQfFRdN7ZLnHhq2uEsZuCFZoQ/+3IU3EwZ6xXnlF/O5TyZ22WidP
 ndjQ==
X-Gm-Message-State: AFuF++l0lK0H02ccu+/Her9VYndV7vw5aBy8YsxnhwNueS8WEWKvaCJB
 ZdShdDYOZuiFCFS3xw6xrRrS3pvDVs4ZNKE+0CSCpQaS7RN6KcMmhE2Ab2XG3n9ufVVVHijn1Z/
 rR6xvyIX4jd7+NXAHgRkzjfUhIRUrBmGCtu2MhIKkoK/rrKvEhsGEXx+gg+Hljw6Y/KYlUqw2sn
 ETfXmDk8WwFrEnhLO7A4n1sPIb+cDj2p3ClA==
X-Gm-Gg: AYBFou3QxEf/Ebu84EclCGpMujpd4SLLb+5aNAwwPW9YglFe45NHuk8vn++0zHDKt1q
 NGj8dX0z61ek/IxHSjTCbo1VKHT3slKyb5XLoACRr09bd5m7S+rNtc6KPl2BFehLk8/B9WwE1fK
 EbsWSzz4lrfZav8ECr/NiFOhaqxqSMBxzv/JzpkK6JMr+h8+vmbNqjlaNfQ+HcmrDtq0BAOKlS6
 Kd2kxNqZ/R9OZg1ZcGhT2xB29bl01HJW/0/DJlfNMQVprXZsPp6dowSCw56ESN3gpIDzSVAHxMC
 kTF9FiPl8KXAXD5v3H2w+D0Oa1qYwej5HxAlrZZL8I3p8ipEGxjzzT8sxnicZxheEoJn+UY9Kmw
 7MgoGcPFWkvWTWq10Vn0hjRY=
X-Received: by 2002:a05:600d:650c:20b0:49d:1d38:b5f6 with SMTP id
 5b1f17b1804b1-49d26d7c52amr65751135e9.5.1789071355017; 
 Thu, 10 Sep 2026 13:15:55 -0700 (PDT)
X-Received: by 2002:a05:600d:650c:20b0:49d:1d38:b5f6 with SMTP id
 5b1f17b1804b1-49d26d7c52amr65750555e9.5.1789071354278; 
 Thu, 10 Sep 2026 13:15:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm727741f8f.36.2026.09.10.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 89/90] vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when
 inflight-migration is on
Message-ID: <d69f24374c7de984e048b03baa3cfda41998e6f0.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Currently during live migration vhost-user-blk sends GET_VRING_BASE to
stop vrings, which causes the back-end to drain all in-flight I/O before
returning. This blocks the migration source until all I/O completes,
adding significant downtime proportional to the I/O load.

When inflight-migration is enabled, send GET_VRING_BASE_SKIP_DRAIN
instead. This instructs the back-end to immediately suspend in-flight
I/O and record it in the shared inflight region, which is then migrated
to the destination host along with the rest of the device state.

Since inflight-migration can only be toggled while the VM is running,
i2ts value at stop time reliably reflects the intent set on a live VM.
There is no need to check migration runstate to decide whether to skip
draining. Using GET_VRING_BASE_SKIP_DRAIN on a regular VM stop is
safe - the back-end records any in-flight requests in the shared
inflight region, and they will be resubmitted when the VM starts again
via SET_INFLIGHT_FD.

If the back-end does not support
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN,
migration is aborted with an error in pre_save rather than hitting an
assert at runtime.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-7-dtalexundeer@yandex-team.ru>
---
 include/hw/virtio/vhost-user.h |  1 -
 hw/block/vhost-user-blk.c      | 29 +++++++++++++++++++++++------
 hw/virtio/vhost-user.c         |  3 +--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 47c13f8677..78b4fba27f 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -73,7 +73,6 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
-    bool supports_inflight_migration;
 } VhostUserState;
 
 /**
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 3eaaa19719..3dade143c9 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -141,10 +141,7 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
 {
     struct VHostUserBlk *s = opaque;
 
-    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
-                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-
-    return inflight_migration;
+    return s->inflight_migration;
 }
 
 
@@ -245,11 +242,13 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }
 
+    bool skip_drain = vhost_user_blk_inflight_needed(s);
+
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
-                       vhost_dev_stop(&s->dev, vdev, true, false);
+                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
 
     err = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (err < 0) {
@@ -381,7 +380,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
     s->vhost_user.supports_config = true;
-    s->vhost_user.supports_inflight_migration = s->inflight_migration;
     ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret < 0) {
@@ -608,10 +606,29 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static bool vhost_user_blk_pre_save(void *opaque, Error **errp)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(opaque);
+
+    bool inflight_migration_enabled = vhost_user_has_protocol_feature(&s->dev,
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
+
+    if (vhost_user_blk_inflight_needed(s) && !inflight_migration_enabled) {
+        error_setg(errp, "can't migrate vhost-user-blk device: "
+                         "backend doesn't support "
+                         "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN "
+                         "protocol feature");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
     .name = "vhost-user-blk/inflight",
     .version_id = 1,
     .needed = vhost_user_blk_inflight_needed,
+    .pre_save_errp = vhost_user_blk_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
         VMSTATE_END_OF_LIST()
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index faf9c8aedd..047058833b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2598,8 +2598,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             }
         }
 
-        if (!u->user->supports_inflight_migration ||
-            !virtio_has_feature(protocol_features,
+        if (!virtio_has_feature(protocol_features,
                                 VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
             protocol_features &= ~(1ULL <<
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-- 
MST


