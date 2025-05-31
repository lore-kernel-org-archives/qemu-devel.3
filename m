Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C372DC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 13:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLLz4-0006cn-CI; Sat, 31 May 2025 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLL3n-00065Y-9K; Sat, 31 May 2025 08:11:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLL3j-0003Iz-UA; Sat, 31 May 2025 08:11:35 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 54VCB66G028914
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 May 2025 21:11:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Es7Tjqzu7RyuSHrhGOvYTa49Aort7jgOaa4SZsM6B4E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1748693481; v=1;
 b=f5Kkv+0X93U0JobzEkl9n43dldqUGLTRZy/IjpU5OCvb5ZH4zP3Vw0MRU1i2yx4S
 JxKCFVKaUIhlaJWWHM4To+XjApN8GhDlDRXYGqPauzGay6LBY/7eoi2gZPai/cPH
 4XGMfH21ppEI+Z1F3zr0No/8ATI4rnQxW3nfUncm9hZL4O0haewoHGgBbMRhsDKq
 V0X6jhGfh64HV87EK3niy+JZLeplN1rgXZdaISQHmyEg4hPLJlbyVEvz8K9WmPzF
 Qx/56UbzvmUAVNlB/U9j099hO2MutP1FixRmbjvMjjzO+fRNaIO3gjBILKmPVHX1
 hJCZ7bcfaAfBBgJc0PBHqQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 31 May 2025 21:11:06 +0900
Subject: [PATCH v3] target/arm: Define raw write for PMU CLR registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250531-clr-v3-1-377f9bf1746d@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIANnxOmgC/1WMQQ6CMBBFr0JmbU07rRRceQ/jAocikyg1rWkgh
 LtbcCPL9/PfmyG6wC7CuZghuMSR/ZBBHwqgvhkeTnCbGVDiSWqlBT2DKBttKq1KrO4W8vMdXMf
 jVrneMvccPz5MWzSpdd37SQklkMjUbWdk5+pL20wDj0fyL1gDCf8l85MwS5YsoiRlLe2lZVm+x
 uiJLswAAAA=
X-Change-ID: 20250313-clr-6a34831628b7
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 May 2025 09:10:43 -0400
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

Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
default write function, which clears written bits instead of writes the
raw value.

PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
had ARM_CP_NO_RAW. Commit 7a0e58fa6487 ("target-arm: Split NO_MIGRATE
into ALIAS and NO_RAW") sugguests ARM_CP_ALIAS should be used instead of
ARM_CP_NO_RAW in such a case:

> We currently mark ARM coprocessor/system register definitions with
> the flag ARM_CP_NO_MIGRATE for two different reasons:
> 1) register is an alias on to state that's also visible via
>    some other register, and that other register is the one
>    responsible for migrating the state
> 2) register is not actually state at all (for instance the TLB
>    or cache maintenance operation "registers") and it makes no
>    sense to attempt to migrate it or otherwise access the raw state
>
> This works fine for identifying which registers should be ignored
> when performing migration, but we also use the same functions for
> synchronizing system register state between QEMU and the kernel
> when using KVM. In this case we don't want to try to sync state
> into registers in category 2, but we do want to sync into registers
> in category 1, because the kernel might have picked a different
> one of the aliases as its choice for which one to expose for
> migration.

These registers fall in category 1 (ARM_CP_ALIAS), not category 2
(ARM_CP_NO_RAW).

ARM_CP_NO_RAW also has another undesired side effect that hides
registers from GDB.

Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
PMINTENCLR and PMINTENCLR_EL1; this fixes GDB/KVM state synchronization
of PMCNTENCLR and PMCNTENCLR_EL0, and exposes all these four registers
to GDB.

It is not necessary to add ARM_CP_ALIAS to these registers because the
flag is already set.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Supersedes: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
("[PATCH 0/4] target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW")
---
Changes in v3:
- Added a reference to commit 7a0e58fa6487
  ("target-arm: Split NO_MIGRATE into ALIAS and NO_RAW")
- Link to v2: https://lore.kernel.org/qemu-devel/20250314-clr-v2-1-7c7220c177c9@daynix.com

Changes in v2:
- Added raw write functions to PMCNTENCLR and PMINTENCLR.
- Dropped the ARM_CP_NO_RAW flag from PMINTENCLR and PMINTENCLR_EL1.
- Link to v1: https://lore.kernel.org/qemu-devel/20250313-clr-v1-1-2cc49df40fe9@daynix.com
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 76312102879b..889d30880794 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1904,7 +1904,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcnten),
       .accessfn = pmreg_access,
       .fgt = FGT_PMCNTEN,
-      .writefn = pmcntenclr_write,
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write,
       .type = ARM_CP_ALIAS | ARM_CP_IO },
     { .name = "PMCNTENCLR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 2,
@@ -1912,7 +1912,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fgt = FGT_PMCNTEN,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
-      .writefn = pmcntenclr_write },
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write },
     { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
       .access = PL0_RW, .type = ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
@@ -2029,16 +2029,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write, },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_R,

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250313-clr-6a34831628b7

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


