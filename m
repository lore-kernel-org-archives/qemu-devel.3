Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DC8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Tp-0006E4-4I; Fri, 10 Jul 2026 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tn-000665-2p
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tl-0003sg-3k
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783679346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nDVAYeNwtZ36piW6MkZr28SSEP6aNOycaQ8r5fgw+2o=;
 b=DxcEtuc7tcScpCfkGuVcMaaHZZ+f/nZzNdwb1E5TUXGrJAz9prnl/BCAjYX19FZlFgQhpz
 WMn6DOykz6S668ZKFzClRmWkeDBP2GIKmkgBCfpyjMBkxAvFIbxEEj1b3RjjCQraOdO/kH
 XuKJd83GJQQf1UXwNms9nHrA1RlQJaw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-V5CgW4QiPW2an91JFYiIVQ-1; Fri,
 10 Jul 2026 06:29:05 -0400
X-MC-Unique: V5CgW4QiPW2an91JFYiIVQ-1
X-Mimecast-MFC-AGG-ID: V5CgW4QiPW2an91JFYiIVQ_1783679344
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E060A195606C; Fri, 10 Jul 2026 10:29:03 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84D6A1800348; Fri, 10 Jul 2026 10:29:00 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>
Subject: [PATCH 0/3] Harden virtio migration load paths against crafted streams
Date: Fri, 10 Jul 2026 12:28:56 +0200
Message-ID: <20260710102859.1967551-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
virtqueue element deserializer, and assert()/exit(1) calls in
virtio-scsi request loading.

These are hardening fixes: the destination QEMU is in a paused
pre-start state and the source VM is unaffected by a failed migration.

Patch 1 validates the virtio-serial nr_active_ports count against the
configured maximum before allocating the post-load array.

Patch 2 replaces the assertions in qemu_get_virtqueue_element() with
a bounds check returning NULL, and updates all callers (virtio-serial,
virtio-blk, virtio-scsi, scsi-bus) to handle the failure gracefully.

Patch 3 replaces the remaining assert() and exit(1) calls in
virtio_scsi_load_request() with proper error returns.

Tested with migration round-trips for virtio-serial (0 to 511 ports),
virtio-blk (1-2 disks), and virtio-scsi (1-2 disks), plus the
original PoC reproducers for issues #3801 and #3802.

Laurent Vivier (3):
  hw/char/virtio-serial-bus: validate nr_active_ports from migration
    stream
  hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
    state
  hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
    stream

 hw/block/virtio-blk.c       |  4 ++++
 hw/char/virtio-serial-bus.c |  7 +++++++
 hw/scsi/scsi-bus.c          |  4 ++++
 hw/scsi/virtio-scsi.c       | 20 ++++++++++++++++----
 hw/virtio/virtio.c          | 11 ++++-------
 5 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.54.0


