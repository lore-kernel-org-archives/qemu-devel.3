Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E42C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnN-0000jt-TP; Mon, 29 Jan 2024 11:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmF-00072V-Sg
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:32 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmD-0003xW-4H
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:31 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33af2823edbso509562f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546787; x=1707151587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpEyww5ql+HDyU+E74XNxXzD2LWLWxnIJJxDrC1dnKo=;
 b=XLINSp+Ces/DTB30elwFcbAG4KQQCg6YrP2UDMa5yARNPPCkMCgwfSWZMYGGaF3nKa
 9XklbPkXk4aFEwy9P+XKgT6HPyJQgNpLe7kxL68a2UDRH8JIU6cXMka/yPoRgdyJV//t
 IRuedVvbgGkI/CLm98U+1J2vypT9o8zW8MErl7yBgMuQExQyq36g2FGgkeVe2HsnqyBQ
 4kRL6+X0xmLtHdbhrmQfzxk/N5zgk122R2leM2aYsbPgfdK5cHyQRzrdHLMqAk4Nq/wP
 HKNtCFkvYDSQ9DTJEsbhyxLejz4An+zgDIW/pCKTZKx5R/pGeuvwO8z4WD6lcqPYiWs7
 XleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546787; x=1707151587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpEyww5ql+HDyU+E74XNxXzD2LWLWxnIJJxDrC1dnKo=;
 b=jllybjPJrzhDsAYXs5bTEsc+I0yoh77WJY2l8cuMNKeshIf2WfyIuNbiFGKsrKr9IR
 A19w9+3AoBcSrDILbEXtMEKQY7+S0kmE9UOUiFMf6/RbPUeCA72yODgIcekchPG1NDw/
 jlzomXDrMUyMgvIU3HzRueLf4PnaCVwCmXsqGK1Eo/UhdBkL2yqbp2yZ/gPdPi8Zw2rk
 QlsVpJ6uvYLMhFkHv7xupwwV9A73dCc/MI1FPVt4+akl5nTircNKpWWHQ0cIAK2r+8de
 KvGeJNGBkmWjjXDn6XJDZjMVmqY7//MIbwOFfRJYwMat/6wbXJekmcCPxcA9F7u39dMj
 h25g==
X-Gm-Message-State: AOJu0YxrSvRQQ3ZyYzDSer3oWnNbJQ/wo7DBs9QMP1UFZgCMisjyx795
 XKeI6DmyW4x6AzLo3mY1FQUfXsFPgLyYHghGtWUwYcWJKTc4Z0crvuvYQsrlYUYTTFsS6AEb8i9
 4
X-Google-Smtp-Source: AGHT+IE/pmLN7aJB50sjYT7HNVrs0xGJu0OS4F2RLGx8AfT4RgKOArlTbN0yv5fwQwzrh+8k2SbzhQ==
X-Received: by 2002:adf:fa51:0:b0:33a:eae2:11a4 with SMTP id
 y17-20020adffa51000000b0033aeae211a4mr2806032wrr.26.1706546787414; 
 Mon, 29 Jan 2024 08:46:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0033af670213dsm258204wrq.110.2024.01.29.08.46.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 11/29] target/hexagon: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Date: Mon, 29 Jan 2024 17:44:53 +0100
Message-ID: <20240129164514.73104-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.c     | 25 ++++++-------------------
 target/hexagon/gdbstub.c |  6 ++----
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 085d6c0115..17a22aa7a5 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -236,10 +236,7 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
 
 static void hexagon_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-
-    hexagon_dump(env, f, flags);
+    hexagon_dump(cpu_env(cs), f, flags);
 }
 
 void hexagon_debug(CPUHexagonState *env)
@@ -249,25 +246,19 @@ void hexagon_debug(CPUHexagonState *env)
 
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-    env->gpr[HEX_REG_PC] = value;
+    cpu_env(cs)->gpr[HEX_REG_PC] = value;
 }
 
 static vaddr hexagon_cpu_get_pc(CPUState *cs)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-    return env->gpr[HEX_REG_PC];
+    return cpu_env(cs)->gpr[HEX_REG_PC];
 }
 
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->gpr[HEX_REG_PC] = tb->pc;
+    cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
 static bool hexagon_cpu_has_work(CPUState *cs)
@@ -279,18 +270,14 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-
-    env->gpr[HEX_REG_PC] = data[0];
+    cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
 static void hexagon_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj);
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 54d37e006e..f773f8ea4f 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -22,8 +22,7 @@
 
 int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
         uint32_t p3_0 = 0;
@@ -42,8 +41,7 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
         uint32_t p3_0 = ldtul_p(mem_buf);
-- 
2.41.0


