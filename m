Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0CAC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubivO-0001uX-1x; Tue, 15 Jul 2025 12:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubied-0006UE-FU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubiea-0003WS-K7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MNHDujN6GPawvgOzY5WFhiVR/voUhWvFgU893UH7/8s=;
 b=iaeyXr27+M2QmAg5k+IcApeWkGNJRH7FT0yAO2m7giAWfpRv3xYs8nlxBMz3miQe1Lh6z7
 uLBc9PXrhunFXcvhhLfcnLxDvXr09V0M8wrzZaxH7yCkHvrtGlNCis3dz1+c9cnbrMQVn8
 lKoFjfjHJ6lD9feWWOe4OtW4GdeSrJU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-NDvKxVayM127AGHX1Wc-TA-1; Tue,
 15 Jul 2025 12:37:13 -0400
X-MC-Unique: NDvKxVayM127AGHX1Wc-TA-1
X-Mimecast-MFC-AGG-ID: NDvKxVayM127AGHX1Wc-TA_1752597433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E260195608E
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 16:37:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90B473000198; Tue, 15 Jul 2025 16:37:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/7] vfio queue
Date: Tue, 15 Jul 2025 18:36:56 +0200
Message-ID: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250715

for you to fetch changes up to 300dcf58b72fa1635190b19f102231b0775e93cb:

  vfio/migration: Max in-flight VFIO device state buffers size limit (2025-07-15 17:11:12 +0200)

----------------------------------------------------------------
vfio queue:

* Fixed vfio-user issues reported by Coverity
* Tweaked VFIO migration with multifd to support aarch64
* Introduced a property to override a device PCI class code

----------------------------------------------------------------
John Levon (4):
      hw/vfio-user: add Cédric Le Goater as a maintainer
      hw/vfio: fix region fd initialization
      hw/vfio-user: wait for proxy close correctly
      hw/vfio-user: fix use of uninitialized variable

Maciej S. Szmigiero (2):
      vfio/migration: Add x-migration-load-config-after-iter VFIO property
      vfio/migration: Max in-flight VFIO device state buffers size limit

Tomita Moeko (1):
      vfio/pci: Introduce x-pci-class-code option

 MAINTAINERS                       |   1 +
 docs/devel/migration/vfio.rst     |  19 ++++++++
 hw/vfio/migration-multifd.h       |   3 ++
 hw/vfio/pci.h                     |   6 +--
 hw/vfio/vfio-helpers.h            |   2 +
 hw/vfio/vfio-migration-internal.h |   1 +
 include/hw/vfio/vfio-device.h     |   2 +
 hw/core/machine.c                 |   1 +
 hw/vfio-user/container.c          |   6 +--
 hw/vfio-user/proxy.c              |  10 ++--
 hw/vfio/device.c                  |   6 ++-
 hw/vfio/helpers.c                 |  17 +++++++
 hw/vfio/migration-multifd.c       | 100 +++++++++++++++++++++++++++++++++++++-
 hw/vfio/migration.c               |  10 +++-
 hw/vfio/pci.c                     |  48 ++++++++++++++++--
 hw/vfio/trace-events              |   1 +
 16 files changed, 212 insertions(+), 21 deletions(-)


