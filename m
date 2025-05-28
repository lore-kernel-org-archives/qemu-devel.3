Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C16C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBxc-0001MM-7g; Wed, 28 May 2025 04:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0008Aj-Uk
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvw-0005HU-8q
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so4682375e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420078; x=1749024878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qFWFQgm7tp2FoeXZowsVaEILXqBgZTLSVkJ211wbIE=;
 b=KwDUiyUvPBaD/B2te2z9PjC0NOXP94vdPhR2TnsNBMwJFRHSNcOAF8pVBF8pAy2Jw7
 VJNtMJzaEWi4adVzyWYu3N/tKSHRlmrs5eqZOEhdbvodQ1zom8ZkoRq1W3VG4ZLODegf
 soDYgajwewmPMIh2uaEt0adix6pMtplkMcyOKV/dlJ+WXiTMCtbqsRHctyrrwQCemQsZ
 jvGJSr+ZCtzVBLMpOSma2OLptXhaA1Iypc+BIjqwcjIsKy6BIOrLS4cOa8a81okndYNI
 yUgeHsCBGy+34UMY/s4eeTu4VL1EviNYs+a8NddQkenKpJmdipMac48Hf32uQb6HjymA
 zVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420078; x=1749024878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qFWFQgm7tp2FoeXZowsVaEILXqBgZTLSVkJ211wbIE=;
 b=ZtMtYQCnc9ASUHwH/33zDFyY+xHMh05XOVbiQEdfWQa9Gy+/szpL78SmjaT1j0tCkV
 jWQxECRiZNTQ3Za8aNApqMW0elHfl6wVGpY6L27lu4jtGQ14UXEhJvljS3MW+CpEWhyN
 asef1aYmpLfJWARlWH4/HtflQQB2QWerC1PO+57VQtIhqI3sj3ZsMO11pP6F8QTvJZjk
 /a/5dWrUeBJDFTuskmEnn0GRHffJ7aFiWUwKNNDXYxLBwSkN2WKBN6is4uxUzTQimkfz
 MSUtKyxMqSnmgYfBAwyXy1vIyY/iC5m5SsQnEkgioabP92HONaW5UbJmKKntxQ5blRAW
 TU3g==
X-Gm-Message-State: AOJu0Yye7iFpHxQYScmJdZYoDQM/Ieso0z+9hpF28paAzW9QWPjVqpP7
 SRj1NjBSnw9zy9tTSW5uB6n6m9fwaLJO/8/vuLeruMxNDGoGYOCL5/8zgRdduzlardBBqz82ZwM
 XmS43cXuC1w==
X-Gm-Gg: ASbGncsp3ST+0DfbSpeztVM/ggJdQb85zhD9tWm6xIcQCbck2s/m/15UemPq5M9Ir6F
 CqUK1NiiSADpooTM1XJwkG2RbsZiNBjopPrjnIoZX9EjRfk8DC7eKnGKDdbXpoGE9ZkNCAREALE
 pClYZ46JOaQ5bmpCOyHI6+RcNB+nvzU64tvRYo8Osd83HpsjWyiMCfdpNjhlgJZMdiBeBDqtoOU
 VZuEa9X58clPNhbwHypiFm+RGfnPUiWHCk7hZr4rnAPPiCbdjUTGV/16crs7T/PdGcyevGEuG0l
 PQQHVp+By5HOqeJndEvixbYdFNMhHi4Coo3Y8m251UnUACt21+VjpS6nIvrNvGcrQgU=
X-Google-Smtp-Source: AGHT+IHy+1pxeCFW/oKFm0z4uhwhluiRDAyqoKqnn/u6x5VkkxYvE94VkYUC1yZCNZaNFr5/SNXESA==
X-Received: by 2002:a05:600c:c059:20b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-44fd1a5bb56mr22270445e9.10.1748420078241; 
 Wed, 28 May 2025 01:14:38 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 19/28] target: Use cpu_pointer_wrap_uint32 for 32-bit targets
Date: Wed, 28 May 2025 09:14:01 +0100
Message-ID: <20250528081410.157251-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

M68K, MicroBlaze, OpenRISC, RX, TriCore and Xtensa are
all 32-bit targets.  AVR is more complicated, but using
a 32-bit wrap preserves current behaviour.

Cc: Michael Rolnik <mrolnik@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Tested-by Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (tricore)
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cputlb.c          | 6 ++++++
 target/avr/cpu.c            | 6 ++++++
 target/m68k/cpu.c           | 1 +
 target/microblaze/cpu.c     | 1 +
 target/openrisc/cpu.c       | 1 +
 target/rx/cpu.c             | 1 +
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 1 +
 9 files changed, 19 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 4f3b4fd3bc..dd8ea30016 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -326,6 +326,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
  * Common pointer_wrap implementations.
  */
 vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
+vaddr cpu_pointer_wrap_uint32(CPUState *, int, vaddr, vaddr);
 
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 49ec3ee5dc..a734859396 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2946,3 +2946,9 @@ vaddr cpu_pointer_wrap_notreached(CPUState *cs, int idx, vaddr res, vaddr base)
 {
     g_assert_not_reached();
 }
+
+/* To be used for strict 32-bit targets. */
+vaddr cpu_pointer_wrap_uint32(CPUState *cs, int idx, vaddr res, vaddr base)
+{
+    return (uint32_t)res;
+}
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 250241541b..6995de6a12 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -250,6 +250,12 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
+    /*
+     * TODO: code and data wrapping are different, but for the most part
+     * AVR only references bytes or aligned code fetches.  But we use
+     * non-aligned MO_16 accesses for stack push/pop.
+     */
+    .pointer_wrap = cpu_pointer_wrap_uint32,
 };
 
 static void avr_cpu_class_init(ObjectClass *oc, const void *data)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c5196a612e..6a09db3a6f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -619,6 +619,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 615a959200..ee0a869a94 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -447,6 +447,7 @@ static const TCGCPUOps mb_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 054ad33360..dfbb2df643 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -265,6 +265,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36eba75545..c6dd5d6f83 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -225,6 +225,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .restore_state_to_opc = rx_restore_state_to_opc,
     .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e56f90fde9..4f035b6f76 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -190,6 +190,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .mmu_index = tricore_cpu_mmu_index,
     .tlb_fill = tricore_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 91b71b6caa..ea9b6df3aa 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -318,6 +318,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


