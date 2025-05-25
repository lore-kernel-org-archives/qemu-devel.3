Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E84FC54ED0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoB-0001sm-97; Sun, 25 May 2025 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo1-0001kl-SN
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDny-000360-To
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so12783395e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188949; x=1748793749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v030sQXn38icJSu8ncIHv/E3f08VdnZ+xSGEfzy3HLE=;
 b=dEDEB7XRshpxYX22MZngR2WOz0n6DQbR8MrWJDqUWGJ90lIwaE5W1Ql8tAFRrTO1hI
 dbz2XpUXNMQXHXxbG0gERIHZTeQRBItpu1tnLf2YgA/3LmKQAn76XIFE/SWIPSTAZAae
 4A7Sz3J5i7Mzd9/f4oJCzyg0QnM8WcyXzb2+Jv75mTkD9emge+xBhOEZxPgt69k69x79
 YYBWqjLEa5WplI+R9UuLvhDPkRbkyyiTOosBuBgJXnhbSo0Jk68yQW77n0jBqHwMMMHS
 PlCobZpk5AaO7+vwZTJ9z1Ls12Q4hcfigYhoX5A/Y5+xk4a3oUhUzbFmFgDgy3rA0iAH
 wf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188949; x=1748793749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v030sQXn38icJSu8ncIHv/E3f08VdnZ+xSGEfzy3HLE=;
 b=EA8Vsrsdnijm0G7mKmvSzIYxKLBsUsk+J01QLc5acM3HHvCFcVWZtZEdBU8eqV7kK1
 RAyLq41KtI7QoVJMxIBf3sfMHXPSqL+a8TS6ke1YXeZXXrMd5ihAf+mIzrKJPgqaH68h
 gKXYePThYDiYgGTcO0wr4OCIHfIrKNYzTCMj1bXgN76cDW/CeW0CK3QlGxMkJi2jKpwr
 pvzgyFghgL91z8enPX/iHYnG/8P5nCL3bWkKRwaOu+oaYlNRDwKjEm64qxlyERoyhmT4
 kD3HE05RRRoSPbGF/Fj+isMW/u5QhEDhRLySxOc69kexOQ1RZw43Zv2yNgDGYTv8le2e
 61sQ==
X-Gm-Message-State: AOJu0YzkasayV8vfELU/oZbjziPi1JIP1dwwymYE71Uu2g8PX705ljQM
 mdesAGQxZ5aRGLPh62MadVahPT1j/YBB5NRlMhJtEo/dt9WFv7b2BT6NNWql4imGZuOOZEntdrX
 WZtdNWiI=
X-Gm-Gg: ASbGncsqdChEjLtcrDLpoOSBAA1W/FuqGLtGoCnpHclP6rOJ6IhOxAy0SJoRBNGBRWS
 UkYnzZb5ALDy4UkZvx2kwWwZNMgGB2F1Y8XGEzew/M7bMJXom37+ZQRwk+pNZNms1isaJ+d57yl
 B1LXoNgEheKwGG4JPovy59OMRZdmP9vO8mj2a4xGezIzsT7/8EsSwoi4+gRHoHvO4c19Fj1Hiii
 yQt2KnMLYn7rX+iGSG4IlGO42oqJts6HBf1cm5Tg64buFr37AuEuqY/o5lP52dBCZ68ZAFYh+AL
 ZUfx0zDgf0YZYR6MDL7pkxocdIPoCZr9MlGHgfaiiMZOGDV2R7JGMHB2cxBA+KQ2twU=
X-Google-Smtp-Source: AGHT+IG+WlHsIbfZGy/JpIYInASIFLI2yRf4a88REYqpZoND2mPE5Dw8UeWmGSq1DivFVJMen9Dsnw==
X-Received: by 2002:a05:600c:1da6:b0:44a:4874:bdde with SMTP id
 5b1f17b1804b1-44c8ed8f474mr57832085e9.0.1748188948925; 
 Sun, 25 May 2025 09:02:28 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 03/10] target/microblaze: Split out
 mb_transaction_failed_internal
Date: Sun, 25 May 2025 17:02:13 +0100
Message-ID: <20250525160220.222154-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Use an explicit 64-bit type for the address to store in EAR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 70 +++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 9e838dfa15..4c39207a55 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -393,38 +393,52 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
     mmu_write(env, ext, rn, v);
 }
 
+static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
+                                           uint64_t addr, unsigned size,
+                                           MMUAccessType access_type,
+                                           uintptr_t retaddr)
+{
+    CPUMBState *env = cpu_env(cs);
+    MicroBlazeCPU *cpu = env_archcpu(env);
+    const char *access_name = "INVALID";
+    bool take = env->msr & MSR_EE;
+    uint32_t esr = ESR_EC_DATA_BUS;
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        access_name = "INST_FETCH";
+        esr = ESR_EC_INSN_BUS;
+        take &= cpu->cfg.iopb_bus_exception;
+        break;
+    case MMU_DATA_LOAD:
+        access_name = "DATA_LOAD";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    case MMU_DATA_STORE:
+        access_name = "DATA_STORE";
+        take &= cpu->cfg.dopb_bus_exception;
+        break;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "Transaction failed: addr 0x%" PRIx64
+                  "physaddr 0x" HWADDR_FMT_plx " size %d access-type %s (%s)\n",
+                  addr, physaddr, size, access_name,
+                  take ? "TAKEN" : "DROPPED");
+
+    if (take) {
+        env->esr = esr;
+        env->ear = addr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+}
+
 void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                unsigned size, MMUAccessType access_type,
                                int mmu_idx, MemTxAttrs attrs,
                                MemTxResult response, uintptr_t retaddr)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
-
-    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
-                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
-                  addr, physaddr, size,
-                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
-                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
-
-    if (!(env->msr & MSR_EE)) {
-        return;
-    }
-
-    if (access_type == MMU_INST_FETCH) {
-        if (!cpu->cfg.iopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_INSN_BUS;
-    } else {
-        if (!cpu->cfg.dopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_DATA_BUS;
-    }
-
-    env->ear = addr;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, retaddr);
+    mb_transaction_failed_internal(cs, physaddr, addr, size,
+                                   access_type, retaddr);
 }
 #endif
-- 
2.43.0


