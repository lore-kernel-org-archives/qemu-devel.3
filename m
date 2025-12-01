Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C27D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3O6-0001hB-B3; Mon, 01 Dec 2025 07:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vQ3Nr-0001Be-SE
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vQ3Nq-0003o5-3O
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764593515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uy30EGZxUbbK0AXQ2bdscXYyRHo9fm1/HxaZfC06wJ0=;
 b=g6DChoZepBiEXrDOcJeNPG2HGElGx6PVqlz5oF+AFPL5UUQ8moZPDAJ5mfYZE+wW9epzJ8
 n5hiBeCbgyuUIMFQVVONYQNejPwvb3GAk/NCciuRdDtDSzVxqt+thHAAZvZcv8w4bCDRa0
 jKJCMdNoW4HE0FloiyiZeOU46eQPNb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-LTPwpfe_NsWPF-ZwLRZtXQ-1; Mon,
 01 Dec 2025 07:51:54 -0500
X-MC-Unique: LTPwpfe_NsWPF-ZwLRZtXQ-1
X-Mimecast-MFC-AGG-ID: LTPwpfe_NsWPF-ZwLRZtXQ_1764593513
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BEC01800473
 for <qemu-devel@nongnu.org>; Mon,  1 Dec 2025 12:51:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAE3F19560A7; Mon,  1 Dec 2025 12:51:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vhost: accept indirect descriptors in shadow virtqueue
Date: Mon,  1 Dec 2025 13:51:49 +0100
Message-ID: <20251201125149.2151026-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

The device is not able to generate indirect descriptors by itself, only
the driver can do it.  And SVQ is already able to handle them by reusing
VirtQueue struct.

Shadow VirtQueue just transform the indirect descriptors to chained
buffers.  This way we don't need to map a new buffer for the indirect
table and handle its exhaustion etc.  As they are only used in control
plane and HW devices don't like indirect, we should not see significant
downsides with these.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
--

Tested functionally by forwarding the CVQ descriptors.
---
 hw/virtio/vhost-shadow-virtqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..6242aeb69c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -34,6 +34,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
         switch (b) {
         case VIRTIO_F_ANY_LAYOUT:
         case VIRTIO_RING_F_EVENT_IDX:
+        case VIRTIO_RING_F_INDIRECT_DESC:
             continue;
 
         case VIRTIO_F_ACCESS_PLATFORM:
-- 
2.52.0


