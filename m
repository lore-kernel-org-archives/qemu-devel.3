Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D1EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKny-0006kp-Co; Wed, 12 Feb 2025 17:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnx-0006kP-3D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:01 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnv-0004Rq-64
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:00 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220c92c857aso3359015ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397717; x=1740002517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uc/r3YpfA3pdOgGMQeJPypU7HcgcUgMjDmFPlunSy+A=;
 b=zUkcIZCQDDmVkKI1VYWMZD6KAKYDUFvXSSEZOTL4v6T+8XnS59XSWjCEUPUCs/ZnSq
 7/BZj6e4+Wj3/0NRZO9FC97CpcDIrNInIH5UK2eEpw+FuhFjyv27jrGjfGyC2RgndPYc
 ipxBbaN2cEdLTcsXaeI1rqb2GHOjSwMXGAeFxk62N9sOHSvGr5u009NxtKgdk4PyndW7
 T8XE9DntV/RumD16G/T73PkXPjv7hSq/5wicL6niVdi844S1gNy5HB3AIP3bTEoMn3cO
 vvx06AWuSHTACC8OfY3xbB+0xbKgo1N67BRAF/Q7WetepIe1cvnmm+dasl09AW0jOhnW
 VKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397717; x=1740002517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uc/r3YpfA3pdOgGMQeJPypU7HcgcUgMjDmFPlunSy+A=;
 b=QcPxF+gPejAqxCq1wNP8IFfXpjOF2l97PyMAqHV0ABQAK59KfRhAjL4x9pT6ZI5oVR
 yS4JUhaboSUlUFLqcwX9dBAuCBCqj94+UMNqGphRUzTmEQu0g5zgJcJ9lWZhlcQJKcv+
 NiWV7FLPZTklZHzPSC+VbTgwmqRV4pJ+NepNvy0enp9xgSWBd+yn4lZqn3DY5CYEy3YK
 y71XudaMdf73NATOurqy1qR3WPkm5H3YKt/q9QYWUlMNscLRXvSDqp1RP66nXDY37Yzu
 XRX1j8o0eKkOZggpTzFyoUd9jSVFN3DWAQWJ6Q0XsoQpAQ+UF41o5hQ66TRptsACkNaV
 Dy5g==
X-Gm-Message-State: AOJu0YwxLM5yteywcueHULtVgsILDxVFbhRT6xM9LCVOYBUTl9RKkq8n
 HWHQXvzV/VT/Az3LEGzJOKMZoHJ6/CG8D8MKJ/RPIFgFWdhx6j5Q4YZIvSmzv5aUIi3aJI/fvWs
 P
X-Gm-Gg: ASbGncurOjvVUdxloKKMosUSiVx+Hb/Bh+0S5R7yodHYm3njOflmU+E/QVCamjc2B7L
 dybduVJrYMomzp8hS28iPOAlJ/iHn7U/B+kMJTkA5l7+6GjhgrhpG0TcZzIP0shQbsrBGlaf/5C
 PmhaCWSpszqY+LguW68j/woIA329O02W4cfrjTPu2/arqdntAcSSIA5Y3PlwFSZ4JjIKLlDo7ZO
 otMgkKuhxq/0NRtTNl97Icr+nyDDASQbs6X0hdoweYQ5eS4LcZWsw76Io8IJkZlBZDMN8X/Tdf/
 AsGz7Xj4SCyQiZM8xHXKOCFtM9UgYuz4oxzLfgje6RQ5dcA=
X-Google-Smtp-Source: AGHT+IHkF3pe5pFq8b6E9PGR59TOs+alcKe8dGX+5TgWXEwRRQW22k3sKQqDT3ra9NaTHdqq+UFCXQ==
X-Received: by 2002:a17:902:d506:b0:21f:3a7b:f4e6 with SMTP id
 d9443c01a7336-220d35b4944mr9847825ad.23.1739397717533; 
 Wed, 12 Feb 2025 14:01:57 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:01:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 1/9] target/microblaze: Split out mb_unaligned_access_internal
Date: Wed, 12 Feb 2025 14:01:47 -0800
Message-ID: <20250212220155.1147144-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/microblaze/cpu.h    |  3 +++
 target/microblaze/helper.c | 25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f6879eee35..45f7f49809 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -372,6 +372,9 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
 #endif /* !CONFIG_USER_ONLY */
+G_NORETURN void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
+                                             MMUAccessType access_type,
+                                             uintptr_t retaddr);
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
                                            int mmu_idx, uintptr_t retaddr);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5d3259ce31..8b096e3e58 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -268,20 +268,20 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #endif /* !CONFIG_USER_ONLY */
 
-void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-                                MMUAccessType access_type,
-                                int mmu_idx, uintptr_t retaddr)
+G_NORETURN
+void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
+                                  MMUAccessType access_type, uintptr_t retaddr)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = cpu_env(cs);
     uint32_t esr, iflags;
 
     /* Recover the pc and iflags from the corresponding insn_start.  */
     cpu_restore_state(cs, retaddr);
-    iflags = cpu->env.iflags;
+    iflags = env->iflags;
 
     qemu_log_mask(CPU_LOG_INT,
-                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
-                  (target_ulong)addr, cpu->env.pc, iflags);
+                  "Unaligned access addr=0x%" PRIx64 " pc=%x iflags=%x\n",
+                  addr, env->pc, iflags);
 
     esr = ESR_EC_UNALIGNED_DATA;
     if (likely(iflags & ESR_ESS_FLAG)) {
@@ -290,8 +290,15 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
     }
 
-    cpu->env.ear = addr;
-    cpu->env.esr = esr;
+    env->ear = addr;
+    env->esr = esr;
     cs->exception_index = EXCP_HW_EXCP;
     cpu_loop_exit(cs);
 }
+
+void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                MMUAccessType access_type,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    mb_unaligned_access_internal(cs, addr, access_type, retaddr);
+}
-- 
2.43.0


