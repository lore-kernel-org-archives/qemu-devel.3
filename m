Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADE7C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHcU-00046p-9b; Thu, 03 Jul 2025 06:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbw-0003uV-Lw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbu-0000mg-Ly
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so36025295e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540169; x=1752144969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=cbKfTsep17+0mzUAO8npzy/97ou9nyRdBEu/gnb0TOeWPXrRJKwvCtUkBKgT5tJhzX
 FyUG9Fvyko4Ap3VZT420tYjPqMxUDlrQ89VD5+pk8EfYSm9Ip13cJgpf+xsjkINTGRPG
 nnuS1XOS5BKkmt5V1ImjZiD0syspF1BvcLsqlAMu04xjNggVG7PVJ2YlVo7XIfUHE+Sm
 UgqiCka7tysbsafVHWw3hIVnNrS1BWJ9xQYrxwcChlE3j85J0uHRwxSgx6GxDxG2HZrI
 kLnbntf6212O1G3BSqQkoOM9ntdHqUpEqTRIzuVMrV7AS6BQatmf1WOg+XSiDQVSYNFX
 reNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540169; x=1752144969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=K2JLr3J768nkYhJV7Tiy/BhkABp/UQC+qrWXUKcpdQVhs5NYREWLYJ+UIa79P+S7mv
 bacTkOYmrjMIgCvt80d3ReyIVhd4bGkaG1OtrDZB/MmcAEGavMewcHBWSOME2HJj8fca
 lUviNi9g4/w8XMFiZj2EPAaLcr47QkAxbhaB+PsZbqyUVXcifrijXG5UxAH084IwBlug
 n/Y4ErVxuoWGyprM1hu5JJDqM0kB1WnFH479ltaOn1EV9VUjS/YXE25lFyu/mqm0dHWc
 Cz1XGUgRkvrjkmZ560+UwBFJonQgcCkiU30QknDobM84+KUu7G0VwH6goDYL7kHs4Y0g
 UTmw==
X-Gm-Message-State: AOJu0Yy3bByX62Qq9yufHxu/cNsas5uQTs7kUitue7lkhkQzjjjG5Z9u
 Taab7Bs6757bu7Fc1E79Z3LRRfrQ2sxTHmd5ip2RWFLkWwIkwhwgBJnIuFg73z7+tQ+RaBAVWZX
 I+O+y1n4=
X-Gm-Gg: ASbGnctREn6buUk4GadkRrIG2+WPOhUr4AXFzq3HYxGr9OvG3DEuvaE94WPdNCydfQd
 qr9a7DZsGnQvyDjg1WZe3NIZ6wMTmmS4RiW28AGQBl4teu2laqd51RLTl+W7rFdq9Dm5KqooVo/
 F+xIcUffXEhi+oDvTxX8bNGNTNLzmnkKNLfJ+ZcqwfjDCDwqpuqtjxm7020hhv47esZfaJJ5GjS
 xKnbnX5k+KYrwhVzxBrmuCd4cYASzZRi46dzU0haAxh/x2gWmTquDnsYlE+C3ckhbR5PJTZ2e1v
 2WhfABd586zSmxWSIMKRO4A0Pqta6zc/r7rbrI3Sv+PGIyaBpxqmCjH1iPNIBIya+igB7S5nTOw
 cZavR+/2rkT8Hxc478jWIqw==
X-Google-Smtp-Source: AGHT+IEC8dV01TEPNItTxkxi7fjNpsKqhBhsTECgtqMBuC3s0JlSf27AYqBUKou7E9aEBPF74FuvmQ==
X-Received: by 2002:a05:600c:c085:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-454a370cd01mr59147005e9.17.1751540168438; 
 Thu, 03 Jul 2025 03:56:08 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3016sm60231825e9.0.2025.07.03.03.56.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 05/69] accel: Keep reference to AccelOpsClass in AccelClass
Date: Thu,  3 Jul 2025 12:54:31 +0200
Message-ID: <20250703105540.67664-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Allow dereferencing AccelOpsClass outside of accel/accel-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/accel.h       | 3 +++
 include/system/accel-ops.h | 3 ++-
 accel/accel-common.c       | 1 +
 accel/accel-system.c       | 3 ++-
 accel/tcg/tcg-accel-ops.c  | 4 +++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index fbd3d897fef..9dea3145429 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,9 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    /* Cached by accel_init_ops_interfaces() when created */
+    AccelOpsClass *ops;
+
     int (*init_machine)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 4c99d25aeff..44b37592d02 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,6 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
+#include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
 
@@ -31,7 +32,7 @@ struct AccelOpsClass {
     /*< public >*/
 
     /* initialization function called when accel is chosen */
-    void (*ops_init)(AccelOpsClass *ops);
+    void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4894b98d64a..56d88940f92 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "system/accel-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a0f562ae9ff..64bc991b1ce 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -85,8 +85,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
      * non-NULL create_vcpu_thread operation.
      */
     ops = ACCEL_OPS_CLASS(oc);
+    ac->ops = ops;
     if (ops->ops_init) {
-        ops->ops_init(ops);
+        ops->ops_init(ac);
     }
     cpus_register_accel(ops);
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6116644d1c0..37b4b21f882 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -196,8 +196,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
-static void tcg_accel_ops_init(AccelOpsClass *ops)
+static void tcg_accel_ops_init(AccelClass *ac)
 {
+    AccelOpsClass *ops = ac->ops;
+
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.49.0


