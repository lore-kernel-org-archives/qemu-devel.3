Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553F7CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zv-0008IP-U3; Sat, 17 Oct 2026 14:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ZZ-0008Aw-1A; Sat, 17 Oct 2026 14:56:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ZX-0003ai-Ey; Sat, 17 Oct 2026 14:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263354; bh=fxET2QOjN+fT/CwIwNfkH5QJ6w6E85MB8X/jd0TrUkY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xkxcm9J4uOjFnfj92oQYkd0Y7JZhtFNhilK9eYASRta68tgYc5tEUNDk/8LNCGXFs
 SvLakBwtyEqPTXBFBIT2QOMpJ3K39Y0eDDm72Xs4yxtIj/bXGmpaSnTXuZANpnctR0
 VcRDs+Q29/+Fl3hPyn+mn+Nf9altwK7hQdyYR7aC/fW/hNvX8pZmg+g1MHqZ5mjrKn
 u5G8minV80+dMyAcea4s4ULKoeelSQ5J1HwJz7vc2CESzEGxHKFAiSP23/1QVhOybi
 vvKLidvT++JruZxTM+tEt6u1aPpExYNXNCOrBP/PulQ7rMOwYpVvcnIf53mYQI2YsN
 sKxDQAO8fM1Ag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 561781DE6A1;
 Sat, 17 Oct 2026 21:55:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2DB2444336C;
 Sat, 17 Oct 2026 21:55:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jean-Francois Bortolotti <jeff@borto.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 01/63] target/arm: Fix PMSAv8 shareability decode for
 R-profile MPU regions
Date: Sat, 17 Oct 2026 21:54:17 +0300
Message-ID: <20261017185528.722197-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Jean-Francois Bortolotti <jeff@borto.fr>

In Armv8-R AArch32 the shareability field of an MPU region lives in
PRBAR, not PRLAR:

  PRBAR: [31:6] BASE  [5] RES0  [4:3] SH  [2:1] AP  [0] XN
  PRLAR: [31:6] LIMIT [5:4] RES0  [3:1] AttrIndx  [0] EN

(Arm Cortex-R52 TRM 100026_0103_00_en: Tables 3-80 and 3-83 for
HPRBAR/HPRLAR, Tables 3-124 and 3-127 for PRBAR/PRLAR.)

Without this fix, address translation instructions like ATS1HR
will return wrong value for PAR.SH.

Cc: qemu-stable@nongnu.org
Fixes: fca45e3467f7 ("target/arm: Add PMSAv8r functionality")
Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
Message-id: 20260925234136.1182108-1-jeff@borto.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 653b0c06c83d761667474b29ebfb8a312f317c3a)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 92d6bd9d40..fa6973adf1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2720,7 +2720,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         if (!arm_feature(env, ARM_FEATURE_M)) {
             uint8_t attrindx = extract32(matched_rlar, 1, 3);
             uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
-            uint8_t sh = extract32(matched_rlar, 3, 2);
+            uint8_t sh = extract32(matched_rbar, 3, 2);
 
             if (regime_sctlr(env, mmu_idx) & SCTLR_WXN &&
                 result->f.prot & PAGE_WRITE && mmu_idx != ARMMMUIdx_Stage2) {
-- 
2.47.3


