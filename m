Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7919AD19505
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPrl-0008QC-Cv; Mon, 26 Jan 2026 11:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPri-0008MA-VP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPrg-0007Aw-5x
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769446498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JqW2bkGgEgt7vPK0yDVS79q4ewH3iMDBA6noVAGBoY8=;
 b=EZOu/i9+EiuhOum8K1XQkhoqejO8q8Ex2/ckcC/clRNYqKfK6inqS5KND9ELEgqYoOq15/
 2q7AOHL4Tjd1zmKvnQeChtS4Hc4b2r+ywo9mfWVrX4//D2f2kLyPrO/+LhJSx2yxJFDME1
 Hb+pzfCI12UwZt5CIn8FLJm8czSwPjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-MGhBUES5Pgi8Jw8MeShOQg-1; Mon,
 26 Jan 2026 11:54:55 -0500
X-MC-Unique: MGhBUES5Pgi8Jw8MeShOQg-1
X-Mimecast-MFC-AGG-ID: MGhBUES5Pgi8Jw8MeShOQg_1769446493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C2C7180035D; Mon, 26 Jan 2026 16:54:53 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 344A81801ACA; Mon, 26 Jan 2026 16:54:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v6 00/11] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Date: Mon, 26 Jan 2026 17:52:59 +0100
Message-ID: <20260126165445.3033335-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When migrating ARM guests accross same machines with different host
kernels we are likely to encounter failures such as:

"failed to load cpu:cpreg_vmstate_array_len"

This is due to the fact KVM exposes a different number of registers
to qemu on source and destination. When trying to migrate a bigger
register set to a smaller one, qemu cannot save the CPU state.

For example, recently we faced such kind of situations with:
- unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
  register from v6.16 onwards. Causes backward migration failure.
- removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
  from v6.13 onwards. Causes forward migration failure.

This situation is really problematic for distributions which want to
guarantee forward and backward migration of a given machine type
between different releases.

While the series mainly targets KVM acceleration, this problem
also exists with TCG. For instance some registers may be exposed
while they shouldn't. Then it is tricky to fix that situation 
without breaking forward migration. An example was provided by
Peter: 4f2b82f60 ("target/arm: Reinstate bogus AArch32 DBGDTRTX
register for migration compat). 

This series introduces 2 CPU array properties that list
- the CPU registers to hide from the exposes sysregs (aims
  at removing registers from the destination)
- The CPU registers that may not exist but which can be found
  in the incoming migration stream (aims at ignoring extra
  registers in the incoming state)

An example is given to illustrate how those props
could be used to apply compats for machine types supposed to "see" the
same register set accross various host kernels.

Mitigation of DBGDTRTX issue would be achieved by setting
x-mig-safe-missing-regs=0x40200000200e0298 which matches
AArch32 DBGDTRTX register index.

The first patch improves the tracing so that we can quickly detect
which registers do not match between the incoming stream and the
exposed sysregs

---

Available at:
https://github.com/eauger/qemu/tree/mitig-v6

---

Tests:
- migration with 10.2 machine with old qemu featuring DBGDTRTX
  and this one where it is removed. Forward migration works.
  backward doesn't because the register is not present in the
  input migration stream and write_list_to_cpustate() fails
  while write_raw_cp_reg and reading it back. write_raw_cp_reg()
  seems to read an unintialized values from  cpu->cpreg_values[i].
  write has no effect since type is ARM_CP_CONST but read_raw_cp_reg
  returns ri->resetvalue which differs from uninitialized value.
  I would have expected the initial cpu->cpreg_values[i] to match
  reset value which is obviously not the case. Laso the comment hints
  that it should be. So maybe another issue? Nevertheless I am
  not totally sure supporting backward migration for TCG is a must.
  This may be fixed separately if it is confirmed this is a bug.

- migration with accel=kvm back and forth old host/qemu where
  host does not feature fixes for TCR2_EL1, PIRE0_EL1, PIR_EL1
  and recent KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW and more recent
  kernel/this qemu that feature them. Migration works forward
  and backward with 10.1 machine type.

History:

v5 -> v6:
- move GString init and collected Sebastian's R-b

v4 -> v5:
- Fixed issue reported by Sebastian about aggregated array
  props. This lead to the introduction of
  hw/arm/virt: Introduce framework to aggregate hidden-regs
  and safe-missing-regs
- Collected additional hacks from Connie

v3 -> v4:
- Collected Connie's & Sebastian's R-bs
- Squashed patches 3 and 5
- various typos and rewording

v2 -> v3:
- revert target/arm: Reinstate bogus AArch32 DBGDTRTX register for migration compat
- fix some typos and rework target/arm/cpu.h hidden_regs comment (Connie)
- Even for TCG we use KVM index

v1 -> v2:
- fixed typos (Connie)
- Make it less KVM specific (tentative hidding of TCG regs, not
  tested)
- Tested DBGDTRTX TCG case reported by Peter
- No change to the property format yet. Ran out of idea. However
  I changed the name of the property with x-mig prefix
- Changed the terminology, kept hidding but remove fake which was
  confusing
- Simplified the logic for regs missing in the incoming stream and
  do not check anymore they are exposed on dest


Eric Auger (11):
  hw/arm/virt: Rename arm_virt_compat into arm_virt_compat_defaults
  target/arm/machine: Improve traces on register mismatch during
    migration
  target/arm/cpu: Allow registers to be hidden
  target/arm/machine: Allow extra regs in the incoming stream
  kvm-all: Enforce hidden regs are never accessed
  target/arm/cpu: Implement hide_reg callback()
  target/arm/cpu: Expose x-mig-hidden-regs and x-mig-safe-missing-regs
    properties
  hw/arm/virt: Declare AArch32 DBGDTRTX as safe to ignore in incoming
    stream
  Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX register for
    migration compat"
  hw/arm/virt: Introduce framework to aggregate hidden-regs and
    safe-missing-regs
  hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
    kernels

 include/hw/arm/virt.h     | 23 ++++++++++
 include/hw/core/cpu.h     |  2 +
 target/arm/cpu.h          | 48 +++++++++++++++++++++
 accel/kvm/kvm-all.c       | 12 ++++++
 hw/arm/virt.c             | 89 ++++++++++++++++++++++++++++++++++++---
 target/arm/cpu.c          | 11 +++++
 target/arm/debug_helper.c | 29 -------------
 target/arm/helper.c       | 12 +++++-
 target/arm/kvm.c          | 35 ++++++++++++++-
 target/arm/machine.c      | 70 +++++++++++++++++++++++++++---
 target/arm/trace-events   | 10 +++++
 11 files changed, 298 insertions(+), 43 deletions(-)

-- 
2.52.0


