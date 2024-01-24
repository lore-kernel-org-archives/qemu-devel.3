Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A23C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShD4-00028p-0d; Wed, 24 Jan 2024 12:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rShD2-00026G-N4
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rShD0-00026T-0M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706117921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sgjNTkQlo22fZWHf6YGut2OQWswQUfoPMwnpvIq/O50=;
 b=FNJJbiDL1CMPRVkIo3Ui+slBzf7+FaYJTwBzMCa6wvdYxk17AaJq5Ne4Z5x4WlfKVfYuwi
 whd2HShxjLXUMmT1DQG5QMar9+hbbp5al0n86XRLK7kHMAYxyI0Qv3aVVv2hlBZng8hVbP
 zplrPkBi6wBzU+C2Ir1qPgJiUrDf5EM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-vlwdfaVfOX2jI0TuUVdnXg-1; Wed,
 24 Jan 2024 12:38:37 -0500
X-MC-Unique: vlwdfaVfOX2jI0TuUVdnXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 066B93C0F370;
 Wed, 24 Jan 2024 17:38:37 +0000 (UTC)
Received: from localhost (unknown [10.39.194.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3747228AC;
 Wed, 24 Jan 2024 17:38:36 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/2] virtio: Keep notifications disabled during drain
Date: Wed, 24 Jan 2024 18:38:28 +0100
Message-ID: <20240124173834.66320-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

When registering callbacks via aio_set_event_notifier_poll(), the
io_poll_end() callback is only invoked when polling actually ends.  If
the notifiers are removed while in a polling section, it is not called.
Therefore, io_poll_start() is not necessarily followed up by
io_poll_end().

It is not entirely clear whether this is good or bad behavior.  On one
hand, it may be unexpected to callers.  On the other, it may be
counterproductive to call io_poll_end() when the polling section has not
ended yet.

Right now, there is only one user of aio_set_event_notifier(), which is
virtio_queue_aio_attach_host_notifier().  It does not expect this
behavior, which leads to virtqueue notifiers remaining disabled if
virtio_queue_aio_detach_host_notifier() is called while polling.  That
can happen e.g. through virtio_scsi_drained_begin() or
virtio_blk_drained_begin() (through virtio_blk_data_plane_detach()).
In such a case, the virtqueue may not be processed for a while, letting
the guest driver hang.  This can be reproduced by repeatedly
hot-plugging and -unplugging a virtio-scsi device with a scsi-hd disk,
because the guest will try to enumerate the virtio-scsi device while
we’re attaching the scsi-hd disk, which causes a drain, which can cause
the virtio-scsi virtqueue to stall as described.

Stefan has suggested ensuring we always follow up io_poll_start() by
io_poll_end():

https://lists.nongnu.org/archive/html/qemu-block/2023-12/msg00163.html

I prefer changing the caller instead, because I don’t think we actually
want the virtqueue notifier to be force-enabled when removing our AIO
notifiers.  So I believe we actually only want to take care to
force-enable it when we re-attach the AIO notifiers, and to kick
virtqueue processing once, in case we missed any events while the AIO
notifiers were not attached.

That is done by patch 2.  We have already discussed a prior version of
it here:

https://lists.nongnu.org/archive/html/qemu-block/2024-01/msg00001.html

And compared to that, based on the discussion, there are some changes:
1. Used virtio_queue_notify() instead of virtio_queue_notify_vq(), as
   suggested by Paolo, because it’s thread-safe
2. Moved virtio_queue_notify() into
   virtio_queue_aio_attach_host_notifier*(), because we always want it
3. Dropped virtio_queue_set_notification(vq, 0) from
   virtio_queue_aio_detach_host_notifier(): Paolo wasn’t sure whether
   that was safe to do from any context.  We don’t really need to call
   it anyway, so I just dropped it.
4. Added patch 1:

Patch 1 fixes virtio_scsi_drained_end() so it won’t attach polling
notifiers for the event virtqueue.  That didn’t turn out to be an issue
so far, but with patch 2, Fiona saw the virtqueue processing queue
spinning in a loop as described in
38738f7dbbda90fbc161757b7f4be35b52205552 ("virtio-scsi: don't waste CPU
polling the event virtqueue").


Note that as of eaad0fe26050c227dc5dad63205835bac4912a51 ("scsi: only
access SCSIDevice->requests from one thread") there’s a different
problem when trying to reproduce the bug via hot-plugging and
-unplugging a virtio-scsi device, specifically, when unplugging, qemu
may crash with an assertion failure[1].  I don’t have a full fix for
that yet, but in case you need a work-around for the specific case of
virtio-scsi hot-plugging and -unplugging, you can use this patch:

https://czenczek.de/0001-DONTMERGE-Fix-crash-on-scsi-unplug.patch


[1] https://lists.nongnu.org/archive/html/qemu-block/2024-01/msg00317.html


Hanna Czenczek (2):
  virtio-scsi: Attach event vq notifier with no_poll
  virtio: Keep notifications disabled during drain

 include/block/aio.h   |  7 ++++++-
 hw/scsi/virtio-scsi.c |  7 ++++++-
 hw/virtio/virtio.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.43.0


