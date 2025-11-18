Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9DCEE336
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOHz-0002zR-Ol; Tue, 18 Nov 2025 11:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOH1-0002X3-4L
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOGx-0004aM-Em
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b26cI2M7OPZ81pAQprxKa6aNofC/up7EdiYzf1XHT/c=;
 b=GyZhnDJi2y0IGvcdGhRd/THpXIt5Ml9CiFiLZJMfepDLl79y19lVCBCleSdyBlQPKALlSB
 OHbUsXvdCHAsi5TF9a8cVVfpzhphHw1KD3RzLl+mlxcP54ednosJVHyvWhTspQXCK1qy9I
 9pOZl7q8WVs7ZxlarwVC1l3BYqUZ1RM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-eOJ-V8qJPpqYzfc7phmRjA-1; Tue,
 18 Nov 2025 11:09:31 -0500
X-MC-Unique: eOJ-V8qJPpqYzfc7phmRjA-1
X-Mimecast-MFC-AGG-ID: eOJ-V8qJPpqYzfc7phmRjA_1763482170
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49BF61956062; Tue, 18 Nov 2025 16:09:30 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84CBA19560B2; Tue, 18 Nov 2025 16:09:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 0/8] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Date: Tue, 18 Nov 2025 17:07:30 +0100
Message-ID: <20251118160920.554809-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Mitigation of DBGDTRTX issue would be achived by setting
x-mig-safe-missing-regs=0x40200000200e0298 which matches
AArch32 DBGDTRTX register index.

The first patch improves the tracing so that we can quickly detect
which registers do not match between the incoming stream and the
exposed sysregs

---

History:

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

Available at:
https://github.com/eauger/qemu/tree/mitig-v2


Eric Auger (8):
  target/arm/machine: Improve traces on register mismatch during
    migration
  target/arm/cpu: Allow registers to be hidden
  target/arm/machine: Allow extra regs in the incoming stream
  target/arm/helper: Skip hidden registers
  kvm-all: Add the capability to blacklist some KVM regs
  target/arm/cpu: Implement hide_reg callback()
  target/arm/cpu: Expose x-mig-hidden-regs and x-mig-safe-missing-regs
    properties
  hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
    kernels

 include/hw/core/cpu.h   |  2 ++
 target/arm/cpu.h        | 51 +++++++++++++++++++++++++++++++
 accel/kvm/kvm-all.c     | 12 ++++++++
 hw/arm/virt.c           | 19 ++++++++++++
 target/arm/cpu.c        | 11 +++++++
 target/arm/helper.c     | 10 +++++-
 target/arm/kvm.c        | 35 ++++++++++++++++++++-
 target/arm/machine.c    | 67 +++++++++++++++++++++++++++++++++++++----
 target/arm/trace-events |  9 ++++++
 9 files changed, 208 insertions(+), 8 deletions(-)

-- 
2.51.1


