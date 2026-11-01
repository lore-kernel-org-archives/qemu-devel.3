Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOfG9Aqb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzz-000587-4T; Sun, 01 Nov 2026 15:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0004qa-DI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzY-000796-G3
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tXC+uFyZxl4OoOt0FW672Bkxtp7o8pJ84GN1qi9ba3k=;
 b=MOfG9AqbW3f+UOF8zsGPjGSPdyixczHErdHEqpxixmlfvptdBr2ndGR54GhlhJYD8xs6dG
 HoJK2DiQEinmK8Qd51Z5mrcWSRF7RET966CEM1oIopNb3ngdckUbwShSsCQca7yvM/27yu
 SNF8DQGbUqEr7EuDdDZQ5iT0vPRJ68s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-X3vmJ1AOMqOZncTwhQO9Ig-1; Sun,
 01 Nov 2026 15:17:21 -0500
X-MC-Unique: X3vmJ1AOMqOZncTwhQO9Ig-1
X-Mimecast-MFC-AGG-ID: X3vmJ1AOMqOZncTwhQO9Ig_1793564240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8341B1955BFE
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E62861956088
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92E7121E6A04; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 RESEND 00/56] qom/qdev: associate properties with QAPI
 schema types
Date: Sun,  1 Nov 2026 21:16:21 +0100
Message-ID: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This is a bigger change from v7 than I'd like, but it gets us to
something I'm willing to merge late in the development cycle.  In this
version:

1. The new @qapi-type in output of qom-list, qom-list-get,
   qom-list-properties is marked unstable.  See thread

    Subject: ObjectPropertyInfo design (was: [PATCH v7 00/65] Hi)
    Date: Thu, 22 Oct 2026 16:04:44 +0200
    Message-ID: <87ik2tj0g3.fsf@pond.sub.org>

2. No changes to @type values in output of qom-list, qom-list-get,
   qom-list-properties.  The changed values are not enough of an
   improvement to be worth the risk and the churn.

3. Less code churn:
   v7: 170 files changed, 2317 insertions(+), 1628 deletions(-)
   v8: 148 files changed, 1638 insertions(+), 1067 deletions(-)

Changes in v8:

* PATCH 11: Mark new qapi-type unstable.  While there, improve commit
  message to better explain why we're doing this.

* Drop typed array PropertyInfos

  Why?  They complicate matters, and I ran out of time.

  - PATCH 07+09: Drop QAPITypeInfo member @list.

  - PATCH 09: Doc adjustment.

  - Old PATCH 59-60: Drop.

  - PATCH 52: Drop only PropertyInfo member @enum_table.  Commit
    message adjusted accordingly.

* Extend object_property_try_add(), object_property_add(),
  object_class_property_add_enum() instead of adding _add_qapi
  variants.  Avoid changing values of ObjectPropertyInfo /
  ObjectPropertyValue member @type.

  - PATCH 09: Doc adjustment.

  - PATCH 14-16: New, replacing old PATCH 16-17.

  - PATCH 17-32,36-45,53: Adjust the conversions, and where
    appropriate their commit messages.

  - Old PATCH 19: Drop, because the above removed the new helper's
    only use.

  - PATCH 32: Keep SpaprCapabilityInfo member @type, name new member
    @qapi_type instead of @type.

  - PATCH 46: Simplify, adjust commit message accordingly.

  - PATCH 47-51: Keep PropertyInfo member @type, adjust commit
    messages accordingly.

  - PATCH 54: New, replacing old PATCH 63.

* Avoid other changes to values of ObjectPropertyInfo /
  ObjectPropertyValue member @type.

  - Old PATCH 33,48-51,54: Drop.

  - PATCH 48: Add a comment to qdev_prop_pci_devfn.

