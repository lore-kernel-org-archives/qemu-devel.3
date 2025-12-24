Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC96BE776EA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRnk-0005fq-AJ; Wed, 24 Dec 2025 11:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRng-0005eA-ON
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:24 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnf-0005Ci-2e
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:24 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso9275468a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766594001; x=1767198801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INUoFXttz71dwXA2SW8hNhOy0LXpWgterJHfnSarRNs=;
 b=vSObODqeLk/NkCHc+vCXmiojJZQrccHuJORce0yoTQRve8Hiy3xylAUlvBzlPQOA8P
 1iZ6fS4Zq31Pm/qQ4WUAAm/X2nNT4tJb5SRfmBGCD043sDiBZS9JUm9HetZAUDAqzUj+
 bD9vTYvqD3iaiIivtldAvk+zYidOcRVvqhzHZyufiUfGMdiWPslvdUjbPRehYJBa04Dq
 ncSZHF2i4O2ogt6AlYDWPtxhVlaXx7B9nG/3uiRK4W2wcYuJ4Lm56/HnQcN9xM1r2qkh
 erjW93WnNCPDng7TyKyVuqtrWryQy9LlMhvQnP6+BbjMHu8I69wYGxcBseuXptXR+yRz
 ePvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766594001; x=1767198801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INUoFXttz71dwXA2SW8hNhOy0LXpWgterJHfnSarRNs=;
 b=rPeDt48+ztYkBKJm+ycOZyeqpqw5xXT6B9jQj+cGox0GD/UzXY/AGn/r+mj+ZMyU6P
 wu/yw/AYHTU4eKTVRb6mw2B12jnaMB68p2gSZwCH8/aVrmaavO3cBqqbcxzHOVARif3s
 ULp/KkIsfC+fUiFlIlDyZo5JLUQRqlJ0Yf7cKtrKlgxNd6PuILCNtcc51i4VMpqDnYgu
 vX3SeJ1y63JPWMFoZ8gBIRGl9+bgamw9g3BSXno6VDbfx/WyFh74m1BBDZm8ul3zSjuW
 FtWTwhGWQKYkvyUAh04g1evNq4UOakS6Jp5Hn4ieB2Jx0D+WnHLN7+kQOoMLnU6Vutr7
 gyiA==
X-Gm-Message-State: AOJu0YwoVvQuF3Sx4AeqGHXng8fWHTn2FyD2DsAp1LewOR1xPa2AWMuh
 FRIw/7QlliuJ90C6FSkk/bHBfQRbyWN3IITrt+hn+Zjyk81M+HTrQkiVtS/vrXEDmBsP4+ZX1+d
 ds8MA8O8=
X-Gm-Gg: AY/fxX63+R6cnEU6blUz3Z3vlzJxVEgESzUGroMHBRZYjpMxM0oJjbszb+Vl2mtA+Af
 nmqCiLclI3ugd9sChztC4l3SfHvbxgnYi/zDzS/NcsbUSPcSKRL+ErdWvCtDBGxaF3MdLfpgDbv
 T5djf4YicIr0JN3EacvWuM8LrsCUpLe0cM7e70AJFudxJFVGCfGzJWph5lmWyZKMV8d3AbLjXk0
 XWxD8Q+kA3K7fhMDMwLesNFraXFC0A0fpicYBN7M7b+DConz88EvBfIrbVwAQDvAgWilcuI1WM4
 j7WuLNPS6R83tF0hFUiE0t+OWo0vGJheMG3Gte9zBF2v4Az+/wBod5S6wMiEURurIEk+H+vNAGJ
 muzHUH7EyaVdqvpp1w3kPzaz8tQap/XYHJDn4U3M4sisIFucRhey2mR3eyOkv7UYv2XRqF7ViJk
 rrlnRRe4fpyz9A2uV93iRtG1nHocZdtEsK0rDGib/CAlfskDlmjp7wA2AzsrOK5yS7Hg==
X-Google-Smtp-Source: AGHT+IFa2sJe81WQYKt6yXi8HwOhldN8E6f/LIHO1dP9EKsIJSwQysAJ4puf2dVBoFUjJCPCUnoBSQ==
X-Received: by 2002:a05:6402:350e:b0:64b:6271:4e1e with SMTP id
 4fb4d7f45d1cf-64b8ec6a5abmr18883923a12.17.1766594001098; 
 Wed, 24 Dec 2025 08:33:21 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b914949bbsm17253599a12.19.2025.12.24.08.33.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:33:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/4] target/rx: Use little-endian variant of cpu_ld/st_data*()
Date: Wed, 24 Dec 2025 17:33:01 +0100
Message-ID: <20251224163304.91384-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163304.91384-1-philmd@linaro.org>
References: <20251224163304.91384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

We only build the RX target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=rx; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..83cd491eb4a 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
     } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        cpu_stl_le_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
         env->psw_ipl = env->ack_ipl;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         qemu_set_irq(env->ack, env->ack_irq);
@@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         const char *expname = "unknown exception";
 
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
+        cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
-            env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
+            env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
         if (vec == 30) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 2b190a4b2cf..ca3e9e85fc7 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
                                  abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
-    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
 void helper_sstr(CPURXState *env, uint32_t sz)
-- 
2.52.0


