Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF51AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9ax-0002Qb-4H; Fri, 13 Dec 2024 12:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YG-0000rY-8O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:08 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YB-0001nJ-PM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:07 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso985899f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111241; x=1734716041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xaMbB8kjdY13l6QcFYXNfjRvMJl7ExJkmBH2Rljo9ow=;
 b=Ko8djdGuUGoJcndE+rLSX5JkgffULpJ5AgjNW+X0qhcNpRDq/+ZDyiOGWUKVC9X1yu
 a0BGLveJQmay1zoQHRB/pX0ke5jJF92vbJPMdiKklpq9AOgbun9gQY9OpDB4KIbgFyYk
 4atq2pgW/UZzHS1OIx2ngilQL2PsvH/WFtBch4FPkrg8cceYfHQDpOUpqrGsEWjWN7IR
 UKbycEHZYU8W03QZI9LJNg2je15HG20kz94lvi20eyDb4hfJaZMxJndZE1vONbkcWdWc
 QrS2rfh1UFcus0NB4ykZ5AOz4Rw/u/9/YsucJjAZoPRuL24b8fGyW/yxorJ9FneCsBrI
 K09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111241; x=1734716041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaMbB8kjdY13l6QcFYXNfjRvMJl7ExJkmBH2Rljo9ow=;
 b=aHX5Mi48W//CsztejoBXuG74Ywao9Fb40LdzDCXpnn6+rx5QkVKCFl0jU4Nt1+mBd6
 ZCoomYQ99njneaUAPP/CT0sASJFosCUKiQ+XlJW/HbZB5svUznC90W/Gt87+sVypUVxE
 tz5GHactk1jZGMLVgdVyNHK0Q3V3NyUUZtgCZVwots3yFq2kjT0CrV0VEQQLukHli/T+
 DyKkHpXd5w5ol0F2EGHsHVerwD2uwbGX29P75G4XLU39vzkYGpU9KzS6kgoX5LcSUa4Q
 nwYQmX77iN3AfIImYNd8qbE8BLq/xKdXmvxp3iMpF13eWACtY978fVgW6XH7Nj4pcb6f
 hmyQ==
X-Gm-Message-State: AOJu0Yya1E/yfRsV7pp/cVwhfF0BKb58o6MwJ4VJrUQEGLObn1YfLwuO
 69UXK3cKd4K+I/fCDc6CeVzUjoXT3/5NWwyBN+m/y1uYc79gIbKc9kR3gFPBfc4pfbNpQ2bTTTZ
 p
X-Gm-Gg: ASbGnct1v39V245MNwbjBIDMFupijTtxl+IWygPkRCIeJaXCcBd1mpBj21KzB/Sx/qx
 HEUJ6oZFvyvoCEeQemWRrHG/lB3HGdXxN+jEW/R+HiAkcUYC2a+dXAvXyyzQONeKGbdUIi4kZ9d
 W3Mu9WqXXL0ZdI0KqXg8n0U+ONsbAmX01JvCQ+fXxb+2yew0YQ3An8avnIuvmc0qCYbq90hoTht
 CSCe2S2yGl9XpkgRrbk+tk0P3gQZTa5wMkJFmUvgp3bF1Pf6L4JiQaHRk4n7A==
X-Google-Smtp-Source: AGHT+IFAZJgVaiWT2YCzSpaNfP0EBKqenYdQrd8dBs1opYfXWhoVIvmdwzrFYISYC8KHasFMOVOX7w==
X-Received: by 2002:a5d:6d8f:0:b0:385:e43a:4dd8 with SMTP id
 ffacd0b85a97d-38880af1458mr2824172f8f.4.1734111240716; 
 Fri, 13 Dec 2024 09:34:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 84/85] target/arm: Move RME TLB insns to tlb-insns.c
Date: Fri, 13 Dec 2024 17:32:28 +0000
Message-Id: <20241213173229.3308926-85-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Move the FEAT_RME specific TLB insns across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-10-peter.maydell@linaro.org
---
 target/arm/helper.c        | 38 --------------------------------
 target/arm/tcg/tlb-insns.c | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd9f8650316..910ae62c476 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6525,14 +6525,6 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-static void tlbi_aa64_paall_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush(cs);
-}
-
 static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -6550,14 +6542,6 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
                                      env_archcpu(env)->reset_l0gptsz);
 }
 
-static void tlbi_aa64_paallos_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_all_cpus_synced(cs);
-}
-
 static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
@@ -6569,28 +6553,6 @@ static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "MFAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 0, .opc2 = 5,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mfar_el3) },
-    { .name = "TLBI_PAALL", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 4,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paall_write },
-    { .name = "TLBI_PAALLOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 4,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
-    /*
-     * QEMU does not have a way to invalidate by physical address, thus
-     * invalidating a range of physical addresses is accomplished by
-     * flushing all tlb entries in the outer shareable domain,
-     * just like PAALLOS.
-     */
-    { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 7,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
-    { .name = "TLBI_RPAOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 3,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
     { .name = "DC_CIPAPA", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NOP },
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 51b4756e31e..d20d32624da 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1181,6 +1181,48 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
       .access = PL3_W, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae3is_write },
 };
+
+static void tlbi_aa64_paall_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush(cs);
+}
+
+static void tlbi_aa64_paallos_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_all_cpus_synced(cs);
+}
+
+static const ARMCPRegInfo tlbi_rme_reginfo[] = {
+    { .name = "TLBI_PAALL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paall_write },
+    { .name = "TLBI_PAALLOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    /*
+     * QEMU does not have a way to invalidate by physical address, thus
+     * invalidating a range of physical addresses is accomplished by
+     * flushing all tlb entries in the outer shareable domain,
+     * just like PAALLOS.
+     */
+    { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 7,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    { .name = "TLBI_RPAOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 3,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+};
+
 #endif
 
 void define_tlb_insn_regs(ARMCPU *cpu)
@@ -1219,5 +1261,8 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
+    if (cpu_isar_feature(aa64_rme, cpu)) {
+        define_arm_cp_regs(cpu, tlbi_rme_reginfo);
+    }
 #endif
 }
-- 
2.34.1


