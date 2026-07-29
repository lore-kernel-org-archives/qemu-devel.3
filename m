Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCB8C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYV-0002oT-2A; Wed, 29 Jul 2026 19:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYS-0002nt-US
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYQ-0008B0-Qu
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pw+D3vabNcb7FTrzqlhU+J8urkDBPU4nDsAViHHBh1s=;
 b=jEBPpcBiTTusqzC/5dpqkpXdtogy1lrFveWpqxxc+quJQB/nTbtHhav0FNcS5S7GesTlHI
 pZgm9bY25Qtjq1RSlKdm+eF2DbPxu4iI+jvcKnkEdNWrCjISlj/89B69RwEAviORvwPLNu
 14sJbQvY7vRcRRyP16HmAzNkd/2vvSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-U_aTOE8jMWGoDq9J1awYDA-1; Wed,
 29 Jul 2026 19:19:11 -0400
X-MC-Unique: U_aTOE8jMWGoDq9J1awYDA-1
X-Mimecast-MFC-AGG-ID: U_aTOE8jMWGoDq9J1awYDA_1785367150
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BAED19560AF; Wed, 29 Jul 2026 23:19:09 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA6D5300019F; Wed, 29 Jul 2026 23:19:05 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 0/7] Harden virtio migration load paths against crafted
 streams
Date: Thu, 30 Jul 2026 01:18:57 +0200
Message-ID: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A crafted migration stream can crash the destination QEMU process
through unvalidated fields in the virtio device state: an unbounded
allocation in virtio-serial, reachable assertions in the shared
virtqueue element deserializer, assert()/exit(1) calls in
virtio-scsi and spapr-vscsi request loading, and missing error
propagation through the SCSI and virtio device load paths.

These are hardening fixes: the destination QEMU is in a paused
pre-start state and the source VM is unaffected by a failed migration.

Patch 1 adds an Error** parameter to the virtio and SCSI load_request
callbacks, allowing proper error propagation instead of error_report()
or silent failures. This provides the infrastructure for the remaining
patches.

Patch 2 validates the virtio-serial nr_active_ports count against the
configured maximum before allocating the post-load array.

Patches 3 and 5 are from Michael S. Tsirkin, modified to use the new
Error** parameter:

Patch 3 makes virtqueue_map() return bool instead of calling exit(1)
on mapping failures, and propagates errors through
qemu_get_virtqueue_element() to virtio-blk, virtio-serial, and
virtio-scsi.

Patch 4 replaces the assertions in qemu_get_virtqueue_element() with
a bounds check returning NULL on invalid in_num/out_num counts.

Patch 5 replaces the assertion in mptsas_load_request() with proper
error handling.

Patch 6 replaces the remaining assert() and exit(1) calls in
virtio_scsi_load_request() with proper error returns.

Patch 7 replaces the assert() calls in vscsi_load_request() with
proper error returns and propagation.

v2:
- New patch 1 to add Error** parameter to load_request callbacks
- Patches 2, 4, 6, 7: add error_setg() calls with descriptive messages
- New patches 3 and 5 from Michael S. Tsirkin (modified to use errp)
- Patch 4: remove caller updates (now handled by patch 3)
- New patch 7: harden spapr_vscsi load_request

Tested with migration round-trips for virtio-serial (0 to 511 ports),
virtio-blk (1-2 disks), virtio-scsi (1-2 disks), mptsas1068
(with and without scsi-hd), and spapr-vscsi, plus the original PoC
reproducers for issues #3801, #3802, and #3888. ppc64 qtests pass.

Laurent Vivier (5):
  VirtioDeviceClass: Add an Error parameter to vmstate load member
  hw/char/virtio-serial-bus: validate nr_active_ports from migration stream
  hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid state
  hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid stream
  hw/scsi/spapr_vscsi: do not crash QEMU on migration errors

Michael S. Tsirkin (2):
  virtio: do not crash QEMU on migration errors
  mptsas: do not crash QEMU on migration errors

 hw/block/virtio-blk.c       | 16 ++++++--
 hw/char/virtio-serial-bus.c | 33 ++++++++++----
 hw/scsi/esp.c               |  2 +-
 hw/scsi/mptsas.c            | 18 +++++---
 hw/scsi/scsi-bus.c          | 25 +++++++++--
 hw/scsi/scsi-disk.c         | 10 +++--
 hw/scsi/scsi-generic.c      |  3 +-
 hw/scsi/spapr_vscsi.c       | 18 +++++++--
 hw/scsi/virtio-scsi.c       | 27 ++++++++++--
 hw/usb/dev-storage.c        |  2 +-
 hw/virtio/virtio.c          | 82 ++++++++++++++++++++++++++-----------
 include/hw/scsi/scsi.h      |  4 +-
 include/hw/usb/msd.h        |  2 +-
 include/hw/virtio/virtio.h  |  4 +-
 14 files changed, 182 insertions(+), 62 deletions(-)

Laurent Vivier (5):
  VirtioDeviceClass: Add an Error parameter to vmstate load member
  hw/char/virtio-serial-bus: validate nr_active_ports from migration
    stream
  hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
    state
  hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
    stream
  hw/scsi/spapr_vscsi: do not crash QEMU on migration errors

Michael S. Tsirkin (2):
  virtio: do not crash QEMU on migration errors
  mptsas: do not crash QEMU on migration errors

 hw/block/virtio-blk.c       | 11 +++++--
 hw/char/virtio-serial-bus.c | 30 +++++++++++------
 hw/scsi/esp.c               |  2 +-
 hw/scsi/mptsas.c            | 16 ++++++----
 hw/scsi/scsi-bus.c          | 18 +++++++++--
 hw/scsi/scsi-disk.c         |  7 ++--
 hw/scsi/scsi-generic.c      |  3 +-
 hw/scsi/spapr_vscsi.c       | 25 +++++++++++----
 hw/scsi/virtio-scsi.c       | 28 ++++++++++++----
 hw/usb/dev-storage.c        |  2 +-
 hw/virtio/virtio.c          | 64 ++++++++++++++++++++++++-------------
 include/hw/scsi/scsi.h      |  4 +--
 include/hw/usb/msd.h        |  2 +-
 include/hw/virtio/virtio.h  |  4 +--
 14 files changed, 150 insertions(+), 66 deletions(-)

-- 
2.54.0


