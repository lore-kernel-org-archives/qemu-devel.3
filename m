Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF1C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eD-0000Hv-BI; Wed, 02 Jul 2025 14:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dt-0007nI-JJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dp-0002ax-Cq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453647147c6so77149285e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482626; x=1752087426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IUtIm3JHDSf2CDlC9ODm0iBh8kfs+CSjmgEqHJOxOs=;
 b=p/RdAU9bDpTbfwZshgJSQqiU6Ba40/Jf41VwsrOkPf9EtbGamIPuc/rpGDrmx3m65n
 S/QfaqLgQyar+/YiSKAPsi/1xTlKcv2/Ge2CKNHfp9MWbC53siknI5Qc6nj09dnwPfi3
 2L8B8rd3843pSnOzoMFno4I87hfhTF+Am0pkPyRgqtLCZJJYT+NZglNtH6btDA7YnTwM
 o1THu6KI6puZJpKzG2hq4dr6RZ+bGmbBOqgAW0pOSv7hRv3SeR0U7ydi0SagPDDbVTKW
 lW2YyU9g2YT+ETuUWauFZ94FcewMTr2CEvuXJ9rU9DYMKXjAaVfJsYe+idd3S3DpWglt
 hKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482626; x=1752087426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IUtIm3JHDSf2CDlC9ODm0iBh8kfs+CSjmgEqHJOxOs=;
 b=MTEQHSmjaO3J5TFZSp1YiD8MEcOjJDlBiPCA9jzXm0CBhzPOqDkXiAxtNW8Keo2S9n
 /LZxupFIPXjpRlALakExLLDceNAEe6RpSO3dhoLPx8bXP6VY8CM7EK6akikaI7bZG32q
 BekJX5jDqxDG7oODZLSE9Xo1Oo8GikvIeDS6u6PGA91a882ZQfeysu06dUCJZYGlWTvJ
 DF0IRc8taGRmW/Mms0OPhgvbB4dDfQFKZHxveKVTuQ7hszu+clSvU6L1llO01rP6jucL
 RakxHWaTFpJZXWX/nYgLc3n7xafls5jJccw6IS91epmqiGq06FEdGW0O+eJLeM5Alv/2
 0ang==
X-Gm-Message-State: AOJu0YwDW16VuXY4z49zI5ylB+16yBY6liR/WR3hDZXoFzJRGBiPRXm3
 fXPwhd+TIIuIC1ko4cCtSl5SIJdlgtRK9UXYihx/699FlDuhUIcsYJRIq0ZQ9gN3p5wF7IO7fDl
 4giQ2
X-Gm-Gg: ASbGncsB0LB3xSZbf3sYGcChoSvs49tPHaDIEVwrdnE9MAYxrWl6KT2Uu/Jx38xpone
 eB7X3EShm5wvnplli7KUurZxG8ZFW0aXBch1kO0gjlbNWqt+yQ/Ja6CaYstYOZqj0OLV1IJdQB2
 4CqpZ41TepDGKB6YuFEjNXD4Fl54315iUof7eAgwNAb1B1kZPeIBdJamrRc9cw0AvOIshdzmShx
 X4RhLF0OuVZuKWzzykFMg/ij1nvsmHyuQg1QllSIfeGMtYafeZvrBP4PyT883WsdbpJgzMXg3z9
 +/fMFBdUZVRsjGiSOQjAahKCRad9OEPaInew9PsXy5RmHfajIFReH+Bqf8bfgyUlgENSwuGJWzn
 F3uYRxYZ5VffNJAB+4rteaMh0dzF6Heys3jMv
X-Google-Smtp-Source: AGHT+IF1pBx8Sq1c4tIPVUXwwJioxbo9zGN6BBQxB4kZYVTiwt8E04DGe2Gq1HOdTb+HoEHQsj89QQ==
X-Received: by 2002:a05:6000:41e2:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3b1fd74c600mr3265581f8f.2.1751482625677; 
 Wed, 02 Jul 2025 11:57:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c99sm16507201f8f.49.2025.07.02.11.57.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 29/65] accel/hvf: Restrict internal declarations
Date: Wed,  2 Jul 2025 20:52:51 +0200
Message-ID: <20250702185332.43650-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


