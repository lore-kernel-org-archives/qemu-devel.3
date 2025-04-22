Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317E6C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KuB-0001Fp-OC; Tue, 22 Apr 2025 17:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktv-0000zq-OH
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktt-0000Pa-Ai
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73972a54919so5826919b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356287; x=1745961087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7HP2zbvSkDBMLOLYhU6UsrfPqpzWt02XJu5z93nvtA=;
 b=YiptxcolcNLjXHEn5zPW4kXMZdQGjrwwfVzwyAvxwM4NpxhFf5EsaUzJ9aV+IprEPB
 F3U/rVBO8ELFQ6ikQ/NfBo8j9UFQ/1mUU/CIzmGV4rydEVnqGxh+fVIApJDZOP42Ftce
 UAdszVR15dTWdY+T0BA+540pd0PGQSAovtwFVB+y4dGHksZVT23ibfjjOAodTtp0l18h
 mPk/aCwF5y8i9NYLV8A+bsNPP4zPa6OQ2TyX5Qmj0zZc8a6wVm9n6kDPgO//FBnnvuC8
 vMfqxo6RZbajV2Pe05Ilyb7fi1GOm5bezpeQxnUhOyZ1D21rJgV+fTepQeAeDquDJZl0
 XpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356287; x=1745961087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7HP2zbvSkDBMLOLYhU6UsrfPqpzWt02XJu5z93nvtA=;
 b=obyeDVHbA+7g5WKfV7Ja0nAF7uHHGx6PWD4JM9eOzarXnXy9fYFA/9o+ei7WK24zCJ
 4jx81rTuZD+LKDSIgnqAClAwsBSRtI1C3xsfbFCEBDrO+P4wnWBY0fxKWHbbXaj26mE+
 EYSc/xBQhlfkyI5Wxu/QsCQqy+Ua8B2yXgPEOhr14u4nAuLvhR7qf2/IVaKEavH5hjG6
 3rn4jo9OaDsqfGwRO2r30tMEpF5X/wo8KSACB1oHDdWuY4z32A50fw2y4qvSCtPGhbqo
 Squ/gmefYFyrVqBMIlQbrcoM2ad0jzVuCkRMISd6iFfDejKTcGa0hJEX0Y03CA+jXd9D
 NfBw==
X-Gm-Message-State: AOJu0Yx3+z4swrAM4Gel09aSWg/BfE3AIj7baHyaKVes5LzdmxA5Q/vP
 v/v+ZOPGPhoVb1CkgmAyhQaWCagh7sr/NUmw3cTFsFpt9HUJYWfRonUKmT2yDUt1nYQWTP9KHkL
 T
X-Gm-Gg: ASbGnctWEByqF7oKxHWUQvr3irta0mM/ez6IzR/5JdLGCmvM/SNbC26nC0hAmiSUl+I
 qeqHp8KQ1D0FPdmICeOkQFPeqIOi+E4ZMiWih7XJYr+/5loaf0YcqxqOc76jtTrQfxNugqgpC4g
 pWH1yvy+ymT1s1YawXsjEhRiPvAZaNR1jlSY55CXJRSeHwgdK/N/XYzsV6wGPcVtK4I6i37SbsG
 vosos1x7tlKRlEUy7k9AODAFjKHmITB+0g7zPm+hdB5jdIkvAe9IFEuuamOdgaFK0K70GQCwpm8
 azVem/L0EG2+gH5JtNIvfHjAtynsHUnrikgqFKKNYEV3VjKYamcL51UZFienGnf4S2v5Y4d0S5u
 xYSmoJji3SQ==
X-Google-Smtp-Source: AGHT+IEpKto+ilQH6+kmnGmOFneZIa997sFFNVLLD9YX5q8JXNqBlv8w45aNKLYoACHSZ/QsSIg+sw==
X-Received: by 2002:a05:6a00:3d02:b0:736:4e0a:7e82 with SMTP id
 d2e1a72fcca58-73dc1480119mr19917517b3a.10.1745356287433; 
 Tue, 22 Apr 2025 14:11:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 3/9] target/avr: Add defines for i/o port registers
