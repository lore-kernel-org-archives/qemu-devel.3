Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7DCCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE70b-00036Q-6e; Wed, 29 Oct 2025 10:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE707-000317-QC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:21 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE6zz-0007WS-Th
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:11 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-378e8d10494so60629091fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747480; x=1762352280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVn0sUQNQNSn8ZCiQSobP2QW4bk86yZD0BGFnx3OH2U=;
 b=Lj8qmw5K4G55Kn9xS+7t2RcFQUHn6qsezo5wzG+Vkd2RBmdvY/+KV7zoB9P8eO3PNT
 xqwylE2Hu3IOSmqZh6Gd3FtiAEhnkc+D7rQwuiVOmXqj1UUyURZ/M0UiYAGZE61imoug
 UmxBgVoT4tNyP80ok7lOOfZj9R9gtXl2bDd51OGzbRVToN0BaODyDr5YiXIw19u6aoh9
 5/9IF8dku11CRsouJoEm2EeqMPuPV20JgBIL9o2zkyq4ES0gsoOG5yX37mwp8o7XkQwk
 uUfLC9E1sreHeGKWcehiABkpaM2UtMScevyS/a4WUfj9mY7qDCSjt84ovPzk4MP3FW/1
 OQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747480; x=1762352280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVn0sUQNQNSn8ZCiQSobP2QW4bk86yZD0BGFnx3OH2U=;
 b=TTXgXapN702i4LDzOQLFJ338acJ4Ty2MBpE3CoQaVo45AZqtm0ZmplOPcZ9wfswHNt
 pZoJ6lWNwmHPZEZOmdljhsZzQ5MqPYzZbetyvmanpN4A8gT211pVAa4lFW2eyOG/RyFE
 lbr6ONBexESL9VER0u54bU5KjW7J2mt0nPUgluPMc0afB6aISWxeZxs5VHJXutFRwCyP
 bIrLCC5MqLvdYvJ7QOFrw0jiSq9FxrifhExgFEXqCgIrAA0V+43WjhR7KKHaDwLdrmmM
 j1d0YNJR8q16ZZKLZl+suuAqq+0x3NHiVUeM0dp+STdzPHXjJ7xIl8kdISmMdUVGh0CQ
 mFBw==
X-Gm-Message-State: AOJu0YwpVRAhreV6mPtWrQzUcd2glPwxVIVTzLwIPYnwb/ntv8YLRxeg
 quVQVqKLA/Z08XASOkxcvu743doQqahrYprS1Hc2gdCVQLUajk86T0CZKaC7wGKmY0A=
X-Gm-Gg: ASbGncuKhVkBG8PX3ZPePGKokcPRLC2GeaB6fNz3F0p0WWo1VjXz3iO057bsQ6pZTwD
 jSGUrNAhYkd2IK/ghDvgdAAp2lJUdXXeH2oLnQ8ABxWkPofS62kTNyNovQZztG8r7jFJUvixzmq
 aaudAB8RKyONvg81b1XGzt5qjI0q6Z4PeRaAe296cenSvg5Nn6QN0LelET4XREUSFP6eYbKcEXI
 RHJVY1ekqA+G8r5K3Bt9D6mPaRqNdpJqkb7Pvy1CMt99JaQSAOIBk2yt6jUvgYJ/PMaXJR1VwTx
 9wJL0oAUx9G6TmZMwg3ijayhhWST4NgK5HhUCGYruS4ZNq8o67erY3lv2JE/fG92fkddOwA5SZH
 pc8Wc0SlEDDjvwVjgSxctot6Br+gpwKnCwOVFwJ78Q9ugtfpgfvjEz0KM6NU8ZWg5s39j0Qrof6
 7syPbbidAN+X9+wlnNMeXH76MDrAgVe2ha3tUr
X-Google-Smtp-Source: AGHT+IG8oCd8E7MdQukwNoCNtKCL1omJvfX50gQ0WZ3coDiy9qvWN29mBc8jyvwW6bIEenisWg6SBQ==
X-Received: by 2002:a05:651c:882:b0:379:782:1223 with SMTP id
 38308e7fff4ca-37a023cdbacmr9271251fa.22.1761747479393; 
 Wed, 29 Oct 2025 07:17:59 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0da2acsm33304661fa.42.2025.10.29.07.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:17:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v1 2/3] target/microblaze: div: Break out raise_divzero()
Date: Wed, 29 Oct 2025 15:17:48 +0100
Message-ID: <20251029141749.1274729-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
References: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Break out raise_divzero() and take the opportunity to rename
and reorder function args to better match with spec and
pseudo code.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/op_helper.c | 38 +++++++++++++++++------------------
 target/microblaze/translate.c | 12 ++---------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 886224df3c..d3f688e375 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,38 +69,36 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
+/* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
+static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
-    if (unlikely(b == 0)) {
-        env->msr |= MSR_DZ;
-
-        if ((env->msr & MSR_EE) &&
-            env_archcpu(env)->cfg.div_zero_exception) {
-            CPUState *cs = env_cpu(env);
-
-            env->esr = ESR_EC_DIVZERO;
-            cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, ra);
-        }
-        return false;
+    env->msr |= MSR_DZ;
+
+    if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
+        CPUState *cs = env_cpu(env);
+
+        env->esr = esr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, unwind_pc);
     }
-    return true;
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return (int32_t)a / (int32_t)b;
+    return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return a / b;
+    return rb / ra;
 }
 
 /* raise FPU exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6442a250c5..fefe5cb552 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -450,16 +450,8 @@ DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
 DO_TYPEA0_CFG(fsqrt, use_fpu >= 2, true, gen_fsqrt)
 
-/* Does not use ENV_WRAPPER3, because arguments are swapped as well. */
-static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divs(out, tcg_env, inb, ina);
-}
-
-static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divu(out, tcg_env, inb, ina);
-}
+ENV_WRAPPER3(gen_idiv, gen_helper_divs)
+ENV_WRAPPER3(gen_idivu, gen_helper_divu)
 
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
-- 
2.43.0


