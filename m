Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B1C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZH-0001NX-47; Thu, 23 May 2024 19:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZA-0000by-DP; Thu, 23 May 2024 19:09:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ7-0005pK-AP; Thu, 23 May 2024 19:09:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8ea5e3812so295952b3a.2; 
 Thu, 23 May 2024 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505778; x=1717110578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PlOMoB5bSanYICurf79scBjhN6zt+9ATt+QRYknyh8=;
 b=cuQ5O/XTszjc2F6iK6+f8qj1K2RDkIyBGgRvANK4gYFA348lZ2x86jHOzdTczK4YlQ
 hAi6NYPEEnujDpNCawObUUx+mp2ha9jk39m1VXAUa12jbAKeHYgM77599D6duxWv77Ax
 vhkBEdd7yP578fwMrKMW04GQVltAg45rBrjlUny0onpCN7vl24BlTCAnu1G0vpqmR9jw
 t65FMpd8bWevpBQ/wRtKiPgjRlel+TNDVn7phcfmeUpeL6v4n8Gpo1wpoA6/3WhC2vBI
 7u54Z7euV12l4OALu++wSb0V9DWXcsTJNLwhQ4zhrjE/p45XIq4kOoZpSw9HUG+DHzq0
 knwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505778; x=1717110578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PlOMoB5bSanYICurf79scBjhN6zt+9ATt+QRYknyh8=;
 b=RV8kzKXlD77zxXnwojGTM/ZqBFs143/uOoR1vW/gVGvWx/Txwi5HBrYDupCsWOpVCV
 thsjdBYq+8jBdjY6bDvG99qzDGpTdRdLM8H4/ygisz++/ok61oA2XpAkl21suffq3y2o
 Jsy293A/Tl96X3tOEC1zAtjePl5937xaQe5T7YqMq+J9LqfacED8ihpcn/iDH4hv4ZsL
 Zrqsm/UMmDs39A2gbjIBg94BrIf5YkJTFRQ7cJDM12jFfO+y8kwULxCWcaSu5my6pEKC
 Mdvin/3ef8d1rUfZFI30KPUrJ1fR6HhALcEaWAWZd/dSdAYUKMflH8gwgo64nu8pptm1
 wNnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHjPKuUlnwYE/6DVYLKktc13nZ6ILy+fCsC4HgyMt8AMAZ47R4BY6PzvAWtWLxAkntoRM9YO3PSM/0RzrF1byxiJZB
X-Gm-Message-State: AOJu0YxDFEvX3F6iinJPvpC4YGn7oebbUlUHWdOPc39whfwYxVOxH8wK
 LJ/yL5xPZ0LNytOYQXr/3+9viRSjZtLak3Ac1fdfpzGm9MvryaC/zEcW8w==
X-Google-Smtp-Source: AGHT+IE42gTcBkpBHcnRp20g4R/xIdtzZ/K5/i16MLrpVnFvnzRN/8MHQG/iDETPKD46hKL+vuYoug==
X-Received: by 2002:a05:6a20:d42f:b0:1b1:f7a1:dfa2 with SMTP id
 adf61e73a8af0-1b212e1c9a0mr826142637.45.1716505778109; 
 Thu, 23 May 2024 16:09:38 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/72] target/ppc: Add PPR32 SPR
Date: Fri, 24 May 2024 09:07:05 +1000
Message-ID: <20240523230747.45703-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

PPR32 provides access to the upper half of PPR.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  1 +
 target/ppc/cpu_init.c   | 12 ++++++++++++
 target/ppc/spr_common.h |  2 ++
 target/ppc/translate.c  | 24 ++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2532408be0..141cbefb4c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2120,6 +2120,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_POWER_MMCRS       (0x37E)
 #define SPR_WORT              (0x37F)
 #define SPR_PPR               (0x380)
+#define SPR_PPR32             (0x382)
 #define SPR_750_GQR0          (0x390)
 #define SPR_440_DNV0          (0x390)
 #define SPR_750_GQR1          (0x391)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 927721d49a..6baf7555a7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5606,6 +5606,14 @@ static void register_HEIR64_spr(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power7_common_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_PPR32, "PPR32",
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 0x00000000);
+}
+
 static void register_power8_tce_address_control_sprs(CPUPPCState *env)
 {
     spr_register_kvm(env, SPR_TAR, "TAR",
@@ -6101,6 +6109,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power7_book4_sprs(env);
 
     /* env variables */
@@ -6247,6 +6256,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6414,6 +6424,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6608,6 +6619,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index eb2561f593..9e40b3b608 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -203,6 +203,8 @@ void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cf42dfcc9d..fb05047d95 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1352,6 +1352,30 @@ void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn)
     gen_load_spr(t0, sprn + 16);
     tcg_gen_ext32u_tl(cpu_gpr[gprn], t0);
 }
+
+/* The PPR32 SPR accesses the upper 32-bits of PPR */
+void spr_read_ppr32(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_load_spr(cpu_gpr[gprn], SPR_PPR);
+    tcg_gen_shri_tl(cpu_gpr[gprn], cpu_gpr[gprn], 32);
+    spr_load_dump_spr(SPR_PPR);
+}
+
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+
+    /*
+     * Don't clobber the low 32-bits of the PPR. These are all reserved bits
+     * but TCG does implement them, so it would be surprising to zero them
+     * here. "Priority nops" are similarly careful not to clobber reserved
+     * bits.
+     */
+    gen_load_spr(t0, SPR_PPR);
+    tcg_gen_deposit_tl(t0, t0, cpu_gpr[gprn], 32, 32);
+    gen_store_spr(SPR_PPR, t0);
+    spr_store_dump_spr(SPR_PPR);
+}
 #endif
 
 #define GEN_HANDLER(name, opc1, opc2, opc3, inval, type)                      \
-- 
2.43.0


