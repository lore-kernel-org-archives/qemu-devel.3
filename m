Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62954E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6dZ-0006wt-MU; Tue, 24 Dec 2024 10:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dY-0006wV-Gk
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dW-00042Z-SI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q9cQB3krYJKeRLC6mSoeU6Cho5QxSHUAe9BzXenEC84=;
 b=CKPxCfrrU9NvCIVXkHg7RnsJFit0nNVtZflnYej3qyKmIK597XsQ4O4YsaozDINUnyfBvt
 NbaqVv0x6jdX+C7d/orwrEQfek2/xQ+EeSl61Mbf9xY+krMZxiBEtdi6RKVJb4EbXa94JV
 FlBgLsUsuh9Wqp4mbE0Y/TKG374/SVo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-GLuQENtUNNCdHokZ1shbEQ-1; Tue,
 24 Dec 2024 10:15:52 -0500
X-MC-Unique: GLuQENtUNNCdHokZ1shbEQ-1
X-Mimecast-MFC-AGG-ID: GLuQENtUNNCdHokZ1shbEQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E93619560BD
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 15:15:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE1903000197; Tue, 24 Dec 2024 15:15:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/17] vfio queue
Date: Tue, 24 Dec 2024 16:15:30 +0100
Message-ID: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit aa3a285b5bc56a4208b3b57d4a55291e9c260107:

  Merge tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into staging (2024-12-22 14:33:27 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20241224

for you to fetch changes up to 242c3cb9a0b0375515630f11c4ecf277f00d1f37:

  migration: Unexport migration_is_active() (2024-12-23 20:15:55 +0100)

----------------------------------------------------------------
vfio queue:

* Add support for IGD passthrough on all Intel Gen 11 and 12 devices
* Refactor dirty tracking engine to include VFIO state in calc-dirty-rate
* Drop usage migration_is_device() and migration_is_active()

----------------------------------------------------------------
Avihai Horon (7):
      vfio/container: Add dirty tracking started flag
      vfio/migration: Refactor vfio_devices_all_dirty_tracking() logic
      vfio/migration: Refactor vfio_devices_all_running_and_mig_active() logic
      vfio/migration: Rename vfio_devices_all_dirty_tracking()
      system/dirtylimit: Don't use migration_is_active()
      migration: Drop migration_is_device()
      migration: Unexport migration_is_active()

Tomita Moeko (10):
      vfio/igd: fix GTT stolen memory size calculation for gen 8+
      vfio/igd: remove unsupported device ids
      vfio/igd: align generation with i915 kernel driver
      vfio/igd: canonicalize memory size calculations
      vfio/igd: add Gemini Lake and Comet Lake device ids
      vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
      vfio/igd: add macro for declaring mirrored registers
      vfio/igd: emulate GGC register in mmio bar0
      vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
      vfio/igd: add x-igd-gms option back to set DSM region size for guest

 include/hw/vfio/vfio-common.h         |   6 +-
 include/hw/vfio/vfio-container-base.h |   1 +
 include/migration/misc.h              |   2 -
 hw/vfio/common.c                      |  57 ++++----
 hw/vfio/container-base.c              |  12 +-
 hw/vfio/container.c                   |   2 +-
 hw/vfio/igd.c                         | 262 +++++++++++++++++++++-------------
 migration/migration.c                 |  23 ++-
 system/dirtylimit.c                   |   3 +-
 9 files changed, 214 insertions(+), 154 deletions(-)


