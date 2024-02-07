Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D39BC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXptx-0006tR-3J; Wed, 07 Feb 2024 16:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptv-0006sY-Ek
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptt-0007Zg-RG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gFHdAOVQTsRaSOUgVQ8b6/e4QuLEvB+ID/BFiR7oHGo=;
 b=fnbylmaaCw+vP51upr44E9n3ExVaYll6RkrMX37qjaUOqV1ecz0QkQ7ToQyzlMCSD7FPCt
 WKDCCQsizzc9LNiTdBiSpv98i9rTRIbKc/4ZxwLwKkwAGJfPRk31gU5EARo17/Kllc95pB
 6qZbY3VmDjJ+G+vWlAN8C7i4AKRSInk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Fhi8y22NORapfBnM2CDIEA-1; Wed, 07 Feb 2024 16:56:10 -0500
X-MC-Unique: Fhi8y22NORapfBnM2CDIEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3766185A780;
 Wed,  7 Feb 2024 21:56:09 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25926492BC6;
 Wed,  7 Feb 2024 21:56:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/16] Block layer patches
Date: Wed,  7 Feb 2024 22:55:50 +0100
Message-ID: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7ccd0415f2d67e6739da756241f60d98d5c80bf8:

  virtio-blk: avoid using ioeventfd state in irqfd conditional (2024-02-07 21:59:07 +0100)

----------------------------------------------------------------
Block layer patches

- Allow concurrent BB context changes
- virtio: Re-enable notifications after drain
- virtio-blk: Fix missing use of irqfd
- scsi: Don't ignore most usb-storage properties
- blkio: Respect memory-alignment for bounce buffer allocations
- iotests tmpdir fixes
- virtio-blk: Code cleanups

----------------------------------------------------------------
Daniel P. Berrangé (2):
      iotests: fix leak of tmpdir in dry-run mode
      iotests: give tempdir an identifying name

Hanna Czenczek (5):
      block-backend: Allow concurrent context changes
      scsi: Await request purging
      virtio-scsi: Attach event vq notifier with no_poll
      virtio: Re-enable notifications after drain
      virtio-blk: Use ioeventfd_attach in start_ioeventfd

Kevin Wolf (2):
      scsi: Don't ignore most usb-storage properties
      blkio: Respect memory-alignment for bounce buffer allocations

Stefan Hajnoczi (7):
      virtio-blk: enforce iothread-vq-mapping validation
      virtio-blk: clarify that there is at least 1 virtqueue
      virtio-blk: add vq_rq[] bounds check in virtio_blk_dma_restart_cb()
      virtio-blk: declare VirtIOBlock::rq with a type
      monitor: use aio_co_reschedule_self()
      virtio-blk: do not use C99 mixed declarations
      virtio-blk: avoid using ioeventfd state in irqfd conditional

 include/block/aio.h            |   7 +-
 include/hw/scsi/scsi.h         |   5 +-
 include/hw/virtio/virtio-blk.h |   2 +-
 block/blkio.c                  |   3 +
 block/block-backend.c          |  22 ++--
 hw/block/virtio-blk.c          | 226 +++++++++++++++++++++++------------------
 hw/scsi/scsi-bus.c             |  63 ++++++------
 hw/scsi/virtio-scsi.c          |   7 +-
 hw/usb/dev-storage-classic.c   |   5 +-
 hw/virtio/virtio.c             |  42 ++++++++
 qapi/qmp-dispatch.c            |   7 +-
 tests/qemu-iotests/testenv.py  |   2 +-
 tests/qemu-iotests/check       |   3 +-
 13 files changed, 236 insertions(+), 158 deletions(-)


