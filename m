Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AB1C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZI-0001RM-DF; Thu, 23 May 2024 19:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ5-0000Qu-6u; Thu, 23 May 2024 19:09:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYx-0005oQ-5w; Thu, 23 May 2024 19:09:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so313879b3a.0; 
 Thu, 23 May 2024 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505766; x=1717110566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlp7i6ItwtmBM1Fq48hjByZE2One86JoyuNbiHvtk4M=;
 b=nGJDZ2qs5s5E4qzP8dBEJFoOMt1rJk0aOmf9M64UnKWgJt2QOQqadn1nuzN6NhCJme
 J+VFlgjnyR+mOWz3gwAvn3YWfiHWP5zfepffq7tc6YkftDLXJCgBKlqp52B+ys/nky16
 hYx/TfkT0CI3AtDiaV1tFgcrGvG6xfPJkzKExxBQ55gmsc5CuWjh/q5QRB5YsQttHUUb
 6ckp8zLcUSqvShbA2zdd0EQrn8Qg4S80Ak4gPQl5VUi/asuxmUF24T8MDgtJSUsPegQJ
 /HiibVFGM3BBXPuy5awPMmFVPZA6Kjzlabyn9Fa1eJp7n/aEJTCGNFrfTn9SL2gqhGNv
 q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505766; x=1717110566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlp7i6ItwtmBM1Fq48hjByZE2One86JoyuNbiHvtk4M=;
 b=OoTFyt4Oyl85zHWuyz52ah0Nmciu7MtDi78/z1DUryVbb4qyafn2plWLTTWmTpdRiv
 NlkxNwWxKfMDL2VuONimypTL8HjPEY+AgU7rI8JfzCDfEgcpN+hDDZMckG/4A0P5CU0t
 CEETB8yCfaCDs0cAdh1ybkWNcbHoNX5P+xYFQQK5FFgdw+5YLoMhx/gVNV9MlTQw+Sv/
 YxnM3qnULMovsYZO7auEKuuNWDn3gx0i9ShVUJA+CDfDbTqE3Olm0HwzncHUPjVn5E0c
 sXbldD8waFz5eFd/ZHBuKtL0TQGsrTUPH02JM0pdXH2fSUKWwDiFbCfSPsQvCr8sVMek
 NhXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLB2Te20nBdvrlvQNiqdABvIywrBSj+zkp7Gr7NEJ5xr9i4OKgejvnZGaeySMoDtihIEajKpp4vLX+iul06o512tqd
X-Gm-Message-State: AOJu0Yxz9phqp/AS4MH5Ug7w2MgQSH26sIN8wj3mWU0OAF31bogddXfR
 fphgKXVoSg2xSKEekTNLVLn8eZHLojcIS1K60E4vQKwvr/68m+OwGktaug==
X-Google-Smtp-Source: AGHT+IEdL9R0ZaGGLIQpqvwA/HuGszZfgj2e49yrFQOwzXSvzwhbrmZASX5BNbdaALI3rTQL1ecVRg==
X-Received: by 2002:a05:6a20:431e:b0:1a3:b642:5fc3 with SMTP id
 adf61e73a8af0-1b212df06f3mr1258199637.41.1716505766141; 
 Thu, 23 May 2024 16:09:26 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 28/72] target/ppc: Make checkstop actually stop the system
Date: Fri, 24 May 2024 09:07:01 +1000
Message-ID: <20240523230747.45703-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run. Make it stop the machine with
qemu_system_guest_panicked.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2e3f36a3ef..fd00c044b5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -425,6 +427,8 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
+    /* KVM guests always have MSR[ME] enabled */
+#ifdef CONFIG_TCG
     CPUState *cs = env_cpu(env);
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
@@ -437,9 +441,15 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     if (qemu_log_separate()) {
         qemu_log("Machine check while not allowed. "
                  "Entering checkstop state\n");
-    }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+    qemu_system_guest_panicked(NULL);
+    cpu_loop_exit_noexc(cs);
+#endif
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.43.0


