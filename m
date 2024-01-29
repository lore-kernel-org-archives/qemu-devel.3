Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A35C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6E-0005sH-Mc; Mon, 29 Jan 2024 18:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6C-0005oz-Ba
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:32 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6A-00056I-MT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:32 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29026523507so2726891a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571089; x=1707175889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YucELH6fbErp+6umx07QFC7pYx6ueR6ifc1TTKY+quw=;
 b=Xd1j6lJmmNj4DOrDmW7nywRSnoxJ6Zl+FwrmYAoE5hsGzZKNjiyjaZR+5IEGGOxo+3
 FgXWr+tcfJqIQ2vs+woBOksP1dslKLj3u4l7bS7gjX91Be2YlRHDs2bGgJgictM8Qxj+
 dbqfMtBEfoXmdJOAcvJWwoFbs4cjnqv8y1ofypeHEXaCFh4EsCqB7UPkHhLYTxFUoyXa
 CU7qpaLUP3EFSp4zInVid3wj7zFthWtz6MsMAmbmv1GX8Hzg8/Y5rRFkpvlXdfdeqspM
 6UG5hZ3Laun/fcNp78Cjo7jNLDhzyNhMb1k2twXVJBlsIZowkYYGNWmKvLxUJ9RUuHGp
 qX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571089; x=1707175889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YucELH6fbErp+6umx07QFC7pYx6ueR6ifc1TTKY+quw=;
 b=n+gAY0H790DltBIwBxktIff71lOAwkewOQqtKek+a9UuHcTzaM+R01vQ0lH7bdHEgr
 Ipdt9CBrWbfTDs7P8S+uneGt2/oActIaiSNTiK0Dr3oPP+K8B6IL94kQE6FWRApCgQcq
 EoZ4/ck3vehGVbr1YcSnlfsNYU4/UAUPwwwfw6D/fOPn+1mOxyyg307dIG2exSV4SP6q
 qQpsRH4raAaObYjooCNCJpCTM46xyUBH+FnrdQEnFRyf0zo3ULgmzV6KPaWUUxmYQhKC
 JwJCGyXHl71u24LB6homymt2BGuy2PuehI4MMRWREJ7qCr15u5fsmH0MOcKVwX4+GCDo
 5Rtg==
X-Gm-Message-State: AOJu0YxEjTzwoaB1Rl3g5BVvHtaHpSwB1su3yyGytxkofyMC1jetjyJ2
 2k5h0Jz7Di2IxZtS9wkuCr6Ec0yCjlG+QVJMIYdrKDLewkCCtQqNbcwLJ3xdADBOVotKnnPKRl+
 9RPo=
X-Google-Smtp-Source: AGHT+IH5IDqnUWaUif2N5yUmkdlgjzY0Q6qtGXX1Ysho1vm8SpPiLEp8ttnWEZvzI9aMq8QHSf7okw==
X-Received: by 2002:a17:90a:a581:b0:28f:f19d:e43 with SMTP id
 b1-20020a17090aa58100b0028ff19d0e43mr4253528pjq.3.1706571089376; 
 Mon, 29 Jan 2024 15:31:29 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 18/33] target/nios2: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:28 +1000
Message-Id: <20240129233043.34558-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h | 12 ++++++------
 target/nios2/cpu.c |  7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 2d79b5b298..9965ff74c1 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -270,12 +270,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
-{
-    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
-                                                  MMU_SUPERVISOR_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -292,6 +286,12 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
+int nios2_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
+{
+    return nios2_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 596c0c5617..e42885997e 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -57,6 +57,12 @@ static bool nios2_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+int nios2_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return (cpu_env(cs)->ctrl[CR_STATUS] & CR_STATUS_U
+            ? MMU_USER_IDX : MMU_SUPERVISOR_IDX);
+}
+
 static void nios2_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -381,6 +387,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
+    cc->mmu_index = nios2_cpu_mmu_index;
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->get_pc = nios2_cpu_get_pc;
-- 
2.34.1


