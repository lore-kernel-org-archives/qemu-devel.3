Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8C-0005pB-5I; Wed, 15 May 2024 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7y-0005hE-5C
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7v-0001bo-Al
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34dc129accaso4880164f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766045; x=1716370845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZG3aV8qfAUE4eaqYaKoPcSH0wJlV80ibYaxpI2XwiLk=;
 b=W8qSh/zoMd4lsT+ZTc5miOjwkabELlAkn+E8MBG0qa0rirqGh2vTrFv60ucPEhI4cw
 gNMBMPASONZM6waNdwwqW8xCSi8fu2gfKIg6cZymPySFzm78vaEzVYFL5cWwpad3VamU
 E69HcrJH97VRICh3w1TG9fjuWPt5OxYp+o4ubCLPPhf61FJbOamdKuTSoqOWf2O4z2JR
 lT+VMvDC9jck4FdpYy63pP4YVVRh424aSh8hezTv/E8Dbyf2ps4RPhbwIMuiRoULQfyf
 m/KR3plxxexe/GZ1i0DkUg8Ng41O1Qdq4D8c9FIwZsl/sWp4wupOVGJg51KyZvZZocZM
 m7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766045; x=1716370845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZG3aV8qfAUE4eaqYaKoPcSH0wJlV80ibYaxpI2XwiLk=;
 b=JoQZPayJvglujJmcMcHQ0S8ypLt7VWfp/jNF2JtdGikmmTPzXS0yFwmqtPI/+thw3k
 sn7wS75xpEXw7EmgSmYMwSrB/CWCKzLUX2xmD3qwBvIs1rkJLH+yjhLzFYEDwbMzszOo
 9TLn2qJQ5s0gVbUyTgXbGmjGZkuOjwGZskiAH5D3NWxnWQp3162eQwuOak//7sb+/+X/
 1dE3LpvSWcBDGqEUcLk5kNDjN+g+Bi91mrJWd8M3o9J44LlkJt2TS3hxfKvymkJMxLni
 FG7gXdDo7ei8XmKotk17Q55jLs/RBjaD7EX1DXv/7OOnG31hFbzUE/kphkiOD1MVQhmC
 Mq5Q==
X-Gm-Message-State: AOJu0YyBIOWZs014pHnW3HdAN9vycXAx8I2y9aCx/yM205hUmaLk+L8q
 pqCVzr/KXTap3kcySu40U0xxrW6CiKp41drvG8TV4oxqmPvvNbVQHQbHiZsQTTv4b9VHLoobc0E
 ORCA=
X-Google-Smtp-Source: AGHT+IHsh3wxOpLs5Cszls7IJC1hWqDk3+04rXRkbquEwiYNzejXPq+VyiAiAj48iSsts4jDYQer9A==
X-Received: by 2002:adf:f287:0:b0:34d:87bc:e79c with SMTP id
 ffacd0b85a97d-3504a633178mr13432596f8f.6.1715766045295; 
 Wed, 15 May 2024 02:40:45 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 01/43] target/hppa: Move cpu_get_tb_cpu_state out of line
Date: Wed, 15 May 2024 11:40:01 +0200
Message-Id: <20240515094043.82850-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 43 ++-----------------------------------------
 target/hppa/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb2e4c4a98..61f1353133 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -314,47 +314,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = env->psw_n * PSW_N;
-
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
-#ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
-    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#else
-    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
-    if ((env->sr[4] == env->sr[5])
-        & (env->sr[4] == env->sr[6])
-        & (env->sr[4] == env->sr[7])) {
-        flags |= TB_FLAG_SR_SAME;
-    }
-#endif
-
-    *pflags = flags;
-}
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 393a81988d..582036b31e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -43,6 +43,48 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
     return cpu->env.iaoq_f;
 }
 
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = env->psw_n * PSW_N;
+
+    /* TB lookup assumes that PC contains the complete virtual address.
+       If we leave space+offset separate, we'll get ITLB misses to an
+       incomplete virtual address.  This also means that we must separate
+       out current cpu privilege from the low bits of IAOQ_F.  */
+#ifdef CONFIG_USER_ONLY
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
+    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#else
+    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
+    *cs_base = env->iasq_f;
+
+    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
+       low 32-bits of CS_BASE.  This will succeed for all direct branches,
+       which is the primary case we care about -- using goto_tb within a page.
+       Failure is indicated by a zero difference.  */
+    if (env->iasq_f == env->iasq_b) {
+        target_long diff = env->iaoq_b - env->iaoq_f;
+        if (diff == (int32_t)diff) {
+            *cs_base |= (uint32_t)diff;
+        }
+    }
+    if ((env->sr[4] == env->sr[5])
+        & (env->sr[4] == env->sr[6])
+        & (env->sr[4] == env->sr[7])) {
+        flags |= TB_FLAG_SR_SAME;
+    }
+#endif
+
+    *pflags = flags;
+}
+
 static void hppa_cpu_synchronize_from_tb(CPUState *cs,
                                          const TranslationBlock *tb)
 {
-- 
2.34.1


