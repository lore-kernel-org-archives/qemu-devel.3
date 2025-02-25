Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D7CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzxo-0002VN-Lq; Tue, 25 Feb 2025 13:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzx1-0002Bx-Kw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzww-0000HW-El
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so36925905e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509192; x=1741113992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbTRpF5vcyxr/D6s1C7IEHtKwvLNoxEVjp74TTMjyRA=;
 b=KSuLm6NC0auNjEkAYnkCF7hs5IrLZo9PFbObcN3tn+89PKLR9Qx0rcrhwYmsiUXqTO
 4iNuKs3c9F/bOvEqrzVmeCT+cvedAEk/0mC0n1SSK6yiWZWqhKm4wm6Pgf+HUBhRbgoM
 EmgmRlUUaMtaPetosxpZhIzdSGZ6g8ShWzIjDAIFNDEkt5ZR29SSfIKf2TZXbN8S2iTu
 Gk4FxzmxyUWhCoMrRPiIcPAPCeXaQ1J3ZKDOB6r0UIkDaE6vPFbghuN2Xj023BNYVOsM
 0JGDpC0V5RLejwyVXIArEtjmzASYJsCvQNkrmVXTAlsuwFXDv3dQkVEA2LT8Ru6plAaS
 ScKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509192; x=1741113992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbTRpF5vcyxr/D6s1C7IEHtKwvLNoxEVjp74TTMjyRA=;
 b=VOmeD9EBhyfdVqDzA8vcXZOdPfeUhBGki9UNGEQJmR8/m9/6YzyVjnsxub+KlCgs3P
 sjE9T1eOFlbEKF95rXy8BXZui6t/Rf4yRPEKvlYK6nyotGEXl6CjBI1sTNdgbw3aU1ic
 w7jADBrnEYwj99d81xD5odd8e/ZCCD5K0FrfNWm9/BJw3K9/zIIyU29Jl4eh5m6FVaTY
 Y2bjsmVo8d1EQqapfyKGHtHJJgCQpXiXv9T3A47f5l7jQ+YBghXWGgu1BbnoHQgMd4Ki
 IfuVV9MkNhzmMGZ5TlxZ+uQW5bq+17m0TmE+utbHXe6fhZr27H2jZNoU9FW7xXsBBQb7
 +ARQ==
X-Gm-Message-State: AOJu0YwMtvz913ZyMXELJKBcKIiY7haqUyiaKuN48LuNi9CfdPWtpgiL
 J07OB+2H/EaLAMzg2lSQZ1MgwFr6RQZsWJcu9jLVN0zp3ltrf/RWfWgAhaz6R2E=
X-Gm-Gg: ASbGncsctcIED2t5xGLadIPm9kNEVQrah4LQvVyT69qVkQ8Mvpbo9nvvIFzGR57iAAK
 /KwW8sjFSH9S6oJEE6pSP2CROGpBa6+O9t2Zduebdt2IMFaRWppUeD93V8epUhJiJITNQmNbrYW
 t0gDYkYyItAsuhPfKUOzRfUHUPBhFYos7tPYBgTtDK6QkX1/v/2YImMEBxpgLQHeLvwy2eWSngf
 K7ivSe35YDIJaxxyafVGpuzaBKNVxelfF6kRnY3DIZgcfILAQK0HhPQhmgqXXtUnSP9KEbBN/sL
 XVV+yg5ClYS6qQVyWTVmAXgNO5kj
X-Google-Smtp-Source: AGHT+IEq+ldn02LlB8ALfv/2PVb8RbqIIo0TN5XbPlxoSQ+pECInXYnm9NeoahrWW6BwXX+G3WOhCQ==
X-Received: by 2002:a5d:64e4:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-390cc60aeb6mr4538882f8f.33.1740509192240; 
 Tue, 25 Feb 2025 10:46:32 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab155eb77sm37328515e9.32.2025.02.25.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2C1F5F9D7;
 Tue, 25 Feb 2025 18:46:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] cputlb: introduce tlb_flush_other_cpu for reset use
Date: Tue, 25 Feb 2025 18:46:27 +0000
Message-Id: <20250225184628.3590671-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225184628.3590671-1-alex.bennee@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
TLB flushing) introduced a regression that only shows up when
--enable-debug-tcg is used. The main use case of tlb_flush outside of
the current_cpu context is for handling reset and CPU creation. Rather
than revert the commit introduce a new helper and tweak the
documentation to make it clear where it should be used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - appraently reset can come from both cpu context and outside
  - add cpu_common_post_load fixes
---
 include/exec/exec-all.h   | 20 ++++++++++++++++----
 accel/tcg/cputlb.c        | 11 +++++++++++
 accel/tcg/tcg-accel-ops.c |  2 +-
 cpu-target.c              |  2 +-
 target/i386/machine.c     |  2 +-
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d9045c9ac4..cf030001ca 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
  *
- * Flush the entire TLB for the specified CPU. Most CPU architectures
- * allow the implementation to drop entries from the TLB at any time
- * so this is generally safe. If more selective flushing is required
- * use one of the other functions for efficiency.
+ * Flush the entire TLB for the specified current CPU.
+ *
+ * Most CPU architectures allow the implementation to drop entries
+ * from the TLB at any time so this is generally safe. If more
+ * selective flushing is required use one of the other functions for
+ * efficiency.
  */
 void tlb_flush(CPUState *cpu);
+/**
+ * tlb_flush_other_cpu:
+ * @cpu: CPU whose TLB should be flushed
+ *
+ * Flush the entire TLB for a specified CPU. For cross vCPU flushes
+ * you shuld be using a more selective function. This is really only
+ * used for flushing CPUs being reset from outside their current
+ * context.
+ */
+void tlb_flush_other_cpu(CPUState *cpu);
 /**
  * tlb_flush_all_cpus_synced:
  * @cpu: src CPU of the flush
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ad158050a1..fc16a576f0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -417,6 +417,17 @@ void tlb_flush(CPUState *cpu)
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }
 
+void tlb_flush_other_cpu(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        tlb_flush(cpu);
+    } else {
+        async_run_on_cpu(cpu,
+                         tlb_flush_by_mmuidx_async_work,
+                         RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
+    }
+}
+
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b..e85d317d34 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 {
     tcg_flush_jmp_cache(cpu);
 
-    tlb_flush(cpu);
+    tlb_flush_other_cpu(cpu);
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/cpu-target.c b/cpu-target.c
index 667688332c..8eb1633c02 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -56,7 +56,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
     cpu->interrupt_request &= ~0x01;
-    tlb_flush(cpu);
+    tlb_flush_other_cpu(cpu);
 
     /* loadvm has just updated the content of RAM, bypassing the
      * usual mechanisms that ensure we flush TBs for writes to
diff --git a/target/i386/machine.c b/target/i386/machine.c
index d9d4f25d1a..e66f46758a 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -401,7 +401,7 @@ static int cpu_post_load(void *opaque, int version_id)
         env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
         cpu_x86_update_dr7(env, dr7);
     }
-    tlb_flush(cs);
+    tlb_flush_other_cpu(cs);
     return 0;
 }
 
-- 
2.39.5


