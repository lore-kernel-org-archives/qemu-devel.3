Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715F1C44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwn-0005vH-10; Sun, 05 Jul 2026 10:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwl-0005pf-3I
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwj-0001Rn-Ec
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmY8MnQhP5H5i1Kwg/ZO3RsXJdwMXxmgaiaGkLPRGEQ=;
 b=Xv9RdZ3BSXs2MH2/+Q7MMiMmyIKBNE9X37P79tEVo6HBY2vEYE0ng2PYoS5L57f9b0gQrQ
 z4dpjiaK98FAFePIuVLnOnHVVtXec55VyBkgA0Y7tXi0LmJ5QZhHLfOHzyRsY9qj2sHpA+
 7uvrLfrmPQMxaRAjsiA2p0971MFXfVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-cryb-MAMP02iAPlNnWdrYQ-1; Sun, 05 Jul 2026 10:35:47 -0400
X-MC-Unique: cryb-MAMP02iAPlNnWdrYQ-1
X-Mimecast-MFC-AGG-ID: cryb-MAMP02iAPlNnWdrYQ_1783262146
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493ce4b7777so13845755e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262146; x=1783866946; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YmY8MnQhP5H5i1Kwg/ZO3RsXJdwMXxmgaiaGkLPRGEQ=;
 b=UzBrxuvoHjRk9Lk30VkS4PS8pnhhzOYdoGsxyKALgG9VoUZGX/t3VqScZBcud4ePIK
 wGdIndEZ/+V9N0UzRa7IKiWqZJFpsk9z/w51yxNJBLNqq9GrsEJB4hA9rTr+/Nt4KXtx
 bFlxvxdUU1O7h3MMEvSnKOG8wpf23jy/oCK3nD92Kdqt7dUEMhKV/n2fx0Oo1nEzzioj
 vOh4yNF46urWolahIQjQMl+Ia/w9QekA/LgDy1exgDaEBudQGyROyh3Xmtd3TNBsUWYw
 Zg2TJ0jmp2yAkUtK7bNF+/RTsezqmc9dJaIjVsjKqGq1xTNVBPSIFjkynZyNWSTlvbeS
 Uwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262146; x=1783866946;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YmY8MnQhP5H5i1Kwg/ZO3RsXJdwMXxmgaiaGkLPRGEQ=;
 b=kUCGwMK1ykEoIJy5kB3EnQuuRW3D+ae2A8ar5+nuObhkH2YyfI3f+93DkX+K2kJnqw
 pievLUvSPmwtrpDatICMOsLszS+sjhp+OFKCAoZZTKKVcU3vXvbw1P8je2gDuzpx0rdQ
 9ANrEShdyIgM2LknK+t22tMJW2AGk8IepZwgQPF8HLG1+2o1m0imlp+d40c3WCuj56EN
 GuBjwmxkcArXkHSMrCwAe8owwrSW6gHo7hHO18anIihnF6+PqOvo//IMmKkpu4DQTztV
 RkyE2kyfgvn8FP+a6doyTxJvXf5Y8W2KH/kNsdRm6Tep9UJ6leoOlRsCYq8HzpyG7knG
 G17Q==
X-Gm-Message-State: AOJu0YyIarZgxElR/zau5LaJZTXObaNZ9GV5wnyS8GtalDKh45DIA3GB
 FRI8E/0Lp/5QT+a4up1RPeu4f8t+k0QlYBRJntoSKDJ3TK1GlZlfCw+1Tcgm0X/riC9jVcsHOK5
 jE2CvQBOzeqNtEA4UOJ1tx8MBC8Lrv6lENNl7J3If0D+2yf1CJNB8R8q57+hz98mBXxmifiFd/j
 KqCE3OM4WPFx+Fte8r7gUCVrP2K+KSlCRWUw==
X-Gm-Gg: AfdE7cnCvJ3er0a5EBsKgELFid7GUBcO1iavbbjfwilApbIA2LPHkpasx1uKnhn2meA
 40eR3oUzSPXWkQbvKRKHbFBdVhBxJhzCFx/E1nXRo2nWZFPaQm62u/nj91gsCemPf/h9Je0BbAp
 bUzUHkLU2RFgVn+TleBsD2mWWkxhRbknxwiNp9Sqj+ukw5nHynMtEs0PiR0dsgsbLWPGrPxAZNk
 xsKE9xVfKOHaXryczpr7XqPt4iaRZOD93rKz9lQLRkrVYiyeEk1jey1uMdan23rHG0F/drVTSIk
 oSfNPl6OAQOYXvY4t4UJR66cRcqGOqcD07EUT1q5lD9eo9/kctD57BQvKeyw29IbivlEWCKF36j
 zzA7DbxJ+SIxLDPtMU2ndfR9WtXetygjR
X-Received: by 2002:a05:600c:5489:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-493d36ff89emr60131095e9.4.1783262146127; 
 Sun, 05 Jul 2026 07:35:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-493d36ff89emr60130025e9.4.1783262144291; 
 Sun, 05 Jul 2026 07:35:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm518323425e9.7.2026.07.05.07.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:43 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 25/44] vhost-user-base: clean up vhost_dev on realize failure
Message-ID: <bb3e0daaf8ea0bc98697c11a15bc30d7fa0b6173.1783261895.git.mst@redhat.com>
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

Failures after vhost_dev_init() currently skip vhost_dev_cleanup(),
leaking initialized vhost_dev state.

Add a separate unwind label for those paths. Keep a copy of
vhost_dev.vqs so the array can still be freed after vhost_dev_cleanup()
clears struct vhost_dev.

Fixes: 6608dca74ecf (vhost-user-device: Add shared memory BAR)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630012058.2663259-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-base.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 6ac523f9eb..478ec68f09 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -287,6 +287,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
     uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+    struct vhost_virtqueue *vhost_vqs = NULL;
     int i, ret, nregions, regions_processed = 0;
 
     if (!vub->chardev.chr) {
@@ -338,6 +339,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     vub->vhost_dev.nvqs = vub->num_vqs;
     vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
+    vhost_vqs = vub->vhost_dev.vqs;
 
     /* connect to backend */
     ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
@@ -353,7 +355,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                                                            errp);
 
     if (ret < 0) {
-        goto err;
+        goto err_vhost_dev;
     }
 
     for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
@@ -368,14 +370,14 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                     errp);
 
                 if (ret < 0) {
-                    goto err;
+                    goto err_vhost_dev;
                 }
             }
 
             if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
                 error_setg(errp, "Shared memory %d size must be a multiple of "
                                  "the host page size", i);
-                goto err;
+                goto err_vhost_dev;
             }
 
             virtio_new_shmem_region(vdev, i, memory_sizes[i]);
@@ -385,7 +387,10 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
     return;
+err_vhost_dev:
+    vhost_dev_cleanup(&vub->vhost_dev);
 err:
+    g_free(vhost_vqs);
     do_vhost_user_cleanup(vdev, vub);
 }
 
-- 
MST


