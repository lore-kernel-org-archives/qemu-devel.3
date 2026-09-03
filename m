Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B22EC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLf-0002qN-Hj; Thu, 03 Sep 2026 00:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLd-0002pz-Vz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:50 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLc-0006W3-C0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc1d57602e8so2019853a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410807; x=1789015607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/fffGBqlaLkGfazVmKx0LxZ4r97UqWLeXOQpQGmiKtM=;
 b=OLBO1h/8XvjC3amDUQFtGV4ixxrj80onelHL1gl1b33MWstrwP5FLBFy2+QcHEFMp3
 WwTJUiEXa7A35ZrRQZFhJypQAtjwZ2oM135f/FxI3vjMNef+PqVi7tK5xKDYVIIDIeWR
 BfBWdnC7Q7bc2UrrhAmyMxZ9PRl3PyPGLgr7L4kKHK0CfPmAAuYvth+nSp5GAb1CFDqt
 XoHhrSClhKrfx9a/DhHXkjQy/D4iYx3qqM0/CahAHuTTIFWIS6kFuPp1lJDNawff1+oT
 2B4LKkAF6CJ+4G+VNtriiMJ3RiwddVhZeXp1m4MGdAnfUn6ShZYYorC4b1CZXeWW58nN
 wf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410807; x=1789015607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/fffGBqlaLkGfazVmKx0LxZ4r97UqWLeXOQpQGmiKtM=;
 b=gO3Hw6fZfmLmCBc23EnLH35BY0H4hZLpVVsUgYRu7pyUP5BPm/Jp4NUeeAzZb+QFXs
 VZLGseORJee9ra140Shgt9FwB61d8LYZNEI9fSqWQryU/12hzbvmgwhxRaNSh5QK7Ltc
 TTzGmx2eJkJ3u2u1fiWlALN/shgSMDX+axOqNEBow18hkYMzJ5dR9/m8vBwS+RedWTS8
 +2bmeINpXSpLLlXFm0TUVqBsksVuYy/W+yni01LwBSNOiKG5Ri4JVza78+aU0mRmOId+
 nJy5c3GKn4uV6ruVck6RsyesYnjlA4Ov6YZDrmkZ8WRQx6+FqlYGWIqpl1kkD+HA8yKw
 O3xw==
X-Gm-Message-State: AFuF++ncl03uvPaF94j0kSDLM2XiS7wpoyUixZU2YyviZnoU/ZBvQTVY
 TclywLJObCtaUDCC+Q6ThmFViu4/qrtnAu3zFGq+fA8w4rxLRzj++ysMyYuUHfAl
X-Gm-Gg: AYBFou1yV1XzPL/RY2ntNlPFClB3ZnD0OOA1zfP9jNLIH/nWR4Pzl++Y+KyrI3hPPi9
 OnqiQSKQQGOzpDMivZ2Yd/QQ6o/C34HBBGV0QohAuvUAz+31vZYev60+NZizMfriHYcqsucgeCO
 9wLpYj8NsO62/NMhWj/DVd03CrCFYgyLaQzt5G6FxF4UMZ6RV0Gvlo+sEmmz1tcFZ/D3W4HhS+I
 mwifjDSsAqS3xx8YqxYa6BYjqRATT8irqQl4xndKXFp+i6bkrX3IphyfG8k29kFuH9hrqJMWAAc
 GXnc8TrIHsM5ZWDwy/leaMK4WsMFh7ieY5Ddo0TWILztd5CaG6zjkw1L1oKKQJD7IdOKbIQt6AM
 3LB2NmzQj/XRfQynGYraE6ZpDttQr0adx3Yoo02Kes5IiTC7detwmNVgM6Bqcoa+sXCtQUc/XBn
 jMcI5+VSgPku5CQOFPk/9ngxfkp5MpovpUaQvZjtUtJOa62c96tYCZfhdqyL1AJ5sRmqQemgTgE
 myR0OPhwISD510jbw==
X-Received: by 2002:a17:90b:1811:b0:398:c724:1bb1 with SMTP id
 98e67ed59e1d1-39aedee9313mr14088699a91.8.1788410806880; 
 Wed, 02 Sep 2026 21:46:46 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:46 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 3/6] target/m68k: Fix NMI pending for Level 7 interrupts
Date: Wed,  2 Sep 2026 21:45:16 -0700
Message-ID: <20260903044626.24453-4-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
References: <20260903044626.24453-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x52a.google.com
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

Why this change is made & How it will be used:
Level 7 interrupts are Non-Maskable Interrupts (NMI) on the M68k architecture. The hardware asserts an NMI only on the rising edge of the level 7 signal. The current QEMU implementation treats level 7 like a standard level interrupt. This patch ensures proper NMI edge-triggered semantics for level 7, which is strictly required by the Sun-3 keyboard/mouse NMI routing logic.

Impact on existing functionality:
Corrects NMI edge-triggering for all M68k boards, adhering closely to the Motorola specifications. Existing boards will now correctly require an edge transition to trigger consecutive NMIs.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/cpu.h       |  4 ++++
 target/m68k/helper.c    |  6 ++++++
 target/m68k/op_helper.c | 14 ++++++--------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108..8f4dec4a40 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -25,6 +25,9 @@
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
+#include "exec/cpu-defs.h"
+
+#define CPU_INTERRUPT_NMI CPU_INTERRUPT_TGT_EXT_1
 
 #define OS_BYTE     0
 #define OS_WORD     1
@@ -148,6 +151,7 @@ typedef struct CPUArchState {
 
     int pending_vector;
     int pending_level;
+    bool nmi_pending;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 68f523ea84..93739ccda7 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -949,6 +949,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
     CPUState *cs = CPU(cpu);
     CPUM68KState *env = &cpu->env;
 
+    if (level == 7 && env->pending_level != 7) {
+        env->nmi_pending = true;
+    } else if (level != 7) {
+        env->nmi_pending = false;
+    }
+
     env->pending_level = level;
     env->pending_vector = vector;
     if (level) {
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a68981..30af4a2631 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -522,14 +522,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUM68KState *env = cpu_env(cs);
 
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
-        /*
-         * Real hardware gets the interrupt vector via an IACK cycle
-         * at this point.  Current emulated hardware doesn't rely on
-         * this, so we provide/save the vector when the interrupt is
-         * first signalled.
-         */
+    if (env->nmi_pending) {
+        env->nmi_pending = false;
+        cs->exception_index = env->pending_vector;
+        do_interrupt_m68k_hardirq(env);
+        return true;
+    } else if (((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
         cs->exception_index = env->pending_vector;
         do_interrupt_m68k_hardirq(env);
         return true;
-- 
2.50.1 (Apple Git-155)


