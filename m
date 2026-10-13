Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BFBCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3h-0007gK-05; Tue, 13 Oct 2026 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3P-00071n-VI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3L-0007cb-HS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so20751455e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880796; x=1792485596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3izCqRV5UcshDEmb0rQN8l/m/Afo4OAdHcc2f4wlql4=;
 b=qwcM9ef2YTUd8KrkTfwWErxRnWdnxTic+1Mi18/bOOE06GJH6R6l7z76IoozbRN0H7
 qgNQrXJGHahrzRADEgzdeM5b9F8qTIbPx8+YrLNyi0aTcmvwgARAEO3AS/phESvJqsEc
 N7folfpUTLNSQ8kIkO5HVFjwacKrEVBH+Ansqz/xeGZOkiRcX7OVF0Yu2W+byiniTdYM
 F1H70Nz+MfF+I3Yo9XRfj2DL014xhzu41u+8/EqdVIu5lRD9Ex3AIVyiK21HYgxwuTC1
 HaVvTs/uIl6tM1Z48UFgPzu9rjfclFvQv4HVbTDJRzDj10LpN2IWky8sZvjXFHwjmPNa
 fdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880796; x=1792485596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3izCqRV5UcshDEmb0rQN8l/m/Afo4OAdHcc2f4wlql4=;
 b=nJxNTwvDLuLELYPQF+o94Hmnndr00RZlHqLtDGmTANFUdtXqRfenT+Anl3Igvbm7Dg
 /29s5xrQ3YnBA9QZzzP1GV+PRsGWGH2OXVES9g3dsyvM/uqV373qYhCxPObKkVb3DV5V
 Q0AHhJjBXmcHS7xrCMBNRWD8bjn4HMOGji/fnqiVo6x4OIE2TDbM+rswaKkq+QfhoV8U
 U5xLcUffBH6t3u2+p0wC//sfwGgj1yLSEuoxkbI+TpQTYxGPq97DDyVmYZIPiN6JMbbF
 gbqEk/KKmb6AMgIB+cM27WGa0JMLDXBHiIxDs+DkpbjEL23b4tAJ6omFYtavPIf8gQDc
 IeaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy77tqZDciEi3Y2gT7m6h0Gdg99Oew1KVKSKWk0PK3xFeBJytgW2R74w3My8HmbpTa0HPmmdmQjyJr7@nongnu.org
X-Gm-Message-State: AFq9FYL+O40jG/DALoqAVr5NoinzutNmSvTQtlYWe9uSa/UtYwfcQnm+
 PEK4tOBvmX/gHi5MnmLfhnon48Rptv+Pd0eUoILbc3paG4SwnlP0QEAkMjkjRAVz70DALlBQCrs
 QK7ZatQ0=
X-Gm-Gg: AYBFou19XABfCqRVTSDXKmMUseNV0Sgy4RkSBAXtdrA0AsVoqYp5bUNkB6D4gV8bTra
 KNIIA3G2QV5kucVgVpgOFypXTzC3JifG7bcY9PizGttG9ngxW+5Vz9lSKmAoyCBG2ckpf1eqvCX
 +VSjNOmOrMHDVGJsR8YVrmEOjDEjJfL6JVI9Gsm+8t+2is2hdqFvKN7qLFZ1AQp6sN916vfSxWh
 njkxE3PJ5UV08XSYv3CNyjWp8q2/lWB2X0rRwBJlXihM4wS1PkRzxBiJ6tj6STP2hhFuSb4Lpj1
 88lEtEfvsZQHIpRoiCk1oWuKDcdP2S1lvPKrfdt14DpEBGU2mZkp05N9acXJou8adpqVBIkHkQW
 saxerVcmOZdb6f+Ny/y0t9LaCiyT18H3uVLtBiKOD32rMorHdPW0EmHEOZLlLCSaGb2l/uWWjY2
 Q66l3Dj24ZGwf6o6TbZKFJ06uvPPS093RiGr2KWhEUxrxLe0x//cHPNi/m+GMCkWBUXX/hcgJmb
 M3NpIUzw9kyYkQXy+lB9UfJE0SCHsgKVnfwb9I0Ta8sYCc1NcfZsLuNFf2i5dAmhBT+5o+5nyiE
 nzU=
X-Received: by 2002:a05:600c:1909:b0:4a0:159b:d283 with SMTP id
 5b1f17b1804b1-4a18e4d5412mr260780845e9.30.1791880794376; 
 Tue, 13 Oct 2026 01:39:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/86] target/arm: GICv5 cpuif: Implement ICH_PPI_{ENABLE, PEND,
 ACTIVE} regs
Date: Tue, 13 Oct 2026 09:38:21 +0100
Message-ID: <20261013083933.1024405-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Implement the ICH_PPI_ENABLERn_EL2, ICH_PPI_PENDRn_EL2 and
ICH_PPI_ACTIVERn_EL2 registers.  These are the hypervisor interface
to the underlying state of its guest's PPI interrupts.  Unlike the
ICC PPI registers, these don't have set and clear register pairs.

We mark these as ARM_CP_IO and give them a writefn, even though right
now the only thing the writefn does is a raw_write to the underlying
CPU struct field, because eventually hypervisor writes to these
registers will need to trigger recalculation of the highest priority
pending PPI and possible signalling of VIRQ.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  3 ++
 target/arm/tcg/gicv5-cpuif.c | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a93fd362417..62262c594d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -596,6 +596,9 @@ typedef struct CPUArchState {
         GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
 
         uint64_t ich_apr_el2;
+        uint64_t ich_ppi_active[GICV5_NUM_PPIS / 64];
+        uint64_t ich_ppi_pend[GICV5_NUM_PPIS / 64];
+        uint64_t ich_ppi_enable[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 83c9be2b0e6..6dec0ec1ea6 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -463,6 +463,24 @@ static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gic_recalc_ppi_hppi(env);
 }
 
+static void gic_ich_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
+static void gic_ich_ppi_pend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
+static void gic_ich_ppi_active_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 /*
  * ICC_APR_EL1 is banked and reads/writes as the version for the
  * current logical interrupt domain.
@@ -937,6 +955,52 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .accessfn = access_gicv5_ich_reg,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_apr_el2),
     },
+    {   .name = "ICH_PPI_ENABLER0_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 2,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb50,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_enable[0]),
+        .writefn = gic_ich_ppi_enable_write,
+    },
+    {   .name = "ICH_PPI_ENABLER1_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 3,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb58,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_enable[1]),
+        .writefn = gic_ich_ppi_enable_write,
+    },
+    {   .name = "ICH_PPI_PENDR0_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 4,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_pend[0]),
+        .writefn = gic_ich_ppi_pend_write,
+    },
+    {   .name = "ICH_PPI_PENDR1_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 5,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_pend[1]),
+        .writefn = gic_ich_ppi_pend_write,
+    },
+    {   .name = "ICH_PPI_ACTIVER0_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 6,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb30,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_active[0]),
+        .writefn = gic_ich_ppi_active_write,
+    },
+    {   .name = "ICH_PPI_ACTIVER1_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 7,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb38,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_active[1]),
+        .writefn = gic_ich_ppi_active_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


