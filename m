Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4685BC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lfc-0001uB-Du; Wed, 16 Sep 2026 05:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfL-0000s3-64; Wed, 16 Sep 2026 05:10:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfJ-0007u7-12; Wed, 16 Sep 2026 05:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=5mRNP4fYxArzWn6ZOjq1iLjKJyV1PsBhJC9+gdnHIjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rcXbweBCMFGzMmRePFnWG/8gkq4fFBU3Amh8+M0NO9OUH3BVFTYojPmUkV8zPsytc
 VfVhJ2gINmzUUw9eyfVXFG2/IK8lU3tLAHBlFIiEbHk/Jw3ILg49WAYlc0G1cYCENL
 03hng+YqtUmp+8XTxpXgaCx+HpOCh6GndVJaRo2GhUkPRRyPeLAz/xz/ErzT9RShlS
 xQfngkU8GpVj6s9V8dPHww0koOueVVZ17zKqDFpye3kjCsUsw3niz+GXaBa3OyR5Ej
 Tl5t8DWdlNg1uqsRD5mzAqA/P0Gf0IT67wvOT/S70RoG/oQTBzR6cF/oRe9Gkg60gA
 L59L7Uve7LuBw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D2C11D56EC;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 18E94429E4B;
 Wed, 16 Sep 2026 12:06:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE1575A7C7; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Doug Cook <dcook@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 55/57] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
Date: Wed, 16 Sep 2026 12:04:19 +0300
Message-ID: <20260916090516.677749-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Doug Cook <dcook@microsoft.com>

ARM_CP_CONST registers ignore writes, so readback assertion fails.

Not asserting now because all entries in the whpx_sreg_match table are
invalid. Needs to be fixed now so that we can fix the table entries.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

(cherry picked from commit 6ae0b04267052bca51fe2f3c99e7053c6fdc19ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be961..d72523e646c 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -223,6 +223,8 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
     { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
 #endif
+#ifdef SYNC_CONST_ID_REGS
+    /* ID registers are ARM_CP_CONST (writes ignored).  */
     { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
     { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
     { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
@@ -235,6 +237,7 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
     { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
     { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
+#endif
 
     { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
     { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
@@ -794,7 +797,7 @@ int whpx_init_vcpu(CPUState *cpu)
 
         ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
         if (ri) {
-            assert(!(ri->type & ARM_CP_NO_RAW));
+            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));
             whpx_sreg_match[i].cp_idx = sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
         } else {
-- 
2.47.3


