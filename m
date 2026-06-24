Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89976CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNmF-000626-8H; Wed, 24 Jun 2026 09:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNmB-0005uM-Ij; Wed, 24 Jun 2026 09:36:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNm9-0000sm-Rk; Wed, 24 Jun 2026 09:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307997; bh=1SLei3wOec+IuksXol0hfWzvxEzayfmod70lDXMUvdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NTOSYzzBNIYHxE+0mNSdfTPVztLJbEFK9vuFmNp4N7QCt+jCmqpM+1VqNyPf1TJqb
 oc6UM6NLqonx3uqoRIKDO3wTdqf5HKVrX04r/eRE/9VS2mB7I10NnP1duDTNjtUy+M
 h9NAclPVD2a1dFC/4QSSSAhS+Cm5l0hXy9R1VtVYys6c2S8LiYUqfz5QczFUE9Rld6
 EOR9IWqj8LpwZ9OwV+BzZ4EMnEg4diFJTbHES7djyYGBHlkKcaHUKlc8UGAg9PXqvo
 lIrpUebfilzoh60Z0L4NX9gdijx0+NXX799BwjHrAl/IzxUXl9+dAhorFIjlr8h5id
 1bBlrmW0xwNsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E8801BA9D4;
 Wed, 24 Jun 2026 16:33:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B8A33DEA23;
 Wed, 24 Jun 2026 16:33:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 034/107] target/arm: Don't assert if 64-bit EL2 AT
 insn sees a Domain fault
Date: Wed, 24 Jun 2026 16:30:39 +0300
Message-ID: <20260624133301.403266-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

The Domain fault type can only happen for 32-bit short-format
descriptors.  This means that it almost never needs to be encoded in
a long-format fault status code.  However, there is one corner case
where we do need to report it as a long-format FSC: if a 64-bit EL2
does an AT insn on an AArch32 EL1&0 translation regime that is using
short-descriptors and that translation operation hits a Domain fault,
then this is reported in the PAR_EL1 in long-format.

The PAR_EL1 register description defines that this should be reported
as 0b111101 for a level 1 Domain fault or 0b111110 for a level 2
Domain fault.

The Arm ARM pseudocode special cases this in the function
AArch64_PARFaultStatus() (because no other "fault to LFSC" code path
can be a Domain fault).  For QEMU, implement it in arm_fi_to_lfsc().

Cc: qemu-stable@nongnu.org
Fixes: 1fa498fe0de97 ("target/arm: Provide fault type enum and FSR conversion functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3512
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260526174155.2491217-1-peter.maydell@linaro.org
(cherry picked from commit bb957530471c792a9a51e822a6c2fa8398cc48f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69..556c0729c7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -872,6 +872,16 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
         assert(fi->level >= 0 && fi->level <= 3);
         fsc = 0b001100 | fi->level;
         break;
+    case ARMFault_Domain:
+        /*
+         * This can only happen when doing an AT insn at EL2 for an AArch32
+         * stage 1 EL1&0 translation regime using short-descriptors, and
+         * the translation hits a Domain fault. This needs to be reported in
+         * the long-format PAR. Compare pseudocode AArch64_PARFaultStatus().
+         */
+        assert(fi->level == 1 || fi->level == 2);
+        fsc = 0b111100 | fi->level;
+        break;
     case ARMFault_Translation:
         assert(fi->level >= -1 && fi->level <= 3);
         if (fi->level < 0) {
-- 
2.47.3


