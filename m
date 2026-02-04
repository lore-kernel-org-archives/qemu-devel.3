Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD9AEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCK-0004iH-DT; Wed, 04 Feb 2026 14:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBT-0003Bn-K3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBI-0008Fn-1j
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BHV9CRtIc65hjBzMkzz5+7e4XSr1yitt8eUrbCO0Ung=;
 b=Rsv71bbaF3qQtndm7YDQbC9bt7+XsZFY7MOJY/NlMz6xOaK6rQ+dddVcm8RrlBDlahvkWc
 ix5CrxoPyboRiGVNf9dhRkPRttWembckbIynkh/WDZpQwQvTYNfM9FwexEGUdq9tTegSU4
 a7go52L9LPry0VxaWNwyXWEebWrFYEw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-NSLfXvkCOWGMaolB0lsskA-1; Wed, 04 Feb 2026 14:04:46 -0500
X-MC-Unique: NSLfXvkCOWGMaolB0lsskA-1
X-Mimecast-MFC-AGG-ID: NSLfXvkCOWGMaolB0lsskA_1770231884
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so763955e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231883; x=1770836683; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BHV9CRtIc65hjBzMkzz5+7e4XSr1yitt8eUrbCO0Ung=;
 b=X2ega7iZWDbbIfGVIfakEEHmEOQw0WBD1Stij3+20tOFCQ6g2cKugb7HUQmLl5YIqM
 by8wBSESUOcuFgfaDFMpoDZZQ9zm9uS0Kq8pYj6ND9uCOc1ZQGs2x4LAukl2E3q9kWjc
 cTdgWbLNg4wpP5bHJwbmkpXXkjqMt8ghQpGVjoXCRW/jmmQ6SZBpDjkDQki5c5Q0CHnR
 gWf/LeTMxMEb0Vr4+mp8ZOM7xhD/qXWQM4JlF8oynavKOI5fosORc3zTK7EyLqqc9JRF
 QaZKXi23+LVFn1qShSSDOZeMhrOGSCwyvCUzlw5wM9f4QrJ+n8g4TVnnmHI3KW9wTiVg
 ye1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231883; x=1770836683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHV9CRtIc65hjBzMkzz5+7e4XSr1yitt8eUrbCO0Ung=;
 b=f0hO2j/1say0GvxOPugH3yMuAic5eXneySIUH8kNVz7rUlj+hLccSXKj2i6SQ54O2p
 dDrr/L3+KcwiHrIIGrrg6aFFUqlTaDyqFIFA9mt+RcnM4/oQAGuks0ANy1aXPFYDNO5k
 aQsKfBQaZeNzFoERi2Po8t2pSEVPZAugWMr7ATqOO3RCfLj1RObwYWwUt+M9BPhMmggi
 pSNaq/ax22tKitXYiXM8WTjapSBk+2gusSgXKP3PS6mJDGdeg4Ts51aELjBz63Ks6+rY
 0d/IcpJm61m56xPUMqSRINI3GFRkUQMCysU+m+cUjFq9NoxDkrDug+Og0tnC6oe1DCVY
 J/uQ==
X-Gm-Message-State: AOJu0YzO9gkJ7NJQ6Tu9nqh+nIbLNqZU41iriAQx64e+zH5eduyRGMt7
 7UvMR0aU5BgogpbjBnoFco2TOrVyFyJpM4+8PnE8aUW06AUMOPxSvJhn9pEcyFwuR3ycLZg2FHu
 wK0FzP8ALu7Q4G1E4oWeoDK+x/m5AxVhH8BJ4uVFNL20WCJ+8IzqbA6Cw/RJfJGHMiJ7eC+98Gn
 beGizVC4OYWOSvqU4wVckhfc6AhHSPPRqA7Q==
X-Gm-Gg: AZuq6aKGIrch90SHQsCETvjTkf7vOHXivjSvDI5ozQY2DEpm3tSCzjyW80mjMjG/i8i
 ByWQ7zd9uSlARZSMUbLVzmakUnjkBa2AZU+8/o6PRt50tGdUkW4S70kA5jh670u8YDxA/7DRRIs
 DGBndUQCToqb/5A+XZZK9WYTzwzYF9DkmaFGb4rr4jtui0V325QwOqbLMMwzjlKhjvYTIwyH2Zn
 piGiJLTmxeK6ztyKyd4S5Q8l8oR88jTZHybz7zZi1QuelwpYRhUdJdRC4Hm2bqyxfhKJBg/DDLN
 sQt/k2twL89nXsBCFNk4MfHF/c4bPKUil2JXyUlzlB6lNlN9JzMT3n9Qkc5rm7CpRcVJwFk4Lw8
 yjKpIOyoLHPeC/7aye5pwbqAtM00nXNLOQQ==
X-Received: by 2002:a05:600c:1988:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-4830e9913afmr53018555e9.33.1770231883407; 
 Wed, 04 Feb 2026 11:04:43 -0800 (PST)
X-Received: by 2002:a05:600c:1988:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-4830e9913afmr53018065e9.33.1770231882929; 
 Wed, 04 Feb 2026 11:04:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3f007sm7648095e9.9.2026.02.04.11.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:42 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 49/51] vhost-user-blk: support inter-host inflight migration
Message-ID: <2e6dd85eed340e12b523a548970a47550be9ac44.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in
vhost-user-blk.
Thus, during the qemu migration, with feature flag the vhost-user
back-end can immediately stop vrings, so all in-flight requests will be
migrated to another host.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260115081103.655749-6-dtalexundeer@yandex-team.ru>
---
 hw/block/vhost-user-blk.c          | 27 +++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/vhost.h          |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4d81d2dc34..c151e83677 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -353,6 +353,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
     s->vhost_user.supports_config = true;
+    s->vhost_user.supports_inflight_migration = s->inflight_migration;
     ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret < 0) {
@@ -568,6 +569,26 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static bool vhost_user_blk_inflight_needed(void *opaque)
+{
+    struct VHostUserBlk *s = opaque;
+
+    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
+
+    return inflight_migration;
+}
+
+static const VMStateDescription vmstate_vhost_user_blk_inflight = {
+    .name = "vhost-user-blk/inflight",
+    .version_id = 1,
+    .needed = vhost_user_blk_inflight_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
@@ -576,6 +597,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_vhost_user_blk_inflight,
+        NULL
+    }
 };
 
 static const Property vhost_user_blk_properties[] = {
@@ -591,6 +616,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
+    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
+                     inflight_migration, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 8158d4673d..1e41a2bcdf 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -52,6 +52,7 @@ struct VHostUserBlk {
     bool started_vu;
 
     bool skip_get_vring_base_on_force_shutdown;
+    bool inflight_migration;
 };
 
 #endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..89817bd848 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -554,4 +554,10 @@ static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
 }
 #endif
 
+extern const VMStateDescription vmstate_vhost_inflight_region;
+#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
+    VMSTATE_STRUCT_POINTER(_field, _state, \
+                           vmstate_vhost_inflight_region, \
+                           struct vhost_inflight)
+
 #endif
-- 
MST


