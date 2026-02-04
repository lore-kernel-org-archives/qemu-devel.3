Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2B5EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAV-0008AR-B1; Wed, 04 Feb 2026 14:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAL-0007av-CH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAJ-0007vH-QH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXkScNv7xNrQiajhZNxV5Y+IbqsvARHUNAQ/l/4frxQ=;
 b=Sprhm/1PW5pknAg/m9QSrA/F5rDsJxt18yq7uItgp5Ds0H7Qw0voEGE80AFFXaKHXaBJ0i
 HvbNv9ItPCDtQ5fa7bIcT3PWp0uXJQM6x7n5/eFIPZxojnlKNbxDCQyZBMymwwuR5KO62z
 CXp5iQnL3uDzGKUZafO/mFflzXqxUhY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-S1kZFgiONg25G7Y9VaoA8Q-1; Wed, 04 Feb 2026 14:03:50 -0500
X-MC-Unique: S1kZFgiONg25G7Y9VaoA8Q-1
X-Mimecast-MFC-AGG-ID: S1kZFgiONg25G7Y9VaoA8Q_1770231829
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435a6c0c794so179882f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231828; x=1770836628; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YXkScNv7xNrQiajhZNxV5Y+IbqsvARHUNAQ/l/4frxQ=;
 b=LPAKXDgjm1erUf7SnogR0JqEiNTf5J1IN/aFYdKNxktLhBzqiDxGLMo4oAybgwXPdq
 ZwgqxWss77OzRHWktxDmTldUdZ3dmtpfIG2s5SfG+0LedmFvL+IOHRJK5SwbLGkhsSor
 dNRhTk1JPhLSj0ZwPCx72i2ad015ieW3X8+q5YUpMxU+gGE912AfC9uSnhEvwEmbbYj7
 9UFC8Z/+67JLfKOS5Gr9aFra509USdgEHB8H0BlmeKfMMM8YILi5CkiV3uJFyPDIwIU2
 iIoe7TZ6wrymEJM66PyGNxp9kmr0oiu10wkIwA0iCI01ALHbkmaDPwJ8eWzVs3nHXUDQ
 QVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231828; x=1770836628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXkScNv7xNrQiajhZNxV5Y+IbqsvARHUNAQ/l/4frxQ=;
 b=KI6QsPGcxenKComBdG9mTrPYWFx8T6nl3m1rqmHhWIeq26ThFsLm70g4ZWhv+MJAMt
 sCXlEtd1RK+ww+hJ+qkp4bTQ56gw7EH5B2/xOzqVU4RFpsOeoYq5DXn6x3P2WBBCsb2t
 pqFI2WIvFIiKUPff1wSOxx8ERa7RM52IowhGfQ0ysFK8g/C30qlpNBcSoXvUFfUhEk21
 3cBGCaFamwqU/1PXY6g7aQlbSiYkBdO6DGjuZ+/iBbHZBNgyRrBoyy3VP2fR0QIiFIxD
 qo6Q0qkt/WKTUcl4sti4qL0EK6wW+9by4+3F7AUYXAw8QvAp9tlgtiF8S8/7m42Rxkrq
 HKZw==
X-Gm-Message-State: AOJu0YwrS+JFEMnbY3LHDXjbfLVxSENcSZTceFOmUVSOSnVD3AlVu225
 B4nWumMt7EQ5orITBRgPU5as+UdhrKKJJnKbkDSIqlYNM7AAkTnefc5BLT/V3v7Dm98iuzGd6BS
 u9pt2frRvVQIcs6HGrDSXNcA5XL87rknAkYcBpJmM12z9EzeC5ztxYk8X5Bw/Bf+xs4b0szHhCb
 qteTQpc5FsgBeVkzH4acyCmXXA3IfdYBJr3A==
X-Gm-Gg: AZuq6aJXZQwItlXs3jg2++X6btMKAabAyAJJRtsMGnu2puuKjdXYhrACgAcHTrlPjTf
 sSPOBnraVKt4EeBqYTqr2t6IrdfVndAS6Mnl/03pn64ZzQFghlv821rOKUCqQRufksGr3PZgttf
 xHUgRXtf/K31tdtKukq3fkMnN+7V0KkI1OVRszZiNt0xEcHnWidtPCJxto2mxss2C2AZJsn7UXl
 YauC1FxFn+mbQWAcXGV5rr3kMy9l6iT4FY0hpcmhRV/vbT/+7h3dM4yiNOo5LSMvoJRcUrqRQFT
 KEIZgXiXh/5ZbrQjftu2lVobA5N14YD4JuEXNnu/PvyBuppGknnTp4ZkDJHK0Jovn4ZND8QwBij
 oeTeQRrLq4Hw286bS0ZuHOxtQHKahfcoAIA==
X-Received: by 2002:a05:6000:400b:b0:432:8504:befd with SMTP id
 ffacd0b85a97d-4361805509dmr5469577f8f.32.1770231828491; 
 Wed, 04 Feb 2026 11:03:48 -0800 (PST)
X-Received: by 2002:a05:6000:400b:b0:432:8504:befd with SMTP id
 ffacd0b85a97d-4361805509dmr5469516f8f.32.1770231827967; 
 Wed, 04 Feb 2026 11:03:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e263b9sm7935042f8f.4.2026.02.04.11.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:47 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wafer Xie <wafer@jaguarmicro.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 25/51] vdpa: fix vhost-vdpa suspended state not be shared
Message-ID: <707e307a3d30cd04b8fe627fa34254732a9d7caa.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Wafer Xie <wafer@jaguarmicro.com>

When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
while the remaining queues are not updated to the suspended state.
As a result, when stopping a multi-queue vhost-vdpa device,
the following error message will be printed.

qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)

qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)

So move v->suspended to v->shared, and then all the vhost_vdpa devices cannot
have different suspended states.

Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20251119132452.3117-1-wafer@jaguarmicro.com>
---
 hw/virtio/vhost-vdpa.c         | 6 +++---
 include/hw/virtio/vhost-vdpa.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..2f8f11df86 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -905,7 +905,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     memory_listener_unregister(&v->shared->listener);
     v->shared->listener_registered = false;
-    v->suspended = false;
+    v->shared->suspended = false;
     return 0;
 }
 
@@ -1354,7 +1354,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
-            v->suspended = true;
+            v->shared->suspended = true;
             return;
         }
     }
@@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if (!v->shared->suspended) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 449bf5c840..80ff670e23 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -76,6 +76,12 @@ typedef struct vhost_vdpa_shared {
 
     /* SVQ switching is in progress, or already completed? */
     SVQTransitionState svq_switching;
+
+    /*
+     * Device suspended successfully.
+     * The vhost_vdpa devices cannot have different suspended states.
+     */
+    bool suspended;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
@@ -83,8 +89,6 @@ typedef struct vhost_vdpa {
     uint32_t address_space_id;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
-    /* Device suspended successfully */
-    bool suspended;
     VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
-- 
MST


