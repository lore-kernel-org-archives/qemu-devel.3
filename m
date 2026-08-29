Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A446C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 09:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0F99-0001Aw-1G; Sat, 29 Aug 2026 05:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x0F98-0001Aj-3w
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 05:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x0F95-00060Y-Cn
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 05:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787994877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33JlipVMbKkC9saEW/YHT3hEo5le8tQEq052Dv5jS/k=;
 b=ioW2ctHvEv17geldaYVllMF5wPWLJhA8ZjLbA74RDkUmm8/MOz9L3NbUzB0CDftigOU97o
 L9eKqbMRow4MVJ0ceTNh7sbl5FO2JRsOeeAPVObW+QTZhAsQFSJndrvG0J8uCd7qYab7+1
 ZxaeaX6JHeKUwE1vodlX2eP8kZEZqiw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-kdFMoOwfPR-JY7wsg0Xnmw-1; Sat,
 29 Aug 2026 05:14:34 -0400
X-MC-Unique: kdFMoOwfPR-JY7wsg0Xnmw-1
X-Mimecast-MFC-AGG-ID: kdFMoOwfPR-JY7wsg0Xnmw_1787994873
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575D219560B0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 09:14:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 486351955D69; Sat, 29 Aug 2026 09:14:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [GIT PULL v2 00/50] Make HMP optional
Date: Sat, 29 Aug 2026 13:14:29 +0400
Message-ID: <20260829-nohmp-v2-0-c5bf7b766fe7@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=19828;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pdNJDjqOWkJJ28YEsF+k4RsrXWN4VR3INJ2BcD6sjV8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkpOArKjwx+v/vu2QIFH0coJ1nKEqdF5jI9Y8e
 /qLaKQsUB6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapKTgAAKCRDa6OEJdZac
 5ZLMD/9WhW5SRY8yMI/xdpG1H1SxnzKYJqjkdUaMuUaVNZLoG3JTshm0Wklxkg9ch9FUfy16KF4
 Nr2cwkcZEiU6fBp7ln0XG6TpUXk97Do48aCVU5ZcpxqdVbtLnwa3kCVqrcBVGsmRpYRHoxvmLJn
 TisDCTbAnuVLDKJvBIqK943f5ThLbFc+NZ61KbDz5qDYp408p/gH2oJVXROUeLvmp+vLTwgAzsi
 WDMVRK0grMOu5pF0HXKzu6Vj3xlyAqlLNOm9uG9TTfM5ZttyZVM9f3CrDaSNnL3TJAyG/2lsaEA
 3+0kgnDsXG5x94J3mOj8kMWlHzPCST9jrxLOU61nsIP6BXIBYwJZ9Xj1edumccJc0fhxvk4t4Ig
 8bH6XNIcHN2T3k2Z6iMePUa9jPdaQ9toXEXivVmM3CyFGPTtLY9Mn0+Qcs7w3iD8FUTJfPK2MtD
 bo5rBY1OmlbDhP0On3RRLlVEIYvN3uW/DN3rJUlB3gt9bas8Uwc5gR9O7wU6ybKt3hGycezAfqO
 8xS9rhC0ScxhUUcfpyZ2m1JwI1aUhg5+dxbtbnGeoXElxMrhkIz8z6ff74kK0DbvxHJoz0iPsUv
 ivusXE1kWDw4M/oiIujl1xspY0jxORYwXjmy/X0C4CJgwqKoI8sbCvFAHH8408DI9gYBxLwCFE8 
 eToieosR2xdF6AQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b475=
:=0D
=0D
  Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qemu=
 into staging (2026-08-28 15:17:04 -0700)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v2=0D
=0D
for you to fetch changes up to 7ef933e532a5f86778a16f5b0074f1c2d7b87459:=0D
=0D
  gitlab: --disable-hmp in build-without-defaults (2026-08-29 12:08:21 +040=
0)=0D
=0D
----------------------------------------------------------------=0D
Make HMP optional=0D
v2:=0D
 - rebased, skip one new test=0D
