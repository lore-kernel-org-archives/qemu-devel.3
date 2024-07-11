Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7169FC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueA-00055u-4K; Thu, 11 Jul 2024 10:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRue7-0004u5-Ip; Thu, 11 Jul 2024 10:19:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRue5-0005Vn-QC; Thu, 11 Jul 2024 10:19:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70b3c0a00f2so745397b3a.3; 
 Thu, 11 Jul 2024 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707580; x=1721312380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IkyAC50oiavRu7uVzyi3eVaZuodeWTVQ2rjbZSzKT0=;
 b=YbzcKQvlaggZsRo5tRYCCeXpIPysPRHN4nB5ctiSOCW4fIoJRdjngmrATpcDwcsiHm
 IIki1GBSY/1476uzZJ7yHdKvCJbcg+wiPnoL7hBuY/7PNReGAm6LQFMXTyJosNvGw4Db
 hfeuDLzT8JyZ0CmM3IOYyfYo1a4KH9/8suKG/BZFub5Wc3aQusqjY6hh+JdlCg3xfX6a
 WaRYU3brMCRMMn7F83U3o038mQg9Nb7hw6x4gDBGe330UbmdJv/NwcROdRhhnqvsNTU4
 VkMyI00lpZ1OrLwBU5ilH9qnAsv84ivG3qzfjr4bVjALMgLdVe9yrmnh7VMxIiFiaAUc
 2Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707580; x=1721312380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IkyAC50oiavRu7uVzyi3eVaZuodeWTVQ2rjbZSzKT0=;
 b=dEyMw0BVPtgN4k/FAc36E9E0VSk/j/IbwIY44ThUcuwJXzvS+ujokhQV/zfxG4z8aw
 Ew7aEnw42m2385fuuoedXCQQ+E1YJExqyciBT2Pcogx86fpHBsVX0Pi+VoQcz3Psra1W
 Dn0SdFQ7jsHZb5FWxF2vNwyAdn3s6swyjJD8L/S3R+IloZHmRyisOCdzYu7nuZpNPvcm
 qwgI1OR3Eku/25Wpl36y3dnNet00p5LtWW47dbwJvLV8UVHt7H2ShZpmA6IaqUovyv31
 /ajDrzhzSzZf84ElCUu6H632J5ofKqPjBU1MzYk64A6qb81t683Y4ghw/nhxwClUATN6
 P6Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ9OADekdjPHgwJ6q+VrtOfu3nYRUYJr3rCpKyosi5OKPIQAhHokojKozUkOEyYCRO7Mm0oSM4JzjpJFSahj9hODqohPg=
X-Gm-Message-State: AOJu0Yxo2A4acUMimuxyhY4MNZFVEChPn31c7glp63pmxe3Icq6QS3g8
 t8ptTb7Fp91/fsrhM74LWQruw+8o72MMmPZCcoxF9XFqh5glKNY+fUyRnfsm
X-Google-Smtp-Source: AGHT+IG2DenIyXPgdzjcTXqxLyfgnRvpcrLXgwaSweWn5Ud7CFs836wvu+62OSpzpiLwiuvH0Air2A==
X-Received: by 2002:a05:6a20:918c:b0:1c2:8904:14c2 with SMTP id
 adf61e73a8af0-1c29824364dmr10989446637.37.1720707572137; 
 Thu, 11 Jul 2024 07:19:32 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 08/18] ppc: Add a core_index to CPUPPCState for SMT vCPUs
Date: Fri, 12 Jul 2024 00:18:40 +1000
Message-ID: <20240711141851.406677-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
index 95ba9e7590..c3a33d2965 100644
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
@@ -1403,7 +1406,7 @@ struct CPUArchState {
 };
 
 #define _CORE_ID(cs)                                            \
-    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
+    (POWERPC_CPU(cs)->env.core_index)
 
 #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
     CPU_FOREACH(cs_sibling)                                     \
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 28ca61926d..7bda29b9c7 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -249,6 +249,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
+    env->core_index = core_hwid;
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 21920ea054..d9116c8409 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -302,16 +302,19 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
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
2.45.1


