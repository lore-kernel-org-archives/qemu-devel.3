Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A1D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqf-0004ry-6H; Sun, 03 Nov 2024 19:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqc-0004Vn-4N; Sun, 03 Nov 2024 19:21:34 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqa-0002ha-1X; Sun, 03 Nov 2024 19:21:33 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720be27db27so2796065b3a.2; 
 Sun, 03 Nov 2024 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679690; x=1731284490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk9/ow9qEkX2Sb6yKS/2UXPFU8j93Otp3AOGck8SdW4=;
 b=BrW36wNh2EoP505JfYlI/tflUBrnZ1MiPRWwKo/azcgpoho0LYVNJfzkw8JffW3Qfk
 +ygbyVDEg9utHbD4iwVogkL6X2o2EkCSiH/1ycamSuUvhkPm2uFD+3UE4vntJe4JjfCN
 IzLJVKBUPRx/HhD059jDnhu2lqSXDJNxiYqBOebO2Y7dJDhehH+Iu78zXjCiqljrM4k9
 /V8vEwmKUPEcAxgiqkbCAaOuIphLmIWOggdTFBprBQNXqEszSo6ftj94csUah/ZmntkX
 wsiA+/Sq+BCZI7RUlcFqO1Lr0fJ4Tz03g0upaRgdIJUu6C3ms424vBvQYYhEUTJAOp/3
 q6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679690; x=1731284490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk9/ow9qEkX2Sb6yKS/2UXPFU8j93Otp3AOGck8SdW4=;
 b=gkJu6WdfMke9Y6L62QhrSIORRN9TvHQFQEa0zHPqGYEbN8uOjFu+def4a2ZNBBncet
 JyCW/9Sa7jN7Bpu/CzR+NNWJXoZrrCKCbBLJXxo4D1MicSo/0JujoL8tVDGQtJvu8ogP
 yu7mvamjEKajEBUsdN4kWkfCI3sYynx6pR7Yq1KWk2SK6CmFudfZutHUgyjoB5Z5ef5l
 0nYva+MZ37EGNmt6SzYBVoEMRF6j+Mi4dk2R62t8asWp8PxXTnzB70Wr+lVEIDy1h0hn
 PPhOZjbss4hcnU0IyBLpeVPt9/wEUo6jgLDf5JbQJ31h1U3uqgmekULHYVhg5iWVx3DU
 9Q5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwu4Xq8kUDG2wISEPZs4LM0capyio5ZDEz4eVNagJ6h5XuhhSZaeJqcWAWzcg/uVJECgSbGtjJSA==@nongnu.org
X-Gm-Message-State: AOJu0YwydZ7NEd62mE7NfNgAfJCG9pM/Wpa5AvmVTZjlnlTiWnrMXgWY
 KecPT/pAMa3WQVELZ0P0J2Gyi/o6dbNou3ShBpaUZ2gWrWlCvge8PPtbDw==
X-Google-Smtp-Source: AGHT+IEF88Z39pRiQO77pQ+fovJrXNzw36tKehMCLcqaLVSDl/WlJPMiKLscc/I06nLiScH713U4Aw==
X-Received: by 2002:a05:6a20:1589:b0:1db:d7d2:786d with SMTP id
 adf61e73a8af0-1dbd7d278d1mr3136173637.6.1730679689978; 
 Sun, 03 Nov 2024 16:21:29 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 38/67] target/ppc: optimize p9 exception handling routines
Date: Mon,  4 Nov 2024 10:18:27 +1000
Message-ID: <20241104001900.682660-39-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

Currently, p9 exception handling has multiple if-condition checks where
it does an indirect access to pending_interrupts and LPCR via env.
Pass the values during entry to avoid multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 72 ++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 087235bd62..7074e6c894 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1872,60 +1872,65 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
      PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |  \
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
 
-static int p9_interrupt_powersave(CPUPPCState *env)
+static int p9_interrupt_powersave(CPUPPCState *env,
+                                  uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
+
     /* External Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_EEE)) {
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
+        (lpcr & LPCR_EEE)) {
+        bool heic = !!(lpcr & LPCR_HEIC);
         if (!heic || !FIELD_EX64_HV(env->msr) ||
             FIELD_EX64(env->msr, MSR, PR)) {
             return PPC_INTERRUPT_EXT;
         }
     }
     /* Decrementer Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_DEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
+        (lpcr & LPCR_DEE)) {
         return PPC_INTERRUPT_DECR;
     }
     /* Machine Check or Hypervisor Maintenance Exception */
-    if (env->spr[SPR_LPCR] & LPCR_OEE) {
-        if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (lpcr & LPCR_OEE) {
+        if (pending_interrupts & PPC_INTERRUPT_MCK) {
             return PPC_INTERRUPT_MCK;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_HMI) {
+        if (pending_interrupts & PPC_INTERRUPT_HMI) {
             return PPC_INTERRUPT_HMI;
         }
     }
     /* Privileged Doorbell Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_PDEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
+        (lpcr & LPCR_PDEE)) {
         return PPC_INTERRUPT_DOORBELL;
     }
     /* Hypervisor Doorbell Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_HDEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
+        (lpcr & LPCR_HDEE)) {
         return PPC_INTERRUPT_HDOORBELL;
     }
     /* Hypervisor virtualization exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HVIRT) &&
-        (env->spr[SPR_LPCR] & LPCR_HVEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
+        (lpcr & LPCR_HVEE)) {
         return PPC_INTERRUPT_HVIRT;
     }
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     return 0;
 }
 
-static int p9_next_unmasked_interrupt(CPUPPCState *env)
+static int p9_next_unmasked_interrupt(CPUPPCState *env,
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         if (env->spr[SPR_PSSCR] & PSSCR_EC) {
@@ -1933,7 +1938,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
              * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
              * wakeup the processor
              */
-            return p9_interrupt_powersave(env);
+            return p9_interrupt_powersave(env, pending_interrupts, lpcr);
         } else {
             /*
              * When it's clear, any system-caused exception exits power-saving
@@ -1944,14 +1949,14 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
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
@@ -1959,18 +1964,18 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Hypervisor virtualization interrupt */
-    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
+    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
             return PPC_INTERRUPT_HVIRT;
         }
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
@@ -1980,20 +1985,20 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
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
@@ -2020,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-        return p9_next_unmasked_interrupt(env);
+        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
+                                          env->spr[SPR_LPCR]);
     default:
         break;
     }
-- 
2.45.2


