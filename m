Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB0DC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzcu-00012N-DW; Tue, 11 Mar 2025 09:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzcs-0000nO-LT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzcq-00057V-0l
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ufdU5STu+BMmZJlWGmwWQJLsWaOQpc2D8tK+F1fBlCw=;
 b=GfDl0DOzZ9Y8GXKSfp6FhLzTOyVSK8dB38kBGJrcfYl5pODCn+o2753c+HVXs7eunIg98e
 2QoIoYviJwcXB/aVpjwpdBZIzFwDqtQcQFePIkbqBzWgEs5reHlIwOpUPoR54wWL7LkTwp
 yYZkzKRU4buxIBCS3XVLU1vqcg7SuGI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-ZAytudF1M4e9hTg25f6AxA-1; Tue,
 11 Mar 2025 09:26:23 -0400
X-MC-Unique: ZAytudF1M4e9hTg25f6AxA-1
X-Mimecast-MFC-AGG-ID: ZAytudF1M4e9hTg25f6AxA_1741699582
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B61195605E; Tue, 11 Mar 2025 13:26:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7240619560AB; Tue, 11 Mar 2025 13:26:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 00/13] virtio-scsi: add iothread-vq-mapping parameter
Date: Tue, 11 Mar 2025 21:26:03 +0800
Message-ID: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v4:
- Squash fixup commit properly this time >_< [Peter]
v3:
- Use vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED] as the AioContext for the Block
  Backend [Kevin]
v2:
- Only expose cmd vqs via iothread-vq-mapping [Kevin, Peter]

Implement --device virtio-scsi-pci,iothread-vq-mapping= support so that
virtqueues can be assigned to different IOThreads. This improves SMP guest
scalability where I/O-intensive applications can become bottlenecked on a
single IOThread.

The following benchmark results show the effect of iothread-vq-mapping. fio
randread 4k iodepth=64 results from a 4 vCPU guest with an Intel P4800X SSD:
iothreads IOPS
------------------------------
1         189576
2         312698
4         346744

The virtio-scsi device model and core SCSI emulation currently assume that
requests are processed in a single AioContext. This patch series goes about
modifying this as follows:

scsi-disk: drop unused SCSIDiskState->bh field
dma: use current AioContext for dma_blk_io()

Make dma-helpers.c support the QEMU multi-queue block layer by using
qemu_get_current_aio_context().

scsi: track per-SCSIRequest AioContext
scsi: introduce requests_lock

Make the core SCSI emulation code support processing requests in multiple
AioContexts by protecting the per-SCSIDevice requests list.

virtio-scsi: introduce event and ctrl virtqueue locks
virtio-scsi: protect events_dropped field
virtio-scsi: perform TMFs in appropriate AioContexts

Make the virtio-scsi emulation code support processing requests in multiple
AioContexts. The event and ctrl virtqueues can interact with multiple
AioContexts. Especially the SCSI Task Management Functions (TMFs) handled by
the ctrl virtqueue need to be made thread-safe.

virtio-blk: extract cleanup_iothread_vq_mapping() function
virtio-blk: tidy up iothread_vq_mapping functions
virtio: extract iothread-vq-mapping.h API
virtio-scsi: add iothread-vq-mapping parameter

Port over the iothread-vq-mapping qdev property from virtio-blk to virtio-scsi.

virtio-scsi: handle ctrl virtqueue in main loop

Simplify TMF handling now that there is no longer a single AioContext where all
requests are processed.

virtio-scsi: only expose cmd vqs via iothread-vq-mapping

Make the user interface more intuitive.

Stefan Hajnoczi (13):
  scsi-disk: drop unused SCSIDiskState->bh field
  dma: use current AioContext for dma_blk_io()
  scsi: track per-SCSIRequest AioContext
  scsi: introduce requests_lock
  virtio-scsi: introduce event and ctrl virtqueue locks
  virtio-scsi: protect events_dropped field
  virtio-scsi: perform TMFs in appropriate AioContexts
  virtio-blk: extract cleanup_iothread_vq_mapping() function
  virtio-blk: tidy up iothread_vq_mapping functions
  virtio: extract iothread-vq-mapping.h API
  virtio-scsi: add iothread-vq-mapping parameter
  virtio-scsi: handle ctrl virtqueue in main loop
  virtio-scsi: only expose cmd vqs via iothread-vq-mapping

 include/hw/scsi/scsi.h                  |   8 +-
 include/hw/virtio/iothread-vq-mapping.h |  45 ++
 include/hw/virtio/virtio-scsi.h         |  15 +-
 include/system/dma.h                    |   3 +-
 hw/block/virtio-blk.c                   | 132 +-----
 hw/ide/core.c                           |   3 +-
 hw/ide/macio.c                          |   3 +-
 hw/scsi/scsi-bus.c                      | 121 ++++--
 hw/scsi/scsi-disk.c                     |  24 +-
 hw/scsi/virtio-scsi-dataplane.c         | 103 +++--
 hw/scsi/virtio-scsi.c                   | 542 ++++++++++++++----------
 hw/virtio/iothread-vq-mapping.c         | 131 ++++++
 system/dma-helpers.c                    |   8 +-
 hw/virtio/meson.build                   |   1 +
 14 files changed, 683 insertions(+), 456 deletions(-)
 create mode 100644 include/hw/virtio/iothread-vq-mapping.h
 create mode 100644 hw/virtio/iothread-vq-mapping.c

-- 
2.48.1


