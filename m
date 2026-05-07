Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA912CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72N-0000tY-K0; Thu, 07 May 2026 18:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72M-0000sn-EV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:42 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72J-0003FQ-PZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:41 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-43454c72d2bso513805fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192257; x=1778797057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H48kL1TGtLHSlE6jIiyOAdlJRT3IfBPUgx3FRBLUEz4=;
 b=RR8I6FgdxEAWFrXLVBIItCb4I1+RU9ea1tzHo7wyTTQa3xSdSC/HoBOIyUTtyN/Eas
 Za3Jaj2q1C6aL4uPpHqhi1r+ruU/Fbn3kG80ejbvn3zvwzlsQeTbCRW8XnzflaVh+VPE
 RdmPVmjGqNfnGUCdl1e5VNmCQ7P3Wc+Bh5OjuRZrYN44tijYLr8raPK/d3pfzoYXVpZm
 gjT30s+odxMWvlMEy4vb0r9Brg4GaLNUJuaS5NbNyXD65aXhwQx2QwrGvj1Y73HogvR1
 bP0fi5sPbJh1TAt3YQFQTO7VhRIkjLjJW1no2KXD4y/CgzWcjW8DEfcr/J+0HOIohCr/
 XO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192257; x=1778797057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H48kL1TGtLHSlE6jIiyOAdlJRT3IfBPUgx3FRBLUEz4=;
 b=PhLY9LcY+pE/InrzF2d/FhyhQHywxzxPEr9Py/ps7M+fZyuotFeoddYHFbqxZwbdDE
 mZXIhL9cV+nt3ngUtmUvpeIdIj7uusoRBfpc1PrzkhtlPi5r5dWC8K6dN/LD1NUURPuS
 3ro4u+/md24WnDq1HmGpLyZ9fGlbqQA28HZK2LhNWiEnONdET/ebZwyjo9c/TP7U5pqi
 rS8PaihDDA2uBgpGW/7/88tPqD06Bt9yAF8RGru8Db1fuTLwDLve8KH5CSJ+JQ1bS400
 5MjxgBcXw/0VboM3KldgU+ZjDpDdfrOvnp2gJnRmkMH1dNIWKDFXPDMCFoKf8hO57yIt
 mKzg==
X-Gm-Message-State: AOJu0YwTfVgTTOH5qZvWoWKb1l44Ff/f0rIQU9soyHYMvkjv9s0BKdI/
 h3He7JsnxVXqpuImfhCX9ASkX1x2TQt84L0rO2a0XK2b8LBjSM7R2LaTIFlznktfhjOJ6ZK4LlD
 Jga2f
X-Gm-Gg: AeBDieuNL3S8kquQBXSQDQXE7CbCJHYzkENnZabWxc6OBs5a4nbN95FtEBvqIzXQ+Oj
 lgnF87GdJlXKDNCfHbuweXdlOhmYRhhze+juu1FxzWJtc1lpzHH0lNaVu5VrbL/1l46ruNq+mCd
 5sFtIM8NZEA+/JBCLsJ3eM5CbQQwOvqRhetbrlgrUy/NR1CYZGw5mIRYrBTU1y85PJYl4DpBnyR
 Wd5baqOsqT09PlhLD0c1E4rdP2KiuIBHAW9n21LfLnoDumz7MPuoerRT7OMN+HJi5jsE4gJBOnD
 ngI2fC/XzqMkkJUfWlSkCVakFDiPHlWKv49zLHjwy/+YBMyEK8y57XVoy+hOvIrHfpXGy0j506U
 QQAddAn5RW0M5ePGbgW0T5dIvkbSawoLoM3+LyPZr0zz3ycONEK8CWtZnzKggUfgIZtb7cCkxZp
 5lLGgWDQhcKo6uHJnoJ4Wq7RZUNZ/rnusWhxuGqTLNkJw5PjsXKcqquExT
X-Received: by 2002:a05:6871:a60b:b0:417:6224:5855 with SMTP id
 586e51a60fabf-434f4e8e8b9mr6251870fac.0.1778192257408; 
 Thu, 07 May 2026 15:17:37 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/18] fpu: Use {get,set}_flush_inputs_to_zero everywhere