=0D
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D
=0D
----------------------------------------------------------------=0D
Marc-Andr=C3=A9 Lureau (50):=0D
      build-sys: introduce CONFIG_HMP=0D
      vl: fix -monitor none prefix matching=0D
      hmp: remove 'vcpu' argument from trace-event help=0D
      hmp: fix snapshot_blkdev argument type=0D
      target/i386: decouple cpu_x86_inject_mce() from Monitor=0D
      target/i386: return an error for invalid CPU in hmp_mce()=0D
      system: move gpa2hva() to system memory unit=0D
      monitor: move HMP-only fields from Monitor to MonitorHMP=0D
      tests/functional: use query-version QMP command instead of HMP=0D
      net/qapi: add x-query-usernet command=0D
      python, tests: switch usernet queries from HMP to QMP=0D
      tests/qtest/pnv: drop unnecessary -serial mon:stdio=0D
      tests/qtest/qmp-test: don't depend on human-monitor-command=0D
      tests/qtest/numa-test: replace HMP "info numa" with QMP query-cpus-fa=
st=0D
      tests/qtest/cdrom-test: replace HMP "info block" with QMP query-block=
=0D
      tests/qtest/device-introspect-test: replace 'info qom-tree'=0D
      tests/qtest/device-introspect-test: restrict test when !CONFIG_HMP=0D
      tests/qemu-iotests/205: fix race in assertExportNotFound=0D
      net: add x-query-network QMP command=0D
      tests/qtest/netdev-socket: replace HMP with x-query-network QMP=0D
      qemu-io: propagate errors through Error API instead of printf=0D
      block: add x-qemu-io QMP command=0D
      qtest: add qemu-io command to the qtest protocol=0D
      qtest/ide-test: convert to use qtest qemu-io command=0D
      tests/qemu-iotests: add qmp_qemu_io()=0D
      tests/qemu-iotests: convert pause/resume_drive() to QMP=0D
      monitor: reject readline monitor when HMP is disabled=0D
      system: guard HMP initialization paths with CONFIG_HMP=0D
      tests: skip HMP-dependent tests when HMP is disabled=0D
      monitor: isolate HMP declarations in hmp.h=0D
      monitor: change HMPCommand cmd to take MonitorHMP=0D
      monitor: make hmp_handle_error() take MonitorHMP=0D
      monitor: add monitor_cur_hmp() helper=0D
      qemu-print: document HMP/QMP behaviour better=0D
      error-report: switch to use monitor_cur_hmp()=0D
      monitor: tighten monitor_set_cpu()/get_cpu()=0D
      monitor: tighten monitor_printf*()=0D
      hexagon: make dump_mmu() take MonitorHMP=0D
      qdev-monitor: make print_dev() callback take MonitorHMP=0D
      qapi: make HMP-specific schema entries conditional on CONFIG_HMP=0D
      Guard HMP command implementations with CONFIG_HMP=0D
      target: guard MonitorDef tables with CONFIG_HMP=0D
      hw: guard BusClass::print_dev with CONFIG_HMP=0D
      hexagon: condition HMP-specific code=0D
      build-sys: make HMP source files conditional on have_hmp=0D
      stubs: split monitor-core stubs into separate compilation units=0D
      monitor: move monitor_hmp_print*() functions to hmp.c=0D
      monitor: move HMP-specific to monitor-hmp-internal.h=0D
      build-sys: add 'hmp' option=0D
      gitlab: --disable-hmp in build-without-defaults=0D
=0D
 .gitlab-ci.d/buildtest.yml                         |   1 +=0D
 accel/accel-system.c                               |   3 +=0D
 accel/tcg/monitor.c                                |   3 +=0D
 audio/audio-hmp-cmds.c                             |  10 +-=0D
 audio/meson.build                                  |   4 +-=0D
 backends/cryptodev-hmp-cmds.c                      |  10 +-=0D
 backends/meson.build                               |   5 +-=0D
 block/monitor/block-hmp-cmds.c                     | 341 +++++++----------=
