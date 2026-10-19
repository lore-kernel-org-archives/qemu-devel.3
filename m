Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D9FCCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDY-0002HC-OK; Mon, 19 Oct 2026 10:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDG-0002CJ-RP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDC-0005Xs-R0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rlHLOtf6so1G7ZFHjsML5Xk9BO16/Bctr6uVCQYxtVo=;
 b=jDVEaSNDpNd34aQ2TLECvxruEB0zgQjhgB2Bul4mE61HhnhtTmNnKDtnFRLvw8OUedjDD/
 +MFKDOSHBbUvMytCTWKInU6FrYxbLHTB1zFCQYcK6S09GECzaB9MJgLj4Nsj4eRHbk1xPO
 D8KSXLrq91eh8hmLZ/z56dJe86IBYtc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-O3gpIYL_PMSDAVPxAoWmeA-1; Mon,
 19 Oct 2026 14:19:33 +0000
X-MC-Unique: O3gpIYL_PMSDAVPxAoWmeA-1
X-Mimecast-MFC-AGG-ID: O3gpIYL_PMSDAVPxAoWmeA_1792419572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88BA81955EA2; Mon, 19 Oct 2026 14:19:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C49CD195607F; Mon, 19 Oct 2026 14:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67DCF21E6A04; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 00/65] qom/qdev: associate properties with QAPI schema types
Date: Mon, 19 Oct 2026 16:18:24 +0200
Message-ID: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

I rewrote some QAPI infrastructure parts of Marc-André's v5.  Me
sending the result is easier, because it's already in my tree.
Marc-André's cover letter follows.

This series connects QOM and qdev properties to the QAPI type system, so
that management tools can discover the QAPI schema type of each object
property.

