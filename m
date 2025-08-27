Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJb8-00088E-2E; Wed, 27 Aug 2025 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJaP-0006lY-64; Wed, 27 Aug 2025 13:05:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJaL-0007yf-Ld; Wed, 27 Aug 2025 13:05:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0058814C731;
 Wed, 27 Aug 2025 20:03:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11CDE2698F7;
 Wed, 27 Aug 2025 20:03:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 15/18] target/arm: Fix handling of setting SVE
 registers from gdb
Date: Wed, 27 Aug 2025 20:03:50 +0300
Message-ID: <20250827170356.2698446-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

The code to handle setting SVE registers via the gdbstub is broken:
 * it sets each pair of elements in the zregs[].d[] array in the
   wrong order for the most common (little endian) case: the least
   significant 64-bit value comes first
 * it makes no attempt to handle target_endian()
 * it does a simple copy out of the (target endian) gdbstub buffer
   into the (host endan) zregs data structure, which is wrong on
   big endian hosts

Fix all these problems:
 * use ldq_p() to read from the gdbstub buffer
 * check target_big_endian() to see if we need to handle the
   128-bit values the opposite way around

Cc: qemu-stable@nongnu.org
Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250722173736.2332529-3-vacha.bhavsar@oss.qualcomm.com
[PMM: adjusted commit message, fixed spacing]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 97b3d732afec9b165c33697452e31267a845338f)
(Mjt: s/target_big_endian/target_words_bigendian/ due to missing
 v10.0.0-277-gb939b8e42a "exec: Rename target_words_bigendian() -> target_big_endian()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 2dc058fcd6..fdbe6ffbd0 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -188,10 +188,17 @@ int arm_gdb_set_svereg(CPUARMState *env, uint8_t *buf, int reg)
     case 0 ... 31:
     {
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq++) {
-            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
-            env->vfp.zregs[reg].d[vq * 2] = *p++;
+            if (target_words_bigendian()) {
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+            } else{
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+            }
+            buf += 8;
             len += 16;
         }
         return len;
@@ -206,9 +213,9 @@ int arm_gdb_set_svereg(CPUARMState *env, uint8_t *buf, int reg)
     {
         int preg = reg - 34;
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
-            env->vfp.pregs[preg].p[vq / 4] = *p++;
+            env->vfp.pregs[preg].p[vq / 4] = ldq_p(buf);
+            buf += 8;
             len += 8;
         }
         return len;
-- 
2.47.2


