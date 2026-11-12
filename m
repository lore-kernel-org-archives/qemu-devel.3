Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C2606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EitRCAAP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtj-0005qw-8g; Thu, 12 Nov 2026 08:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtO-0005gf-Ob
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtM-0000g1-E2
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xlLNOzl3bmgq1+SeuUCFOt3A7WepJQNcGchQbQfmnK8=;
 b=EitRCAAPHYJXVRyTp42twm0jvcEON9CpeMmZ0Vfz3wqF410ZJeVgvetiBZuPhfGNAUA3Xn
 ZcQclCYMi54VdLEahqc3nSfjPTTwXFo7u+C0p9HQAazQkPhK5DUwMIpuhOTiXETXBLQSq0
 TIFyfOrHqictaP1o4QopmoWKT//BgDM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-qHb_MuIWPz6bwcP-fK6VIA-1; Thu,
 12 Nov 2026 08:30:58 -0500
X-MC-Unique: qHb_MuIWPz6bwcP-fK6VIA-1
X-Mimecast-MFC-AGG-ID: qHb_MuIWPz6bwcP-fK6VIA_1794490257
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BBB19775AC; Thu, 12 Nov 2026 13:30:57 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EDB01956087; Thu, 12 Nov 2026 13:30:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/48] hw: resolve QOM type conflicts in multi-target builds
Date: Thu, 12 Nov 2026 13:30:06 +0000
Message-ID: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When building a multi-target binary, QOM types from multiple targets
will be linked together. QOM types are required to have unique names
when registered, so linking multiple targets in turn requires QOM type
names to be unique across the QEMU codebase.

Global QOM type name uniqueness is a desirable property for QEMU
regardless of multi-target work, so that QEMU presents a non-ambiguous
object model to applications regardless of context.

In a multi-target binary, it is desirable to applications are able to
introspect all types linked into QEMU, when launching with '-machine
none'. Dynamic filtering of registered classes at runtime, to resolving
QOM naming conflicts is undesirable, as it requires introspection
to be repeated for each available target in order to discover the full
set of available types in a binary.

Introspection is a fairly heavy weight process due to QEMU's vast size,
so enabling introspection to be done once only for all targets will be a
very significant benefit for management applications with a multi-target
binary.

The glaring problem is that our historical design has led to multiple
targets all providing a 'virt' machine type, which leads to multiple QOM
types call 'virt-machine' which are all different.

Having a common short name "virt" is a useful characteristic for users,
but this does not imply we need to use that as the basis for primary QOM
typename. It is sufficient to have an alias called 'virt'.

In terms of implementation there are two core pieces

 * An 'Aliased' interface which can be implemented by QOM types which
   want to support type aliases.

 * A 'TargetSpecific' interface which can be implemented by QOM types
   which want to declare  they can only be used with a subset of targets.

With those foundational pieces

 * Machine implements Aliased and TargetSpecific

 * query-machines reports multiple aliases and declared supported
   targets per machine for introspection

 * All the 'virt' machines are renamed to $target-virt, and aliases
   added for the shorter 'virt' names to retain compatibility and
   convenience when a target is selected

 * All the machines which have 'is_available' set now report their
   targets via the TargetSpecific  interface

 * Creating machines validates declared targets from TargetSpecific

An apparent design mistake in TYPE_ACCEL_CPU is resolved which allows
removal of the is_available hooks from target specific CPU impls, which
were working around the bug.

The original proposed patches to unconditionally register some object
properties is pulled in.

Overall this brings us closer to having a single unified object model
across all targets, without having to make runtime variations of what
is exposed/reported by a given QOM class name.

