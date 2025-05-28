Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D204C5B54E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBw8-00084J-SV; Wed, 28 May 2025 04:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvd-0007uY-5y
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvZ-0005DD-3V
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4bdee0bf7so2821710f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420058; x=1749024858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJaBhv0ijUe3F26URh+WI237MjGIudTdQQErvUey5XI=;
 b=gfY4I7cW5F1vqL9G1QAD5kAeGGMySQe5e95C7MPNEMgtRoYviq83M/5o3PsK3bUB02
 3M0N52yTLAvvoaPsFc3iC+4fya+NRnkfg6c0x8zLt4+yAR31oWP/pQx9dIh9N6naQUPs
 6WJNLCFXxb6WPs0E7eFiF9XmsMzBCL/aRwdz5oPkgeCVm7rWf+oM6R9VkePfm+CfeOOL
 jA8NeOtvTKaThCUqq3tmLHOdUtyu1RarZj9YKjPMZwp6e7pIqUkJquN2BTd8dw4glKDE
 ISRAlDx0dMF30daUI7l95vhEdaWTjLovYHbXIvxapD5H5SRGnG1f6hObV13TIgg06Rtz
 7T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420058; x=1749024858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJaBhv0ijUe3F26URh+WI237MjGIudTdQQErvUey5XI=;
 b=aq+RbJsZBuWIkoUKg5KztfTzM41M4ecHyIRTToY9ZIPJVc+Spj39KN+pV1hmgQ996J
 5pFiIoTRZRdaa+XxFviAtd+4etIPEvRlzaNlqEp52W+erdgEoHY/PvdpU1iAQ/RN74mh
 BQnNL6AU1h5wNawLkvoRfsfGJQIcGU+ml623D+PocCh6U/9g5LGMQKfSbniyXiwkcNHi
 6KtTxeXdewQIllXTxNS4If8zHSXsRS/G1zxwpZ5VxzmusaK7xEJZA3LTTy7YGsoYubiZ
 82Q56IoLp+GKc+wTBJv3w98Vl4QwHzz1DcqGJDyAW5nmD4T/pU39XfO1o5N5bQHwly03
 PXRg==
X-Gm-Message-State: AOJu0Ywrjw7dFNgheu99MH9SWA1Gsdu12C1kd/JnGLExlPe9KxO2/HSc
 b6p2YCswYE+0U3qwRFIadMZR8i6QNBkdnEB4REkh+095FnjV0KP+8ke8cJahk671wRnBRb5fLXQ
 dU1WDfNo/4A==
X-Gm-Gg: ASbGncvvOfsQ37wY2ttw2Cfkwk3Q+Es/WSJyEIMEuklthJDcAacCdhwygl3CITosagB
 uDA+YoGAuVT7Q4zBV0VtkxVCMT1hFXm5qJOtxusNRJb2CSWCEFlGHJft3ZqnC3qW4GUz5VWuzL1
 qmj1LOEmFdvtQG6SV2VNI1d+r2OLPuzM96+i8Ga5ISrpsJPjW9iaadzYDCGYKn1yHBWBFvh0Ds4
 4fY+LN5LciBZo7lu0YSPu5vZpxt9+N8GRcOC3wfEFnLfnZPWLMFep9aAltcyhmudv/0EPJK6HGX
 ZZhTylKFmwcgtXsbS56HdcLaweG50Go5vBpsK31iffS0btMx2Omq7a4cvMRugkRLeNc=
X-Google-Smtp-Source: AGHT+IGF5F3i0DVq+2ZehMlN/z/IvQO5TZknbANgk1sxbxBniTeTFr49FCQ/kb4rJURZBG3ZCdcbpw==
X-Received: by 2002:a05:6000:288f:b0:3a4:e082:c8f4 with SMTP id
 ffacd0b85a97d-3a4e082ca5emr5432989f8f.47.1748420058114; 
 Wed, 28 May 2025 01:14:18 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 04/28] target/microblaze: Split out mb_unaligned_access_internal
Date: Wed, 28 May 2025 09:13:46 +0100
Message-ID: <20250528081410.157251-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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