* Missing conversions

  - PATCH 26: Property "guest-memfd" in backends/hostmem-memfd.c.
    Commit message adjusted.

  - PATCH 36: Property ACPI_PM_PROP_GPE0_BLK in hw/acpi/ich9.c,
    "subsystem-base" in hw/hexagon/hexagon_dsp.c, "socket" in
    hw/remote/vfio-user-obj.c, "policy" and "tsc-frequency" in
    target/i386/sev.c.

  - PATCH 36: object_class_property_add_bool_ptr(),
    object_class_property_add_uint8_ptr()
    object_class_property_add_uint16_ptr(),
    object_class_property_add_uint32_ptr(),
    object_class_property_add_uint64_ptr().

  - This list may not be complete.

* Miscellaneous minor stuff

  - PATCH 02-04,09: Update docs/devel/qapi-code-gen.rst examples.

  - PATCH 07: Comment tweaked.

  - PATCH 09: Explain why modular in commit message.

  - Old PATCH 10 squashed into 09.

  - PATCH 36: Use &uint32_type_info qapi-type with "uint64_t" type,
    not &size_type_info, to keep the patch mechanical.

  - PATCH 40+41+53: QAPI schema comments tweaked.

  - PATCH 40: Move assertion to a more logical place.

  - PATCH 55: Exploit all enums have non-null @qapi_type.

Marc-André's cover letter for v7:

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

Changes in v7:
- fixed a few more mis-typed list properties
- use designated initializers for StructTm fields
- assert enum get() returns >= or an error
- a few commit message and code comment tweaks
- rebased, add r-b trailers

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
  loongarch/virt: convert OnOffAuto properties to QAPI-aware
    registration
  hostmem: convert OnOffAuto rom property to QAPI-aware registration
  sev: convert OnOffAuto legacy-vm-type property to QAPI-aware
    registration
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
  hw/s390-virtio-ccw: convert loadparm property to QAPI-aware
    registration
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

