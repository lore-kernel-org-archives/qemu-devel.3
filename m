Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339CBCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Rj-0007og-R2; Sun, 10 May 2026 09:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4RQ-0007nP-CI
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4RN-0004Hu-EB
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b+FKPe0LKbZXUFHzikncuPs0TDZHzBlgEpHpDdUdUp8=;
 b=XdOxADCS9WzWL2tFpUGBzqYBerd98mo2uLIaSNTeRfkzyAcAKyQKVKiDob0BK8Vgj/S29W
 djpW3/yB6IzrbcKhaIIgIXmjjnR6109IBKGXiCjZlPLB7zRJawxQ3gaRRmLQX0Om6Z1gQU
 JKBmTAEXgwgcRbjG4+ZnPe0yeLuCxj8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-sYfNTYnpNp66YJpCBoxsjg-1; Sun,
 10 May 2026 09:43:25 -0400
X-MC-Unique: sYfNTYnpNp66YJpCBoxsjg-1
X-Mimecast-MFC-AGG-ID: sYfNTYnpNp66YJpCBoxsjg_1778420604
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BA31800612
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:43:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DD4818004A3; Sun, 10 May 2026 13:43:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
Date: Sun, 10 May 2026 17:42:57 +0400
Message-Id: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqAIBCF4VeJWSeMhS16lWhRNtYEXdSKQHz3r
 JYf/OcE8OSYPNRZAEcXe97WBJlnoKduHUnwkAwFFhUqicJui7DdzsL0hEZhhbo0kPLdkeH7u2r
 a3/7sZ9LHu4cYHzKyGGVsAAAA
