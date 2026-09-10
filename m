Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87ACC88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nw7-000198-Da; Thu, 10 Sep 2026 19:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTR-0005q8-BQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lT2-0002bw-IK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXlvSlMUeFS1LC0HetGaOS9EPv1rV9NRjwcngeZp5O0=;
 b=amMTJllUuOSh0p1za69NeMHCewX6688lqwGZITknNLTQMK55YIBIcOSHVSBv/Fub9pltJT
 nKqv0k9DqJMkSwbW3xlsoueonz5ZgQ5cFTRvkm9MV9COV2PQYOWSOV26Ga/A//iYVGcOhO
 RHgwEuBimKUBtRm8Q13J+koZrSHWAUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-RJQ_XtX7NrerKCOauaaPjQ-1; Thu, 10 Sep 2026 16:11:53 -0400
X-MC-Unique: RJQ_XtX7NrerKCOauaaPjQ-1
X-Mimecast-MFC-AGG-ID: RJQ_XtX7NrerKCOauaaPjQ_1789071112
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4843e59c32dso62850f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071112; x=1789675912; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DXlvSlMUeFS1LC0HetGaOS9EPv1rV9NRjwcngeZp5O0=;
 b=m7Xqr6SeNt180gwGGZDjQmVrJonO6kzuuXBXcZlmR8v/rUU/6pvW1due+HRYhbSK/d
 jsFxBC+lFvGtpEXe/FgqPxQJm2Oz3K+PzYy/ewbOBONtYblWbbBHN2g0y5KL6MJfa1Zk
 HNZKdnIMV8j9jyOf011TPbVv4AyGuslVr98zvqRh4AQpFGhNiO2cZsJqzccpalfRQMSA
 Vqpr0MuCf5qnJ+ct+pViEo6lHNs7ZzQpiGate/Yy9Mjh8HljyC+g/y3yyblq4U/g+TE6
 H9w1jThxrilG+uNYeF8RWbTAi8XkCOwH4tbUbCPsZqYDxh2JEg3ktjEdbsQrfFudn2Mj
 0Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071112; x=1789675912;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DXlvSlMUeFS1LC0HetGaOS9EPv1rV9NRjwcngeZp5O0=;
 b=KHBVea9F4m7PLo7O3h0D0ivXDQCr8f8XN2w/VGJpyhCp+e8YFincVAg9lfJhG6bKVj
 Nw/RL+I5cRaZ6iGIetBf2RJO6qkEXwQ9XQBAthPWn1q+jc7N12DnUceoZTF9TEu5/e6s
 7atVXDeyqDET6Oty6JmI/gzyKI1XGv5H4/fS6Ijj1vG3E8X58nPM5kFgkVjRphENRAON
 B5G7TSCH/W251NwoX3MLLq11x2JZS2C39DY7xl0sUtqHkT/Xm9ySxux+u/nfinEcEgKh
 hH3ecqRmyEQSJyPignr3Dd/Hj/JCAQ/WYCZuFXKM8IwkhAQrUtP6I0CkDdGanaBs2995
 M5Vg==
X-Gm-Message-State: AFuF++mCdgCTaenBJdCnYZ/TN9V6filOKMmg1q+Gz6kqixqL0kKMgvRV
 86fCDkhDjNv61hM1V5LbtknrCFOowqs3Zfo6yx81HXp/L8Xv5TSkehuqJVK2WfJzFHbWEDV/bsq
 GqHt4BtICbdqHjN7W/+0mksEI6Gav7TewS6MoMxJHJiZq7Zv9mQN3GQVc71A/f90vRU/A6voz9i
 YFbgsycoXWczefYx3yd9ju3y0w+j5M1tg/Aw==
X-Gm-Gg: AYBFou1AzgbRqroGpCOWB4117xbzJzR9GV/HJrHUfkYfKIVANsJWikIXwoPnpuqc5lK
 Kisg1nSuUmbesvCk708XmQlXSfv4yEJHgiHGJhBs3DqBKBtgrjSeYogoww9sz5btBc1VaR6QtnK
 cW4Xm0fK6DFE/dS+vHvv7WSXg/GyC6YNAztaWzgrqU4g+mWSmG4wmZpqeMsN9CYYBuv9v4Ku6u1
 LrMybch2HylTX4KaSQzcZYJGJVMwfzuV1SOJ8UFUJwMhym3PysWrDar+WIe1eGFtNGH5opsx4/a
 28q33DILpoPLPpzho+igCmFoddaglgcRh4ikBED7Qziaf6UnAeyH0FmUmYzz3oE43ezynoswKPl
 nw5es4HSm6ikRbI5Nf/tiHyA=
X-Received: by 2002:a05:6000:2f86:b0:486:e73e:abe5 with SMTP id
 ffacd0b85a97d-486eb2e269amr867033f8f.10.1789071112101; 
 Thu, 10 Sep 2026 13:11:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:486:e73e:abe5 with SMTP id
 ffacd0b85a97d-486eb2e269amr866983f8f.10.1789071111535; 
 Thu, 10 Sep 2026 13:11:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eaccaa1asm1180268f8f.0.2026.09.10.13.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 12/90] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Message-ID: <8a6790e5438a7e9e67125acfb8c441ae1b721b13.1789071042.git.mst@redhat.com>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-9-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 13 +++++++++++++
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 9b98d34dd0..44e65968d9 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() / vhost_dev_reset_owner() - take / release ownership
+ * @hdev: the common vhost_dev structure
+ *
+ * Take (VHOST_SET_OWNER) or release (VHOST_RESET_OWNER) ownership of a
+ * device that has already been set up.  Used to hand a device over during
+ * CPR.  Returns -ENOSYS if the backend has no such op.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2bb9a23fee..ea17bf0108 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
-- 
MST


