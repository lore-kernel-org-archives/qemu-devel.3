Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA91C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvWm-0003vq-Km; Fri, 02 Feb 2024 10:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWj-0003vF-RU
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWi-0000C3-EH
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706887943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nTVW0ex8r7dGzT2U4Ccj8kElbtM0N6FAXXTnFzTz3so=;
 b=hvq1Y2EqHXo+D/qQToSP4CZcFxU1DutfntOf1ffzqN0OjSviZe/4dDMZdfO14DdFQvGKxe
 JPp00JDqzbGGSa7XrkHRJIgZ8liCXUhGr0Zw1RgqerTYKhFek88NziFIxDJpvVG13MdvuW
 fD0meWmvjJO0RQ2pYyq4z0z68Sj7xAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-DjKHpWLeNNOYxbLs4s7pJQ-1; Fri, 02 Feb 2024 10:32:20 -0500
X-MC-Unique: DjKHpWLeNNOYxbLs4s7pJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61CDE85CBA4;
 Fri,  2 Feb 2024 15:32:20 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2E193C2E;
 Fri,  2 Feb 2024 15:32:19 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 0/3] virtio: Re-enable notifications after drain
Date: Fri,  2 Feb 2024 16:31:55 +0100
Message-ID: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
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

v1:

https://lists.nongnu.org/archive/html/qemu-block/2024-01/msg00336.html


Hi,

This is basically the same series as v1: When using
aio_set_event_notifier_poll(), the io_poll_end() callback is only
invoked when polling ends, not when the notifier is being removed while
in a polling section.  This can leave the virtqueue notifier disabled
during drained sections, which however is not a bad thing.  We just need
to ensure they are re-enabled after the drain, and kick the virtqueue
once to pick up all the requests that came in during the drained
section.

Patch 1 is a technically unrelated fix, but addresses a problem that
became visible with patch 2 applied.

Patch 3 is a small (optional) clean-up patch.


v2:
- Changed the title of this series and patch 2 (was: "Keep notifications
  disabled durin drain"): Keeping the notifier disabled was something
  the initial RFC did, this version (v1 too) just ensures the notifier
  is enabled after the drain, regardless of its state before.

- Use event_notifier_set() instead of virtio_queue_notify() in patch 2

- Added patch 3


Hanna Czenczek (3):
  virtio-scsi: Attach event vq notifier with no_poll
  virtio: Re-enable notifications after drain
  virtio-blk: Use ioeventfd_attach in start_ioeventfd

 include/block/aio.h   |  7 ++++++-
 hw/block/virtio-blk.c | 21 ++++++++++-----------
 hw/scsi/virtio-scsi.c |  7 ++++++-
 hw/virtio/virtio.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.43.0


