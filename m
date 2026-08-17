Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4092C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqL-0001If-NJ; Mon, 17 Aug 2026 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqB-000155-AM; Mon, 17 Aug 2026 06:45:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuq9-0003xL-FV; Mon, 17 Aug 2026 06:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=QWvE6AmpBInK6lbFSuehZkneRr61b7k0Z7b3bjFEr/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gqyg+hmyiGXX7XQpKd8BxEhySCXGfrsevvXkzjW6TjXC8SZdpTkDQRFKVp3G50ueH
 7lK0h1F0vGCyu9xtissIO+PhHfQVx3OCJYh9KfGNKgJ0019HOXD6se3VnWLKQd19l9
 6ijS7VluEfVhL69Vwsj0c/IXI4e/+mUol2dCMA1XzpBG/NDXJRwLYlERj5avQTgQ0s
 54QO6A6465ZnueAbgBcQTSp5Dc2FSIC49cZSkVsLFck7RbshAv6tfonZV5hmq/JD8S
 QIAPin/0YDwoL68Vt7ZcEMrJBsQtyp1ODxm0xzhRf22hBBIdSfJPPJXDKWDx5Mtjh0
 BvELs0vvha5WA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60F5A1CBB6A;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6214840D1F8;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EEB3D30E4C; Mon, 17 Aug 2026 13:44:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 125/161] target/s390x: Make PRNO TRNG interruptible
Date: Mon, 17 Aug 2026 13:42:39 +0300
Message-ID: <20260817104344.2047346-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

fill_buf_random() writes the entire guest-requested amount of random
bytes in one go. Since the length is a full 64-bit value, a guest can
request several gigabytes and keep the vCPU spinning inside the helper,
without a chance to react to interrupts.

Do the same thing as HELPER(mvcl): check cpu_loop_exit_requested() at the
bottom of the loop, and when a return to the main loop is pending, stop
and report partial completion with condition code 3.

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: 3dbc5fdacb5a ("target/s390x: support PRNO_TRNG instruction")
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714191948.342204-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit aae77f5dddef62da7e1479c257d99d2ab574df56)
(Mjt: context fixup for v11.0.0-713-gde96db79aa58
 "target/s390x: Compile crypto_helper.c as common unit")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 074d745eb3f..2a947a88c97 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -16,6 +16,7 @@
 #include "qemu/guest-random.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-mmu-index.h"
@@ -245,8 +246,8 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
-                            uint64_t *buf_reg, uint64_t *len_reg)
+static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                           uint64_t *buf_reg, uint64_t *len_reg)
 {
     uint8_t tmp[256];
     uint64_t len = *len_reg;
@@ -267,7 +268,13 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             --*len_reg;
         }
         len -= block;
+
+        if (cpu_loop_exit_requested(env_cpu(env))) {
+            break;
+        }
     }
+
+    return len == 0 ? 0 : 3;
 }
 
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
@@ -280,6 +287,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     int i;
+    int cc;
 
     switch (type) {
     case S390_FEAT_TYPE_KMAC:
@@ -309,9 +317,13 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                             &env->regs[r2 + 1], type);
     case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
-        break;
+        cc = fill_buf_random(env, mmu_idx, ra,
+                             &env->regs[r1], &env->regs[r1 + 1]);
+        if (cc == 0) {
+            cc = fill_buf_random(env, mmu_idx, ra,
+                                 &env->regs[r2], &env->regs[r2 + 1]);
+        }
+        return cc;
     default:
         /* we don't implement any other subfunction yet */
         g_assert_not_reached();
-- 
2.47.3


