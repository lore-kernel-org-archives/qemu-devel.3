Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339DECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShG7-0005Lx-Mk; Thu, 28 May 2026 16:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShG5-0005LB-As
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShG3-0004LN-Fk
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so9229045f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999790; x=1780604590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=46WbI2djE0UCmBdcudxQk4DPj15qACVaBONwHZoW6vM=;
 b=jiseDnVqpzDWoIZ1vf/E9vwvDNpnlycs+P8irTCX53sMfoZGOMWayTWFFVYGXev+Zh
 3BtQYhVBDzyBUD367aVtvTBWJbyGzs/p0TpJPGims2aRf3lVFy9SMnrGnEiZCLi40Jx4
 FMH2ZhDQ7Dkjv1LWzcToSdBtjmZUnXQj135CrAhSx3VReN31zi3JUOPEjmjclf62AocW
 h+tB2cbe2JtvTApmzOdspQ2s4O0zHydonrhjUuPEKPkkEzAxKnMgFc9WEwNdXb1hohRs
 ftLkNjnyczv2u63Sc7pjBeziS++CMMYAkKIhWGQm+pFpkVmOR1lsWA+mflzOnTWRBhDG
 DmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999790; x=1780604590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=46WbI2djE0UCmBdcudxQk4DPj15qACVaBONwHZoW6vM=;
 b=MudSVwkZajs3u9gnXqaEI4DJnioImC9H4iKjEQW1UlluNNRowkIKsKOVDdDiFnP/4g
 NECQFqjvuezIyZJorCXDsLc7otP8BH5IGer/CldFFlk3ATWaJpngs/c7em9o3PfvvJf+
 GBfIvgYYQthb20PTzRhXAzS0t0pbzhPMU8la6p3MHcv2guoequA7YBSqjdypPYsnyZGV
 JnlLqjzrBSQxMjnGdFyCC5WMzvVwoWUOXakitszins+GikfLd9/McfDCoAsJEbG5WeJi
 cXaxmk4cgmLzNofusxcGjZO3lCRj8WM3xYBkxEkOxfEmQEbIpe/y/cszHiYPuCAR9CT8
 XZtA==
X-Gm-Message-State: AOJu0YzBlG0VzqMKlBcr66je2ObbAUfr7ht+adphqyLckigZcP8avKKr
 YZSewmBnoL4PswKp0O1De+IfY0AIuhVSxhFUH/aNG4DauB+QFbyAzqxAiDB/N50SEQC+tnPq91h
 ff4TYPJIocA==
X-Gm-Gg: Acq92OHRuFMMurvqhkWGw4xKbAcWJQjTB4z9UC72oSRKXu3WI8U61383cR9OVibQXv4
 qFjz/ts4foVxyElcIuc6dEo2lmQLRPx9+fsmWQk+TQ+Dpp/y/SiEUhEoaiNryIOy6yetiUXaZkd
 FO0rltN+5acYdwf0GGpz5g2izot+r65qZZ6jhUMsgnae5ChdcoHozAjZ5b1d5PVrUfH+PhUbIMT
 W63tEh4OexzU2MTWyXptDFWVSM+Jk4+CoaWoD6xbH9MhkRfd5jR33KZLHNKfN2Yw43awzQYP6N8
 6bLmY6x3+ZnGi9fLKBED7tvlYyjUPOR3yK9PAbZjahImFZRTrF2OzFV8+1y5j7FqhQdQl7MnTCk
 1fWwTvDc8kmI9iUonozWdrIQy13XtPaSdmfbgQFxK/V4gTObjrKHNOJAPZoVxg0aO5dnsXCH/Oo
 VdTia9ekSw4XqV7O5glCClVhxPeaA+tNBkRgH9WvvF2vvK6zL2IWC8u4Iz7YZzQpsUlw==
X-Received: by 2002:adf:eb50:0:b0:45e:9304:a4c3 with SMTP id
 ffacd0b85a97d-45ef12b1845mr24577f8f.19.1779999789753; 
 Thu, 28 May 2026 13:23:09 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed496112sm3910241f8f.15.2026.05.28.13.23.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/22] target/tcg: Rename unaligned_access() helpers
Date: Thu, 28 May 2026 22:22:32 +0200
Message-ID: <20260528202253.49122-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260224193028.2370-4-philmd@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 2 +-
 target/microblaze/helper.h       | 2 +-
 target/arm/tcg/helper-a64.c      | 4 ++--
 target/arm/tcg/translate-a64.c   | 4 ++--
 target/microblaze/helper.c       | 2 +-
 target/microblaze/translate.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b7880f773e7..cae543a7a15 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -113,7 +113,7 @@ DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
-DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_4(arm_unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
 
 DEF_HELPER_3(setp, void, env, i32, i32)
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 01eba592b26..1429c1727ef 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -27,7 +27,7 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
-DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
+DEF_HELPER_FLAGS_2(microblaze_unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
 DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 6505ee3c942..093c697e050 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -835,8 +835,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     clear_helper_retaddr();
 }
 
-void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
-                              uint32_t access_type, uint32_t mmu_idx)
+void HELPER(arm_unaligned_access)(CPUARMState *env, uint64_t addr,
+                                  uint32_t access_type, uint32_t mmu_idx)
 {
     arm_cpu_do_unaligned_access(env_cpu(env), addr, access_type,
                                 mmu_idx, GETPC());
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 15b40090c0f..eb533ebc651 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -382,8 +382,8 @@ static void check_lse2_align(DisasContext *s, int rn, int imm,
 
     type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD,
     mmu_idx = get_mem_index(s);
-    gen_helper_unaligned_access(tcg_env, addr, tcg_constant_i32(type),
-                                tcg_constant_i32(mmu_idx));
+    gen_helper_arm_unaligned_access(tcg_env, addr, tcg_constant_i32(type),
+                                    tcg_constant_i32(mmu_idx));
 
     gen_set_label(over_label);
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f81c4f625b5..3434ea47e8c 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -69,7 +69,7 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 #ifndef CONFIG_USER_ONLY
 
-void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
+void HELPER(microblaze_unaligned_access)(CPUMBState *env, uint64_t addr)
 {
     mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 74b5420ed24..a93f14d6e09 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -692,7 +692,7 @@ static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
         record_unaligned_ess(dc, rd, size, store);
 
         tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
-        gen_helper_unaligned_access(tcg_env, ea);
+        gen_helper_microblaze_unaligned_access(tcg_env, ea);
         gen_set_label(over);
     }
 }
-- 
2.53.0


