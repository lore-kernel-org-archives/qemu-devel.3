Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D411CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPonw-0006oX-Io; Wed, 20 May 2026 17:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPonu-0006lp-Sy
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPons-00043y-Av
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j+glvum1TZ16l0tfh3UpaAUk9C77I5QWXkcsSCmHhHg=;
 b=HbbW/LCp/B1oD8KA4zEMfi4b2GE9j8I2R/eTcL6gaUq2/kyTwoqdYo84yS434ahYKkcW7b
 jJBfBeeJzu3Y3QwU6kAC5GQKgY60okYzgIUMcWc70I1lO4ToDje6q3mRger/UT0dzbi101
 gyk8Rqi7Y/1y+J8dTM8bPMtuizE2Gvk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-EO9uODyEO92M2GMRnt1L9w-1; Wed,
 20 May 2026 17:50:07 -0400
X-MC-Unique: EO9uODyEO92M2GMRnt1L9w-1
X-Mimecast-MFC-AGG-ID: EO9uODyEO92M2GMRnt1L9w_1779313806
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A11E9195608A
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C8A518004A3; Wed, 20 May 2026 21:50:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/40] Make HMP optional (and later standalone)
Date: Thu, 21 May 2026 01:49:01 +0400
Message-Id: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE1SFYSriEXVlJEoWkQi7q5Yv
 sX/F3hyTB6q6AJHB3uebUASR6AHZXtC7oJBCpmLTCa40rSjnXGYFiTVpUa0pii1gFAsjgyf361
 ufvu9HUlv7wLu+wG0i7j5bwAAAA==
