Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welGC-00067D-Qe; Tue, 30 Jun 2026 23:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welG3-0005ot-I7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFz-0002tp-AM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c82538b6c0so1418765ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875098; x=1783479898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8qTIMHwz1Nx+GGcIl7ueTFBZIpYrxFuhh8bdVUncVE=;
 b=zX1db1xGD4b4QfNogYb0R3bZwPbdejJAfjxJ/0tUvtDxzducJmp94nZRPQ9DcpPJuc
 9MBnA2ZqtTB1BiR4XkLxifduVVYQUIj+svk/VbtuKbDpP1PKXxm9QCgcH9pQ0hMOuQYR
 MnokEbglEwEhQMuVMMlvvTHo1N9Qm2EmZTK2zl0LMsACm65ErYx1fKv1BG2wGgI8rgKG
 r4HbhuxVZMUqhBnjR20g7RVnY5ZXb3RHOgmAPtoKnQAtPMdhJhBu5T64cEqG4G0CXzAS
 tz5BUEQDDuKBzvsJD6n3CCNLPUO2gsmvW3YB2qm0aRPg0e6kGNCJLDPPYtiTwgtDINuN
 DHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875098; x=1783479898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8qTIMHwz1Nx+GGcIl7ueTFBZIpYrxFuhh8bdVUncVE=;
 b=UvNPtBRRg1T0ImuktJBiUfQqoJRGAz4T7+q7gJSEdsuoB4qk7r3W5JMlZ+9FEAPPUS
 gmQZyPmd6NCttRYaPw62MjvTIEAFaZoFXzDq01uRSrttuh8BHyKj2PfjPyiTEkbeHHQq
 b3nXhItTOlGYFr7IJ2boyZ+2d8BvxnAV0cttcHuYbR64ajf5+rByZEEGadYyzu+Ddu5V
 YWVFOGL5ErKgxyuHOKbtbryxczFOoWOH029MpbXjNOUpIIR1E3+rdmomeUnp1rEryiKo
 B//l+mXA0UQ0x6EgJZIr/a2vt73bw70M22tHPunkCAXDv2oiSHT5kgbUy7q79ONGWERx
 ArVw==
X-Gm-Message-State: AOJu0Yyw+4CeKyGj5z+33GpgduQ7aQDiYaL2zjq1QBkX7Cze6EbKucB8
 NeKngH2kMFirbgtz6apiITcVgHsIwxMgUPkU+tDcs1Z+dWO2IYuuKU/UYFlHuJGui2aXn5B0pFT
 cNtpX
X-Gm-Gg: AfdE7ckQetmN3astc3DaKNVclp9CyjPMYPEfIPz269I8ssQaztGKd7XB/n6ntS7G1/A
 Eh3a6avFGr51+7eUeog3BBjACCjHA53C1tW7BJ93AZacntoJiLwKxOU/hj4gSrT4M/HNew5yR7l
 1qE6Al4aK+/XKaFIrkBFchwOwEPxWOZ9u++mqlL61tbNC0hr06kkdPobh8HpAAMDOvgf11w/KrE
 1+Wp06z3FA0aA7iE5myW2f8KTXMF03F+MoNHNu5N8osGxqP1md2WrLqUzMmwf1Xl+ZuR/VejhqO
 534ceXRBRP7ugQXm15QfTij+eX24oskeW1l5ijJelXAhuw+InSRcaZPy7fnCF9UdlmclcT4ihLj
 Rlk5nZDXIcSHLN8CjmsQ3+QFawP8YEtzEfbwztDFjLAxTptdXb96/VkD6f9gqD91ytacsM7wC2J
 WmPb2WlTQPcCgfC+WJGIP+HIN9X2duVw0iplZwFPJTrXtK+yLaGQ==
X-Received: by 2002:a17:902:e5ca:b0:2c9:bd3b:34f with SMTP id
 d9443c01a7336-2ca2ea1bb17mr48617975ad.35.1782875097700; 
 Tue, 30 Jun 2026 20:04:57 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 16/17] target/xtensa: Use BP_CPU_ID_SHIFT
Date: Tue, 30 Jun 2026 20:04:42 -0700
Message-ID: <20260701030443.1382447-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set the id when installing the breakpoint, and drop the
loop when checking the breakpoint.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/dbg_helper.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 160cdd798c..5b957474ea 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -44,7 +44,8 @@ void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
         if (change & (1 << i)) {
             if (v & (1 << i)) {
                 cpu_breakpoint_insert(cs, env->sregs[IBREAKA + i],
-                                      BP_CPU, &env->cpu_breakpoint[i]);
+                                      BP_CPU | (i << BP_CPU_ID_SHIFT),
+                                      &env->cpu_breakpoint[i]);
             } else {
                 cpu_breakpoint_remove_by_ref(cs, env->cpu_breakpoint[i]);
                 env->cpu_breakpoint[i] = NULL;
@@ -60,7 +61,8 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
         CPUState *cs = env_cpu(env);
 
         cpu_breakpoint_remove_by_ref(cs, env->cpu_breakpoint[i]);
-        cpu_breakpoint_insert(cs, v, BP_CPU, &env->cpu_breakpoint[i]);
+        cpu_breakpoint_insert(cs, v, BP_CPU | (i << BP_CPU_ID_SHIFT),
+                              &env->cpu_breakpoint[i]);
     }
     env->sregs[IBREAKA + i] = v;
 }
@@ -68,18 +70,12 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 bool xtensa_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     CPUXtensaState *env = cpu_env(cs);
-    unsigned int i;
+    unsigned int i = bp->flags >> BP_CPU_ID_SHIFT;
 
     if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
         return false;
     }
-    for (i = 0; i < env->config->nibreak; ++i) {
-        if (env->sregs[IBREAKENABLE] & (1 << i) &&
-            env->sregs[IBREAKA + i] == env->pc) {
-            return true;
-        }
-    }
-    return false;
+    return (env->sregs[IBREAKENABLE] >> i) & 1;
 }
 
 static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
-- 
2.43.0


