Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED83CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTI-0005ti-Nb; Wed, 27 Aug 2025 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSy-0004WJ-P6
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:08 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSt-0004L7-LA
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:07 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3253f0c8788so488981a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336921; x=1756941721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5IHWXiuirOhIdHwAX/EQgapibaS75RzzatEhNgb4z0=;
 b=DfwiY/Ur9YhcdPQR17oJPjSdjaPu1KodOcxJotDrhX6frjB9zi5SzzqM2bpebGlgc6
 vYchYg0UOeBu/XYhVS+sLjIpyCwNYWQcmYYa4PHpyL6uIbSXHEtV5ClROg59I/KzNW4D
 oi6mSWljl23/KdlbfJDL86137O2RXSg+G3T939zHlNUOLQG8GrtDOcv2PaPJ0kY8PXm7
 WnXK0hS0Mgz0WNBEjfLZW2W4v4pn+UZa/B21S4Slje/MmoEVt2IfgvTwXr3N8X79V9KX
 WFgEEUDKZCfqvejbPrhBpQKazHOIvTkNvmzIDICD1ESQxN2Mb5IxIh1rNTe7sdr4D/uM
 uchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336921; x=1756941721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5IHWXiuirOhIdHwAX/EQgapibaS75RzzatEhNgb4z0=;
 b=RyxMj+ys19hcq0WvT5Y5GGPgzi66IKpGVB1dLdFUdB7fSvnvk9mvHzRC/G2f4WwoUd
 eqZhe4uTwoTewJAPyc4vhdjh3YMphMw2DCgyYKJrgTzLS9hlbFEHAbYuCruhgrxl1rWj
 pB4zRtemQhKgDnTmDh85Wvbn3whbNnpVcFKLguSQUamJGav+Ud4jVfGpU4QllyYVOMEg
 DArj9e4ZmzsZC5VLD4oqTtavJNSKlGUS8p5OknwVwSBArzI9+3LmBafb18rM05lbEGYT
 1wzlvRujpVORC9+OjTt1Gudwi0Dprjear3L9Hpf6pWb1QOm3R7tVF3sd5z94QBeQwimx
 J7hw==
X-Gm-Message-State: AOJu0YwpDvRtqaqNu6AQpDHY664ghme4yWym1V+ph5P8bP4Ppbm/qD+S
 zdkx4BzINkiYG6q4D9rHkcH3XaBNEiOeeyJ2X6Cb+f57QltsTxAcibwi5cNzwkAFkZdBiOikyDE
 UoC02kUs=
X-Gm-Gg: ASbGnctAdr55iVTo1nDaXHBTkADrR8wqOEJC8/e9M3jWhA5Mtyaeg/SS7vLJ2f+XB4G
 sS7geYQvqCyrBCpe2RkwH7kLVF3sMu8itEv4WAGMykd/XFra9sD1dMLFvgZutAzAhzjnBk0jA5U
 M3QEtRN9cPgeOV0t+yGNzmL57wr35627WRev7fYt7tlH0I+G09SfvyrGnJ4meagUz5jDwP+8xZK
 zcqZhMeUr/4iqLZLqauHxbf8FsopCvTXmV4K7kBNZ0VFxDUJQQ/dXJTBfQH1w21IBfNRtobJ5BW
 cF+k5Y3UlxGX46dXaz7ut6jw26SvPL1EdZXXFZTogKjTlnrdPhf4eMCwHLaX6ARavUY6w5Q5MI4
 q4UOZisiWDR0wRsrEZEKgRXw9BQSwH9fnKzlr
X-Google-Smtp-Source: AGHT+IHlCkNedVLU77sLuhJtGobn2weWAx0qzXk64ItfeczVnhZYfz2F8Jn8THhXJZypeb+QBPihUQ==
X-Received: by 2002:a17:90b:2f47:b0:321:87fa:e1ec with SMTP id
 98e67ed59e1d1-32515ef197cmr26127483a91.34.1756336921087; 
 Wed, 27 Aug 2025 16:22:01 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/46] linux-user/mips: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:10 +1000
Message-ID: <20250827232023.50398-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Note that init_thread had set cp0_status in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because mips_cpu_reset_hold initializes CP0_Status properly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c       |  8 +-------
 linux-user/mips/cpu_loop.c | 16 ++++++----------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0feccfbe91..ac96755b06 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -581,13 +581,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->cp0_status = 2 << CP0St_KSU;
-    regs->cp0_epc = infop->entry;
-    regs->regs[29] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 6405806eb0..e67b8a2e46 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -211,12 +211,9 @@ done_syscall:
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
     struct mode_req {
         bool single;
@@ -245,12 +242,11 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 
     struct mode_req prog_req;
     struct mode_req interp_req;
+    target_ulong entry = info->entry;
 
-    for(i = 0; i < 32; i++) {
-        env->active_tc.gpr[i] = regs->regs[i];
-    }
-    env->active_tc.PC = regs->cp0_epc & ~(target_ulong)1;
-    if (regs->cp0_epc & 1) {
+    env->active_tc.gpr[29] = info->start_stack;
+    env->active_tc.PC = entry & ~(target_ulong)1;
+    if (entry & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     }
 
-- 
2.43.0


