Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCE7C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsI-0000Kp-35; Mon, 27 Jul 2026 15:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsF-0000Gx-OX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsE-0000ca-2B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrMWxqQkZCCLjgvL4EhAZA9LLZrvR9Qu3eOej5gCQYQ=;
 b=dzfpFdmO3icl6SrASGUipYY18rEyWugoa37xsYCfRbDsiJhJ3Ss8D7TFo4/dlBeWBNi/3e
 BZJ50lGqVbJ/Kq8DD8x518B8Ekfch5n2dIAT2nA271QVCxL0i86BrdVCs4TM6XncOWq97f
 mi1XNqEDHY72mtmOSTvK+81RuVNBwqg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568--hXP05yxMheJA0REtkljiQ-1; Mon, 27 Jul 2026 15:20:17 -0400
X-MC-Unique: -hXP05yxMheJA0REtkljiQ-1
X-Mimecast-MFC-AGG-ID: -hXP05yxMheJA0REtkljiQ_1785180012
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4956c1655c3so14807285e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180011; x=1785784811; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrMWxqQkZCCLjgvL4EhAZA9LLZrvR9Qu3eOej5gCQYQ=;
 b=RI7ZU+B9r8o3s2mmisKjgsI3gAMn2Fs7GOL00Qz9zJyaAd6ruP7I+zBfst8olYdQ9P
 Fj98ZPpQqSTXXU9DExn9aiDcjzaXd20yK+ps7R7h1JaGPKC4OOs56nhGOFsGhSliomzt
 KTEHhmdpIhq4Qpbep9TZ6Y+45POe4uRYNJ5T30XB9Az6nUMqfb8G/yQZB3VGFMvuJvs2
 G0NboTsb6+RA1/X6D/K19qLXXt9Fb9ATcacZQ8XZ2wXqv01rwlKr2SKFpcrU5Wv3cLfN
 gmXoJMeX4zrVU/XUcD90HQe5wC93WR8IYMvHVRsILTU5c5mA38NxJ8Hm7zEAloLa4+JO
 gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180011; x=1785784811;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrMWxqQkZCCLjgvL4EhAZA9LLZrvR9Qu3eOej5gCQYQ=;
 b=h1530Xwrs65TJe0RK5uVdTTugwpOnxqW+tsFQje0c7eADaHq4haX3E0TLbkoN+Xmwy
 XXq8MCmO1jJUbQWeU8Pxu5m1eKMqK+PLzYCBmfjc/CqvTKrS3mDEUtaqoGb/QFs/WBs+
 cVem15JgBqNBjbZWvXK0ImetM5a/ZM8uyBDgx6gqfR3yBAVkPBhBYf7/uUjf9Ov/BK3Y
 MG0NpSy97pJh1fg+/N+MsevH5h/V5tDHVoC8WDbOGLHlnAI0VGLlKx/kE6QI1A1xtb0s
 7GcsyXuUyoZAiRCks59C+J2tFgoTkDaAyUk8b2PRtCZ4JP/a7S2BCoC7dxDLyecRgYp4
 ieRA==
X-Gm-Message-State: AOJu0Yw6b6Em22H4vIMY6RiuS/XJF+d+YXOMPVJCWkIXSDHYgxiy0ssv
 8TpSRzqxnn9P0TRo7u7HbnN3yhd12pFGP31bBF+DnWtrFiq9Jo0KrNsLbX0F5OUDoD6D+VSkDh1
 UcT12jhgej5azfd1+DXYAODhL2d7NcMNJ/u9ztULEk22bKmqszpNHNTkhWxMeCtZ8TKL2Xh+TYV
 z2c3JGmkHkNuKsYZYK+ShUJG2HrPcbcQI7EA==
X-Gm-Gg: AR+sD12kzduw825bUgCn4u7mgahQM/i94Z8DSfsOuzvTYNRUX8WGJ3WAdueX8j4TUWc
 OCPLxEWeVkWylrQwGK4kePX9WH8s62ilqIC8hsYAyo1EEI1hpjo7pD18Z9yMB0NFYxQy1d37y07
 FspM55HxHODD+ZNk49Gv0fGJozBkiXY6gXJi79/oVH75fl5pgaWEdCv1E5W768FFp1IPvxFQEaK
 wT+4HlqLQc+HbOgSJvCGkbhDfwbdI9tZwGlYuuOU2GIbsNb761I+g1qpDqd2VGKY0uLafCOgKuF
 pSeYzC/5sqo51Lt2s9CnLmq8lGppiLjduquM30Sk3qDDnaRDxisVwh3+jsSKbp1RGyrGQ3Mb/t8
 BxFc2vXQmbDofY0B8Hsp/pw==
X-Received: by 2002:a05:600c:1987:b0:495:4a34:16e1 with SMTP id
 5b1f17b1804b1-496c4fc231amr4102075e9.23.1785180011367; 
 Mon, 27 Jul 2026 12:20:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1987:b0:495:4a34:16e1 with SMTP id
 5b1f17b1804b1-496c4fc231amr4101765e9.23.1785180010837; 
 Mon, 27 Jul 2026 12:20:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45bb2e7sm14770675e9.7.2026.07.27.12.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:10 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, BB CC <wywwzjj@gmail.com>
Subject: [PULL v2 15/30] libvhost-user: validate last_batch_head in
 vu_check_queue_inflights
Message-ID: <bf21298c082cc5561072bbfd79216d478861a5cd.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

vu_check_queue_inflights uses last_batch_head from the frontend-controlled
inflight shared memory as an index into desc[] without bounds checking.
A malicious or buggy frontend can set last_batch_head >= desc_num,
causing an out-of-bounds write.

Validate last_batch_head before using it.
Note: the value is not guest-accessible so not a security vulnerability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: BB CC <wywwzjj@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 42a5e2f1f5..c1c13dbc90 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1379,6 +1379,12 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->counter = 0;
 
     if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        if (vq->inflight->last_batch_head >= vq->inflight->desc_num) {
+            vu_panic(dev, "vu_check_queue_inflights: last_batch_head %u "
+                     "out of range (desc_num %u)",
+                     vq->inflight->last_batch_head, vq->inflight->desc_num);
+            return -1;
+        }
         vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
 
         barrier();
-- 
MST


