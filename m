Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AADC44507
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifmn-0007HR-Ct; Sat, 11 Jul 2026 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifme-00077b-6q; Sat, 11 Jul 2026 18:02:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmc-0008TK-Km; Sat, 11 Jul 2026 18:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=3RD5JNOkSPrWlHNEmA/+dJRj4CoMpMAytqA+nPxw8uA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wBP3KE+yLd8eolA8NCcPdUUjrYz92P5129QQmtSIygRqmtyB1lAskK1uSd5mp+xIT
 xvagADwqLHNAytlJFSrQjVh+0LSzy7Uk5TA3Vj9CcL821+WhDloJFYJevjWjrXiwuP
 SeWVw56QgVNfoSVIniy09j3+VYRV62KHal2vbl6OFYjgP5hftkpZlS7P9YO4dVzrRO
 X/cU18+n/WEAPQB6Ap5y4GGV11y8ktOD05FJ/VjZx+4e8hYaa71NgNgT2Wjt8UwgPl
 KOIhvJsSjasrQoKBVD8ocsxnSWRky/PcJyRlLsUDb1TJNi4K8YseJsluboswzI9a+R
 kUeQAi/eXIoIQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3D0B1C0AAE;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 98C353EAF39;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 89F8B13329; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Oliver Upton <oupton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 35/81] target/arm: Only evaluate SCR_EL3.PIEN if
 ARM_FEATURE_EL3 is present
Date: Sun, 12 Jul 2026 00:58:13 +0300
Message-ID: <20260711215904.3757-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Oliver Upton <oupton@kernel.org>

Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
on -cpu max gets stuck in an infinite loop of stage-2 permission faults
due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.

Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.

Cc: qemu-stable@nongnu.org
Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Message-id: 20260626231738.947317-1-oupton@kernel.org
[PMM: removed hardcoded tab]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d77a93ca4b53da18ce01c5b7678e0eb435851919)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b39..df98cf87aaf 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1392,9 +1392,14 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
                   PAGE_READ | PAGE_WRITE },
     };
 
-    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
-    int s2pi = extract64(pir, pi_index * 4, 4);
+    uint64_t pir = env->cp15.s2pir_el2;
+    int s2pi;
 
+    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN)) {
+        pir = 0;
+    }
+
+    s2pi = extract64(pir, pi_index * 4, 4);
     result->f.prot = perm_table[s2pi][2];
     return perm_table[s2pi][s1_is_el0];
 }
-- 
2.47.3