=0D
 block/monitor/meson.build                          |   5 +-=0D
 block/monitor/qmp-cmds.c                           |  79 ++++=0D
 chardev/char-hmp-cmds.c                            |  36 +-=0D
 chardev/char.c                                     |  11 +-=0D
 chardev/meson.build                                |   5 +-=0D
 disas/disas-mon.c                                  |  11 +-=0D
 disas/meson.build                                  |   4 +-=0D
 docs/devel/style.rst                               |   2 +-=0D
 docs/devel/writing-monitor-commands.rst            |   8 +-=0D
 dump/dump-hmp-cmds.c                               |  12 +-=0D
 dump/meson.build                                   |   5 +-=0D
 gdbstub/system.c                                   |  10 +-=0D
 hmp-commands-info.hx                               |   6 +-=0D
 hmp-commands.hx                                    |   9 +-=0D
 hw/char/virtio-serial-bus.c                        |  21 +-=0D
 hw/core/machine-hmp-cmds.c                         | 263 +++++++------=0D
 hw/core/meson.build                                |   5 +-=0D
 hw/core/sysbus.c                                   |  15 +-=0D
 hw/hexagon/hexagon_tlb.c                           |  87 ++---=0D
 hw/i386/kvm/xen-stubs.c                            |  10 +-=0D
 hw/i386/kvm/xen_evtchn.c                           |  28 +-=0D
 hw/i386/meson.build                                |   4 +-=0D
 hw/i386/sgx-hmp-stub.c                             |   4 +-=0D
 hw/i386/sgx.c                                      |  32 +-=0D
 hw/misc/auxbus.c                                   |  29 +-=0D
 hw/misc/mos6522-stub.c                             |   6 +-=0D
 hw/misc/mos6522.c                                  |   7 +-=0D
 hw/net/meson.build                                 |   4 +-=0D
 hw/net/rocker/rocker-hmp-cmds.c                    | 158 ++++----=0D
 hw/pci/meson.build                                 |   4 +-=0D
 hw/pci/pci-hmp-cmds.c                              | 121 +++---=0D
 hw/pci/pci-internal.h                              |   2 +-=0D
 hw/pci/pci-stub.c                                  |   8 +-=0D
 hw/pci/pci.c                                       |   2 +=0D
 hw/s390x/s390-skeys.c                              |  14 +-=0D
 hw/s390x/s390-stattrib.c                           |  26 +-=0D
 hw/uefi/ovmf-log.c                                 |  10 +-=0D
 hw/usb/bus.c                                       |  21 +-=0D
 hw/usb/host-libusb.c                               |  29 +-=0D
 hw/virtio/meson.build                              |   4 +-=0D
 hw/virtio/virtio-hmp-cmds.c                        | 312 ++++++++--------=
=0D
 hw/xen/xen-bus.c                                   |  11 +-=0D
 include/block/block-hmp-cmds.h                     |  55 +--=0D
 include/disas/disas.h                              |   4 +-=0D
 include/hw/core/qdev.h                             |   5 +-=0D
 include/hw/core/sysemu-cpu-ops.h                   |   2 +=0D
 include/hw/hexagon/hexagon_tlb.h                   |   5 +-=0D
 include/hw/usb/usb.h                               |   3 +-=0D
 include/monitor/hmp.h                              | 334 +++++++++--------=
=0D
 include/monitor/monitor.h                          |  21 --=0D
 include/monitor/qdev.h                             |   5 +-=0D
 include/net/net.h                                  |   8 +-=0D
 include/net/slirp.h                                |   8 +-=0D
 include/qemu-io.h                                  |   4 +-=0D
 include/system/memory.h                            |   2 +=0D
 meson.build                                        |   6 +-=0D
 meson_options.txt                                  |   2 +=0D
 migration/dirtyrate.c                              |  52 +--=0D
 migration/meson.build                              |   4 +-=0D
 migration/migration-hmp-cmds.c                     | 363 +++++++++--------=
