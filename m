Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFACCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbD-0005MJ-LY; Fri, 22 May 2026 14:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb9-0005AB-PY
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb7-0005Ta-MQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b788a98557so49127735ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474468; x=1780079268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yciU7wfFxUZkhCl24mXhpsueynP3S6dxYuvKP7a/kAg=;
 b=EQ9lOU1R5MrfhZ4qmV1l0kNc++iTwWSOk2h+bBr5tNmLtSZjInG6dEIHhm1arKWJvk
 HFMUCg8hIZ6a0UmfeLxrJVnHC5ADA+n0iqPIdtyPymu7oL05moeIay6a9c+AgSjnDz8m
 X3GamX/xSu5pO4cPUz3iQaN6yfucWjCtY2M7QW8DHcKvHAOPEf8rxJ5/G+Bni+3nkUuF
 tOq9tAkP647EqM3ydTC7LoaBh7Nx6kCNRKU1eoSJJcjFQlBC9v7YEraq/3MlrSxB9eDa
 cPNodDw+S4JNn1jxuLyl48y2GjrNFmdkiVEb2rmUXh01wO9ROvzlo4VrseQHJkaJTTbe
 2Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474468; x=1780079268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yciU7wfFxUZkhCl24mXhpsueynP3S6dxYuvKP7a/kAg=;
 b=QpG/V7CpvlNJ5ky/gyUOgAYyf7wI+nX7Yh5meOXasgxvIv8iAO+bspGl8fEABOdj0k
 9Ee4fAr7UolZGuqXcY3L0NVd26QqWx+MOhcc/kMpozG2Fv+nijMrSdZwYtBJCwFSFJTK
 m9hipDb230qOuMy2jxpWAAmnsv+cfAqpSd4b1inKy/T/KFpHB/ekA4Pc4P1M2nX4CSD+
 DWppTsMEN3bOKygUisbDvgGc47kAdEUS0ijugu695NSHSBQ7uJtCaYHwHggtcSnJ8Gvu
 rhXnFa7z4nbsO4FJAhogHJ3gFIudrhiTVyz7pApmnF+41c+pTc/S/bgHPvcS+AB1OZrj
 um/A==
X-Gm-Message-State: AOJu0YxzeMdYRt2hvEDcPE9yxBephmG+WIckje9h6kaVuvuaAe9klaWv
 YferK+NblGQ4Jm0yX8tq8x/DJnP4kl/xoFqfxz9fCnNlRD1TxgJL8JgMIdylP17X0o+d9RnpflV
 SclkE
X-Gm-Gg: Acq92OFhmAEt8qy++ms4raiwrkzb7lH0X/fIP25On1FdGL+JFy0bNBEzczvHtSM5fZN
 /14hrcKOStZjBjg9Zbyu2b448eqh2R0GL6jrFaxbNS5KgcPP9tg8IucLX17ERfBvGFvn9bXGiyn
 KGX6RFV1Q+tjLbgI7wSyeMJWtfL6dqD9QwWNsYzZCuC961ihEZLayklr32yRZNgg7YeJEhwCMWB
 VPdZUhnsINVu+jjpICN/b+HaaGz9T80w3Y2UmhRmKRH8iCOuB0g4G3YzD6NKqfJ5cJcPa/8zmWw
 iku/SrgUWIy3HGwo0fiGi1xT1SzzOMspgK7mPQiEg0+VF+xLamcCMr2R//80MGiX1QmEG0ms2Y8
 aLEfOpgJlDS7rW1q/rK30Ix6F7ZKOZXaRwzhpwkgaVWCV4j2bK6hZNgWcJ/buGdRFlV5B1OB0Lw
 S83oLs/ay4ELmW8ZnbsKz837WF90Ht
X-Received: by 2002:a17:903:2b0e:b0:2bd:a403:4ab8 with SMTP id
 d9443c01a7336-2beb06319ffmr51605215ad.25.1779474468008; 
 Fri, 22 May 2026 11:27:48 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/30] fpu: Use {get,set}_flush_inputs_to_zero everywhere
Date: Fri, 22 May 2026 11:26:51 -0700
Message-ID: <20260522182658.184604-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 14 +++++++-------
 target/alpha/fpu_helper.c |  2 +-
 target/alpha/helper.c     |  3 ++-
 tests/fp/fp-bench.c       |  2 +-
 fpu/softfloat-parts.c.inc |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dcae5b3be2..be6b02d866 100644
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
@@ -4764,7 +4764,7 @@ static bool parts_squash_denormal(FloatParts64 p, float_status *status)
 
 float16 float16_squash_input_denormal(float16 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float16_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4776,7 +4776,7 @@ float16 float16_squash_input_denormal(float16 a, float_status *status)
 
 float32 float32_squash_input_denormal(float32 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float32_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4788,7 +4788,7 @@ float32 float32_squash_input_denormal(float32 a, float_status *status)
 
 float64 float64_squash_input_denormal(float64 a, float_status *status)
 {
-    if (status->flush_inputs_to_zero) {
+    if (get_flush_inputs_to_zero(status)) {
         FloatParts64 p = unpack_raw64(&float64_params, a);
 
         if (parts_squash_denormal(p, status)) {
@@ -4800,7 +4800,7 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
 
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
index 33fed0c746..2abf07c191 100644
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
index 0e5311b50f..6a67e6af2c 100644
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


