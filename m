Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA97EC48297
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2kP-0008Qs-3f; Mon, 05 Feb 2024 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kM-0008QH-UP
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kL-0006N2-2w
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707154023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LupsDdRCboTtrl6w5VQovcR2YIzDGTBn0l2JbKnYgOs=;
 b=ilLHlHJQvJuHcBsYAm+ZwZLARlVWMZQLo2n9UbQkMJpVjQKz0GpIzxBsfuxVNhvnXaQahA
 oihW57Tyu80D8B+7Ahgw7C6Yqqht9waKg7qhnzkqsH6/F9bzg9F++MoZdakRZBsDPtaZSS
 tyzfA/83ibd5Dd0/KdOTMxW9GCvLmZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-mKtTPHKjOhKjcQPSwKrmyw-1; Mon, 05 Feb 2024 12:27:02 -0500
X-MC-Unique: mKtTPHKjOhKjcQPSwKrmyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4F5E84AC60;
 Mon,  5 Feb 2024 17:27:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 565EE492BC6;
 Mon,  5 Feb 2024 17:27:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 0/5] virtio-blk: iothread-vq-mapping cleanups
Date: Mon,  5 Feb 2024 12:26:54 -0500
Message-ID: <20240205172659.476970-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hanna reviewed the iothread-vq-mapping patches after they were applied to
qemu.git. This series consists of code cleanups that Hanna identified.

There are no functional changes or bug fixes that need to be backported to the
stable tree here, but it may make sense to backport them in the future to avoid
conflicts.

Stefan Hajnoczi (5):
  virtio-blk: enforce iothread-vq-mapping validation
  virtio-blk: clarify that there is at least 1 virtqueue
  virtio-blk: add vq_rq[] bounds check in virtio_blk_dma_restart_cb()
  virtio-blk: declare VirtIOBlock::rq with a type
  monitor: use aio_co_reschedule_self()

 include/hw/virtio/virtio-blk.h |   2 +-
 hw/block/virtio-blk.c          | 194 ++++++++++++++++++---------------
 qapi/qmp-dispatch.c            |   7 +-
 3 files changed, 112 insertions(+), 91 deletions(-)

-- 
2.43.0


