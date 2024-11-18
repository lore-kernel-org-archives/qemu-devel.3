Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2DD49233
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3Qx-0007iA-9E; Mon, 18 Nov 2024 10:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tD3Qt-0007hc-Ub
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tD3Qp-0002rp-0Q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731942770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SleHbmHuseE0/UaM4uoTOkg23G0mBRlDw406pFKfsI=;
 b=YdNjO/sK5BpfegxHm/AMm4NDpjKEHYNpWr+5Q0Z8BnbHIEziL43n9okUskSToDV2U4dlsW
 Vl8WwzoYkfOHsGUFVCyN+aoHPkEHtrv8ja0x5EIn8P9tE7nyRo3VHpMoWKZFB01+mW8JEs
 ZQsoNI0K9K1uW7yv/7tCf+1oNKGw1EU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-repVW9fQN96S_o8dUdKgXg-1; Mon,
 18 Nov 2024 10:12:46 -0500
X-MC-Unique: repVW9fQN96S_o8dUdKgXg-1
X-Mimecast-MFC-AGG-ID: repVW9fQN96S_o8dUdKgXg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2938F1903470; Mon, 18 Nov 2024 15:12:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03DD61956086; Mon, 18 Nov 2024 15:12:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF75C21E691E; Mon, 18 Nov 2024 16:12:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Zhao Liu <zhao1.liu@intel.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v3 1/2] qapi: Move include/qapi/qmp/ to include/qobject/
Date: Mon, 18 Nov 2024 16:12:34 +0100
Message-ID: <20241118151235.2665921-2-armbru@redhat.com>
In-Reply-To: <20241118151235.2665921-1-armbru@redhat.com>
References: <20241118151235.2665921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The general expectation is that header files should follow the same
file/path naming scheme as the corresponding source file. There are
various historical exceptions to this practice in QEMU, with one of
the most notable being the include/qapi/qmp/ directory. Most of the
headers there correspond to source files in qobject/.

This patch corrects most of that inconsistency by creating
include/qobject/ and moving the headers for qobject/ there.

