Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBECDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrU8-00073j-KN; Thu, 25 Jun 2026 17:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrU6-00073I-Kd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrU4-0003DV-0T
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bp5uoppMTfGHCcC1OlvAY7raUR8Ckw9LJ94/Hk6YuRw=;
 b=DBAPxmT33CEUNb6BhEOh+U7wuaLq1RZ8iUz5TBsgNs8Nx8hdH7gCM62N67sQq37Sx8JG+D
 E+k5uQdT9mPdljhUgjuiAWCCvE1zgqHfujdsSprpyg6bPiPNCyNRaTrGMuraOqyYIYha46
 9xDYP1bYYnpDfFmr0PXF6Udu9M+RtoE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-PXaKI8nuMlG8lfsoy7TCvA-1; Thu,
 25 Jun 2026 17:19:36 -0400
X-MC-Unique: PXaKI8nuMlG8lfsoy7TCvA-1
X-Mimecast-MFC-AGG-ID: PXaKI8nuMlG8lfsoy7TCvA_1782422375
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4A7A18005B1; Thu, 25 Jun 2026 21:19:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE52D18005A5; Thu, 25 Jun 2026 21:19:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/39] Make HMP optional (and later standalone)
Date: Fri, 26 Jun 2026 01:19:01 +0400
Message-Id: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZhpBRVW3sOwgHZqawLFFoiG9
 O4Cbl2+5P33F4gcHEeosgUCzy46368gDxko2/QPRqdXBknyTIUU+OJuwt6j7QbkRp8MteZSKoJ
 1MQQ27r3X7vWP49Q+WY1bYjOsi6MPn/1uFpv3vzwLJNSCcnOlkkVe3AJr24xH5TuoU0pfZD3g+
 rkAAAA=
X-Change-ID: 20260521-qemu-no-hmp-ead3f0bf79c0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=19086;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M6d4zpHnz5w2GI5JSQKHqncN1uu92ZWB0U7NXKz5poQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtbvIg7Iiwe6clNJ9xLCuHx45/h14xe3AxDe
 XtKxBXF3h2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bWwAKCRDa6OEJdZac
 5WaZD/96c39TDR3ok82UdVvx+esNvTG0cbvgpGuJes+h9i/icmNcLYX0OIJWMb9sR9IOmXgFTq/
 YBVEg5iDhQQ37rk1usfSaaW9W4aQJ+5fwD58z1EV4QFxiid32soycLJNMycIR39ZIWj+dPx1gl2
 16ZhfCJGpOCu7heDALRcbzDm6IxfDE3MwCgJ20kICnhFOXQm3YPXlN6+obShK5oqucEzl2Rkmmy
 nzmi9YAsWbhzbsUlrtvf697tY89vlJgmApF03TnhkG7nQxre9wSVEGHlvvgcuNB/Pxut8Gh/Beh
 P7QigG6wHkVy5aL7KXIsb7vsLQoz6j8yfCf+hQe8rcPu8GsCHkUOArsZwg0DN4bmshn6Nr9y728
 Hj4ab8ZyMSAOOJylysbX/u+/N7qn0fwAK43eWBTQmTrLcmPH+IEqyGhxENZmWAmrSGi73iRDVw4
 Dn9g7px/yHnOT+ggcP1zXRmMzwvyBCQ96iMbs2L7wPb1vbuEl2Dg6Ysx5mb5UQBvkFOVHATbueN
 q5pL32GV2sR9TdKCCemNOrwO36v1Yo2DORO44NBdN1TO83g6utuAZslpF3jrQaDYvVEkyT1h6du
 h/cb7l98PF402wU9ZLwqvQDh+CkHYLd+tiYjGemlSvk9MFOR4GRec8rqbNWBqJiStrO60IQGn4/
 fko7yr6pcxU+1YA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series makes HMP compile-time optional via --disable-hmp. The
resulting binary speaks only QMP - reducing the attack surface, binary
size and enforcing a separation between machine-readable interface and
interactive debugging console.

QMP offers almost all the functionality HMP could provide, so a separate
standalone "HMP-like" console could be implemented on top of it. The
rough list of missing commands (+complexity estimation) after this
series:

