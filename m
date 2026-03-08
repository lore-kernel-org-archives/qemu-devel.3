Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D620F55138
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Pb-0006dW-MD; Sun, 08 Mar 2026 03:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pa-0006dF-PK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:50 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PZ-0001Ly-BO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:50 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be19f05d7dso3689893eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954328; x=1773559128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhdf6+VhGm1VbDUsJVUdk3p4/TzAmoSvruGWW5HiuPU=;
 b=QNKZqywTWAvGEpCfWV+RYDgKRfMLVzqoRhfxtX1TlCsAK9bIo3p9vfD0U9A6Jp+hvY
 46pp843rGvkZ3RQ4SrmnvmCxrt0jbEvSL7P6JQhouZtaIZWoRDMynRJ6vXwINTd4HfcK
 kGh2jbKYqqn7ZiaWwC4BLuLmZ5iDkU1jSvHDonENjbpl7llnN02xurxUj7Gt5gM6RyT8
 UkowlA60fMC/fpnMy7eTWXQpUqGf4JV+ZiXy8arXB9wn16zUhCrjJ1H88Q5eIKybovFK
 EuTKvTXihHO3Ob+Ek6rIJy1k1E9KZayCF5JOdajFWRa5/XIa4Im40IUugpCTC03t+d+Y
 1iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954328; x=1773559128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhdf6+VhGm1VbDUsJVUdk3p4/TzAmoSvruGWW5HiuPU=;
 b=dVtmiJ1tuM/25IETfgvaGNpbTzZteoIfeTMM0RaA72yR0BkSztagmc0IAZgKHz2Zad
 2GKMbzHU9lob/NiEGRWOfPdDqr+6oJnMzRLcrO3BGdprJ7LO2JHZz7YXnDw3ZEfrxydZ
 npcU9XXnHZEkNGNNW+XTKL/surWwbIFkRkH3PtZzjET13BSrUMFPV0g951ZVAREq9KQG
 dYl4uND/3GUHx4q5d4yybrJZ8Y7K4uOAvzVXEI5M2XASNWletqGknxZV1WmYazNHUEGZ
 7qegjGjiRgU+Ib+ZPhK+veWUAOMRcawxwK+izbONDyECP65aanRMw0jnw6yuy1zKaRSA
 jGMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAl/MDwgqw04cVkPhlN2uVmKThRmDLmrbJ1MZtocFAVm4BVQe+WAfFM/Fx32iEPpbbJnrJrr4tky+C@nongnu.org
X-Gm-Message-State: AOJu0Yzsc16Cw3yMunUimN6LGwQ7XtbEci2BSGS3f7gVUXhvwV+HSKMH
 U3gfyQuCTco9tNA7n6DG6eqaDYmCfa5QYLqsBxB5Hwl6Ry+aycGqd8Nh
X-Gm-Gg: ATEYQzxJr3XYavciyu0aJ170HRHvr8kTqscX6s+gpKEqud/hf2IZC0+l3trKq5kpJM/
 6e9fp9ZaIa2ibHISF2X0sd2gKxIsg0kUhiY831xcTFUz0JWEam0MbnGqCRf1M/wyuZy6b3Lej9h
 01DVG2EvUx37Zan0bwoO18/eiZjVNejjsPZ1kLsl9+KT2LiGP9rzkNt65+zEcBDg6ytF+OK16Hv
 5RewYOK2daA+GKgILAqBPBv/AoLoPV3zTUG7pgLe7UWS3w41qVE2jcSXm/IDRzpfdJly5yLCXCG
 QC3pw5B39tEw3cjO5szJ5YtO8jo3JyCCnFIgHS+jxei5EuZcvcdERGkE/Vb5rG9BKyvXKpi7kmI
 wpomk4XLNnNpBJ6rslATjwEyBCIYOOg49VURxxBvSd125eFyGtVnghd0vBYuBWsXwO4ULU7PjLn
 vz2WPLwfMOdsbVSRM0dpHzgt0pu2rUwGGcV2w2zRVkArlL82gMc6O5NcNGTV8jWT7tT9n5PH38k
 ampFb+XPQbVMNVRM5/IpT3yRrc=
X-Received: by 2002:a05:7300:2393:b0:2be:2912:ff66 with SMTP id
 5a478bee46e88-2be4e02bf42mr3642378eec.25.1772954327896; 
 Sat, 07 Mar 2026 23:18:47 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:46 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 03/28] target/riscv: enter Debug Mode from pending DM halt
 requests
Date: Sun,  8 Mar 2026 15:17:06 +0800
Message-ID: <d31a7f38a9b0d3fc54e9ce562a648717c8855b3e.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Consume pending Debug Module halt requests from the regular CPU
execution path and enter Debug Mode with the recorded debug cause
before normal interrupt delivery.

This routes haltreq and reset-haltreq through the same entry path
used by other debug stops, clears the pending request once it is
taken, and jumps to the Debug Module ROM when the hart is wired
to one.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu_helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 714dcb446e..e477016d4a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -655,12 +655,31 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
+    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI |
+                    CPU_INTERRUPT_DM_HALT;
 
     if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
+        /* DM halt request: enter debug mode before checking regular IRQs */
+        if (env->dm_halt_request && !env->debug_mode) {
+            uint32_t halt_cause = env->dm_halt_cause;
+
+            qemu_log_mask(CPU_LOG_INT,
+                          "exec_interrupt: dm_halt cause=%u pc=0x%" PRIx64
+                          " halt_addr=0x%" PRIx64 "\n",
+                          halt_cause,
+                          (uint64_t)env->pc,
+                          (uint64_t)env->dm_halt_addr);
+            env->dm_halt_request = false;
+            env->dm_halt_cause = DCSR_CAUSE_HALTREQ;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_DM_HALT);
+            riscv_cpu_enter_debug_mode(env, env->pc, halt_cause);
+            env->pc = env->dm_halt_addr;
+            return true;
+        }
+
         if (cpu->cfg.ext_sdext && !env->debug_mode &&
             (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
             return false;
-- 
2.53.0


