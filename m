Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111D2EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voN7O-0008D9-7t; Fri, 06 Feb 2026 09:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1voN7K-0008Ch-St
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1voN7H-0006iM-4R
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770389243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AMN2roAzdNjqxbP3sP8XvnllXlDPELrnmVS0rRyPlwg=;
 b=XA+8Ua0NYNTVX6MshFvoN1wdcRLD00lRUGFxQobLVwvapV+svq8+q9FpqXafcppdAVHjgz
 uKv7HZ3i1xCFk/WMBkrS7MnKvqE04HHmnRW5NcQ/IADny/z/AB1/PnKlIXN9YwY4UQwrKr
 GSiTZt/qti7bw5fvufIHdLS2Hz2M7Hk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-FsBl881vOfeQx5GSQ3E9UA-1; Fri,
 06 Feb 2026 09:47:22 -0500
X-MC-Unique: FsBl881vOfeQx5GSQ3E9UA-1
X-Mimecast-MFC-AGG-ID: FsBl881vOfeQx5GSQ3E9UA_1770389241
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A823D18004BB
 for <qemu-devel@nongnu.org>; Fri,  6 Feb 2026 14:47:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.83])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 529CE192C7C3; Fri,  6 Feb 2026 14:47:18 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH] net/vhost-vdpa: Whitelist virtio-net GSO for shadow virtqueue
Date: Fri,  6 Feb 2026 15:47:17 +0100
Message-ID: <20260206144717.730799-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Even if it is deprecated by the VirtIO standard it does not affect the
layout of the queue, or introduces new operations. So Shadow Virtqueue
can handle it just fine.

Tested with OVS DPDK and VDUSE.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 74d26a949725..df9513c8ab60 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -116,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_GSO) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
--
2.53.0


