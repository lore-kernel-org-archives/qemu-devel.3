Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5D3C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBL-0007ms-Um; Fri, 11 Sep 2026 05:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBI-0007ZL-Ar
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBG-0008VN-U2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=QVfZu8itkd1ZfU2ta6aKdJ4c6tQYQhj9KCH90sqV10NBYRzh8fuJRxqt/U7OnHJOlD3Ck5
 F3xBqEefEowscsBkkGc/J+Ba4M3V0Scm50srONBwH6XW6Q1LsSqQRRbI+M3F6usJJsC3aX
 gp8qy5G9Ca0wzEHDCnSpi9L86Qnd740=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-lMgAsKLnNnGhAfrYo-dAzg-1; Fri, 11 Sep 2026 05:04:20 -0400
X-MC-Unique: lMgAsKLnNnGhAfrYo-dAzg-1
X-Mimecast-MFC-AGG-ID: lMgAsKLnNnGhAfrYo-dAzg_1789117460
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so5978295e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117460; x=1789722260; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=CVslz74VWweqAbOIt+lM9JY0PlDfiFPWj0NiSC7jMst7cVGGrJrLph1tYs+I+1PLcG
 EEW62YgctYC6Thq0N5l6nGUoRqn7Jmd1dRh9ZiniuanNOOQ7e4570DhJdX21ql4UiFTV
 X3cxkMVLjixNsY6gjPcHxAaZBIOsvNNNx0qyOmCMy69Uoua/SH1X7uOR+fzYCZM9XZIX
 MKjpvblq0sMcNycmCNm+e+oI4tjv4Il/kwJqDdL7YGOaX0+9H2ppe5FhYNss84VGqU1V
 L/d2f8tSMPi5r2hb51d4Ov3Z6S3mPkB44qgOoKUenDpRfTgDPZL/xGe5ZhuNufJ4mkOy
 Ao6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117460; x=1789722260;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=XUqKYNYWPqgMdCjBp5La7aG3nUl+d13LK2VFbo6xWPjV5qEs7tcArHozxJa2qPWtQS
 A0ynGJ+COqPQBzEm01dJKwRIX06NV8vZ7rRQIQLku+ld2h/RWfMrVmROXyV0nEM8hd94
 e8RreA0qnn4slLJ62pynEcZ6tfmjsaR8HwGLxStfj7gmzQ+G3hKptLYJsCSAOZ11Bnog
 9Vk7v05Efd3cBmjIUT6n9XJ79jKEag+tpDrghW3sWWSoydx8UQTmWrJw6XGb/chHqFdj
 DAi5a47qOqVC8SwW7qRDRENmZU5gN5zabt+EQjrmsua4YFrbgHI+eDYJYVXCb6WHC89u
 CDaw==
X-Gm-Message-State: AFuF++nMX6+Dxs2NtsBzVdYEKV2oMXjxhWYiOeqI/0zHp8B7tHIh7g7f
 ozR893gfmTEtzdXA7cTvKwMzXRFtYJuPkPS1JfYkQb2XabRM/el+t5zS/8Tq7ahjqSy/AxnmqGc
 oTo/4ceiztB6Aqbww5tksOzpTfU8ejQOHO1dZEAHQHR5dZjvu53LcTsNiVwNzydXFfOZtdOVkgM
 9Z0GibCWHEcAA62dtLm1sF/H6330m59kqbbg==
X-Gm-Gg: AYBFou0W4dW4/7spg/v//P9A9nTL8AiG3Nqr/UZfhetUuYDMkAGHDkMbj8pJKtFEqHm
 SDEjwIoh0SD7z971ajXfvLL8pt72+UKj8cAInTtq3L0EYW8+GQ89+4iseHZyyhthLJMr+hiWEs/
 onoMxoVmSgNOYB250POBLvCIiQLvTwyH548bcCR+Aj9Ksf7t6dZmWDKad13ApnHX8yx3Xm9qOE8
 JWcwQR9qdK598v9oLZ5rsXJ070G54I/IUYrbAeSXjyBZkqxeQ38cqBOuGd+xPKbQqKyrlLQF0C1
 0ywadjb+pEzoWRyNRyIQ7o9mC735f0J5NnwIy2QtMaIba3XoSrdBbPPtfcD8TBw4PU/nPSpbHON
 n0p2k+T90stwvQxOHp0wXmT4=
X-Received: by 2002:a05:600d:8648:10b0:49d:1f10:8b9f with SMTP id
 5b1f17b1804b1-49e619836aemr26260455e9.7.1789117459545; 
 Fri, 11 Sep 2026 02:04:19 -0700 (PDT)
X-Received: by 2002:a05:600d:8648:10b0:49d:1f10:8b9f with SMTP id
 5b1f17b1804b1-49e619836aemr26259835e9.7.1789117459026; 
 Fri, 11 Sep 2026 02:04:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm36413805e9.2.2026.09.11.02.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL v2 73/75] vhost-user-blk: move inflight_needed higher
Message-ID: <301f703fe71cce590d1c597536a08b359fc05b76.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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

Move vhost_user_blk_inflight_needed() earlier in the file so it can
be called from vhost_user_blk_stop(), which is defined before the
VMState section. No functional change.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-6-dtalexundeer@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 501de30796..3eaaa19719 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -137,6 +137,17 @@ const VhostDevConfigOps blk_ops = {
     .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
 };
 
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
+
 static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
@@ -597,14 +608,6 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
-static bool vhost_user_blk_inflight_needed(void *opaque)
-{
-    struct VHostUserBlk *s = opaque;
-
-    return vhost_user_has_protocol_feature(
-        &s->dev, VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-}
-
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
     .name = "vhost-user-blk/inflight",
     .version_id = 1,
-- 
MST


