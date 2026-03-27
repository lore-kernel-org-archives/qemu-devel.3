Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE210ED662
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CG-00074Q-Ie; Fri, 27 Mar 2026 07:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C8-0006vh-UM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C6-0008Aw-AD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so1307546f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610257; x=1775215057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxB5i187u8Un3u8aoHnxELkuuEe7fJmA9lYGeZQAHAk=;
 b=le5DwtnMqzYDUxIYbjEV2+OvgDRb/7CvlgritHF3Y9EcjOog66VmxmlfEsd9Qmnh8M
 bd4kat4PApTm+nPVOJZuFhpWoResn5+cXWBvu9hjNgZQxhCuEdZNWsLS0/K1BI54FeAb
 OHQGVL5f3+Pdmls4XwKKcyQVFTRzC+qZ4PvPSNnEnyjtBB944N3GODqEUTwxXpREuaHI
 VNVLLnQgRyQbHDbIV5Q6L4LtoLLeE8WC3vwrgQUNS7rs/cWm8tRZvSibv4wI5rLHMcpO
 ESJTYg0gT2Zx7fHQbADoquZcnnB6FwhA/AxbvLU9tR+JTshKSnzEuwpNuMiws2sKxxiC
 jKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610257; x=1775215057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kxB5i187u8Un3u8aoHnxELkuuEe7fJmA9lYGeZQAHAk=;
 b=oNRGbg+P+W1Wda8AGwxIF8pOe6j07MFjgtTZBKnygaGqosGOsTMjJ/csAzysP3H6wq
 M9F+o6XGh9gtxR5uHCrGwWSEAtppJkGYcA6jkhnrA9M5xVVn6V0wmcqJF7maMQGDmOE6
 NUgHuTjS4sdf0ffl61hXmAUiqfH/bZ7pmoK3W17QEhN3iDlz4rOLjzeOWbhtYnAdelzf
 8uvlPRgVsq2SEwoHscWPMF630tYNiNBJpy4HleCIzESFMh2DIaKQjSmMYCCyxsySNW+M
 IKbRBIqCIXaJXtH8XIZZ4xT1nkIu3a50bgAGRMHaZ0GxqCkvd+hyE6cyFmQsWaPP7do2
 H2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4GDjRvWPq8gancRcwtxP2bVNQr6JWplgkLuLVKakhYKsRcr448x0afOwm47/jf22koZdclKUicaaz@nongnu.org
X-Gm-Message-State: AOJu0YwBteSm0deDAtS9wgYe6S3O9+/JiVHcVGFdnJdweqVPzSX9Evsu
 PxWOretrBgNWTG+n1i+cOkrbooXmk/zHvZgEJBxEbYT06k+9rsuDrsy51twENfPG3zJFFUwP3YV
 asCX+ScA=
X-Gm-Gg: ATEYQzx4HlzqVwTAPlAchjSrxx7YsySJfXM+QTNG4ey6Vep1rcqp/zwZd7ejqGttO0B
 xSHowNFtL8YIWH1XGu/owS3ScguVirNZs01G8qzYWZwB3S+lRPSnLZDEAvA9RQJXBsrAaMlqGse
 sfm803bH5dBn7qXeRLJA7OWYsAJqP2SH7a3bw45j3J5PSNP8XkaMfJ1W0Yv6Ulz1lK62V9QRD/2
 tIxrF0E+B2uvGHpsX1Q0O58SzpN8evKmFyy72sqlDxO6hZAbta5jp3E2KMgTpTBtz+ecQh0nMAv
 QMXm+HTsdMG1vDeVzUq/TcDOWeswxcJcXqu4ryC15h4lbIlCem/LP8H+Z3hsBUXddUFYG8tuVb2
 IXNmM+ilfmgDIJMwNSwZXuHCR2x10flHa6hbgg4bMp1JNedLF9JWE28NMUA51qOgRmPLNcVGHYE
 AnfWIQEbqtuNLkhCqg+2u4SHVCLIgqpYDrLm6fXRJZNsCFBilB1WtZvrji6XJGYyWljwK2lUDhK
 YTx9JftKE0IAfJPPZjMLZzRv6HIYZI=
X-Received: by 2002:a05:6000:4013:b0:43b:60f7:2283 with SMTP id
 ffacd0b85a97d-43b9e9f6ae1mr2931812f8f.22.1774610256701; 
 Fri, 27 Mar 2026 04:17:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 36/65] target/arm: GICv5 cpuif: Implement GICv5 PPI active
 set/clear registers
Date: Fri, 27 Mar 2026 11:16:31 +0000
Message-ID: <20260327111700.795099-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the GICv5 PPI state and control lives in the CPU interface; this
is different from the GICv3 where this was all in the redistributor.

Implement the access system registers for the PPI active state; this
is a pair of registers, one of which has "write 1 to clear" behaviour
and the other of which has "write 1 to set".  In both cases, reads
return the current state.

We start here by implementing the accessors for the underlying state;
we don't yet attempt to do anything (e.g.  recalculating the highest
priority pending PPI) when the state changes.  That will come in
subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  5 +++++
 target/arm/tcg/gicv5-cpuif.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a32c5f3ab1..dd4dc12feb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -257,6 +257,9 @@ typedef enum ARMFPStatusFlavour {
 } ARMFPStatusFlavour;
 #define FPST_COUNT  10
 
+/* Architecturally there are 128 PPIs in a GICv5 */
+#define GICV5_NUM_PPIS 128
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -600,6 +603,8 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
+        uint64_t ppi_active[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 497c09474b..6672cda37f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -175,6 +175,20 @@ static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_handling(gic, id, hm, domain, type, virtual);
 }
 
+static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old & ~value);
+}
+
+static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old | value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -254,6 +268,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
          */
         .resetfn = arm_cp_reset_ignore,
     },
+    {   .name = "ICC_PPI_CACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_CACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 2,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_sactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 3,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_sactive_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


