Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA06CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbeE-0000OT-0Y; Tue, 19 Mar 2024 11:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdn-0007Uw-Tr
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdd-0005EA-J9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41461c256c4so9418585e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863068; x=1711467868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goVPZjhGsrNSLmW6IZIplIeGALKCmKT21+JRh5OPT4g=;
 b=RF89ge2MZ0jHRN0KR97wC/9dNKrOWqZ5vxM1+bvJ3kk78z1eRgfNk6GmenC7ohxWES
 GHcgFnzAm8Jx34p0plVoWm4BjvSojifDphY+U/zubykc+9Q7pOLhmbLxURSY7HPliMGm
 nInSFUdVY0T0mbO+Rpqr6NyumiHbHD9IcPsGCUTFUIf/t1u9IS9vLAWHlJ2M7j6zKfRs
 PilbfkICYH12MtRjOe3UtVLp0j+XhWb5n+38peOWDHAw09MnDDxOF7ksyvR/t9DBpl2j
 4XcVAyTnNEokZkCkG0Q3UUYu5/9A9kXTBI9m0857V9JRisLR0PV3/M1WIOLtt6eHLZUh
 4n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863068; x=1711467868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goVPZjhGsrNSLmW6IZIplIeGALKCmKT21+JRh5OPT4g=;
 b=JmbrClUXmmFGxm+A2qH7X2vMTieX3Jrqtc0HwpViQXj5X26Hh0Nij+TYXKuBrvWTIr
 UW+4cDeyV/Mitc2lAUchHnvsv8xwQuap3mle9h5lhFE+VEl8DWpY6KEdTpC0v9bxhVqP
 xeRP8Wf3aywgp3HpOlmiVMb0bl+wDLU7CT521oMByaz8IFHbpqG1ZDkU0Tj1/MCahFIj
 hEStS/H6LcvtMoRZEVxbRaEwfiH4PoXuCt0GI9xzPnEzcSpvI1ugbUSnyyaa+bNR8zYU
 wW1auD/S+jPvlHuyn28kn0dZauEvTv88Fh/69xTy8avzN+b8GaSvm9KuL46WeMEkCBB8
 UO8g==
X-Gm-Message-State: AOJu0Yxtzq4ghJewbYj1s+twZUPStjfzUGckVYJLMgo70p61w8kO474Z
 Jv8yxQwO0IYMfBH54P7dUprKWh02MZReFWGr3ZmPcUd6FLgyCsO6HtVj4Xilc4dSlDvCmkY9yih
 p
X-Google-Smtp-Source: AGHT+IEIacTEdvl1U5cLP5qgpG54E3GpTrl4MV3+Gl+NTqo1PltbQ0v3NatBwJnd9sALG/hnmUlpvw==
X-Received: by 2002:a05:600c:314e:b0:413:ee58:db7e with SMTP id
 h14-20020a05600c314e00b00413ee58db7emr2335980wmo.3.1710863067825; 
 Tue, 19 Mar 2024 08:44:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0041413546e5bsm5695602wmq.0.2024.03.19.08.44.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH-for-9.1 15/27] target/nios2: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:44 +0100
Message-ID: <20240319154258.71206-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/cpu.h | 14 --------------
 target/nios2/cpu.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 32002b819a..d0616723fe 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -286,18 +286,4 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
-
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
-           | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
-           | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
-}
-
 #endif /* NIOS2_CPU_H */
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 679aff5730..d1a98c47ad 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -43,6 +43,18 @@ static void nios2_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->pc = data[0];
 }
 
+static void nios2_get_cpu_state(CPUNios2State *env, vaddr *pc,
+                                uint64_t *cs_base, uint32_t *flags)
+{
+    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
+
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
+             | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
+             | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
+}
+
 static bool nios2_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
@@ -354,6 +366,7 @@ static const struct SysemuCPUOps nios2_sysemu_ops = {
 static const TCGCPUOps nios2_tcg_ops = {
     .initialize = nios2_tcg_init,
     .restore_state_to_opc = nios2_restore_state_to_opc,
+    .get_cpu_state = nios2_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = nios2_cpu_tlb_fill,
-- 
2.41.0