X-Change-ID: 20260510-qom-qapi-fbe0f5060c3f
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14172;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tWbo9EgS2mTHf/s9XvybHcU6jzulkCUrUACi3Zz1f7I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItufGfyRDucfw986sgfTc+nQmnuDysQLgyeI
 crYP5sRiyiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5ZewEAC0OTDMkHdebRf/ehZu54DVFYhL1p4h4/2lqDDjsnmvbQTKmW+Fipi96WfsM+VjNCdpGRW
 vOt1Y+NTERTHdy4b/W7U5HZVM06GsYJFwlvKwZ/WzEwLSW7AGCmd7UMOUQ+dsfX4IDCMtI9jBFU
 1XPsvGNJfHuwFo/SPLd9iUgmAAS67ejjDB96YSrZlC6TlGqyJAJ3NhPHDWVGuNisD1i0BZJXQsh
 oHJ2tO+yZCnFbVoh6cYDsgjbD3igOJgNvDDUSs/83W3qlMYfzqrV0Zvpi/qn+n2CndI09Yp3Y58
 /0WDpdlmFRXEP5ecaLwymPTBwWe+NbYVQ0CFkCwEX/PAigxn6F0gE0HaE3BcUT0M2a34ahHcMXU
 S/VCFv4eNUQtVidoiwQiwYed4MNmSvZo/GjSxCclqmZ9uaQZf4JLIJEvlRFLo9nnRZYj4/ImB27
 P5/aV0X+2yZYCjvynbxdK4MaQHYq6PTeRD3+j9AkGgiYZg4olpOselg8cBdiElhpIq34RuXzIsE
 cWhS4B6HcU8J0ww2pt+ARCNuvjXcgfKW/k1eO3BlMfa6Xp6PTmJ/QdUcH0DmKWRSm48xLUXHI7/
 WBbxnEOxTbGyi4ruIyU0o6PgdbwG61o8LlsP+DOq1QCNuXWzv1DjmP4nUDyVfSbRcIc8DXTmmLj
 JNO0vMTkiQt2dkA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Marc-André Lureau (54):
      qapi: add QAPITypeInfo struct definition
      qapi/introspect: expose the type name map
      qapi: add type-infos generator
      qapi/backend: wire up type-infos generation
      qapi/gen: fix _module_basename for multi-dash 'what' parameters
      meson: add qapi-type-infos-*.c/h to build
      qom: add qapi_type field to ObjectProperty
      qapi/qom: add qapi-type field to ObjectPropertyInfo
      qom/qmp: populate qapi-type in QMP handlers
      qom: add QAPI-aware property registration
      tests: update check-qom-proplist for QAPI-aware property registration
      qom: convert enum properties to QAPI-aware registration
      qom: remove old enum property registration API
      qom: convert struct properties to QAPI-aware registration
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
      hw/mem/nvdimm: fix "size" property typename
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
      hw/pci: change the busnr type to uint8
      qdev: add qapi_type field to PropertyInfo with fallback registration
      qdev: convert core PropertyInfo definitions to use qapi_type
      qdev: convert system PropertyInfo definitions to use qapi_type
      hw: convert device-local PropertyInfo definitions to use qapi_type
      target/riscv: fix incorrect QAPI types and u8 casting
      target/riscv: convert PropertyInfo definitions to use qapi_type
      qdev: convert PropertyInfo definitions to use qapi_type
      qdev: introduce typed array PropertyInfos
      qdev: simplify DEFINE_PROP_ARRAY and remove generic array PropertyInfo
      qdev: remove deprecated PropertyInfo.type and .enum_table fields
      memory: use object_property_add_link for container property
      qom: drop free-form property typename registration
      qom: use QAPITypeInfo in object_property_get_enum

 docs/devel/qapi-code-gen.rst             |  90 ++++++++++++
 docs/interop/virtio-balloon-stats.rst    |  22 +--
 meson.build                              |   1 +
 qapi/common.json                         |  28 ++++
 qapi/machine.json                        |  92 ++++++++++++
 qapi/pragma.json                         |   1 +
 qapi/qom.json                            |  12 ++
 qapi/sockets.json                        |  20 +++
 hw/core/qdev-prop-internal.h             |  20 +++
 hw/display/apple-gfx.h                   |   1 +
 include/hw/block/block.h                 |   2 +-
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |  29 ++--
 include/qapi/qapi-type-info.h            |  19 +++
 include/qemu/uuid.h                      |   4 +
 include/qom/object.h                     | 162 ++++++++++++---------
 include/system/spdm-socket.h             |  28 ++--
 accel/hvf/hvf-all.c                      |  29 ++--
 accel/kvm/kvm-all.c                      |  31 ++--
 accel/nitro/nitro-accel.c                |   3 +-
 accel/tcg/tcg-all.c                      |   3 +-
 accel/whpx/whpx-common.c                 |  58 +++-----
 authz/list.c                             |  14 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  33 ++---
 backends/hostmem-memfd.c                 |   3 +-
 backends/hostmem.c                       |  20 +--
 backends/spdm-socket.c                   |  25 ++--
 backends/tpm/tpm_util.c                  |   3 +-
 block/throttle-groups.c                  |  10 +-
 chardev/char-socket.c                    |   3 +-
 crypto/secret_common.c                   |  12 +-
 crypto/secret_keyring.c                  |   9 +-
 crypto/tlscreds.c                        |  12 +-
 event-loop-base.c                        |   7 +-
 hw/acpi/ich9.c                           |   3 +-
 hw/acpi/pci.c                            |   5 +-
 hw/arm/virt.c                            |  31 ++--
 hw/block/xen-block.c                     |   3 +-
 hw/core/clock.c                          |   3 +-
 hw/core/machine-qmp-cmds.c               |   3 +-
 hw/core/machine.c                        |  13 +-
 hw/core/qdev-properties-system.c         |  97 ++++++-------
 hw/core/qdev-properties.c                | 168 ++++++++++++++--------
 hw/cpu/core.c                            |  10 +-
 hw/cxl/cxl-host.c                        |   6 +-
 hw/gpio/aspeed_gpio.c                    |   5 +-
 hw/gpio/aspeed_sgpio.c                   |   3 +-
 hw/gpio/pca9552.c                        |   6 +-
 hw/gpio/pca9554.c                        |   6 +-
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/i386/microvm.c                        |  84 +++++------
 hw/i386/pc.c                             |  32 ++---
 hw/i386/pc_piix.c                        |  19 ++-
 hw/i386/sgx-epc.c                        |   3 +-
 hw/i386/x86.c                            | 119 +++++++---------
 hw/ide/ide-dev.c                         |   3 +-
 hw/input/stellaris_gamepad.c             |   2 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/intc/rx_icu.c                         |   4 +-
 hw/loongarch/virt.c                      |  87 ++++++------
 hw/mem/nvdimm.c                          |  11 +-
 hw/mem/pc-dimm.c                         |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 +--
 hw/misc/arm_sysctl.c                     |   4 +-
 hw/misc/aspeed_lpc.c                     |  73 ++++++----
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/mps2-scc.c                       |   2 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/xlnx-versal-trng.c               |   3 +-
 hw/net/ne2000-isa.c                      |   3 +-
 hw/net/rocker/rocker.c                   |   2 +-
 hw/net/virtio-net.c                      |   2 +-
 hw/nvme/ctrl.c                           |  29 ++--
 hw/nvme/nguid.c                          |   3 +-
 hw/nvram/xlnx-bbram.c                    |   3 +-
 hw/nvram/xlnx-efuse.c                    |   5 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c      |   3 +-
 hw/pci-host/i440fx.c                     |  35 +++--
 hw/pci-host/pnv_phb3.c                   |   5 +-
 hw/pci-host/pnv_phb4.c                   |   5 +-
 hw/pci-host/q35.c                        |   9 +-
 hw/pci/pci.c                             |   3 +-
 hw/ppc/spapr_caps.c                      |  39 ++---
 hw/ppc/spapr_drc.c                       |   5 +-
 hw/ppc/spapr_rtc.c                       |  18 ++-
 hw/remote/vfio-user-obj.c                |   5 +-
 hw/riscv/microchip_pfsoc.c               |   3 +-
 hw/riscv/riscv_hart.c                    |   6 +-
 hw/riscv/virt.c                          |  54 ++++---
 hw/rtc/mc146818rtc.c                     |  16 ++-
 hw/s390x/ccw-device.c                    |   3 +-
 hw/s390x/css.c                           |   5 +-
 hw/s390x/s390-pci-bus.c                  |   3 +-
 hw/s390x/s390-virtio-ccw.c               |   4 +-
 hw/s390x/sclpcpi.c                       |   8 +-
 hw/s390x/virtio-ccw-mem.c                |   3 +-
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
 hw/virtio/virtio-balloon.c               |  89 +++++-------
 hw/virtio/virtio-iommu-pci.c             |   2 +-
 hw/virtio/virtio-mem-pci.c               |   3 +-
 hw/virtio/virtio-mem.c                   |  18 +--
 hw/xen/xen-pvh-common.c                  |   9 +-
 iothread.c                               |   9 +-
 migration/options.c                      |   4 +-
 net/colo-compare.c                       |   7 +-
 net/dump.c                               |   6 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |  10 +-
 qom/object.c                             | 237 ++++++++++++++-----------------
 qom/qom-qmp-cmds.c                       |  32 +++--
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |  40 ++----
 target/arm/cpu64.c                       |  11 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |   5 +-
 target/i386/cpu.c                        |  26 ++--
 target/i386/kvm/kvm.c                    |  38 ++---
 target/i386/kvm/tdx.c                    |   4 +-
 target/i386/sev.c                        |  31 ++--
 target/i386/whpx/whpx-all.c              | 102 +++++--------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  46 +++---
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |   7 +-
 target/s390x/cpu-system.c                |   4 +-
 target/s390x/cpu_models.c                |   5 +-
 target/sparc/cpu.c                       |   3 +-
 tests/unit/check-qom-proplist.c          | 100 ++++++++++---
 tests/unit/test-qdev-global-props.c      |  11 +-
 tests/unit/test-qdev.c                   |   2 +-
 ui/console.c                             |   3 +-
 ui/dbus.c                                |  10 +-
 ui/input-linux.c                         |  11 +-
 util/thread-context.c                    |   7 +-
 util/uuid.c                              |   4 +
 hw/display/apple-gfx-mmio.m              |   2 +-
 hw/display/apple-gfx-pci.m               |   2 +-
 hw/display/apple-gfx.m                   |   7 +-
 qapi/meson.build                         |   4 +
 scripts/qapi/backend.py                  |   4 +-
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               |  13 +-
 scripts/qapi/type_infos.py               | 182 ++++++++++++++++++++++++
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 159 files changed, 1887 insertions(+), 1272 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260510-qom-qapi-fbe0f5060c3f

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