Markus Armbruster (10):
  qapi/schema: Rename .lookup_entity() and tighten return type
  qapi: Ease access to introspection names
  qapi/introspect: Simplify masked name comment emission slighly
  qapi/introspect: Don't elide types
  qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
  qapi/introspect: Tweak integer type masking
  qom: New object_property_add() etc. parameter @qapi_type
  qom/object: Move enum property code so it is together
  qom: New object_property_add_enum() etc. parameter @qapi_type
  qom: Drop object_property_add_enum() parameter @lookup

 docs/devel/qapi-code-gen.rst             | 161 +++++++++++++-----
 docs/interop/virtio-balloon-stats.rst    |  22 +--
 docs/sphinx/qapidoc.py                   |   2 +-
 meson.build                              |   1 +
 qapi/common.json                         |  27 +++
 qapi/machine.json                        | 101 ++++++++++++
 qapi/pragma.json                         |   1 +
 qapi/qom.json                            |  18 ++
 include/chardev/char.h                   |   3 +-
 include/hw/core/qdev-properties.h        |   2 +-
 include/hw/i386/pc.h                     |   4 +-
 include/qapi/qapi-type-info.h            |  25 +++
 include/qom/object.h                     |  48 ++----
 accel/hvf/hvf-all.c                      |  24 +--
 accel/kvm/kvm-all.c                      |  33 ++--
 accel/nitro/nitro-accel.c                |   2 +
 accel/tcg/tcg-all.c                      |   7 +-
 accel/whpx/whpx-common.c                 |  48 ++----
 authz/list.c                             |   7 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  40 ++---
 backends/hostmem-memfd.c                 |  25 ++-
 backends/hostmem.c                       |  30 ++--
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
 hw/arm/virt.c                            |  35 ++--
 hw/block/xen-block.c                     |   2 +
 hw/core/clock.c                          |   2 +
 hw/core/machine-qmp-cmds.c               |   4 +-
 hw/core/machine.c                        |  27 +--
 hw/core/qdev-properties-system.c         |  69 +++++---
 hw/core/qdev-properties.c                |  41 ++++-
 hw/cpu/core.c                            |   7 +-
 hw/cxl/cxl-host.c                        |   4 +-
 hw/gpio/aspeed_gpio.c                    |   9 +-
 hw/gpio/aspeed_sgpio.c                   |   4 +-
 hw/gpio/pca9552.c                        |   4 +-
 hw/gpio/pca9554.c                        |   3 +-
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/hexagon/hexagon_dsp.c                 |   2 +
 hw/i386/microvm.c                        |  65 +++-----
 hw/i386/pc.c                             |  39 +++--
 hw/i386/pc_piix.c                        |  56 ++-----
 hw/i386/sgx-epc.c                        |   2 +
 hw/i386/x86.c                            |  92 ++++-------
 hw/ide/ide-dev.c                         |   3 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/loongarch/virt.c                      |  73 ++++-----
 hw/mem/nvdimm.c                          |   6 +-
 hw/mem/pc-dimm.c                         |   4 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   3 +-
 hw/misc/aspeed_lpc.c                     |  37 +++--
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/xlnx-versal-trng.c               |  14 ++
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
 hw/ppc/spapr_rtc.c                       |  25 ++-
 hw/remote/vfio-user-obj.c                |   4 +-
 hw/riscv/microchip_pfsoc.c               |   2 +
 hw/riscv/virt.c                          |  40 ++---
 hw/rtc/mc146818rtc.c                     |  23 ++-
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
 hw/sensor/isl_pmbus_vr.c                 |  19 ++-
 hw/sensor/lsm303dlhc_mag.c               |  25 +--
 hw/sensor/max34451.c                     |   5 +-
 hw/sensor/tmp105.c                       |   3 +-
 hw/sensor/tmp421.c                       |   9 +-
 hw/usb/dev-storage-classic.c             |   3 +-
 hw/vfio-user/pci.c                       |   4 +-
 hw/vfio/pci-quirks.c                     |   2 +
 hw/virtio/virtio-balloon.c               |  85 ++++------
 hw/virtio/virtio-mem-pci.c               |   2 +
 hw/virtio/virtio-mem.c                   |   7 +-
 hw/xen/xen-pvh-common.c                  |   5 +
 iothread.c                               |   9 +-
 migration/options.c                      |   3 +
 monitor/qmp.c                            |   3 +-
 net/colo-compare.c                       |  15 +-
 net/dump.c                               |   4 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |   6 +-
 qom/object.c                             | 199 ++++++++---------------
 qom/qom-qmp-cmds.c                       |  47 +++---
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |   5 +-
 target/arm/cpu64.c                       |  12 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |   6 +-
 target/i386/cpu.c                        |  22 ++-
 target/i386/kvm/kvm.c                    |  12 +-
 target/i386/kvm/tdx.c                    |   8 +-
 target/i386/sev.c                        |  30 ++--
 target/i386/whpx/whpx-all.c              |  83 +++-------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  34 +++-
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |   7 +-
 target/s390x/cpu-system.c                |   2 +
 target/s390x/cpu_models.c                |   7 +-
 target/sparc/cpu.c                       |   2 +
 tests/qtest/qmp-cmd-test.c               |  55 ++++++-
 tests/unit/check-qom-proplist.c          |  95 +++++++++--
 tests/unit/test-qdev-global-props.c      |   7 +-
 ui/console-vc.c                          |   1 +
 ui/console.c                             |   3 +-
 ui/dbus.c                                |   8 +-
 ui/input-linux.c                         |   3 +-
 util/thread-context.c                    |   6 +-
 hw/display/apple-gfx.m                   |   2 +
 qapi/meson.build                         |   4 +
 qga/meson.build                          |   2 +
 scripts/qapi/backend.py                  |   2 +
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               |  74 +++------
 scripts/qapi/schema.py                   |  57 +++++--
 scripts/qapi/type_infos.py               | 149 +++++++++++++++++
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 148 files changed, 1638 insertions(+), 1067 deletions(-)
 create mode 100644 include/qapi/qapi-type-info.h
 create mode 100644 scripts/qapi/type_infos.py

-- 
2.55.0


