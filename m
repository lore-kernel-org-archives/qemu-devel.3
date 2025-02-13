Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2711C021A6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidWZ-0007rJ-OS; Thu, 13 Feb 2025 13:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWE-0007fw-To
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWC-0006Pf-V4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739469653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7bpxq8mz8Sv+m+s38czM6zURIi0j+FKNnxHbgG6JYKU=;
 b=RIQXt2cIW+QiddqI5nmM4WpbgHcFoTRn1prE7NS/N3AxgU6hymdXHs1K3tcOpZjlr0SCEu
 7thBQAt33bclr1Wta8oVu5hOJ5NpLShUJzrnEX0ikzbCWEf9cshJ8N7F1PJrSJXANgTo0C
 /nInwdb72C4A5mVxRo1nSRLCRVqVrkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-UpybSlBeN0qtdZN6tJzgvQ-1; Thu,
 13 Feb 2025 13:00:49 -0500
X-MC-Unique: UpybSlBeN0qtdZN6tJzgvQ-1
X-Mimecast-MFC-AGG-ID: UpybSlBeN0qtdZN6tJzgvQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B0D01800878; Thu, 13 Feb 2025 18:00:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69E721955DCE; Thu, 13 Feb 2025 18:00:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 00/12] virtio-scsi: add iothread-vq-mapping parameter
Date: Thu, 13 Feb 2025 13:00:31 -0500
Message-ID: <20250213180043.713434-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stefan Hajnoczi (12):
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

 include/hw/scsi/scsi.h                  |   8 +-
 include/hw/virtio/iothread-vq-mapping.h |  45 ++
 include/hw/virtio/virtio-scsi.h         |  15 +-
 include/system/dma.h                    |   3 +-
 hw/block/virtio-blk.c                   | 132 +-----
 hw/ide/core.c                           |   3 +-
 hw/ide/macio.c                          |   3 +-
 hw/scsi/scsi-bus.c                      | 121 ++++--
 hw/scsi/scsi-disk.c                     |  24 +-
 hw/scsi/virtio-scsi-dataplane.c         |  96 +++--
 hw/scsi/virtio-scsi.c                   | 534 ++++++++++++++----------
 hw/virtio/iothread-vq-mapping.c         | 131 ++++++
 system/dma-helpers.c                    |   8 +-
 hw/virtio/meson.build                   |   1 +
 14 files changed, 672 insertions(+), 452 deletions(-)
 create mode 100644 include/hw/virtio/iothread-vq-mapping.h
 create mode 100644 hw/virtio/iothread-vq-mapping.c

-- 
2.48.1


