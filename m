Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372B9C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qvJ-0006Tg-IM; Wed, 16 Sep 2026 10:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qvH-0006Sh-NN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qvC-0006L4-Dq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o6TLEUfsuWnfnPaMNFtZXD1NQjE9HnCmVJlsx/1A0Zw=;
 b=HOXL8e/UEGYX2gYj2hEHzd9VsYiX+ijuK/kZ9I+MRwjmFrzRngeatFxzk8Q7n7FMmywe5M
 GBBGT6z3IR0lV/b09J4agofQIMhnIu2vmrM2ZO33cwGkJOky/FakMNElTflehp/V2cRD4D
 PmYeT3IGfEZjY0p8Hf4sSG4oNS54m8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-aAoA-kzTMNC2zKC3hZEiFw-1; Wed,
 16 Sep 2026 10:47:34 -0400
X-MC-Unique: aAoA-kzTMNC2zKC3hZEiFw-1
X-Mimecast-MFC-AGG-ID: aAoA-kzTMNC2zKC3hZEiFw_1789570052
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72CEE1800DB5; Wed, 16 Sep 2026 14:47:31 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E852D19560AB; Wed, 16 Sep 2026 14:47:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 00/26] kvm/arm: Introduce a customizable aarch64 KVM host
 model
Date: Wed, 16 Sep 2026 16:45:23 +0200
Message-ID: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series enhances the current host KVM model with capability to
set writable ID reg fields.

Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
of a subset of ID regs. The list of writable fields continues to grow.
The feature ID range is defined as the AArch64 System register space
with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.

The end goal is to get more flexibility when migrating guests
between different host hardware.

QEMU retrieves the writable ID fields from KVM UAPI and
match them against a generated description of ID regs and their
named fields that stem from AARCHMRS Registers.json file.
Current description is based on latest 2026-03 edition.
The content of the generated files was compared against kernel
linux/arch/arm64/tools/sysreg file. It is not straightforward
to have unit tests for python scripts as there are many cases for
field extraction.

For each writable named field a uint64 property is created
following the "SYSREG_<REG>_<FIELD>" naming convention. REG and
FIELD names are those described in ARM ARM Reference manual.

SYSREG properties are applied at the end of the initialization
chain, after legacy composite options (sve, pauth, ...). They
do not substitute to them because legacy options do more than
just changing the value of ID registers. They may also interact
with KVM to init the vcpu with specific features or set some
VM capabilities. SYSREG properties just affect the corresponding
ID register field. Some checks are performed to make sure their
value is not inconsistent with legacy composite options.

The list of SYSREG properties can be retrieved through the qmp
monitor using query-cpu-model-expansion. They return the current
value for the corresponding field. The qmp command also allows to
test  setting new values. In static mode, they are tested at qemu
level only, against field length, arch enum values if any and
consistency with legacy composite options. With full expansion,
the values are tested against KVM using a scratch vcpu initialized
with the right legacy composite property values.

Connie & Eric

This series can be found at:
https://github.com/eauger/qemu/tree/arm-cpu-model-v9

History:
--------
v8 -> v9:
- Eventually turned this series into non RFC series as main
  blockers have been removed I think
- Changed the way SYSREG props are applied, first stored into
  a hashkey and applied at the very end of the init chain, after
  legacy composite options. This fixes the issue with NV.
- Also we are running the expansion code on a scratch vcpu mode
  that should be similar to the final one, initialized with the
  right composite options.
- Introduced the static support for expansion. In static mode,
  we don't run checks against the scratch vcpu
- Added consistency checks between legacy composite options and
  SYSREG props
- Addressed the 2 bugs reported by Khushit & Shameer (scrach vcpu
  leak in expansion code and RES field handling)
- pass errp to kvm_arch_init_vcpu()
- introduced kvm_arm_vcpu_prepare_init_features

Cornelia Huck (3):
  target/arm/kvm: Retrieve writable ID reg map
  arm-qmp-cmds: introspection for ID register props
  arm/cpu-features: document ID reg properties

Eric Auger (22):
  scripts: introduce scripts/update-aarch64-cpu-sysregs-header.py
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm/cpu-sysregs.h.inc: Update with automatic generation
  arm/cpu: Add infra to handle generated ID register definitions
  scripts: Introduce scripts/aarch64_sysreg_helpers module
  scripts: Introduce scripts/update-aarch64-cpu-sysreg-properties.py
  target/arm/cpu-idregs.h.inc: generate with script
  target/arm/cpu-idregs.h.inc: Generate enum values
  hw/arm/virt: Make sure virt_get_caches() keeps on reading CLIDR_EL1 as
    0
  arm/kvm: Initialize isar.idregs[] with all writable host ID regs
  target/arm/kvm: Introduce kvm_arm_expose_idreg_properties
  target/arm/kvm: Implement SYSREG property setter and getter
  target/arm/kvm: Pass an Error handle to kvm_arch_init_vcpu
  target/arm/kvm: Apply SYSREG props to the final vcpu
  target/arm/kvm: Add consistency checking for SYSREG props
  target/arm/cpu: Expose writable ID reg field properties on the kvm
    host vcpu model
  target/arm/cpu-idregs.h.inc: Generate reserved fields
  target/arm/kvm: Ignore and trace unexpected writable reserved fields
  target/arm/kvm: add helper to test SYSREG props against a scratch vcpu
  target/arm/kvm: Add an error handle to
    kvm_arm_create_scratch_host_vcpu
  target/arm/kvm: Introduce kvm_arm_vcpu_prepare_init_features helper
  target/arm/kvm: Introduce kvm_arm_create_init_scratch_vcpu()

Shaju Abraham (1):
  target/arm/cpu_idregs: generate tables for Arm64 ID registers and
    fields

 docs/system/arm/cpu-features.rst              |  100 +-
 include/system/kvm.h                          |    2 +-
 target/arm/cpu-idregs.h                       |   36 +
 target/arm/cpu.h                              |    2 +
 target/arm/kvm_arm.h                          |   28 +-
 target/arm/cpu-idregs.h.inc                   | 2512 +++++++++++++++++
 target/arm/cpu-sysregs.h.inc                  |   55 +-
 accel/kvm/kvm-all.c                           |   15 +-
 hw/arm/virt.c                                 |    4 +
 target/arm/arm-qmp-cmds.c                     |  107 +-
 target/arm/cpu-idregs.c                       |   96 +
 target/arm/cpu.c                              |    5 +-
 target/arm/cpu64.c                            |    5 +
 target/arm/kvm-stub.c                         |   17 +
 target/arm/kvm.c                              |  560 +++-
 target/i386/kvm/kvm.c                         |   22 +-
 target/loongarch/kvm/kvm.c                    |   24 +-
 target/ppc/kvm.c                              |    6 +-
 target/riscv/kvm/kvm-cpu.c                    |    3 +-
 target/s390x/kvm/kvm.c                        |    2 +-
 scripts/aarch64_sysreg_helpers.py             |  121 +
 .../update-aarch64-cpu-sysreg-properties.py   |  299 ++
 scripts/update-aarch64-cpu-sysregs-header.py  |   51 +
 target/arm/meson.build                        |    1 +
 target/arm/trace-events                       |    9 +
 25 files changed, 3987 insertions(+), 95 deletions(-)
 create mode 100644 target/arm/cpu-idregs.h
 create mode 100644 target/arm/cpu-idregs.h.inc
 create mode 100644 target/arm/cpu-idregs.c
 create mode 100644 scripts/aarch64_sysreg_helpers.py
 create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
 create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py

-- 
2.53.0


