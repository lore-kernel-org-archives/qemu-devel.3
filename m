Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B89CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2166-0008Ai-CN; Fri, 26 Sep 2025 01:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2164-0008AS-Vs
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v215y-0000ht-Hx
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tL4fHJ+R8bfe4F8GBAcs9mBmKIyYR2X1iEIuqGWnuco=;
 b=Z3NN26YoD7i0t3KBDx8e4UyZDx5GXQURPSBX9Mb8KVNxEughdM5ZUTg8LhWcTRXM7rYTxl
 EVwOVgnqLpMZg2FKkt8GZJYqdMpaA3Dt47yyiAcfyRJbYPR900LM0B1ITYqgoxkLgn4TBU
 9W+U1Oy4s2goUDXwmcWjBqAfpmROZyI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-yTSlVWAhMNSxQSPO4ICLYA-1; Fri,
 26 Sep 2025 01:34:03 -0400
X-MC-Unique: yTSlVWAhMNSxQSPO4ICLYA-1
X-Mimecast-MFC-AGG-ID: yTSlVWAhMNSxQSPO4ICLYA_1758864843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09BDF19560AE
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:34:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E3931800579; Fri, 26 Sep 2025 05:34:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/29] vfio queue
Date: Fri, 26 Sep 2025 07:33:29 +0200
Message-ID: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250926

for you to fetch changes up to 7c773b4267ae10820ed5e3ec6b15219b39dbcebd:

  include/hw/vfio/vfio-device.h: fix include header guard name (2025-09-25 17:55:20 +0200)

----------------------------------------------------------------
vfio queue:

* New vfio-user functional test
* Improved naming conventions

----------------------------------------------------------------
Mark Cave-Ayland (29):
      tests/functional: add a vfio-user smoke test
      include/hw/vfio/vfio-container.h: rename VFIOContainer to VFIOLegacyContainer
      include/hw/vfio/vfio-container-base.h: rename VFIOContainerBase to VFIOContainer
      include/hw/vfio/vfio-container.h: rename file to vfio-container-legacy.h
      include/hw/vfio/vfio-container-base.h: rename file to vfio-container.h
      hw/vfio/container.c: rename file to container-legacy.c
      hw/vfio/container-base.c: rename file to container.c
      vfio/iommufd.c: use QOM casts where appropriate
      vfio/cpr-iommufd.c: use QOM casts where appropriate
      vfio/vfio-iommufd.h: rename VFIOContainer bcontainer field to parent_obj
      vfio/spapr.c: use QOM casts where appropriate
      vfio/spapr.c: rename VFIOContainer bcontainer field to parent_obj
      vfio/pci.c: rename vfio_instance_init() to vfio_pci_init()
      vfio/pci.c: rename vfio_instance_finalize() to vfio_pci_finalize()
      vfio/pci.c: rename vfio_pci_dev_class_init() to vfio_pci_class_init()
      vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
      hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to TYPE_VFIO_PCI_DEVICE
      vfio/pci.c: rename vfio_pci_base_dev_class_init() to vfio_pci_device_class_init()
      vfio/pci.c: rename vfio_pci_base_dev_info to vfio_pci_device_info
      vfio/pci.c: rename vfio_pci_dev_properties[] to vfio_pci_properties[]
      vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[] to vfio_pci_nohotplug_properties[]
      vfio/pci.c: rename vfio_pci_nohotplug_dev_class_init() to vfio_pci_nohotplug_class_init()
      vfio/pci.c: rename vfio_pci_nohotplug_dev_info to vfio_pci_nohotplug_info
      vfio-user/pci.c: rename vfio_user_pci_dev_class_init() to vfio_user_pci_class_init()
      vfio-user/pci.c: rename vfio_user_pci_dev_properties[] to vfio_user_pci_properties[]
      vfio-user/pci.c: rename vfio_user_instance_init() to vfio_user_pci_init()
      vfio-user/pci.c: rename vfio_user_instance_finalize() to vfio_user_pci_finalize()
      vfio-user/pci.c: rename vfio_user_pci_dev_info to vfio_user_pci_info
      include/hw/vfio/vfio-device.h: fix include header guard name

 MAINTAINERS                                      |    1 +
 hw/vfio-user/container.h                         |    4 +-
 hw/vfio/pci.h                                    |    2 +-
 hw/vfio/types.h                                  |    4 +-
 hw/vfio/vfio-iommufd.h                           |    9 +-
 hw/vfio/vfio-listener.h                          |    4 +-
 include/hw/vfio/vfio-container-base.h            |  279 -----
 include/hw/vfio/vfio-container-legacy.h          |   39 +
 include/hw/vfio/vfio-container.h                 |  286 ++++-
 include/hw/vfio/vfio-cpr.h                       |   15 +-
 include/hw/vfio/vfio-device.h                    |   12 +-
 hw/ppc/spapr_pci_vfio.c                          |   14 +-
 hw/s390x/s390-pci-vfio.c                         |   16 +-
 hw/vfio-user/container.c                         |   18 +-
 hw/vfio-user/pci.c                               |   35 +-
 hw/vfio/container-base.c                         |  347 ------
 hw/vfio/container-legacy.c                       | 1277 +++++++++++++++++++++
 hw/vfio/container.c                              | 1325 ++++------------------
 hw/vfio/cpr-iommufd.c                            |    4 +-
 hw/vfio/cpr-legacy.c                             |   43 +-
 hw/vfio/device.c                                 |    4 +-
 hw/vfio/iommufd.c                                |   48 +-
 hw/vfio/listener.c                               |   74 +-
 hw/vfio/pci.c                                    |   68 +-
 hw/vfio/spapr.c                                  |   52 +-
 hw/vfio/meson.build                              |    2 +-
 tests/functional/x86_64/meson.build              |    1 +
 tests/functional/x86_64/test_vfio_user_client.py |  201 ++++
 28 files changed, 2194 insertions(+), 1990 deletions(-)
 delete mode 100644 include/hw/vfio/vfio-container-base.h
 create mode 100644 include/hw/vfio/vfio-container-legacy.h
 delete mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/container-legacy.c
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py


