Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45327CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3e-0007aP-A6; Tue, 13 Oct 2026 04:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3P-00071j-VZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3K-0007cL-Fs
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4956869750eso20242305e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880793; x=1792485593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qpgEaqwbI8cXhwzqqc5V6TxLN3Im1mcvPlwe4PGvMA8=;
 b=Mut4tNWg+ihZb04jsCn9gVV87CGjj81ZKQtFhZrBQcCPAVUOidAM3xfzySAB1nwHUC
 RBHO0daEUeB0aWlR2yxXv1I/Ra2R305/HY1njSTarJBG9s+9uCHtPttXKpeCrO9Wv9nQ
 dzmYRiRPmuvY16FQWv4bSc/CwUG19smi0JxkiXENFiyDEOtNIRpsW5w36djKRwlirW2b
 DHeLD5WrQaxhbleco/8boDazsv9zeXMy9+oTbpeuR1X96RVi+tjHyHV53HNyy8p8608D
 49UZY+t+01y0nX2XQh4CamLznWGQtq1GUqa3OtORpIilIMvX57Vum8H97IVDEQbJOzCd
 JAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880793; x=1792485593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qpgEaqwbI8cXhwzqqc5V6TxLN3Im1mcvPlwe4PGvMA8=;
 b=CRtKWbmDzObHny4mQkneENniwuwvs0eXvRppJY3lNQlQmIJXTJI56CL8u2skreiedP
 gOw1xx/VCdBxyyP/n5SapAWdvToRGLoPoGxUXGTkVZQ7UXCeGJep+VDZLX+XzISU9JRQ
 uGu+xgG6M6hS8Mipwt2j46dS0VkRk9epnPQsJbwos3VibXv0pL3a896ID0KNJVKTs6P+
 0qgfrhXKDbDNUHGiD2eGObjNxDFm5wPr93Xram9Qqa7ArJxC3ljR6pmZfFrMkh25gQF+
 zK8MJmVMdb1/lr5YCwNcfesYKz1gSoNgr+cQ1Uv/ll0bL1etb5MxPMJEYBAtscN6wyVN
 +0CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgA82xbGUYUikoxyHk/6NrOFY3hlmjxY5LkXeCsVQHELa8YTPbqSgJm5P2t1bAGVuC8nGWS+6t5cH6@nongnu.org
X-Gm-Message-State: AFq9FYIT24vvNPOg8wQqeZNV/Nckhjr+yhNq0smiKeEbyllf+W7yhRyT
 Npx3YQIDZO/LVwoO54EB5gJrXEjqMjm75appI501TZUn6AkYI6PptxcNxGWJDpb/YdppopRNdVl
 xrfnrHas=
X-Gm-Gg: AYBFou0hrVZZjhstycDPK1doSvyFxiBHIbaCIb4DtCV4FQQbydA4CkCxgE7kzyX5bXk
 cd7FYuKPlgc6cwPZ8BFzOCwSnG9pwcB8y5/AORVqdhah4akqryocjxZZ8MjZNMji3p1iOUKYc5P
 pSG4Q0caZK+dyC9XCRp73BWWQHTT5p07X/cRkRAZ5zkPfP33ssrPm3t/mr7p4WrIDZl6RogZA6a
 WGwExrVEsWLf2cLq5BtiK3OBn5C6j3OvleYcFS70utLAPWiApSg54DhmzV/PDu7rXnOq5qc6THJ
 h9+rnISn9+Z90si5cBfkrJE8+AdUhLysPIAIrutvBULsWGpw+ebcKa+XjZ1AjGJ/vsnuWjdYJpr
 YBMVoEz7sebXxM3GktQDQO2WYWl7tBpHKc6b+hm0ZUMqjUVMzfCXuorTpx6XXzU8loGG8rQe3gI
 jyQXQqSzkp5in8CTubVizNR5/YZ7Ro0ZP2ETBEF3DQEpBhKUUmQX2BurpsYPQBBPeVKV5isv7+J
 KaTzgE0jyMbNkjFrYp1TEHLgYRv8nGAaus6PeL2dfqqTSbXhe53NqefMzwmXIECUwvKtFez5F6a
 HcXjCTJtC4PNCQ==
X-Received: by 2002:a05:600c:3b1a:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4a18e4b91f8mr200321455e9.20.1791880793162; 
 Tue, 13 Oct 2026 01:39:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/86] target/arm: GICv5 cpuif: Implement ICH_APR_EL2
Date: Tue, 13 Oct 2026 09:38:20 +0100
Message-ID: <20261013083933.1024405-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the ICH_APR_EL2 register.  This is part of the hypervisor
control register interface, and is the hypervisor-facing access to
the state which holds the guest's its active priority register.

The only slightly non-straightforward part of this is that because
the GICv5 allows a hypervisor to give its guest a GICv3-compatible
virtual CPU interface, this register has to UNDEF to the inner guest
when legacy-vcpu operation is enabled.  We don't implement
GCIE_LEGACY in QEMU yet, but since we expect to do so in future, the
handling for this is implemented here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 82c13186b68..a93fd362417 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -594,6 +594,8 @@ typedef struct CPUArchState {
 
         /* Cached highest-priority pending PPI for each domain */
         GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
+
+        uint64_t ich_apr_el2;
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 0b1033c1ef0..83c9be2b0e6 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -90,6 +90,15 @@ static GICv5Common *gicv5_get_gic(CPUARMState *env)
     return env->gicv5.gicv5state;
 }
 
+/*
+ * Return true if GIC virtual interface legacy operation is enabled.
+ * We don't currently implement FEAT_GCIE_LEGACY.
+ */
+static bool gicv5_legacy_enabled(CPUARMState *env)
+{
+    return false;
+}
+
 static GICv5Domain gicv5_logical_domain(CPUARMState *env)
 {
     /*
@@ -696,6 +705,34 @@ static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static CPAccessResult access_gicv5_ich_reg(CPUARMState *env,
+                                           const ARMCPRegInfo *ri,
+                                           bool isread)
+{
+    /*
+     * accessfn for GICv5 ICH regs. The NV behaviour here is a little
+     * different from usual because of the optional legacy GIC feature.
+     *
+     * At EL1, if GCIE_LEGACY is disabled or not implemented, these
+     * behave like normal EL2 registers, which is that they redirect
+     * to memory if NV2 is enabled and trap to EL2 if not.  If legacy
+     * operation is enabled, these registers must UNDEF to EL1
+     * (because from the inner guest's point of view it has a GICv3
+     * and this sysreg doesn't exist).
+     *
+     * The UNDEF at EL1 when NV==0 is handled already because of the
+     * .access = PL2_RW setting on the cpreg.
+     */
+    if (arm_current_el(env) == 1 && gicv5_legacy_enabled(env)) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    /*
+     * continue to either redirect-to-memory, trap-to-EL2 or (if
+     * current EL is 2 or 3) access the register
+     */
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -893,6 +930,13 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_pcr_el1_write,
         .resetfn = gic_icc_pcr_el1_reset,
     },
+    {   .name = "ICH_APR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 4,
+        .access = PL2_RW, .type = ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb00,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_apr_el2),
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


