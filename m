Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743DDCD3442
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcus-0000va-WF; Wed, 06 May 2026 10:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuh-0000Tj-Gi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuf-0001yf-ES
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b150559bso44967485e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076462; x=1778681262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0nvgup5yA+TVirBzshOkEAlxX6Plz/Eb10z3ot7vtvM=;
 b=w/15LdEGHALXv+v4FleBSAxmbU+ebF0uz38+ZIXPtC8dYsZYZN2AmrpkX9tQCGjMWt
 i6Enxscv6dqk6FSt6idSyO6+PWLDpkApwllMn/3obCyA7pQBvm8RNZsBqq1RuOu1w43z
 zD1m36GUdAh8g+aAQkiKiY4hqhDvUSseClIXLxYR7VYZD2kvn5j62+SvK6qXj8Jhyh97
 pDgjQYkeO0XNNnUO1dKJYWGt/VLl8dyXJubzLPBnxmprRTJ/bWNmx+mh4MP/Dyk0HnSa
 QjjfsPWHODAwXkrV0M8x44FMX1PyXXltUZ69ZydGtQAQGKtwNShaDfIapEX2eJmWtYjY
 46uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076462; x=1778681262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0nvgup5yA+TVirBzshOkEAlxX6Plz/Eb10z3ot7vtvM=;
 b=sskEaGfifRWOwixiSve8S0U3pxhCi4WVDsbYaNt2ywJ3nw5f1WwEteliFlVUs/mPa4
 Ix1YWkFOe/Mj7abnOpwhWOn725yYbZ7Jzt68TSJoFDcEU9w6dSWnHs5Uga9HSpCJtDVe
 DtI7/2dp3PZ+CARws5gRUAdIbH8dWJ4XJdrfRuYvgMNDHyeUp3qUVGb2/tfyPMifDkyg
 4MPkzvETHOl/4dEg8a54jVxfizu+1nquajdDrejuLRpbs66jxNHkLBOZzU/OoOrYFett
 kn8y2KlKnibYYzDLJpnTr6Q692sRo195i25kzJzb1hjeys6oveZ0cOatScJkbcsL5VOq
 +NfA==
X-Gm-Message-State: AOJu0Yw8Pw6TUk5FysdnJGAKIHEpgeN104nBc4GDaHQniR8YZ3rY99dR
 F60aIZgT2xM4CPafjB4cIbxy5e2+EU+7tqMybbp3K60K8iRmvpg3TPh7CTk/FC0D0qc8I7zTSSU
 /ChKk2cs=
X-Gm-Gg: AeBDiet9oMJwb7B6oTo1MPZ7Rq+WcyB4c/itW+pfMHY0Fsi8jB7Ruho9K2F9y+kOpCo
 6/VtxZJz3gR6vXVcP+PSkC614cQItZaQk6SzmMhjUsXeg9Cx8ykaDcR8Mfj5vzYgLfFRYtQdvwP
 K6CAg1HCCPW+/llZFTAw9xKewcYZ4uZY0uURhmRLUEqXoHhahRWewJcbxdQ31DXtb4syMCoQmKk
 SsXZ/bMXtz2kb8H9YgUmNd7reE+IfRuVaxZh5AGTOOq80jB0g/hE5rcTZy2andtQV7Ve3wI+HMZ
 8GzctOnWGeI40us3D7DBilfmKUKx1Z7jpvG5VAgPHdGdje0dWF3h9zfRev5dLolJJv0Y4Wz7G9/
 a5flX2gzPO7jr6YG0Z20/6xV2xIvYIJF3Yr2HgjHXVkmD1TwBHSJB3KgG9PZ9Duq3kma7zRqsLR
 6RPsmpAFMtWxr4gWKLN/d9hYC0eX4mtQo7BRDmPa7sxwy4UrKotW5D1EfHPIx9TUq82ngAp3fU9
 tQUbXLUzMA0qb87A0j60g==
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48e52bd5035mr63305265e9.14.1778076462486; 
 Wed, 06 May 2026 07:07:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538acbfcsm46580525e9.8.2026.05.06.07.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 093/110] target/s390x: Have MSA helper pass a mmu_idx argument
Date: Wed,  6 May 2026 15:55:05 +0200
Message-ID: <20260506135524.20617-94-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Next commit will use the cpu_ld/st_mmu() API and thus
will also use a @mmu_idx. In order to keep it simple to
review, propate @mmu_idx in a preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-8-philmd@linaro.org>
---
 target/s390x/tcg/crypto_helper.c | 41 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 4447bb66eee..074d745eb3f 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -18,6 +18,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-mmu-index.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -119,8 +120,8 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
     sha512_bda(a, t);
 }
 
-static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
-                            uint64_t a[8], uintptr_t ra)
+static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -130,8 +131,8 @@ static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
-                             uint64_t a[8], uintptr_t ra)
+static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -141,8 +142,8 @@ static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_block(CPUS390XState *env, uint64_t addr,
-                              uint64_t a[16], uintptr_t ra)
+static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint64_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -152,8 +153,8 @@ static void sha512_read_block(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
-                                 uint8_t a[16], uintptr_t ra)
+static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -163,8 +164,9 @@ static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
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
@@ -182,7 +184,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha512_read_icv(env, param_addr, a, ra);
+    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
 
     /* Process full blocks first. */
     for (; len >= 128; len -= 128, processed += 128) {
@@ -192,7 +194,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
             break;
         }
 
-        sha512_read_block(env, *message_reg + processed, w, ra);
+        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
         sha512_bda(a, w);
     }
 
@@ -215,13 +217,13 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
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
 
@@ -236,14 +238,14 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
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
@@ -271,6 +273,7 @@ static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     const uintptr_t ra = GETPC();
     const uint8_t mod = env->regs[0] & 0x80ULL;
     const uint8_t fc = env->regs[0] & 0x7fULL;
@@ -303,11 +306,11 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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
2.53.0


