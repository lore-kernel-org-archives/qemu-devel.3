Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E2C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHj8-0002TA-NZ; Tue, 18 Aug 2026 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHj6-0002Si-R7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHj4-0004kI-E9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VKbIRM+a2FlPfzjUnBHUuWfllVE6sHymUaS0Uq7p2NM=;
 b=Vm5wGUlod4pcfnmYssLrKbDAmwCo9Bv9/XA1kziItrr67FcPMxwI9by6hKilrkqTu6YsBs
 WuP9J689cA7mfmJl+hX1NYYeBbfEkdcx/OFQWZqkvxSjSyNSvu7TENPz7A2/1F0hO0k5Cf
 WgiEHgOgvcdkyJlilqZ2ywrS2N4wapo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-c_JntiMCMn-Sb2VKsnYEqw-1; Tue,
 18 Aug 2026 07:11:20 -0400
X-MC-Unique: c_JntiMCMn-Sb2VKsnYEqw-1
X-Mimecast-MFC-AGG-ID: c_JntiMCMn-Sb2VKsnYEqw_1787051479
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD23B1954ADD; Tue, 18 Aug 2026 11:11:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FBD130002E9; Tue, 18 Aug 2026 11:10:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/74] qom/qdev: associate properties with QAPI schema types
Date: Tue, 18 Aug 2026 15:10:27 +0400
Message-Id: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBQFr9KwFgPUktaV9zAu4PdjMWlpoRJN0
 7sLdaEmLid5M28hAb3FQI7FQjxGG6wbEpS7gkCnhitS2yYmggnJKs7o5Ho6qdFSo5GZikkGpSF
 pPno09rGlzpc3h7u+IczZz4vOhtn55/YVed79yUZOGT3UWknFFTeqOnlsOzXvwfUkd6P4mJLLL
 1MkE6ApG6kb4DX8mOu6vgCyvDw37QAAAA==
X-Change-ID: 20260510-qom-qapi-fbe0f5060c3f
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=17690;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R3D61QSpzvkq2eaL5Vc6t2+SMjih2wwD1EcCLPB9uyg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD21uRfBf5e/pczChdSW5uRqoxtFMZRKun/SI
 2MhU9bM8iSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9tQAKCRDa6OEJdZac
 5Sw1D/4tFgDDpzXqhx8vX1Z2r1JR51/L5eqVGLTQaxKeuMIBQtTDsb6s31Cox7HCCsE5m/8gEyL
 gkcqTnIl+Zyw76/GLR2UbTEgHPJk+HvkGRiAXrY9KpQCfdTs3L3yY6Bq1mi68t0W94T3jg92BD+
 eAPpD3j0+fGt7EhvcwbUGPqcIv7Eq9nChv3a0NpZC+gf/XYORJ9+pSv8HujnHh0u54Q0MRQ+iOt
 YHAiSpFpBEgdEPMPvR8UOLuoqWosJxPXyLiRCJidVMF+kmcxVnr3bXYn5kGe94NH4Z2XxNgV9+u
 sawpDpntRqDeIx5gSEjo+zEzKrmKO8E8VYprevjo0HI/emmL74lPmols9EXSVhC5ARRMoR1rJpu
 Cnat+4xHGZVGS8ifF/zI27MPH/On7SeAk4ryUTw5MD2XPRsHQYXJmuRHUJ1JZaOrRvDMUWcHk14
 3OeDqKHQjtVj69F0cMfN4Ovqb2gVaZsJfrcsG0ZimqZKQy7sAsCrnl3z+Hql+Zg1ktrPW05+B6z
 zZxfyXoHr3yFHOFjgglj26/VWRXYzYGjoYVPYWRq3+oKEW8JJiV2ia5La8E5Tv/2LHyrMierkly
 aP7MN2Z8l1Nf5a2bUrEOx3lYopBbr/56E1CdoY4qRoQcOyEffDDdE8eRVMVoMzO0Ko9efcrFU7B
 Jf9MUzOiMco/v9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Hi,

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

Comments welcome!

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
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

To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>

