Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158BC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQlx-0008Gr-4K; Tue, 06 Feb 2024 14:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQlv-0008GK-BM
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQlt-0000cB-VB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707246377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qk9znVXbYI2JlbhJEPlg00fHcjNS/Uv8uu9frD/ohbg=;
 b=BDEzOhR8DqP9mLiHYtqbA/8/qBol0Pez4v3Vz6MV0YZBunaYBOs+Csi/6DULZJ7T5Wi+GT
 UqJ7pBCs2Yz6fu0fc6dPBmIIZF0gqjYkHeP+KiktW6P1h9156i7IMaucI44bwbLubM9zoi
 hgzAHUCDFPevPaOCRPVcD9E1iAZVcgY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-QIhMRlPSP2SrmOvJbPS0nQ-1; Tue,
 06 Feb 2024 14:06:12 -0500
X-MC-Unique: QIhMRlPSP2SrmOvJbPS0nQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84BD029AA382;
 Tue,  6 Feb 2024 19:06:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E02DD40C9444;
 Tue,  6 Feb 2024 19:06:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/5] virtio-blk: iothread-vq-mapping cleanups
Date: Tue,  6 Feb 2024 14:06:05 -0500
Message-ID: <20240206190610.107963-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2:
- Add comment in Patch 3 explaining why bounds check assertion [Manos]
- Remove redundant nested if in Patch 1 [Hanna]

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


