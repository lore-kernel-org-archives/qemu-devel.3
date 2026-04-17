Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD565F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaKy-0000AV-RF; Thu, 16 Apr 2026 23:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaKx-0000AK-Pz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaKw-0001Dz-7J
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso2956895e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776398264; x=1777003064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FrY0N+MlqE1VqAmJP5+zOpwJgQamw0o/zYm1s6GqUI=;
 b=lm3/nY0LB0UU+NxWyqZI13gnId6IZIdVemkRF4xaa8Rgw7xtrQoafZptNK1CzSrWex
 lCkXx92De89BlirjYnsUtyuE1P9Lty1A3n+QvFDZJUE8LMqOQbxaYU4tA6hYmVItfhf1
 ZoD4q3CVUzESBxrA3zqT6K4w2pv71yYopW56A2yrq/VapxrLtWH5P8dlsWpfj8jTLxe5
 Ke4MvJzVwhbAgxnRqxTSV3jG3NOx4XLmxhSbgDajoeQl+SXey1nBKzbIGxhPSQK2m9Qp
 mtsi1ZFXqQ5jlexjnLbUwOH3/2IKa60X1wp7vDzueTD8V7VrrMLhfz27+vLnMiRToRVc
 XOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398264; x=1777003064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6FrY0N+MlqE1VqAmJP5+zOpwJgQamw0o/zYm1s6GqUI=;
 b=AWjd4N2LkbwUn8Ite7B0A+BW2p1MGzywCtPzntHOqp8FcE5YFE7gZQ7IkO+xSiTCj/
 PvE8bTrkiXuItNTgrAbHwA0sGDc7PDmcH/O+MyPZMi46BXCenFQEK0JBpC88mgn6rkuW
 mh6Ex7OOhZv4m7zM8A5df9IrsGR0VyfKp1xshKO1mA91Rk9UpYP6JYkRGkGj1zsf8g/h
 6516Kg8UortDQJzjKfTRgPN+v5MgtZyyKAoKfSJI2y5Tnl2LwfoHdjv8fv67eDETRVuv
 i8g5Z4Mwy+BBVWNW2soX8ZmAQKQIuodoFrR18YGXuxluhcOALasx8OE4034XaU3T0BZ2
 uQBg==
X-Gm-Message-State: AOJu0YzjNcjyaM9k0/FYZS9GihGTqbz72+JYgEBlenSdueFohfKsyjWe
 oAB4ywFpvWdT/1rEuZ6AtFFPouhJPGTMGJcChaW9kl2I03/EWzYrQ4KJ1BF7hqxMmqoDkRQqo4X
 EYIn0lNk=
X-Gm-Gg: AeBDies8hFO+fH/OgUPAoSMlTsvFPkSgIr4r+zEHNA5tPhnR0t2jCrNAshvQX2zXwAM
 yC9n/lxtnW5iJJonGSA5qlrkI6lD57Y4zpqP4KYwzY4yT6CqUtSZwqVcrZfoVc6A8JnSiw7y4Gr
 lk8Xx+dj8lHEKPrLAmgS701/JBrexTQ1lM6EdHJLgS5zyeyUNb9iLR/yWziI6bG0IMG61pbuSi7
 G+am6o4zvLyArazoImzsmK2iEklmYZ6K7K3y5tWn3sBh2Sb2/bkzRa4muhZ+0OIQUNJ4bw4eJ8Y
 qc/rPVsGQDa0BUynYEFEFKPfJOhGOrC1h/TzZPdyQZ97qnGLN/+EZt3cKAYbqw3Abx0TUmyAEQW
 8+EwbMvyAjd2Bmvhx/g8NSuBh4YCCXRfFpIbc7ce2hJdsECBTKnLSPspJZxFYBifgZWF9pJ3dei
 7IfJa63puYEtHv9bsiiRq4ng0AbEPVwfBvszNgAnMN0frcgrnbHxP1yuWosYaPfaCOdrgOGac2K
 Vsh9CpvwNE=
X-Received: by 2002:a05:600d:13:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488fb7419c4mr10915175e9.8.1776398264331; 
 Thu, 16 Apr 2026 20:57:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7bd700sm6959855e9.31.2026.04.16.20.57.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 20:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 1/4] target/mips: Pass MemOpIdx argument to Load/Store
 Multiple helpers
Date: Fri, 17 Apr 2026 05:57:31 +0200
Message-ID: <20260417035734.32334-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417035734.32334-1-philmd@linaro.org>
References: <20260417035734.32334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In preparation of using the MemOp content in the next commit,
pass it as MemOpIdx. Include the access size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/ldst_helper.c             | 16 ++++++++++++----
 target/mips/tcg/micromips_translate.c.inc | 16 ++++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 4ebf72d610e..7be2cad89d6 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -224,8 +224,10 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
 
 void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -246,8 +248,10 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -268,8 +272,10 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 
 #if defined(TARGET_MIPS64)
 void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
@@ -290,8 +296,10 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
-                uint32_t mem_idx)
+                uint32_t memop_idx)
 {
+    MemOpIdx oi = memop_idx;
+    unsigned mem_idx = get_mmuidx(oi);
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 8fda7c8a214..4dca11b84b4 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -693,7 +693,8 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
                               int base, int16_t offset)
 {
     TCGv t0, t1;
-    TCGv_i32 t2;
+    MemOp mop = MO_UNALN;
+    MemOpIdx oi;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         gen_reserved_instruction(ctx);
@@ -705,22 +706,25 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
     gen_base_offset_addr(ctx, t0, base, offset);
 
     t1 = tcg_constant_tl(reglist);
-    t2 = tcg_constant_i32(ctx->mem_idx);
 
     save_cpu_state(ctx, 1);
     switch (opc) {
     case LWM32:
-        gen_helper_lwm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UL, ctx->mem_idx);
+        gen_helper_lwm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
     case SWM32:
-        gen_helper_swm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UL, ctx->mem_idx);
+        gen_helper_swm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
 #ifdef TARGET_MIPS64
     case LDM:
-        gen_helper_ldm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UQ, ctx->mem_idx);
+        gen_helper_ldm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
     case SDM:
-        gen_helper_sdm(tcg_env, t0, t1, t2);
+        oi = make_memop_idx(mop | MO_UQ, ctx->mem_idx);
+        gen_helper_sdm(tcg_env, t0, t1, tcg_constant_i32(oi));
         break;
 #endif
     }
-- 
2.53.0


