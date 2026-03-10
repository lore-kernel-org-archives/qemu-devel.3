Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED27FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4O-0006pI-CN; Tue, 10 Mar 2026 01:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4F-0006oK-8f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4C-0006DF-B1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jw/xqGpA3MdoTlj6mC7Ayn3QBvHQjMDR+qlGLpqSpVk=;
 b=a12GLf1LBDaOw379wsTGAr8vGQLWkwmKS9F1P6HxYn8QmFLYe/m0TiPIk9MBRrM+0ncF6c
 vmmGYRyEPgYvWkjgOC5MTwtYPOsihvHRCLf2+AziikxVrpE8KDVJo63h/wXgl2E0uYfbLS
 I5eu3qo9ijO9+2yPlxdF+ko1vmeg1sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311--mVGZMvfM3yc_xfLQnqhRw-1; Tue,
 10 Mar 2026 01:55:35 -0400
X-MC-Unique: -mVGZMvfM3yc_xfLQnqhRw-1
X-Mimecast-MFC-AGG-ID: -mVGZMvfM3yc_xfLQnqhRw_1773122134
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A78C1800561; Tue, 10 Mar 2026 05:55:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7EB41956095; Tue, 10 Mar 2026 05:55:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/25] s390x & functional tests pull request for the softfreeze
Date: Tue, 10 Mar 2026 06:55:05 +0100
Message-ID: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:

  Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-10

for you to fetch changes up to f2bd9693f22b105182b0bacdba390a0e41b2cf82:

  pc-bios/s390-ccw.img: Update the s390 bios blog with the latest changes (2026-03-10 06:46:45 +0100)

----------------------------------------------------------------
- Improve the s390-ccw bios to be able to boot from virtio-blk-pci devices
- Rework migration functional test to avoid a problem in the ppc64 test
- Disable functional memlock test for asan builds
- Some other minor tests improvements

----------------------------------------------------------------
Fabiano Rosas (4):
      tests/functional/migration: Use socket_dir
      tests/functional/migration: Add migrate_vms
      tests/functional/migration: Use the migrate_vms helper
      tests/functional/ppc64/pseries: Remove custom migration routine

Jared Rossi (15):
      pc-bios/s390-ccw: Fix misattributed function prototypes
      pc-bios/s390-ccw: Remove redundant vring schid attribute
      pc-bios/s390-ccw: Always reset virtio device on failed boot attempt
      s390x: Remove duplicate definitions of IPL types
      pc-bios/s390-ccw: Store device type independent of sense data
      pc-bios/s390-ccw: Split virtio-ccw and generic virtio
      include/hw/s390x: Move CLP definitions for easier BIOS access
      pc-bios/s390-ccw: Introduce CLP Architecture
      s390x: Add definitions for PCI IPL type
      pc-bios/s390-ccw: Introduce PCI device
      pc-bios/s390-ccw: Introduce virtio-pci functions
      pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
      s390x: Build IPLB for virtio-pci devices
      hw: Add "loadparm" property to virtio block PCI devices booting on s390x
      tests/qtest: Add s390x PCI boot test to cdrom-test.c

Peter Maydell (1):
      tests/functional/x86_64: Disable memlock test for asan builds

Thomas Huth (5):
      tests/qemu-iotests: Mark 182 as Linux-only
      tests/functional: Don't try to run functional tests on Windows
      tests/functional/ppc/test_40: Fix the URL of the NetBSD-7.1.2-prep.iso asset
      pc-bios/s390-ccw: Fix compiler warning when compiling with DEBUG enabled
      pc-bios/s390-ccw.img: Update the s390 bios blog with the latest changes

 MAINTAINERS                               |   1 +
 hw/s390x/ipl.h                            |   8 +-
 include/hw/pci/pci.h                      |   1 +
 include/hw/pci/pci_device.h               |   3 +
 include/hw/s390x/ipl/qipl.h               |  20 ++
 include/hw/s390x/{ => ipl}/s390-pci-clp.h |   0
 include/hw/s390x/s390-pci-bus.h           |   4 +-
 pc-bios/s390-ccw/clp.h                    |  24 ++
 pc-bios/s390-ccw/iplb.h                   |   4 -
 pc-bios/s390-ccw/pci.h                    |  39 +++
 pc-bios/s390-ccw/s390-ccw.h               |   9 +-
 pc-bios/s390-ccw/virtio-ccw.h             |  24 ++
 pc-bios/s390-ccw/virtio-pci.h             |  82 ++++++
 pc-bios/s390-ccw/virtio-scsi.h            |   2 +-
 pc-bios/s390-ccw/virtio.h                 |  19 +-
 hw/pci/pci.c                              |  38 +++
 hw/s390x/ipl.c                            |  63 ++++-
 hw/s390x/s390-pci-bus.c                   |   3 +-
 hw/s390x/s390-pci-vfio.c                  |   2 +-
 hw/virtio/virtio-blk-pci.c                |   1 +
 pc-bios/s390-ccw/bootmap.c                |   2 +-
 pc-bios/s390-ccw/clp.c                    |  99 +++++++
 pc-bios/s390-ccw/main.c                   |  88 +++++-
 pc-bios/s390-ccw/netmain.c                |   2 +-
 pc-bios/s390-ccw/pci.c                    | 118 ++++++++
 pc-bios/s390-ccw/virtio-blkdev.c          |  76 ++++--
 pc-bios/s390-ccw/virtio-ccw.c             | 239 +++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c             |   5 +-
 pc-bios/s390-ccw/virtio-pci.c             | 433 ++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c            |   8 +-
 pc-bios/s390-ccw/virtio.c                 | 293 +++++++-------------
 tests/qtest/cdrom-test.c                  |   7 +
 pc-bios/s390-ccw.img                      | Bin 87824 -> 95992 bytes
 pc-bios/s390-ccw/Makefile                 |   3 +-
 tests/functional/meson.build              |   5 +-
 tests/functional/migration.py             |  46 ++--
 tests/functional/ppc/test_40p.py          |   2 +-
 tests/functional/ppc64/test_migration.py  |  11 -
 tests/functional/ppc64/test_pseries.py    |  10 +-
 tests/functional/x86_64/meson.build       |   9 +-
 tests/qemu-iotests/182                    |   1 +
 41 files changed, 1492 insertions(+), 312 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h
 create mode 100644 pc-bios/s390-ccw/clp.c
 create mode 100644 pc-bios/s390-ccw/pci.c
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c


