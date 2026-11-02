Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839E606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xec14YVu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwyc-0004yg-N7; Mon, 02 Nov 2026 13:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNwyZ-0004xe-Sv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 13:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNwyX-000688-7U
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 13:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793644903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y8PEDYyaJrlZ3Kal/npxKzAfArgdbzF7XKg0e/y4qQs=;
 b=Xec14YVu+99Ci/8pcvk1/l/S1dqMGuUnQN48KAH2JM6eBIMpjBqcA8ooTlS+/P006na+UE
 cIgWlLuf/3l3i3fKCmhf1Qc8NRaAo3lrejsUroxePJXW2+7pFhAwEuu5VmDQPWZW4zRr+e
 +33A4gCo4u2HB71Bvb7rILaJ3A7ZTKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-8xmZ_fkBOZiuUUOmlpEkLg-1; Mon,
 02 Nov 2026 13:41:41 -0500
X-MC-Unique: 8xmZ_fkBOZiuUUOmlpEkLg-1
X-Mimecast-MFC-AGG-ID: 8xmZ_fkBOZiuUUOmlpEkLg_1793644901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC3B3180AAB4; Mon,  2 Nov 2026 18:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FE481955F06; Mon,  2 Nov 2026 18:41:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6E7521E6A04; Mon, 02 Nov 2026 19:41:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 00/74] QAPI patches for 2026-11-02
Date: Mon,  2 Nov 2026 19:41:36 +0100
Message-ID: <20261102184137.3310251-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-02-v2

for you to fetch changes up to 861eb824ca6a6ac031e82d27c483f3828d2b5048:

  tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema (2026-11-02 19:35:21 +0100)

----------------------------------------------------------------
QAPI patches for 2026-11-02

----------------------------------------------------------------
Daniel P. Berrangé (8):
      qapi: make 'CompatPolicy' the first arg in compat_policy_input_ok
      qapi: add 'warn' option to CompatPolicyInput
      qapi: rename 'insecure-types' to 'insecure-input'
      qapi: drop CompatPolicySecurity and use CompatPolicyInput
      qapi: rename compat_policy_check_security method
      qapi: reverse arg order in compat_policy_security_ok
      qemu-options: document -compat insecure-input parameter
      qapi: print a message before aborting for -compat violations

John Snow (1):
      qapi/control: Turn the reference to qmp-spec.rst into a link

Marc-André Lureau (46):
      qapi: add QAPITypeInfo struct definition
      qapi/gen: fix _module_basename for multi-dash 'what' parameters
      qapi: add type-infos generator
      qom: add qapi_type field to ObjectProperty
      qapi/qom: add qapi-type to qom-list, qom-list-properties, qom-list-get
      qom/qmp: populate qapi-type in QMP handlers
      qom/qmp: populate description & default-value in qom_property_info()
      tests: update check-qom-proplist for QAPI-aware property registration
      qom: convert QAPI enum properties to QAPI-aware registration
      qom: convert struct properties to QAPI-aware registration
      x86: convert OnOffAuto properties to QAPI-aware registration
      microvm: convert OnOffAuto properties to QAPI-aware registration
      pc: convert OnOffAuto vmport property to QAPI-aware registration
      arm/virt: convert OnOffAuto acpi property to QAPI-aware registration
      riscv/virt: convert OnOffAuto properties to QAPI-aware registration
      loongarch/virt: convert OnOffAuto properties to QAPI-aware registration
      hostmem: convert OnOffAuto rom property to QAPI-aware registration
      sev: convert OnOffAuto legacy-vm-type property to QAPI-aware registration
      whpx: convert OnOffAuto hyperv property to QAPI-aware registration
      whpx: convert OnOffAuto arch properties to QAPI-aware registration
      accel/kvm: convert OnOffSplit property to QAPI-aware registration
      whpx: convert OnOffSplit property to QAPI-aware registration
      ppc/spapr-caps: convert to QAPI-aware property registration
      net/colo-compare: fix compare_timeout setter visitor type
      net/colo-compare: fix max_queue_size setter visitor type
      hw/misc/xlnx-versal-trng: add missing getter for fips-fault-events
      qom: convert scalar properties to QAPI-aware registration
      i386/cpu: convert strList property to QAPI-aware registration
      accel/hvf: convert OnOffSplit property to QAPI-aware registration
      i386/x86: convert SgxEPCList property to QAPI-aware registration
      virtio-balloon: convert guest-stats property to QAPI type
      qom: replace object_property_add_tm with StructTm QAPI type
      hw/nvdimm: convert UUID property to QAPI-aware registration
      hw/s390-virtio-ccw: convert loadparm property to QAPI-aware registration
      hw/ppc/spapr_drc: convert fdt property to QAPI-aware registration
      hw/s390x: convert BootCertificatesList to QAPI-aware registration
      qdev: add qapi_type field to PropertyInfo with fallback registration
      qdev: convert core PropertyInfo definitions to use qapi_type
      qdev: convert system PropertyInfo definitions to use qapi_type
      hw: convert device-local PropertyInfo definitions to use qapi_type
      target/riscv: convert PropertyInfo definitions to use qapi_type
      qdev: convert PropertyInfo definitions to use qapi_type
      qdev: PropertyInfo.enum_table is no longer used, drop
      hw/i386: convert PCSouthBridgeOption to QAPI enum
      qom: use QAPITypeInfo in object_property_get_enum
      tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema

