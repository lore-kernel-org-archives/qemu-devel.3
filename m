Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F572C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvK4-0005MT-HF; Fri, 28 Aug 2026 08:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvJz-0005Lg-TH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvJw-0001ew-5z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ucS2QBmZcST6faPS/JFZFfGA/IwvZdQ7OI7S+emcI1Q=;
 b=FSiw71JlkoF75wlYHu9B7/gdy/rwnWdA1gzMATtlRua3zOV+2MoUAQJZVO67D8fSpeFKZd
 kSE6V9xtN6Ip7ZkR2stiJwtHBVSojvXmVbDOWfrLuYavOMQLLOp6FLsCka4vEjagLNE6hz
 YR4Lxa5Iw+HiG08WyaTh+TrCb9ZVL+I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-qBL3EPSGPKOj3VpzFG10Fw-1; Fri,
 28 Aug 2026 08:04:26 -0400
X-MC-Unique: qBL3EPSGPKOj3VpzFG10Fw-1
X-Mimecast-MFC-AGG-ID: qBL3EPSGPKOj3VpzFG10Fw_1787918665
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED27B180256E; Fri, 28 Aug 2026 12:04:24 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3687195604A; Fri, 28 Aug 2026 12:04:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v5 00/50] Make HMP optional (and later standalone)
Date: Fri, 28 Aug 2026 16:03:57 +0400
Message-Id: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Nyw6CMBAF0F8hXVvT1/Bw5X8YF6VMpSY8bJFoD
 P9u0YUiLm/mnjsPEtA7DGSXPIjH0QXXtTHAJiGm1u0JqatiJoKJlIHg9ILNlbYdrZueoq6kZaX
 NCsNIFL1H626vtcPxncO1PKMZ5om5UbswdP7+ejfyufd/eeSU0YozZXNWIFew91jVetiariHz9
 Cg+OBXpEouIc20lLw0ok/IVlh+c8x8sI0aQ1kiIHNgKqy8sYIlVxNrGA2RG2BIXeJqmJ8gL/xh
 wAQAA
X-Change-ID: 20260521-qemu-no-hmp-ead3f0bf79c0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, "Denis V. Lunev" <den@openvz.org>, 
 "Jason J. Herne" <jjherne@linux.ibm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=23790;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hqtaVKJO3Ev6d0Z+adLpH26klLBn1W1ulVYyXfFnPOc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk3WoVqgFMk1uzkTGIz5Lu8DhA6EFKWDTkTT
 O7RSPjiiI+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5NwAKCRDa6OEJdZac
 5cIOD/9ZslVFU9UNdEexQ3eu1BdAO2NKa94BfLn5FVj9GO4VFiYdcsADIbzWG45qIzMm0DvBr7A
 Jt2zUerV+25yK/4Vxo74eqZXlgGarBydHBLbHTHT9WEeonamIta45RVzsmkAKnTp4ZuGAmvsKJK
 lK+S8nCfIx4iV2NM8jWHQuUdv6cnNSoepRKabNy6xZNzOHrSfM7AWabkUI0CSxoM3iIDO+Z6pGw
 k8DIV4clnYWDLLNf6fjp9viKCsRn/VAVJdn7SFKpJialnqZz1ksZS6MX6SB/WADaxq1wEQqgSa9
 ptbre88vb3cmCmtPUzqN/HHCmJbrLHXrKQcvr0ZRfCMyM3V3Zt1g8X6cbBYd2opQN4sNTp9PGhK
 nGNfTZJ9dP62Bqy8/ryQHaYyzHPeLGcGQYjsuPM+ZRdAqn8tRin97w1bR9QMTDFsCe+5AQAwtxM
 +Sm5n1z5/P1oGLUhisAUmR8K5ba3otrji27W761vbl3QPqfjsZ8TJBuujC/2AVsPFfMEB21MSHB
 a9OebB3y0m6WDeSsVE/5MtQ3JbQ2KAucA+8NtJ2IuaFClHyWAbv7UlJSZlcpkWaz0ZHtcNNrkTL
 v66o/g1NuFKR2CdLOq/fcNCXq3EFkkyDZKGwhxeAFvTUI0Hpm1r2Ze6WHGRWr/hXn6qH/LITVOI
 GxAAdJ/2VpvlYzA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Changes in v5:
- renamed local variable hmp_mon -> hmp in patch for consistency
- renamed error_vprintf_mon/error_printf_mon -> error_vprintf_hmp/error_printf_hmp
- simplified default_monitor init with IS_ENABLED(CONFIG_HMP)
- added early NULL return in qemu_vprintf/qemu_vfprintf
- reworked !opts->has_mode path to use explicit error_setg() when HMP is disabled
- split device-introspect-test patch
- rebased, collected tags, all reviewed, ready-to-merge
- Link to v4: https://lore.kernel.org/qemu-devel/20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com

Changes in v4:
- patches missing review: 1, 16, 18, 19, 22, 33, 34, 36, 42, 45, 49
- reordering, introduce CONFIG_HMP early, better bisectability
- dropped "qemu-print: swith to monitor_cur_hmp()" instead "document
  HMP/QMP behaviour" patch
- fixed "error-report: switch to use monitor_cur_hmp()" to avoid calling
  monitor_cur() multiple times
- dropped "system: decouple qmp_inject_nmi()", now useless
- rebased, minor fixups, collect tags
- I didn't split "monitor: tighten monitor_printf*()", as suggested by
  David, since it's mostly mechanical changes. Let me know if necessary.
- Link to v3: https://lore.kernel.org/qemu-devel/20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com

Changes in v3:
- adapted to QOM refactoring of the Monitor subsystem, use type-system
  enforced MonitorHMP
- adjusted hmp_snapshot_blkdev() code for non-optional filename
- dropped patch 39/40 "monitor: guard HMP internal helpers with CONFIG_HMP"
- guard new tests for HMP dependency
- rebase, minor fixups
- Link to v2: https://lore.kernel.org/qemu-devel/20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com

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
Cc: dave@treblig.org
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