This also fixes MAINTAINERS for include/qapi/qmp/dispatch.h:
scripts/get_maintainer.pl now reports "QAPI" instead of "No
maintainers found".

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com> #s390x
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                                 |  5 +----
 docs/devel/qapi-code-gen.rst                |  2 +-
 include/block/qdict.h                       |  2 +-
 include/{qapi/qmp => qobject}/json-parser.h |  0
 include/{qapi/qmp => qobject}/json-writer.h |  0
 include/{qapi/qmp => qobject}/qbool.h       |  2 +-
 include/{qapi/qmp => qobject}/qdict.h       |  2 +-
 include/{qapi/qmp => qobject}/qjson.h       |  0
 include/{qapi/qmp => qobject}/qlist.h       |  2 +-
 include/{qapi/qmp => qobject}/qlit.h        |  0
 include/{qapi/qmp => qobject}/qnull.h       |  2 +-
 include/{qapi/qmp => qobject}/qnum.h        |  2 +-
 include/{qapi/qmp => qobject}/qobject.h     |  2 +-
 include/{qapi/qmp => qobject}/qstring.h     |  2 +-
 migration/migration.h                       |  2 +-
 monitor/monitor-internal.h                  |  2 +-
 qobject/json-parser-int.h                   |  2 +-
 qobject/qobject-internal.h                  |  2 +-
 tests/qtest/libqmp.h                        |  2 +-
 tests/qtest/libqtest.h                      |  4 ++--
 audio/audio-hmp-cmds.c                      |  2 +-
 audio/audio.c                               |  2 +-
 authz/listfile.c                            |  4 ++--
 backends/cryptodev-hmp-cmds.c               |  2 +-
 block.c                                     |  8 ++++----
 block/blkdebug.c                            |  6 +++---
 block/blkio.c                               |  2 +-
 block/blklogwrites.c                        |  4 ++--
 block/blkverify.c                           |  4 ++--
 block/copy-before-write.c                   |  2 +-
 block/copy-on-read.c                        |  2 +-
 block/curl.c                                |  4 ++--
 block/file-posix.c                          |  4 ++--
 block/file-win32.c                          |  4 ++--
 block/gluster.c                             |  2 +-
 block/iscsi.c                               |  4 ++--
 block/monitor/block-hmp-cmds.c              |  2 +-
 block/nbd.c                                 |  2 +-
 block/nfs.c                                 |  4 ++--
 block/null.c                                |  4 ++--
 block/nvme.c                                |  4 ++--
 block/parallels.c                           |  2 +-
 block/qapi-sysemu.c                         |  2 +-
 block/qapi.c                                | 10 +++++-----
 block/qcow.c                                |  4 ++--
 block/qcow2.c                               |  4 ++--
 block/qed.c                                 |  2 +-
 block/quorum.c                              |  6 +++---
 block/rbd.c                                 |  8 ++++----
 block/replication.c                         |  2 +-
 block/snapshot.c                            |  4 ++--
 block/ssh.c                                 |  4 ++--
 block/stream.c                              |  2 +-
 block/vhdx.c                                |  2 +-
 block/vmdk.c                                |  2 +-
 block/vpc.c                                 |  2 +-
 block/vvfat.c                               |  4 ++--
 blockdev.c                                  |  8 ++++----
 chardev/char-hmp-cmds.c                     |  2 +-
 dump/dump-hmp-cmds.c                        |  2 +-
 hw/arm/aspeed_ast27x0.c                     |  2 +-
 hw/arm/mps2-tz.c                            |  2 +-
 hw/arm/mps2.c                               |  2 +-
 hw/arm/mps3r.c                              |  2 +-
 hw/arm/sbsa-ref.c                           |  2 +-
 hw/arm/stellaris.c                          |  2 +-
 hw/arm/vexpress.c                           |  2 +-
 hw/arm/virt.c                               |  2 +-
 hw/arm/xlnx-versal.c                        |  2 +-
 hw/block/xen-block.c                        |  4 ++--
 hw/core/machine-hmp-cmds.c                  |  2 +-
 hw/core/machine-qmp-cmds.c                  |  2 +-
 hw/core/qdev-properties.c                   |  2 +-
 hw/core/qdev.c                              |  2 +-
 hw/hyperv/hv-balloon.c                      |  2 +-
 hw/i386/acpi-build.c                        |  2 +-
 hw/i386/kvm/xen_evtchn.c                    |  2 +-
 hw/i386/monitor.c                           |  2 +-
 hw/i386/pc.c                                |  2 +-
 hw/net/rocker/rocker-hmp-cmds.c             |  2 +-
 hw/net/virtio-net.c                         |  2 +-
 hw/net/xen_nic.c                            |  2 +-
 hw/pci/pci-hmp-cmds.c                       |  2 +-
 hw/ppc/pegasos2.c                           |  2 +-
 hw/ppc/spapr_drc.c                          |  2 +-
 hw/rx/rx62n.c                               |  2 +-
 hw/s390x/s390-skeys.c                       |  2 +-
 hw/s390x/s390-stattrib.c                    |  2 +-
 hw/usb/xen-usb.c                            |  4 ++--
 hw/vfio/pci.c                               |  2 +-
 hw/virtio/virtio-hmp-cmds.c                 |  2 +-
 hw/virtio/virtio-qmp.c                      |  4 ++--
 hw/xen/xen-bus.c                            |  2 +-
 migration/dirtyrate.c                       |  2 +-
 migration/migration-hmp-cmds.c              |  2 +-
 migration/migration.c                       |  2 +-
 migration/options.c                         |  2 +-
 migration/vmstate.c                         |  2 +-
 monitor/hmp-cmds-target.c                   |  2 +-
 monitor/hmp-cmds.c                          |  2 +-
 monitor/hmp.c                               |  4 ++--
 monitor/monitor.c                           |  2 +-
 monitor/qemu-config-qmp.c                   |  2 +-
 monitor/qmp.c                               |  6 +++---
 net/net-hmp-cmds.c                          |  2 +-
 net/net.c                                   |  2 +-
 net/slirp.c                                 |  2 +-
 qapi/qapi-clone-visitor.c                   |  2 +-
 qapi/qapi-dealloc-visitor.c                 |  2 +-
 qapi/qapi-forward-visitor.c                 | 14 +++++++-------
 qapi/qmp-dispatch.c                         |  6 +++---
 qapi/qmp-event.c                            |  6 +++---
 qapi/qobject-input-visitor.c                | 14 +++++++-------
 qapi/qobject-output-visitor.c               | 12 ++++++------
 qapi/string-input-visitor.c                 |  2 +-
 qemu-img.c                                  |  4 ++--
 qemu-io-cmds.c                              |  2 +-
 qemu-io.c                                   |  4 ++--
 qemu-nbd.c                                  |  4 ++--
 qga/main.c                                  |  6 +++---
 qobject/block-qdict.c                       |  8 ++++----
 qobject/json-parser.c                       | 12 ++++++------
 qobject/json-writer.c                       |  2 +-
 qobject/qbool.c                             |  2 +-
 qobject/qdict.c                             | 10 +++++-----
 qobject/qjson.c                             | 16 ++++++++--------
 qobject/qlist.c                             | 10 +++++-----
 qobject/qlit.c                              | 14 +++++++-------
 qobject/qnull.c                             |  2 +-
 qobject/qnum.c                              |  2 +-
 qobject/qobject.c                           | 12 ++++++------
 qobject/qstring.c                           |  2 +-
 qom/object.c                                | 10 +++++-----
 qom/object_interfaces.c                     |  6 +++---
 qom/qom-hmp-cmds.c                          |  4 ++--
 qom/qom-qmp-cmds.c                          |  2 +-
 replay/replay-debugging.c                   |  2 +-
 replay/replay-snapshot.c                    |  2 +-
 scsi/qemu-pr-helper.c                       |  2 +-
 stats/stats-hmp-cmds.c                      |  2 +-
 storage-daemon/qemu-storage-daemon.c        |  4 ++--
 system/device_tree.c                        |  2 +-
 system/dirtylimit.c                         |  2 +-
 system/qdev-monitor.c                       |  4 ++--
 system/runstate-hmp-cmds.c                  |  2 +-
 system/vl.c                                 |  6 +++---
 target/arm/arm-qmp-cmds.c                   |  2 +-
 target/i386/cpu-apic.c                      |  2 +-
 target/i386/cpu-sysemu.c                    |  2 +-
 target/i386/monitor.c                       |  2 +-
 target/loongarch/loongarch-qmp-cmds.c       |  2 +-
 target/ppc/cpu_init.c                       |  2 +-
 target/riscv/riscv-qmp-cmds.c               |  4 ++--
 target/s390x/cpu_models_sysemu.c            |  2 +-
 tests/qtest/adm1266-test.c                  |  4 ++--
 tests/qtest/adm1272-test.c                  |  4 ++--
 tests/qtest/ahci-test.c                     |  2 +-
 tests/qtest/arm-cpu-features.c              |  4 ++--
 tests/qtest/aspeed_gpio-test.c              |  2 +-
 tests/qtest/ast2700-gpio-test.c             |  2 +-
 tests/qtest/boot-order-test.c               |  2 +-
 tests/qtest/cdrom-test.c                    |  2 +-
 tests/qtest/cpu-plug-test.c                 |  4 ++--
 tests/qtest/device-introspect-test.c        |  6 +++---
 tests/qtest/device-plug-test.c              |  4 ++--
 tests/qtest/drive_del-test.c                |  4 ++--
 tests/qtest/emc141x-test.c                  |  2 +-
 tests/qtest/fdc-test.c                      |  2 +-
 tests/qtest/hd-geo-test.c                   |  2 +-
 tests/qtest/ide-test.c                      |  2 +-
 tests/qtest/isl_pmbus_vr-test.c             |  4 ++--
 tests/qtest/libqmp.c                        |  4 ++--
 tests/qtest/libqos/generic-pcihost.c        |  2 +-
 tests/qtest/libqos/libqos.c                 |  2 +-
 tests/qtest/libqos/pci-pc.c                 |  2 +-
 tests/qtest/libqos/qos_external.c           |  8 ++++----
 tests/qtest/libqtest.c                      | 10 +++++-----
 tests/qtest/lsm303dlhc-mag-test.c           |  2 +-
 tests/qtest/machine-none-test.c             |  2 +-
 tests/qtest/max34451-test.c                 |  4 ++--
 tests/qtest/migration-helpers.c             |  4 ++--
 tests/qtest/migration-test.c                |  4 ++--
 tests/qtest/netdev-socket.c                 |  2 +-
 tests/qtest/npcm7xx_adc-test.c              |  2 +-
 tests/qtest/npcm7xx_emc-test.c              |  4 ++--
 tests/qtest/npcm7xx_pwm-test.c              |  4 ++--
 tests/qtest/npcm7xx_watchdog_timer-test.c   |  2 +-
 tests/qtest/numa-test.c                     |  4 ++--
 tests/qtest/pvpanic-pci-test.c              |  2 +-
 tests/qtest/pvpanic-test.c                  |  2 +-
 tests/qtest/q35-test.c                      |  2 +-
 tests/qtest/qmp-cmd-test.c                  |  2 +-
 tests/qtest/qmp-test.c                      |  6 +++---
 tests/qtest/qom-test.c                      |  4 ++--
 tests/qtest/qos-test.c                      |  2 +-
 tests/qtest/readconfig-test.c               |  6 +++---
 tests/qtest/tco-test.c                      |  2 +-
 tests/qtest/test-filter-mirror.c            |  2 +-
 tests/qtest/test-filter-redirector.c        |  2 +-
 tests/qtest/test-netfilter.c                |  2 +-
 tests/qtest/test-x86-cpuid-compat.c         |  8 ++++----
 tests/qtest/tmp105-test.c                   |  2 +-
 tests/qtest/tpm-emu.c                       |  4 ++--
 tests/qtest/tpm-util.c                      |  2 +-
 tests/qtest/vhost-user-test.c               |  2 +-
 tests/qtest/virtio-net-failover.c           |  6 +++---
 tests/qtest/virtio-net-test.c               |  2 +-
 tests/qtest/vmgenid-test.c                  |  2 +-
 tests/qtest/wdt_ib700-test.c                |  2 +-
 tests/unit/check-block-qdict.c              |  4 ++--
 tests/unit/check-qdict.c                    |  6 +++---
 tests/unit/check-qjson.c                    | 12 ++++++------
 tests/unit/check-qlist.c                    |  4 ++--
 tests/unit/check-qlit.c                     | 12 ++++++------
 tests/unit/check-qnull.c                    |  2 +-
 tests/unit/check-qnum.c                     |  2 +-
 tests/unit/check-qobject.c                  | 12 ++++++------
 tests/unit/check-qom-proplist.c             |  4 ++--
 tests/unit/check-qstring.c                  |  2 +-
 tests/unit/test-block-iothread.c            |  2 +-
 tests/unit/test-blockjob-txn.c              |  2 +-
 tests/unit/test-blockjob.c                  |  2 +-
 tests/unit/test-char.c                      |  2 +-
 tests/unit/test-forward-visitor.c           |  4 ++--
 tests/unit/test-image-locking.c             |  2 +-
 tests/unit/test-keyval.c                    |  6 +++---
 tests/unit/test-qemu-opts.c                 |  4 ++--
 tests/unit/test-qga.c                       |  4 ++--
 tests/unit/test-qmp-cmds.c                  |  8 ++++----
 tests/unit/test-qmp-event.c                 | 10 +++++-----
 tests/unit/test-qobject-input-visitor.c     | 12 ++++++------
 tests/unit/test-qobject-output-visitor.c    | 12 ++++++------
 tests/unit/test-replication.c               |  2 +-
 tests/unit/test-visitor-serialization.c     |  4 ++--
 trace/trace-hmp-cmds.c                      |  2 +-
 ui/ui-hmp-cmds.c                            |  2 +-
 util/keyval.c                               |  6 +++---
 util/qemu-config.c                          |  4 ++--
 util/qemu-option.c                          |  8 ++++----
 scripts/qapi/commands.py                    |  4 ++--
 scripts/qapi/events.py                      |  2 +-
 scripts/qapi/introspect.py                  |  2 +-
 242 files changed, 433 insertions(+), 436 deletions(-)
 rename include/{qapi/qmp => qobject}/json-parser.h (100%)
 rename include/{qapi/qmp => qobject}/json-writer.h (100%)
 rename include/{qapi/qmp => qobject}/qbool.h (94%)
 rename include/{qapi/qmp => qobject}/qdict.h (98%)
 rename include/{qapi/qmp => qobject}/qjson.h (100%)
 rename include/{qapi/qmp => qobject}/qlist.h (98%)
 rename include/{qapi/qmp => qobject}/qlit.h (100%)
 rename include/{qapi/qmp => qobject}/qnull.h (94%)
 rename include/{qapi/qmp => qobject}/qnum.h (98%)
 rename include/{qapi/qmp => qobject}/qobject.h (98%)
 rename include/{qapi/qmp => qobject}/qstring.h (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..186d751e69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3189,8 +3189,6 @@ S: Supported
 F: qapi/
 X: qapi/*.json
 F: include/qapi/
-X: include/qapi/qmp/
-F: include/qapi/qmp/dispatch.h
 F: tests/qapi-schema/
 F: tests/unit/test-*-visitor.c
 F: tests/unit/test-qapi-*.c
@@ -3214,8 +3212,7 @@ QObject
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qobject/
-F: include/qapi/qmp/
-X: include/qapi/qmp/dispatch.h
+F: include/qobject/
 F: scripts/coccinelle/qobject.cocci
 F: tests/unit/check-qdict.c
 F: tests/unit/check-qjson.c
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 583207a8ec..90d1dfa16c 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1985,7 +1985,7 @@ Example::
     #ifndef EXAMPLE_QAPI_INTROSPECT_H
     #define EXAMPLE_QAPI_INTROSPECT_H
 
-    #include "qapi/qmp/qlit.h"
+    #include "qobject/qlit.h"
 
     extern const QLitObject example_qmp_schema_qlit;
 
diff --git a/include/block/qdict.h b/include/block/qdict.h
index b4c28d96a9..53c4df4cb2 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -10,7 +10,7 @@
 #ifndef BLOCK_QDICT_H
 #define BLOCK_QDICT_H
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 QObject *qdict_crumple(const QDict *src, Error **errp);
 void qdict_flatten(QDict *qdict);
diff --git a/include/qapi/qmp/json-parser.h b/include/qobject/json-parser.h
similarity index 100%
rename from include/qapi/qmp/json-parser.h
rename to include/qobject/json-parser.h
diff --git a/include/qapi/qmp/json-writer.h b/include/qobject/json-writer.h
similarity index 100%
rename from include/qapi/qmp/json-writer.h
rename to include/qobject/json-writer.h
diff --git a/include/qapi/qmp/qbool.h b/include/qobject/qbool.h
similarity index 94%
rename from include/qapi/qmp/qbool.h
rename to include/qobject/qbool.h
index 0d09726939..b348e17867 100644
--- a/include/qapi/qmp/qbool.h
+++ b/include/qobject/qbool.h
@@ -14,7 +14,7 @@
 #ifndef QBOOL_H
 #define QBOOL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QBool {
     struct QObjectBase_ base;
diff --git a/include/qapi/qmp/qdict.h b/include/qobject/qdict.h
similarity index 98%
rename from include/qapi/qmp/qdict.h
rename to include/qobject/qdict.h
index 82e90fc072..903e6e5462 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qobject/qdict.h
@@ -13,7 +13,7 @@
 #ifndef QDICT_H
 #define QDICT_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 #define QDICT_BUCKET_MAX 512
diff --git a/include/qapi/qmp/qjson.h b/include/qobject/qjson.h
similarity index 100%
rename from include/qapi/qmp/qjson.h
rename to include/qobject/qjson.h
diff --git a/include/qapi/qmp/qlist.h b/include/qobject/qlist.h
similarity index 98%
rename from include/qapi/qmp/qlist.h
rename to include/qobject/qlist.h
index e4e985d435..0377bf824e 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qobject/qlist.h
@@ -13,7 +13,7 @@
 #ifndef QLIST_H
 #define QLIST_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 typedef struct QListEntry {
diff --git a/include/qapi/qmp/qlit.h b/include/qobject/qlit.h
similarity index 100%
rename from include/qapi/qmp/qlit.h
rename to include/qobject/qlit.h
diff --git a/include/qapi/qmp/qnull.h b/include/qobject/qnull.h
similarity index 94%
rename from include/qapi/qmp/qnull.h
rename to include/qobject/qnull.h
index 7feb7c7d83..4423836a0c 100644
--- a/include/qapi/qmp/qnull.h
+++ b/include/qobject/qnull.h
@@ -13,7 +13,7 @@
 #ifndef QNULL_H
 #define QNULL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QNull {
     struct QObjectBase_ base;
diff --git a/include/qapi/qmp/qnum.h b/include/qobject/qnum.h
similarity index 98%
rename from include/qapi/qmp/qnum.h
rename to include/qobject/qnum.h
index e86788dd2e..1ce24b3668 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qobject/qnum.h
@@ -15,7 +15,7 @@
 #ifndef QNUM_H
 #define QNUM_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 typedef enum {
     QNUM_I64,
diff --git a/include/qapi/qmp/qobject.h b/include/qobject/qobject.h
similarity index 98%
rename from include/qapi/qmp/qobject.h
rename to include/qobject/qobject.h
index 256d782688..a6244d0ce0 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qobject/qobject.h
@@ -34,7 +34,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 
-/* Not for use outside include/qapi/qmp/ */
+/* Not for use outside include/qobject/ */
 struct QObjectBase_ {
     QType type;
     size_t refcnt;
diff --git a/include/qapi/qmp/qstring.h b/include/qobject/qstring.h
similarity index 96%
rename from include/qapi/qmp/qstring.h
rename to include/qobject/qstring.h
index 318d815d6a..1e2abe4032 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qobject/qstring.h
@@ -13,7 +13,7 @@
 #ifndef QSTRING_H
 #define QSTRING_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QString {
     struct QObjectBase_ base;
diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b..ef5e1e5e6e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -17,7 +17,7 @@
 #include "exec/cpu-common.h"
 #include "hw/qdev-core.h"
 #include "qapi/qapi-types-migration.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
 #include "io/channel.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index cb628f681d..797e89a999 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -29,7 +29,7 @@
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-control.h"
 #include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/json-parser.h"
+#include "qobject/json-parser.h"
 #include "qemu/readline.h"
 #include "sysemu/iothread.h"
 
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 16a25d00bb..8c01f23627 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -14,7 +14,7 @@
 #ifndef JSON_PARSER_INT_H
 #define JSON_PARSER_INT_H
 
-#include "qapi/qmp/json-parser.h"
+#include "qobject/json-parser.h"
 
 typedef enum json_token_type {
     JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
diff --git a/qobject/qobject-internal.h b/qobject/qobject-internal.h
index b310c8e1b5..0c7679fe98 100644
--- a/qobject/qobject-internal.h
+++ b/qobject/qobject-internal.h
@@ -10,7 +10,7 @@
 #ifndef QOBJECT_INTERNAL_H
 #define QOBJECT_INTERNAL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 static inline void qobject_init(QObject *obj, QType type)
 {
diff --git a/tests/qtest/libqmp.h b/tests/qtest/libqmp.h
index 3445b753ff..4a931c93ab 100644
--- a/tests/qtest/libqmp.h
+++ b/tests/qtest/libqmp.h
@@ -18,7 +18,7 @@
 #ifndef LIBQMP_H
 #define LIBQMP_H
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 QDict *qmp_fd_receive(int fd);
 #ifndef _WIN32
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18eb..fdeb7ebf71 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -17,8 +17,8 @@
 #ifndef LIBQTEST_H
 #define LIBQTEST_H
 
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "libqmp.h"
 
 typedef struct QTestState QTestState;
diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index c9608b715b..8774c09f18 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -27,7 +27,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
 
diff --git a/audio/audio.c b/audio/audio.c
index af0ae33fed..2067d7e5f8 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -32,7 +32,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/qapi-commands-audio.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/authz/listfile.c b/authz/listfile.c
index 45a60e987d..d31d9103f7 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -28,8 +28,8 @@
 #include "qemu/filemonitor.h"
 #include "qom/object_interfaces.h"
 #include "qapi/qapi-visit-authz.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qjson.h"
+#include "qobject/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 
 
diff --git a/backends/cryptodev-hmp-cmds.c b/backends/cryptodev-hmp-cmds.c
index 4f7220bb13..01396d227c 100644
--- a/backends/cryptodev-hmp-cmds.c
+++ b/backends/cryptodev-hmp-cmds.c
@@ -14,7 +14,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-cryptodev.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict)
diff --git a/block.c b/block.c
index 7d90007cae..fa3db17dc5 100644
--- a/block.c
+++ b/block.c
@@ -36,10 +36,10 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
diff --git a/block/blkdebug.c b/block/blkdebug.c
index c95c818c38..e560702703 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -33,9 +33,9 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "sysemu/qtest.h"
 
diff --git a/block/blkio.c b/block/blkio.c
index e0e765af63..c99ce6bdf7 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -16,7 +16,7 @@
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "exec/memory.h" /* for ram_block_discard_disable() */
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ed38a93f21..b0f78c4bc7 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -14,8 +14,8 @@
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/blkverify.c b/block/blkverify.c
index 5a9bf674d9..db79a36681 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -12,8 +12,8 @@
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 81afeff1c7..35a17e9099 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index c36f253d16..accf1402f0 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -25,7 +25,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "block/copy-on-read.h"
 
 
diff --git a/block/curl.c b/block/curl.c
index 0fdb6d39ac..5467678024 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -29,8 +29,8 @@
 #include "qemu/option.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "crypto/secret.h"
 #include <curl/curl.h>
 #include "qemu/cutils.h"
diff --git a/block/file-posix.c b/block/file-posix.c
index 90fa54352c..44e16dda87 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -36,8 +36,8 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 #include "scsi/pr-manager.h"
 #include "scsi/constants.h"
diff --git a/block/file-win32.c b/block/file-win32.c
index 7e1baa1ece..af9aea631c 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -33,8 +33,8 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include <windows.h>
 #include <winioctl.h>
 
diff --git a/block/gluster.c b/block/gluster.c
index e9c038042b..c6d25ae733 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -15,7 +15,7 @@
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index 979bf90cb7..931dafe68f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -44,8 +44,8 @@
 #include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "crypto/secret.h"
 #include "scsi/utils.h"
 #include "trace.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdf2eb50b6..f10b1776cc 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -41,7 +41,7 @@
 #include "sysemu/blockdev.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-export.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
diff --git a/block/nbd.c b/block/nbd.c
index d464315766..887841bc81 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -36,7 +36,7 @@
 #include "qemu/main-loop.h"
 
 #include "qapi/qapi-visit-sockets.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qapi/clone-visitor.h"
 
 #include "block/qdict.h"
diff --git a/block/nfs.c b/block/nfs.c
index 0500f60c08..ca4c76ab6e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -41,8 +41,8 @@
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include <nfsc/libnfs.h>
diff --git a/block/null.c b/block/null.c
index 4730acc1eb..a38b24cca8 100644
--- a/block/null.c
+++ b/block/null.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block-io.h"
diff --git a/block/nvme.c b/block/nvme.c
index 3b588b139f..87e6766479 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -14,8 +14,8 @@
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..402e8b58fd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -36,7 +36,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qemu/bswap.h"
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index e4282631d2..8949f09488 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -35,7 +35,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 
diff --git a/block/qapi.c b/block/qapi.c
index 2b5793f1d9..0b4f1cec0a 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -33,11 +33,11 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/qcow.c b/block/qcow.c
index 84d1cca296..f3190cb195 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -34,8 +34,8 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include <zlib.h>
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto/block.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 803ca73a2f..13fef01646 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -32,8 +32,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "trace.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
diff --git a/block/qed.c b/block/qed.c
index fa5bc11085..34c8a72453 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -24,7 +24,7 @@
 #include "trace.h"
 #include "qed.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/quorum.c b/block/quorum.c
index 46be65a95f..30747a6df9 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -23,10 +23,10 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "crypto/hash.h"
 
 #define HASH_LENGTH 32
diff --git a/block/rbd.c b/block/rbd.c
index 04ed0e242e..55111d6b3e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -24,10 +24,10 @@
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/replication.c b/block/replication.c
index 0415a5e8b7..4cc53ff4b4 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -21,7 +21,7 @@
 #include "block/block_backup.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "block/replication.h"
 
 typedef enum {
diff --git a/block/snapshot.c b/block/snapshot.c
index 8fd1756777..403628b6bb 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -27,8 +27,8 @@
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/ssh.c b/block/ssh.c
index 9f8140bcb6..baa9f923c8 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -39,8 +39,8 @@
 #include "qemu/sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "trace.h"
diff --git a/block/stream.c b/block/stream.c
index 9076203193..202b654215 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -16,7 +16,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
 #include "block/copy-on-read.h"
diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a13506..b76e14ece0 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -29,7 +29,7 @@
 #include "vhdx.h"
 #include "migration/blocker.h"
 #include "qemu/uuid.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 78f6433607..3dc778ef15 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/vpc.c b/block/vpc.c
index d95a204612..e8e3d9f698 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -34,7 +34,7 @@
 #include "qemu/bswap.h"
 #include "qemu/uuid.h"
 #include "qemu/memalign.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/vvfat.c b/block/vvfat.c
index 8ffe8b3b9b..1f5b35c5be 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -34,8 +34,8 @@
 #include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/blockdev.c b/blockdev.c
index 6740663fda..3926f316a3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -46,12 +46,12 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-transaction.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index 287c2b1bcd..8e9e1c1c02 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index d9340427c3..21023db6fd 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -10,7 +10,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 63d1fcb086..8de933d4b7 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -20,7 +20,7 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/intc/arm_gicv3.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8edf57a66d..63aef4922c 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -48,7 +48,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..d023c231f5 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -48,7 +48,7 @@
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/qdev-clock.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 typedef enum MPS2FPGAType {
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c..33e6432988 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..062c9db229 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -48,7 +48,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..4540c47d45 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -31,7 +31,7 @@
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "ui/input.h"
 
 #define GPIO_A 0
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index de815d84cc..47ccb2db8a 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -42,7 +42,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..f3c996fe44 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -70,7 +70,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3a1e2e29f1..346e09a3f3 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..5c5a5fec19 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -16,8 +16,8 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 8701f00cc7..e68a0545f1 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..8e51a9031c 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 315196bd85..211461b335 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,7 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77..930d33b364 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 3a9ef07691..76ed893ce8 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -26,7 +26,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-types-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9fcc2897b8..d62a330d91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "acpi-build.h"
 #include "acpi-common.h"
 #include "qemu/bitmap.h"
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 07bd0c9ab8..2a963a87df 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -20,7 +20,7 @@
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/object.h"
 #include "exec/target_page.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1ebd3564bf..1921e4d52e 100644
--- a/hw/i386/monitor.c
+++ b/hw/i386/monitor.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "hw/i386/x86.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9147fecbd..f47f48bc57 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -44,7 +44,7 @@
 #include "sysemu/reset.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "acpi-build.h"
diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
index 197c6e28dc..df40991f6d 100644
--- a/hw/net/rocker/rocker-hmp-cmds.c
+++ b/hw/net/rocker/rocker-hmp-cmds.c
@@ -18,7 +18,7 @@
 #include "monitor/monitor.h"
 #include "net/eth.h"
 #include "qapi/qapi-commands-rocker.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void hmp_rocker(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f2104ed364..ba46d097fb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,7 +26,7 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qemu/config-file.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 89487b49ba..31866bd1fb 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -24,7 +24,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 
 #include <sys/socket.h>
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index fdfe44435c..a5f6483cc3 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -20,7 +20,7 @@
 #include "monitor/monitor.h"
 #include "pci-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-pci.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ff4a00c34..086f6c0673 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -32,7 +32,7 @@
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "trace.h"
 #include "qemu/datadir.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..4b3dec6e50 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 560f53a58a..dd2122a562 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 /*
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index bf22d6863e..1b89092fe7 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/memory_mapping.h"
 #include "exec/address-spaces.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c4259b5327..b9116cd5f5 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 13901625c0..13b065b0fa 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,8 +30,8 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 #include "hw/xen/interface/io/usbif.h"
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..4b9ec847ab 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..7d8677bcf0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -9,7 +9,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 static void hmp_virtio_dump_protocols(Monitor *mon,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index cccc6fe761..fbcb7c57e8 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-virtio.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qobject.h"
+#include "qobject/qjson.h"
 #include "hw/virtio/vhost-user.h"
 
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 95b207ac8b..c4e2b3c2f9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -18,7 +18,7 @@
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "trace.h"
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index f7e86686fc..54f4046412 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -24,7 +24,7 @@
 #include "dirtyrate.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "exec/memory.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e219..69c86780e3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/cutils.h"
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..3996683900 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -43,7 +43,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/rcu.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..4bfa2ac236 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -19,7 +19,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
 #include "migration/misc.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index fa002b24e8..1199a823f7 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -15,7 +15,7 @@
 #include "migration/vmstate.h"
 #include "savevm.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index ff01cf9d8d..a79418f52b 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -29,7 +29,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/hw_accel.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f601d06ab8..c353c52ec5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,7 +25,7 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 460e8832f6..dc33fec8c3 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,8 +27,8 @@
 #include "hw/qdev-core.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 56786c0ccc..c35c7a1d37 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -28,7 +28,7 @@
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 24477a0e44..9a3b183602 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -2,7 +2,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "hw/boards.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5e538f34c0..2f46cf9e49 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -28,9 +28,9 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "trace.h"
 
 /*
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 41d326bf5f..e7c55d2787 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -22,7 +22,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
diff --git a/net/net.c b/net/net.c
index 7ef6885876..582a0fdf1d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -36,7 +36,7 @@
 #include "qemu/help_option.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed4..9b2784d643 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -43,7 +43,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "util.h"
 #include "migration/register.h"
 #include "migration/vmstate.h"
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index bbf953698f..30997638de 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -12,7 +12,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 
 struct QapiCloneVisitor {
     Visitor visitor;
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ef283f2966..57a2c904bb 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/visitor-impl.h"
 
 struct QapiDeallocVisitor
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index e36d9bc9ba..dea540c3c9 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -14,14 +14,14 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 
 struct ForwardFieldVisitor {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 176b549473..e24ba9f0b6 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -17,11 +17,11 @@
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qbool.h"
 #include "qemu/coroutine.h"
 #include "qemu/main-loop.h"
 
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 0fe0d0a5a6..11cb6ace99 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -14,9 +14,9 @@
 #include "qemu/osdep.h"
 
 #include "qapi/qmp-event.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 
 static void timestamp_put(QDict *qdict)
 {
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2..93317532be 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -19,14 +19,14 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/keyval.h"
 
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 74770edd73..13d3ae95b7 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -17,12 +17,12 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct QStackEntry {
     QObject *value;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 3f1b9e9b41..f4eecc73d0 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -15,7 +15,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 
diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..3cee4e4d23 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -32,8 +32,8 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index e2fab57183..844c738b55 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu-io.h"
 #include "sysemu/block-backend.h"
 #include "block/block.h"
diff --git a/qemu-io.c b/qemu-io.c
index 6cb1e00385..3e30da48cb 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -27,8 +27,8 @@
 #include "qemu/readline.h"
 #include "qemu/log.h"
 #include "qemu/sockets.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a186d2e119..2076aec68d 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -37,8 +37,8 @@
 #include "qemu/log.h"
 #include "qemu/systemd.h"
 #include "block/snapshot.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
diff --git a/qga/main.c b/qga/main.c
index 50186760bf..e74c14b3fc 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -19,9 +19,9 @@
 #include <sys/wait.h>
 #endif
 #include "qemu/help-texts.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/json-parser.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "guest-agent-core.h"
 #include "qga-qapi-init-commands.h"
 #include "qapi/error.h"
diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 4a83bda2c3..d0e1c63cf6 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -9,10 +9,10 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d498db6e70..7483e582fe 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,12 +16,12 @@
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "json-parser-int.h"
 
 struct JSONToken {
diff --git a/qobject/json-writer.c b/qobject/json-writer.c
index 309a31d57a..aac2c6ab71 100644
--- a/qobject/json-writer.c
+++ b/qobject/json-writer.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/unicode.h"
 
 struct JSONWriter {
diff --git a/qobject/qbool.c b/qobject/qbool.c
index c7049c0c50..00d7066aae 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qbool.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..a90ac9ae2f 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 167fcb429c..c858dafb5e 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -13,14 +13,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/json-writer.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/json-parser.h"
+#include "qobject/json-writer.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct JSONParsingState {
     JSONMessageParser parser;
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 356ad946b0..41e6876d5b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/queue.h"
 #include "qobject-internal.h"
 
diff --git a/qobject/qlit.c b/qobject/qlit.c
index a62865b642..a44f47eaa5 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -15,13 +15,13 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qlit.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qnull.h"
 
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
diff --git a/qobject/qnull.c b/qobject/qnull.c
index 445a5db7f3..0fb78cbd0a 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qobject-internal.h"
 
 QNull qnull_ = {
diff --git a/qobject/qnum.c b/qobject/qnum.c
index dd8ea49565..a938b64537 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qobject.c b/qobject/qobject.c
index d7077b8f2a..78d1e057c1 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 QEMU_BUILD_BUG_MSG(
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 794f8c9357..d316604914 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qom/object.c b/qom/object.c
index 9edc06d391..9c434dda78 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,16 +23,16 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 #include "trace.h"
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/error-report.h"
 
 #define MAX_INTERFACES 32
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1a6f29c053..f35d331331 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -3,10 +3,10 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 6e3a2175a4..a00a564b1e 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -11,8 +11,8 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "qemu/readline.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 46e4562300..e866547618 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -20,7 +20,7 @@
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 82c66fff26..fd46a948d2 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -17,7 +17,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-replay.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/timer.h"
 #include "block/snapshot.h"
 #include "migration/snapshot.h"
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index ccb4d89dda..37394b626e 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -14,7 +14,7 @@
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qemu/error-report.h"
 #include "migration/vmstate.h"
 #include "migration/snapshot.h"
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index c6c6347e9b..b69dd982d6 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -47,7 +47,7 @@
 #include "qemu/log.h"
 #include "qemu/systemd.h"
 #include "qapi/util.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
 #include "qemu-version.h"
diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
index 1f91bf8bd5..b93b471b1b 100644
--- a/stats/stats-hmp-cmds.c
+++ b/stats/stats-hmp-cmds.c
@@ -11,7 +11,7 @@
 #include "monitor/monitor.h"
 #include "qemu/cutils.h"
 #include "hw/core/cpu.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 
 static void print_stats_schema_value(Monitor *mon, StatsSchemaValue *value)
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 0e9354faa6..9d5e84674d 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -38,8 +38,8 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-block-export.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 
 #include "qemu/help-texts.h"
diff --git a/system/device_tree.c b/system/device_tree.c
index 2e38259d34..446e49cef6 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -28,7 +28,7 @@
 #include "hw/boards.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "monitor/hmp.h"
 
 #include <libfdt.h>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index ab20da34bb..644b0060ce 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "sysemu/dirtyrate.h"
 #include "sysemu/dirtylimit.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 4c09b38ffb..ae4c786930 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -27,9 +27,9 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index 2df670f0c0..be1d676992 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/accel.h"
 
 void hmp_info_status(Monitor *mon, const QDict *qdict)
diff --git a/system/vl.c b/system/vl.c
index d217b3d64d..ce079faa24 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -31,9 +31,9 @@
 #include "hw/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qjson.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..c89fd3258f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -28,7 +28,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 
 static GICCapability *gic_cap_new(int version)
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index d397ec94dc..9fd4d6eab5 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 227ac021f6..96b8006b27 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 2d766b2637..3ea92b066e 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 782fd511fd..3fde5a5a20 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c2..890ee5d72b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -32,7 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d363dc318d..aff59b83c6 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,8 +26,8 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index f6df691b66..ea595a00d4 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine-target.h"
 
 static void list_add_feat(const char *name, void *opaque);
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 6c312c499f..5ae8206234 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -13,8 +13,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "adm1266-test"
diff --git a/tests/qtest/adm1272-test.c b/tests/qtest/adm1272-test.c
index 63f8514801..2abda8d5be 100644
--- a/tests/qtest/adm1272-test.c
+++ b/tests/qtest/adm1272-test.c
@@ -12,8 +12,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "adm1272-test"
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5a1923f721..88ac6c66ce 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -30,7 +30,7 @@
 #include "libqos/ahci.h"
 #include "libqos/pci-pc.h"
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/host-utils.h"
 
 #include "hw/pci/pci_ids.h"
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index cfd6f77353..6fd29593a5 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -11,8 +11,8 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 
 /*
  * We expect the SVE max-vq to be 16. Also it must be <= 64
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index d38f51d719..12675d4cbb 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "libqtest-single.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
diff --git a/tests/qtest/ast2700-gpio-test.c b/tests/qtest/ast2700-gpio-test.c
index 9275845564..eeae9bf11f 100644
--- a/tests/qtest/ast2700-gpio-test.c
+++ b/tests/qtest/ast2700-gpio-test.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "libqtest-single.h"
 
 #define AST2700_GPIO_BASE 0x14C0B000
diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
index c67b8cfe16..b6b37a0fb3 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 
 typedef struct {
diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index c86725a511..56e2d283a9 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "boot-sector.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 static char isoimage[] = "cdrom-boot-iso-XXXXXX";
 
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 7f5dd5f85a..6633abfc10 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -10,8 +10,8 @@
 #include "qemu/osdep.h"
 
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 struct PlugTestData {
     char *machine;
diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 587da59623..f84cec51dc 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -18,9 +18,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index c6f33153eb..7124f17a0f 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 static void system_reset(QTestState *qtest)
 {
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 7b67a4bbee..709e41370f 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -13,8 +13,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 static const char *qvirtio_get_dev_type(void);
 
diff --git a/tests/qtest/emc141x-test.c b/tests/qtest/emc141x-test.c
index 8c86694091..a24103e2cd 100644
--- a/tests/qtest/emc141x-test.c
+++ b/tests/qtest/emc141x-test.c
@@ -10,7 +10,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/sensor/emc141x_regs.h"
 
 #define EMC1414_TEST_ID   "emc1414-test"
diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 8645b080f7..1b37a8a4d2 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -26,7 +26,7 @@
 
 
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define DRIVE_FLOPPY_BLANK \
     "-drive if=floppy,file=null-co://,file.read-zeroes=on,format=raw,size=1440k"
diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index 85eb8d7668..929f5ab2db 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "libqtest.h"
 #include "libqos/fw_cfg.h"
 #include "libqos/libqos.h"
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 90ba6b298b..ceee444a9e 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -29,7 +29,7 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/malloc-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/bswap.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/isl_pmbus_vr-test.c b/tests/qtest/isl_pmbus_vr-test.c
index 5553ea410a..1ff840c6b7 100644
--- a/tests/qtest/isl_pmbus_vr-test.c
+++ b/tests/qtest/isl_pmbus_vr-test.c
@@ -21,8 +21,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "isl_pmbus_vr-test"
diff --git a/tests/qtest/libqmp.c b/tests/qtest/libqmp.c
index a89cab03c3..16fe546885 100644
--- a/tests/qtest/libqmp.c
+++ b/tests/qtest/libqmp.c
@@ -25,8 +25,8 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/json-parser.h"
+#include "qobject/qjson.h"
 
 #define SOCKET_MAX_FDS 16
 
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 3124b0e46b..4bbeb5ff50 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "../libqtest.h"
 #include "generic-pcihost.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 #include "qemu/host-utils.h"
 
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 5c0fa1f7c5..0cc8c511f0 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -2,7 +2,7 @@
 #include "../libqtest.h"
 #include "libqos.h"
 #include "pci.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 /*** Test Setup & Teardown ***/
 
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 96046287ac..147009f4f4 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "../libqtest.h"
 #include "pci-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 
 #include "qemu/module.h"
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_external.c
index c6bb8bff09..493ab747de 100644
--- a/tests/qtest/libqos/qos_external.c
+++ b/tests/qtest/libqos/qos_external.c
@@ -19,11 +19,11 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include "../libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qstring.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "libqos-malloc.h"
 #include "qgraph.h"
 #include "qgraph_internal.h"
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 817fd7aac5..c71eaa7322 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -33,11 +33,11 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
+#include "qobject/qbool.h"
 
 #define MAX_IRQ 256
 
diff --git a/tests/qtest/lsm303dlhc-mag-test.c b/tests/qtest/lsm303dlhc-mag-test.c
index 0f64e7fc67..55ef4594f9 100644
--- a/tests/qtest/lsm303dlhc-mag-test.c
+++ b/tests/qtest/lsm303dlhc-mag-test.c
@@ -13,7 +13,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define LSM303DLHC_MAG_TEST_ID        "lsm303dlhc_mag-test"
 #define LSM303DLHC_MAG_REG_CRA        0x00
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 159b2a705a..b6a87d27ed 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -14,7 +14,7 @@
 
 #include "qemu/cutils.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 struct arch2cpu {
diff --git a/tests/qtest/max34451-test.c b/tests/qtest/max34451-test.c
index dbf6ddc829..5e0878c923 100644
--- a/tests/qtest/max34451-test.c
+++ b/tests/qtest/max34451-test.c
@@ -11,8 +11,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "max34451-test"
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0025933883..b08b49bd43 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -12,11 +12,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e6a2803e71..419a910cb9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -13,14 +13,14 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "crypto/tlscredspsk.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "ppc-util.h"
 
 #include "migration-helpers.h"
diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 317af03817..b731af0ad9 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -11,7 +11,7 @@
 #include <glib/gstdio.h>
 #include "../unit/socket-helpers.h"
 #include "libqtest.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qemu/sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
diff --git a/tests/qtest/npcm7xx_adc-test.c b/tests/qtest/npcm7xx_adc-test.c
index e751a72e36..8bc89b8a8b 100644
--- a/tests/qtest/npcm7xx_adc-test.c
+++ b/tests/qtest/npcm7xx_adc-test.c
@@ -18,7 +18,7 @@
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define REF_HZ          (25000000)
 
diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index 2e1a1a6d70..eeedb27ee6 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -16,8 +16,8 @@
 
 #include "qemu/osdep.h"
 #include "libqos/libqos.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 #include "qemu/iov.h"
 
diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
index b53a43c417..052ea87662 100644
--- a/tests/qtest/npcm7xx_pwm-test.c
+++ b/tests/qtest/npcm7xx_pwm-test.c
@@ -17,8 +17,8 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 
 static int verbosity_level;
 
diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
index 981b853c99..521ea789f1 100644
--- a/tests/qtest/npcm7xx_watchdog_timer-test.c
+++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
@@ -18,7 +18,7 @@
 #include "qemu/timer.h"
 
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define WTCR_OFFSET     0x1c
 #define REF_HZ          (25000000)
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 6d92baee86..d657f38947 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 static char *make_cli(const GString *generic_cli, const char *test_cli)
 {
diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index dc021c2fdf..f788a44dbe 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/misc/pvpanic.h"
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index d49d2ba931..5606baf47b 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/misc/pvpanic.h"
 
 static void test_panic_nopause(void)
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index c922d81bc0..4636a40e99 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -14,7 +14,7 @@
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci-host/q35.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define TSEG_SIZE_TEST_GUEST_RAM_MBYTES 128
 
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 2c15f60958..15c88248b7 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -14,7 +14,7 @@
 #include "libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-introspect.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 
 const char common_args[] = "-nodefaults -machine none";
diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 22957fa49c..edf0886787 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -14,10 +14,10 @@
 #include "libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index d677f87c8e..1e30a5bfe8 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 114f6bef27..ad849c7438 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -20,7 +20,7 @@
 #include <getopt.h>
 #include "libqtest-single.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-machine.h"
diff --git a/tests/qtest/readconfig-test.c b/tests/qtest/readconfig-test.c
index 760f974e63..c6f32a4e14 100644
--- a/tests/qtest/readconfig-test.c
+++ b/tests/qtest/readconfig-test.c
@@ -13,10 +13,10 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qapi-visit-ui.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qemu/units.h"
 
 static QTestState *qtest_init_with_config(const char *cfgdata)
diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
index 0547d41173..20ccefabcb 100644
--- a/tests/qtest/tco-test.c
+++ b/tests/qtest/tco-test.c
@@ -12,7 +12,7 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 #include "hw/southbridge/ich9.h"
 #include "hw/acpi/ich9.h"
diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index f3865f7519..723d2c2f29 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index a77d5fd8ec..a996a80c1c 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -52,7 +52,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.c
index b09ef7fae9..326d4bd85f 100644
--- a/tests/qtest/test-netfilter.c
+++ b/tests/qtest/test-netfilter.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 /* add a netfilter to a netdev and then remove it */
 static void add_one_netfilter(void)
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9e7e5ef7b..f6f6c86ce8 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qbool.h"
 #include "libqtest-single.h"
 
 static char *get_cpu0_qom_path(void)
diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 85ad4eed85..3b114a50f5 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -12,7 +12,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/sensor/tmp105_regs.h"
 
 #define TMP105_TEST_ID   "tmp105-test"
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index 2bf8ff4c86..9e4c2005d0 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -16,8 +16,8 @@
 #include "backends/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "tpm-emu.h"
 
 void tpm_emu_test_wait_cond(TPMTestState *s)
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 1c0319e6e7..2cb2dd4796 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -18,7 +18,7 @@
 #include "hw/acpi/tpm.h"
 #include "libqtest.h"
 #include "tpm-util.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 8948fb81ef..ee6ab3cc95 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -12,7 +12,7 @@
 
 #include "libqtest-single.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc272..d1c16101c4 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -12,9 +12,9 @@
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "migration-helpers.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qjson.h"
 #include "libqos/malloc-pc.h"
 #include "libqos/virtio-pci.h"
 #include "hw/pci/pci.h"
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index 2df75c9780..60e5229a3d 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -11,7 +11,7 @@
 #include "libqtest-single.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-net.h"
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 29fee9e7c0..e613374665 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -15,7 +15,7 @@
 #include "boot-sector.h"
 #include "acpi-utils.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
 #define VMGENID_GUID_OFFSET 40   /* allow space for
diff --git a/tests/qtest/wdt_ib700-test.c b/tests/qtest/wdt_ib700-test.c
index 797288d939..1754757162 100644
--- a/tests/qtest/wdt_ib700-test.c
+++ b/tests/qtest/wdt_ib700-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/timer.h"
 
 static void qmp_check_no_event(QTestState *s)
diff --git a/tests/unit/check-block-qdict.c b/tests/unit/check-block-qdict.c
index 751c58e737..0036d85cfa 100644
--- a/tests/unit/check-block-qdict.c
+++ b/tests/unit/check-block-qdict.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
 #include "qapi/error.h"
 
 static void qdict_defaults_test(void)
diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
index b5efa859b0..a1312be30a 100644
--- a/tests/unit/check-qdict.c
+++ b/tests/unit/check-qdict.c
@@ -11,9 +11,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qjson.c b/tests/unit/check-qjson.c
index a89293ce51..780a3654d0 100644
--- a/tests/unit/check-qjson.c
+++ b/tests/unit/check-qjson.c
@@ -14,12 +14,12 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qjson.h"
+#include "qobject/qlit.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/unicode.h"
 
 static QString *from_json_str(const char *jstr, bool single, Error **errp)
diff --git a/tests/unit/check-qlist.c b/tests/unit/check-qlist.c
index 3cd0ccbf19..1388aeede3 100644
--- a/tests/unit/check-qlist.c
+++ b/tests/unit/check-qlist.c
@@ -11,8 +11,8 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qlist.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qlit.c b/tests/unit/check-qlit.c
index bd6798d912..ea7a0d9119 100644
--- a/tests/unit/check-qlit.c
+++ b/tests/unit/check-qlit.c
@@ -9,12 +9,12 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qlit.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 static QLitObject qlit = QLIT_QDICT(((QLitDictEntry[]) {
     { "foo", QLIT_QNUM(42) },
diff --git a/tests/unit/check-qnull.c b/tests/unit/check-qnull.c
index 5ceacc65d7..724a66d0bd 100644
--- a/tests/unit/check-qnull.c
+++ b/tests/unit/check-qnull.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/error.h"
diff --git a/tests/unit/check-qnum.c b/tests/unit/check-qnum.c
index bf7fe45bac..a40120e8d3 100644
--- a/tests/unit/check-qnum.c
+++ b/tests/unit/check-qnum.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qobject.c b/tests/unit/check-qobject.c
index 022b7c74fe..ccb25660f2 100644
--- a/tests/unit/check-qobject.c
+++ b/tests/unit/check-qobject.c
@@ -9,12 +9,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 #include <math.h>
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 79d4a8b89d..b814ded957 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -22,8 +22,8 @@
 
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qdict.h"
+#include "qobject/qobject.h"
 #include "qom/object.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/tests/unit/check-qstring.c b/tests/unit/check-qstring.c
index bd861f4f8b..2e6a00570f 100644
--- a/tests/unit/check-qstring.c
+++ b/tests/unit/check-qstring.c
@@ -11,7 +11,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 20ed54f570..9d84ab2436 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -28,7 +28,7 @@
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/tests/unit/test-blockjob-txn.c b/tests/unit/test-blockjob-txn.c
index d3b0bb24be..199f6f5291 100644
--- a/tests/unit/test-blockjob-txn.c
+++ b/tests/unit/test-blockjob-txn.c
@@ -15,7 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 typedef struct {
     BlockJob common;
diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index fe3e0d2d38..918d212661 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -15,7 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "iothread.h"
 
 static const BlockJobDriver test_block_job_driver = {
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index a6e8753e1c..38fd920123 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -10,7 +10,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 #include "io/channel-socket.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/unit/test-forward-visitor.c b/tests/unit/test-forward-visitor.c
index eea8ffc072..aad1c89f13 100644
--- a/tests/unit/test-forward-visitor.c
+++ b/tests/unit/test-forward-visitor.c
@@ -12,8 +12,8 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "test-qapi-visit.h"
 #include "qemu/keyval.h"
 
diff --git a/tests/unit/test-image-locking.c b/tests/unit/test-image-locking.c
index 2624cec6a0..7801876a01 100644
--- a/tests/unit/test-image-locking.c
+++ b/tests/unit/test-image-locking.c
@@ -28,7 +28,7 @@
 #include "block/block.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/main-loop.h"
 
 static BlockBackend *open_image(const char *path,
diff --git a/tests/unit/test-keyval.c b/tests/unit/test-keyval.c
index 4dc52c7a1a..c6e8f4fe37 100644
--- a/tests/unit/test-keyval.c
+++ b/tests/unit/test-keyval.c
@@ -13,9 +13,9 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qemu/cutils.h"
diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 828d40e928..8d03a69f7c 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -12,8 +12,8 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/config-file.h"
 
 
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 8cddf5dc37..541b08a5e7 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -5,8 +5,8 @@
 #include <sys/un.h>
 
 #include "../qtest/libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 typedef struct {
     char *test_dir;
diff --git a/tests/unit/test-qmp-cmds.c b/tests/unit/test-qmp-cmds.c
index 6d52b4e5d8..ad53886886 100644
--- a/tests/unit/test-qmp-cmds.c
+++ b/tests/unit/test-qmp-cmds.c
@@ -1,9 +1,9 @@
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
diff --git a/tests/unit/test-qmp-event.c b/tests/unit/test-qmp-event.c
index 08e95a382b..2aac27163d 100644
--- a/tests/unit/test-qmp-event.c
+++ b/tests/unit/test-qmp-event.c
@@ -15,11 +15,11 @@
 
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qmp-event.h"
 #include "test-qapi-events.h"
 #include "test-qapi-emit-events.h"
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 5479e68237..84bdcdf702 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -17,12 +17,12 @@
 #include "qapi/qapi-visit-introspect.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
+#include "qobject/qjson.h"
 #include "test-qapi-introspect.h"
 #include "qapi/qapi-introspect.h"
 
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 3455f3b107..407ab9ed50 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -15,12 +15,12 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct TestOutputVisitorData {
     Visitor *ov;
diff --git a/tests/unit/test-replication.c b/tests/unit/test-replication.c
index 5d2003b8ce..32f2fbff6a 100644
--- a/tests/unit/test-replication.c
+++ b/tests/unit/test-replication.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/option.h"
 #include "qemu/main-loop.h"
 #include "block/replication.h"
diff --git a/tests/unit/test-visitor-serialization.c b/tests/unit/test-visitor-serialization.c
index c2056c3eaa..2d365999fc 100644
--- a/tests/unit/test-visitor-serialization.c
+++ b/tests/unit/test-visitor-serialization.c
@@ -16,8 +16,8 @@
 
 #include "test-qapi-visit.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qjson.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/string-input-visitor.h"
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index d38dd600de..45f4335ff5 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "trace/control.h"
 #ifdef CONFIG_TRACE_SIMPLE
 #include "trace/simple.h"
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 26c8ced1f2..980a8bbc51 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -21,7 +21,7 @@
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/util/keyval.c b/util/keyval.c
index 66a5b4740f..a70629a481 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -91,9 +91,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/keyval.h"
 #include "qemu/help_option.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index a90c18dad2..d1fc49c507 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 201f7a87f3..770300dff1 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -27,10 +27,10 @@
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f..f0aa13b5cf 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -320,7 +320,7 @@ def _begin_user_module(self, name: str) -> None:
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
 #include "%(visit)s.h"
@@ -330,7 +330,7 @@ def _begin_user_module(self, name: str) -> None:
 
         if self._gen_tracing and commands != 'qapi-commands':
             self._genc.add(mcgen('''
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 #include "trace/trace-%(nm)s_trace_events.h"
 ''',
                                  nm=c_name(commands, protect=False)))
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d1f639981a..d179b0ed69 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -194,7 +194,7 @@ def _begin_user_module(self, name: str) -> None:
 #include "%(visit)s.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp-event.h"
 ''',
                              events=events, visit=visit,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index ac14b20f30..42e5185c7c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -197,7 +197,7 @@ def visit_end(self) -> None:
         # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
-#include "qapi/qmp/qlit.h"
+#include "qobject/qlit.h"
 
 extern const QLitObject %(c_name)s;
 ''',
-- 
2.46.0