---
Marc-André Lureau (74):
      qapi: add QAPITypeInfo struct definition
      qapi/gen: fix _module_basename for multi-dash 'what' parameters
      qapi: factor out QAPISchemaUsedTypes from introspect visitor
      qapi: register all introspectable types, not just QMP-reachable ones
      qapi: add type-infos generator
      meson: add qapi-type-infos-*.c/h to build
      qom: add qapi_type field to ObjectProperty
      qapi/qom: add qapi-type field to ObjectPropertyInfo
      qom/qmp: populate qapi-type in QMP handlers
      qom: add object_property_set_default_enum()
      qom: add object_{class_}property_add_qapi
      qom: add object_{class_}property_add_qapi_enum
      tests: update check-qom-proplist for QAPI-aware property registration
      qom: convert enum properties to QAPI-aware registration
      qom: remove old enum property registration API
      qom: convert struct properties to QAPI-aware registration
      x86: convert OnOffAuto properties to QAPI-aware registration
      microvm: convert OnOffAuto properties to QAPI-aware registration
      pc: convert OnOffAuto vmport property to QAPI-aware registration
      arm/virt: convert OnOffAuto acpi property to QAPI-aware registration
      riscv/virt: convert OnOffAuto properties to QAPI-aware registration
      loongarch/virt: convert OnOffAuto properties to QAPI-aware registration
      hostmem-file: convert OnOffAuto rom property to QAPI-aware registration
      sev: convert OnOffAuto legacy-vm-type property to QAPI-aware registration
      whpx: convert OnOffAuto hyperv property to QAPI-aware registration
      whpx: convert OnOffAuto arch properties to QAPI-aware registration
      accel/kvm: convert OnOffSplit property to QAPI-aware registration
      whpx: convert OnOffSplit property to QAPI-aware registration
      ppc/spapr-caps: convert to QAPI-aware property registration
      system/memory: fix "priority" property typename
      backends/hostmem: fix property typenames
      backends/hostmem-file: fix "align" property typename
      accel/tcg: fix "tb-size" property typename
      block/throttle-groups: fix throttle properties typename
      event-loop-base: fix property typenames
      iothread: fix poll properties typename
      util/thread-context: fix property typenames
      target/i386: fix CPUID version properties typename
      ppc/pnv: fix phb-id and chip-id properties typename
      backends/hostmem-memfd: fix "hugetlbsize" property typename
      hw/acpi: fix "node" properties typename
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
      spdm-socket: convert SpdmTransportType to QAPI enum
      hw/gpio/pca955x: use QAPI enums for led and pin properties
      include: add QEMU_REPEAT helper macro
      hw/gpio/pca955x: convert pin/led property to QAPI-aware enum
      hw/pci: change the busnr type to uint8
      qdev: add qapi_type field to PropertyInfo with fallback registration
      qdev: convert core PropertyInfo definitions to use qapi_type
      qdev: adjust PciDevfn declared type
      qdev: convert system PropertyInfo definitions to use qapi_type
      hw: convert device-local PropertyInfo definitions to use qapi_type
      target/riscv: fix incorrect QAPI types and u8 casting
      target/riscv: convert PropertyInfo definitions to use qapi_type
      qdev: convert PropertyInfo definitions to use qapi_type
      qdev: introduce typed array PropertyInfos
      qdev: simplify DEFINE_PROP_ARRAY and remove generic array PropertyInfo
      qdev: remove deprecated PropertyInfo.type and .enum_table fields
      memory: use object_property_add_link for container property
      hw/i386: convert PCSouthBridgeOption to QAPI enum
      qom: use QAPITypeInfo in object_property_get_enum
      qapi: expose integer signedness and width in introspection
      tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema

 accel/hvf/hvf-all.c                      |  29 ++--
 accel/kvm/kvm-all.c                      |  31 ++--
 accel/nitro/nitro-accel.c                |   3 +-
 accel/tcg/tcg-all.c                      |   3 +-
 accel/whpx/whpx-common.c                 |  58 +++----
 authz/list.c                             |  14 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  33 ++--
 backends/hostmem-memfd.c                 |   3 +-
 backends/hostmem.c                       |  20 +--
 backends/spdm-socket.c                   |  25 +--
 backends/tpm/tpm_util.c                  |   3 +-
 block/throttle-groups.c                  |  10 +-
 chardev/char-socket.c                    |   3 +-
 crypto/secret_common.c                   |  12 +-
 crypto/secret_keyring.c                  |   9 +-
 crypto/tlscreds.c                        |  12 +-
 docs/devel/qapi-code-gen.rst             | 123 +++++++++++++--
 docs/interop/virtio-balloon-stats.rst    |  22 +--
 event-loop-base.c                        |   7 +-
 hw/acpi/ich9.c                           |   3 +-
 hw/acpi/pci.c                            |   7 +-
 hw/arm/virt.c                            |  31 ++--
 hw/block/xen-block.c                     |   3 +-
 hw/core/clock.c                          |   3 +-
 hw/core/machine-qmp-cmds.c               |   3 +-
 hw/core/machine.c                        |  13 +-
 hw/core/qdev-prop-internal.h             |  20 +++
 hw/core/qdev-properties-system.c         |  97 ++++++------
 hw/core/qdev-properties.c                | 180 ++++++++++++++-------
 hw/cpu/core.c                            |  10 +-
 hw/cxl/cxl-host.c                        |   6 +-
 hw/display/apple-gfx-mmio.m              |   2 +-
 hw/display/apple-gfx-pci.m               |   2 +-
 hw/display/apple-gfx.h                   |   1 +
 hw/display/apple-gfx.m                   |   7 +-
 hw/gpio/aspeed_gpio.c                    |   5 +-
 hw/gpio/aspeed_sgpio.c                   |   3 +-
 hw/gpio/pca9552.c                        | 261 ++++++++++++-------------------
 hw/gpio/pca9554.c                        | 157 +++++++------------
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/i386/microvm.c                        |  80 ++++------
 hw/i386/pc.c                             |  32 ++--
 hw/i386/pc_piix.c                        |  61 +++-----
 hw/i386/sgx-epc.c                        |   3 +-
 hw/i386/x86.c                            | 113 ++++++-------
 hw/ide/ide-dev.c                         |   3 +-
 hw/input/stellaris_gamepad.c             |   2 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/intc/arm_gicv5_common.c               |   4 +-
 hw/intc/rx_icu.c                         |   4 +-
 hw/loongarch/virt.c                      |  87 +++++------
 hw/mem/nvdimm.c                          |  11 +-
 hw/mem/pc-dimm.c                         |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 ++-
 hw/misc/arm_sysctl.c                     |   4 +-
 hw/misc/aspeed_lpc.c                     |  73 ++++++---
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/mps2-scc.c                       |   2 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/tz-ppc.c                         |  19 +--
 hw/misc/xlnx-versal-trng.c               |  15 +-
 hw/net/ne2000-isa.c                      |   3 +-
 hw/net/rocker/rocker.c                   |   2 +-
 hw/net/virtio-net.c                      |   2 +-
 hw/nvme/ctrl.c                           |  29 ++--
 hw/nvme/nguid.c                          |   3 +-
 hw/nvram/xlnx-bbram.c                    |   3 +-
 hw/nvram/xlnx-efuse.c                    |   5 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c      |   3 +-
 hw/pci-host/i440fx.c                     |  29 ++--
 hw/pci-host/pnv_phb3.c                   |   5 +-
 hw/pci-host/pnv_phb4.c                   |   5 +-
 hw/pci-host/q35.c                        |   9 +-
 hw/pci/pci.c                             |   3 +-
 hw/ppc/spapr_caps.c                      |  39 ++---
 hw/ppc/spapr_drc.c                       |   5 +-
 hw/ppc/spapr_rtc.c                       |  18 ++-
 hw/remote/vfio-user-obj.c                |  22 +--
 hw/riscv/microchip_pfsoc.c               |   3 +-
 hw/riscv/riscv_hart.c                    |   6 +-
 hw/riscv/virt.c                          |  52 +++---
 hw/rtc/mc146818rtc.c                     |  16 +-
 hw/s390x/ccw-device.c                    |   3 +-
 hw/s390x/css.c                           |   5 +-
 hw/s390x/s390-pci-bus.c                  |   3 +-
 hw/s390x/s390-virtio-ccw.c               |   4 +-
 hw/s390x/sclpcpi.c                       |   8 +-
 hw/s390x/virtio-ccw-mem.c                |   3 +-
 hw/sensor/adc128d818.c                   |  16 +-
 hw/sensor/adm1266.c                      |   3 +-
 hw/sensor/adm1272.c                      |   9 +-
 hw/sensor/emc141x.c                      |   9 +-
 hw/sensor/isl_pmbus_vr.c                 |  19 +--
 hw/sensor/lsm303dlhc_mag.c               |   9 +-
 hw/sensor/max34451.c                     |   5 +-
 hw/sensor/tmp105.c                       |   3 +-
 hw/sensor/tmp421.c                       |   9 +-
 hw/usb/dev-storage-classic.c             |   3 +-
 hw/vfio-user/pci.c                       |   5 +-
 hw/vfio/pci-quirks.c                     |   3 +-
 hw/virtio/virtio-balloon.c               |  87 ++++-------
 hw/virtio/virtio-iommu-pci.c             |   2 +-
 hw/virtio/virtio-mem-pci.c               |   3 +-
 hw/virtio/virtio-mem.c                   |  18 ++-
 hw/xen/xen-pvh-common.c                  |   9 +-
 include/chardev/char.h                   |   8 -
 include/hw/block/block.h                 |   2 +-
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |  40 +++--
 include/hw/cxl/cxl_component.h           |   5 +-
 include/hw/i386/pc.h                     |   4 +-
 include/qapi/qapi-type-info.h            |  32 ++++
 include/qemu/osdep.h                     |  33 ++++
 include/qemu/uuid.h                      |   4 +
 include/qom/object.h                     | 171 ++++++++++++--------
 include/system/spdm-socket.h             |  28 ++--
 iothread.c                               |   9 +-
 meson.build                              |   2 +
 migration/options.c                      |   4 +-
 monitor/qmp.c                            |  12 +-
 net/colo-compare.c                       |  15 +-
 net/dump.c                               |   6 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |  10 +-
 qapi/common.json                         |  28 ++++
 qapi/introspect.json                     |  20 ++-
 qapi/machine.json                        | 152 ++++++++++++++++++
 qapi/meson.build                         |   4 +
 qapi/pragma.json                         |   1 +
 qapi/qom.json                            |  10 ++
 qapi/sockets.json                        |  20 +++
 qga/meson.build                          |   2 +
 qom/object.c                             | 236 +++++++++++++---------------
 qom/qom-qmp-cmds.c                       |  32 ++--
 scripts/qapi/backend.py                  |   9 +-
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               | 107 ++++++-------
 scripts/qapi/schema_analysis.py          | 149 ++++++++++++++++++
 scripts/qapi/type_infos.py               | 178 +++++++++++++++++++++
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |  40 +----
 target/arm/cpu64.c                       |  11 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |   5 +-
 target/i386/cpu.c                        |  26 +--
 target/i386/kvm/kvm.c                    |  38 +++--
 target/i386/kvm/tdx.c                    |   4 +-
 target/i386/sev.c                        |  31 ++--
 target/i386/whpx/whpx-all.c              | 101 ++++--------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  50 +++---
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |  13 +-
 target/s390x/cpu-system.c                |   4 +-
 target/s390x/cpu_models.c                |   5 +-
 target/sparc/cpu.c                       |   3 +-
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 tests/qtest/qmp-cmd-test.c               |  55 ++++++-
 tests/unit/check-qom-proplist.c          |  99 +++++++++---
 tests/unit/test-qdev-global-props.c      |  11 +-
 tests/unit/test-qdev.c                   |   2 +-
 ui/console-vc.c                          |   8 +-
 ui/console.c                             |   3 +-
 ui/dbus.c                                |  18 ++-
 ui/input-linux.c                         |  11 +-
 util/thread-context.c                    |   7 +-
 util/uuid.c                              |   5 +
 172 files changed, 2510 insertions(+), 1699 deletions(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260510-qom-qapi-fbe0f5060c3f

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