Today, QOM properties carry a free-form "type" string ("bool", "uint32",
"OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
on naming conventions to figure out how to interpret property values.

This series adds:
  - A new QAPITypeInfo struct that pairs a property with its QAPI schema
    type name, enum lookup table, and list-element type.

  - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
    instance for every schema-defined type, including the mapping
    between internal C names and the schema name visible to clients.

  - A "qapi-type" field in the ObjectPropertyInfo and
    ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
    when present giving clients a cross-reference into query-qmp-schema
    output.

  - Conversion of all PropertyInfo definitions from the old
    .type/.enum_table strings to the new .qapi_type pointer.

  - Replacement of the generic qdev_prop_array with typed per-element
    array PropertyInfos, removing the arrayinfo/arrayfieldsize
    indirection from struct Property.

  - Removal of the deprecated PropertyInfo.type and .enum_table fields,
    and of the old object_property_add_enum/add_tm APIs.

Along the way, a few pre-existing type mismatches in property
definitions are fixed, the "struct tm" RTC property is replaced with a
proper QAPI StructTm type etc. Introducing more specific types or a
"typedef" to QAPI could help provide better associated type informations
than plain "str" in many cases, for example.

Changes in v6:
- Rebase, resolve a few conflicts
- Replace old PATCH 03-04 by new PATCH 01-06, adjust PATCH 09 [old
  PATCH 05]
- Fix temporary build breakage: convert PCSouthBridgeOption only when
  it gets QAPIfied [PATCH 62], delay removal of old interface until
  after that [PATCH 63].
- Clean up checkpatch long line warnings, except leave the ones in
  PATCH 38 for later

Changes in v5:
- make "masked_name" mandatory, skip QType QAPITypeInfo generation
- added/split "hw/ppc/spapr_caps: fix property type name" patch
- added "qapi: select introspectable types directly", simplifying type discovery
- fixed an include path
- doc adjustments
- rebased, collect r-b trailers
- Link to v4: https://lore.kernel.org/qemu-devel/20260904-qom-qapi-v4-0-a985f168e938@redhat.com

Changes in v4:
- new patch "qom/qmp: populate description & default-value"
- added gtk-doc comments for class_property_add_qapi*()
- correct some property types to reflect the visitor
- collected rb, rebased
- Link to v3: https://lore.kernel.org/qemu-devel/20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com

Changes in v3:
- QAPI analysis redesign (replacing the old "expose name map" from
introspect)
- all non-implicit QAPI types are now introspectable, including QOM-only
types
- QAPITypeInfo.schema_name -> masked_name
- exposes integer signedness and width through query-qmp-schema
- various extra property fixes
- rebase, some patch split or merge

- Link to v2: https://lore.kernel.org/qemu-devel/20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com

Changes in v2:

- Added kernel-doc documentation for the QAPITypeInfo struct fields.
- Dropped "qom: drop free-form property typename registration", it's
  still needed for array of links to provide useful type names.
- Added qdev_prop_link_list for array-of-links properties, with a
  create function that generates "link<TYPE>List" type names matching the
  existing "link<TYPE>" convention.
- qdev_prop_link now uses &str_type_info instead of "link" (the full
  "link<TYPE>" type name is set at property-add time)
- Simplified DEFINE_PROP_LINK_ARRAY to use qdev_prop_link_list, dropping
  the now-unnecessary _arraytype parameter.
- rebased
- Link to v1: https://lore.kernel.org/qemu-devel/20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com

Marc-André Lureau (59):
  qapi: add QAPITypeInfo struct definition
  qapi/gen: fix _module_basename for multi-dash 'what' parameters
  qapi: add type-infos generator
  meson: add qapi-type-infos-*.c/h to build
  qom: add qapi_type field to ObjectProperty
  qapi/qom: add qapi-type field to ObjectPropertyInfo
  qom/qmp: populate qapi-type in QMP handlers
  qom/qmp: populate description & default-value in qom_property_info()
  qom: add object_property_set_default_enum()
  qom: add object_{class_}property_add_qapi
  qom: add object_{class_}property_add_qapi_enum
  tests: update check-qom-proplist for QAPI-aware property registration
  qom: convert QAPI enum properties to QAPI-aware registration
  qom: convert struct properties to QAPI-aware registration
  x86: convert OnOffAuto properties to QAPI-aware registration
  microvm: convert OnOffAuto properties to QAPI-aware registration
  pc: convert OnOffAuto vmport property to QAPI-aware registration
  arm/virt: convert OnOffAuto acpi property to QAPI-aware registration
  riscv/virt: convert OnOffAuto properties to QAPI-aware registration
  loongarch/virt: convert OnOffAuto properties to QAPI-aware
    registration
  hostmem-file: convert OnOffAuto rom property to QAPI-aware
    registration
  sev: convert OnOffAuto legacy-vm-type property to QAPI-aware
    registration
  whpx: convert OnOffAuto hyperv property to QAPI-aware registration
  whpx: convert OnOffAuto arch properties to QAPI-aware registration
  accel/kvm: convert OnOffSplit property to QAPI-aware registration
  whpx: convert OnOffSplit property to QAPI-aware registration
  hw/ppc/spapr_caps: fix property type name
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
  hw/s390-virtio-ccw: convert loadparm property to QAPI-aware
    registration
  hw/ppc/spapr_drc: convert fdt property to QAPI-aware registration
  hw/s390x: convert BootCertificatesList to QAPI-aware registration
  hw/gpio/pca955x: use QAPI enums for led and pin properties
  include: add QEMU_REPEAT helper macro
  hw/gpio/pca955x: convert pin/led property to QAPI-aware enum
  hw/pci: change the busnr type to uint8
  qdev: add qapi_type field to PropertyInfo with fallback registration
  qdev: convert core PropertyInfo definitions to use qapi_type
  qdev: adjust PciDevfn declared type
  qdev: convert system PropertyInfo definitions to use qapi_type
  hw: convert device-local PropertyInfo definitions to use qapi_type
  target/riscv: convert PropertyInfo definitions to use qapi_type
  qdev: convert PropertyInfo definitions to use qapi_type
  qdev: introduce typed array PropertyInfos
  qdev: simplify DEFINE_PROP_ARRAY and remove generic array PropertyInfo
  qdev: remove deprecated PropertyInfo.type and .enum_table fields
  hw/i386: convert PCSouthBridgeOption to QAPI enum
  qom: remove old enum property registration API
  qom: use QAPITypeInfo in object_property_get_enum
  tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema

Markus Armbruster (6):
  qapi/schema: Rename .lookup_entity() and tighten return type
  qapi: Ease access to introspection names
  qapi/introspect: Simplify masked name comment emission slighly
  qapi/introspect: Don't elide types
  qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
  qapi/introspect: Tweak integer type masking

 docs/devel/qapi-code-gen.rst             |  92 +++++++-
 docs/interop/virtio-balloon-stats.rst    |  22 +-
 docs/sphinx/qapidoc.py                   |   2 +-
 meson.build                              |   1 +
 qapi/common.json                         |  28 +++
 qapi/machine.json                        | 152 +++++++++++++
 qapi/pragma.json                         |   1 +
 qapi/qom.json                            |  10 +
 hw/core/qdev-prop-internal.h             |  23 ++
 hw/display/apple-gfx.h                   |   1 +
 include/chardev/char.h                   |   8 -
 include/hw/block/block.h                 |   2 +-
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |  40 ++--
 include/hw/cxl/cxl_component.h           |   5 +-
 include/hw/i386/pc.h                     |   4 +-
 include/qapi/qapi-type-info.h            |  31 +++
 include/qemu/osdep.h                     |  33 +++
 include/qemu/uuid.h                      |   4 +
 include/qom/object.h                     | 186 +++++++++++-----
 accel/hvf/hvf-all.c                      |  29 +--
 accel/kvm/kvm-all.c                      |  31 ++-
 accel/nitro/nitro-accel.c                |   3 +-
 accel/tcg/tcg-all.c                      |   3 +-
 accel/whpx/whpx-common.c                 |  58 ++---
 authz/list.c                             |  14 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  33 ++-
 backends/hostmem-memfd.c                 |   3 +-
 backends/hostmem.c                       |  20 +-
 backends/spdm-socket.c                   |   4 +-
 backends/tpm/tpm_util.c                  |   3 +-
 block/throttle-groups.c                  |  10 +-
 chardev/char-socket.c                    |   3 +-
 crypto/secret_common.c                   |  12 +-
 crypto/secret_keyring.c                  |   9 +-
 crypto/tlscreds.c                        |  12 +-
 event-loop-base.c                        |   7 +-
 hw/acpi/ich9.c                           |   1 +
 hw/acpi/pci.c                            |   7 +-
 hw/arm/virt.c                            |  31 ++-
 hw/block/xen-block.c                     |   3 +-
 hw/core/clock.c                          |   3 +-
 hw/core/machine-qmp-cmds.c               |   4 +-
 hw/core/machine.c                        |  13 +-
 hw/core/qdev-properties-system.c         |  97 ++++-----
 hw/core/qdev-properties.c                | 182 +++++++++++-----
 hw/cpu/core.c                            |  10 +-
 hw/cxl/cxl-host.c                        |   6 +-
 hw/gpio/aspeed_gpio.c                    |   5 +-
 hw/gpio/aspeed_sgpio.c                   |   3 +-
 hw/gpio/pca9552.c                        | 261 +++++++++--------------
 hw/gpio/pca9554.c                        | 157 +++++---------
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/i386/microvm.c                        |  80 +++----
 hw/i386/pc.c                             |  32 ++-
 hw/i386/pc_piix.c                        |  61 ++----
 hw/i386/sgx-epc.c                        |  10 +-
 hw/i386/x86.c                            | 113 +++++-----
 hw/ide/ide-dev.c                         |   3 +-
 hw/input/stellaris_gamepad.c             |   2 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/intc/arm_gicv5_common.c               |   4 +-
 hw/intc/rx_icu.c                         |   4 +-
 hw/loongarch/virt.c                      |  87 ++++----
 hw/mem/nvdimm.c                          |  11 +-
 hw/mem/pc-dimm.c                         |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 +-
 hw/misc/arm_sysctl.c                     |   4 +-
 hw/misc/aspeed_lpc.c                     |  73 ++++---
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/mps2-scc.c                       |   2 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/tz-ppc.c                         |  19 +-
 hw/misc/xlnx-versal-trng.c               |  15 +-
 hw/net/ne2000-isa.c                      |   3 +-
 hw/net/rocker/rocker.c                   |   2 +-
 hw/net/virtio-net.c                      |   2 +-
 hw/nvme/ctrl.c                           |   3 +-
 hw/nvme/nguid.c                          |   3 +-
 hw/nvram/xlnx-bbram.c                    |   3 +-
 hw/nvram/xlnx-efuse.c                    |   5 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c      |   3 +-
 hw/pci-host/i440fx.c                     |  29 +--
 hw/pci-host/pnv_phb3.c                   |   5 +-
 hw/pci-host/pnv_phb4.c                   |   5 +-
 hw/pci-host/q35.c                        |   9 +-
 hw/pci/pci.c                             |   3 +-
 hw/ppc/spapr_caps.c                      |  39 ++--
 hw/ppc/spapr_drc.c                       |   5 +-
 hw/ppc/spapr_rtc.c                       |  18 +-
 hw/remote/vfio-user-obj.c                |  22 +-
 hw/riscv/microchip_pfsoc.c               |   3 +-
 hw/riscv/riscv_hart.c                    |   6 +-
 hw/riscv/virt.c                          |  52 ++---
 hw/rtc/mc146818rtc.c                     |  16 +-
 hw/s390x/ccw-device.c                    |   3 +-
 hw/s390x/css.c                           |   5 +-
 hw/s390x/s390-pci-bus.c                  |   3 +-
 hw/s390x/s390-virtio-ccw.c               |  11 +-
 hw/s390x/sclpcpi.c                       |   8 +-
 hw/s390x/virtio-ccw-mem.c                |   3 +-
 hw/sensor/adc128d818.c                   |  16 +-
 hw/sensor/adm1266.c                      |   3 +-
 hw/sensor/adm1272.c                      |   9 +-
 hw/sensor/emc141x.c                      |   9 +-
 hw/sensor/isl_pmbus_vr.c                 |  19 +-
 hw/sensor/lsm303dlhc_mag.c               |   9 +-
 hw/sensor/max34451.c                     |   5 +-
 hw/sensor/tmp105.c                       |   3 +-
 hw/sensor/tmp421.c                       |   9 +-
 hw/usb/dev-storage-classic.c             |   3 +-
 hw/vfio-user/pci.c                       |   5 +-
 hw/vfio/pci-quirks.c                     |   3 +-
 hw/virtio/virtio-balloon.c               |  87 +++-----
 hw/virtio/virtio-iommu-pci.c             |   2 +-
 hw/virtio/virtio-mem-pci.c               |   3 +-
 hw/virtio/virtio-mem.c                   |  18 +-
 hw/xen/xen-pvh-common.c                  |   9 +-
 iothread.c                               |   9 +-
 migration/options.c                      |   4 +-
 monitor/qmp.c                            |  12 +-
 net/colo-compare.c                       |  15 +-
 net/dump.c                               |   6 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |  10 +-
 qom/object.c                             | 236 +++++++++-----------
 qom/qom-qmp-cmds.c                       |  47 ++--
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |   5 +-
 target/arm/cpu64.c                       |  11 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |  11 +-
 target/i386/cpu.c                        |  26 ++-
 target/i386/kvm/kvm.c                    |  38 ++--
 target/i386/kvm/tdx.c                    |   4 +-
 target/i386/sev.c                        |  31 ++-
 target/i386/whpx/whpx-all.c              | 101 +++------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  47 ++--
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |  13 +-
 target/s390x/cpu-system.c                |   4 +-
 target/s390x/cpu_models.c                |   5 +-
 target/sparc/cpu.c                       |   3 +-
 tests/qtest/qmp-cmd-test.c               |  55 ++++-
 tests/unit/check-qom-proplist.c          |  99 +++++++--
 tests/unit/test-qdev-global-props.c      |  11 +-
 tests/unit/test-qdev.c                   |   2 +-
 ui/console-vc.c                          |   8 +-
 ui/console.c                             |   3 +-
 ui/dbus.c                                |  18 +-
 ui/input-linux.c                         |  11 +-
 util/thread-context.c                    |   7 +-
 util/uuid.c                              |   5 +
 hw/display/apple-gfx-mmio.m              |   2 +-
 hw/display/apple-gfx-pci.m               |   2 +-
 hw/display/apple-gfx.m                   |   7 +-
 qapi/meson.build                         |   4 +
 qga/meson.build                          |   2 +
 scripts/qapi/backend.py                  |   2 +
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               |  74 ++-----
 scripts/qapi/schema.py                   |  57 ++++-
 scripts/qapi/type_infos.py               | 163 ++++++++++++++
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 170 files changed, 2304 insertions(+), 1628 deletions(-)
 create mode 100644 include/qapi/qapi-type-info.h
 create mode 100644 scripts/qapi/type_infos.py

-- 
2.55.0


