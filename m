Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E323EC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVA-00012b-E5; Tue, 29 Jul 2025 20:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFT-0001yY-8y
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFR-000451-1j
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:46 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5931189b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833643; x=1754438443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=on+u6bbfdDUn5A5FUn0dghBlt7iCztcjK2d6O8nRN8Y=;
 b=n20YEh4V8otwgNYIuv1T65D91MAP0YJ5pEoz1cx25lYGvynCRLIUVbtPvjyC5eEgh6
 jgUPCV8Fqi1yNPTolkglmrpldRgQtEMCMxK8zoutgN89wobO2JCKt5iFsJP2K/HEv283
 l6JzoEf8GLZ4D+dLrdWz2aGqG2wipLydNtSM9XWHzUDXrXOQIObxxkWLq7RURm9/YG2I
 WXX2inDbuvZQcj8oQZgCEo/R9STZaxlREbPye8vISDdzm+MUtPFofKoC1tWeUPZAafNZ
 mtsCaTUcmNxFJCm7td0hYHvp/VJPBuh2reCJsemaC5Ol2a+TK3cFIgpaHXViAwWyHoe6
 cP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833643; x=1754438443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on+u6bbfdDUn5A5FUn0dghBlt7iCztcjK2d6O8nRN8Y=;
 b=cikaahxR6HELzoojgB3LmjW30ngyWN5Y9ZS5OhBh6PbF2kjII2sveyE/Zzmw4VmW2v
 hmQD8BkQQdtz0dvjAjFelfeetFbDypTABo1Ye+RDV2Re6as62MG9SIT5mv5+kpU8mQxN
 j2gCnW8EgvBKEBNWw6WSlKSMiTRQ0hIzzujpzGXRY1HVsQZLP91GtUizT/qDw+7RCdc5
 W6ZwWobd9sb1FLo2wpJvNViRGS4nth10qPYxPIOuysDNhUQU4t1kQNrjkhkyiKf0RDau
 oI9nxtyLDQ600Jap8v7j7mMOlD4z0z+GEcpbrGzxOqkHTdUfmGOkFNO/PqdJGolMhGqd
 1UcA==
X-Gm-Message-State: AOJu0YzlPh03wVSKJe3o+vWMFFxOCEWRtuGMS+0LYPYvZE+OIdXA5jiS
 x/4v+cwnfaU+KcISqTk8ykNm5DqDiDgv7w+s+3r6RaW74/CxeMQaSbmNF6GgaacnBO2EBfMVmAd
 lDKda
X-Gm-Gg: ASbGncsFlIUyk/90R3puY80OOU0GztdXvcfTSJ+W+C45gyeH36hD0c+S6Gv/wcazfug
 ATecGz0464vwt8vPnJUqtsoH7AOpiC1zCDS2vL64XQRbcDH+Rd8LdEmFYVuPdjWNNCUHHLCcuMR
 ic2lACS2TgnL/kP6uimJiJeOwv4i+EiGiP6NAJ+GXnZwlWjZjj3H4MH+xt8j9PLYCJD5jg3Rqcc
 AyxZ06juqBZBUXHfKltU0J/jLIJXUCDj2QsKxKpOTD/K+KW+Dm/IvCAsenjPmat6TFxnia1MLRO
 rg2L77b/ibcjPkM+h0ckFtLLmmhd634P8dOaJKR3Q90zn942yF5fmTUBEQhH52TYyeUZevsEvJb
 pLDlVTIlNo6xJAeW4jHA06Go3UFJsSiP39q2+wNyCFt6DBekHoofRgUsE+C8KCTRmqivSI4tc2Y
 H+ozM0ryiwpQ==
X-Google-Smtp-Source: AGHT+IE26bR/Ngf47YizVbSoWj3SndTUfvGNOqDe4x52VcVaFshf2f/uCQ/CKQyEgaOjQKLR+eTRhw==
X-Received: by 2002:a05:6a00:b88:b0:74e:a9c0:9b5c with SMTP id
 d2e1a72fcca58-76ab293839fmr2123216b3a.13.1753833643276; 
 Tue, 29 Jul 2025 17:00:43 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/89] linux-user/arm: Create init_main_thread