Date: Tue, 22 Apr 2025 14:11:18 -0700
Message-ID: <20250422211124.305724-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h    | 10 ++++++++++
 target/avr/helper.c | 36 ++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 84a8f5cc8c..1a5a5b8e3e 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -47,6 +47,16 @@
 /* Number of IO registers accessible by ld/st/in/out */
 #define NUMBER_OF_IO_REGISTERS 64
 
+/* CPU registers mapped into i/o ports 0x38-0x3f. */
+#define REG_38_RAMPD  0
+#define REG_38_RAMPX  1
+#define REG_38_RAMPY  2
+#define REG_38_RAMPZ  3
+#define REG_38_EIDN   4
+#define REG_38_SPL    5
+#define REG_38_SPH    6
+#define REG_38_SREG   7
+
 /*
  * Offsets of AVR memory regions in host memory space.
  *
diff --git a/target/avr/helper.c b/target/avr/helper.c
index e5bf16c6b7..f8ada8b106 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -216,29 +216,29 @@ target_ulong helper_inb(CPUAVRState *env, uint32_t port)
 {
     target_ulong data = 0;
 
-    switch (port) {
-    case 0x38: /* RAMPD */
+    switch (port - 0x38) {
+    case REG_38_RAMPD:
         data = 0xff & (env->rampD >> 16);
         break;
-    case 0x39: /* RAMPX */
+    case REG_38_RAMPX:
         data = 0xff & (env->rampX >> 16);
         break;
-    case 0x3a: /* RAMPY */
+    case REG_38_RAMPY:
         data = 0xff & (env->rampY >> 16);
         break;
-    case 0x3b: /* RAMPZ */
+    case REG_38_RAMPZ:
         data = 0xff & (env->rampZ >> 16);
         break;
-    case 0x3c: /* EIND */
+    case REG_38_EIDN:
         data = 0xff & (env->eind >> 16);
         break;
-    case 0x3d: /* SPL */
+    case REG_38_SPL:
         data = env->sp & 0x00ff;
         break;
-    case 0x3e: /* SPH */
+    case REG_38_SPH:
         data = env->sp >> 8;
         break;
-    case 0x3f: /* SREG */
+    case REG_38_SREG:
         data = cpu_get_sreg(env);
         break;
     default:
@@ -265,39 +265,39 @@ void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
 {
     data &= 0x000000ff;
 
-    switch (port) {
-    case 0x38: /* RAMPD */
+    switch (port - 0x38) {
+    case REG_38_RAMPD:
         if (avr_feature(env, AVR_FEATURE_RAMPD)) {
             env->rampD = (data & 0xff) << 16;
         }
         break;
-    case 0x39: /* RAMPX */
+    case REG_38_RAMPX:
         if (avr_feature(env, AVR_FEATURE_RAMPX)) {
             env->rampX = (data & 0xff) << 16;
         }
         break;
-    case 0x3a: /* RAMPY */
+    case REG_38_RAMPY:
         if (avr_feature(env, AVR_FEATURE_RAMPY)) {
             env->rampY = (data & 0xff) << 16;
         }
         break;
-    case 0x3b: /* RAMPZ */
+    case REG_38_RAMPZ:
         if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
             env->rampZ = (data & 0xff) << 16;
         }
         break;
-    case 0x3c: /* EIDN */
+    case REG_38_EIDN:
         env->eind = (data & 0xff) << 16;
         break;
-    case 0x3d: /* SPL */
+    case REG_38_SPL:
         env->sp = (env->sp & 0xff00) | (data);
         break;
-    case 0x3e: /* SPH */
+    case REG_38_SPH:
         if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
             env->sp = (env->sp & 0x00ff) | (data << 8);
         }
         break;
-    case 0x3f: /* SREG */
+    case REG_38_SREG:
         cpu_set_sreg(env, data);
         break;
     default:
-- 
2.43.0


