Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D6C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhGY-0005hT-6j; Tue, 15 Jul 2025 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgoD-0000V3-J5; Tue, 15 Jul 2025 10:39:05 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgo8-0008Qw-8I; Tue, 15 Jul 2025 10:39:03 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgnr-00000000kFN-0Fol; Tue, 15 Jul 2025 16:38:43 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] VFIO multifd device state transfer patches for QEMU
 10.1
Date: Tue, 15 Jul 2025 16:37:35 +0200
Message-ID: <cover.1752589295.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is an updated v2 patch series of the v1 series located at [1] of the
leftover patches of VFIO multifd migration patch set that was merged in
QEMU 10.0.

Changes from v1:
* Drop the in-flight VFIO device state buffer *count* limit, leave
  the *size* limit only.

* Add a small target-dependent helper to hw/vfio/helpers.c to avoid doing
  strcmp(target_name(), "aarch64") in hw/vfio/migration-multifd.c.

* Mention that VFIO device config with ARM interlocking enabled is
  loaded as part of the non-iterables as suggested by Avihai.

* Collect Fabiano and Avihai Reviewed-by tags.

[1]: https://lore.kernel.org/qemu-devel/cover.1750787338.git.maciej.szmigiero@oracle.com/

Maciej S. Szmigiero (2):
  vfio/migration: Add x-migration-load-config-after-iter VFIO property
  vfio/migration: Max in-flight VFIO device state buffers size limit

 docs/devel/migration/vfio.rst     |  19 ++++++
 hw/core/machine.c                 |   1 +
 hw/vfio/helpers.c                 |  17 +++++
 hw/vfio/migration-multifd.c       | 100 +++++++++++++++++++++++++++++-
 hw/vfio/migration-multifd.h       |   3 +
 hw/vfio/migration.c               |  10 ++-
 hw/vfio/pci.c                     |  19 ++++++
 hw/vfio/vfio-helpers.h            |   2 +
 hw/vfio/vfio-migration-internal.h |   1 +
 include/hw/vfio/vfio-device.h     |   2 +
 10 files changed, 171 insertions(+), 3 deletions(-)


