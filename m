Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F616C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CMC-0004iC-1T; Mon, 14 Sep 2026 15:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CM4-0004a4-Sj; Mon, 14 Sep 2026 15:28:41 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CM3-000303-Bt; Mon, 14 Sep 2026 15:28:40 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hkFYx6D3NzBqPV;
 Mon, 14 Sep 2026 21:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789414117;
 bh=mZeRvHBGZjvTQDaNJAFKTjoSRtReNyYV8QT57TH3mGU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uabNaIEbPTfsU1CRhmpWK3IvsmgbIiqUWrglHY1YnBBDf6Z6KTm5aam05V0YOG440
 /v9WJPzCS3WLXZFiCQOJ52KoAR2/vMmjGqzP/YboYjwOK7yGt5VZlDntQj6nU5Hz/7
 FbAhbFupExrCNn5Y7SUT/fi5wXybWJxUwWpx/AQUjOUK1cICXXDoflvxfgF7SHDhh+
 lji5MvJKrQk2wn69FvfcNPpaprNEBnmzEY2GqBrS6A5xDneVgTuktlngMu+/Cvs5SI
 gWzqfHDtXFWUcYV5OCHJ3uBpXl8A/3K9v5oZ/N11uLgRBth3nqcmBaAXIdwwM9YkeW
 FyXspFlwCESdg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hkFYx4hMhz6skd;
 Mon, 14 Sep 2026 21:28:37 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 5/6] target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
Date: Mon, 14 Sep 2026 21:23:21 +0200
Message-ID: <20260914192323.29250-6-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PMSAv7 walk accepted any non-zero region size field, but Armv6-M
requires a minimum of 7 (256 B), Armv7-M requires 4 (32 B) and v7-R
retains its current minimum of 1 (4 B). Introduce rsize_min based on
ARM_FEATURE_M and ARM_FEATURE_V7 and reject smaller values. The PMSAv8
path is handled earlier and remains unchanged.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 target/arm/ptw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f..cb9e73fc0a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2720,6 +2720,11 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
+    uint32_t rsize_min = 1;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        rsize_min = arm_feature(env, ARM_FEATURE_V7) ? 4 : 7;
+    }
 
     result->f.phys_addr = address;
     result->f.lg_page_size = TARGET_PAGE_BITS;
@@ -2748,11 +2753,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                 continue;
             }
 
-            if (!rsize) {
+            if (rsize < rsize_min) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "DRSR[%d]: Rsize field cannot be 0\n", n);
+                              "DRSR[%d]: invalid Rsize field 0x%x\n",
+                              n, rsize);
                 continue;
             }
+
             rsize++;
             rmask = (1ull << rsize) - 1;
 
-- 
2.55.0