Markus Armbruster (19):
      qapi/machine: Drop misleading (for OptsVisitor) doc
      qga/qapi-schema: Drop "This is a read-only operation"
      qga/qapi-schema: Deemphasize numeric @whence in guest-file-seek
      qapi/acpi-hest: Fix markup of heading
      qapi: Fix inaccurate comment on pragma member-name-exceptions
      qapi/compat: Fix inaccurate CompatPolicy introduction
      qapi/compat: Fix "only syntactic aspects of QMP" note
      rng: Remove deprecated "rng-backend" property "opened"
      qapi/schema: Rename .lookup_entity() and tighten return type
      qapi: Ease access to introspection names
      qapi/introspect: Simplify masked name comment emission slighly
      qapi/introspect: Don't elide types
      qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
      qapi/introspect: Tweak integer type masking
      qom: New object_property_add() etc. parameter @qapi_type
      qom/object: Move enum property code so it is together
      qom: New object_property_add_enum() etc. parameter @qapi_type
      hw/ufs: Convert PropertyInfo to QAPITypeInfo
      qom: Drop object_property_add_enum() parameter @lookup

 docs/devel/qapi-code-gen.rst             | 161 +++++++++++++++++-------
 docs/interop/qmp-spec.rst                |   2 +
 docs/interop/virtio-balloon-stats.rst    |  22 +---
 docs/sphinx/qapidoc.py                   |   2 +-
 docs/system/security.rst                 |   2 +-
 meson.build                              |   1 +
 qapi/acpi-hest.json                      |   3 +-
 qapi/common.json                         |  57 +++++++++
 qapi/compat.json                         |  44 +++----
 qapi/control.json                        |   3 +-
 qapi/machine.json                        | 105 +++++++++++++++-
 qapi/pragma.json                         |   3 +-
 qapi/qom.json                            |  40 +++---
 qga/qapi-schema.json                     |  12 +-
 hw/ufs/ufs.h                             |  34 -----
 include/chardev/char.h                   |   3 +-
 include/hw/core/qdev-properties.h        |   2 +-
 include/hw/i386/pc.h                     |   4 +-
 include/qapi/compat-policy.h             |  12 +-
 include/qapi/qapi-type-info.h            |  25 ++++
 include/qom/object.h                     |  48 ++-----
 accel/hvf/hvf-all.c                      |  24 ++--
 accel/kvm/kvm-all.c                      |  33 +++--
 accel/nitro/nitro-accel.c                |   2 +
 accel/tcg/tcg-all.c                      |   7 +-
 accel/whpx/whpx-common.c                 |  48 +++----
 authz/list.c                             |   7 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  40 +++---
 backends/hostmem-memfd.c                 |  25 ++--
 backends/hostmem.c                       |  30 ++---
 backends/rng.c                           |  11 --
 backends/spdm-socket.c                   |   3 +-
 backends/tpm/tpm_util.c                  |   2 +
 block/throttle-groups.c                  |  11 +-
 chardev/char-socket.c                    |   2 +
 crypto/secret_common.c                   |   6 +-
 crypto/secret_keyring.c                  |   9 +-
 crypto/tlscreds.c                        |   6 +-
 event-loop-base.c                        |   4 +
 hw/acpi/ich9.c                           |   2 +
 hw/acpi/pci.c                            |   9 +-
 hw/arm/virt.c                            |  35 +++---
 hw/block/xen-block.c                     |   2 +
 hw/core/clock.c                          |   2 +
 hw/core/machine-qmp-cmds.c               |   4 +-
 hw/core/machine.c                        |  27 ++--
 hw/core/qdev-properties-system.c         |  69 ++++++----
 hw/core/qdev-properties.c                |  41 ++++--
 hw/cpu/core.c                            |   7 +-
 hw/cxl/cxl-host.c                        |   4 +-
 hw/gpio/aspeed_gpio.c                    |   9 +-
 hw/gpio/aspeed_sgpio.c                   |   4 +-
 hw/gpio/pca9552.c                        |   4 +-
 hw/gpio/pca9554.c                        |   3 +-
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/hexagon/hexagon_dsp.c                 |   2 +
 hw/i386/microvm.c                        |  65 ++++------
 hw/i386/pc.c                             |  39 +++---
 hw/i386/pc_piix.c                        |  56 +++------
 hw/i386/sgx-epc.c                        |   2 +
 hw/i386/x86.c                            |  92 ++++++--------
 hw/ide/ide-dev.c                         |   3 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/loongarch/virt.c                      |  73 +++++------
 hw/mem/nvdimm.c                          |   6 +-
 hw/mem/pc-dimm.c                         |   4 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   3 +-
 hw/misc/aspeed_lpc.c                     |  37 ++++--
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/xlnx-versal-trng.c               |  14 +++
 hw/net/ne2000-isa.c                      |   3 +-
 hw/nvme/ctrl.c                           |   2 +
 hw/nvme/nguid.c                          |   2 +
 hw/nvram/xlnx-bbram.c                    |   2 +
 hw/nvram/xlnx-efuse.c                    |   2 +
 hw/pci-bridge/pci_expander_bridge.c      |   3 +-
 hw/pci-host/i440fx.c                     |   5 +
 hw/pci-host/pnv_phb3.c                   |   5 +-
 hw/pci-host/pnv_phb4.c                   |   5 +-
 hw/pci-host/q35.c                        |   5 +
 hw/pci/pci.c                             |   2 +
 hw/ppc/spapr_caps.c                      |  19 ++-
 hw/ppc/spapr_drc.c                       |   7 +-
 hw/ppc/spapr_rtc.c                       |  25 +++-
 hw/remote/vfio-user-obj.c                |   4 +-
 hw/riscv/microchip_pfsoc.c               |   2 +
 hw/riscv/virt.c                          |  40 +++---
 hw/rtc/mc146818rtc.c                     |  23 +++-
 hw/s390x/ccw-device.c                    |   2 +
 hw/s390x/css.c                           |   3 +
 hw/s390x/s390-pci-bus.c                  |   2 +
 hw/s390x/s390-virtio-ccw.c               |   5 +-
 hw/s390x/sclpcpi.c                       |   8 +-
 hw/s390x/virtio-ccw-mem.c                |   2 +
 hw/sensor/adc128d818.c                   |  10 +-
 hw/sensor/adm1266.c                      |   3 +-
 hw/sensor/adm1272.c                      |   9 +-
 hw/sensor/emc141x.c                      |   9 +-
 hw/sensor/isl_pmbus_vr.c                 |  19 +--
 hw/sensor/lsm303dlhc_mag.c               |  25 ++--
 hw/sensor/max34451.c                     |   5 +-
 hw/sensor/tmp105.c                       |   3 +-
 hw/sensor/tmp421.c                       |   9 +-
 hw/ufs/ufs.c                             |  15 +--
 hw/usb/dev-storage-classic.c             |   3 +-
 hw/vfio-user/pci.c                       |   4 +-
 hw/vfio/pci-quirks.c                     |   2 +
 hw/virtio/virtio-balloon.c               |  85 +++++--------
 hw/virtio/virtio-mem-pci.c               |   2 +
 hw/virtio/virtio-mem.c                   |   7 +-
 hw/xen/xen-pvh-common.c                  |   5 +
 iothread.c                               |   9 +-
 migration/options.c                      |   3 +
 monitor/qmp.c                            |   3 +-
 net/colo-compare.c                       |  15 +--
 net/dump.c                               |   4 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |   6 +-
 qapi/qapi-util.c                         |  57 +++++----
 qapi/qapi-visit-core.c                   |   4 +-
 qapi/qmp-dispatch.c                      |   2 +-
 qapi/qobject-input-visitor.c             |   2 +-
 qom/object.c                             | 209 +++++++++++--------------------
 qom/qom-qmp-cmds.c                       |  47 ++++---
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |   5 +-
 target/arm/cpu64.c                       |  12 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |   6 +-
 target/i386/cpu.c                        |  22 ++--
 target/i386/kvm/kvm.c                    |  12 +-
 target/i386/kvm/tdx.c                    |   8 +-
 target/i386/sev.c                        |  30 ++---
 target/i386/whpx/whpx-all.c              |  83 ++++--------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  34 ++++-
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |   7 +-
 target/s390x/cpu-system.c                |   2 +
 target/s390x/cpu_models.c                |   7 +-
 target/sparc/cpu.c                       |   2 +
 tests/qtest/qmp-cmd-test.c               |  55 +++++++-
 tests/unit/check-qom-proplist.c          |  95 +++++++++++---
 tests/unit/test-qdev-global-props.c      |   7 +-
 ui/console-vc.c                          |   1 +
 ui/console.c                             |   3 +-
 ui/dbus.c                                |   8 +-
 ui/input-linux.c                         |   3 +-
 util/thread-context.c                    |   6 +-
 hw/display/apple-gfx.m                   |   2 +
 qapi/meson.build                         |   4 +
 qemu-options.hx                          |  37 +++++-
 qga/meson.build                          |   2 +
 scripts/qapi/backend.py                  |   2 +
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               |  74 +++--------
 scripts/qapi/schema.py                   |  57 +++++++--
 scripts/qapi/type_infos.py               | 149 ++++++++++++++++++++++
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 163 files changed, 1778 insertions(+), 1235 deletions(-)
 create mode 100644 include/qapi/qapi-type-info.h
 create mode 100644 scripts/qapi/type_infos.py

-- 
2.55.0


