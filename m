Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08890CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obl-0005jU-Q6; Mon, 22 Sep 2025 18:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obh-0005e0-Ng
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obe-0001sI-Lh
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+rshgyCdBIuDTsFJnW77Yg4Y41sdmr4f5CG2JHHpJs8=;
 b=UYhn8Tdy7cacfiBK646ket9gGzXj00H6wiwsFQjSlqgegT1J19KTyd7jF9maHhmFXjveLE
 IIJ/O4Q4LXNCAJCRpkF9oFpSREM8i8EN94Lk0hqBzg76eU8Wz4xn6P/TwhQt702zm4bWqz
 ukNn3qfW9hNgXf9tqeyxtjwm91QHpek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-IIlhRA2YPj-v1YrFLcOQTg-1; Mon,
 22 Sep 2025 18:01:53 -0400
X-MC-Unique: IIlhRA2YPj-v1YrFLcOQTg-1
X-Mimecast-MFC-AGG-ID: IIlhRA2YPj-v1YrFLcOQTg_1758578512
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6DC1800350; Mon, 22 Sep 2025 22:01:52 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B0B41800446; Mon, 22 Sep 2025 22:01:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/5] virtio: allow virtio_error() in IOThreads
Date: Mon, 22 Sep 2025 18:01:44 -0400
Message-ID: <20250922220149.498967-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The hw/virtio/ code calls virtio_error() when the guest driver does something
invalid. virtio_error() is currently not usable outside the Big QEMU Lock (BQL)
because it calls into the interrupt code path (MSI, etc) that requires the BQL.

Make the hw/virtio.c code aware of the IOThread case where the BQL is not held
and use irqfd there. This makes virtio_error() available to IOThreads.

Stefan Hajnoczi (5):
  vhost: use virtio_config_get_guest_notifier()
  virtio: unify virtio_notify_irqfd() and virtio_notify()
  virtio: support irqfd in virtio_notify_config()
  tests/libqos: extract qvirtqueue_set_avail_idx()
  tests/virtio-scsi: add a virtio_error() IOThread test

 include/hw/virtio/virtio.h     |  1 -
 tests/qtest/libqos/virtio.h    |  2 ++
 hw/block/virtio-blk.c          |  6 +-----
 hw/scsi/virtio-scsi.c          |  6 +-----
 hw/virtio/vhost.c              | 11 +++++++----
 hw/virtio/virtio.c             | 35 ++++++++++++++++++----------------
 tests/qtest/libqos/virtio.c    | 16 ++++++++++++----
 tests/qtest/virtio-scsi-test.c | 32 +++++++++++++++++++++++++++++++
 hw/virtio/trace-events         |  1 -
 9 files changed, 74 insertions(+), 36 deletions(-)

-- 
2.51.0


