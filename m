Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DAC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoZ-0002GF-1B; Sun, 25 May 2025 12:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo1-0001ke-1k
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDnx-00035n-4i
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4c9df6f92so1358635f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188946; x=1748793746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAhHFjlenR/Sqt29jyVYJUHEixh44cdrPOm049Pm2o4=;
 b=TDmZ2zLxNNwdzemSCR4cebTAn9HY/Ys1Fn+I1poH2sMxQVyk3qd0FKvU8xJXLUDI6a
 9dCiLJKFiP1NAw96rUVcEr/WvxSbry1FIOUL2XisdYsyC9SXbfVEynl+QvH2aBlwCXeF
 /u3jAbhdw8PFpYohxNq0Mq+fowpiAxA/3hT33fATHtcelpZ0UGP/AqR1fnDTv3rwbKVl
 2OVsNcNWvuSch8BwRZm42EUoIKvx6FQjOwJrAyjz11bhpGUTlhL5F7MhghaEB+Eu+fPs
 T1ncokgXvbvDxKyIBMWZ4MkMal0uQs5pNIP1ymGCmOnmVtpXShttHIKygPCQfOWVQgkp
 hcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188946; x=1748793746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAhHFjlenR/Sqt29jyVYJUHEixh44cdrPOm049Pm2o4=;
 b=Idp5b172Sjivv41+tSs1FydwVrZ/HMv0twVMTXkWA+0HqpYXsWrugXyQUCzt3JGuNi
 3qC4NSa+FcHcjhDO3TJoF/1igZFdpmHbw0IlOK5QFoN257wjn7mr6WfZpC3fEj0NvbNA
 ph9DaF1J+wpsz6c2pjUA2ngNloIStDUNi2+oCwuzq31qh7fZKNW/8BMdNhUyzKjonOtU
 bnvYE8J7Uk0fbhyifgmnLtzLtIGPSKyw9/76SHKEoabLYePwI1DNpYDzDsc7uk6ANHvn
 8SsXdX07GA0q1QZD+CXfYy2kNRUQbOiLpXuYAaVTSa/k/FBQQNhxjnkXipgNLT8606PA
 u9cA==
X-Gm-Message-State: AOJu0YyggY2M5AzS8tOjFgIrmkBbWpKjyary1UrU1yMEEv/0IGVZrcpM
 inmMhRobsls4uuwQrTHJo5MC6yoTOI4SZf68mv4y/rMyCQJxwsn6Ch+n/Ii7UiqnuuOFvDZALkx
 KGPJLyRc=
X-Gm-Gg: ASbGncswMLqg+HpuiOdmFnyr37IutB8Z0M5cU90tgCtanL8w8qXcTxH2/ePj6L0qkRl
 GeQjLg6bXNxyMVWRbet8H1tRLDBdtXQXQFEkdwOkVr6Mb+gx4Aob0BXW12aS3IOk06M8J0svwUs
 15fYyrkUGho8uk+bqi839VhyoVHOzAaLOkzdrQ9ypPT1cI8gYU2PxUfXyMkI99Y6hMYtgqS7rxJ
 nfw0JBrsA+x8KHjEn67ZmYzdvAOs4HHDPRbehZZnsqQd0w7SPo2He1x6OoNyqLQxynYjIb7erMN
 lSbsDrAx0xlnUC63lSACuyq/Odz2fUw4VhEgI2iUucGDp+aOVlI9239p
X-Google-Smtp-Source: AGHT+IEi6ATy9l47m4j/r7ipKsrqRyScHtmR/LhPQDC4t5K66pKvgg3/gpmbMgtFIVKtmeL/7gfwpg==
X-Received: by 2002:a05:6000:4203:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3a4cb4899e8mr4490805f8f.36.1748188946310; 
 Sun, 25 May 2025 09:02:26 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 01/10] target/microblaze: Split out
 mb_unaligned_access_internal
Date: Sun, 25 May 2025 17:02:11 +0100
Message-ID: <20250525160220.222154-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
 target/microblaze/helper.c | 64 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 9203192483..5fe81e4b16 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -27,6 +27,42 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
+
+G_NORETURN
+static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
+                                         uintptr_t retaddr)
+{
+    CPUMBState *env = cpu_env(cs);
+    uint32_t esr, iflags;
+
+    /* Recover the pc and iflags from the corresponding insn_start.  */
+    cpu_restore_state(cs, retaddr);
+    iflags = env->iflags;
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "Unaligned access addr=0x%" PRIx64 " pc=%x iflags=%x\n",
+                  addr, env->pc, iflags);
+
+    esr = ESR_EC_UNALIGNED_DATA;
+    if (likely(iflags & ESR_ESS_FLAG)) {
+        esr |= iflags & ESR_ESS_MASK;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
+    }
+
+    env->ear = addr;
+    env->esr = esr;
+    cs->exception_index = EXCP_HW_EXCP;
+    cpu_loop_exit(cs);
+}
+
+void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                MMUAccessType access_type,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    mb_unaligned_access_internal(cs, addr, retaddr);
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
                                     MMUAccessType access_type)
@@ -269,31 +305,3 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 #endif /* !CONFIG_USER_ONLY */
-
-void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-                                MMUAccessType access_type,
-                                int mmu_idx, uintptr_t retaddr)
-{
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    uint32_t esr, iflags;
-
-    /* Recover the pc and iflags from the corresponding insn_start.  */
-    cpu_restore_state(cs, retaddr);
-    iflags = cpu->env.iflags;
-
-    qemu_log_mask(CPU_LOG_INT,
-                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
-                  (target_ulong)addr, cpu->env.pc, iflags);
-
-    esr = ESR_EC_UNALIGNED_DATA;
-    if (likely(iflags & ESR_ESS_FLAG)) {
-        esr |= iflags & ESR_ESS_MASK;
-    } else {
-        qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
-    }
-
-    cpu->env.ear = addr;
-    cpu->env.esr = esr;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit(cs);
-}
-- 
2.43.0