-=0D
 monitor/hmp-cmds.c                                 | 290 +++++++--------=0D
 monitor/hmp.c                                      | 257 +++++++------=0D
 monitor/meson.build                                |   9 +-=0D
 monitor/monitor-hmp-internal.h                     | 106 ++++++=0D
 monitor/monitor-internal.h                         | 104 ------=0D
 monitor/monitor.c                                  |  76 ++--=0D
 monitor/qmp-cmds.c                                 |   5 +-=0D
 net/hub.c                                          |  29 +-=0D
 net/hub.h                                          |   4 +-=0D
 net/meson.build                                    |   4 +-=0D
 net/net-hmp-cmds.c                                 |  85 +++--=0D
 net/net.c                                          |  70 +++-=0D
 net/slirp.c                                        |  70 ++--=0D
 python/qemu/utils/__init__.py                      |   5 +-=0D
 qapi/block.json                                    |  34 ++=0D
 qapi/control.json                                  |   4 +-=0D
 qapi/misc.json                                     |   3 +-=0D
 qapi/net.json                                      | 166 +++++++++=0D
 qemu-io-cmds.c                                     | 414 +++++++++++------=
----=0D
 qemu-io.c                                          |  17 +-=0D
 qemu-options.hx                                    |   6 +-=0D
 qom/meson.build                                    |   4 +-=0D
 qom/qom-hmp-cmds.c                                 |  46 +--=0D
 replay/replay-debugging.c                          |  20 +-=0D
 replay/stubs-system.c                              |  14 +-=0D
 scripts/meson-buildoptions.sh                      |   3 +=0D
 stats/meson.build                                  |   5 +-=0D
 stats/stats-hmp-cmds.c                             |  60 +--=0D
 stubs/hmp-cmd-info_sev.c                           |   4 +-=0D
 stubs/meson.build                                  |  15 +-=0D
 stubs/monitor-core.c                               |  21 +-=0D
 stubs/monitor-cur.c                                |  14 +=0D
 stubs/monitor-hmp.c                                |   9 +=0D
 stubs/monitor-internal.c                           |   4 +-=0D
 stubs/qapi-event-emit.c                            |   8 +=0D
 system/dirtylimit-hmp-cmds.c                       |  20 +-=0D
 system/meson.build                                 |  11 +-=0D
 system/physmem.c                                   |  31 ++=0D
 system/qdev-monitor.c                              |  39 +-=0D
 system/qtest.c                                     |  14 +=0D
 system/runstate-hmp-cmds.c                         |  22 +-=0D
 system/tpm-hmp-cmds.c                              |  30 +-=0D
 system/vl.c                                        |   4 +-=0D
 target/hexagon/hex_mmu.c                           |   6 +-=0D
 target/hexagon/hex_mmu.h                           |   3 +-=0D
 target/i386/cpu-apic.c                             |   8 +-=0D
 target/i386/cpu.c                                  |   8 +-=0D
 target/i386/cpu.h                                  |   4 +-=0D
 target/i386/helper.c                               |  49 +--=0D
 target/i386/kvm/kvm.c                              |   4 +-=0D
 target/i386/monitor.c                              | 173 ++++-----=0D
 target/i386/sev.c                                  |  38 +-=0D
 target/m68k/cpu.c                                  |   4 +=0D
 target/m68k/monitor.c                              |   8 +-=0D
 target/ppc/monitor.c                               |   8 +-=0D
 target/riscv/monitor.c                             |  61 +--=0D
 target/rx/disas.c                                  |   1 +=0D
 target/sh4/monitor.c                               |  34 +-=0D
 target/sparc/cpu.c                                 |   5 +-=0D
 target/sparc/monitor.c                             |   8 +-=0D
 target/xtensa/monitor.c                            |   8 +-=0D
 tests/functional/generic/test_version.py           |  10 +-=0D
 tests/functional/qemu_test/utils.py                |   8 +-=0D
 tests/qemu-iotests/004.out                         |  20 +-=0D
 tests/qemu-iotests/021.out                         |  60 +--=0D
 tests/qemu-iotests/026.out                         | 228 ++++++------=0D
 tests/qemu-iotests/028                             |   1 +=0D
 tests/qemu-iotests/045                             |   3 +-=0D
 tests/qemu-iotests/051                             |   1 +=0D
 tests/qemu-iotests/056                             |   3 +-=0D
 tests/qemu-iotests/060                             |   1 +=0D
 tests/qemu-iotests/060.out                         |  44 ++-=0D
 tests/qemu-iotests/068                             |   1 +=0D
 tests/qemu-iotests/071                             |   1 +=0D
 tests/qemu-iotests/071.out                         |  10 +-=0D
 tests/qemu-iotests/072.out                         |   2 +-=0D
 tests/qemu-iotests/080.out                         |   4 +-=0D
 tests/qemu-iotests/081                             |   1 +=0D
 tests/qemu-iotests/081.out                         |   2 +-=0D
 tests/qemu-iotests/083.out                         |  36 +-=0D
 tests/qemu-iotests/089.out                         |   4 +-=0D
 tests/qemu-iotests/091                             |   1 +=0D
 tests/qemu-iotests/093                             |   3 +-=0D
 tests/qemu-iotests/102                             |   1 +=0D
 tests/qemu-iotests/114.out                         |   2 +-=0D
 tests/qemu-iotests/117                             |   1 +=0D
 tests/qemu-iotests/119                             |   1 +=0D
 tests/qemu-iotests/120                             |   1 +=0D
 tests/qemu-iotests/124                             |   3 +-=0D
 tests/qemu-iotests/130                             |   1 +=0D
 tests/qemu-iotests/132                             |   3 +-=0D
 tests/qemu-iotests/134.out                         |   2 +-=0D
 tests/qemu-iotests/136                             |   3 +-=0D
 tests/qemu-iotests/137.out                         |   2 +-=0D
 tests/qemu-iotests/142                             |   1 +=0D
 tests/qemu-iotests/145                             |   1 +=0D
 tests/qemu-iotests/146                             |   1 +=0D
 tests/qemu-iotests/148                             |   3 +-=0D
 tests/qemu-iotests/151                             |   3 +-=0D
 tests/qemu-iotests/152                             |   3 +-=0D
 tests/qemu-iotests/153                             |   1 +=0D
 tests/qemu-iotests/153.out                         |  12 +-=0D
 tests/qemu-iotests/156                             |   1 +=0D
 tests/qemu-iotests/157                             |   1 +=0D
 tests/qemu-iotests/161                             |   1 +=0D
 tests/qemu-iotests/165                             |   3 +-=0D
 tests/qemu-iotests/171                             |   2 +-=0D
 tests/qemu-iotests/171.out                         |  68 ++--=0D
 tests/qemu-iotests/172                             |   1 +=0D
 tests/qemu-iotests/181                             |   1 +=0D
 tests/qemu-iotests/185                             |   1 +=0D
 tests/qemu-iotests/186                             |   1 +=0D
 tests/qemu-iotests/192                             |   1 +=0D
 tests/qemu-iotests/201                             |   1 +=0D
 tests/qemu-iotests/205                             |   6 +-=0D
 tests/qemu-iotests/214.out                         |   2 +-=0D
 tests/qemu-iotests/216                             |   3 +-=0D
 tests/qemu-iotests/220.out                         |   2 +-=0D
 tests/qemu-iotests/225                             |   1 +=0D
 tests/qemu-iotests/225.out                         |   4 +-=0D
 tests/qemu-iotests/232                             |   1 +=0D
 tests/qemu-iotests/236                             |   3 +-=0D
 tests/qemu-iotests/244.out                         |  12 +-=0D
 tests/qemu-iotests/245                             |   3 +-=0D
 tests/qemu-iotests/246                             |   3 +-=0D
 tests/qemu-iotests/249                             |   1 +=0D
 tests/qemu-iotests/249.out                         |   6 +-=0D
 tests/qemu-iotests/254                             |   3 +-=0D
 tests/qemu-iotests/255                             |   3 +-=0D
 tests/qemu-iotests/257                             |   3 +-=0D
 tests/qemu-iotests/260                             |   3 +-=0D
 tests/qemu-iotests/264                             |   3 +-=0D
 tests/qemu-iotests/267                             |   1 +=0D
 tests/qemu-iotests/271.out                         |  14 +-=0D
 tests/qemu-iotests/274                             |   3 +-=0D
 tests/qemu-iotests/280                             |   1 +=0D
 tests/qemu-iotests/281                             |   3 +-=0D
 tests/qemu-iotests/283                             |   1 +=0D
 tests/qemu-iotests/286                             |   1 +=0D
 tests/qemu-iotests/289.out                         |   2 +-=0D
 tests/qemu-iotests/298                             |   3 +-=0D
 tests/qemu-iotests/300                             |   3 +-=0D
 tests/qemu-iotests/304                             |   3 +-=0D
 tests/qemu-iotests/305.out                         |   2 +-=0D
 tests/qemu-iotests/307.out                         |   2 +-=0D
 tests/qemu-iotests/310                             |   3 +-=0D
 tests/qemu-iotests/common.rc                       |   8 +=0D
 tests/qemu-iotests/iotests.py                      |  32 +-=0D
 tests/qemu-iotests/tests/backup-discard-source     |   7 +-=0D
 tests/qemu-iotests/tests/copy-before-write         |  69 ++--=0D
 tests/qemu-iotests/tests/file-io-error.out         |   2 +-=0D
 tests/qemu-iotests/tests/image-fleecing            |   3 +-=0D
 tests/qemu-iotests/tests/image-fleecing.out        |  12 +-=0D
 tests/qemu-iotests/tests/inactive-node-nbd.out     |   8 +-=0D
 tests/qemu-iotests/tests/iothreads-create          |   3 +-=0D
 tests/qemu-iotests/tests/luks-detached-header      |   3 +-=0D
 .../tests/migrate-bitmaps-postcopy-test            |   3 +-=0D
 tests/qemu-iotests/tests/migrate-bitmaps-test      |   3 +-=0D
 tests/qemu-iotests/tests/mirror-change-copy-mode   |   3 +-=0D
 tests/qemu-iotests/tests/mirror-ready-cancel-error |   3 +-=0D
 tests/qemu-iotests/tests/qcow2-internal-snapshots  |   1 +=0D
 tests/qemu-iotests/tests/qsd-migrate               |   3 +-=0D
 tests/qemu-iotests/tests/reopen-file               |   3 +-=0D
 tests/qemu-iotests/tests/write-zeroes-unmap        |   1 +=0D
 tests/qtest/ahci-test.c                            |   5 +-=0D
 tests/qtest/cdrom-test.c                           |  29 +-=0D
 tests/qtest/device-introspect-test.c               | 111 ++++--=0D
 tests/qtest/drive_del-test.c                       |  25 ++=0D
 tests/qtest/ide-test.c                             |   8 +-=0D
 tests/qtest/libqtest.c                             |  14 +=0D
 tests/qtest/libqtest.h                             |  11 +=0D
 tests/qtest/meson.build                            |   8 +-=0D
 tests/qtest/netdev-socket.c                        | 143 ++++---=0D
 tests/qtest/numa-test.c                            |  63 +++-=0D
 tests/qtest/pnv-host-i2c-test.c                    |   2 +-=0D
 tests/qtest/pnv-xive2-test.c                       |   2 +-=0D
 tests/qtest/qmp-test.c                             |  13 +-=0D
 tests/unit/test-util-sockets.c                     |   1 -=0D
 tests/vm/basevm.py                                 |  13 +-=0D
 tools/qemu-vnc/clipboard.c                         |   4 +-=0D
 tools/qemu-vnc/stubs.c                             |   5 -=0D
 trace/meson.build                                  |   5 +-=0D
 trace/trace-hmp-cmds.c                             |  17 +-=0D
 ui/meson.build                                     |   4 +-=0D
 ui/ui-hmp-cmds.c                                   | 151 ++++----=0D
 util/error-report.c                                |  72 ++--=0D
 util/qemu-print.c                                  |  30 +-=0D
 255 files changed, 3926 insertions(+), 2938 deletions(-)=0D
 create mode 100644 block/monitor/qmp-cmds.c=0D
 create mode 100644 monitor/monitor-hmp-internal.h=0D
 create mode 100644 stubs/monitor-cur.c=0D
 create mode 100644 stubs/monitor-hmp.c=0D
 create mode 100644 stubs/qapi-event-emit.c=0D
=0D


