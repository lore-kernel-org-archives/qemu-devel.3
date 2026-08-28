Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC5AC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Ot-0004N7-Lo; Fri, 28 Aug 2026 16:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Os-0004Ch-4i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Op-0007wA-FU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Af7uIp4TzybAVQ2B8/dplEM+WUnkAF4FqxCKdCx8wIQ=;
 b=S56efEOnewrOHknfqYg0hK5N2D1PXc4wk2xtPUt4iFCjxNW+zfhz8CTAy5GmkfYI0zK0Yi
 6Y7uLnh2jaLO1mpWj4c2bTRrE1vQvDn9+Q0XjqH6yO75q5NXreWJBg/dL4TdH0jJBSPvfA
 +fnLMFpOEdIEc9miIVWV1uHFU7iZlvc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-KbDTN98gOEirTLDq9_Jbwg-1; Fri,
 28 Aug 2026 16:42:02 -0400
X-MC-Unique: KbDTN98gOEirTLDq9_Jbwg-1
X-Mimecast-MFC-AGG-ID: KbDTN98gOEirTLDq9_Jbwg_1787949721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F273180AE2E; Fri, 28 Aug 2026 20:42:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E0611803A40; Fri, 28 Aug 2026 20:42:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/50] Make HMP optional
Message-Id: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
Date: Sat, 29 Aug 2026 00:41:39 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=19791;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Hbx5AZtewSnVveDeCK5GpeRN+zx0xR04BuGY9ku7srk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKTOOsVmfDT73JiAunSlZ8RrEy1/tI9Hy6Rq
 VG08KpSdaaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5dWXD/9J+f6/1/knBAqpfyM36ztiP0jaiexNiF1+6lGEV6JUOuN23/MaP8oUpQWOgLNm7PKJfD8
 NP3xzIiNJ9xsXE/aGhts9arFa0vdd4wWctejh07suPk+PQg0BkMDwRyl3rUA45CTnbP9r/0KIbt
 XCpNzRCPf00+A/qL0wdJ47EmMx3PFZtCCr2g8UU3kHY/LY+AZnD0n5p2H4IBVNm53kmjDatqMRP
 2I1jiIxER7hWMFODzjPqD0IV3ShfQtzHhDtHE4l5d4selhNlft8AVM6eJU8WiG+qowICzxIocJr
 z+R4bTwIddtrk59Xb3SBBSNebRPa+5BeJxQvLmehe4Z5juKVzI3Y2fhq+EGFdK12eE6X+8hTmTW
 Ge3KKKRMDitmFPAFHfH+WaNTcG7hGPCZNR3XBZFcyIDeRugz8wYE35fYfac36P2VM/j27XFCdWr
 v099D0eqY8f4S/XeVIYUy2smcGQqUFdiKIzLiyt+7ibsmfQDGjo8/jpJ+9Mf4gUzoT6lNqucEYm
 61uscv9cZ2ryLa/Hk5yWhpAFg7eLSJ7wRTWQVsSdCvcF0WWgrS2532fPogRZK96M2mCObNX9KQE
 8IUMcN1cOukazuBCcaQ/ZOTca9oBN7XZTXf6rsueU74kpWHjBHilfB3i/4025/irYfG3+1WbfJv
 +WrrVPobc/7ekvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:

  tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v1

for you to fetch changes up to 7a3647d67a54728e8f88aa0fa7f5e9a98bf06a51:

  gitlab: --disable-hmp in build-without-defaults (2026-08-29 00:41:32 +0400)

----------------------------------------------------------------
Make HMP optional

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
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
 create mode 100644 block/monitor/qmp-cmds.c
 create mode 100644 monitor/monitor-hmp-internal.h
 create mode 100644 stubs/monitor-cur.c
 create mode 100644 stubs/monitor-hmp.c
 create mode 100644 stubs/qapi-event-emit.c


