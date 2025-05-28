Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D4FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZk-0002bI-K6; Wed, 28 May 2025 14:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZV-0002MB-TG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZL-00071q-OP
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jbyjZxxaAUVh41vjvoPNgeKxdedSNQw+vJHgyay37to=;
 b=ZRCQkCY0GjtBS8i1xGN2BTioHX1mmB8dJCnFRSPFhNP+AO6w1Be2VqWJH2Mk3ha1cMOoIY
 yt30MUou9f1JGIXtI8LwkCwn4wCIIygyMnHWsxmUUBtOVA5ejYTE223cr1WumZhFQB5bXD
 bRP5VhIQBDGPDeW6BarJEwwJHxKbdYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-o5sT6JhaOLCURXK4pio2vw-1; Wed,
 28 May 2025 14:31:56 -0400
X-MC-Unique: o5sT6JhaOLCURXK4pio2vw-1
X-Mimecast-MFC-AGG-ID: o5sT6JhaOLCURXK4pio2vw_1748457114
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FF351956089
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4690D19560B3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CB7C21E6768; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/13] QAPI patches patches for 2025-05-28
Date: Wed, 28 May 2025 20:31:38 +0200
Message-ID: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:

  Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-05-28

for you to fetch changes up to e1a80c3241631ee0e7a687a54f71407b6d3828b7:

  qapi: use imperative style in documentation (2025-05-28 18:59:12 +0200)

----------------------------------------------------------------
QAPI patches patches for 2025-05-28

----------------------------------------------------------------
Daniel P. Berrangé (9):
      qapi: expose rtc-reset-reinjection command unconditionally
      qapi: expand docs for SEV commands
      qapi: make SEV commands unconditionally available
      qapi: expose query-gic-capability command unconditionally
      qapi: make SGX commands unconditionally available
      qapi: make Xen event commands unconditionally available
      qapi: remove the misc-target.json file
      qapi: make most CPU commands unconditionally available
      qapi: make s390x specific CPU commands unconditionally available

Philippe Mathieu-Daudé (1):
      qapi: Make CpuModelExpansionInfo::deprecated-props optional and generic

Pierrick Bouvier (3):
      qapi: remove qapi_specific_outputs from meson.build
      qapi: make all generated files common
      qapi: use imperative style in documentation

 MAINTAINERS                               |   1 -
 qapi/audio.json                           |   2 +-
 qapi/block.json                           |   2 +-
 qapi/char.json                            |   4 +-
 qapi/control.json                         |   2 +-
 qapi/cryptodev.json                       |   2 +-
 qapi/dump.json                            |   2 +-
 qapi/machine-s390x.json                   | 121 +++++++
 qapi/machine-target.json                  | 523 ------------------------------
 qapi/machine.json                         | 371 ++++++++++++++++++++-
 qapi/migration.json                       |  10 +-
 qapi/misc-arm.json                        |  49 +++
 qapi/{misc-target.json => misc-i386.json} | 165 ++++------
 qapi/misc.json                            |   2 +-
 qapi/qapi-schema.json                     |   5 +-
 qapi/ui.json                              |  10 +-
 qapi/virtio.json                          |   2 +-
 include/hw/s390x/cpu-topology.h           |   2 +-
 hw/i386/kvm/xen-stubs.c                   |  13 -
 hw/i386/kvm/xen_evtchn.c                  |   2 +-
 hw/i386/monitor.c                         |   2 +-
 hw/i386/sgx-stub.c                        |   2 +-
 hw/i386/sgx.c                             |   2 +-
 hw/s390x/cpu-topology.c                   |   4 +-
 hw/s390x/s390-skeys.c                     |   1 -
 stubs/monitor-arm-gic.c                   |  12 +
 stubs/monitor-cpu-s390x-kvm.c             |  22 ++
 stubs/monitor-cpu-s390x.c                 |  23 ++
 stubs/monitor-cpu.c                       |  21 ++
 stubs/monitor-i386-rtc.c                  |  12 +
 stubs/monitor-i386-sev.c                  |  36 ++
 stubs/monitor-i386-sgx.c                  |  17 +
 stubs/monitor-i386-xen.c                  |  16 +
 target/arm/arm-qmp-cmds.c                 |   4 +-
 target/i386/cpu-system.c                  |   2 +-
 target/i386/cpu.c                         |   2 +-
 target/i386/monitor.c                     |   1 -
 target/i386/sev-system-stub.c             |  32 --
 target/i386/sev.c                         |   2 +-
 target/loongarch/loongarch-qmp-cmds.c     |   2 +-
 target/mips/system/mips-qmp-cmds.c        |  12 +-
 target/ppc/ppc-qmp-cmds.c                 |  12 +-
 target/riscv/riscv-qmp-cmds.c             |   2 +-
 target/s390x/cpu_models_system.c          |   2 +-
 tests/qtest/qmp-cmd-test.c                |   1 +
 qapi/meson.build                          |  33 +-
 stubs/meson.build                         |   8 +
 47 files changed, 842 insertions(+), 733 deletions(-)
 create mode 100644 qapi/machine-s390x.json
 delete mode 100644 qapi/machine-target.json
 create mode 100644 qapi/misc-arm.json
 rename qapi/{misc-target.json => misc-i386.json} (75%)
 create mode 100644 stubs/monitor-arm-gic.c
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c
 create mode 100644 stubs/monitor-cpu-s390x.c
 create mode 100644 stubs/monitor-cpu.c
 create mode 100644 stubs/monitor-i386-rtc.c
 create mode 100644 stubs/monitor-i386-sev.c
 create mode 100644 stubs/monitor-i386-sgx.c
 create mode 100644 stubs/monitor-i386-xen.c

-- 
2.48.1


