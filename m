Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EA7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0F-0006ND-E2; Fri, 12 Jul 2024 08:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzV-0003pV-H9; Fri, 12 Jul 2024 08:03:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzR-0005Pw-M6; Fri, 12 Jul 2024 08:03:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70b13791a5eso1645280b3a.1; 
 Fri, 12 Jul 2024 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785781; x=1721390581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5y4TKaDDHvMsX8pNSb4QjcSx4fOTcaEPBO+qYDjTJY=;
 b=WoR4dy7BQKu8ouHzjI4/M7wJsfUzqiu0H2MF6w5lGdFDZ+X5SWg+jT6pBokvUH955K
 4NamA/JDk3EUhNfkGUJhqo0zA1JOdC9bkKnDOeIkqCcNPwDdfNsczMI7fUdyl86TeCRX
 xGG8gA0i5yZl+ivFsXBJFWBGs143d2v8qrkQws7e4+1Ep8qgkKY6gZXGwRCXVwN1Ov2U
 6NhOg2JIQYuGWp8Bxf0Vbm8uB5n9gb5okxdwneWFXKYX8UfU0NJbHS5vB26NdmKQv/ag
 9DFhwmTjY3Fqxxk0h1kgyIzgqp2a2FvkH5moNEZBo2iG9wniryoIvTjApPnb80au+V32
 LTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785781; x=1721390581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5y4TKaDDHvMsX8pNSb4QjcSx4fOTcaEPBO+qYDjTJY=;
 b=porAnHctY9Yufivp68WNUt5g4x3VOW5lqlmGWL+TMuXkkzUfEs9fM/gi4QDO4er/bx
 MCg5Zgl6iotOTIzPvoy+F86/KmB7koxr61ZmrwGBQl0MUqCRZuRTde3YXRWh1ghekJpT
 /jseDf26qPET++DVQBlrpvOPGFdbqFofJtYn4ONs1pvryHLqgXz81I4/EMMVrpQlzjK3
 N/KNwOjj0uqDXORf7V0HrwB/TmTsX929v0gW6vIs7cdkkhMrdbGYJ7sIp08fHx9htqwQ
 koh5xB/1a/5A9j41RwsE4ByVJ0TbfrlcMV8iqpYqFpcmAsG4g6qA+vNEkq4ZszLGbqWQ
 B14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOkOHtIQR9gk6G08n+ndGj5Kd8zphyIlPHjYFO0MXrlLBr3O07O08SyNFhv3x14fJ/x1r6VQpUX/GKbR8KQSduQFSQzY0=
X-Gm-Message-State: AOJu0Yx1c/YhjA9vDK8WPNwWjLpJmdBWoYvZaMX2H3qFSOK/S2N57jKk
 Q8yXYB7ErhkYoI+4hboXtuHIlCPOAAttlThDfCCvvP7Dh7focM4j/W2WgQ==
X-Google-Smtp-Source: AGHT+IEUD8WdJRMjWSCBr5swBEJWeXVdnX6fpN3tn4GfB6QbIWkXrEX8ZLSXiPJR+KunESwpOk49Sg==
X-Received: by 2002:a05:6a00:2e04:b0:702:6f45:effc with SMTP id
 d2e1a72fcca58-70b4357d653mr14660357b3a.20.1720785780533; 
 Fri, 12 Jul 2024 05:03:00 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 01/19] target/ppc: Fix msgsnd for POWER8
Date: Fri, 12 Jul 2024 22:02:28 +1000
Message-ID: <20240712120247.477133-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0a9e8539a4..5368bf2ff3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3007,6 +3007,41 @@ static inline bool dbell_bcast_subproc(target_ulong rb)
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
@@ -3027,6 +3062,13 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
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
@@ -3073,41 +3115,13 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
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
2.45.1


