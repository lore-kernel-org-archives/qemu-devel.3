Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E967EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVO-00034z-Bo; Mon, 17 Aug 2026 09:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVL-00033o-PN; Mon, 17 Aug 2026 09:35:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVJ-0007IW-Nr; Mon, 17 Aug 2026 09:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=Ety++kSWc2iiwB3S2F+jM9QhUMjvlpDaSgWE3k1ptao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RnTN/qz2CjKwrcyU7pK2o3LGNkXi54Qg2QWD3eeBogAMA0rc7z0y5b+YoNC8L/bO5
 JlBXJ4WWLztrLqp3DfxBC7r9I4lLfBju93G2/9NFdBwyN/gkqISflv0kFQlT08owI0
 MdmEmryXZybNCXDAI/wdIaFOpTvgZUjpEzgLfW972WIzOk67HHhhemWuZ2lw3sVFma
 D/cwvGu3yQnPDXzpcEcODEDkZrsp7MnMgVH6p7wEoYSM2w/B1XrKlTdd6LOPSyQJNZ
 6P1d51GhLN6bC26GrN1Uuvac0jOxOYLjmg6jBwZSdzei8jqnhlhDo6lYR10CBySC8w
 iQsFNo4oAE8rw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07D3A1CBCB8;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42E9540D415;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8F69330F7A; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 105/135] target/s390x: Have MSA helper pass a
 mmu_idx argument
Date: Mon, 17 Aug 2026 16:34:15 +0300
Message-ID: <20260817133451.2384630-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Next commit will use the cpu_ld/st_mmu() API and thus
will also use a @mmu_idx. In order to keep it simple to
review, propate @mmu_idx in a preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-8-philmd@linaro.org>
(cherry picked from commit fcc2699d41ede314e76c9f0fe5ddb5a1156620ae)
(Mjt: pick this (basically no-op) one up so subsequent changes applies easily)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 93aabd236f4..2e998b628c2 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -120,8 +120,8 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
     sha512_bda(a, t);
 }
 
-static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
-                            uint64_t a[8], uintptr_t ra)
+static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -131,8 +131,8 @@ static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
-                             uint64_t a[8], uintptr_t ra)
+static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -142,8 +142,8 @@ static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_block(CPUS390XState *env, uint64_t addr,
-                              uint64_t a[16], uintptr_t ra)
+static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint64_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -153,8 +153,8 @@ static void sha512_read_block(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
-                                 uint8_t a[16], uintptr_t ra)
+static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -164,8 +164,9 @@ static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
-                      uint64_t *message_reg, uint64_t *len_reg, uint32_t type)
+static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                        uint64_t param_addr, uint64_t *message_reg,
+                        uint64_t *len_reg, uint32_t type)
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
@@ -183,7 +184,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha512_read_icv(env, param_addr, a, ra);
+    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
 
     /* Process full blocks first. */
     for (; len >= 128; len -= 128, processed += 128) {
@@ -193,7 +194,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
             break;
         }
 
-        sha512_read_block(env, *message_reg + processed, w, ra);
+        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
         sha512_bda(a, w);
     }
 
@@ -216,13 +217,13 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
          * or use an additional one.
          */
         if (len < 112) {
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
         }
         sha512_bda_be64(a, (uint64_t *)x);
 
         if (len >= 112) {
             memset(x, 0, 112);
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
             sha512_bda_be64(a, (uint64_t *)x);
         }
 
@@ -237,14 +238,14 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha512_write_ocv(env, param_addr, a, ra);
+    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
     return !len ? 0 : 3;
 }
 
-static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
+static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
 {
     uint8_t tmp[256];
@@ -272,6 +273,7 @@ static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     const uintptr_t ra = GETPC();
     const uint8_t mod = env->regs[0] & 0x80ULL;
     const uint8_t fc = env->regs[0] & 0x7fULL;
@@ -304,11 +306,11 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         }
         break;
     case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
+        return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                             &env->regs[r2 + 1], type);
     case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, ra, &env->regs[r2], &env->regs[r2 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
         break;
     default:
         /* we don't implement any other subfunction yet */
-- 
2.47.3


