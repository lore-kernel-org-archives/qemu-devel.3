Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C06C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFg-0003z0-EM; Wed, 15 May 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFd-0003xw-Ju
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003F7-7W
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41ff5e3d86aso38691445e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785740; x=1716390540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+rFx22MXTz69amYQHY6y5MWkt0yWCTNmtE/0oYtP34=;
 b=g9PK4EhNVC4s8/0zYyGytKl9KdBjgO37U0IwYMeejirbkm8T8xpXjRkzJ3/1AC6PqQ
 VHF9ZjYo9EiOzn3MfNR2yu+0mt9DebjnGvc7Uiepsmjk/I32lyg6x7aqBpjJoOfVX3ZD
 T3zceqLubvJS8cZYQDs1ufpT7khc7crkA9aNf5/SP2hoKSf8U5kV06TzO1Vd1fE1HfaI
 JBL3w3B9iC5H39q30LkFuaOMsAWEuo+L93/YE6mwwQeUzOefRviXMIvVxyMvDCwv2g1n
 ESRZeQZtL/R8dUNeeaAtU6UDrczyRD00CtwsHD60YqRhVc/Np++mxtznX/b/AQPhiMCX
 1hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785740; x=1716390540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+rFx22MXTz69amYQHY6y5MWkt0yWCTNmtE/0oYtP34=;
 b=BLfjL2WIOe8cdCf/2BYSNHaOFGV6wDBoBa+xO50n6WExQLjl0mu3+q9QxogkYvq3hn
 eseTOnmdqP5phTD4FWA5+6vvSKzDuDIexo0obi/x9KqcncoYPHbRNeGVPXkECqVW0KXB
 8SoPBRETg13LnANXZSl8tPypnbgo09/QOFgKrXEQXzwjjgYmFUvJ66HTSUJ4r5R1Mtpv
 Cs/ukJwiCKMTOulGcYbNLwOZ1hF+31tl19jNMTwYEUhMWzw3AA1Q2U6qTc8C5vLwBFuu
 w/Ko3A59Tu81LunrauwdNpM+IlZReQoniTtsOhis+to/qpXc2DVZy78jVSCUJnBtYs6e
 vDIw==
X-Gm-Message-State: AOJu0YwtFai5x+r0jdE3SafNu6Yy9iM6VW1oc79wpkF6zNR1w5KHn3nh
 IUn1Cajs2Jtt3aDq24mxsSMmRT8XE3R/mWiset8vpWanYGj37MWdi9NAEzEkbunAoo1doXZv36X
 Tb+8=
X-Google-Smtp-Source: AGHT+IGYSOvdMdkmPn4kEjY5yWG6oA7nuZEr6lsZtaAzXgNhkdSRo68Af2azPp/hP13yYjTHCl5jAw==
X-Received: by 2002:a05:600c:ac1:b0:416:3f85:d49 with SMTP id
 5b1f17b1804b1-41feaa42cd6mr136506845e9.18.1715785740043; 
 Wed, 15 May 2024 08:09:00 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 26/28] target/i386: Pass host pointer and size to
 cpu_x86_{fsave, frstor}
Date: Wed, 15 May 2024 17:08:35 +0200
Message-Id: <20240515150837.259747-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            | 10 ++++++----
 linux-user/i386/signal.c     |  4 ++--
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4b3bffeb9c..2897faccb9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2236,11 +2236,13 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 /* used for debug or cpu save/restore */
 
 /* cpu-exec.c */
-/* the following helpers are only usable in user mode simulation as
-   they can trigger unexpected exceptions */
+/*
+ * The following helpers are only usable in user mode simulation.
+ * The host pointers should come from lock_user().
+ */
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
-void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
-void cpu_x86_frstor(CPUX86State *s, target_ulong ptr, int data32);
+void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
 void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
 void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 2f93342ade..816e8ab2a9 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -373,7 +373,7 @@ static void setup_sigcontext(CPUX86State *env,
     __put_user(env->regs[R_ESP], &sc->esp_at_signal);
     __put_user(env->segs[R_SS].selector, (uint32_t *)&sc->ss);
 
-    cpu_x86_fsave(env, fpstate_addr, 1);
+    cpu_x86_fsave(env, fpstate, sizeof(*fpstate));
     fpstate->status = fpstate->swd;
     magic = (fpkind == FPSTATE_FSAVE ? 0 : 0xffff);
     __put_user(magic, &fpstate->magic);
@@ -702,7 +702,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
      * the merge within ENV by loading XSTATE/FXSTATE first, then
      * overriding with the FSTATE afterward.
      */
-    cpu_x86_frstor(env, fpstate_addr, 1);
+    cpu_x86_frstor(env, fpstate, sizeof(*fpstate));
     return true;
 }
 #endif
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1ac61c5d7d..05db16a152 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3017,22 +3017,28 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void cpu_x86_fsave(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_fsave(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
-    do_fsave(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_fsave(&ac, 0, true);
 }
 
-void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
-    do_frstor(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_frstor(&ac, 0, true);
 }
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


