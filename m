Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AC2EFCE20
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxq8Y-0003BE-4P; Wed, 04 Mar 2026 12:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8U-00039p-LG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8S-0004qW-EO
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772645747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Off7P7zDAnDS91ybSFcvl6xNyVE6VRsO+xZHKngqjDQ=;
 b=e9nP5DpEwPtVpyNttpo4B9L5jCzJ/2pbWjq7DwdqLT7997Ie5Kq/vylYFH8aEvzj1kNs/l
 fmsHFoho2Y399sL0SbrWhLRfJKMSxheoMLVBbjPCxYo0NBxC8v9Wo4GeafiV1PCxtpB6PY
 N3jbxpdBEM5nSAgNmXhXy0UreAo6L4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-oboX5sw_PzSzSLLYC9BVPg-1; Wed,
 04 Mar 2026 12:35:43 -0500
X-MC-Unique: oboX5sw_PzSzSLLYC9BVPg-1
X-Mimecast-MFC-AGG-ID: oboX5sw_PzSzSLLYC9BVPg_1772645742
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1A6218005B3; Wed,  4 Mar 2026 17:35:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94A851958DC5; Wed,  4 Mar 2026 17:35:37 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea DE <dtatulea@nvidia.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Koushik Dutta <kdutta@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 0/7] Add VIRTIO_F_IN_ORDER support to vhost shadow virtqueue
Date: Wed,  4 Mar 2026 18:35:28 +0100
Message-ID: <20260304173535.2702587-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds support for the VIRTIO_F_IN_ORDER feature flag to vhost shadow
virtqueue (SVQ), enabling migration of vDPA devices that offer this feature.
As SVQ acts as a virtio driver, the series follows the Linux kernel
implementation for the feature by Jason Wang.  This enables the live migration
of vhost-vdpa devices that supports IN_ORDER.

The IN_ORDER feature allows virtio devices to use many descriptors in batch,
just by marking the last one of the set as used.

The series is structured in three parts.  First, max_steps calculation in
virtqueue_ordered_fill is fixed to allow filling the entire virtqueue at once.
Otherwise, a full queue cannot be used with just one used entry.

Afterwards, the series extracts helper functions for descriptor processing to
prepare for in order changes:

Finally, the series adds IN_ORDER support, first adding conditional logic for
in-order vs regular processing and whitelisting the feature flag in SVQ.

Eugenio Pérez (7):
  virtio: Allow to fill a whole virtqueue in order
  vhost: move svq next desc array to descs state struct
  vhost: factor out the descriptor next fetching
  vhost: factor out the get of last used desc in SVQ
  vhost: factor out the detach buf logic in SVQ
  vhost: add in_order feature to shadow virtqueue
  vhost: accept in order feature flag

 hw/virtio/vhost-shadow-virtqueue.c | 215 +++++++++++++++++++++++++----
 hw/virtio/vhost-shadow-virtqueue.h |  38 ++++-
 hw/virtio/virtio.c                 |   2 +-
 3 files changed, 219 insertions(+), 36 deletions(-)

-- 
2.53.0


