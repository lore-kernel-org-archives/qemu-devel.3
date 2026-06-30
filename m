Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB56C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWYx-0003Wp-QZ; Tue, 30 Jun 2026 07:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYk-0003SQ-Pr
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYh-0005br-E2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782818596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nn7wAQySvYQPqCaaoPzWCdHh+QUoLvsSCq7YQ7Cq5L4=;
 b=eGo6o/bx48xg4yTonkx++RWhtnDS8r/RN2QXjgrjamjeulzSis3g2UCGnXS0h/EvjIJA7S
 N/8StJ6nv/llSIdwkutvP117I2iWh86gvlI+w1xtms+QA/E/NqUNJZIPrIvF1LtugzZgg4
 +DN26UnWzh5enG21KNDpyLwv8Id+gt8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-GoW7Ju1dNd2tuUeVVYuiXA-1; Tue,
 30 Jun 2026 07:23:15 -0400
X-MC-Unique: GoW7Ju1dNd2tuUeVVYuiXA-1
X-Mimecast-MFC-AGG-ID: GoW7Ju1dNd2tuUeVVYuiXA_1782818594
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21BE61800A3B; Tue, 30 Jun 2026 11:23:14 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDA33180065F; Tue, 30 Jun 2026 11:23:11 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 0/3] hw/display: add vhost-user-media device
Date: Tue, 30 Jun 2026 13:23:07 +0200
Message-ID: <20260630112310.552606-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series introduces the QEMU frontend for the virtio-media device,
a VirtIO device that exposes V4L2 video device functionality to the guest
over the virtio-media protocol, as specified in the VirtIO specification
v1.4, section 5.22 [1].

Note on patch 1
---------------
Patch 1 adds a temporary virtio-media device ID to QEMU's copy of the
Linux standard headers. It is included to unblock testing but is marked
"DO NOT MERGE": it will be superseded once the corresponding kernel-side
patch [2] is merged upstream and QEMU's headers are updated to match.
Patches 2 and 3 depend on patch 1 for the VIRTIO_ID_MEDIA definition.

Overview
--------
Patch 2 introduces the vhost-user-media device frontend as defined by
the specification.

Patch 3 adds a 4 GiB shared memory PCI BAR (BAR 2) used by the guest
driver as a DMA cache for video buffer exchange with the host backend.
The region is exposed to the guest through a VirtIO shared memory
capability.

Testing
-------
The series was tested with:

  Guest driver: the virtio-media out-of-tree Linux kernel driver [3].
  An upstream series for this driver has also been posted [4].

  Host backend: the rust-vmm vhost-device-media backend [5]:
      cargo run -- -s /path/to/media.sock -d /dev/video0 --backend v4l2-proxy

  Full QEMU invocation:

      qemu-system-x86_64 \
          -chardev socket,path=/tmp/media.sock,id=media \
          -device vhost-user-media-pci,chardev=media,id=media \
          -object memory-backend-memfd,id=mem,size=4G,share=on \
          -numa node,memdev=mem

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/cs01/virtio-v1.4-cs01.html
[2] https://lore.kernel.org/all/20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com/
[3] https://github.com/chromeos/virtio-media/tree/main/driver
[4] https://lore.kernel.org/all/20260622204343.1994418-1-briandaniels@google.com/
[5] https://github.com/rust-vmm/vhost-device/pull/944

Albert Esteve (3):
  virtio_ids: Add ID for virtio media
  hw/display: add vhost-user-media device
  hw/display/vhost-user-media: add shared memory cache BAR

 hw/display/Kconfig                          |   5 +
 hw/display/meson.build                      |   3 +
 hw/display/vhost-user-media-pci.c           | 105 ++++++
 hw/display/vhost-user-media.c               | 397 ++++++++++++++++++++
 hw/virtio/virtio.c                          |   3 +-
 include/hw/virtio/vhost-user-media.h        |  47 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 7 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/vhost-user-media-pci.c
 create mode 100644 hw/display/vhost-user-media.c
 create mode 100644 include/hw/virtio/vhost-user-media.h

-- 
2.54.0


