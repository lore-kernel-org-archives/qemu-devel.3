Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6963C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uWy-00057z-8u; Mon, 06 May 2024 05:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uWu-00057A-Ce
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uWs-0007BV-Ik
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714987261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGOoUKz2+q1UL5Nviv0b3Y5yl9Qvc7lvRfYm07XSqrA=;
 b=ivv3Lrqr9GOEASqeKW0ZQ7RubqY/M3hCFncqHOG8+MXHMxNaadeRJULmaCR2zpGDZGKIvI
 dflz6SlNNS8ZVJQDbQiJt82nuGeeDYkUmjSx73O1A47zAIVtsFeDBxgvRXD+xe7Peh9VrQ
 CjZGZoLv4CG3TJJ00sJbo00l1mfhKi0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-3xqyVdkoOAaGIHwuI7dwhg-1; Mon,
 06 May 2024 05:20:57 -0400
X-MC-Unique: 3xqyVdkoOAaGIHwuI7dwhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30AAB29AB420;
 Mon,  6 May 2024 09:20:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF927AC69;
 Mon,  6 May 2024 09:20:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 00/10] vfio: Improve error reporting (part 2)
Date: Mon,  6 May 2024 11:20:43 +0200
Message-ID: <20240506092053.388578-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello,

The motivation behind these changes is to improve error reporting to
the upper management layer (libvirt) with a more detailed error, this
to let it decide, depending on the reported error, whether to try
migration again later. It would be useful in cases where migration
fails due to lack of HW resources on the host. For instance, some
adapters can only initiate a limited number of simultaneous dirty
tracking requests and this imposes a limit on the the number of VMs
that can be migrated simultaneously.

We are not quite ready for such a mechanism but what we can do first is
to cleanup the error reporting in the early save_setup sequence. This
is what the following changes propose, by adding an Error** argument to
various handlers and propagating it to the core migration subsystem.

The first part [1] of this series modifying the core migration
subsystem is now merged. This is the second part changing VFIO which
was already proposed in March. See [2].

Thanks,

C.

[1] [PATCH for-9.1 v5 00/14] migration: Improve error reporting
    https://lore.kernel.org/qemu-devel/20240320064911.545001-1-clg@redhat.com/

[2] [PATCH v4 00/25] migration: Improve error reporting
    https://lore.kernel.org/qemu-devel/20240306133441.2351700-1-clg@redhat.com/

Changes in v5:

 - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
 - Fixed typo in set_dirty_page_tracking documentation
 - Used error_setg_errno() in vfio_devices_dma_logging_start()
 - Replaced error_setg() by error_setg_errno() in vfio_migration_set_state()
 - Replaced error_setg() by error_setg_errno() in
   vfio_devices_query_dirty_bitmap() and vfio_legacy_query_dirty_bitmap()
 - ':' -> '-' in vfio_iommu_map_dirty_notify()

Cédric Le Goater (10):
  vfio: Add Error** argument to .set_dirty_page_tracking() handler
  vfio: Add Error** argument to vfio_devices_dma_logging_start()
  vfio: Extend migration_file_set_error() with Error** argument
  vfio: Use new Error** argument in vfio_save_setup()
  vfio: Add Error** argument to .vfio_save_config() handler
  vfio: Reverse test on vfio_get_dirty_bitmap()
  memory: Add Error** argument to memory_get_xlat_addr()
  vfio: Add Error** argument to .get_dirty_bitmap() handler
  vfio: Also trace event failures in vfio_save_complete_precopy()
  vfio: Extend vfio_set_migration_error() with Error* argument

 include/exec/memory.h                 |  15 ++-
 include/hw/vfio/vfio-common.h         |  29 +++++-
 include/hw/vfio/vfio-container-base.h |  35 ++++++-
 include/migration/misc.h              |   2 +-
 hw/vfio/common.c                      | 137 ++++++++++++++++----------
 hw/vfio/container-base.c              |   9 +-
 hw/vfio/container.c                   |  20 ++--
 hw/vfio/migration.c                   |  97 ++++++++++--------
 hw/vfio/pci.c                         |   5 +-
 hw/virtio/vhost-vdpa.c                |   5 +-
 migration/migration.c                 |   6 +-
 system/memory.c                       |  10 +-
 12 files changed, 244 insertions(+), 126 deletions(-)

-- 
2.45.0


