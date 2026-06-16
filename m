Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71270CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZToW-0005Pj-6u; Tue, 16 Jun 2026 09:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZToU-0005PS-OR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZToR-0005nl-Dm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781616402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OCTYHIVEWuGrk0Rhta/8oenK8fxSIqUARq5vxMjeiVI=;
 b=Oa5oBbovBM36XOgmtNHxo5qm1Se/HOIPO4BrinNYUEHkbmhy1bBf0Qd7tySf6WoSLAJUqK
 vF5AxUnLAJaGfW4n9h/E8jhNzA7Hc2dS1L44Nht4soc1QWEZqgJ9mbs3Tnyx71Gp4k9ifV
 Kr0wr6EG0zfB64hziu7ju3kkZ43ZGfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-2Yi3HbraNzyf9Xad4hel7Q-1; Tue,
 16 Jun 2026 09:26:38 -0400
X-MC-Unique: 2Yi3HbraNzyf9Xad4hel7Q-1
X-Mimecast-MFC-AGG-ID: 2Yi3HbraNzyf9Xad4hel7Q_1781616396
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8616C19560A5; Tue, 16 Jun 2026 13:26:36 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 910A13000203; Tue, 16 Jun 2026 13:26:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v6 00/17] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Date: Tue, 16 Jun 2026 15:16:47 +0200
Message-ID: <20260616132625.1732031-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This series enhances the current host KVM model with capability to
set writable ID reg fields. 

Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
of a subset of ID regs. The list of writable fields continues to grow.
The feature ID range is defined as the AArch64 System register space
with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.

The end goal is to get more flexibility when migrating guests
between different host hardware.

QEMU retrieves the writable ID fields from KVM UAPI [1] and
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

The list of SYSREG_ID properties can be retrieved through the qmp
monitor using query-cpu-model-expansion [2].

For the record, Jinqian was able to migrate between Hisilicon KunPeng
HIP09 and HIP12 chips with this series using this kind of command:

-cpu host,pauth=off,pmu=off,sve=off,\
SYSREG_ID_AA64PFR1_EL1_NMI=0x0,\
SYSREG_ID_AA64ISAR1_EL1_LS64=0x0,\
SYSREG_ID_AA64ISAR1_EL1_XS=0x0,\
SYSREG_ID_AA64ISAR1_EL1_LRCPC=0x2,\
SYSREG_ID_AA64ISAR2_EL1_RPRFM=0x0,\
SYSREG_ID_AA64ISAR2_EL1_CLRBHB=0x0,\
SYSREG_ID_AA64ISAR2_EL1_PAC_frac=0x0,\
SYSREG_ID_AA64ISAR2_EL1_BC=0x0,\
SYSREG_ID_AA64ISAR2_EL1_RPRES=0x0,\
SYSREG_ID_AA64ISAR2_EL1_WFxT=0x0,\
SYSREG_ID_AA64MMFR0_EL1_FGT=0x0,\
SYSREG_ID_AA64MMFR0_EL1_BigEnd=0x0,\
SYSREG_ID_AA64MMFR1_EL1_ECBHB=0x0,\
SYSREG_ID_AA64MMFR1_EL1_CMOW=0x0,\
SYSREG_ID_AA64MMFR1_EL1_TIDCP1=0x0,\
SYSREG_ID_AA64MMFR1_EL1_nTLBPA=0x0,\
SYSREG_ID_AA64MMFR1_EL1_AFP=0x0,\
SYSREG_ID_AA64MMFR1_EL1_HCX=0x0,\
SYSREG_ID_AA64MMFR1_EL1_ETS=0x0,\
SYSREG_ID_AA64MMFR1_EL1_PAN=0x2,\
SYSREG_ID_AA64MMFR1_EL1_HAFDBS=0x2,\
SYSREG_ID_AA64MMFR2_EL1_CnP=0x0,\
SYSREG_ID_AA64MMFR3_EL1_TCRX=0x0,\
SYSREG_ID_AA64DFR0_EL1_PMUVer=0x6,\
SYSREG_ID_AA64DFR0_EL1_DebugVer=0x9,\
SYSREG_ID_AA64DFR0_EL1_DoubleLock=0xf,\
SYSREG_ID_AA64ZFR0_EL1_F64MM=0x0,\
SYSREG_ID_AA64ZFR0_EL1_F32MM=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SM4=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SHA3=0x0,\
SYSREG_ID_AA64ZFR0_EL1_BitPerm=0x0,\
SYSREG_ID_AA64ZFR0_EL1_AES=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SVEver=0x0,\
SYSREG_CTR_EL0_L1Ip=0x2 \

Connie & Eric

