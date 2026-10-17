Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C00ECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0C-0005Co-As; Sat, 17 Oct 2026 16:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIAzl-00057k-Ip; Sat, 17 Oct 2026 16:27:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIAzd-0003t3-L6; Sat, 17 Oct 2026 16:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268817; bh=5szADkSqt+Y+KJByQCD4jhduzE0A1PK/3Wrx2/eB+rs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MQhrL91WZSqol8lTRVuwnw0EtoThdtaPicbZdPcjY9UZfq442fHY2tIBvO8XeBg9u
 klqt9EpnnZfsv4HpjzRMA2sKzIMnP91M5JSuhwD1pvAwL2Zzg9gm/7W5X1a1NiA/9F
 4Uvv9GvMV6unppQja40sHIhKumQPzXc6Hd9+j/5nZU8caDOlZ0E7sLkg7UbhoNNHVa
 rMkoHEYdjSP4wqk25N7XrrkIDLp8rBU4NOM9eRsOgICiS0uhgQoI5sjVNe5XYXwAPu
 SN/GkJ0Z2CSeTDXWzaACmY6WWUgj82PPva+xBjBFqlvNQfUDpsMam8oz/i+qQSeVPx
 2ecGeZD9w66LQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3B571DE73C;
 Sat, 17 Oct 2026 23:26:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 01262443413;
 Sat, 17 Oct 2026 23:26:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jean-Francois Bortolotti <jeff@borto.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 01/73] target/arm: Fix PMSAv8 shareability decode for
 R-profile MPU regions
Date: Sat, 17 Oct 2026 23:25:19 +0300
Message-ID: <20261017202638.728621-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f..663a4862a4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3085,7 +3085,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         if (!arm_feature(env, ARM_FEATURE_M)) {
             uint8_t attrindx = extract32(matched_rlar, 1, 3);
             uint64_t mair = env->cp15.mair_el[regime_el(mmu_idx)];
-            uint8_t sh = extract32(matched_rlar, 3, 2);
+            uint8_t sh = extract32(matched_rbar, 3, 2);
 
             if (regime_sctlr(env, mmu_idx) & SCTLR_WXN &&
                 result->f.prot & PAGE_WRITE && mmu_idx != ARMMMUIdx_Stage2) {
-- 
2.47.3