X-Change-ID: 20260521-qemu-no-hmp-ead3f0bf79c0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14463;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UTVQqQ6GWDf45iz59lQtjTQDSqom8J1vBiPQGaaHsIE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyC1BOLHbtp5ZS2T3kn4wFlsN5cWy8Qo5RIk
 HGu2nol1beJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5U/nEACIWKOGdgK5LZNc/UA1EAu81tXojNJuKcO3AtHFYvzQuaprjVxk8aTqxLtQptFR5OjDoqL
 EKfFjKAJ7a/8iMAGQLaytwAx5wS0+QiKJlCpiqyOM9Cz5Z8EWVeaCPPbyaqZvF0HRslXyy+7k1Q
 4l0MiMX1gABvcJUS/LKVhcK6k+utSLDILV6bT6/oANVGKLgtiZwW6Kp+VaeHgwT6NBmGz5pMILL
 kAMLMnZNmfsQIL/U4niFCJfb/kM1sYGVTuJp1nz2+U6OKPnK8kQLbbrY4kEIfVmJ3vt3WZ3tYuv
 IW4ojWeqvHUzx5+x4iYjHAl2ZUoUTLOZYo86vBDloUY+zA9Y9EmIdscQg+YpuIeRmKbhZDDxJwF
 f+1mDikFwFWCYVwYPGX0UarhVIMUdveOsShsnudFei5+zH5do1zhnU3Tlya6YG2pQBz2Rx2vToB
 L03BMGBcwm0NWRiNFLtYaWCqqa69lXZCbS8rXH9PwZh0iF+F19W+JODMSpUcay7sYXA83FZnTCL
 jdVGzxa93s42hhuzGTn2+mxDWay/HiDG01l3hO5BuLKf2thPoyf+6Zzs+7rmYv4fWJd/JoHe7pi
 m1jJT6wVm5WbcSNY+6coWkabvwcRm+1n7ibH1Ya2WNmNER60llltuVXSz/mrwZUgcLF4mEBBd54
 eXzqd7VJHAopS8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Marc-André Lureau (40):
      vl: fix -monitor none prefix matching
      hmp: remove 'vcpu' argument from trace-event help
      hmp: fix snapshot_blkdev argument type
      target/i386: decouple cpu_x86_inject_mce() from Monitor
      system: move gpa2hva() to system memory unit
      s390x: prevent crash if given invalid CPU#
      system: decouple qmp_inject_nmi() from Monitor
      hmp: correct the nmi documentation
      monitor: move HMP-only fields from Monitor to MonitorHMP
      tests/functional: use query-version QMP command instead of HMP
      net/qapi: add x-query-usernet
      tests: use x-query-usernet
      RFC: qtest: add -qtest-no-ts option
      qemu-io: propagate errors through Error API instead of printf
      block: add x-qemu-io QMP command
      tests/qemu-iotests/N: use x-qemu-io QMP command
      tests/qemu-iotests/181, 192, 249: convert to QMP
      tests/qemu-iotests/186: convert from HMP to QMP
      tests/qemu-iotests/copy-before-write: convert to QMP
      tests/qemu-iotests: skip some 172 & 267 that require HMP
      RFC: qtest: add qemu-io command to the qtest protocol
      RFC: qtest/ide-test: convert to use qtest qemu-io command
      tests/qtest/numa-test: replace HMP "info numa" with QMP query-cpus-fast
      tests/qtest/pnv: drop unnecessary -serial mon:stdio
      net: add x-query-network QMP command
      tests/qtest/netdev-socket: replace HMP with x-query-network QMP
      tests/qtest/cdrom-test: replace HMP "info block" with QMP query-block
      tests/qtest/qmp-test: don't depend on human-monitor-command
      build-sys: add 'hmp' option
      tests/qtest/device-introspect-test: fix test without HMP
      tests/qtest/drive_del-test: guard HMP-dependent tests with CONFIG_HMP
      qapi: make HMP-specific schema entries conditional on CONFIG_HMP
      monitor: guard HMP-specific code with CONFIG_HMP
      util: guard monitor_vprintf callers with CONFIG_HMP
      system: guard HMP initialization paths with CONFIG_HMP
      hw: guard BusClass::print_dev with CONFIG_HMP
      target: guard MonitorDef tables with CONFIG_HMP
      Guard HMP command implementations with CONFIG_HMP
      build-sys: make HMP source files conditional on have_hmp
      gitlab-ci: add --disable-hmp to build-without-defaults

 meson.build                                   |   6 +-
 qapi/block.json                               |  34 ++
 qapi/control.json                             |   4 +-
 qapi/machine.json                             |   5 +-
 qapi/misc.json                                |   3 +-
 qapi/net.json                                 | 166 ++++++++++
 qapi/qom.json                                 |   5 +-
 include/hw/core/qdev.h                        |   2 +
 include/hw/core/sysemu-cpu-ops.h              |   2 +
 include/monitor/hmp.h                         |   2 +
 include/monitor/monitor.h                     |  11 +-
 include/net/net.h                             |   3 +-
 include/qemu-io.h                             |   4 +-
 include/system/memory.h                       |   2 +
 include/system/qtest.h                        |   3 +-
 monitor/monitor-internal.h                    |   4 +-
 net/hub.h                                     |   4 +-
 target/i386/cpu.h                             |   4 +-
 tests/qtest/libqtest.h                        |  11 +
 accel/accel-system.c                          |   2 +
 accel/tcg/monitor.c                           |   2 +
 block/monitor/block-hmp-cmds.c                |  60 +---
 block/monitor/qmp-cmds.c                      |  79 +++++
 chardev/char.c                                |   7 +
 gdbstub/system.c                              |   8 +
 hw/char/virtio-serial-bus.c                   |   6 +
 hw/core/sysbus.c                              |   6 +
 hw/i386/kvm/xen-stubs.c                       |   2 +
 hw/i386/kvm/xen_evtchn.c                      |   3 +-
 hw/i386/sgx.c                                 |   2 +
 hw/misc/auxbus.c                              |  16 +-
 hw/misc/mos6522-stub.c                        |   2 +
 hw/misc/mos6522.c                             |   2 +
 hw/pci/pci-hmp-cmds.c                         |   2 +
 hw/pci/pci-stub.c                             |   2 +
 hw/pci/pci.c                                  |   2 +
 hw/s390x/s390-skeys.c                         |   2 +
 hw/s390x/s390-stattrib.c                      |   4 +
 hw/s390x/s390-virtio-ccw.c                    |   5 +
 hw/uefi/ovmf-log.c                            |   2 +
 hw/usb/bus.c                                  |   6 +
 hw/usb/host-libusb.c                          |   6 +
 hw/xen/xen-bus.c                              |   4 +
 migration/dirtyrate.c                         |   2 +
 monitor/hmp-cmds.c                            |  48 +--
 monitor/hmp.c                                 |   5 +-
 monitor/monitor.c                             |  47 ++-
 monitor/qmp-cmds.c                            |   2 +
 net/hub.c                                     |  29 +-
 net/net-hmp-cmds.c                            |  59 +++-
 net/net.c                                     |  70 +++-
 net/slirp.c                                   |  41 ++-
 qemu-io-cmds.c                                | 426 +++++++++++++------------
 qemu-io.c                                     |  17 +-
 replay/replay-debugging.c                     |   8 +
 replay/stubs-system.c                         |   6 +
 stubs/monitor-core.c                          |   2 +
 stubs/monitor-internal.c                      |   2 +
 system/cpus.c                                 |   7 +-
 system/dirtylimit.c                           |   6 +
 system/physmem.c                              |  31 ++
 system/qdev-monitor.c                         |   4 +
 system/qtest.c                                |  75 ++++-
 system/vl.c                                   |  13 +-
 target/i386/cpu-apic.c                        |   2 +
 target/i386/cpu.c                             |   4 +
 target/i386/helper.c                          |  49 +--
 target/i386/kvm/kvm.c                         |   4 +-
 target/i386/monitor.c                         |   9 +-
 target/i386/sev.c                             |   2 +
 target/m68k/cpu.c                             |   4 +
 target/m68k/monitor.c                         |   2 +
 target/ppc/monitor.c                          |   2 +
 target/riscv/monitor.c                        |   3 +
 target/sh4/monitor.c                          |   2 +
 target/sparc/cpu.c                            |   5 +-
 target/sparc/monitor.c                        |   2 +
 target/xtensa/monitor.c                       |   2 +
 tests/qtest/cdrom-test.c                      |  29 +-
 tests/qtest/device-introspect-test.c          | 111 +++++--
 tests/qtest/drive_del-test.c                  |  14 +
 tests/qtest/ide-test.c                        |   4 +-
 tests/qtest/libqtest.c                        |  14 +
 tests/qtest/netdev-socket.c                   | 143 +++++----
 tests/qtest/numa-test.c                       |  63 +++-
 tests/qtest/pnv-host-i2c-test.c               |   2 +-
 tests/qtest/pnv-xive2-test.c                  |   2 +-
 tests/qtest/qmp-test.c                        |   9 +-
 tests/unit/test-util-sockets.c                |   4 +-
 tools/qemu-vnc/stubs.c                        |   2 +
 util/error-report.c                           |   8 +-
 util/qemu-print.c                             |   6 +
 .gitlab-ci.d/buildtest.yml                    |   1 +
 audio/meson.build                             |   4 +-
 backends/meson.build                          |   5 +-
 block/monitor/meson.build                     |   5 +-
 chardev/meson.build                           |   5 +-
 disas/meson.build                             |   4 +-
 dump/meson.build                              |   5 +-
 hmp-commands-info.hx                          |   6 +-
 hmp-commands.hx                               |  14 +-
 hw/core/meson.build                           |   5 +-
 hw/i386/meson.build                           |   4 +-
 hw/net/meson.build                            |   4 +-
 hw/pci/meson.build                            |   4 +-
 hw/virtio/meson.build                         |   4 +-
 meson_options.txt                             |   2 +
 migration/meson.build                         |   4 +-
 monitor/meson.build                           |   9 +-
 net/meson.build                               |   4 +-
 python/qemu/utils/__init__.py                 |   5 +-
 qemu-options.hx                               |   7 +-
 qom/meson.build                               |   4 +-
 scripts/meson-buildoptions.sh                 |   3 +
 stats/meson.build                             |   5 +-
 stubs/meson.build                             |  12 +-
 system/meson.build                            |   9 +-
 tests/functional/generic/test_version.py      |  10 +-
 tests/functional/qemu_test/utils.py           |   8 +-
 tests/qemu-iotests/004.out                    |  20 +-
 tests/qemu-iotests/021.out                    |  60 ++--
 tests/qemu-iotests/060                        |   8 +-
 tests/qemu-iotests/060.out                    |  44 ++-
 tests/qemu-iotests/071                        |  30 +-
 tests/qemu-iotests/071.out                    |  14 +-
 tests/qemu-iotests/072.out                    |   2 +-
 tests/qemu-iotests/080.out                    |   4 +-
 tests/qemu-iotests/089.out                    |   4 +-
 tests/qemu-iotests/114.out                    |   2 +-
 tests/qemu-iotests/117                        |   5 +-
 tests/qemu-iotests/117.out                    |   7 +-
 tests/qemu-iotests/120                        |   4 +-
 tests/qemu-iotests/120.out                    |   2 +-
 tests/qemu-iotests/134.out                    |   2 +-
 tests/qemu-iotests/137.out                    |   2 +-
 tests/qemu-iotests/156                        |  36 +--
 tests/qemu-iotests/156.out                    |  48 +--
 tests/qemu-iotests/161                        |  18 +-
 tests/qemu-iotests/161.out                    |  24 +-
 tests/qemu-iotests/171                        |   2 +-
 tests/qemu-iotests/171.out                    |  68 ++--
 tests/qemu-iotests/172                        |   5 +
 tests/qemu-iotests/181                        |  99 ++++--
 tests/qemu-iotests/181.out                    |  36 ++-
 tests/qemu-iotests/186                        |  20 +-
 tests/qemu-iotests/186.out                    | 440 ++++++--------------------
 tests/qemu-iotests/192                        |  22 +-
 tests/qemu-iotests/192.out                    |  17 +-
 tests/qemu-iotests/214.out                    |   2 +-
 tests/qemu-iotests/220.out                    |   2 +-
 tests/qemu-iotests/244.out                    |  12 +-
 tests/qemu-iotests/249                        |  18 +-
 tests/qemu-iotests/249.out                    |  18 +-
 tests/qemu-iotests/267                        |   4 +
 tests/qemu-iotests/271.out                    |  14 +-
 tests/qemu-iotests/283                        |   4 +-
 tests/qemu-iotests/283.out                    |   4 +-
 tests/qemu-iotests/common.rc                  |   7 +
 tests/qemu-iotests/iotests.py                 |   4 +-
 tests/qemu-iotests/tests/copy-before-write    |  98 +++---
 tests/qemu-iotests/tests/image-fleecing       |   4 +-
 tests/qemu-iotests/tests/image-fleecing.out   |  52 +--
 tests/qemu-iotests/tests/migrate-bitmaps-test |   4 +-
 tests/qtest/meson.build                       |   8 +-
 tests/vm/basevm.py                            |  13 +-
 trace/meson.build                             |   5 +-
 ui/meson.build                                |   4 +-
 167 files changed, 2092 insertions(+), 1292 deletions(-)
---
base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
change-id: 20260521-qemu-no-hmp-ead3f0bf79c0

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