---
Marc-André Lureau (50):
      build-sys: introduce CONFIG_HMP
      vl: fix -monitor none prefix matching
      hmp: remove 'vcpu' argument from trace-event help
      hmp: fix snapshot_blkdev argument type
      target/i386: decouple cpu_x86_inject_mce() from Monitor
      target/i386: return an error for invalid CPU in hmp_mce()
      system: move gpa2hva() to system memory unit
      monitor: move HMP-only fields from Monitor to MonitorHMP
      tests/functional: use query-version QMP command instead of HMP
      net/qapi: add x-query-usernet command
      python, tests: switch usernet queries from HMP to QMP
      tests/qtest/pnv: drop unnecessary -serial mon:stdio
      tests/qtest/qmp-test: don't depend on human-monitor-command
      tests/qtest/numa-test: replace HMP "info numa" with QMP query-cpus-fast
      tests/qtest/cdrom-test: replace HMP "info block" with QMP query-block
      tests/qtest/device-introspect-test: replace 'info qom-tree'
      tests/qtest/device-introspect-test: restrict test when !CONFIG_HMP
      tests/qemu-iotests/205: fix race in assertExportNotFound
      net: add x-query-network QMP command
      tests/qtest/netdev-socket: replace HMP with x-query-network QMP
      qemu-io: propagate errors through Error API instead of printf
      block: add x-qemu-io QMP command
      qtest: add qemu-io command to the qtest protocol
      qtest/ide-test: convert to use qtest qemu-io command
      tests/qemu-iotests: add qmp_qemu_io()
      tests/qemu-iotests: convert pause/resume_drive() to QMP
      monitor: reject readline monitor when HMP is disabled
      system: guard HMP initialization paths with CONFIG_HMP
      tests: skip HMP-dependent tests when HMP is disabled
      monitor: isolate HMP declarations in hmp.h
      monitor: change HMPCommand cmd to take MonitorHMP
      monitor: make hmp_handle_error() take MonitorHMP
      monitor: add monitor_cur_hmp() helper
      qemu-print: document HMP/QMP behaviour better
      error-report: switch to use monitor_cur_hmp()
      monitor: tighten monitor_set_cpu()/get_cpu()
      monitor: tighten monitor_printf*()
      hexagon: make dump_mmu() take MonitorHMP
      qdev-monitor: make print_dev() callback take MonitorHMP
      qapi: make HMP-specific schema entries conditional on CONFIG_HMP
      Guard HMP command implementations with CONFIG_HMP
      target: guard MonitorDef tables with CONFIG_HMP
      hw: guard BusClass::print_dev with CONFIG_HMP
      hexagon: condition HMP-specific code
      build-sys: make HMP source files conditional on have_hmp
      stubs: split monitor-core stubs into separate compilation units
      monitor: move monitor_hmp_print*() functions to hmp.c
      monitor: move HMP-specific to monitor-hmp-internal.h
      build-sys: add 'hmp' option
      gitlab: --disable-hmp in build-without-defaults

 .gitlab-ci.d/buildtest.yml                         |   1 +
 accel/accel-system.c                               |   3 +
 accel/tcg/monitor.c                                |   3 +
 audio/audio-hmp-cmds.c                             |  10 +-
 audio/meson.build                                  |   4 +-
 backends/cryptodev-hmp-cmds.c                      |  10 +-
 backends/meson.build                               |   5 +-
 block/monitor/block-hmp-cmds.c                     | 341 +++++++----------
 block/monitor/meson.build                          |   5 +-
 block/monitor/qmp-cmds.c                           |  79 ++++
 chardev/char-hmp-cmds.c                            |  36 +-
 chardev/char.c                                     |  11 +-
 chardev/meson.build                                |   5 +-
 disas/disas-mon.c                                  |  11 +-
 disas/meson.build                                  |   4 +-
 docs/devel/style.rst                               |   2 +-
 docs/devel/writing-monitor-commands.rst            |   8 +-
 dump/dump-hmp-cmds.c                               |  12 +-
 dump/meson.build                                   |   5 +-
 gdbstub/system.c                                   |  10 +-
 hmp-commands-info.hx                               |   6 +-
 hmp-commands.hx                                    |   9 +-
 hw/char/virtio-serial-bus.c                        |  21 +-
 hw/core/machine-hmp-cmds.c                         | 263 +++++++------
 hw/core/meson.build                                |   5 +-
 hw/core/sysbus.c                                   |  15 +-
 hw/hexagon/hexagon_tlb.c                           |  87 ++---
 hw/i386/kvm/xen-stubs.c                            |  10 +-
 hw/i386/kvm/xen_evtchn.c                           |  28 +-
 hw/i386/meson.build                                |   4 +-
 hw/i386/sgx-hmp-stub.c                             |   4 +-
 hw/i386/sgx.c                                      |  32 +-
 hw/misc/auxbus.c                                   |  29 +-
 hw/misc/mos6522-stub.c                             |   6 +-
 hw/misc/mos6522.c                                  |   7 +-
 hw/net/meson.build                                 |   4 +-
 hw/net/rocker/rocker-hmp-cmds.c                    | 158 ++++----
 hw/pci/meson.build                                 |   4 +-
 hw/pci/pci-hmp-cmds.c                              | 121 +++---
 hw/pci/pci-internal.h                              |   2 +-
 hw/pci/pci-stub.c                                  |   8 +-
 hw/pci/pci.c                                       |   2 +
 hw/s390x/s390-skeys.c                              |  14 +-
 hw/s390x/s390-stattrib.c                           |  26 +-
 hw/uefi/ovmf-log.c                                 |  10 +-
 hw/usb/bus.c                                       |  21 +-
 hw/usb/host-libusb.c                               |  29 +-
 hw/virtio/meson.build                              |   4 +-
 hw/virtio/virtio-hmp-cmds.c                        | 312 ++++++++--------
 hw/xen/xen-bus.c                                   |  11 +-
 include/block/block-hmp-cmds.h                     |  55 +--
 include/disas/disas.h                              |   4 +-
 include/hw/core/qdev.h                             |   5 +-
 include/hw/core/sysemu-cpu-ops.h                   |   2 +
 include/hw/hexagon/hexagon_tlb.h                   |   5 +-
 include/hw/usb/usb.h                               |   3 +-
 include/monitor/hmp.h                              | 334 +++++++++--------
 include/monitor/monitor.h                          |  21 --
 include/monitor/qdev.h                             |   5 +-
 include/net/net.h                                  |   8 +-
 include/net/slirp.h                                |   8 +-
 include/qemu-io.h                                  |   4 +-
 include/system/memory.h                            |   2 +
 meson.build                                        |   6 +-
 meson_options.txt                                  |   2 +
 migration/dirtyrate.c                              |  52 +--
 migration/meson.build                              |   4 +-
 migration/migration-hmp-cmds.c                     | 363 +++++++++---------
 monitor/hmp-cmds.c                                 | 290 +++++++--------
 monitor/hmp.c                                      | 257 +++++++------
 monitor/meson.build                                |   9 +-
 monitor/monitor-hmp-internal.h                     | 106 ++++++
 monitor/monitor-internal.h                         | 104 ------
 monitor/monitor.c                                  |  76 ++--
 monitor/qmp-cmds.c                                 |   5 +-
 net/hub.c                                          |  29 +-
 net/hub.h                                          |   4 +-
 net/meson.build                                    |   4 +-
 net/net-hmp-cmds.c                                 |  85 +++--
 net/net.c                                          |  70 +++-
 net/slirp.c                                        |  70 ++--
 python/qemu/utils/__init__.py                      |   5 +-
 qapi/block.json                                    |  34 ++
 qapi/control.json                                  |   4 +-
 qapi/misc.json                                     |   3 +-
 qapi/net.json                                      | 166 +++++++++
 qemu-io-cmds.c                                     | 414 +++++++++++----------
 qemu-io.c                                          |  17 +-
 qemu-options.hx                                    |   6 +-
 qom/meson.build                                    |   4 +-
 qom/qom-hmp-cmds.c                                 |  46 +--
 replay/replay-debugging.c                          |  20 +-
 replay/stubs-system.c                              |  14 +-
 scripts/meson-buildoptions.sh                      |   3 +
 stats/meson.build                                  |   5 +-
 stats/stats-hmp-cmds.c                             |  60 +--
 stubs/hmp-cmd-info_sev.c                           |   4 +-
 stubs/meson.build                                  |  15 +-
 stubs/monitor-core.c                               |  21 +-
 stubs/monitor-cur.c                                |  14 +
 stubs/monitor-hmp.c                                |   9 +
 stubs/monitor-internal.c                           |   4 +-
 stubs/qapi-event-emit.c                            |   8 +
 system/dirtylimit-hmp-cmds.c                       |  20 +-
 system/meson.build                                 |  11 +-
 system/physmem.c                                   |  31 ++
 system/qdev-monitor.c                              |  39 +-
 system/qtest.c                                     |  14 +
 system/runstate-hmp-cmds.c                         |  22 +-
 system/tpm-hmp-cmds.c                              |  30 +-
 system/vl.c                                        |   4 +-
 target/hexagon/hex_mmu.c                           |   6 +-
 target/hexagon/hex_mmu.h                           |   3 +-
 target/i386/cpu-apic.c                             |   8 +-
 target/i386/cpu.c                                  |   8 +-
 target/i386/cpu.h                                  |   4 +-
 target/i386/helper.c                               |  49 +--
 target/i386/kvm/kvm.c                              |   4 +-
 target/i386/monitor.c                              | 173 ++++-----
 target/i386/sev.c                                  |  38 +-
 target/m68k/cpu.c                                  |   4 +
 target/m68k/monitor.c                              |   8 +-
 target/ppc/monitor.c                               |   8 +-
 target/riscv/monitor.c                             |  61 +--
 target/rx/disas.c                                  |   1 +
 target/sh4/monitor.c                               |  34 +-
 target/sparc/cpu.c                                 |   5 +-
 target/sparc/monitor.c                             |   8 +-
 target/xtensa/monitor.c                            |   8 +-
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
 tests/qtest/ahci-test.c                            |   5 +-
 tests/qtest/cdrom-test.c                           |  29 +-
 tests/qtest/device-introspect-test.c               | 111 ++++--
 tests/qtest/drive_del-test.c                       |  25 ++
 tests/qtest/ide-test.c                             |   4 +-
 tests/qtest/libqtest.c                             |  14 +
 tests/qtest/libqtest.h                             |  11 +
 tests/qtest/meson.build                            |   8 +-
 tests/qtest/netdev-socket.c                        | 143 ++++---
 tests/qtest/numa-test.c                            |  63 +++-
 tests/qtest/pnv-host-i2c-test.c                    |   2 +-
 tests/qtest/pnv-xive2-test.c                       |   2 +-
 tests/qtest/qmp-test.c                             |  13 +-
 tests/unit/test-util-sockets.c                     |   1 -
 tests/vm/basevm.py                                 |  13 +-
 tools/qemu-vnc/clipboard.c                         |   4 +-
 tools/qemu-vnc/stubs.c                             |   5 -
 trace/meson.build                                  |   5 +-
 trace/trace-hmp-cmds.c                             |  17 +-
 ui/meson.build                                     |   4 +-
 ui/ui-hmp-cmds.c                                   | 151 ++++----
 util/error-report.c                                |  72 ++--
 util/qemu-print.c                                  |  30 +-
 255 files changed, 3922 insertions(+), 2938 deletions(-)
---
base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
change-id: 20260521-qemu-no-hmp-ead3f0bf79c0

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


