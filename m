Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA36AC25B7E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxc-0006IU-99; Sun, 26 May 2024 08:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxb-0006HQ-2X; Sun, 26 May 2024 08:26:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxZ-0001N9-Ea; Sun, 26 May 2024 08:26:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso1930594b3a.3; 
 Sun, 26 May 2024 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726403; x=1717331203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HcYPwV6XCSqjrlNZ2r5bJKShIDF7V+jrAWQcaF5Fd4=;
 b=VtuNZb1hfPMfe+wrXCiiCVkWVgLOvAnSwRUfQSvLiLyRXA+od5Rg4Clfc7tn6WcxCa
 /2FHz+TMedmc3FYv1N2/FvLHB08iAythooU1pjiwn3KG9m1AhP7K3bIq0sgFyzxmcaqA
 g9MnPacKr8H08bVLn3aAHNIjdEz6NWTkvuF4NqJVqeVC3Xh+wFuQReWP5avTZTVxMFKr
 045aEHtcDA5ThgSwSJQvstG2HGXNsm77gecaEDcWnVD8fD5QXUd2QxLI9u7qBiGIgclu
 jejcl44SYVjJHlwuWnvEBYUpAVMmvOwVbXfZQRR3SW72GihhvTaCgNKwB+HS/kZe9KUO
 Gc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726403; x=1717331203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HcYPwV6XCSqjrlNZ2r5bJKShIDF7V+jrAWQcaF5Fd4=;
 b=lZEVH9qp2qZNJdFwCOfycSR/3GKfgHGdCf3TGC5Ht9rpF2Mc2QlTSDHmvNNWSdzH8F
 y3IKFw/M19mxsBvCbrr8WiupBfJooVkWTjURn27ybaJ4645ypBYPM4veJQKqja2OYHnd
 gBXpnnB0uLYrcy20T56CusFf+iLTH5p1ZgNonYiE+ExDfOUAI0JBZqU7V3UN4LsKNxb6
 Uo2if/pKaknk0hKmTB7G9fVncksqq5rD+JnYlHQnctHXkOnkNa+dagJwodVWQVrMfilf
 C+tPRqaW21zgTz9N5M/saLTGC4gkIMUadcuVr4/NSP/xf7sp6YzXh9jBhCsb4qwm/MuB
 LbBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDS9KPvroHg3Fu2E6EcTtjKHqqsVWf/RLhRuMj/xl4p0KloqqDVLjLNI7YjEtuKrpkC+sb+D84INLVtQK5UhDO0na3NJc=
X-Gm-Message-State: AOJu0Yz18exY5yDhJgWXgcgou6pfKi9fdkNgSXyufr04inbjMNnePkRu
 fpEXH+r9cvw6GZKLxEcOMNfcCVeVWTgHD+IMbP6m4/++AuscRXMJfcdy5Q==
X-Google-Smtp-Source: AGHT+IGiCxQZVmeHAC0Oh8hcu8HqDjj+JnXyTz1UmwHwIzZoeCsVLDQw12ePDL+gOux36QvJ6KwMeQ==
X-Received: by 2002:a05:6a00:4093:b0:6e6:9f47:c18c with SMTP id
 d2e1a72fcca58-6f8f41a9f2dmr6694534b3a.33.1716726403357; 
 Sun, 26 May 2024 05:26:43 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 06/10] ppc: Add a core_index to CPUPPCState for SMT vCPUs
Date: Sun, 26 May 2024 22:26:07 +1000
Message-ID: <20240526122612.473476-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The way SMT thread siblings are matched is clunky, using hard-coded
logic that checks the PIR SPR.

Change that to use a new core_index variable in the CPUPPCState,
where all siblings have the same core_index. CPU realize routines have
flexibility in setting core/sibling topology.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        | 5 ++++-
 hw/ppc/pnv_core.c       | 2 ++
 hw/ppc/spapr_cpu_core.c | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index dac13d4dac..9a89083932 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1247,6 +1247,9 @@ struct CPUArchState {
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
+    /* For SMT processors */
+    int core_index;
+
 #if !defined(CONFIG_USER_ONLY)
     /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
@@ -1404,7 +1407,7 @@ struct CPUArchState {
 };
 
 #define _CORE_ID(cs)                                            \
-    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
+    (POWERPC_CPU(cs)->env.core_index)
 
 #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
     CPU_FOREACH(cs_sibling)                                     \
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9b5edd9e48..0f61aabb77 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -252,6 +252,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
+    env->core_index = core_hwid;
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e7c9edd033..059d372c8a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -300,16 +300,19 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
     g_autofree char *id = NULL;
     CPUState *cs;
     PowerPCCPU *cpu;
+    CPUPPCState *env;
 
     obj = object_new(scc->cpu_type);
 
     cs = CPU(obj);
     cpu = POWERPC_CPU(obj);
+    env = &cpu->env;
     /*
      * All CPUs start halted. CPU0 is unhalted from the machine level reset code
      * and the rest are explicitly started up by the guest using an RTAS call.
      */
     qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
+    env->core_index = cc->core_id;
     cs->cpu_index = cc->core_id + i;
     if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         return NULL;
-- 
2.43.0