Debugging / introspection:
- info registers (medium) - plus $reg expression handling
- x/xp read memory (medium)
- gpa2hpa/gpa2hva/gva2gpa address translation (medium)
- info lapic (high) - deep x86 APIC state, lots of registers
- info mem (high) - virtual memory mappings, different per arch
- info tlb (high) - virt-to-phys mappings, also per arch
- info mtree (high) - memory region tree, multiple view modes
- info skeys (medium) - s390x storage keys
- info cmma (medium) - s390x CMMA values
- info qdm (easy) - could probably be folded into QOM introspection
- info qtree (medium) - same, maybe QOM introspection is enough
- info snapshots (medium)
- info usbhost (medium)
- info via (medium) -- VIA south bridge state

Simple actions / settings:
- gdbserver (trivial)
- boot_set (easy)
- mce (easy) - x86 MCE injection
- sum (easy) - memory checksum
- sync-profile (easy) - enable/disable/reset
- info sync-profile (medium)
- one-insn-per-tb (easy) - could be a QOM property on the accelerator
- pcie_aer_inject_error (easy)
- migration_mode (medium?)
- i/o ioport read/write (easy)
- hostfwd-add/hostfwd-remove (medium) - slirp port forwarding
- log/logfile (medium)
- trace-file (medium)

Also, to let clients do disassembly on their side, it'd be useful to
have something like "query-disassemble-info" that gives the client what
architecture and endianness is used etc.

In the meantime, being able to build without HMP is valuable and helps
identifying the missing pieces. The series does so by steps:

- preparatory cleanups and bug fixes
- add commands without QMP equivalent and needed for tests
- convert most iotests and qtests from HMP to QMP
- guard HMP-only code paths
- make HMP source files conditional in the build system

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2:
- add "target/i386: return an error for invalid CPU in hmp_mce()",
  suggested by Philippe
- drop all the patches converting iotests to QMP - instead skip
  when HMP is disabled. The series was getting significantly bigger with
  those, we can address the remaining conversion later.
- clean up the series to be fully bisectable
- rebased, add r-b trailers
- Link to v1: https://lore.kernel.org/qemu-devel/20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com

To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

