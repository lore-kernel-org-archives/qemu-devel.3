Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C588CF5386
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bF5-00066A-OC; Wed, 23 Oct 2024 09:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bEu-0005y4-T9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bEm-00028C-Ob
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmMf7TJrUm0jIG8CgPCjMXW/r/bLSOhnGM3UCaNH4Sc=;
 b=BD/r5ekR9hOjQYiq9/V1POAUIxzDXmPR8kTjzgTHo8BBA7A7TM/kiddV2usvSBuHugkLsA
 8vYix/Lt8fCcMl/Ecy8/125bgDPHcxUN+9M4CvScMm/lup5RBpN4TTYbSqJUK0kO9Vgp6X
 7M0W01XPkMWRacolvVV2pTIvhiP3+6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-AG5dCiAXOqC0pOvTZMlCkQ-1; Wed,
 23 Oct 2024 09:17:15 -0400
X-MC-Unique: AG5dCiAXOqC0pOvTZMlCkQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ACB019560BD; Wed, 23 Oct 2024 13:17:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB38E19560AE; Wed, 23 Oct 2024 13:17:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/23] s390-ccw bios update
Date: Wed, 23 Oct 2024 15:16:47 +0200
Message-ID: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-23

for you to fetch changes up to 239e351ec415ff3673d9da70d70ca3a5dd95a2f0:

  pc-bios/s390-ccw: Update s390-ccw.img with the full boot order support feature (2024-10-23 06:53:44 +0200)

----------------------------------------------------------------
* Allow multiple boot devices (via bootindex properties) on s390x
* Avoid TEXTREL relocations in the s390-ccw.img firmware

----------------------------------------------------------------
Jared Rossi (16):
      pc-bios/s390-ccw: Use the libc from SLOF and remove sclp prints
      pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img binary
      docs/system/s390x/bootdevices: Update the documentation about network booting
      pc-bios/s390-ccw: Remove panics from ISO IPL path
      pc-bios/s390-ccw: Remove panics from ECKD IPL path
      pc-bios/s390-ccw: Remove panics from SCSI IPL path
      pc-bios/s390-ccw: Remove panics from DASD IPL path
      pc-bios/s390-ccw: Remove panics from Netboot IPL path
      pc-bios/s390-ccw: Enable failed IPL to return after error
      include/hw/s390x: Add include files for common IPL structs
      s390x: Add individual loadparm assignment to CCW device
      hw/s390x: Build an IPLB for each boot device
      s390x: Rebuild IPLB for SCSI device directly from DIAG308
      pc-bios/s390x: Enable multi-device boot loop
      docs/system: Update documentation for s390x IPL
      tests/qtest: Add s390x boot order tests to cdrom-test.c

Jens Remus (2):
      pc-bios/s390-ccw: Clarify alignment is in bytes
      pc-bios/s390-ccw: Don't generate TEXTRELs

Marc Hartmayer (1):
      pc-bios/s390-ccw: Introduce `EXTRA_LDFLAGS`

Thomas Huth (4):
      hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
      hw/s390x: Remove the possibility to load the s390-netboot.img binary
      pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
      pc-bios/s390-ccw: Update s390-ccw.img with the full boot order support feature

 docs/system/bootindex.rst               |   7 +-
 docs/system/s390x/bootdevices.rst       |  29 +-
 pc-bios/s390-ccw/netboot.mak            |  62 -----
 hw/s390x/ccw-device.h                   |   2 +
 hw/s390x/ipl.h                          | 123 +--------
 include/hw/s390x/ipl/qipl.h             | 127 +++++++++
 pc-bios/s390-ccw/bootmap.h              |  20 +-
 pc-bios/s390-ccw/cio.h                  |   2 +
 pc-bios/s390-ccw/dasd-ipl.h             |   2 +-
 pc-bios/s390-ccw/iplb.h                 | 108 ++------
 pc-bios/s390-ccw/libc.h                 |  89 -------
 pc-bios/s390-ccw/s390-ccw.h             |  36 +--
 pc-bios/s390-ccw/virtio.h               |   3 +-
 hw/s390x/ccw-device.c                   |  46 ++++
 hw/s390x/ipl.c                          | 282 ++++++++++----------
 hw/s390x/s390-virtio-ccw.c              |  28 +-
 hw/s390x/sclp.c                         |   9 +-
 pc-bios/s390-ccw/bootmap.c              | 455 ++++++++++++++++++++++----------
 pc-bios/s390-ccw/cio.c                  |  81 +++---
 pc-bios/s390-ccw/dasd-ipl.c             |  71 ++---
 pc-bios/s390-ccw/jump2ipl.c             |  22 +-
 pc-bios/s390-ccw/libc.c                 |  88 ------
 pc-bios/s390-ccw/main.c                 |  97 ++++---
 pc-bios/s390-ccw/menu.c                 |  51 ++--
 pc-bios/s390-ccw/netmain.c              |  38 ++-
 pc-bios/s390-ccw/sclp.c                 |   7 +-
 pc-bios/s390-ccw/virtio-blkdev.c        |  12 +-
 pc-bios/s390-ccw/virtio-net.c           |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c          | 160 +++++++----
 pc-bios/s390-ccw/virtio.c               |  67 +++--
 target/s390x/diag.c                     |   9 +-
 tests/qtest/cdrom-test.c                |  24 ++
 tests/tcg/s390x/console.c               |   3 +
 pc-bios/meson.build                     |   1 -
 pc-bios/s390-ccw.img                    | Bin 42608 -> 79608 bytes
 pc-bios/s390-ccw/Makefile               |  72 ++++-
 pc-bios/s390-ccw/start.S                |  11 +-
 pc-bios/s390-netboot.img                | Bin 67232 -> 0 bytes
 tests/tcg/s390x/Makefile.softmmu-target |   2 +-
 39 files changed, 1171 insertions(+), 1082 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 include/hw/s390x/ipl/qipl.h
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c
 delete mode 100644 pc-bios/s390-netboot.img


