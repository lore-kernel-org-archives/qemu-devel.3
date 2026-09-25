Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED89C9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 00:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAG42-0003T7-7L; Fri, 25 Sep 2026 20:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeff@borto.fr>)
 id 1xAFnY-000278-Eo; Fri, 25 Sep 2026 19:57:48 -0400
Received: from relay.wiredblade.com ([168.235.95.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeff@borto.fr>)
 id 1xAFnV-0001Hm-1S; Fri, 25 Sep 2026 19:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=dynu.com; s=mail;
 b=yKVIijcOi6Tf6xPhxfu+UwW3s4sH7vWI0DFDpcO0eqbEQprxyLqX0+pvFQEJnJSo1PT/ZYS1XhrVbQb4Ir5TTck9OdZ1grU1uP2jKlZJMsvHzo3OnYbAYt/6+ui+1nfE+YfkUSMO0Pjffgyk9hxuOBBpZF1gkoyqCmbUndJiP9Wp+C+OM9FZ4QhVvZuwTqeog825pAdPC+DUZXl5mKJdJVxDTI/StNAtEKIm2jnvq0ZsmMbxIuHmb6Ee4a
 cQ9UNs/WBbp2qOCzF03sg8NUMlfJdblwghShfL4CwMOlHKbL5emE7eFeS1zjH4YArsSLuNkmIGZRPxIdt1wz91kIxI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dynu.com; s=mail;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
 bh=tVxOMaCxaD+dYMmOZTK75JKtzBRDQuT1liae3kU6+0w=;
 b=yT4JqNW0OUZu5vPybYOGk6/H3n+3Vozjk3oaBpFh8Il5/VNB0V4QtcrtoafQGDKXvn38KYZ3j41ARbKFAlnGpZN87Y0ZufCcb1XB3enlPnfol+IyyVLViExHfwSUBKZDpXTbBtZDJeMhBQSEV2LzBNAhAdBhomeNOFYtx1nHiktmR9qWvyn+Tfnj/ztE/g8A4S4F0jaYZtEa7soNko/t5cLcZMEpMGkx8ynHQyFx16b3/VRDGUgf5lKcMY
 pshHGhd897TMwsgdR95axT7hK56c7IqG6eBxydwcT19GjyfyRF5sb7RKKybEkaSecxLmiiYNVpD0XIyJTdGEzUTk0MRA==
ARC-Authentication-Results: i=1; mx.dynu.com;
	dkim=pass;
	dmarc=pass
Received: from borto.fr (lfbn-tou-1-1061-139.w90-76.abo.wanadoo.fr
 [90.76.130.139]) by relay.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Fri, 25 Sep 2026 23:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=borto.fr; s=mail;
 t=1790379727; bh=6QoBM2Q+2htXMJeWNC4OsA0vxD8yomEVCrzi9Xhr3Ic=;
 h=From:To:Cc:Subject:Date:From;
 b=e55udqTeK10pG5DDocFqCAB9BPNKUJa/Mp8EeLSp8djiohS6mVfj8weH3cjjTHhNi
 lStjftlbJDj29zvoYPTbB816BIcTNzQznDmUh56pT0rBULpBsFCVcUM6wMB05pxwc9
 k24JDFWLtCpX6495kM4UMS00Wg9LolfLQtac0TBU=
From: Jean-Francois Bortolotti <jeff@borto.fr>
To: qemu-devel@nongnu.org
Cc: Jean-Francois Bortolotti <jeff@borto.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] target/arm: Fix PMSAv8 shareability decode for R-profile MPU
 regions
Date: Sat, 26 Sep 2026 01:41:36 +0200
Message-Id: <20260925234136.1182108-1-jeff@borto.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mx.dynu.com;
	dkim=pass;
	dmarc=pass
Received-SPF: pass client-ip=168.235.95.80; envelope-from=jeff@borto.fr;
 helo=relay.wiredblade.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 20:14:47 -0400
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

In Armv8-R AArch32 the shareability field of an MPU region lives in
PRBAR, not PRLAR:

  PRBAR: [31:6] BASE  [5] RES0  [4:3] SH  [2:1] AP  [0] XN
  PRLAR: [31:6] LIMIT [5:4] RES0  [3:1] AttrIndx  [0] EN

(Arm Cortex-R52 TRM 100026_0103_00_en: Tables 3-80 and 3-83 for
HPRBAR/HPRLAR, Tables 3-124 and 3-127 for PRBAR/PRLAR.)

Without this fix, address translation instructions like ATS1HR
will return wrong value for PAR.SH.

Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.34.1


