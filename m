Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41FBCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk7-0000Jy-OP; Sat, 30 Aug 2025 11:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X2-00032R-72
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wz-0002v1-RN
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771eecebb09so3477241b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506312; x=1757111112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ODt3jFX/ShiFbhhaunrjNIA0fSWhF7JNs/c5siSe2U=;
 b=e6ftwQcVDaSaiDb7LtWB7g/Ap9grXczrs0jx4ti0MEOu1KHURogBcH9XbilOqIPVGG
 ylrHGV0rAwraYOfsrrJc2EK+orNQvZmyLwgiIUDrac++546NyBd8A9TRmiK87qsu3iHJ
 aVSFKn56ox11e9IDiBPkttjtDSBxyTyro7VNirT6R5AJUyTLr9jUhW5OtG+8s4qe6LvY
 BL7FhVO2ygs6JPmKVGU+1ye8dqBN1db0ONM11zXLOL8gOgWkIZh5uhvfd4onT2MWN0vZ
 Ftsekqmr+fIwdey4dhIAuoSaJ0qmw4irU2prKSBwaX/SWTCokJxIgObZ1oIn9NGhDF2c
 yoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506312; x=1757111112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ODt3jFX/ShiFbhhaunrjNIA0fSWhF7JNs/c5siSe2U=;
 b=WMQMFktBh2t+KjXcUTrd+2fiUDESQ3m4mWAIMSikqFwsS60mDOEMpc6rzGVHaux14k
 ywFwSIJh5JUaCXV2IVmPsdzQa0eXOlHuFLdi1VTndozszEA9UpcepTAAnehqPUbI/XoG
 Uxuz+MrrsK455bOLEqJsgL2uS1Yz8sGUNK1y0PK7gj1Qtb0cUTrotrbTiR56th339/l/
 vTOdxceY+2uyw9Wxdy5luiCqftq7KTDviGTTXThocwGVLg6MzWzDcVylt+dlGteAr6+e
 KjfPAhllQlUhbFyhRuZt0rOVrmBKd4/iU8A6VRpLVyIAUslTmEM4cw9A3tpasOHssm6W
 yfDQ==
X-Gm-Message-State: AOJu0YymVttTXlBsi0a6Dge0U82mBrjCjaBHHwXoji2Lwjesc6evb1RC
 LM8Q8c1rYiLe/gvhKuccZhztz4QlUFP/zHPWxjDRGBGNaOA+mTLsItczwgRr4+as9T2XslxuOnm
 1jeg0db8=
X-Gm-Gg: ASbGncu+pk01027CRQpcK6UdtYQc6RL0z80A3h0sAq3WRDCNwFB39if/m6d+G277Ljv
 hAmvEtYat1gKPD9RoI7NT9VH5OFPsq/zhmaBpra/p8XfHtHllAvUWnFnCsdu/1Xs3KupEU36uV/
 X1LTcD2hK+hsdWRI+7CP78cYmDIHw2yFFwjvaUVyIkBQ1N84IQFUPPILuSlaIXYKWFX5p7SordT
 YX2UZN7Ww4aq3x71gd9sGHV9VmJNbno07i6KpabJczhXPf4zNTJsIwD4WzG2vyymlRfJwevZcDC
 wUWbi6PKu897pCT5VpDtNme0pxI+CjVU5p4PQt8cT5vcDEDTjY6WgwW3VhrvuAspXaRWLtvMfCJ
 pQPnbADyLzWSE64fIHa3diaqaRtjI3yhqEqMfDr7ks3JI3oMQ75kq7KAhNcAu3PptqAq5iE8=
X-Google-Smtp-Source: AGHT+IGhjt9x1vdwjR1/Hg1do5ESSaOxca5UZKu2FOaxGaRCUn55DtWdj/H0rVTXffHY2SeHBfPsSQ==
X-Received: by 2002:a05:6a00:a22:b0:771:e3d7:4320 with SMTP id
 d2e1a72fcca58-7723e362840mr206158b3a.19.1756506312252; 
 Fri, 29 Aug 2025 15:25:12 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/91] linux-user/s390x: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:12 +1000
Message-ID: <20250829222427.289668-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 63376fa1d6..98c17d32e6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -770,7 +770,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_REG_PSWM = 0,
@@ -780,22 +782,22 @@ enum {
     TARGET_REG_ORIG_R2 = 26,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUS390XState *env)
 {
     int i;
     uint32_t *aregs;
 
-    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
+    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
+    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
     for (i = 0; i < 16; i++) {
-        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
     }
-    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
+    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
     for (i = 0; i < 16; i++) {
         aregs[i] = tswap32(env->aregs[i]);
     }
-    (*regs)[TARGET_REG_ORIG_R2] = 0;
+    r->regs[TARGET_REG_ORIG_R2] = 0;
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


