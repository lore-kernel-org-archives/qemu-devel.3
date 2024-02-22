Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA8AC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvX-00085X-Bp; Thu, 22 Feb 2024 15:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvV-00081v-Uk
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:17 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvU-0002nJ-74
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:17 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so735305ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634655; x=1709239455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udP+pGil6gAHeo/JHSsvoaPGgz4MOYyC4J6GT3yPeXc=;
 b=L35Wv8i/oAv4rLRX/wwXGQupBb2keeJ7y0nozbetbqxu/OqL2PmZQuGhTFJTmC8g69
 8eGmDRQWolb9Q+g5o1SQiugFKkjOHsbMmZZFzNvKuoXSIclYMATmhbfW470jJ1RFqn8l
 9FSaOe0uAogfLHSmzUrt+YDV5Y6L13GS8f5We7wQRVvuSqfOgcMN0TUJ8tY91VF54u79
 UwOjLbCyqass88YLN1S49x3S/90yRxDzxDFlnhSL+p2lxqTxV+oV1DPAinwxC200g5hy
 ajn/9e0jnYujrc/4/V3cqao8JBNHWU61Xl37JhYfC9qAXwpFhjV5GgENOEO9W5NBsLjv
 Hnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634655; x=1709239455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udP+pGil6gAHeo/JHSsvoaPGgz4MOYyC4J6GT3yPeXc=;
 b=HcLhG26E2OIoR1s/dnrfXS0Bpxo2Z0unDGjGmd49KNtzu92QGhm0zLOOA1679rgBvh
 9zi6DaCGObo1WazZt6+VdplVgg9PS1tWTd4Vnn5GE7uElajBFx5DOApW+KffyAj4Rjen
 NCssTC+iV1zM+68fqOfw8H1+KGOl/y7/o+gfwFgZdL0KG7v1mcDfKmWByPVYRs/oHf42
 E+sGLM9YnpqoPOomwsywnnm4X6iZgyn4DDX8xsFX3RKVH4SVGu3chQDHwkSmRHzaCjeZ
 eSKxTJYiCpx6HZAhOe4PBIR1BoRXioNywvkA8IAbLy91bRyfL2+viy9ewI+wilrfvvm/
 0bPw==
X-Gm-Message-State: AOJu0YwB89Xb9XP28tLOFvw0t1ONNw0b9LuzXJYYBOWtTGATX5oEN7TU
 08zo3Ab92597foXl4AYEvqUKVDvHmK4SVzDz5wo9sfHuB7t/TnSzsQBRcmpk7puBXT5Tu0H+tKm
 K
X-Google-Smtp-Source: AGHT+IHmRldTC2Oj1M+mEVc2bPTfcjkS1elRciYvXqFJwyVQ53+rYoa+Y2PpqeDUwSY3raIPCecSsw==
X-Received: by 2002:a17:902:6f08:b0:1db:8555:55b1 with SMTP id
 w8-20020a1709026f0800b001db855555b1mr16310209plk.37.1708634654987; 
 Thu, 22 Feb 2024 12:44:14 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 32/39] cpu: Remove page_size_init
Date: Thu, 22 Feb 2024 10:43:16 -1000
Message-Id: <20240222204323.268539-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
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

Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
It should be removed from bsd-user as well, but defer that cleanup.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-28-richard.henderson@linaro.org>
---
 bsd-user/qemu.h           |  7 +++++++
 include/exec/cpu-common.h |  7 -------
 include/hw/core/cpu.h     |  2 --
 accel/tcg/translate-all.c |  1 -
 bsd-user/main.c           | 12 ++++++++++++
 cpu-target.c              | 13 -------------
 system/vl.c               |  1 -
 7 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dc842fffa7..c05c512767 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -39,6 +39,13 @@ extern char **environ;
 #include "qemu/clang-tsa.h"
 
 #include "qemu-os.h"
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+extern uintptr_t qemu_host_page_size;
+extern intptr_t qemu_host_page_mask;
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+
 /*
  * This struct is used to hold certain information about the image.  Basically,
  * it replicates in user space what would be certain task_struct fields in the
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9ead1be100..6346df17ce 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -20,13 +20,6 @@
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
-/* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
- * when intptr_t is 32-bit and we are aligning a long long.
- */
-extern uintptr_t qemu_host_page_size;
-extern intptr_t qemu_host_page_mask;
-
-#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4385ce54c9..5c2d55f6d2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1179,8 +1179,6 @@ bool target_words_bigendian(void);
 
 const char *target_name(void);
 
-void page_size_init(void);
-
 #ifdef NEED_CPU_H
 
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1c695efe02..c1f57e894a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -256,7 +256,6 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 
 void page_init(void)
 {
-    page_size_init();
     page_table_config_init();
 }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 521b58b880..4d6ce59af4 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -49,6 +49,13 @@
 #include "host-os.h"
 #include "target_arch_cpu.h"
 
+
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+uintptr_t qemu_host_page_size;
+intptr_t qemu_host_page_mask;
+
 static bool opt_one_insn_per_tb;
 uintptr_t guest_base;
 bool have_guest_base;
@@ -307,6 +314,9 @@ int main(int argc, char **argv)
         (void) envlist_setenv(envlist, *wrk);
     }
 
+    qemu_host_page_size = getpagesize();
+    qemu_host_page_size = MAX(qemu_host_page_size, TARGET_PAGE_SIZE);
+
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
@@ -403,6 +413,8 @@ int main(int argc, char **argv)
         }
     }
 
+    qemu_host_page_mask = -qemu_host_page_size;
+
     /* init debug */
     {
         int mask = 0;
diff --git a/cpu-target.c b/cpu-target.c
index 86444cc2c6..8763da51ee 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -474,16 +474,3 @@ const char *target_name(void)
 {
     return TARGET_NAME;
 }
-
-void page_size_init(void)
-{
-    /* NOTE: we can always suppose that qemu_host_page_size >=
-       TARGET_PAGE_SIZE */
-    if (qemu_host_page_size == 0) {
-        qemu_host_page_size = qemu_real_host_page_size();
-    }
-    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
-        qemu_host_page_size = TARGET_PAGE_SIZE;
-    }
-    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
-}
diff --git a/system/vl.c b/system/vl.c
index b8469d9965..7913cc28aa 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2118,7 +2118,6 @@ static void qemu_create_machine(QDict *qdict)
     }
 
     cpu_exec_init_all();
-    page_size_init();
 
     if (machine_class->hw_version) {
         qemu_set_hw_version(machine_class->hw_version);
-- 
2.34.1


