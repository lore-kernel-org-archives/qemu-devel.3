Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A79C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUai2-0001Ph-9W; Mon, 29 Jan 2024 18:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeT-000750-Id
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeN-00007H-9w
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso6923735ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569365; x=1707174165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/uaC3GU2r5ag1NYLRtG0R3ws3tDO6FtLPMPWrHI/7I=;
 b=SmySVDk4CLGNNNDAGdf+kN3ViZI28aPf1/OUMu5YqX1fspLJMu8HxE8HeG6e4jJbkB
 uGz5Vg+zIZX8ZLRcqs5JfeLWhliaBqckfw/L8I6H13bzZXQdyV5p88Wx7XY2cl3u2LQ+
 v5gtJxr4LqOlMrTHAAY15Hs6UmzOIAPmVrHCe+OyqisGCAnps4RED/9cRCC/qBUo+tVx
 nYqAHUymJ4K3iuh9/Ld/6AUXSLpTU9IJm3rKwd/D0w8yWScIsREduRF3L4VGV5mof+6t
 0mB9CF19pqBnGtSrJi0GPbvMo0x3pNMZ10BRbnRMDymN5+4e3ciZ0ZTjBM4U8St1roFO
 gUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569365; x=1707174165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/uaC3GU2r5ag1NYLRtG0R3ws3tDO6FtLPMPWrHI/7I=;
 b=dQqcmMLsM8Tqol4WLRPCj+6mAeLeuoZtyc4pk0WhvyUZYibSowwGKaqBRKhG70buWp
 grwxHu0tHaQt3zwDBNiQnDUC8TsXt2Mp2k8Nt4rvyCC68h4PINhme90iI7LBzB7/1cTu
 /zGM4tzbvej/MZSF49I2ynL0nF4Cp8KMRUtI9AgxgddvMDjo7DvLaywp96+oB/aAXr66
 r6gnZMSkW0LhnXzEd2Sknj2b4YPmU9t2trvmtDoJR+qQxS0nbri78GpynWn5hePKDGd2
 Cw1kwz9mCeuEakVSiHySOXeTb3b+SP3hasT4EGtIZVUfSsnTK1QrmQiAvh7G/B5JuScm
 8iKg==
X-Gm-Message-State: AOJu0Yzole6WjA5uvlERdoGy5rk8LWagXvlj5JcOn45Wlq+epZeW/OZ/
 N1D007noIcojs/ACrsr0tJOrBEstU4MgBnXYmypOZUjqYUqmFnPaGh0pWybvKqQ2fzgFL9mom9q
 Jul8=
X-Google-Smtp-Source: AGHT+IF2dmmVJC6HuYJkxe9w/Awo0+4xM3RYdghfxsA15ZbmrTFy+cTLpP+Gv8g3rLy1aw4xqG02sg==
X-Received: by 2002:a05:6a20:b90a:b0:19c:a484:290e with SMTP id
 fe10-20020a056a20b90a00b0019ca484290emr1885572pzb.2.1706569365363; 
 Mon, 29 Jan 2024 15:02:45 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 31/31] target/i386: Extract x86_cpu_exec_halt() from accel/tcg/
Date: Tue, 30 Jan 2024 09:01:21 +1000
Message-Id: <20240129230121.8091-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move this x86-specific code out of the generic accel/tcg/.

Reported-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-10-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 accel/tcg/cpu-exec.c                | 12 ------------
 target/i386/tcg/sysemu/seg_helper.c | 13 +++++++++++++
 target/i386/tcg/tcg-cpu.c           |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 253b1f561e..effc2c1c98 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 82627b12b8..977576ca14 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -30,9 +30,6 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-#include "hw/i386/apic.h"
-#endif
 #include "sysemu/cpus.h"
 #include "exec/cpu-all.h"
 #include "sysemu/cpu-timers.h"
@@ -666,15 +663,6 @@ static inline bool cpu_handle_halt(CPUState *cpu)
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-#if defined(TARGET_I386)
-        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            bql_lock();
-            apic_poll_irq(x86_cpu->apic_state);
-            cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
-            bql_unlock();
-        }
-#endif /* TARGET_I386 */
         if (tcg_ops->cpu_exec_halt) {
             tcg_ops->cpu_exec_halt(cpu);
         }
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index e6f42282bb..2db8083748 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
@@ -127,6 +128,18 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
+void x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+        X86CPU *x86_cpu = X86_CPU(cpu);
+
+        bql_lock();
+        apic_poll_irq(x86_cpu->apic_state);
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
+        bql_unlock();
+    }
+}
+
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 5bdcf45199..cca19cd40e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -119,6 +119,7 @@ static const TCGCPUOps x86_tcg_ops = {
 #else
     .tlb_fill = x86_cpu_tlb_fill,
     .do_interrupt = x86_cpu_do_interrupt,
+    .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
-- 
2.34.1


