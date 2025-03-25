Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07467C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0a-0002ml-4Q; Tue, 25 Mar 2025 18:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0H-0001WR-1c
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0E-00073P-DL
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so54962655ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942649; x=1743547449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NysG+klqlTH+Cqa+DgVibFr5yz9FYb8KE+rqeZdAsXI=;
 b=xXd+J4u0wAnLpQTlhReTB0DFbDDZsVBJ5ZEkhf+wUbVSzKcR7VhrMr9rnomow17lAF
 7+M2tlLZp/07FtqXYk0xVFaQ3S+tfuGLWZEBltESmgU69EbNgWJ68lv/ooJORPSMLDiX
 t9qeTQQRcv9ComCT/JMm7aScY44W/WhB4u2qV1g6lwlQk4V1qc+PPPNZ/BC256VLOzMP
 P8sqRlZag77eVprQIm6BL00yVJewZWXdckuagca4cqwiXRFMPsKWt9Woobts8/XKpciC
 mfnYBfCUq06Mg1b3r13o6PtH/S3ARsSGJcCJzBGzeCD3bTsQsVOzP2IiLu2gwZdgWRV8
 Sjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942649; x=1743547449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NysG+klqlTH+Cqa+DgVibFr5yz9FYb8KE+rqeZdAsXI=;
 b=ifU2H3HX/P15rSbtMiaCKY/n1dfGeRFNcBRmxJcAcJVrqsgCRhJ3erH6oahhN0k1S8
 0TzmjTLXZOWPbd6tbuwNYEPLqlpOfVub2tcMJL9/PZrYPT1hEsUFOVeasqzd/XpaO8YU
 SBYmm2Yj1IxO7+CGBNxfxz1U7VOgRF+5gxQeu5Ty2H0/iNtAJEBhLEij15oPekbv1zUJ
 45qmXzdz8tpTrFy2usMIQeyK1mb/QixZQFRk1wZlnCFe/04lhneAscBV3E2shibJTGQm
 1D56aW/DBdaSocA7vcLuNPCDfUF0m9Bh1Nup7qRCEOtF4Tou5OilnpYO1oXvfpx8Ng/2
 fxfA==
X-Gm-Message-State: AOJu0YyJPmGvfvRizSBUFJ5vAVRPYIcMEZHOkAdAm2C5IF2iqsCfx/lA
 Ufrwst8+OF1AhhjWmRChgH9lPzYbg5w6ytXk6nN+TeqMnzRUTr5JHlkL53xrY+SNtL2EKdwBNkj
 X
X-Gm-Gg: ASbGnctuQXQm5cJdebh4ZoF5IsQqD8VhLft/g+l0pb1eC4Gvsjy2gw2ue0RUH3no42e
 5PSpsLHP+TqA+wQooY4zjjQdG5UYDJx2kelW3wBKDaSN9yyG64TLfCXmnrs7rQD8T0OS2Iktq+3
 Jh1iFRwiFV1x7D+CHqrmnNAfpql9oDVBa0BHR8E2GhItgnl9R/y4VvlitUkD2T1yCgHzzmrXa6u
 Yv3t2ue7WNX1P+cocW/8joi2Jpatoiog+pSCzn+mIn44QNODa2kCM4o3pld2GKiRKXOl37P8Xpy
 Fc15YbUJxufrRwHe3S/adiNBFz2HOQWnHo49VcwOM7VvHvC+TD1Y/Y7sPqoXbZ3OVjet9gh7tcC
 g
X-Google-Smtp-Source: AGHT+IEZ6cu7oXzjvNlHCM4jz5Ez5N8kIDllVgrKO1EMwgmRJ0X9Y8IwI7+SbpaC9eWf1Xa8i5qsZw==
X-Received: by 2002:a17:903:32c8:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22780e14a50mr322363575ad.34.1742942649052; 
 Tue, 25 Mar 2025 15:44:09 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 06/11] target/avr: Add defines for i/o port registers
Date: Tue, 25 Mar 2025 15:43:58 -0700
Message-ID: <20250325224403.4011975-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h    | 10 ++++++++++
 target/avr/helper.c | 36 ++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index b49e7a7056..ebcdda20ac 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -45,6 +45,16 @@
 /* Number of CPU registers */
 #define NUMBER_OF_CPU_REGISTERS 32
 
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


