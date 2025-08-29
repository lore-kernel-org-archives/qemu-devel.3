Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D594CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNky-0003nU-Jh; Sat, 30 Aug 2025 11:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bA-0004MI-LJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b8-0003a5-J3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so2093269b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506568; x=1757111368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0b8XApD11uS49cAycox2dUykst7Wjzbv/b7G4vIsl14=;
 b=NnCzgKEQk5n2SyLKoj5TsoIDvLQjYq2SHXsb0iNyMab3W985RiviLo0fRszusjB/Ca
 riOanlBTu+t614TVWwTrbKeUqlXhDUeEoslN9IkeWB1Pro+FwVb3K35tee4qZBgibDjn
 FhOFIy9iAQWKWoHbxyzPmzVAlyuDGjEiWUJekVKcjMFIx7LLoeaGbMI1Ho0Bj2imOcWG
 MERUwj3Jre/pcX3jkWhYlJV86F8ulyO5FNSuaB4K1JjWQYg5wSu0L95xqndQ2jbitv0n
 dmhcPXcDS0aI8Aw8Wxy3HoQ5FPbgJ34DT/RaKmj7Q9mDG6gkJiDc3f10Jtrt5ZQjq/WG
 cNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506568; x=1757111368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0b8XApD11uS49cAycox2dUykst7Wjzbv/b7G4vIsl14=;
 b=gFQ/MXgrgPt9XwVO11WFbXymqS4+yMUYMbPbusQY8HwEOmGyxcIvuiyTORJxndq7MP
 IzdpLBg18A1tgosCooiSawXSC3FFjOhsjdJ/C9fO3ShK22fCOkgdIpRjhAeLo3iWQUix
 pqPoNphcRjWspw3Y1T1yr3qLesqIiP8lZHT/wf1EpcuyHGZcwTwvDm3la5gAIdelfy5c
 8Q/PTZOpUAYgCHNXht+Fn4WKDh32uk9Ij+DjzoE59Peqrs31ssTdP+6qKOLF41obGqR3
 DloieQCcb6aVPPtEQdTxoznTl3GN9crIpwUnWV+qlVzS2EnhMfAWqgGkV/moQ3f/OoMJ
 IIYA==
X-Gm-Message-State: AOJu0Yz1DhOej7etjg8SCTep5o3q5OTdIv7zJjTM9fXKnlR9ERsvDdnU
 LbE+PBLRBNo+7LqjeDRVcft9Nnhm6AvSmlh8Vsw5O2jBWWTNFAsdfgttkTdZB3bFXqvI5MsgUJF
 YMjU+zNM=
X-Gm-Gg: ASbGncvG9U27W13KWC7dC9sWGJEtfVMefZxunAihPEMGqpAjVvl6pA/k28oUVCVgJ8t
 ApX1GysR4mNOPeTjocXaEON7rZ/jkYWzQtGmst0H83EGRBb7ahVb2R9fDayc65sltMNKfX4uEMt
 IbzeH3bZtcd2Fa6rp0eIy7V0Zfz/lLgmPwr0oBqZgFWmfvniqH3ALhd9QpclE5BH3MBMj6yKv1A
 QUGsoH8mQMMr3bVxS8KbuLHcSRUezwJtt/776SxJgoMdKr9bqkHA9LSzEPD/DUjsrMBwgwrj7mA
 x+vFXBx3NNhwn/xFQx/CBu0vw2wirRPWwodMGMSs+w7OR59TKJjUCDCZ6Ab8gN3aiiK57BoAIjt
 7ddF5TujaZebfTgZzutusej1Qx2lQc16JR5O3V2MalEgoOD6cx1rCTMOqVlQopO8=
X-Google-Smtp-Source: AGHT+IF86UjIpExCZf9kfvKrOOhbrRzG3nHakxqS988SQdXc/rTUTl1bVPoBIkjXSqg/rCBBfP+E9g==
X-Received: by 2002:a05:6a00:4b11:b0:772:2ca8:9378 with SMTP id
 d2e1a72fcca58-7723e341374mr278060b3a.21.1756506568476; 
 Fri, 29 Aug 2025 15:29:28 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 47/91] linux-user/microblaze: Fold target_pt_regs.r* to an array
Date: Sat, 30 Aug 2025 08:23:43 +1000
Message-ID: <20250829222427.289668-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


