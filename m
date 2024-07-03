Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E78CC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8ir-000271-1R; Wed, 03 Jul 2024 18:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ip-00026P-DC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8if-0000uk-Lc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=cFcuxYfTKzBoBlpLQ1q3nbc3ddngwye/0gnRYLQE/giHBsplqhy+7Ivl5vfIgl+6NEWwyH
 uVyCACkP4Kte0eknVfpnlm/lLceA+cVvZbe/RLc58heN2oneNNZlulpVohIW344XPhXMk2
 Xqx90lsJeGx1pxGY+CT12Zey3rtVESE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-AQyMzSOENR-7lRw03WptyA-1; Wed, 03 Jul 2024 18:44:54 -0400
X-MC-Unique: AQyMzSOENR-7lRw03WptyA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d5467c427so5923a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046693; x=1720651493;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=aeSeJk4iSHXhlOixWCXtrtS16mqnE479kVazD6Y2iyTWe+eSqbuS+/KOjKcRnfhyw0
 Q5K1knWBpNhPgVWIuYlp8yVDBc+gEyooF0JBnijQFPlgCo63nXkoA8rd2wNjxoiOqaf5
 PHorJd1xHYk4Yc4YOTWTGao0wq5Sn6b+LxoCgaAgqsNhzgBdqEkgYgogQe/CON9Rxt5a
 NStz958l/V95379eAiw6BRP/A4jwBARngT/3G7a6HD2X4mvQWA7IqpjCx16hXbtKjy5P
 TfiOutp9Kwrx5qx0b7FgKTiOy1L/gcqz+Sq3cXVZ7HQEnLaIzL8/rhzn1s4z0rU1ovGc
 nXGQ==
X-Gm-Message-State: AOJu0Yxc08KaWP6f00nLNIxmh7TVLQwmu7xSXXQCAQkiP813NMINfxRD
 Y4Urm2skn+gNY1op/OP/9bgrXKSBJ1AKh+oyC88mUqNEdOL/9iZGQke+5l0rtgxz3JUAxxNx+4u
 YX4Lxgq38zNQpVdWcffFoxEuejrc4UAj1t6RXceubXqsmOyc5KNjNu+OiP19udNYp9Wdva3TKsN
 CIOTyROT88A6xFIHbdL0it25mV+x3mNg==
X-Received: by 2002:a05:6402:1d4e:b0:57c:60f0:98bc with SMTP id
 4fb4d7f45d1cf-5879f59bc5bmr9191127a12.11.1720046693302; 
 Wed, 03 Jul 2024 15:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwt0cgeX7IzE5SqJO3nOeUkZXrRoV1CshiFn78EWfICEMahzxy9ojl/p5VnzrZmp+wx076qg==
X-Received: by 2002:a05:6402:1d4e:b0:57c:60f0:98bc with SMTP id
 4fb4d7f45d1cf-5879f59bc5bmr9191098a12.11.1720046692666; 
 Wed, 03 Jul 2024 15:44:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835dfsm7618146a12.20.2024.07.03.15.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:52 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Srujana Challa <schalla@marvell.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL v3 08/85] vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to
 vhost feature bits
Message-ID: <b937fa896321fb7b6d7f2205edb5490e0e5d6c69.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support for the VIRTIO_F_NOTIFICATION_DATA feature across a variety
of vhost devices.

The inclusion of VIRTIO_F_NOTIFICATION_DATA in the feature bits arrays
for these devices ensures that the backend is capable of offering and
providing support for this feature, and that it can be disabled if the
backend does not support it.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-6-jonah.palmer@oracle.com>
Acked-by: Srujana Challa <schalla@marvell.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c    | 1 +
 hw/net/vhost_net.c           | 2 ++
 hw/scsi/vhost-scsi.c         | 1 +
 hw/scsi/vhost-user-scsi.c    | 1 +
 hw/virtio/vhost-user-fs.c    | 2 +-
 hw/virtio/vhost-user-vsock.c | 1 +
 net/vhost-vdpa.c             | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..bc2677dbef 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -51,6 +51,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fd1a93701a..18898afe81 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -48,6 +48,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_HASH_REPORT,
     VHOST_INVALID_FEATURE_BIT
 };
@@ -55,6 +56,7 @@ static const int kernel_feature_bits[] = {
 /* Features supported by others. */
 static const int user_feature_bits[] = {
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ae26bc19a4..3d5fe0994d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -38,6 +38,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a63b1f4948..0b050805a8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -36,6 +36,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index cca2cd41be..ae48cc1c96 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -33,7 +33,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
-
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 9431b9792c..802b44a07d 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -21,6 +21,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index eda714d1a4..daa38428c5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -62,6 +62,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
     VIRTIO_F_VERSION_1,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
     VIRTIO_NET_F_CTRL_MAC_ADDR,
-- 
MST


