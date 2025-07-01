Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E187C8303B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcD0-0002TB-Cw; Tue, 01 Jul 2025 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCS-0001Xb-C3
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCM-000735-Jm
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so38356915e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380977; x=1751985777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgP4tqYRygNF/qbfEH0O4ZbQcscHGETVIN7Hvn8iOoA=;
 b=xZ6mB6/O9wURv4AaqwfZlidY8vWllO+rwehEqIAGAXwOZnZuYtLr3US9hTRLnhrmnw
 /yw08lJnLiPQx+ZUgKHoz7iylkyi2ir4U16fMDuLTfmjHMMPutmRD5W+NpLDMRIOwUSX
 Ly9c2jqWDvSKWI1+/I55zhWbHOayH38f+cLpdQN6bz0jLsSVv8WkTc4qk6i6QEicyxdn
 y/kfc6grJIMfiSD4P/HSOUzOdsi0K+hEtZYLquqzrGdfn+rrt5+Qt24YdJcBqKH8OOS9
 U+ffi0I+brmgBLJFLe7kZy5qp2rDFn/bqpnhyUg5iM7ZOz3aaOO3aYI9uQIQY7jy2gEi
 f8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380977; x=1751985777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgP4tqYRygNF/qbfEH0O4ZbQcscHGETVIN7Hvn8iOoA=;
 b=Id2QlSPOGcZhxSqIair1wd5+53yhyiCxjPqlGslLz52XADIjehf1pQ+PskkRyotEnR
 PYRNUq7r9oGtUrunlg4agsAUdvIONIUQLyBuVmkZbUFhi6Mkuwfef5LcwpRPzrdGjAoW
 ZNulgzzF1/u8rpKgbYegCpVzLnIWmyAe5InL8ieuRJ845gDljDg7Q7xsxyyraizxexnG
 fNGfCnB8aLT0pU25/mpx6NmfrwjRgX5ki9JMQHw8QX3hfmVkRcdOWThJ/UWdRznMowHG
 xYJats5yS+h6AXgosgSHt74siVwomNA8myG+yFevOfaVXireoC9It0BED1Aqae31H+A6
 DnPw==
X-Gm-Message-State: AOJu0YzS1NpmA4Kms7gjmkCGHfNBrvIppEszI64dJ2/rKktr6ykrhyaV
 ZybIz4jwEnF/S9C6kR6awUPm5S/md2bW2u/r9Fd9PgKKaz4niKIvVhuDZEZdXDX4ZyG2p1RjGw3
 XsPrz
X-Gm-Gg: ASbGncv0jnZR9RRm57hclyCl1eskPCYxLe1otJ0dTYlYaaXZ7lERp/iKDhwAaKjnw+I
 QAIx5G9V7WoUUuU9pnkQjwJsj0AqlpZHCHeA+2VUoRBgJfn4coKXwLk2XBe9+wRGxFZLSewYG+s
 JuqCJXbU6FvwaHHjlnaG/GKJDZXDv4beIvUgTsydD3Fypgoat791EGtHvo3Ml6U/s5f2OmBcblW
 8ANZNA4esnKslh8DodnHYBpZsH9a0O1G7HO61u3iZhuxSkM+j0EJw6QrZ3of87XJPawLbXt3vPS
 gbEOQpgam+7DJ++u1zE8rrGFPin4ig67v3h3FJwzoRMZp9yVpbgEDxBNPBAOQJaUpfLMRkg3aYT
 I17N0H5vS4VjJuSIQb1WfmaFoHGOAPIfLKdT3
X-Google-Smtp-Source: AGHT+IGxmZ48PnEKW2Iuf076bEtlA53LyyCQeT3muqYLsz0zHXzQ/Te10GCglQQeN3XH89NhWjxE+A==
X-Received: by 2002:a5d:5f8b:0:b0:3a5:8cc2:dabc with SMTP id
 ffacd0b85a97d-3a8fda359d7mr16627589f8f.5.1751380976861; 
 Tue, 01 Jul 2025 07:42:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa8fasm13377364f8f.28.2025.07.01.07.42.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 29/68] accel/hvf: Restrict internal declarations
Date: Tue,  1 Jul 2025 16:39:37 +0200
Message-ID: <20250701144017.43487-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Common code only needs to know whether HVF is enabled and
the QOM type. Move the rest to "hvf_int.h", removing the
need for COMPILING_PER_TARGET #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf.h     | 41 ----------------------------------------
 include/system/hvf_int.h | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 7b9384d816c..d3dcf088b3f 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -14,10 +14,6 @@
 #define HVF_H
 
 #include "qemu/accel.h"
-#include "qemu/queue.h"
-#include "exec/vaddr.h"
-#include "qom/object.h"
-#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_HVF
@@ -40,41 +36,4 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
-#ifdef COMPILING_PER_TARGET
-struct hvf_sw_breakpoint {
-    vaddr pc;
-    vaddr saved_insn;
-    int use_count;
-    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
-};
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
-                                                 vaddr pc);
-int hvf_sw_breakpoints_active(CPUState *cpu);
-
-int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
-void hvf_arch_remove_all_hw_breakpoints(void);
-
-/*
- * hvf_update_guest_debug:
- * @cs: CPUState for the CPU to update
- *
- * Update guest to enable or disable debugging. Per-arch specifics will be
- * handled by calling down to hvf_arch_update_guest_debug.
- */
-int hvf_update_guest_debug(CPUState *cpu);
-void hvf_arch_update_guest_debug(CPUState *cpu);
-
-/*
- * Return whether the guest supports debugging.
- */
-bool hvf_arch_supports_guest_debug(AccelState *as);
-
-bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
-
-#endif /* COMPILING_PER_TARGET */
-
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d774e58df91..ea6730f255d 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -12,6 +12,8 @@
 #define HVF_INT_H
 
 #include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "qom/object.h"
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
@@ -77,4 +79,38 @@ int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+struct hvf_sw_breakpoint {
+    vaddr pc;
+    vaddr saved_insn;
+    int use_count;
+    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
+};
+
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
+                                                 vaddr pc);
+int hvf_sw_breakpoints_active(CPUState *cpu);
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
+void hvf_arch_remove_all_hw_breakpoints(void);
+
+/*
+ * hvf_update_guest_debug:
+ * @cs: CPUState for the CPU to update
+ *
+ * Update guest to enable or disable debugging. Per-arch specifics will be
+ * handled by calling down to hvf_arch_update_guest_debug.
+ */
+int hvf_update_guest_debug(CPUState *cpu);
+void hvf_arch_update_guest_debug(CPUState *cpu);
+
+/*
+ * Return whether the guest supports debugging.
+ */
+bool hvf_arch_supports_guest_debug(AccelState *as);
+
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
-- 
2.49.0


