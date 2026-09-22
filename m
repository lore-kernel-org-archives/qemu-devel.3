Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61837C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96xb-0003h0-8y; Tue, 22 Sep 2026 16:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xO-0003Su-Aw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xI-0007zq-GN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D4dm0oGHCwF1xjoyCqUXpAcFgTDnsXLRNPpj8OdikUw=;
 b=KgawJGSgNwcdhhY4Ql4O14ttaTw8nnCGVHSpt05cMcZ93GcdY7Ompie8ED5h7WLrytEEW2
 CkZJntluBF/3YG/2jihLCaoFS1HidjaHl3SB2/MlFdZLmPzAK04adVQyAaRGBNupriQoP4
 sjZMGtey10idcUhoqzYpNWmdUT9xhVo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-VQ6EPZAxN3yJf-ROHlWxWg-1; Tue,
 22 Sep 2026 16:19:05 -0400
X-MC-Unique: VQ6EPZAxN3yJf-ROHlWxWg-1
X-Mimecast-MFC-AGG-ID: VQ6EPZAxN3yJf-ROHlWxWg_1790108344
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618C91800596
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 20:19:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60C0D180056E; Tue, 22 Sep 2026 20:19:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/88] qemu-iotests: migrate away from HMP ("make HMP
 optional" follow-up)
Date: Wed, 23 Sep 2026 00:17:07 +0400
Message-Id: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyND3bz8jNwC3VSDlLQ0Q1MLI0sjSyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQCL7V19aQAAAA==
X-Change-ID: 20260921-nohmp-e0dff1582929
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=19397;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IQLnjW7C6rNxFSKxbq+5B9vAFoiDn51TTuiwxEpJMzE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKts+6FQrrakdEeM7NkAhXfrJvcjHPuNBL34
 +WvlDNoMemJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirQAKCRDa6OEJdZac
 5cxnEACtwIlmHPcdkZUnv2Kcdmx3Ga0+9ky8OO32Uo0gKxghgmzFkf6fELP34VssxlbrMkWHtPD
 zYkPzte9INiZSiuWVWXij+qI0Lxdo8XEwZoA4/oWjtkU3ri25+pfFYC8502uN8FDmJQ0nXUG04k
 HSljq3+C/GIMowJW+y1qLQCqfVF6AqdXFHlC9m3qmN01TL3R+zKbu4cnd9VY0YcqXu+1BHYsTIb
 qDGu5eV6jJn5xUAHNkfd9RnuijWTAMtiC1dE3KVOtO6VH0WQMTvMv6vloHV5iU8qTPXWsFf4d0y
 /SZlDoTK7dmz4UPDH5WSzcnUO0qnin33J/pk3RjAQqIyYfAmzHrLPkXWvZTseOUiY/74TPEVP8O
 Wgiutz9TaZsUb3TZvR4Cm8xkHMI/EWxL6lgWxHGD0D2vhlr8GBRZ42s4EMKf5a/gIUWQ2wZpXj9
 D7P9/+zDBPXc1kkdtJNgh0P8Pnr5BtKdqqJcWparbBsnbIi69Yrc4OnMhT9oQC5Z8+6aMURRFE2
 dSSD822Yp01JVlJWPTY/c97/dbqVcR3kfn0egl1II530tVPN9GqBqhPzCfIWb7/19zv9Rq8GD7Z
 /CghDIxN9eZeD3OQo99IQgjYHvd8ZWAJVX/IRhjOVoFYcGXYsIOvbrdt6FDv8n9/m+d88NgdIE9
 GyuzVeO7+L2W+lQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

This series migrates all qemu-iotests away from HMP, so that the test
framework no longer depends on it and can execute with --disable-hmp.
This can simplify the tests, as they don't need to check/grep on stdout,
HMP & QMP but can rely increasingly on QMP alone.

The series is organized as follows: preparatory patches, monitor
infrastructure, test infrastructure, test migrations, cleanup.

x-query-qtree (info qtree) is introduced to make test 172 migration
easier, but arguably, qom-list could be extended instead.

All migrated tests have been verified to pass.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (88):
      scripts/checkpatch: skip trailer checks inside patch diff
      build-sys: bump minimum glib version to v2.68
      docs/devel: minor fix in qom documentation
      qom: auto-terminate interfaces array in OBJECT_DEFINE_TYPE macros
      qemu-io: drop "qemu-io:" prefix in error-report
      monitor: allow a bare Monitor
      qemu-print: use monitor_puts() for any non-QMP monitor
      block/monitor: capture x-qemu-io output
      qemu-iotests/iotests: filter x-qemu-io messages
      tests/qemu-iotests: do no interpret backslash as escape
      tests/qemu-iotests: filter all generated node ids
      qemu-iotests/216: migrate away from HMP
      qemu-iotests/310: migrate away from HMP
      qemu-iotests/283: migrate away from HMP
      qemu-iotests/281: migrate away from HMP
      qemu-iotests/reopen-file: migrate away from HMP
      qemu-iotests/mirror-ready-cancel-error: migrate away from HMP
      qemu-iotests/copy-before-write: migrate away from HMP
      qemu-iotests/132: migrate away from HMP
      qemu-iotests/152: migrate away from HMP
      qemu-iotests/254: migrate away from HMP
      qemu-iotests/264: migrate away from HMP
      qemu-iotests/304: migrate away from HMP
      qemu-iotests/300: replace hmp_qemu_io with qmp
      qemu-iotests/298: migrate away from HMP
      qemu-iotests/056: migrate away from HMP
      qemu-iotests/093: migrate away from HMP
      qemu-iotests/124: migrate away from HMP
      qemu-iotests/136: migrate away from HMP
      qemu-iotests/148: migrate away from HMP
      qemu-iotests/151: migrate away from HMP
      qemu-iotests/236: migrate away from HMP
      qemu-iotests/245: migrate away from HMP
      qemu-iotests/255: migrate away from HMP
      qemu-iotests/257: migrate away from HMP
      qemu-iotests/260: migrate away from HMP
      qemu-iotests/280: migrate away from HMP
      qemu-iotests/backup-discard-source: migrate away from HMP
      qemu-iotests/qsd-migrate: migrate away from HMP
      qemu-iotests/mirror-change-copy-mode: migrate away from HMP
      qemu-iotests/migrate-bitmaps-test: migrate away from HMP
      qemu-iotests/image-fleecing: migrate away from HMP
      qemu-iotests/migrate-bitmaps-postcopy: migrate away from HMP
      qemu-iotests/165: migrate away from HMP
      qemu-iotests/iothreads-create: doesn't actually depend on HMP
      qemu-iotests/045: remove HMP monitor dependency
      qemu-iotests/common: add _run_qmp_job helper
      qemu-iotests/007: migrate away from HMP
      qemu-iotests/028: migrate away from HMP
      qemu-iotests/225: migrate away from HMP
      qemu-iotests/300: migrate away from HMP
      qemu-iotests/286: migrate away from HMP
      qemu-iotests/142: migrate away from HMP
      qemu-iotests/146: migrate away from HMP
      qemu-iotests/117: migrate away from HMP
      qemu-iotests/119: migrate away from HMP
      qemu-iotests/060: migrate away from HMP
      qemu-iotests/071: migrate away from HMP
      qemu-iotests/081: migrate away from HMP
      qemu-iotests/102: migrate away from HMP
      qemu-iotests/091: migrate away from HMP
      qemu-iotests/120: migrate away from HMP
      qemu-iotests/161: migrate away from HMP
      qemu-iotests/249: migrate away from HMP
      qemu-iotests/156: migrate away from HMP
      qemu-iotests/write-zeroes-unmap: migrate away from HMP
      qemu-iotests/luks-detached-header: migrate away from HMP
      qemu-iotests/qcow2-internal-snapshots: migrate away from HMP
      qemu-iotests/185: migrate away from HMP
      qemu-iotests/246: migrate away from HMP
      qemu-iotests/274: migrate away from HMP
      qemu-iotests/145: migrate away from HMP
      qemu-iotests/068: migrate away from HMP
      qemu-iotests/130: migrate away from HMP
      qemu-iotests/153: migrate away from HMP
      qemu-iotests/157: migrate away from HMP
      qemu-iotests/181: migrate away from HMP
      qemu-iotests/182: migrate away from HMP
      qemu-iotests/186: migrate away from HMP
      qemu-iotests/192: migrate away from HMP
      qemu-iotests/201: migrate away from HMP
      qemu-iotests/232: migrate away from HMP
      qemu-iotests/267: migrate away from HMP
      qemu-iotests/051: migrate away from HMP
      qdev: add x-query-qtree QMP command
      qemu-iotests/172: migrate away from HMP
      qemu-iotests: remove HMP framework support
      block/monitor: redirect HMP qemu-io to HMP stream

 accel/tcg/cputlb.c                                 |   4 +-
 backends/igvm-cfg.c                                |   3 +-
 block/monitor/block-hmp-cmds.c                     |  13 +-
 block/monitor/qmp-cmds.c                           |  49 +-
 contrib/plugins/lockstep.c                         |  25 -
 docs/devel/qom.rst                                 |   2 +-
 hw/9pfs/9p-synth.c                                 |   2 +-
 hw/9pfs/9p-util.h                                  |   2 +-
 hw/9pfs/9p.c                                       |   2 +-
 hw/acpi/core.c                                     |   2 +-
 hw/acpi/pci.c                                      |   6 +-
 hw/char/virtio-serial-bus.c                        |  23 +-
 hw/core/machine.c                                  |   2 +-
 hw/core/reset.c                                    |   4 +-
 hw/core/resetcontainer.c                           |   5 +-
 hw/core/sysbus.c                                   |  17 +-
 hw/hyperv/hv-balloon.c                             |   2 +-
 hw/i386/multiboot.c                                |   2 +-
 hw/misc/auxbus.c                                   |  22 +-
 hw/net/eepro100.c                                  |   2 +-
 hw/nvram/fw_cfg.c                                  |   8 +-
 hw/pci/pci-hmp-cmds.c                              |  38 --
 hw/pci/pci-internal.h                              |   2 +-
 hw/pci/pci.c                                       |  40 +-
 hw/ppc/pef.c                                       |   3 +-
 hw/scsi/mptsas.c                                   |   5 +-
 hw/usb/bus.c                                       |  23 +-
 hw/vfio/pci.c                                      |   2 +-
 hw/virtio/virtio-mem.c                             |   6 +-
 hw/xen/xen-bus.c                                   |  12 +-
 include/glib-compat.h                              |  41 +-
 include/hw/core/qdev.h                             |   4 +-
 include/monitor/monitor.h                          |   2 +
 include/qom/object.h                               |   6 +-
 linux-user/syscall.c                               |   2 +-
 linux-user/uaccess.c                               |   2 +-
 meson.build                                        |   2 +-
 monitor/hmp.c                                      |  12 +-
 monitor/monitor.c                                  |  28 +-
 monitor/qmp.c                                      |  12 +-
 net/colo.c                                         |   4 +-
 python/qemu/machine/machine.py                     |   7 -
 qapi/block.json                                    |   3 +
 qapi/qapi-clone-visitor.c                          |  16 +-
 qapi/qapi-visit-core.c                             |   6 +-
 qapi/qdev.json                                     |  31 ++
 qemu-io-cmds.c                                     |  74 +--
 qemu-io.c                                          |   4 +
 rust/bindings/hwcore-sys/lib.rs                    |   2 +-
 scripts/checkpatch.pl                              |   7 +-
 stubs/meson.build                                  |   1 +
 stubs/monitor-puts.c                               |   9 +
 system/memory.c                                    |   2 +-
 system/qdev-monitor.c                              |  42 +-
 system/qtest.c                                     |   4 +-
 system/ram-block-attributes.c                      |   3 +-
 system/vl.c                                        |   2 +-
 target/i386/kvm/tdx.c                              |   3 +-
 target/s390x/kvm/pv.c                              |   3 +-
 tests/qemu-iotests/004.out                         |  20 +-
 tests/qemu-iotests/007                             |  25 +-
 tests/qemu-iotests/021.out                         |  60 +--
 tests/qemu-iotests/026.out                         | 396 +++++++-------
 tests/qemu-iotests/026.out.nocache                 | 168 +++---
 tests/qemu-iotests/028                             |  27 +-
 tests/qemu-iotests/028.out                         |  17 +-
 tests/qemu-iotests/045                             |   6 +-
 tests/qemu-iotests/051                             |  75 ++-
 tests/qemu-iotests/051.out                         | 241 +++------
 tests/qemu-iotests/051.pc.out                      | 311 +++++------
 tests/qemu-iotests/056                             |  21 +-
 tests/qemu-iotests/059.out                         |   6 +-
 tests/qemu-iotests/060                             |   9 +-
 tests/qemu-iotests/060.out                         |  48 +-
 tests/qemu-iotests/061.out                         |   4 +-
 tests/qemu-iotests/068                             |  56 +-
 tests/qemu-iotests/068.out                         |  26 +-
 tests/qemu-iotests/069.out                         |   2 +-
 tests/qemu-iotests/070.out                         |   2 +-
 tests/qemu-iotests/071                             |  31 +-
 tests/qemu-iotests/071.out                         |  16 +-
 tests/qemu-iotests/072.out                         |   2 +-
 tests/qemu-iotests/075.out                         |  14 +-
 tests/qemu-iotests/076.out                         |   6 +-
 tests/qemu-iotests/078.out                         |  12 +-
 tests/qemu-iotests/080.out                         |  44 +-
 tests/qemu-iotests/081                             |  11 +-
 tests/qemu-iotests/081.out                         |  12 +-
 tests/qemu-iotests/083.out                         | 104 ++--
 tests/qemu-iotests/088.out                         |  12 +-
 tests/qemu-iotests/089.out                         |   4 +-
 tests/qemu-iotests/091                             |  45 +-
 tests/qemu-iotests/092.out                         |  24 +-
 tests/qemu-iotests/093                             |  15 +-
 tests/qemu-iotests/102                             |  21 +-
 tests/qemu-iotests/102.out                         |  12 +-
 tests/qemu-iotests/103.out                         |  14 +-
 tests/qemu-iotests/114.out                         |   4 +-
 tests/qemu-iotests/116.out                         |  14 +-
 tests/qemu-iotests/117                             |   5 +-
 tests/qemu-iotests/117.out                         |   8 +-
 tests/qemu-iotests/119                             |   5 +-
 tests/qemu-iotests/119.out                         |   4 +-
 tests/qemu-iotests/120                             |   5 +-
 tests/qemu-iotests/120.out                         |   4 +-
 tests/qemu-iotests/124                             |  33 +-
 tests/qemu-iotests/130                             |  53 +-
 tests/qemu-iotests/130.out                         |   8 +-
 tests/qemu-iotests/132                             |   5 +-
 tests/qemu-iotests/133.out                         |  30 +-
 tests/qemu-iotests/134.out                         |   2 +-
 tests/qemu-iotests/136                             |   7 +-
 tests/qemu-iotests/137.out                         |  30 +-
 tests/qemu-iotests/140.out                         |   2 +-
 tests/qemu-iotests/142                             | 233 ++++----
 tests/qemu-iotests/142.out                         |  30 +-
 tests/qemu-iotests/143.out                         |   4 +-
 tests/qemu-iotests/145                             |   8 +-
 tests/qemu-iotests/145.out                         |   6 +-
 tests/qemu-iotests/146                             |   5 -
 tests/qemu-iotests/148                             |  13 +-
 tests/qemu-iotests/151                             |  51 +-
 tests/qemu-iotests/152                             |   5 +-
 tests/qemu-iotests/153                             |  37 +-
 tests/qemu-iotests/153.out                         |  86 +--
 tests/qemu-iotests/156                             |  37 +-
 tests/qemu-iotests/156.out                         |  60 +--
 tests/qemu-iotests/157                             |  10 +-
 tests/qemu-iotests/157.out                         |  16 +-
 tests/qemu-iotests/161                             |  19 +-
 tests/qemu-iotests/161.out                         |  24 +-
 tests/qemu-iotests/165                             |  10 +-
 tests/qemu-iotests/171.out                         |  68 +--
 tests/qemu-iotests/172                             |  76 ++-
 tests/qemu-iotests/172.out                         | 305 +----------
 tests/qemu-iotests/181                             |  86 ++-
 tests/qemu-iotests/181.out                         |  36 +-
 tests/qemu-iotests/182                             |   5 +-
 tests/qemu-iotests/185                             |  15 +-
 tests/qemu-iotests/185.out                         |  10 +-
 tests/qemu-iotests/186                             |  12 +-
 tests/qemu-iotests/186.out                         | 590 +++++++++------------
 tests/qemu-iotests/187.out                         |   6 +-
 tests/qemu-iotests/188.out                         |   2 +-
 tests/qemu-iotests/192                             |  25 +-
 tests/qemu-iotests/192.out                         |  17 +-
 tests/qemu-iotests/197.out                         |   2 +-
 tests/qemu-iotests/201                             |  75 ++-
 tests/qemu-iotests/201.out                         |  10 +-
 tests/qemu-iotests/205                             |   4 +-
 tests/qemu-iotests/214.out                         |   2 +-
 tests/qemu-iotests/215.out                         |   2 +-
 tests/qemu-iotests/216                             |   6 +-
 tests/qemu-iotests/216.out                         |   3 +-
 tests/qemu-iotests/220.out                         |   2 +-
 tests/qemu-iotests/225                             |  28 +-
 tests/qemu-iotests/225.out                         |  25 +-
 tests/qemu-iotests/226.out                         |  16 +-
 tests/qemu-iotests/232                             |  32 +-
 tests/qemu-iotests/232.out                         | 216 ++++++--
 tests/qemu-iotests/236                             |   7 +-
 tests/qemu-iotests/236.out                         |   8 -
 tests/qemu-iotests/244.out                         |  22 +-
 tests/qemu-iotests/245                             |  28 +-
 tests/qemu-iotests/246                             |  11 +-
 tests/qemu-iotests/246.out                         |   8 +-
 tests/qemu-iotests/249                             |  19 +-
 tests/qemu-iotests/249.out                         |  18 +-
 tests/qemu-iotests/254                             |   4 +-
 tests/qemu-iotests/255                             |   7 +-
 tests/qemu-iotests/257                             |   7 +-
 tests/qemu-iotests/257.out                         | 315 -----------
 tests/qemu-iotests/260                             |   9 +-
 tests/qemu-iotests/264                             |   5 +-
 tests/qemu-iotests/267                             | 139 +++--
 tests/qemu-iotests/267.out                         | 447 ++++++++++++----
 tests/qemu-iotests/271.out                         |  14 +-
 tests/qemu-iotests/274                             |  14 +-
 tests/qemu-iotests/274.out                         |  26 -
 tests/qemu-iotests/280                             |   3 +-
 tests/qemu-iotests/280.out                         |   3 +-
 tests/qemu-iotests/281                             |  11 +-
 tests/qemu-iotests/283                             |   4 +-
 tests/qemu-iotests/283.out                         |   4 +-
 tests/qemu-iotests/286                             |  15 +-
 tests/qemu-iotests/286.out                         |   8 +-
 tests/qemu-iotests/289.out                         |   2 +-
 tests/qemu-iotests/293.out                         |  30 +-
 tests/qemu-iotests/294.out                         |   4 +-
 tests/qemu-iotests/298                             |   9 +-
 tests/qemu-iotests/300                             |  34 +-
 tests/qemu-iotests/304                             |   7 +-
 tests/qemu-iotests/305.out                         |   2 +-
 tests/qemu-iotests/307.out                         |   2 +-
 tests/qemu-iotests/310                             |   6 +-
 tests/qemu-iotests/310.out                         |   3 +-
 tests/qemu-iotests/common.filter                   |   9 +-
 tests/qemu-iotests/common.qemu                     |  58 +-
 tests/qemu-iotests/common.rc                       |   8 -
 tests/qemu-iotests/iotests.py                      |  40 +-
 tests/qemu-iotests/tests/backup-discard-source     |  15 +-
 tests/qemu-iotests/tests/copy-before-write         | 130 +++--
 tests/qemu-iotests/tests/file-io-error.out         |   2 +-
 tests/qemu-iotests/tests/image-fleecing            |   5 +-
 tests/qemu-iotests/tests/image-fleecing.out        |  32 +-
 tests/qemu-iotests/tests/inactive-node-nbd.out     |  10 +-
 tests/qemu-iotests/tests/iothreads-create          |   3 +-
 tests/qemu-iotests/tests/luks-detached-header      |  49 +-
 .../tests/migrate-bitmaps-postcopy-test            |   5 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test      |   7 +-
 tests/qemu-iotests/tests/mirror-change-copy-mode   |  15 +-
 tests/qemu-iotests/tests/mirror-ready-cancel-error |   7 +-
 tests/qemu-iotests/tests/nbd-reconnect-on-open.out |   4 +-
 tests/qemu-iotests/tests/parallels-bitmap.out      |   4 +-
 tests/qemu-iotests/tests/parallels-checks.out      |   4 +-
 tests/qemu-iotests/tests/qcow2-internal-snapshots  | 226 ++++++--
 .../tests/qcow2-internal-snapshots.out             | 175 +++---
 tests/qemu-iotests/tests/qsd-migrate               |  23 +-
 tests/qemu-iotests/tests/qsd-migrate.out           |  44 +-
 tests/qemu-iotests/tests/reopen-file               |  12 +-
 tests/qemu-iotests/tests/write-zeroes-unmap        |  42 +-
 tests/qemu-iotests/tests/write-zeroes-unmap.out    |  80 +--
 util/error-report.c                                |   2 +-
 util/qemu-print.c                                  |  16 +-
 224 files changed, 3658 insertions(+), 3754 deletions(-)
---
base-commit: 67166d97a3269285aa68c489f85c9ccdf78495e1
change-id: 20260921-nohmp-e0dff1582929

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


