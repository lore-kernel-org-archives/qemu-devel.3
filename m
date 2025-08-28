Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AE8CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHX-0005IS-JX; Thu, 28 Aug 2025 13:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVe-0007ck-UY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVa-0008Ce-Jt
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24457fe9704so8977535ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383216; x=1756988016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETzMoCsYZvdXntMHdD7opuNC2i41ysldzXxK0olCZs0=;
 b=CoG3+ayPjkXd5MYVBO9Fakk3ARZrlwU9Zbs49P9VUZHAIl5iCpifsD+UiQL5uoc9J3
 4WhRUpT6FTwurODdEBATYaUBRZfTZ0Z9L/vQTGQtVbnnMqBWQWryTnN6NLvnMgcgYAAk
 Xe2xijjh1kx4/EXzUJxDIG58V0aKCABnI4gTUjSgkneSXBjLjbkOvXrP7VbkuWJnvmgH
 FFzlxAMqJT+A8a6C+tTGPGs/KC37ghhVqY3Dq/4toGal4/jcvDcmdIQINL59RQlUvBXP
 9RNAYnaT4DJaBYX8rTKh0r1jjxAVQmj+jjexXmPBBXrA974y487j2Y1kFwH6aii0G4F2
 FTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383216; x=1756988016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETzMoCsYZvdXntMHdD7opuNC2i41ysldzXxK0olCZs0=;
 b=VDmDoJhq2WD8NEA0nIlhZ5UuGGYPWEUI6NZQwSn8F2gI1qvdtmgiUnnd3ByTSozuer
 9VLcEeLHj6nlBPnODGvaD2YGpQOBvITEQAoqSWnWJTp0/YUOcELa3hxmEbvkihDzzmY8
 jFSTANQnD2rbpwZnma19NmuHWi+hA7uYgoYeK6yByjn9ilMrsNhPmlZxBQ6MPUcIljBO
 8JMrL+IcCj9GK9OwXF8ja68MknbtNka5SSg2e0khtPNsTCqSHcEOk4CcT6c5rfKhEoFY
 olKQw8WtreiYnjZ4gL7FMgcbjkg3x8h9CA+rtMgLVr3PoaE3sxeuzsMizMCooJG8mYV2
 s8wg==
X-Gm-Message-State: AOJu0YzAq0Z98614w8tTotOhYuJOxvyVHCC81841c2Y5HxMLUeI7wZGl
 6X0EOfWKc/teE982yMrattD2o7TIa9gQORtNJ2cqR3qXnrZjYRLOsbpN2VU3RYcZjJ7DEtr1SKx
 /nBToF8c=
X-Gm-Gg: ASbGncuoCTL3hxgnqhDHLfsNlBDvt6lY64LSxCzuaN1Mgiu7s3y5TxXBtK9JkISC8N/
 VFLJKZR6XIH7715Qf2lUuX9LdDb3touJfcUAII2gSIYBsYrvMLGJD7CCJy3r0/dC0nx3HOJZ0ou
 YPQEgFBEH/f4HuYTS+livvmGW+zvcce9rJ+LP8wie0+Vo+8DvwySvHp0bZ3T8MdMcARvWGCeC8S
 p6F09e0l8Dk8V3nhHFzjgZVp2SycZkwUClZxAUDXhtqDzhCKZZQmulMtaVTb83kSlwMRIQEEyq3
 bZDZJNy6AGaZfN8XhDMh1i4/iV5kZ4anA1k1U/4QaAPKNzDGNWqwuQ557hx5P1dEMdGyAigokYS
 Jsz83qnqpFEzsJGAqkezD2Ja6wtQ4pKy9Y6kN
X-Google-Smtp-Source: AGHT+IHJUrmlpyUB+23RX5aXQa6H6ZdV38fDNjJyCKaIpiDTKJezIUWaco3MdpbFJLaYmBruDE4S0Q==
X-Received: by 2002:a17:903:124c:b0:240:84b:a11a with SMTP id
 d9443c01a7336-2462ee2bc6fmr296999095ad.17.1756383216387; 
 Thu, 28 Aug 2025 05:13:36 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 43/87] linux-user/microblaze: Fold target_pt_regs.r* to an
 array
Date: Thu, 28 Aug 2025 22:07:52 +1000
Message-ID: <20250828120836.195358-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Separately enumerating all 32 registers is not helpful.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_ptrace.h | 34 +------------
 linux-user/microblaze/signal.c        | 70 +++------------------------
 2 files changed, 8 insertions(+), 96 deletions(-)

