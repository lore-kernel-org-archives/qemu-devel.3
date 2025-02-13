Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3825C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 13:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZDY-0003ls-G0; Thu, 13 Feb 2025 08:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiZDW-0003la-Nd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiZDU-0004sE-Iw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739453118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Qk6Apdpx+tTW7v8TzLJk5s6DWHi87zofCpnQ8mYoDc=;
 b=ikw7HqjpAYnvr94xBNh2nWiTlmD2uafUxO8xD91K7/wXZVZTdiKaf2z7LYusE8HDG/lNk+
 JGJCpulWct0YQTb/d8pOlf7N5A43ZZg6YxIlmx3s/4z4aBMQOBskl9cNsORUduCX90rV22
 m8to7Z47axOixNN8OY0/OphdvsHZigI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ptu45PCAOv6UTSITG7m3dg-1; Thu, 13 Feb 2025 08:25:17 -0500
X-MC-Unique: ptu45PCAOv6UTSITG7m3dg-1
X-Mimecast-MFC-AGG-ID: ptu45PCAOv6UTSITG7m3dg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd1bdf360so657893f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 05:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739453115; x=1740057915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Qk6Apdpx+tTW7v8TzLJk5s6DWHi87zofCpnQ8mYoDc=;
 b=keaUAWnlogl3/IGQ3QBPxGDQBns4suu4as1QL28M+/uisINCyjk1Q++wgrj+mJVaS8
 +RsZZmPwAQNNp9kZ1AysOy62S5ZoMOwKu5Wi02Fj1SGkgIfboWkoHCsVi3r4bqVCwJaR
 M2+Pq5rtg4FZL/wV+dcD6nlduDkrvH7Qx98wgrmq0ou6okFDRMAHbheJI5PCwA69N37y
 XYFONR9HrXGmqFL3veYJU+hBnlrrDR+rfQ/y9OZ+kVPRYcvgO90Q0qaF5btWoRNtXXWg
 X2ZwCbXqY/+Dx1qMlXldlDs/6iCyG7NVLcUzzZ5t5Sf0eqCSFdwYQIR0/NjZ8gZ4BS6w
 QdnA==
X-Gm-Message-State: AOJu0YzJnuC2ao2aJs5yOeht/8yoPcO8w3dYsZZ6axVXgENs8ziF0QlP
 KPMAmAMExUpDERGS7WF18i7NloQL+jtQMVqGefr1aV3l6r4mhiHAIGyiK0/m2oaKJe++9v/S4Az
 K2+T+9YJf95g4HxOYIBkiSDZVTqAZLNvYpMgoKNuA8T6oDXYcNsIL1/MAp+XA47zOItm/ekzuvE
 i5W616tq191uVRzF/u2LhokPqUIaI13OL2jrEK
X-Gm-Gg: ASbGncuL+EkPgOEBEjh51zMziNf1BvgzkOaj89/uTM8GcXASZbMTl2bjq8NFvMyE5M+
 +5Qz7OBsCPygXgL9mJYn9uxsaL3W4jtjId+vzS/P7gTZnq9nJ/Syni6acLw/FtjJXIrU4eDjF+z
 s+iyqV8eD2hgX/5cT5tOQeBZ3jij06drhXP7l1qH7E2yKhC9qhw7bFgjaI9+lousQuIVSWPnGGM
 3AM3oRigoKMt+wM7pTSgSzQrIn6pF6lAiO7CHbIV+ZKL5mTWmxOhb5UdzgGN+2qsORgKUvAiwBG
 /rZSD60j
X-Received: by 2002:a5d:6c68:0:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-38dea2e82a6mr7347904f8f.41.1739453115086; 
 Thu, 13 Feb 2025 05:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFTd0APPqUN6x64SdzoiH0fzu74EBNOm+VerOdMggLSEmGCVLsY1YW5Q4dOO2emnrdJQr0Jg==
X-Received: by 2002:a5d:6c68:0:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-38dea2e82a6mr7347850f8f.41.1739453114636; 
 Thu, 13 Feb 2025 05:25:14 -0800 (PST)
Received: from localhost ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fdce7sm1892428f8f.96.2025.02.13.05.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 05:25:14 -0800 (PST)
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Date: Thu, 13 Feb 2025 14:25:13 +0100
Message-ID: <20250213132513.767709-1-mvaralar@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use virtio_get_config_size() rather than sizeof(struct
virtio_snd_config) for the config_size in the vhost-user-snd frontend.
The frontend shall rely on device features for the size of the device
configuration space. This fixes an issue introduced by commit ab0c7fb2
in which the optional field `control` is added to the virtio_snd_config
structure. This breaks vhost-user-device backends that do not implement
the `controls` field.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
 hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 8610370af8..8da4309470 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -16,6 +16,18 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_snd.h"
 
+static const VirtIOFeature feature_sizes[] = {
+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
+    .end = endof(struct virtio_snd_config, controls)},
+    {}
+};
+
+static const VirtIOConfigSizeParams cfg_size_params = {
+    .min_size = endof(struct virtio_snd_config, chmaps),
+    .max_size = sizeof(struct virtio_snd_config),
+    .feature_sizes = feature_sizes
+};
+
 static const VMStateDescription vu_snd_vmstate = {
     .name = "vhost-user-snd",
     .unmigratable = 1,
@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
 
 static const Property vsnd_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BIT64("config-controls", VHostUserBase,
+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
 };
 
 static void vu_snd_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+    VirtIODevice *vdev = &vub->parent_obj;
 
     vub->virtio_id = VIRTIO_ID_SOUND;
     vub->num_vqs = 4;
-    vub->config_size = sizeof(struct virtio_snd_config);
+    vub->config_size = virtio_get_config_size(&cfg_size_params,
+                                              vdev->host_features);
     vub->vq_size = 64;
 
     vubs->parent_realize(dev, errp);
-- 
2.42.0


