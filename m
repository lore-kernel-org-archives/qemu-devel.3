Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED2FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHip-0005Sc-A1; Thu, 03 Jul 2025 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfp-0006sW-2u
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfk-0003bl-NQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso42638895e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540406; x=1752145206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=r/qH9Q8E26okDUnQ3bR36DteCJrwy8orRxAh2PNJtV/SNAOkPjtt1DptWG3YB9mGig
 nom+95BnxPGn6YfpBYdhamhlKRRnq7e41dWS+bZO8MrNy7kDxGe7QvJok4Yhn1PfU2wy
 gyTiNGsgoglA6z8zJLxI1boQFUW1Ab1jWo/wYbMigj0pYdu+9AADM6/TJ3gA1HIV5LZm
 wNXt8saQKIXHypYzv1asyfqtfQb424w5tHdZxX4yyaC/ze66LnOfwDxHCOWmnTVevHv9
 8HDGuUY143oE/rS/j62F4RQTJIiBGVT/sytM+GDsS6EARu2Bmh+C7OCnlaJhQZm9CVGV
 XZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540406; x=1752145206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kywse2u9MhU8QPCYXPxuKeKrJVPdiRbR+9Ey6S9IQUI=;
 b=Y/NZXUEH9/yoNb3Hw6qIp0045wZ8XYnq6IkNa8+RfUEuu+jjzt4k4y9gnUNC/a7G+2
 nVMEiX/8AK1AHvQdAcOcygc13XlhAMK/5fALAiBazgOC8iakbRpvu9IZV8PIQyodtcMj
 PzKA2RKFVC7JJJj5MhjzZccSTLO0uQ9ehDipn7etR/GfXaoDhyR3G7UOn7c5FjB5rJu8
 b2XBfQl2l+cozmzzvjWivcvgHXQu2pEoQbhdWFItyU0CBUSHd8JUQm/aeoMPxhs+5yUw
 ybP6l3InBujbsH20Imlv3blC2q07/v3u++C5jEkaadg+QyISvdUxLP3IGLPb99gcWPY5
 vHuA==
X-Gm-Message-State: AOJu0YwqIaEhfgGwmybCwVzEmHmt+1hNIlGoV0SmuH0umhAfQL9o2yga
 n0LAomzgfvfstAOQU7zBCla2WdDdQMs4Gkd6j1npE0xzeTly9KGd+H7upd+NEspozpqX+xm0EP7
 XO+uy/N4=
X-Gm-Gg: ASbGncvLaRDQU7NW9cipi3c856ol8bgnIYSOvh7SGVW1UlCxrxP5fsa/3pzu+idWEkS
 J1wn7Y7MgDF0uDIG1RNqZs2C4d6F6kx8OMNc57nMSKKWTKYFIAWp0zH1Xqz3/V+WxnXHiWevsMo
 CCLwg1bIWV14D++a2suQ3h1PEUFBCFA//Uf3zr2nm2z5Jw6BhPuQSqFdjflkqoz7L+6QzKkQuWM
 7TzMjN7KRQGoI1Z8y33UFnBxlnuk/CHIVFq3V28A/RgAHgynbamyM5RaG7YCxlDLYpJl9KfD0OD
 rG6UVUi84rJkuJ8ZuK91kmsItfhF+pHT7mjVMcKzPVPOe5fpmLVFAeVTXCOwqewsFE9D8H/u8/O
 B+wuEyrfwjBI=
X-Google-Smtp-Source: AGHT+IFcuVQPSvcB9tMEYZkxIF5efKkb5dETC/UVOZdIIwZuyXL+g/f5Jm/UZvPU76maeI70uQekgg==
X-Received: by 2002:a05:600c:6305:b0:453:6146:1182 with SMTP id
 5b1f17b1804b1-454a9cb45afmr25885755e9.32.1751540406328; 
 Thu, 03 Jul 2025 04:00:06 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e24bsm23516035e9.16.2025.07.03.04.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 50/69] accel/tcg: Factor tcg_vcpu_thread_precreate() out
Date: Thu,  3 Jul 2025 12:55:16 +0200
Message-ID: <20250703105540.67664-51-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Factor tcg_vcpu_thread_precreate() out for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 3 +--
 accel/tcg/tcg-accel-ops-rr.c    | 3 +--
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..129af89c3e7 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index dfcee30947e..462be7596b9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -133,8 +133,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+    tcg_vcpu_thread_precreate(cpu);
 
     /* create a thread per vCPU with TCG (MTTCG) */
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..fc33a13e4e8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -311,8 +311,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, false);
+    tcg_vcpu_thread_precreate(cpu);
 
     if (!single_tcg_cpu_thread) {
         single_tcg_halt_cond = cpu->halt_cond;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 95ff451c148..861996649b7 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -41,6 +41,7 @@
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
+#include "hw/boards.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
@@ -69,6 +70,12 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     tcg_cflags_set(cpu, cflags);
 }
 
+void tcg_vcpu_thread_precreate(CPUState *cpu)
+{
+    g_assert(tcg_enabled());
+    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