This series can be found at:
https://github.com/eauger/qemu/tree/arm-cpu-model-v6

History:
--------
v5 -> v6:
v6 is mostly for Khushit to see how he may work on top
of this series. It fulfills some of his requirements:
- Upon Khushit request I added description for enum values
  and reserved fields
- set_sysreg_prop checks the input value against enum values
  if any
- writable_bitmap is now dispatched into the sysreg descripton
  and not stored in vcpu state anymore (besides it is VM wide)
- implemented write for qmp inspection. However this is not
  yet checked against KVM. That's the next step I think, ie.
  instantiate a scratch vcpu to test if the field value can be
  applied?
- if some inconsistencies between writable mask and idreg
  field, reserved fields only produce traces
- simplify checks related to availability of writable map
- this version does not yet fix some reported issues about host
  supporting nested virt. I will further sync with Khushit.
  so this is definitively not candidate to be applied, hence the
  RFC tag.

v4 -> v5:
- generate target/arm/cpu-idregs.h.inc that look similar to
  the format used in [RFC PATCH v1 02/13] target/arm:
  named_cpu_model: Add ID Register Fields without the
  description of the value values nor safe policy/value.
  I guess valid values could be generated from the Registers.json
  file too. Safe policy/values cannot.
  I reused one patch from the above series.
  Let's see how both series can progress/coexist without any
  anticipated bias.
- Addressed all comments from Shameer on v4
- Addressed 2 comments from v4 that were missed including the
  issue of IDreg visibility affected by some other settings.
  Unfortunately I was not able to test it.
- Further look at overrides between low level id reg field
  properties versus legacy CPU options. I have the feeling they
  can coexist as long as we document the hierarchy between them:
  host kvm default -> ID reg field props -> legacy CPU options
- Noticed more writable fields that are RES0/RAZ
- Improved commit messages in general

References:
-----------

[1]
KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
KVM_ARM_GET_REG_WRITABLE_MASKS
Documentation/virt/kvm/api.rst

[2]
qemu-system-aarch64 -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -M virt --enable-kvm -cpu host
sudo build/run qmp-shell /home/augere/TEST/QEMU/qmp-sock
Welcome to the QMP low-level shell!
Connected to QEMU 11.0.50
(QEMU) query-cpu-model-expansion type=full model={"name":"host"}


Cornelia Huck (3):
  target/arm/kvm: Retrieve writable ID reg map
  arm-qmp-cmds: introspection for ID register props
  arm/cpu-features: document ID reg properties

Eric Auger (13):
  scripts: introduce scripts/update-aarch64-cpu-sysregs-header.py
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm/cpu-sysregs.h.inc: Update with automatic generation
  arm/cpu: Add infra to handle generated ID register definitions
  scripts: Introduce scripts/aarch64_sysreg_helpers module
  scripts: Introduce scripts/update-aarch64-cpu-sysreg-properties.py
  target/arm/cpu-idregs.h.inc: generate with script
  target/arm/cpu-idregs.h.inc: Generate enum values
  arm/kvm: Initialize all writable ID registers from host
  target/arm/kvm: Introduce kvm_arm_expose_idreg_properties
  target/arm/cpu: Expose writable ID reg field properties on the kvm
    host vcpu model
  target/arm/cpu-idregs.h.inc: Generate reserved fields
  target/arm/kvm: Ignore and trace unexpected writable reserved fields

Shaju Abraham (1):
  target/arm/cpu_idregs: generate tables for Arm64 ID registers and
    fields

 docs/system/arm/cpu-features.rst              |  106 +-
 target/arm/cpu-idregs.h                       |   41 +
 target/arm/kvm_arm.h                          |   10 +
 target/arm/cpu-idregs.h.inc                   | 2164 +++++++++++++++++
 target/arm/cpu-sysregs.h.inc                  |   57 +-
 target/arm/arm-qmp-cmds.c                     |   29 +
 target/arm/cpu-idregs.c                       |   96 +
 target/arm/cpu64.c                            |    5 +
 target/arm/kvm.c                              |  311 ++-
 scripts/aarch64_sysreg_helpers.py             |  109 +
 .../update-aarch64-cpu-sysreg-properties.py   |  290 +++
 scripts/update-aarch64-cpu-sysregs-header.py  |   51 +
 target/arm/meson.build                        |    1 +
 target/arm/trace-events                       |    7 +
 14 files changed, 3244 insertions(+), 33 deletions(-)
 create mode 100644 target/arm/cpu-idregs.h
 create mode 100644 target/arm/cpu-idregs.h.inc
 create mode 100644 target/arm/cpu-idregs.c
 create mode 100644 scripts/aarch64_sysreg_helpers.py
 create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
 create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py

-- 
2.53.0


