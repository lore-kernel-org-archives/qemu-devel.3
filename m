Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F86D1119B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kr7-0005MT-B5; Sun, 03 Nov 2024 19:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqg-00051B-Vj; Sun, 03 Nov 2024 19:21:39 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqe-0002i9-0r; Sun, 03 Nov 2024 19:21:37 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so2636875a12.0; 
 Sun, 03 Nov 2024 16:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679694; x=1731284494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJvgzKMs06qUgwXBjWAED/oIYCP+DEyOHDHvbxTpPZw=;
 b=ZWAnmyF00dF6GgEv+Dwu7TUAECKuWrKKZfbfTsBxkayPb/j87ipJgSS8wcc1GrpzSD
 1cBmm9oy66wBPnOnh35vFsE1EwekpoZNdzt+uLDpGn2e11pGjIRq++6R8+Kc3Gi0YPXq
 BFnfk+2X+Ot3ZlS98qWKq1HMtE/RV/RZO4dPoHrOP/nI0tnPho8bCZ9jAWl4y8Sio6Nh
 Kn7T59Hove1l/1+6LS+5ymChksat3vu8lN5j368N2ifE1RYLvZT46hM6SgRAusvtFVzX
 g7fDhakjQHpjI90+Qh3h90QTaNNFEww3Kml1MQUFD2ePAsNbd/QMFOcrPn/wpMn43y/T
 9b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679694; x=1731284494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJvgzKMs06qUgwXBjWAED/oIYCP+DEyOHDHvbxTpPZw=;
 b=EeZR7YZIjYXtW4PKOAF8jU9+vnZAZdRdTt22q206rY7gW4Ymf1oTFPgqS6yV14V88x
 mNA8ycytAfw13c6+oh5klfBJPd8kZ35MAmg+3chuFoSooQwuh9KbY51Bl/FTx/X26dJZ
 bhyu2POHlJrs31SRgL2SUB0+aQRVJJf7RJt4BmQ3DJJjhGzz6XlLP+KPB1tpWDa5dULz
 ShU5VO41BXPx7VyoDn1RqU2KGA05q5EXhLXDEEDjUvs0/5F/zREUKrDxsuTho2Tpob7h
 4tHGrgksvpamK9YYoen9RncnxlNi9zTkov1aRNzSapECid6F7RLNJNM2civTt61Kvz+1
 /J+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQr4+H29sP357dDK3jez3LOpWl5tD8rNsK/8/vXtsRzHtiOQWPyEXuj5N2k/rSv3JODtSJ9E/cMQ==@nongnu.org
X-Gm-Message-State: AOJu0YyeucGALuT0Nynuc4qrnQirKW1zlzPV342d6ERAQcUebD0qi3QN
 qYsg6f2FOLQc5jOHF4Ks+fUeMa/4nsXBnW4QcebOxBoVjFnrTrycL/mh3w==
X-Google-Smtp-Source: AGHT+IGCYsi8B0gdBMr0mbVcdZNTO34nTzzIrz/cN5SnCGy5/9AKPzdx9UvTiIlqUpuJr6vAnvi8KQ==
X-Received: by 2002:a05:6a20:b182:b0:1d9:237a:2d66 with SMTP id
 adf61e73a8af0-1dba5620e9bmr13036908637.47.1730679693815; 
 Sun, 03 Nov 2024 16:21:33 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 39/67] target/ppc: optimize p8 exception handling routines
Date: Mon,  4 Nov 2024 10:18:28 +1000
Message-ID: <20241104001900.682660-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Most of the p8 exception handling accesses env->pending_interrupts and
env->spr[SPR_LPCR] at multiple places. Passing it directly as local
variables simplifies the code and avoids multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 60 +++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7074e6c894..38733b7521 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1765,39 +1765,42 @@ static int p7_next_unmasked_interrupt(CPUPPCState *env)
     PPC_INTERRUPT_CEXT | PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL |  \
     PPC_INTERRUPT_FIT | PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
 
-static int p8_interrupt_powersave(CPUPPCState *env)
+static int p8_interrupt_powersave(uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE2)) {
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
+        (lpcr & LPCR_P8_PECE2)) {
         return PPC_INTERRUPT_EXT;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE3)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
+        (lpcr & LPCR_P8_PECE3)) {
         return PPC_INTERRUPT_DECR;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_MCK) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
+    if ((pending_interrupts & PPC_INTERRUPT_MCK) &&
+        (lpcr & LPCR_P8_PECE4)) {
         return PPC_INTERRUPT_MCK;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_HMI) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HMI) &&
+        (lpcr & LPCR_P8_PECE4)) {
         return PPC_INTERRUPT_HMI;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE0)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
+        (lpcr & LPCR_P8_PECE0)) {
         return PPC_INTERRUPT_DOORBELL;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_P8_PECE1)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
+        (lpcr & LPCR_P8_PECE1)) {
         return PPC_INTERRUPT_HDOORBELL;
     }
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     return 0;
 }
 
-static int p8_next_unmasked_interrupt(CPUPPCState *env)
+static int p8_next_unmasked_interrupt(CPUPPCState *env,
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
@@ -1808,18 +1811,18 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
 
     if (cs->halted) {
         /* LPCR[PECE] controls which interrupts can exit power-saving mode */
-        return p8_interrupt_powersave(env);
+        return p8_interrupt_powersave(pending_interrupts, lpcr);
     }
 
     /* Machine check exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (pending_interrupts & PPC_INTERRUPT_MCK) {
         return PPC_INTERRUPT_MCK;
     }
 
     /* Hypervisor decrementer exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
+    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -1827,9 +1830,9 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* External interrupt can ignore MSR:EE under some circumstances */
-    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if (pending_interrupts & PPC_INTERRUPT_EXT) {
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -1839,20 +1842,20 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (msr_ee != 0) {
         /* Decrementer exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+        if (pending_interrupts & PPC_INTERRUPT_DECR) {
             return PPC_INTERRUPT_DECR;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
             return PPC_INTERRUPT_DOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
             return PPC_INTERRUPT_HDOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
+        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
             return PPC_INTERRUPT_PERFM;
         }
         /* EBB exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
+        if (pending_interrupts & PPC_INTERRUPT_EBB) {
             /*
              * EBB exception must be taken in problem state and
              * with BESCR_GE set.
@@ -2021,7 +2024,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     case POWERPC_EXCP_POWER7:
         return p7_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER8:
-        return p8_next_unmasked_interrupt(env);
+        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
+                                          env->spr[SPR_LPCR]);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-- 
2.45.2


