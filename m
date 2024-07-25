Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4F6C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JC-0007su-Ar; Thu, 25 Jul 2024 19:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J9-0007aZ-MT; Thu, 25 Jul 2024 19:55:40 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J5-0000xf-Lq; Thu, 25 Jul 2024 19:55:37 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-71871d5e087so301597a12.1; 
 Thu, 25 Jul 2024 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951733; x=1722556533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cRNIZQvI22DqGJqRZ6sJmUnDyfnGdR7fxBN0WMsukQ=;
 b=D5rZVmz6wFTBEleiQEUZCsij1sonvOQF1Pf4gtktT+iQkdfCD7wuH13xUVHGlMJuw5
 vczrlcKSHKnH6pmSyEPC78TchOJC14ynkYRHNFiRXynrvr1TW/V9pz5+3evLGJ2ip10v
 FVYDNpseCdggGu2e2opmsC7Nu14NSHVXbfL2Rqg9Bk881GU+05smDef9g1onjJqdtJ9O
 vOYt8bdCiQGu/WgJ6NM/AW9+pCXCUAqXTu3QU7lH7NYgMFYYPaQ1L70RNKz1Gymo5R5v
 rsPfDsLWt8rIAobXHvrkr65agJ96EUPhrlrs9AQ3gsXWeACsqxyoGq18Nzy93Yu6WLR6
 dVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951733; x=1722556533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cRNIZQvI22DqGJqRZ6sJmUnDyfnGdR7fxBN0WMsukQ=;
 b=OU1iVk81+Ie6x6sQ8as2U9rjYAuzmiZONoezyMaQCBVVkSC5Exqx1amMf9pTUljROX
 ggq2MpGd1QcAmv0vojujNLlgBTL1ECRZQIIZrB5VEr88IX6bgFF2TZXmRMm7eCCxDXEl
 YytCfB/G5AKVcUFa+7HvQbLGOnX+5uOYCPYMw7NniE81ilZpApyDu/GsH3rX5An+G5U9
 sjIvnTRwylZi7qDU6ulFAKkvpWSsK+2BmlLwSHUzSPu4H6zPmx7mTLivBW+bd+THYQos
 JZp3JPkXjBzo/8J5BFFJIvgl0glA2RZK9eVnb/QS9G0UigILFmDa0J1Pfe7KLjwFQsAm
 e8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvX/B2Yd6U/ayGqHWjcolYJu0h6lOvnEw+fIeg65wpwEtgaorAMfcV/Hptw+T4DPlxh7AsAD9+Pq7sQOqnoUeIFh0R
X-Gm-Message-State: AOJu0YzjLYF3rbhqLsoQANyDNF6PRthoaFsWFNZJ3/mVVYjyRavK2Lyv
 mGh33tCsoto7nHWYAl7TZFlc/nlerrp3C6LwhiCIiqo34LL8t/NWjFMTkg==
X-Google-Smtp-Source: AGHT+IGMemA1K+1CtJd6xKFtm2XXieQjwtse9MoL4pMXeJNffn+A9hSJwBAWnIAZnjIB4dtZX9vEHw==
X-Received: by 2002:a17:90a:b30d:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2cf238bdda9mr4929412a91.33.1721951733042; 
 Thu, 25 Jul 2024 16:55:33 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/96] target/ppc: Fix msgsnd for POWER8
Date: Fri, 26 Jul 2024 09:52:51 +1000
Message-ID: <20240725235410.451624-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

POWER8 (ISA v2.07S) introduced the doorbell facility, the msgsnd
instruction behaved mostly like msgsndp, it was addressed by TIR
and could only send interrupts between threads on the core.

ISA v3.0 changed msgsnd to be addressed by PIR and can interrupt
any thread in the system.

msgsnd only implements the v3.0 semantics, which can make
multi-threaded POWER8 hang when booting Linux (due to IPIs
failing). This change adds v2.07 semantics.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0cd542675f..c0120c8a88 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2998,6 +2998,41 @@ static inline bool dbell_bcast_subproc(target_ulong rb)
     return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
 }
 
+/*
+ * Send an interrupt to a thread in the same core as env).
+ */
+static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
+    }
+
+    if (target_tir >= nr_threads) {
+        return;
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, irq, 1);
+    } else {
+        CPUState *ccs;
+
+        /* Does iothread need to be locked for walking CPU list? */
+        bql_lock();
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+            if (target_tir == ppc_cpu_tir(ccpu)) {
+                ppc_set_irq(ccpu, irq, 1);
+                break;
+            }
+        }
+        bql_unlock();
+    }
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3018,6 +3053,13 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         return;
     }
 
+    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
+    if (!(env->insns_flags2 & PPC2_ISA300)) {
+        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
+        return;
+    }
+
+    /* POWER9 and later msgsnd is a global (targets any thread) */
     cpu = ppc_get_vcpu_by_pir(pir);
     if (!cpu) {
         return;
@@ -3064,41 +3106,13 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
  */
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs = env_cpu(env);
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
-    int ttir = rb & PPC_BITMASK(57, 63);
-
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
-    }
-
-    if (!dbell_type_server(rb) || ttir >= nr_threads) {
-        return;
-    }
-
-    if (nr_threads == 1) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
+    if (!dbell_type_server(rb)) {
         return;
     }
 
-    /* Does iothread need to be locked for walking CPU list? */
-    bql_lock();
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
-        uint32_t thread_id = ppc_cpu_tir(ccpu);
-
-        if (ttir == thread_id) {
-            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
-            bql_unlock();
-            return;
-        }
-    }
-
-    g_assert_not_reached();
+    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
 }
 #endif /* TARGET_PPC64 */
 
-- 
2.45.2


