Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB2C88E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oYK-0004G1-Eh; Thu, 10 Sep 2026 19:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW9-0006Tc-Fj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVh-0004V7-Fe
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=bUH4vWp3hmYOpxi9LCcWIx72C6aqm7Ry+B/6a0v+KMdEQp66grcX+GoOmECGcKf6cxelcF
 vnU2qm4rSNBvt6dIO+iPMrt41T3WFaIEg9+n0c4Mrg1fg4hZouaDh6uNeZT0OwM3bWu6GW
 GCt2N4rwUf0Dmr9/pt0SwOYcVIKSzYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-DC_zVZ0CN2KvdyDmAygHZQ-1; Thu, 10 Sep 2026 16:15:53 -0400
X-MC-Unique: DC_zVZ0CN2KvdyDmAygHZQ-1
X-Mimecast-MFC-AGG-ID: DC_zVZ0CN2KvdyDmAygHZQ_1789071352
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso2101675e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071352; x=1789676152; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=jM3cH3fB6bbva81/8eC+lXYnQY6S82BSLHJCqJFVNYMEyl2chWbA/gWJBrgdWsYJQo
 uoha+F8eGwak7yc4HP3ITHAdpNMkrcs8OjVbCRpfzYCzI3BWP2zhwB2+ot05mwnslyUp
 p3ByiJugauI4cYxpDkobhp0Bc1DFEVDhMAiw1rHK5n/HnG63zy47ASvxUPtg+a3oUiI5
 /nIble2h0bI/sltdFxtMzoxHdW6w+l7LFkHIkBfvoENmjdCJl1P9YgeG5GIEkXj+NpcT
 6Wdd72pjPen7ofbu4XeBX9uuuL/CktVbkYNqOTW2vMFYu7GgEhcqZpahFudFcjvLNLSy
 3yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071352; x=1789676152;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nSx6T21s1gGNGKoeJ/fw1fyWuRbnS5MwK7Kbb47ZVSQ=;
 b=oVtCsysQL5d5M8hxCC3hOQaLgSDQ5pKA2LOI4zcsc5znI4hQkiTo5PhrawUQrmmb+8
 tvSEjkyRg2f6g5FmjxP3YXZtlAARsQsRaBKVJZmAv+DlRtcH9H/2xdD8vxlDsfKf6/1n
 RIYQmqG+mvOhK9ev05HB08WzBFhxf7q3scwyFTlYpqQaJ5LAsISTRrr2Sgkchhm78nDG
 jeZo+kpP/CDJjTPYoK7EvIvU28hRT6Gg/MBT3JhKGrXECP+IOxwfzLSlxj4lgc41xi5E
 AkWvjs+9PigkagtPwJF44gSOxuRV8mtX30DxK7kw5Ga/wbp3EY+KsH1O9XN+sFPmbimR
 ClUg==
X-Gm-Message-State: AFuF++nYp1VGPQ3XXjcu/PsguFENz4VxIRFPiKilhjmaQ51sBRChdq1j
 iVpbtP95ucoEaykhKFH69iyuGxbwM0wVVMT7ZSKLyma930buWs2+vwIYU1g824wLs61l0SkpUK/
 w3amw8irH+aDtSU2lDIhcjxCVazsKEb60CW4C/xM85Jn1lnsdB2lxZOCOM+fzUjJxwjZ/+hLDgH
 XHRkEf2uWocsuOHtU9eFAf/8TQL5Ey/zRAXw==
X-Gm-Gg: AYBFou0mPJCxugRvRrS8odFX6BW3lP+j9HvfzTqPmV4w+oSnKlZwcZIYZAW08gfQCMf
 ftnaoTrIp4cQHAWHsGgvMaq8NWpFbEZxpZntYFW9sCpeP9wWwGP2iRcPn0HXNtFM29bA9fcSdRu
 cnqAkIwrApJYEwE7xtuK4XusWZcJDzP2hr+NFc2WQNy2DqRQ++P9OpLvM+q+YHNtS8KA0vOVayr
 RLamkVUb32uUKxkS6LVAmIA4EqaVlOhvXfvT0duEfPKbErjo158TAFva4psIbjfY8ifYoP3++4K
 kdzfXMqH9DLIbukRZQ2y3+jjrdvLrtHgXd1V49kcjIwHMibl2RNQL0ESzAK3WxtdLxBmDPVfeBf
 jao/Mb7AS/g0uvhtSRYx8vOA=
X-Received: by 2002:a05:600c:548b:b0:49c:f2f4:eddd with SMTP id
 5b1f17b1804b1-49e619bb9b2mr7028855e9.16.1789071352223; 
 Thu, 10 Sep 2026 13:15:52 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:49c:f2f4:eddd with SMTP id
 5b1f17b1804b1-49e619bb9b2mr7028395e9.16.1789071351635; 
 Thu, 10 Sep 2026 13:15:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ea4fsm762243f8f.21.2026.09.10.13.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 88/90] vhost-user-blk: move inflight_needed higher
Message-ID: <e5e70c539a83840ec7034dd243e5f546b293ea38.1789071043.git.mst@redhat.com>
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