Daniel P. Berrangé (43):
  iotests: better heuristics to find I/O tests build/source dirs
  qom: define a TargetSpecific interface
  qom: define an Aliased interface
  hw: tweak approach to setting alias in machine macros
  hw/core: implement TYPE_ALIASED interface in machines
  qapi: report multiple aliases in MachineInfo
  system: report multiple machine aliases in help output
  system: increase space for machine name in '-machine help'
  system: resolve multiple aliases when creating machines
  qapi: deprecate 'alias' field in MachineInfo
  hw/arm: convert machines to use AliasedClass interface
  hw/avr: convert machines to use AliasedClass interface
  hw/hexagon: convert machines to use AliasedClass interface
  hw/i386: convert machines to use AliasedClass interface
  hw/loongarch: convert machines to use AliasedClass interface
  hw/m68k: convert machines to use AliasedClass interface
  hw/ppc: convert machines to use AliasedClass interface
  hw/s390x: convert machines to use AliasedClass interface
  include/hw: convert machine docs to use AliasedClass interface
  hw: drop 'alias' field from MachineClass
  hw/arm: rename the 'virt' machines to 'arm-virt'
  hw/riscv: rename the 'virt' machines to 'riscv-virt'
  hw/hexagon: rename the 'virt' machine to 'hexagon-virt'
  hw/loongarch: rename the 'virt' machine to 'loongarch-virt'
  hw/m68k: rename the 'virt' machine to 'm68k-virt'
  hw/or1k: rename the 'virt' machine to 'or1k-virt'
  hw/xtensa: rename the 'virt' machine to 'xtensa-virt'
  system: stop sorting machine names based on 'family'
  system: put machine aliases in alphbetical order
  system: filter machine type list if a target is selected
  hw/core: filter machine type list if a target is selected
  system: filter machines based on target during creation
  hw/core: implement TYPE_TARGET_SPECIFIC for machine
  qapi: report target compatibility for machine types
  hw/arm: declare arm machine targets
  hw/hexagon: declare hexagon machine target
  hw/m68k: declare m68k machine target
  hw/or1k: declare or1k machine target
  hw/riscv: declare riscv machine target
  accel: make TYPE_ACCEL_CPU name target independent
  Revert "multi-target: restrict whpx-accel-*-cpu to matching target"
  Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
    targets"
  qom: drop the 'is_available' callback from TypeInfo

Pierrick Bouvier (1):
  Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
    targets"

Yonggang Luo (4):
  target-info: add target_mask_selected()
  hw/pci: unconditionally expose the 'loadparm' property
  hw/scsi: unconditionally expose the 'loadparm' property
  hw/virtio/virtio-mem: unconditionally expose 'unplugged-inaccessible'

 accel/accel-common.c             |   3 +-
 accel/whpx/whpx-common.c         |   8 --
 docs/about/deprecated.rst        |   7 ++
 hw/arm/aspeed_ast27x0-fc.c       |   5 +-
 hw/arm/aspeed_ast27x0_evb.c      |  14 ++-
 hw/arm/raspi.c                   |   9 +-
 hw/arm/raspi4b.c                 |   6 +-
 hw/arm/virt.c                    |  43 +++++++--
 hw/arm/xlnx-versal-virt.c        |   7 +-
 hw/avr/arduino.c                 |  30 +++++-
 hw/core/machine-qmp-cmds.c       |  52 ++++++++++-
 hw/core/machine.c                |   5 +
 hw/hexagon/hexagon_dsp.c         |   7 +-
 hw/hexagon/virt.c                |  11 ++-
 hw/i386/pc_piix.c                |  25 ++++-
 hw/i386/pc_q35.c                 |  20 +++-
 hw/loongarch/virt.c              |  39 ++++++--
 hw/m68k/virt.c                   |  46 +++++++---
 hw/or1k/virt.c                   |  14 ++-
 hw/pci/pci.c                     |  18 ++--
 hw/ppc/pnv.c                     |   7 +-
 hw/ppc/spapr.c                   |  31 ++++---
 hw/riscv/virt.c                  |  14 ++-
 hw/s390x/s390-virtio-ccw.c       |  24 +++--
 hw/scsi/scsi-disk.c              |  18 ++--
 hw/virtio/virtio-mem.c           |  12 +--
 hw/xtensa/virt.c                 |   9 +-
 include/accel/accel-cpu-target.h |   3 +-
 include/accel/accel-cpu.h        |   2 +
 include/hw/arm/virt.h            |   2 +-
 include/hw/core/boards.h         |  29 ++++--
 include/hw/hexagon/virt.h        |   2 +-
 include/hw/i386/pc.h             |   5 +-
 include/hw/loongarch/virt.h      |   2 +-
 include/hw/riscv/virt.h          |   2 +-
 include/qemu/target-info-init.h  |  15 ++-
 include/qemu/target-info.h       |   9 ++
 include/qom/object.h             |   3 -
 include/qom/object_interfaces.h  | 152 +++++++++++++++++++++++++++++++
 meson.build                      |   1 +
 qapi/machine.json                |  19 +++-
 qom/object.c                     |   4 -
 qom/object_interfaces.c          |  88 ++++++++++++++++++
 rust/qom/src/qom.rs              |   1 -
 stubs/meson.build                |   1 +
 stubs/target-mask-selected.c     |  13 +++
 system/vl.c                      | 115 ++++++++++++-----------
 target-info-def.c                |   3 +
 target-info-qom.c                |  10 ++
 target/riscv/kvm/kvm-cpu.c       |   2 -
 target/riscv/tcg/tcg-cpu.c       |   1 -
 tests/qemu-iotests/check         |  52 ++++++++---
 52 files changed, 804 insertions(+), 216 deletions(-)
 create mode 100644 stubs/target-mask-selected.c

-- 
2.56.1


