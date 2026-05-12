Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023DFCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuOn-0004Dw-GJ; Tue, 12 May 2026 17:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOb-0003p1-TN; Tue, 12 May 2026 17:12:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOZ-0004gW-DT; Tue, 12 May 2026 17:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=3w4BZEGu5+aMcubKWy0KGPpOR0vSYNmr/c/r2eJy0TE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LBCEAPJz9WkTGYw8kjtPhvsYYK+GwZmrgoXdBfx2imDsffonw1Cr9dRekQF2rkA1C
 eqU6xSbveh4RQNUxZBgFxveyQK6PF119sxgMAgqqI/WbC+j9icKu1XlrD/YZrnD9c4
 exOH0oSQuy2fWgPlWW4ORW/TGx6hMCwb8GqlBMS5bIDbIpedPVDZho+weP/5W0+NiJ
 7imCC2My5Gj2a739V5O5ooE2ut2ProBcAIiNIzQfvHL6eAmq2YRnR74sWcC+oBHuiC
 Xkx55hqmMWbPVatuuA/p8Z9orPOsba9d9W3mR81KPrltX6BNofMHvMYh3tdhfmMNB5
 r54IAnyI/m15w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FABA1AA379;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AADE33ABCE8;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 059/117] target/arm: fix fault_s1ns for stage 2 faults
Date: Tue, 12 May 2026 23:54:01 +0300
Message-ID: <20260512205503.361097-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

The computation of s1ns was simply wrong. For Stage 2 faults, it
should indicate whether the faulting IPA is in the Non-Secure IPA
space. Correct the logic to check for ARMSS_NonSecure and drop the
extraneous s2_mmu_idx test.

This is effectively a change in the intended semantics of the
ARMMMUFaultInfo::s1ns field, so that we no longer try to make it
exactly match HPFAR_EL2.NS but instead set it for any stage 2 fault
on an NS IPA, relying on users of the field to check whether the
fault is to be taken to Secure EL2 before propagating the field to
the HPFAR_EL2.NS bit.  Since the actual writing of HPFAR_EL2.NS is
already gated by arm_is_secure_below_el3(env), we only need to update
the comments to document this change of semantics.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260405112410.603223-1-alex.bennee@linaro.org
[PMM: also update comments about the s1ns field]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 566594f10873723a179057a604d890bfaa1a9f0a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d5f6d6546f..6434331ef2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -739,7 +739,10 @@ typedef enum ARMGPCF {
  * @paddr_space: physical address space that caused a fault for gpc
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
- * @s1ns: True if we faulted on a non-secure IPA while in secure state
+ * @s1ns: True if we faulted on a non-secure IPA. Note that (unlike the
+ * HPFAR_EL2.NS bit) this is set for any stage 2 fault for an NS IPA, so
+ * code must check that this is for a fault taken to Secure EL2 before
+ * propagating s1ns to HPFAR_EL2.NS.
  * @ea: True if we should set the EA (external abort type) bit in syndrome
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e96b1c11e8..3e3c467eb2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -613,12 +613,14 @@ static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
 static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
 {
     /*
-     * For stage 2 faults in Secure EL22, S1NS indicates
-     * whether the faulting IPA is in the Secure or NonSecure
-     * IPA space. For all other kinds of fault, it is false.
+     * For stage 2 faults, S1NS indicates whether the faulting IPA is
+     * in the Non-Secure (true) or Secure (false) IPA space. For all
+     * other kinds of fault, it is false. Note that we do not
+     * distinguish "s2 fault on NS IPA taken to Secure EL2" from
+     * "s2 fault on NS IPA taken to NS EL2 or Realm EL2" here, but
+     * instead do that when setting HPFAR_EL2.NS.
      */
-    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
-        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
+    return space == ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);
 }
 
 /* Translate a S1 pagetable walk through S2 if needed.  */
-- 
2.47.3


