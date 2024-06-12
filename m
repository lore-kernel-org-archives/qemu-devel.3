Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90019C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNbm-00034t-Lt; Wed, 12 Jun 2024 09:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNbk-000348-Kb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNbh-0007k7-Db
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5yRaWwLDhGbvAU0z8G4TpcKLUfQNsgr5YLCwdYKTM4Q=;
 b=c1CgXfwmJFWklZgBTOEHePagRimhI4DD3xlnPGNeYsor0fHRGmiFmMIvY9diDpjk2Xnrhz
 BX3El7wDplXzobc0ltJFwJfkeXNGcdaaaG7yIkoRVl2Ps0y4CMw1fGj3KWL4qiXV2EAEjZ
 7Gf4iHVL0Ij2RMeOhN/wKCsFP/dkgCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-fmJDKycCM4OC8KA3o2xJ4w-1; Wed,
 12 Jun 2024 09:01:29 -0400
X-MC-Unique: fmJDKycCM4OC8KA3o2xJ4w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0A01956069; Wed, 12 Jun 2024 13:01:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79BE41956053; Wed, 12 Jun 2024 13:01:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 00/16] vfio: QOMify VFIOContainer
Date: Wed, 12 Jun 2024 15:01:06 +0200
Message-ID: <20240612130122.813935-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

The series starts with simple changes (patch 1-4). Two of which were
initialy sent by Joao in a series adding VFIO migration support with
vIOMMU [1].

The changes following prepare VFIOContainer for QOMification, switch
the container models to QOM when ready and add some final cleanups.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/


Avihai Horon (1):
  vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()

Cédric Le Goater (14):
  vfio: Make vfio_devices_dma_logging_start() return bool
  vfio: Remove unused declarations from vfio-common.h
  vfio/container: Introduce vfio_address_space_insert()
  vfio/container: Simplify vfio_container_init()
  vfio/container: Modify vfio_get_iommu_type() to use a container fd
  vfio/container: Introduce vfio_get_iommu_class_name()
  vfio/container: Introduce vfio_create_container()
  vfio/container: Discover IOMMU type before creating the container
  vfio/container: Change VFIOContainerBase to use QOM
  vfio/container: Switch to QOM
  vfio/container: Introduce an instance_init() handler
  vfio/container: Remove VFIOContainerBase::ops
  vfio/container: Remove vfio_container_init()
  vfio/container: Introduce vfio_iommu_legacy_instance_init()

Joao Martins (1):
  vfio/common: Move dirty tracking ranges update to helper

 include/hw/vfio/vfio-common.h         |  10 ++-
 include/hw/vfio/vfio-container-base.h |  16 +---
 hw/vfio/common.c                      | 124 ++++++++++++++++----------
 hw/vfio/container-base.c              |  66 ++++++++------
 hw/vfio/container.c                   | 104 +++++++++++----------
 hw/vfio/iommufd.c                     |  12 +--
 hw/vfio/pci.c                         |   4 +-
 hw/vfio/spapr.c                       |   3 +
 8 files changed, 193 insertions(+), 146 deletions(-)

-- 
2.45.2


