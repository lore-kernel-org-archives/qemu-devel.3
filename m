Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503C7C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag41-0004aC-8P; Thu, 15 Feb 2024 13:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3q-0003le-00
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3j-0002h2-JK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-411d715c401so9345115e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020123; x=1708624923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoJzuCIrsH01JQMu3l4P7H0/BC0QIRTQUaRRKiYrvbM=;
 b=fqs7eixhayUIsPWPvQepdXb4+b3Q/AKm0bqu4nUJF88Wunnu/VmZ7knY0hzfTtZ/jf
 I2K6potT9qLPHozHAuRfsGztBuPO44CXC0zHZ4WMBPtCQ1atr3BaIPk70H79SysylFv3
 pfT6AKbffZkTwn0oV8R2Qq3TnE1EDgh8LAgawfJS9/3PRM0CpRwkeOYbxLZTtRK8p8TT
 c+1rP0d8JJokwJEi/cc9ExEMNWoBX9T2oYwd6digUxGYlO5zPp5bZ3W+1HVGlhfRkyrz
 jS7tV5+w0TfrY7wDmg39Gbv9WDY3QYqGHAqp4o4OZHIAsnSSa0gcagfEfk6a6QcbMM3Z
 mfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020123; x=1708624923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoJzuCIrsH01JQMu3l4P7H0/BC0QIRTQUaRRKiYrvbM=;
 b=lnKnpuCW6vtCJ6PqRa14mugFQsMag/dkqudEEswfVy6DXC4W12DtUnEo6Fn81O3tty
 cHyDkutTH2B8SDAXPMxzMTweEwu53JyL7wPbJmlScWbC/S/JBjOFYd82ad/1uRllroON
 cNfipkuzpNmFz6cwvHq2E922k2/s9NYZF0co7vTegl/TEp7+eIihbzNe/992j9Ch8MPb
 QQAHAJ2pICG6EFOK0Kpry+MlffOU+8jWOdf4xRZJGZ5QbyFO9W6tx5JAsdCNcX+IttvQ
 pccBMbnBrQSpnmyQkmv+JkXyWEspfLnvkKHj9XXRjkQzTHN7akCEY6F6rJktzJ3XL4/d
 BbAA==
X-Gm-Message-State: AOJu0YwR/ANuo/j/I2PwOTuhRaJLLSxJkKhmhGMMGgLQ/nbn+K7/ayad
 S5c/t3JQ0BK5BAhd4AWwEu2j35vJeblA2/6UG98TZtSCvbvFlfKCH/ckzMNi4zT9yFuRHdbIXzY
 RCCk=
X-Google-Smtp-Source: AGHT+IFY9hGG2vljf22mvOtE0ougi1cbCRUSfU0FuBG5sFnmty9l0k3qlq1C7jdZ9QvgUyz7/mu/+Q==
X-Received: by 2002:a05:600c:198f:b0:40f:ddc8:f804 with SMTP id
 t15-20020a05600c198f00b0040fddc8f804mr1666036wmq.17.1708020122980; 
 Thu, 15 Feb 2024 10:02:02 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b00410add3af79sm5649214wmd.23.2024.02.15.10.02.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 37/56] target/sparc: implement asr17 feature for smp
Date: Thu, 15 Feb 2024 18:57:31 +0100
Message-ID: <20240215175752.82828-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
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

From: Clément Chigot <chigot@adacore.com>

This allows the guest program to know its cpu id.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-6-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/helper.h    |  1 +
 target/sparc/helper.c    | 16 ++++++++++++++++
 target/sparc/translate.c | 13 +++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 6a42ba4e9e..e55fad5b8c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -2,6 +2,7 @@
 DEF_HELPER_1(rett, void, env)
 DEF_HELPER_2(wrpsr, void, env, tl)
 DEF_HELPER_1(rdpsr, tl, env)
+DEF_HELPER_1(rdasr17, tl, env)
 DEF_HELPER_1(power_down, void, env)
 #else
 DEF_HELPER_FLAGS_2(wrpil, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index bd10b60e4b..2247e243b5 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -212,4 +212,20 @@ void helper_power_down(CPUSPARCState *env)
     env->npc = env->pc + 4;
     cpu_loop_exit(cs);
 }
+
+target_ulong helper_rdasr17(CPUSPARCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong val;
+
+    /*
+     * TODO: There are many more fields to be filled,
+     * some of which are writable.
+     */
+    val = env->def.nwindows - 1;    /* [4:0]   NWIN   */
+    val |= 1 << 8;                  /* [8]      V8    */
+    val |= (cs->cpu_index) << 28;   /* [31:28] INDEX  */
+
+    return val;
+}
 #endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d9304a5bc4..692ce0b010 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,6 +37,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rdasr17(D, E)               qemu_build_not_reached()
 # define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
@@ -2382,16 +2383,8 @@ static bool trans_RDY(DisasContext *dc, arg_RDY *a)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
-    uint32_t val;
-
-    /*
-     * TODO: There are many more fields to be filled,
-     * some of which are writable.
-     */
-    val = dc->def->nwindows - 1;   /* [4:0] NWIN */
-    val |= 1 << 8;                 /* [8]   V8   */
-
-    return tcg_constant_tl(val);
+    gen_helper_rdasr17(dst, tcg_env);
+    return dst;
 }
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
-- 
2.41.0


