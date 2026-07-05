Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA30C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNxm-0000Vp-45; Sun, 05 Jul 2026 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxN-00008u-CU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxK-0001Zj-MU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KL2DF1MGtq5gbiVrCmWbVvM0UikmTGQObA8JzRTFGAY=;
 b=gaP22wKojLCH3Cm6wt+hZL8F4bxo/s4bA36vSl+X8Rat/K7hdZ955GWi6mLMLlMjx51SHm
 w8sTwfAa8GqaCx2RW3OhJ49CVhbuxYuWT0V86XaWOelAYlUnECHn3ojOjTzcx6yUx24sF2
 ++LRXokdUdI8wBJc4acc9dLgeFqPqTU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-bwuJ-5cmPPyxkD9rX_qWsw-1; Sun, 05 Jul 2026 10:36:24 -0400
X-MC-Unique: bwuJ-5cmPPyxkD9rX_qWsw-1
X-Mimecast-MFC-AGG-ID: bwuJ-5cmPPyxkD9rX_qWsw_1783262184
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4740be00302so1740914f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262183; x=1783866983; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KL2DF1MGtq5gbiVrCmWbVvM0UikmTGQObA8JzRTFGAY=;
 b=Pant4TPWE2JFEL6ZUu99Mq1bOOSZXuaQlZi77S7oeZYgOKYf2LRqLFPxPXBQayPwNM
 Jr7m0MnEPj9/dpDD2zOutHCCgPv9JQBLAVIKnn6VCtLsnTsU+zjngeyiTUVE60G9gjM7
 O6X9XlatuVjlIGYKOJYEeGAOxAuhx+vAtq/S/VlUupOKXVXjDYBbyPhoSPCZUwOLduNS
 BBsU6BFxbKI3IM3feZktCnEA/LH/a9P5FGy/juPoinlja7R0HCqPoLnBtNzBazU24UYa
 KHLBnOdaXlKOM1GG6uUkdV7fShaoivPU+H6GUap+xEsaEWCi1mrSfYhF3cVnqDD/0FNP
 AUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262183; x=1783866983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL2DF1MGtq5gbiVrCmWbVvM0UikmTGQObA8JzRTFGAY=;
 b=dcdSGeitxAsICl2M1Y3mllBJzUBSycoFJZVC/UCxaJU3PaVPg7four8/0rY/cfZPeJ
 ngLj2GBtIS8cva4/P6vw7J9XzmrlkJKPYEMMMEeQHp60uXt1qa+Nv5BfB+xweWQyFTl/
 C4TcPj2BFCH6vuvllxh9PhMqm/8rs0gca6CWB6QmfPUTC7gkMnE2+LZ9dEe9lpyDZ4Ah
 ym7644bJfi3v7EFAqCihctp6mv9TsmwV0eeOKswpIi28DXwANclBvGIR4o8A8aBDLpMb
 bKYp/jW7G0aw4Eyox7rjnc3J7dBiE+HNIvsEo7ezOvNzvVVt/PUNXzuX+ZMje1ES0Pag
 uTzw==
X-Gm-Message-State: AOJu0Yz8EZgDC7WUFN9kMsHTRPWD+fzkubvyipuOuFbhgKu5NE7rUKBO
 vLAWTr77IASQMJHLv8Bh8ISIDAc/EuCXdjP+hbLOwthB+9kPqP7ZM+BILgpZt0qqEEozyp3jHrZ
 Cms8JGEyNx5bdFD59VdWl9fobaEprsBAcMlFR9If5le+gJQ9vZ/vBsLWCp4+GpKmwGp1tsM54aI
 3REmMOlYcaiP4ZWps4Tq4eVCXxNDaURtOGgg==
X-Gm-Gg: AfdE7ck1BaolUPFfZH0p/SYkumAX43c+1p7IYZRmmPp1niv6G7dqxl2zc2gNbDcAf5O
 agdXAk4HkqOIqo/eBIKf5vWZ6aGfpH1ENrrpQbJhCKFPkYDX4GaVIVk1gdFEmGgsCQvQYJtfeEM
 5IPJpD5tmo1LaXYpcd0aTD2MUbE2xoPazBtA1ULvI0nRIii8EnXZdyLTOb9fg8aIjm4LRc8bIb7
 H10+qEcdq5Tg3wyS41pG4I/lZH59bVm8Ps23tXBsLuAnMkfOnrKHZohWnBfFrfCIS60z+aYHoAb
 wzXBIFxHh5/kzH0TvVnCtPRJGymIKCPoFqHQZc8lnSLiWmz4ST4zEy1+3GhuDo2xfRnxaAf0R6y
 GRv2H7qUU/C3rKXfTuHRDjsKHNJGjmTTx
X-Received: by 2002:a05:600c:3483:b0:493:b782:10d9 with SMTP id
 5b1f17b1804b1-493d11d7d6bmr80846105e9.10.1783262183386; 
 Sun, 05 Jul 2026 07:36:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3483:b0:493:b782:10d9 with SMTP id
 5b1f17b1804b1-493d11d7d6bmr80845645e9.10.1783262182779; 
 Sun, 05 Jul 2026 07:36:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d620sm219513205e9.1.2026.07.05.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:22 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>, Milan Zamazal <mzamazal@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 42/44] vhost-user-scmi: free vhost virtqueue array on cleanup
Message-ID: <cecd7a11df7b7fdfccc60fe50cc78e75635db886.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vhost-user-scmi allocates vhost_dev.vqs during realize, but the
cleanup helper frees scmi->vhost_dev.vqs after vhost_dev_cleanup() has
cleared struct vhost_dev. This turns the free into g_free(NULL), leaking
the allocated vhost virtqueue array.

Keep a copy of the vhost_dev.vqs pointer across vhost_dev_cleanup() and
free that saved pointer from the common cleanup helper.

Fixes: a5dab090e142 (hw/virtio: Add boilerplate for vhost-user-scmi device)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630072728.3025097-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-scmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 9470f68c1f..02dc088ea9 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -220,11 +220,12 @@ static void vu_scmi_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserSCMI *scmi)
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserSCMI *scmi,
+                                  struct vhost_virtqueue *vhost_vqs)
 {
     virtio_delete_queue(scmi->cmd_vq);
     virtio_delete_queue(scmi->event_vq);
-    g_free(scmi->vhost_dev.vqs);
+    g_free(vhost_vqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&scmi->vhost_user);
 }
@@ -233,6 +234,7 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+    struct vhost_virtqueue *vhost_vqs;
     int ret;
 
     if (!scmi->chardev.chr) {
@@ -252,13 +254,14 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
     scmi->event_vq = virtio_add_queue(vdev, 256, vu_scmi_handle_output);
     scmi->vhost_dev.nvqs = 2;
     scmi->vhost_dev.vqs = g_new0(struct vhost_virtqueue, scmi->vhost_dev.nvqs);
+    vhost_vqs = scmi->vhost_dev.vqs;
 
     ret = vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "vhost-user-scmi: vhost_dev_init() failed");
-        do_vhost_user_cleanup(vdev, scmi);
+        do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
         return;
     }
 
@@ -270,10 +273,11 @@ static void vu_scmi_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+    struct vhost_virtqueue *vhost_vqs = scmi->vhost_dev.vqs;
 
     vu_scmi_set_status(vdev, 0);
     vhost_dev_cleanup(&scmi->vhost_dev);
-    do_vhost_user_cleanup(vdev, scmi);
+    do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
 }
 
 static const VMStateDescription vu_scmi_vmstate = {
-- 
MST


