Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E64CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTD-0005N0-Km; Wed, 27 Aug 2025 19:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSn-0004Bv-Ew
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSh-0004IF-Hj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso329544b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336908; x=1756941708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLWZcll6BBWWPhJe3hiHwSDE6R9zCUM8RT/HK5CodU8=;
 b=a6i4lfOYt7JwTnn0gYmcNQGzsLALe/iJK82J1kw67JNf+zIojoFvodXWO8sN+QfaMh
 oUkt+JcWUV/0bgqdorToDjWJpQVakjsHb4P3mnnVFlvUVKhNG4zq0lngCNGjqVUXfFR0
 Ui6s8P8/gm+1KrwcCYOvnrOoI00w9WkBiWAtXoHYJbbyoCrdFMDVAe9svymjkq98xIFT
 ua04wqgt+C3pI6iW7VTvQ7M/dojgcDa3RZ4Pn8F+qFYuchDrsUkiyBj3lH4tkkTxU3Mk
 U+TBAb+aB/HmKpwjOHHwkDrkinvF9rq91LxRvvp5rgAncLNpU3chJKMoMQPN3Ybbx4tW
 PweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336908; x=1756941708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLWZcll6BBWWPhJe3hiHwSDE6R9zCUM8RT/HK5CodU8=;
 b=pNvLjiR8Yg1HjBmWLXjKAz/aTMsHbcfdkVte2SDIcL25z3G1osi4BSKgh/WRjeZQuZ
 BPLrbvr7pXryHzeZ7mOItR7Jw4QQWtFskWy3l9dwnrmrMtV4ej+C/UYNgploN36yt2rF
 M0qjfEVKsk5Ghbrt3QnaNR1xJbYr9idoDx7ArX67BMUMcUVLRLU8NdFXTcoK2sglDVOZ
 Ivtfs4wOuA3VX7HgeQ/SJ89vISz2MllFa0IMBvNC+wBNNEpKGInyMKbfl6kEx8/riWv0
 lTF57Bg3SLwI/96Iw00sFEBRphC/sf2n9uUAWdFrzGM8SNKbxsKap8pq+6F9U39Ksk1c
 V/mQ==
X-Gm-Message-State: AOJu0Yyqa/8DYeT+XlyICJFw1sNfVOzmhy8dE49S2Cr+VCQCZB8FSazZ
 8Yz/9Thb+/mI5YVbzozO6k6yNzRSSqdX53itSalAg+2h+xV31mFEpCYL9QtNzqKskLcnGtvh5R4
 uKOtrM8U=
X-Gm-Gg: ASbGncuFaT6/0ua8aBfwnOxJT1+gavLaOhJiFcuIFBwgq+m/v+fHiZLW4zyTt0uVk8F
 SekSjsT9CtDyto0qVHRTxSHZqbmoFv3saJDZ4l5BzKj8raCUOzsQIXbSFetg2bM9MbhOXaIWNnM
 AUQcmWavCujws/wg4xPE9CgR2ZsbljnoAmU14QaackxPG5mnAVam2icYj99f+dZMpk3gZQy0PQk
 tWZgrbWXy1Al2I2HD3AyBXITDfUvxr0bDWK/V2fVjqBVUjPq2Slw9K2iXs93Ci5iCKuAVcSCxhS
 JEhSU3PyuTg5zITg5KlUKQP0deRL0Ol/bVWA9qNRTX7Jn08x3FToEJfgs3wP1UcPCE8KKDh7EP+
 tUBJUHcT69wJCcqi7p5N6WToNnw==
X-Google-Smtp-Source: AGHT+IGi8Wa5Hs4WOIwWVfUR+AIk5dk8CHtrcsUyoKxmn2236ldg6Mx5XwiIteAuvXRZyfsh4T6AEA==
X-Received: by 2002:a05:6a00:2989:b0:772:775:88c9 with SMTP id
 d2e1a72fcca58-77207758ab4mr4917533b3a.19.1756336907974; 
 Wed, 27 Aug 2025 16:21:47 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/46] linux-user/arm: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:04 +1000
Message-ID: <20250827232023.50398-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 51 ++++++++++++++++++++++++++++++++-------
 linux-user/elfload.c      | 41 +------------------------------
 2 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 9d54422736..739e1607e3 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -480,17 +480,50 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-    int i;
+    CPUARMState *env = cpu_env(cs);
+    abi_ptr stack = info->start_stack;
+    abi_ptr entry = info->entry;
 
-    cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
-               CPSRWriteByInstr);
-    for(i = 0; i < 16; i++) {
-        env->regs[i] = regs->uregs[i];
+    cpsr_write(env, ARM_CPU_MODE_USR | (entry & 1 ? CPSR_T : 0),
+               CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
+
+    env->regs[15] = entry & 0xfffffffe;
+    env->regs[13] = stack;
+
+    /* FIXME - what to for failure of get_user()? */
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
+    /* XXX: Linux does this only on ARM with no MMU (do we care?) */
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
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 89f3972253..9586873954 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -293,46 +293,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
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


