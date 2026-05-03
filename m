Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095AEFF885A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 07:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJRN0-00081h-KZ; Sun, 03 May 2026 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRMx-000815-4P
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRMu-0003TK-Q7
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777793759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eJbqFxtHUzeCNhZy2Eqbtv3ldmKnEXIaIpe/lLouE+8=;
 b=gvJYnV/FXNlN0rHJYK1dJTyyCJqOC7Nd1LbCaZWd/QLYhg07zVjAc2WPtBh6QwsADfiAHe
 h31BgruT7JlU8ieHm28++uJ0zMJ/T22dblUpjkyjaNImNKeK/JDi2ySZUi+JKAbsgwnGq5
 Q36Ljl9Rz1xmoDPFXTKugdRaudcebGk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-p8La373fM-iT3TSbbUu7nw-1; Sun,
 03 May 2026 03:35:55 -0400
X-MC-Unique: p8La373fM-iT3TSbbUu7nw-1
X-Mimecast-MFC-AGG-ID: p8La373fM-iT3TSbbUu7nw_1777793754
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76029195608B; Sun,  3 May 2026 07:35:53 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 047FA1801481; Sun,  3 May 2026 07:35:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v4 00/17] kvm/arm: Introduce a customizable aarch64 KVM host
 model
Date: Sun,  3 May 2026 09:33:20 +0200
Message-ID: <20260503073541.790215-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
linux/arch/arm64/tools/sysreg file [3] . It is not straightforward
to have unit tests for python scripts as there are many cases for
field extraction.

For each writable named field a uint64 property is created
following the "SYSREG_<REG>_<FIELD>" naming convention. REG and
FIELD names are those described in ARM ARM Reference manual.

The list of SYSREG_ID properties can be retrieved through the qmp
monitor using query-cpu-model-expansion [2].

Connie & Eric

This series can be found at:
https://github.com/eauger/qemu/tree/arm-cpu-model-v4

References:

[1]
KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
KVM_ARM_GET_REG_WRITABLE_MASKS
Documentation/virt/kvm/api.rst

[2]
qemu-system-aarch64 -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -M virt --enable-kvm -cpu custom
sudo build/run qmp-shell /home/augere/TEST/QEMU/qmp-sock
Welcome to the QMP low-level shell!
Connected to QEMU 11.0.50
(QEMU) query-cpu-model-expansion type=full model={"name":"host"}

[3]
linux/arch/arm64/tools/sysreg and gen-sysreg.awk
./tools/include/generated/asm/sysreg-defs.h


Cornelia Huck (4):
  target/arm/kvm: Introduce kvm_get_writable_id_regs
  arm/cpu: accessors for writable id registers
  arm-qmp-cmds: introspection for ID register props
  arm/cpu-features: document ID reg properties

Eric Auger (13):
  scripts: introduce scripts/update-aarch64-cpu-sysregs-header.py
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm/cpu-sysregs.h.inc: Update with automatic generation
  arm/cpu: Add infra to handle generated ID register definitions
  scripts: Introduce scripts/aarch64_sysreg_helpers module
  scripts: Introduce scripts/update-aarch64-cpu-sysreg-properties.py
  target/arm/cpu-sysreg-properties.c: Generate code with new script
  arm/kvm: Allow reading all the writable ID registers
  arm/kvm: write back modified ID regs to KVM
  target/arm/kvm: Introduce kvm_arm_expose_idreg_properties
  target/arm/kvm: Special case REVIDR_EL1 and AIDR_EL1
  target/arm/kvm: Special case ID_AA64ISAR0_EL1 RES0 [24, 27] bits
  arm/cpu: Expose writable ID reg field properties on the kvm host vcpu
    model

 docs/system/arm/cpu-features.rst              | 104 ++-
 scripts/aarch64_sysreg_helpers.py             | 109 +++
 .../update-aarch64-cpu-sysreg-properties.py   | 169 +++++
 scripts/update-aarch64-cpu-sysregs-header.py  |  51 ++
 target/arm/arm-qmp-cmds.c                     |  19 +
 target/arm/cpu-idregs.h                       |  59 ++
 target/arm/cpu-sysreg-properties.c            | 673 ++++++++++++++++++
 target/arm/cpu-sysregs.h.inc                  |  57 +-
 target/arm/cpu.c                              |  12 +
 target/arm/cpu.h                              |  36 +
 target/arm/cpu64.c                            |  26 +-
 target/arm/kvm-stub.c                         |   3 +-
 target/arm/kvm.c                              | 313 +++++++-
 target/arm/kvm_arm.h                          |  19 +-
 target/arm/meson.build                        |   3 +-
 target/arm/trace-events                       |   6 +
 16 files changed, 1622 insertions(+), 37 deletions(-)
 create mode 100644 scripts/aarch64_sysreg_helpers.py
 create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
 create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py
 create mode 100644 target/arm/cpu-idregs.h
 create mode 100644 target/arm/cpu-sysreg-properties.c

-- 
2.53.0


