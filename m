Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8BC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1NDw-0001wT-04; Tue, 01 Sep 2026 08:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NDu-0001vv-4V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NDs-00071W-DI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788264254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VHSUA6upzNGECkdJcbaIJ6C7sTKu7I3QIRpugTEwoPo=;
 b=Z1cmnxic60vcCtw8rlLvesUrxcsnKrGOU2K+TVPDDToJXbBaEIJjI206wSjMUMw1OFwFsN
 pBh4/abEUKrK025qRmUmeM6aHdeRrYnQ5XupZ+uu3YlNAq71wZNU2cMCqmLyM3cLROhKfQ
 Fppdq589hG+oRbmhnD9xBlME9wUqLt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-zlvfC0mlMsmwHdQCJhaQfw-1; Tue,
 01 Sept 2026 08:04:11 -0400
X-MC-Unique: zlvfC0mlMsmwHdQCJhaQfw-1
X-Mimecast-MFC-AGG-ID: zlvfC0mlMsmwHdQCJhaQfw_1788264250
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE9E0195DE35; Tue,  1 Sep 2026 12:04:09 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FF1C1955F02; Tue,  1 Sep 2026 12:04:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 0/3] hw/display: add vhost-user-media device
Date: Tue, 01 Sep 2026 14:04:03 +0200
Message-Id: <20260901-virtio-media-v2-0-bd3cc9347ab9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDSwND3bLMopLMfN3c1JTMRF0LwyRji0QzA5PExEQloJaCotS0zAqwcdG
 xtbUAMOH4RF4AAAA=
X-Change-ID: 20260901-virtio-media-81b38a604aaa
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, manos.pitsidianakis@linaro.org, 
 alex.bennee@linaro.org, Dorinda Bassey <dbassey@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264246; l=2880;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=pJkY0TVnPXdIkqRisp8r+82regxoytAJu/WPR5I2//c=;
 b=p5AKP35Mo0Y+md9plJtXd43/s0OPcJ6kOKz0P/sFBbDrFcowPmn0wbshkNDIlJ8/mJ4bgGXUY
 y/65kvOI2lJB+eiK/MDwwU2m0SbNywKnI7l+nboayhKnxrQfIwTQVTl
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This series introduces the QEMU frontend for the virtio-media device,
a VirtIO device that exposes V4L2 video device functionality to the guest
over the virtio-media protocol, as specified in the VirtIO specification
v1.4, section 5.22 [1].

Overview
--------
Patch 1 adds VIRTIO_ID_MEDIA definition from Linux v7.3-rc1.

Patch 2 introduces the vhost-user-media device frontend as defined by
the specification.

Patch 3 adds a shared memory PCI BAR (BAR 2) sized by GET_SHMEM_CONFIG
and used by the guest driver as a MMAP mapping window for video buffer
exchange with the host backend. The region is exposed to the guest
through a VirtIO shared memory capability.

Testing
-------
The series was tested with:

  Guest driver: the virtio-media out-of-tree Linux kernel driver [2].
  An upstream series for this driver has also been posted [3].

  Host backend: the rust-vmm vhost-device-media backend [4]:
      cargo run -- -s /path/to/media.sock -d /dev/video0 --backend v4l2-proxy

  Full QEMU invocation:

      qemu-system-x86_64 \
          -chardev socket,path=/path/to/media.sock,id=media \
          -device vhost-user-media-pci,chardev=media,id=media \
          -object memory-backend-memfd,id=mem,size=4G,share=on \
          -numa node,memdev=mem

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/cs01/virtio-v1.4-cs01.html
[2] https://github.com/chromeos/virtio-media/tree/main/driver
[3] https://lore.kernel.org/all/20260622204343.1994418-1-briandaniels@google.com/
[4] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-media

--
Changes in v2:
- virtio_ids.h header updated from kernel sources
- Updated copyright year to current
- Added MAINTAINERS entry for vhost-user-media
- Added GET_SHMEM_CONFIG request for media shm region
- Few other changes to align media with other backends
- Link to v1: https://lore.kernel.org/qemu-devel/20260630112310.552606-1-aesteve@redhat.com/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (3):
      linux-headers: add VIRTIO_ID_MEDIA
      hw/display: add vhost-user-media device
      hw/display/vhost-user-media: add shared memory region BAR

 MAINTAINERS                                 |   6 +
 hw/display/Kconfig                          |   5 +
 hw/display/meson.build                      |   3 +
 hw/display/vhost-user-media-pci.c           | 115 +++++++++
 hw/display/vhost-user-media.c               | 388 ++++++++++++++++++++++++++++
 hw/virtio/virtio.c                          |   3 +-
 include/hw/virtio/vhost-user-media.h        |  46 ++++
 include/standard-headers/linux/virtio_ids.h |   1 +
 8 files changed, 566 insertions(+), 1 deletion(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260901-virtio-media-81b38a604aaa

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>


