Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F80E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjNT-0007Bg-8k; Thu, 26 Dec 2024 03:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQjNR-0007BX-Op
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQjNQ-0002GY-3m
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735202270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0itVGAftAcMyFMkBRGn4Le/tPG7BCw0AY/lt/ZdyzTA=;
 b=Wk2y8M9gzsSIla9PuxYKgjdAUESLvAOO0vL1oST9u6ABRUbY6c9fqjfkcSAKnTD+892uG9
 tCnUX+AkoR/Vsxuahk5RyJLtlxlZaQP0NaesLddhooXF3kJSlWQepIKuPwGOt1qbvIkOPx
 7mCPDkH999IBbdmc1vrCL9zKF2odme8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-oQmZMNo-NpmUVk7lBiM3Mg-1; Thu,
 26 Dec 2024 03:37:48 -0500
X-MC-Unique: oQmZMNo-NpmUVk7lBiM3Mg-1
X-Mimecast-MFC-AGG-ID: oQmZMNo-NpmUVk7lBiM3Mg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DBD419560B1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 08:37:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5AAE19560A3; Thu, 26 Dec 2024 08:37:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v2 00/17] vfio queue
Date: Thu, 26 Dec 2024 09:37:41 +0100
Message-ID: <20241226083742.690265-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit a7f77545d401266a6415e6e03c7738c95314f0e6:

  Merge tag 'pull-tcg-20241224' of https://gitlab.com/rth7680/qemu into staging (2024-12-25 08:33:33 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20241226

for you to fetch changes up to 3bdb1a75f1bb4234904dec7753de9c0c0ece3dbf:

  migration: Unexport migration_is_active() (2024-12-26 07:23:38 +0100)

----------------------------------------------------------------
vfio queue:

* Add support for IGD passthrough on all Intel Gen 11 and 12 devices
* Refactor dirty tracking engine to include VFIO state in calc-dirty-rate
* Drop usage migration_is_device() and migration_is_active()

Changes in v2:

- Fixed conversion specifier on 32-bit platform

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