diff --git a/linux-user/microblaze/target_ptrace.h b/linux-user/microblaze/target_ptrace.h
index a46c8cb7bc..ead913e5a4 100644
--- a/linux-user/microblaze/target_ptrace.h
+++ b/linux-user/microblaze/target_ptrace.h
@@ -7,38 +7,8 @@
 typedef uint32_t microblaze_reg_t;
 
 struct target_pt_regs {
-    microblaze_reg_t r0;
-    microblaze_reg_t r1;
-    microblaze_reg_t r2;
-    microblaze_reg_t r3;
-    microblaze_reg_t r4;
-    microblaze_reg_t r5;
-    microblaze_reg_t r6;
-    microblaze_reg_t r7;
-    microblaze_reg_t r8;
-    microblaze_reg_t r9;
-    microblaze_reg_t r10;
-    microblaze_reg_t r11;
-    microblaze_reg_t r12;
-    microblaze_reg_t r13;
-    microblaze_reg_t r14;
-    microblaze_reg_t r15;
-    microblaze_reg_t r16;
-    microblaze_reg_t r17;
-    microblaze_reg_t r18;
-    microblaze_reg_t r19;
-    microblaze_reg_t r20;
-    microblaze_reg_t r21;
-    microblaze_reg_t r22;
-    microblaze_reg_t r23;
-    microblaze_reg_t r24;
-    microblaze_reg_t r25;
-    microblaze_reg_t r26;
-    microblaze_reg_t r27;
-    microblaze_reg_t r28;
-    microblaze_reg_t r29;
-    microblaze_reg_t r30;
-    microblaze_reg_t r31;
+    /* Note the kernel enumerates all 32 registers. */
+    microblaze_reg_t r[32];
     microblaze_reg_t pc;
     microblaze_reg_t msr;
     microblaze_reg_t ear;
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 7aef781314..e874e4def1 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -51,75 +51,17 @@ struct target_rt_sigframe {
 
 static void setup_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
 {
-    __put_user(env->regs[0], &sc->regs.r0);
-    __put_user(env->regs[1], &sc->regs.r1);
-    __put_user(env->regs[2], &sc->regs.r2);
-    __put_user(env->regs[3], &sc->regs.r3);
-    __put_user(env->regs[4], &sc->regs.r4);
-    __put_user(env->regs[5], &sc->regs.r5);
-    __put_user(env->regs[6], &sc->regs.r6);
-    __put_user(env->regs[7], &sc->regs.r7);
-    __put_user(env->regs[8], &sc->regs.r8);
-    __put_user(env->regs[9], &sc->regs.r9);
-    __put_user(env->regs[10], &sc->regs.r10);
-    __put_user(env->regs[11], &sc->regs.r11);
-    __put_user(env->regs[12], &sc->regs.r12);
-    __put_user(env->regs[13], &sc->regs.r13);
-    __put_user(env->regs[14], &sc->regs.r14);
-    __put_user(env->regs[15], &sc->regs.r15);
-    __put_user(env->regs[16], &sc->regs.r16);
-    __put_user(env->regs[17], &sc->regs.r17);
-    __put_user(env->regs[18], &sc->regs.r18);
-    __put_user(env->regs[19], &sc->regs.r19);
-    __put_user(env->regs[20], &sc->regs.r20);
-    __put_user(env->regs[21], &sc->regs.r21);
-    __put_user(env->regs[22], &sc->regs.r22);
-    __put_user(env->regs[23], &sc->regs.r23);
-    __put_user(env->regs[24], &sc->regs.r24);
-    __put_user(env->regs[25], &sc->regs.r25);
-    __put_user(env->regs[26], &sc->regs.r26);
-    __put_user(env->regs[27], &sc->regs.r27);
-    __put_user(env->regs[28], &sc->regs.r28);
-    __put_user(env->regs[29], &sc->regs.r29);
-    __put_user(env->regs[30], &sc->regs.r30);
-    __put_user(env->regs[31], &sc->regs.r31);
+    for (int i = 0; i < 32; ++i) {
+        __put_user(env->regs[i], &sc->regs.r[i]);
+    }
     __put_user(env->pc, &sc->regs.pc);
 }
 
 static void restore_sigcontext(struct target_sigcontext *sc, CPUMBState *env)
 {
-    __get_user(env->regs[0], &sc->regs.r0);
-    __get_user(env->regs[1], &sc->regs.r1);
-    __get_user(env->regs[2], &sc->regs.r2);
-    __get_user(env->regs[3], &sc->regs.r3);
-    __get_user(env->regs[4], &sc->regs.r4);
-    __get_user(env->regs[5], &sc->regs.r5);
-    __get_user(env->regs[6], &sc->regs.r6);
-    __get_user(env->regs[7], &sc->regs.r7);
-    __get_user(env->regs[8], &sc->regs.r8);
-    __get_user(env->regs[9], &sc->regs.r9);
-    __get_user(env->regs[10], &sc->regs.r10);
-    __get_user(env->regs[11], &sc->regs.r11);
-    __get_user(env->regs[12], &sc->regs.r12);
-    __get_user(env->regs[13], &sc->regs.r13);
-    __get_user(env->regs[14], &sc->regs.r14);
-    __get_user(env->regs[15], &sc->regs.r15);
-    __get_user(env->regs[16], &sc->regs.r16);
-    __get_user(env->regs[17], &sc->regs.r17);
-    __get_user(env->regs[18], &sc->regs.r18);
-    __get_user(env->regs[19], &sc->regs.r19);
-    __get_user(env->regs[20], &sc->regs.r20);
-    __get_user(env->regs[21], &sc->regs.r21);
-    __get_user(env->regs[22], &sc->regs.r22);
-    __get_user(env->regs[23], &sc->regs.r23);
-    __get_user(env->regs[24], &sc->regs.r24);
-    __get_user(env->regs[25], &sc->regs.r25);
-    __get_user(env->regs[26], &sc->regs.r26);
-    __get_user(env->regs[27], &sc->regs.r27);
-    __get_user(env->regs[28], &sc->regs.r28);
-    __get_user(env->regs[29], &sc->regs.r29);
-    __get_user(env->regs[30], &sc->regs.r30);
-    __get_user(env->regs[31], &sc->regs.r31);
+    for (int i = 0; i < 32; ++i) {
+        __get_user(env->regs[i], &sc->regs.r[i]);
+    }
     __get_user(env->pc, &sc->regs.pc);
 }
 
-- 
2.43.0