Date: Tue, 29 Jul 2025 13:58:57 -1000
Message-ID: <20250730000003.599084-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 53 ++++++++++++++++++++++++++++++++-------
 linux-user/elfload.c      | 41 +-----------------------------
 2 files changed, 45 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 1f3bb96484..8974b35e8d 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -480,19 +480,54 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
-               CPSRWriteByInstr);
-    for (int i = 0; i < 16; i++) {
-        env->regs[i] = regs->uregs[i];
+    CPUARMState *env = cpu_env(cs);
+    abi_ptr stack = info->start_stack;
+    abi_ptr entry = info->entry;
+
+    cpsr_write(env, ARM_CPU_MODE_USR | (entry & 1 ? CPSR_T : 0),
+               CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
+
+    env->regs[15] = entry & 0xfffffffe;
+    env->regs[13] = stack;
+
+    /* FIXME - what to for failure of get_user()? */
+    /* FIXME - a modern kernel does not do this? */
+    get_user_ual(env->regs[2], stack + 8); /* envp */
+    get_user_ual(env->regs[1], stack + 4); /* envp */
+
+    /*
+     * Per the SVR4 ABI, r0 contains a pointer to a function to be
+     * registered with atexit.  A value of 0 means we have no such handler.
+     */
+    env->regs[0] = 0;
+
+    /* For uClinux PIC binaries.  */
+    /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
+    env->regs[10] = info->start_data;
+
+    /* Support ARM FDPIC.  */
+    if (info_is_fdpic(info)) {
+        /*
+         * As described in the ABI document, r7 points to the loadmap info
+         * prepared by the kernel. If an interpreter is needed, r8 points
+         * to the interpreter loadmap and r9 points to the interpreter
+         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
+         * r9 points to the main program PT_DYNAMIC info.
+         */
+        env->regs[7] = info->loadmap_addr;
+        if (info->interpreter_loadmap_addr) {
+            /* Executable is dynamically loaded.  */
+            env->regs[8] = info->interpreter_loadmap_addr;
+            env->regs[9] = info->interpreter_pt_dynamic_addr;
+        } else {
+            env->regs[8] = 0;
+            env->regs[9] = info->pt_dynamic_addr;
+        }
     }
 
     if (TARGET_BIG_ENDIAN) {
-        CPUState *cpu = env_cpu(env);
-        TaskState *ts = get_task_state(cpu);
-        struct image_info *info = ts->info;
-
         /* Enable BE8.  */
         if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
             && (info->elf_flags & EF_ARM_BE8)) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 553d632d46..a9a1d7222a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -299,46 +299,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-
-    regs->uregs[16] = ARM_CPU_MODE_USR;
-    if (infop->entry & 1) {
-        regs->uregs[16] |= CPSR_T;
-    }
-    regs->uregs[15] = infop->entry & 0xfffffffe;
-    regs->uregs[13] = infop->start_stack;
-    /* FIXME - what to for failure of get_user()? */
-    get_user_ual(regs->uregs[2], stack + 8); /* envp */
-    get_user_ual(regs->uregs[1], stack + 4); /* envp */
-    /* XXX: it seems that r0 is zeroed after ! */
-    regs->uregs[0] = 0;
-    /* For uClinux PIC binaries.  */
-    /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
-    regs->uregs[10] = infop->start_data;
-
-    /* Support ARM FDPIC.  */
-    if (info_is_fdpic(infop)) {
-        /* As described in the ABI document, r7 points to the loadmap info
-         * prepared by the kernel. If an interpreter is needed, r8 points
-         * to the interpreter loadmap and r9 points to the interpreter
-         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
-         * r9 points to the main program PT_DYNAMIC info.
-         */
-        regs->uregs[7] = infop->loadmap_addr;
-        if (infop->interpreter_loadmap_addr) {
-            /* Executable is dynamically loaded.  */
-            regs->uregs[8] = infop->interpreter_loadmap_addr;
-            regs->uregs[9] = infop->interpreter_pt_dynamic_addr;
-        } else {
-            regs->uregs[8] = 0;
-            regs->uregs[9] = infop->pt_dynamic_addr;
-        }
-    }
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_NREG    18
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-- 
2.43.0


