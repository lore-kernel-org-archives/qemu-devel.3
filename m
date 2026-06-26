Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316BBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdDZW-00017o-Fp; Fri, 26 Jun 2026 16:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oupton@kernel.org>)
 id 1wdDIB-0006pM-VT; Fri, 26 Jun 2026 16:36:54 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oupton@kernel.org>)
 id 1wdDI9-0005Ap-OB; Fri, 26 Jun 2026 16:36:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14E35600AA;
 Fri, 26 Jun 2026 20:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F31F000E9;
 Fri, 26 Jun 2026 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782506205;
 bh=E+xeZBd97/MILfl6vVEnz7x35bdQO+xqAW2g7gNyAeM=;
 h=From:To:Cc:Subject:Date;
 b=hLAdqnHJtO4wcIkLHpudkx39cmR+UiYJS/dp+6Ak2RD8B2MgYd6dVMD6OTWk/v/MX
 tGf9Z/b/AD5IcfqasBDAE896CNs8FqnYtlk2diN0AjxPyH35Zp83juRDgSLISJFQHN
 65VK7rTIs4AevzTV8NcHOYIKtC4Wt1AVYpzz2gZBXm0MSBOE/lcFRNKagXDD3DhNIM
 yME1/LYBa0Fr/tb8RFa4q2rfzQIpwexFu69qSmxlVXMICEcFdwDO68A0/eFfZMZ4da
 x6KWWLNE9ib2qJO6Or2xb3QdTzHmeeprIbiOQgcxiaPyPVU+fUxlA3fLQZTdroChsf
 y/IjnJVwSYjwg==
From: Oliver Upton <oupton@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Oliver Upton <oupton@kernel.org>
Subject: [PATCH] target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3 is
 present
Date: Fri, 26 Jun 2026 13:36:39 -0700
Message-ID: <20260626203639.431191-1-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=oupton@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Jun 2026 16:54:45 -0400
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

Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
on -cpu max gets stuck in an infinite loop of stage-2 permission faults
due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.

Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.

Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 target/arm/ptw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1470de3010..4a7aeb140c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1414,9 +1414,13 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
                   PAGE_READ | PAGE_WRITE },
     };
 
-    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
-    int s2pi = extract64(pir, pi_index * 4, 4);
+    uint64_t pir = env->cp15.s2pir_el2;
+    int s2pi;
 
+    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN))
+	pir = 0;
+
+    s2pi = extract64(pir, pi_index * 4, 4);
     result->f.prot = perm_table[s2pi][2];
     return perm_table[s2pi][s1_is_el0];
 }

base-commit: 8f1d3b586f1265023f75ea9c227c35d463321aef
-- 
2.47.3