---
Marc-André Lureau (39):
      vl: fix -monitor none prefix matching
      hmp: remove 'vcpu' argument from trace-event help
      hmp: fix snapshot_blkdev argument type
      target/i386: decouple cpu_x86_inject_mce() from Monitor
      target/i386: return an error for invalid CPU in hmp_mce()
      system: move gpa2hva() to system memory unit
      s390x: prevent crash if given invalid CPU#
      system: decouple qmp_inject_nmi() from Monitor
      hmp: correct the nmi documentation
      monitor: move HMP-only fields from Monitor to MonitorHMP
      tests/functional: use query-version QMP command instead of HMP
      net/qapi: add x-query-usernet command
      python, tests: switch usernet queries from HMP to QMP
      tests/qtest/pnv: drop unnecessary -serial mon:stdio
      tests/qtest/qmp-test: don't depend on human-monitor-command
      tests/qtest/numa-test: replace HMP "info numa" with QMP query-cpus-fast
      tests/qtest/cdrom-test: replace HMP "info block" with QMP query-block
      tests/qtest/device-introspect-test: fix test without HMP
      tests/qemu-iotests/205: fix race in assertExportNotFound
      net: add x-query-network QMP command
      tests/qtest/netdev-socket: replace HMP with x-query-network QMP
      qemu-io: propagate errors through Error API instead of printf
      RFC: qtest: add qemu-io command to the qtest protocol
      RFC: qtest/ide-test: convert to use qtest qemu-io command
      block: add x-qemu-io QMP command
      tests/qemu-iotests: add qmp_qemu_io()
      tests/qemu-iotests: convert pause/resume_drive() to QMP
      build-sys: add 'hmp' option
      monitor: reject readline monitor when HMP is disabled
      tests: skip HMP-dependent tests when HMP is disabled
      util: guard monitor_vprintf callers with CONFIG_HMP
      qapi: make HMP-specific schema entries conditional on CONFIG_HMP
      system: guard HMP initialization paths with CONFIG_HMP
      Guard HMP command implementations with CONFIG_HMP
      target: guard MonitorDef tables with CONFIG_HMP
      hw: guard BusClass::print_dev with CONFIG_HMP
      build-sys: make HMP source files conditional on have_hmp
      monitor: guard HMP internal helpers with CONFIG_HMP
      monitor: guard HMP monitor API with CONFIG_HMP

 meson.build                                        |   6 +-
 qapi/block.json                                    |  34 ++
 qapi/control.json                                  |   4 +-
 qapi/machine.json                                  |   5 +-
 qapi/misc.json                                     |   3 +-
 qapi/net.json                                      | 166 +++++++++
 include/hw/core/qdev.h                             |   2 +
 include/hw/core/sysemu-cpu-ops.h                   |   2 +
 include/monitor/monitor.h                          |  11 +-
 include/net/net.h                                  |   3 +-
 include/qemu-io.h                                  |   4 +-
 include/system/memory.h                            |   2 +
 monitor/monitor-internal.h                         |   4 +-
 net/hub.h                                          |   4 +-
 target/i386/cpu.h                                  |   4 +-
 tests/qtest/libqtest.h                             |  11 +
 accel/accel-system.c                               |   2 +
 accel/tcg/monitor.c                                |   2 +
 block/monitor/block-hmp-cmds.c                     |  60 +--
 block/monitor/qmp-cmds.c                           |  79 ++++
 chardev/char.c                                     |   7 +
 gdbstub/system.c                                   |   8 +
 hw/char/virtio-serial-bus.c                        |   6 +
 hw/core/sysbus.c                                   |   6 +
 hw/i386/kvm/xen-stubs.c                            |   2 +
 hw/i386/kvm/xen_evtchn.c                           |   3 +-
 hw/i386/sgx.c                                      |   2 +
 hw/misc/auxbus.c                                   |  16 +-
 hw/misc/mos6522-stub.c                             |   2 +
 hw/misc/mos6522.c                                  |   2 +
 hw/pci/pci-stub.c                                  |   2 +
 hw/pci/pci.c                                       |   2 +
 hw/s390x/s390-skeys.c                              |   2 +
 hw/s390x/s390-stattrib.c                           |   4 +
 hw/s390x/s390-virtio-ccw.c                         |   5 +
 hw/uefi/ovmf-log.c                                 |   2 +
 hw/usb/bus.c                                       |   6 +
 hw/usb/host-libusb.c                               |   6 +
 hw/xen/xen-bus.c                                   |   4 +
 migration/dirtyrate.c                              |   2 +
 monitor/hmp-cmds.c                                 |  53 +--
 monitor/hmp.c                                      |   7 +-
 monitor/monitor.c                                  |  47 ++-
 monitor/qmp-cmds.c                                 |   2 +
 net/hub.c                                          |  29 +-
 net/net-hmp-cmds.c                                 |  59 ++-
 net/net.c                                          |  70 +++-
 net/slirp.c                                        |  41 +-
 qemu-io-cmds.c                                     | 414 +++++++++++----------
 qemu-io.c                                          |  17 +-
 replay/replay-debugging.c                          |   8 +
 replay/stubs-system.c                              |   6 +
 stubs/monitor-core.c                               |   2 +
 stubs/monitor-internal.c                           |   2 +
 system/cpus.c                                      |   7 +-
 system/dirtylimit.c                                |   6 +
 system/physmem.c                                   |  31 ++
 system/qdev-monitor.c                              |   4 +
 system/qtest.c                                     |  14 +
 system/vl.c                                        |   6 +-
 target/i386/cpu-apic.c                             |   2 +
 target/i386/cpu.c                                  |   4 +
 target/i386/helper.c                               |  49 +--
 target/i386/kvm/kvm.c                              |   4 +-
 target/i386/monitor.c                              |  13 +-
 target/i386/sev.c                                  |   2 +
 target/m68k/cpu.c                                  |   4 +
 target/m68k/monitor.c                              |   2 +
 target/ppc/monitor.c                               |   2 +
 target/riscv/monitor.c                             |   3 +
 target/sh4/monitor.c                               |   2 +
 target/sparc/cpu.c                                 |   5 +-
 target/sparc/monitor.c                             |   2 +
 target/xtensa/monitor.c                            |   2 +
 tests/qtest/cdrom-test.c                           |  29 +-
 tests/qtest/device-introspect-test.c               | 111 ++++--
 tests/qtest/drive_del-test.c                       |  25 ++
 tests/qtest/ide-test.c                             |   4 +-
 tests/qtest/libqtest.c                             |  14 +
 tests/qtest/netdev-socket.c                        | 143 ++++---
 tests/qtest/numa-test.c                            |  63 +++-
 tests/qtest/pnv-host-i2c-test.c                    |   2 +-
 tests/qtest/pnv-xive2-test.c                       |   2 +-
 tests/qtest/qmp-test.c                             |   9 +-
 tests/unit/test-util-sockets.c                     |   4 +-
 tools/qemu-vnc/stubs.c                             |   2 +
 util/error-report.c                                |   8 +-
 util/qemu-print.c                                  |   6 +
 audio/meson.build                                  |   4 +-
 backends/meson.build                               |   5 +-
 block/monitor/meson.build                          |   5 +-
 chardev/meson.build                                |   5 +-
 disas/meson.build                                  |   4 +-
 dump/meson.build                                   |   5 +-
 hmp-commands-info.hx                               |   6 +-
 hmp-commands.hx                                    |  14 +-
 hw/core/meson.build                                |   5 +-
 hw/i386/meson.build                                |   4 +-
 hw/net/meson.build                                 |   4 +-
 hw/pci/meson.build                                 |   4 +-
 hw/virtio/meson.build                              |   4 +-
 meson_options.txt                                  |   2 +
 migration/meson.build                              |   4 +-
 monitor/meson.build                                |   9 +-
 net/meson.build                                    |   4 +-
 python/qemu/utils/__init__.py                      |   5 +-
 qemu-options.hx                                    |   6 +-
 qom/meson.build                                    |   4 +-
 scripts/meson-buildoptions.sh                      |   3 +
 stats/meson.build                                  |   5 +-
 stubs/meson.build                                  |  12 +-
 system/meson.build                                 |   9 +-
 tests/functional/generic/test_version.py           |  10 +-
 tests/functional/qemu_test/utils.py                |   8 +-
 tests/qemu-iotests/004.out                         |  20 +-
 tests/qemu-iotests/021.out                         |  60 +--
 tests/qemu-iotests/026.out                         | 228 ++++++------
 tests/qemu-iotests/028                             |   1 +
 tests/qemu-iotests/045                             |   3 +-
 tests/qemu-iotests/051                             |   1 +
 tests/qemu-iotests/056                             |   3 +-
 tests/qemu-iotests/060                             |   1 +
 tests/qemu-iotests/060.out                         |  44 ++-
 tests/qemu-iotests/068                             |   1 +
 tests/qemu-iotests/071                             |   1 +
 tests/qemu-iotests/071.out                         |  10 +-
 tests/qemu-iotests/072.out                         |   2 +-
 tests/qemu-iotests/080.out                         |   4 +-
 tests/qemu-iotests/081                             |   1 +
 tests/qemu-iotests/081.out                         |   2 +-
 tests/qemu-iotests/083.out                         |  36 +-
 tests/qemu-iotests/089.out                         |   4 +-
 tests/qemu-iotests/091                             |   1 +
 tests/qemu-iotests/093                             |   3 +-
 tests/qemu-iotests/102                             |   1 +
 tests/qemu-iotests/114.out                         |   2 +-
 tests/qemu-iotests/117                             |   1 +
 tests/qemu-iotests/119                             |   1 +
 tests/qemu-iotests/120                             |   1 +
 tests/qemu-iotests/124                             |   3 +-
 tests/qemu-iotests/130                             |   1 +
 tests/qemu-iotests/132                             |   3 +-
 tests/qemu-iotests/134.out                         |   2 +-
 tests/qemu-iotests/136                             |   3 +-
 tests/qemu-iotests/137.out                         |   2 +-
 tests/qemu-iotests/142                             |   1 +
 tests/qemu-iotests/145                             |   1 +
 tests/qemu-iotests/146                             |   1 +
 tests/qemu-iotests/148                             |   3 +-
 tests/qemu-iotests/151                             |   3 +-
 tests/qemu-iotests/152                             |   3 +-
 tests/qemu-iotests/153                             |   1 +
 tests/qemu-iotests/153.out                         |  12 +-
 tests/qemu-iotests/156                             |   1 +
 tests/qemu-iotests/157                             |   1 +
 tests/qemu-iotests/161                             |   1 +
 tests/qemu-iotests/165                             |   3 +-
 tests/qemu-iotests/171                             |   2 +-
 tests/qemu-iotests/171.out                         |  68 ++--
 tests/qemu-iotests/172                             |   1 +
 tests/qemu-iotests/181                             |   1 +
 tests/qemu-iotests/185                             |   1 +
 tests/qemu-iotests/186                             |   1 +
 tests/qemu-iotests/192                             |   1 +
 tests/qemu-iotests/201                             |   1 +
 tests/qemu-iotests/205                             |   6 +-
 tests/qemu-iotests/214.out                         |   2 +-
 tests/qemu-iotests/216                             |   3 +-
 tests/qemu-iotests/220.out                         |   2 +-
 tests/qemu-iotests/225                             |   1 +
 tests/qemu-iotests/225.out                         |   4 +-
 tests/qemu-iotests/232                             |   1 +
 tests/qemu-iotests/236                             |   3 +-
 tests/qemu-iotests/244.out                         |  12 +-
 tests/qemu-iotests/245                             |   3 +-
 tests/qemu-iotests/246                             |   3 +-
 tests/qemu-iotests/249                             |   1 +
 tests/qemu-iotests/249.out                         |   6 +-
 tests/qemu-iotests/254                             |   3 +-
 tests/qemu-iotests/255                             |   3 +-
 tests/qemu-iotests/257                             |   3 +-
 tests/qemu-iotests/260                             |   3 +-
 tests/qemu-iotests/264                             |   3 +-
 tests/qemu-iotests/267                             |   1 +
 tests/qemu-iotests/271.out                         |  14 +-
 tests/qemu-iotests/274                             |   3 +-
 tests/qemu-iotests/280                             |   1 +
 tests/qemu-iotests/281                             |   3 +-
 tests/qemu-iotests/283                             |   1 +
 tests/qemu-iotests/286                             |   1 +
 tests/qemu-iotests/289.out                         |   2 +-
 tests/qemu-iotests/298                             |   3 +-
 tests/qemu-iotests/300                             |   3 +-
 tests/qemu-iotests/304                             |   3 +-
 tests/qemu-iotests/305.out                         |   2 +-
 tests/qemu-iotests/307.out                         |   2 +-
 tests/qemu-iotests/310                             |   3 +-
 tests/qemu-iotests/common.rc                       |   8 +
 tests/qemu-iotests/iotests.py                      |  32 +-
 tests/qemu-iotests/tests/backup-discard-source     |   7 +-
 tests/qemu-iotests/tests/copy-before-write         |  69 ++--
 tests/qemu-iotests/tests/file-io-error.out         |   2 +-
 tests/qemu-iotests/tests/image-fleecing            |   3 +-
 tests/qemu-iotests/tests/image-fleecing.out        |  12 +-
 tests/qemu-iotests/tests/inactive-node-nbd.out     |   8 +-
 tests/qemu-iotests/tests/iothreads-create          |   3 +-
 tests/qemu-iotests/tests/luks-detached-header      |   3 +-
 .../tests/migrate-bitmaps-postcopy-test            |   3 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test      |   3 +-
 tests/qemu-iotests/tests/mirror-change-copy-mode   |   3 +-
 tests/qemu-iotests/tests/mirror-ready-cancel-error |   3 +-
 tests/qemu-iotests/tests/qcow2-internal-snapshots  |   1 +
 tests/qemu-iotests/tests/qsd-migrate               |   3 +-
 tests/qemu-iotests/tests/reopen-file               |   3 +-
 tests/qemu-iotests/tests/write-zeroes-unmap        |   1 +
 tests/qtest/meson.build                            |   8 +-
 tests/vm/basevm.py                                 |  13 +-
 trace/meson.build                                  |   5 +-
 ui/meson.build                                     |   4 +-
 219 files changed, 1917 insertions(+), 927 deletions(-)
---
base-commit: 1b4d5bb3e233c9fc84663be28635d122c9a2b81e
change-id: 20260521-qemu-no-hmp-ead3f0bf79c0

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


