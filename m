Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE8FC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN29-0004I7-Im; Wed, 11 Jun 2025 11:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN28-0004Hx-0Q
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN26-00071r-7h
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=toy0Bwfi6m8o9wIri5DUHpcUptCGS9a7YDqMIF+bLqU=;
 b=S22oUDR6HtEhk59XFXLVx19yvY9hDVQPcez9bwteHG1xCNVqujss1b61UAOZCaB8hZ0UE9
 cDTgJteqFCgc80TTOwKckjccdKSWuN5p4cU/AmzqeH+svgKvUpno+ztHVilpAbXJTOVKMT
 nGgLh5Kj8ddUy6Br+uNcwi63dkpQvW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-DYOuOB_WO-WfoyhUcL12bg-1; Wed,
 11 Jun 2025 11:06:26 -0400
X-MC-Unique: DYOuOB_WO-WfoyhUcL12bg-1
X-Mimecast-MFC-AGG-ID: DYOuOB_WO-WfoyhUcL12bg_1749654384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5924C19560B1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 15:06:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4648F180045B; Wed, 11 Jun 2025 15:06:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/27] vfio queue
Date: Wed, 11 Jun 2025 17:05:52 +0200
Message-ID: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:

  Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250611

for you to fetch changes up to 079e7216debd767e78a77aefc88e2e7335f49b26:

  vfio: improve VFIODeviceIOOps docs (2025-06-11 14:01:58 +0200)

----------------------------------------------------------------
vfio queue:

* Fixed newly added potential issues in vfio-pci
* Added support to report vfio-ap configuration changes
* Added prerequisite support for vfio-user
* Added first part for VFIO live update support

----------------------------------------------------------------
John Levon (4):
      vfio: export PCI helpers needed for vfio-user
      vfio: add per-region fd support
      vfio: mark posted writes in region write callbacks
      vfio: improve VFIODeviceIOOps docs

Rorie Reyes (4):
      hw/vfio/ap: notification handler for AP config changed event
      hw/vfio/ap: store object indicating AP config changed in a queue
      hw/vfio/ap: Storing event information for an AP configuration change event
      s390: implementing CHSC SEI for AP config change

Steve Sistare (17):
      migration: cpr helpers
      migration: lower handler priority
      vfio/container: register container for cpr
      vfio/container: preserve descriptors
      vfio/container: discard old DMA vaddr
      vfio/container: restore DMA vaddr
      vfio/container: mdev cpr blocker
      vfio/container: recover from unmap-all-vaddr failure
      pci: export msix_is_pending
      pci: skip reset during cpr
      vfio-pci: skip reset during cpr
      vfio/pci: vfio_pci_vector_init
      vfio/pci: vfio_notifier_init
      vfio/pci: pass vector to virq functions
      vfio/pci: vfio_notifier_init cpr parameters
      vfio/pci: vfio_notifier_cleanup
      vfio/pci: export MSI functions

Zhenzhong Duan (2):
      vfio/container: Fix vfio_listener_commit()
      vfio/pci: Fix instance_size of VFIO_PCI_BASE

 MAINTAINERS                           |   1 +
 hw/vfio/pci.h                         |  19 +++
 include/hw/pci/msix.h                 |   1 +
 include/hw/pci/pci.h                  |   2 +
 include/hw/s390x/ap-bridge.h          |  39 +++++
 include/hw/vfio/vfio-container-base.h |   3 +
 include/hw/vfio/vfio-container.h      |   2 +
 include/hw/vfio/vfio-cpr.h            |  39 +++++
 include/hw/vfio/vfio-device.h         |  59 +++++--
 include/hw/vfio/vfio-region.h         |   1 +
 include/migration/cpr.h               |   5 +
 include/migration/vmstate.h           |   6 +-
 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |   5 +
 hw/s390x/ap-stub.c                    |  21 +++
 hw/vfio/ap.c                          |  88 +++++++++++
 hw/vfio/container.c                   |  97 +++++++++---
 hw/vfio/cpr-legacy.c                  | 287 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                         |  36 ++++-
 hw/vfio/device.c                      |  32 +++-
 hw/vfio/listener.c                    |  21 ++-
 hw/vfio/pci.c                         | 205 +++++++++++++++---------
 hw/vfio/region.c                      |  12 +-
 migration/cpr.c                       |  36 +++++
 migration/savevm.c                    |   4 +-
 target/s390x/ioinst.c                 |  11 +-
 hw/s390x/meson.build                  |   1 +
 hw/vfio/meson.build                   |   1 +
 hw/vfio/trace-events                  |   6 +-
 29 files changed, 914 insertions(+), 128 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c
 create mode 100644 hw/vfio/cpr-legacy.c