Date: Thu,  7 May 2026 17:17:13 -0500
Message-ID: <20260507221717.486023-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 14 +++++++-------
 target/alpha/fpu_helper.c |  2 +-
 target/alpha/helper.c     |  3 ++-
 tests/fp/fp-bench.c       |  2 +-
 fpu/softfloat-parts.c.inc |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 98cb0623ac..92918df89a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -141,7 +141,7 @@ GEN_INPUT_FLUSH__NOCHECK(float64_input_flush__nocheck, float64)
 #define GEN_INPUT_FLUSH1(name, soft_t)                  \
     static inline void name(soft_t *a, float_status *s) \
     {                                                   \
-        if (likely(!s->flush_inputs_to_zero)) {         \
+        if (likely(!get_flush_inputs_to_zero(s))) {     \
             return;                                     \
         }                                               \
         soft_t ## _input_flush__nocheck(a, s);          \
@@ -154,7 +154,7 @@ GEN_INPUT_FLUSH1(float64_input_flush1, float64)
 #define GEN_INPUT_FLUSH2(name, soft_t)                                  \
     static inline void name(soft_t *a, soft_t *b, float_status *s)      \
     {                                                                   \
-        if (likely(!s->flush_inputs_to_zero)) {                         \
+        if (likely(!get_flush_inputs_to_zero(s))) {                     \
             return;                                                     \
         }                                                               \
         soft_t ## _input_flush__nocheck(a, s);                          \
@@ -168,7 +168,7 @@ GEN_INPUT_FLUSH2(float64_input_flush2, float64)
 #define GEN_INPUT_FLUSH3(name, soft_t)                                  \
     static inline void name(soft_t *a, soft_t *b, soft_t *c, float_status *s) \
     {                                                                   \
-        if (likely(!s->flush_inputs_to_zero)) {                         \
+        if (likely(!get_flush_inputs_to_zero(s))) {                     \
             return;                                                     \
         }                                                               \
         soft_t ## _input_flush__nocheck(a, s);                          \
@@ -4752,7 +4752,7 @@ static bool parts_squash_denormal(FloatParts64 p, float_status *status)
 
 float16 float16_squash_input_denormal(float16 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float16_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4764,7 +4764,7 @@ float16 float16_squash_input_denormal(float16 a, float_status *status)
 
 float32 float32_squash_input_denormal(float32 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float32_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4776,7 +4776,7 @@ float32 float32_squash_input_denormal(float32 a, float_status *status)
 
 float64 float64_squash_input_denormal(float64 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float64_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4788,7 +4788,7 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
 
 bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&bfloat16_params, a);
 
         if (parts_squash_denormal(p, status)) {
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 0ced53c54e..5b7e4bd5eb 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -151,7 +151,7 @@ void helper_ieee_input_cmp(CPUAlphaState *env, uint64_t val)
 void helper_ieee_input_s(CPUAlphaState *env, uint64_t val)
 {
     if (unlikely(2 * val - 1 < 0x1fffffffffffffull)
-        && !env->fp_status.flush_inputs_to_zero) {
+        && !get_flush_inputs_to_zero(&env->fp_status)) {
         arith_excp(env, GETPC(), EXC_M_INV | EXC_M_SWC, 0);
     }
 }
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7a..b7eb13d0d2 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -24,6 +24,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "fpu/softfloat-types.h"
+#include "fpu/softfloat-helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
@@ -80,7 +81,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
     env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
-    env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+    set_flush_inputs_to_zero(fpcr & FPCR_DNZ, &env->fp_status);
 
     t = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
 #ifdef CONFIG_USER_ONLY
diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index ccc561b578..c53d6e4b34 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -672,7 +672,7 @@ static void parse_args(int argc, char *argv[])
             tester = val;
             break;
         case 'z':
-            soft_status.flush_inputs_to_zero = 1;
+            set_flush_inputs_to_zero(true, &soft_status);
             break;
         case 'Z':
             set_flush_to_zero(true, &soft_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 22c11171f3..c6a3ba9a22 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -218,7 +218,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
     if (unlikely(p->exp == 0)) {
         if (likely(fracN(eqz)(p))) {
             p->cls = float_class_zero;
-        } else if (status->flush_inputs_to_zero) {
+        } else if (get_flush_inputs_to_zero(status)) {
             float_raise(float_flag_input_denormal_flushed, status);
             p->cls = float_class_zero;
             fracN(clear)(p);
-- 
2.43.0


