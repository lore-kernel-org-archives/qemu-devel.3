Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DCEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uwq-00029L-HB; Fri, 03 May 2024 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1s2uwk-00027C-IO; Fri, 03 May 2024 11:35:38 -0400
Received: from out-184.mta0.migadu.com ([91.218.175.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1s2uwh-0002aO-Rn; Fri, 03 May 2024 11:35:38 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714750531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=54XfP9NU3z3SUadnzHfd4tGzOYczNY9+tkAX9cRT6Ao=;
 b=uhDl4iW9zQ5c0OQAYZsUFdznjGYRio6gEdWGLiwT8Auq13FfmcVnEn+dK0O+4uxaojSkU+
 6oIET8TD5yfMGLAvsIjTQZBynY4gGGrMjXje75ei5cu2INGxnqVRXHeBEgNZI0AfVXTxqr
 6MKb/J1gWGPLGz8f64Uz0H+trLD5EhI=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, wanghaibin.wang@huawei.com,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System
 registers
Date: Fri,  3 May 2024 23:34:53 +0800
Message-Id: <20240503153453.54389-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.184; envelope-from=zenghui.yu@linux.dev;
 helo=out-184.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

We wrongly encoded ID_AA64PFR1_EL1 using {3,0,0,4,2} in hvf_sreg_match[] so
we fail to get the expected ARMCPRegInfo from cp_regs hash table with the
wrong key.

Fix it with the correct encoding {3,0,0,4,1}. With that fixed, the Linux
guest can properly detect FEAT_SSBS2 on my M1 HW.

All DBG{B,W}{V,C}R_EL1 registers are also wrongly encoded with op0 == 14.
It happens to work because HVF_SYSREG(CRn, CRm, 14, op1, op2) equals to
HVF_SYSREG(CRn, CRm, 2, op1, op2), by definition. But we shouldn't rely on
it.

Fixes: a1477da3ddeb ("hvf: Add Apple Silicon support")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c | 160 +++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 08d0757438..45e2218be5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -396,85 +396,85 @@ struct hvf_sreg_match {
 };
 
 static struct hvf_sreg_match hvf_sreg_match[] = {
-    { HV_SYS_REG_DBGBVR0_EL1, HVF_SYSREG(0, 0, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR0_EL1, HVF_SYSREG(0, 0, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR0_EL1, HVF_SYSREG(0, 0, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR0_EL1, HVF_SYSREG(0, 0, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR1_EL1, HVF_SYSREG(0, 1, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR1_EL1, HVF_SYSREG(0, 1, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR1_EL1, HVF_SYSREG(0, 1, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR1_EL1, HVF_SYSREG(0, 1, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR2_EL1, HVF_SYSREG(0, 2, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR2_EL1, HVF_SYSREG(0, 2, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR2_EL1, HVF_SYSREG(0, 2, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR2_EL1, HVF_SYSREG(0, 2, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR3_EL1, HVF_SYSREG(0, 3, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR3_EL1, HVF_SYSREG(0, 3, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR3_EL1, HVF_SYSREG(0, 3, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR3_EL1, HVF_SYSREG(0, 3, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR4_EL1, HVF_SYSREG(0, 4, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR4_EL1, HVF_SYSREG(0, 4, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR4_EL1, HVF_SYSREG(0, 4, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR4_EL1, HVF_SYSREG(0, 4, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR5_EL1, HVF_SYSREG(0, 5, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR5_EL1, HVF_SYSREG(0, 5, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR5_EL1, HVF_SYSREG(0, 5, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR5_EL1, HVF_SYSREG(0, 5, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR6_EL1, HVF_SYSREG(0, 6, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR6_EL1, HVF_SYSREG(0, 6, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR6_EL1, HVF_SYSREG(0, 6, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR6_EL1, HVF_SYSREG(0, 6, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR7_EL1, HVF_SYSREG(0, 7, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR7_EL1, HVF_SYSREG(0, 7, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR7_EL1, HVF_SYSREG(0, 7, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR7_EL1, HVF_SYSREG(0, 7, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR8_EL1, HVF_SYSREG(0, 8, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR8_EL1, HVF_SYSREG(0, 8, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR8_EL1, HVF_SYSREG(0, 8, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR8_EL1, HVF_SYSREG(0, 8, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR9_EL1, HVF_SYSREG(0, 9, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR9_EL1, HVF_SYSREG(0, 9, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR9_EL1, HVF_SYSREG(0, 9, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR9_EL1, HVF_SYSREG(0, 9, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR10_EL1, HVF_SYSREG(0, 10, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR10_EL1, HVF_SYSREG(0, 10, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR10_EL1, HVF_SYSREG(0, 10, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR10_EL1, HVF_SYSREG(0, 10, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR11_EL1, HVF_SYSREG(0, 11, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR11_EL1, HVF_SYSREG(0, 11, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR11_EL1, HVF_SYSREG(0, 11, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR11_EL1, HVF_SYSREG(0, 11, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR12_EL1, HVF_SYSREG(0, 12, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR12_EL1, HVF_SYSREG(0, 12, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR12_EL1, HVF_SYSREG(0, 12, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR12_EL1, HVF_SYSREG(0, 12, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR13_EL1, HVF_SYSREG(0, 13, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR13_EL1, HVF_SYSREG(0, 13, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR13_EL1, HVF_SYSREG(0, 13, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR13_EL1, HVF_SYSREG(0, 13, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR14_EL1, HVF_SYSREG(0, 14, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR14_EL1, HVF_SYSREG(0, 14, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR14_EL1, HVF_SYSREG(0, 14, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR14_EL1, HVF_SYSREG(0, 14, 14, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR15_EL1, HVF_SYSREG(0, 15, 14, 0, 4) },
-    { HV_SYS_REG_DBGBCR15_EL1, HVF_SYSREG(0, 15, 14, 0, 5) },
-    { HV_SYS_REG_DBGWVR15_EL1, HVF_SYSREG(0, 15, 14, 0, 6) },
-    { HV_SYS_REG_DBGWCR15_EL1, HVF_SYSREG(0, 15, 14, 0, 7) },
+    { HV_SYS_REG_DBGBVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 7) },
+
+    { HV_SYS_REG_DBGBVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 4) },
+    { HV_SYS_REG_DBGBCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 5) },
+    { HV_SYS_REG_DBGWVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 6) },
+    { HV_SYS_REG_DBGWCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 7) },
 
 #ifdef SYNC_NO_RAW_REGS
     /*
@@ -486,7 +486,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_MPIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 5) },
     { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
 #endif
-    { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 2) },
+    { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
     { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
     { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
     { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
-- 
2.34.1


